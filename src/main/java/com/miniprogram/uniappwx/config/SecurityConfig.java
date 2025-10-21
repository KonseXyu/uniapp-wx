package com.miniprogram.uniappwx.config;

import com.miniprogram.uniappwx.filter.JwtAuthenticationFilter;
import jakarta.annotation.Resource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * Spring Security 配置类
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

	// 注入自定义的 JWT 过滤器
	@Resource
	private JwtAuthenticationFilter jwtAuthenticationFilter;

	// 定义无需认证的白名单 URL
	private static final String[] WHITE_LIST_URLS = {
			"/api/auth/wx-login", // 微信登录接口必须放行
			"/api/auth/phone-login",
			// 可以添加 Swagger/API 文档路径等
			// "/v3/api-docs/**",
			// "/swagger-ui/**",
	};

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http
				// 1. 禁用 CSRF（跨站请求伪造）保护，因为我们使用无状态的 Token
				.csrf(AbstractHttpConfigurer::disable)

				// 2. 禁用默认的表单登录和 HTTP Basic 认证，防止弹出登录框
				.formLogin(AbstractHttpConfigurer::disable)
				.httpBasic(AbstractHttpConfigurer::disable)

				// 3. 配置 Session 管理为无状态，因为使用 JWT
				.sessionManagement(session ->
						session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
				)

				// 4. 配置授权规则
				.authorizeHttpRequests(authorize -> authorize
						// 允许白名单中的请求可以直接访问
						.requestMatchers(WHITE_LIST_URLS).permitAll()
						// 所有其他请求都需要认证
						.anyRequest().authenticated()
				)

				// 5. 【关键】将自定义的 JWT 过滤器添加到 Spring Security 过滤器链中
				// 确保它在 UsernamePasswordAuthenticationFilter 之前执行
				.addFilterBefore(
						jwtAuthenticationFilter,
						UsernamePasswordAuthenticationFilter.class
				)

		// 6. 处理未认证和无权限访问的异常（可选，但推荐）
		// 可以自定义 AuthenticationEntryPoint 和 AccessDeniedHandler
		// 这里为了简化，先使用 Spring Security 的默认处理，返回 401
		;

		return http.build();
	}
}