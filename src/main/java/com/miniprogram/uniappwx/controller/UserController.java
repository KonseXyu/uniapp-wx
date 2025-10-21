package com.miniprogram.uniappwx.controller;


import com.miniprogram.uniappwx.common.Result;
import com.miniprogram.uniappwx.service.AuthService;
import com.miniprogram.uniappwx.vo.UserInfoVO;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 用户控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/user")
public class UserController {

	@Resource
	private AuthService authService;

	/**
	 * 获取用户信息
	 */
	@GetMapping("/info")
	public Result<UserInfoVO> getUserInfo(@RequestAttribute("userId") Long userId) {
		try {
			UserInfoVO vo = authService.getUserInfo(userId);
			return Result.success(vo);
		} catch (Exception e) {
			log.error("获取用户信息失败", e);
			return Result.error(e.getMessage());
		}
	}
}
