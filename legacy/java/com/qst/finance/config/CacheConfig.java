package com.qst.finance.config;

import org.springframework.beans.factory.ObjectProvider;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.StringRedisTemplate;

import com.qst.finance.cache.CacheService;
import com.qst.finance.cache.CacheServiceImpl;

@Configuration
public class CacheConfig {

    @Bean
    public CacheService cacheService(AppProperties properties, ObjectProvider<StringRedisTemplate> redisProvider) {
        return new CacheServiceImpl(properties, redisProvider.getIfAvailable());
    }
}
