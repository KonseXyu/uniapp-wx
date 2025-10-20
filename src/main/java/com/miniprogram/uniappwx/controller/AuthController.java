package com.miniprogram.uniappwx.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.miniprogram.uniappwx.dto.Result;
import com.miniprogram.uniappwx.entity.User;
import com.miniprogram.uniappwx.mapper.UserMapper;
import com.miniprogram.uniappwx.security.CustomUserDetails;
import com.miniprogram.uniappwx.security.JwtTokenProvider;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

	private final AuthenticationManager authenticationManager;
	private final UserMapper userMapper;
	private final PasswordEncoder passwordEncoder;
	private final JwtTokenProvider tokenProvider;

	@Data
	public static class LoginRequest {
		private String username;
		private String password;
	}

	@Data
	public static class RegisterRequest {
		private String username;
		private String password;
		private String nickname;
		private String phone;
	}

	@Data
	public static class AuthResponse {
		private String token;
		private String type = "Bearer";
		private Long userId;
		private String username;
		private String role;

		public AuthResponse(String token, Long userId, String username, String role) {
			this.token = token;
			this.userId = userId;
			this.username = username;
			this.role = role;
		}
	}

	/**
	 * 登录
	 */
	@PostMapping("/login")
	public Result<AuthResponse> login(@RequestBody LoginRequest request) {
		Authentication authentication = authenticationManager.authenticate(
				new UsernamePasswordAuthenticationToken(
						request.getUsername(),
						request.getPassword()
				)
		);

		SecurityContextHolder.getContext().setAuthentication(authentication);
		String token = tokenProvider.generateToken(authentication);

		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();

		AuthResponse response = new AuthResponse(
				token,
				userDetails.getId(),
				userDetails.getUsername(),
				userDetails.getRole()
		);

		return Result.success(response);
	}

	/**
	 * 注册
	 */
	@PostMapping("/register")
	public Result<Void> register(@RequestBody RegisterRequest request) {
		// 检查用户名是否存在
		LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
		wrapper.eq(User::getUsername, request.getUsername());
		User existUser = userMapper.selectOne(wrapper);

		if (existUser != null) {
			return Result.error("用户名已存在");
		}

		// 创建新用户
		User user = new User();
		user.setUsername(request.getUsername());
		user.setPassword(passwordEncoder.encode(request.getPassword()));
		user.setNickname(request.getNickname());
		user.setPhone(request.getPhone());
		user.setRole("USER");
		user.setStatus(1);
		user.setCreateTime(LocalDateTime.now());
		user.setUpdateTime(LocalDateTime.now());

		userMapper.insert(user);
		return Result.success(null);
	}

	/**
	 * 获取当前用户信息
	 */
	@GetMapping("/me")
	public Result<Map<String, Object>> getCurrentUser(
			@AuthenticationPrincipal UserDetails userDetails) {
		CustomUserDetails customUserDetails = (CustomUserDetails) userDetails;

		Map<String, Object> userInfo = new HashMap<>();
		userInfo.put("id", customUserDetails.getId());
		userInfo.put("username", customUserDetails.getUsername());
		userInfo.put("role", customUserDetails.getRole());

		return Result.success(userInfo);
	}
}