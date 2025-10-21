package com.miniprogram.uniappwx.config;

import com.miniprogram.uniappwx.filter.JwtInterceptor;
import jakarta.annotation.Resource;
import org.springframework.context.annotation.Configuration;

import org.springframework.web.servlet.config.annotation.*;


@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	@Resource
	private JwtInterceptor jwtInterceptor;

	/**
	 * 添加拦截器
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(jwtInterceptor)
				.addPathPatterns("/api/**")
				.excludePathPatterns(
						"/api/auth/**",  // 登录接口不拦截
						"/error"
				);
	}

	/**
	 * 跨域配置
	 */
	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**")
				.allowedOriginPatterns("*")
				.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
				.allowedHeaders("*")
				.allowCredentials(true)
				.maxAge(3600);
	}
}

