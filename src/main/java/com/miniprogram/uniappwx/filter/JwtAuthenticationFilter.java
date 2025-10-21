package com.miniprogram.uniappwx.filter;

import cn.hutool.core.util.StrUtil;
import com.miniprogram.uniappwx.utils.JwtUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import jakarta.annotation.Resource;

import java.io.IOException;

/**
 * JWT 认证过滤器，用于集成 Spring Security
 */
@Slf4j
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

	@Resource
	private JwtUtil jwtUtil;

	@Override
	protected void doFilterInternal(HttpServletRequest request,
																	HttpServletResponse response,
																	FilterChain filterChain)
			throws ServletException, IOException {

		// 1. 获取Token
		String token = request.getHeader("Authorization");

		if (StrUtil.isBlank(token) || !token.startsWith("Bearer ")) {
			// 没有Token或格式不正确，直接放行到下一个过滤器 (由Spring Security处理未认证请求)
			filterChain.doFilter(request, response);
			return;
		}

		// 2. 去除Bearer前缀
		token = token.substring(7);

		try {
			// 3. 验证Token是否有效
			if (jwtUtil.validateToken(token)) {

				// 4. 从Token中获取用户ID
				Long userId = jwtUtil.getUserIdFromToken(token);

				// 5. 【关键】构建认证对象并设置到 SecurityContext 中
				// 这里的用户ID是 Principal，Credentials 为 null，Authority 权限为空
				UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
						userId,
						null,
						null
				);

				// 设置认证详情，包括 IP 地址和 Session ID
				authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

				// 将认证信息放入安全上下文，Spring Security 认为用户已认证
				SecurityContextHolder.getContext().setAuthentication(authentication);

			} else {
				// Token 无效，不做处理，让后续过滤器或处理器返回 401
				log.warn("JWT Token 无效: {}", token);
			}

		} catch (Exception e) {
			// Token 解析或验证过程中发生异常（如过期、签名错误）
			log.error("JWT 认证失败：{}", e.getMessage());
			// 通常不做处理，让后续 Spring Security 逻辑或自定义的EntryPoint处理 401
		}

		// 6. 继续处理请求
		filterChain.doFilter(request, response);
	}
}