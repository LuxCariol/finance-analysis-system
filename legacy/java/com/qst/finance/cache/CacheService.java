package com.qst.finance.cache;

/**
 * 缓存服务: 优先使用 Redis，Redis 不可用时自动降级为 JVM 内存缓存，
 * 保证系统在未部署 Redis 的环境下同样可以运行(对应项目技术架构中的 Redis 三方缓存)。
 */
public interface CacheService {

    void set(String key, Object value);

    void set(String key, Object value, long expireSeconds);

    Object get(String key);

    <T> T get(String key, Class<T> type);

    void delete(String key);

    void deleteByPrefix(String prefix);

    /** 当前实际生效的缓存类型: redis / memory */
    String currentType();
}
