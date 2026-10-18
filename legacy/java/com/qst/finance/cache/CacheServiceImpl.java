package com.qst.finance.cache;

import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.StringRedisTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.qst.finance.config.AppProperties;

/**
 * 缓存实现: Redis + JVM 内存双通道，Redis 异常时自动降级
 */
public class CacheServiceImpl implements CacheService {

    private static final Logger log = LoggerFactory.getLogger(CacheServiceImpl.class);

    private final AppProperties properties;
    private final StringRedisTemplate redisTemplate;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final Map<String, Entry> memoryStore = new ConcurrentHashMap<String, Entry>();
    private volatile Boolean redisAvailable;
    private volatile boolean degraded;

    public CacheServiceImpl(AppProperties properties, StringRedisTemplate redisTemplate) {
        this.properties = properties;
        this.redisTemplate = redisTemplate;
    }

    @Override
    public void set(String key, Object value) {
        set(key, value, properties.getCacheExpireSeconds());
    }

    @Override
    public void set(String key, Object value, long expireSeconds) {
        if (useRedis()) {
            try {
                redisTemplate.opsForValue().set(key, objectMapper.writeValueAsString(value), expireSeconds,
                        java.util.concurrent.TimeUnit.SECONDS);
                return;
            } catch (Exception e) {
                degrade("写入缓存失败", e);
            }
        }
        memoryStore.put(key, new Entry(value, expireSeconds));
    }

    @Override
    public Object get(String key) {
        if (useRedis()) {
            try {
                String value = redisTemplate.opsForValue().get(key);
                return value == null ? null : objectMapper.readValue(value, Object.class);
            } catch (Exception e) {
                degrade("读取缓存失败", e);
            }
        }
        Entry entry = memoryStore.get(key);
        if (entry == null) {
            return null;
        }
        if (entry.expireAt > 0 && entry.expireAt < System.currentTimeMillis()) {
            memoryStore.remove(key);
            return null;
        }
        return entry.value;
    }

    @Override
    @SuppressWarnings("unchecked")
    public <T> T get(String key, Class<T> type) {
        Object value = get(key);
        if (value == null) {
            return null;
        }
        if (type.isInstance(value)) {
            return (T) value;
        }
        try {
            return objectMapper.convertValue(value, type);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public void delete(String key) {
        if (useRedis()) {
            try {
                redisTemplate.delete(key);
            } catch (Exception e) {
                degrade("删除缓存失败", e);
            }
        }
        memoryStore.remove(key);
    }

    @Override
    public void deleteByPrefix(String prefix) {
        if (useRedis()) {
            try {
                java.util.Set<String> keys = redisTemplate.keys(prefix + "*");
                if (keys != null && !keys.isEmpty()) {
                    redisTemplate.delete(keys);
                }
            } catch (Exception e) {
                degrade("按前缀删除缓存失败", e);
            }
        }
        Iterator<String> it = memoryStore.keySet().iterator();
        while (it.hasNext()) {
            if (it.next().startsWith(prefix)) {
                it.remove();
            }
        }
    }

    @Override
    public String currentType() {
        return useRedis() ? "redis" : "memory";
    }

    private boolean useRedis() {
        if ("memory".equalsIgnoreCase(properties.getCacheType()) || redisTemplate == null || degraded) {
            return false;
        }
        if (redisAvailable == null) {
            synchronized (this) {
                if (redisAvailable == null) {
                    try {
                        redisTemplate.execute(new RedisCallback<String>() {
                            @Override
                            public String doInRedis(RedisConnection connection) {
                                return connection.ping();
                            }
                        });
                        redisAvailable = true;
                        log.info("Redis 缓存已启用");
                    } catch (Exception e) {
                        redisAvailable = false;
                        log.warn("Redis 不可用，已自动降级为 JVM 内存缓存: {}", e.getMessage());
                    }
                }
            }
        }
        return Boolean.TRUE.equals(redisAvailable);
    }

    private void degrade(String message, Exception e) {
        log.warn("{}，后续请求将使用内存缓存: {}", message, e.getMessage());
        degraded = true;
        redisAvailable = false;
    }

    private static class Entry {
        private final Object value;
        private final long expireAt;

        Entry(Object value, long expireSeconds) {
            this.value = value;
            this.expireAt = expireSeconds <= 0 ? 0 : System.currentTimeMillis() + expireSeconds * 1000L;
        }
    }
}
