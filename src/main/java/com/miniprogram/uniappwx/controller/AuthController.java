package com.miniprogram.uniappwx.controller;


import com.miniprogram.uniappwx.common.Result;
import com.miniprogram.uniappwx.dto.*;
import com.miniprogram.uniappwx.service.*;
import com.miniprogram.uniappwx.vo.*;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 认证控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/auth")
public class AuthController {

	@Resource
	private AuthService authService;

	/**
	 * 微信登录
	 */
	@PostMapping("/wx-login")
	public Result<LoginVO> wxLogin(@Validated @RequestBody WxLoginDTO dto) {
		try {
			LoginVO vo = authService.wxLogin(dto);
			return Result.success(vo);
		} catch (Exception e) {
			log.error("微信登录失败", e);
			return Result.error(e.getMessage());
		}
	}
	/**
	 * 【新增】微信手机号授权登录/绑定
	 */
	@PostMapping("/phone-login")
	public Result<LoginVO> wxPhoneLogin(@Validated @RequestBody PhoneLoginDTO dto) {
		try {
			LoginVO vo = authService.wxPhoneLogin(dto);
			return Result.success(vo);
		} catch (Exception e) {
			log.error("微信手机号登录失败", e);
			return Result.error(e.getMessage());
		}
	}
}
