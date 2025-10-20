package com.miniprogram.uniappwx.config;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * MyBatis-Plus 配置
 * 版本: 3.5.14
 */
@Configuration
@MapperScan("com.miniprogram.uniappwx.mapper")
public class MybatisPlusConfig {

	/**
	 * 分页插件配置
	 * 注意: 需要 mybatis-plus-jsqlparser 依赖
	 */
	@Bean
	public MybatisPlusInterceptor mybatisPlusInterceptor() {
		MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();

		// 分页插件
		PaginationInnerInterceptor paginationInterceptor = new PaginationInnerInterceptor();
		paginationInterceptor.setDbType(DbType.MYSQL);
		paginationInterceptor.setOverflow(false);
		paginationInterceptor.setMaxLimit(500L);

		interceptor.addInnerInterceptor(paginationInterceptor);

		return interceptor;
	}
}