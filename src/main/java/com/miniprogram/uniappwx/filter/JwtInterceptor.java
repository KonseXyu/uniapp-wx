package com.miniprogram.uniappwx.filter;


import cn.hutool.core.util.StrUtil;
import com.miniprogram.uniappwx.utils.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import jakarta.annotation.Resource;

/**
 * JWT认证拦截器
 */
@Slf4j
@Component
public class JwtInterceptor implements HandlerInterceptor {

	@Resource
	private JwtUtil jwtUtil;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		// 跨域OPTIONS请求直接放行
		if ("OPTIONS".equals(request.getMethod())) {
			return true;
		}

		// 获取Token
		String token = request.getHeader("Authorization");
		if (StrUtil.isBlank(token)) {
			response.setStatus(401);
			return false;
		}

		// 去除Bearer前缀
		if (token.startsWith("Bearer ")) {
			token = token.substring(7);
		}

		// 验证Token
		try {
			if (!jwtUtil.validateToken(token)) {
				response.setStatus(401);
				return false;
			}

			// 从Token中获取用户ID并设置到请求属性中
			Long userId = jwtUtil.getUserIdFromToken(token);
			request.setAttribute("userId", userId);

			return true;
		} catch (Exception e) {
			log.error("Token验证失败", e);
			response.setStatus(401);
			return false;
		}
	}
}
