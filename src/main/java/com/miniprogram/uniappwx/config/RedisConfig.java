//package com.miniprogram.uniappwx.config;
//
//import com.alibaba.fastjson.support.spring.FastJsonRedisSerializer;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.data.redis.connection.RedisConnectionFactory;
//import org.springframework.data.redis.core.RedisTemplate;
//import org.springframework.data.redis.serializer.StringRedisSerializer;
//
///**
// * RedisConfig配置类
// */
//@Configuration
//public class RedisConfig {
//
//	@Bean
//	public RedisTemplate<Object, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
//		RedisTemplate<Object, Object> template = new RedisTemplate<>();
//		template.setConnectionFactory(connectionFactory);
//
//		FastJsonRedisSerializer<Object> serializer = new FastJsonRedisSerializer<>(Object.class);
//
//		// 使用StringRedisSerializer来序列化和反序列化redis的key值
//		template.setKeySerializer(new StringRedisSerializer());
//		// 值采用json序列化
//		template.setValueSerializer(serializer);
//
//		// Hash的key也采用StringRedisSerializer的序列化方式
//		template.setHashKeySerializer(new StringRedisSerializer());
//		// Hash的value序列化方式采用JSON序列化
//		template.setHashValueSerializer(serializer);
//
//		// 设置hash key 和value序列化模式
//		template.afterPropertiesSet();
//		return template;
//	}
//}
