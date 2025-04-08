package com.sky.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

@Configuration
@Slf4j
public class RedisConfiguration {

    @Bean
    public RedisTemplate redisTemplate(RedisConnectionFactory redisConnectionFactory) {
        log.info("开始配置Redis模板对象...");
        RedisTemplate redisTemplate = new RedisTemplate();
        //设置redis连接工厂对象
        redisTemplate.setConnectionFactory(redisConnectionFactory);
        log.info("RedisTemplate已配置");
        //设置序列化器
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        //redisTemplate.setValueSerializer(new GenericJackson2JsonRedisSerializer() );
        return redisTemplate;
    }
}
