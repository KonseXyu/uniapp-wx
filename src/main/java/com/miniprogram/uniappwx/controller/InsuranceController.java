package com.miniprogram.uniappwx.controller;

import com.miniprogram.uniappwx.common.Result;
import com.miniprogram.uniappwx.dto.*;
import com.miniprogram.uniappwx.entity.CompanyDetail;
import com.miniprogram.uniappwx.service.InsuranceMatchService;
import com.miniprogram.uniappwx.vo.*;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 保险匹配控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/insurance")
public class InsuranceController {

	@Resource
	private InsuranceMatchService matchService;

	/**
	 * 浏览所有保险产品
	 */
	@GetMapping("/list")
	public Result<List<InsuranceListVO>> listAllInsurance() {
		try {
			List<InsuranceListVO> list = matchService.listAllInsurance();
			return Result.success(list);
		} catch (Exception e) {
			log.error("获取保险列表失败", e);
			return Result.error(e.getMessage());
		}
	}

	/**
	 * 根据筛选条件匹配保险产品（不保存记录）
	 */
	@PostMapping("/match")
	public Result<List<InsuranceMatchVO>> matchInsuranceByFilter(
			@Validated @RequestBody CompanyDetail filter) {
		try {
			List<InsuranceMatchVO> list = matchService.matchInsuranceByFilter(filter);
			return Result.success(list);
		} catch (Exception e) {
			log.error("匹配保险失败", e);
			return Result.error(e.getMessage());
		}
	}

	/**
	 * 获取保险产品详情
	 */
	@GetMapping("/detail/{id}")
	public Result<InsuranceDetailVO> getInsuranceDetail(@PathVariable Long id) {
		try {
			InsuranceDetailVO vo = matchService.getInsuranceDetail(id);
			return Result.success(vo);
		} catch (Exception e) {
			log.error("获取保险详情失败", e);
			return Result.error(e.getMessage());
		}
	}

	/**
	 * 收藏保险产品
	 */
	@PostMapping("/favorite/{insuranceId}")
	public Result<String> addFavorite(
			@RequestAttribute("userId") Long userId,
			@PathVariable Long insuranceId) {
		try {
			matchService.addFavorite(userId, insuranceId);
			return Result.success("收藏成功");
		} catch (Exception e) {
			log.error("收藏失败", e);
			return Result.error(e.getMessage());
		}
	}

	/**
	 * 取消收藏
	 */
	@DeleteMapping("/favorite/{insuranceId}")
	public Result<String> removeFavorite(
			@RequestAttribute("userId") Long userId,
			@PathVariable Long insuranceId) {
		try {
			matchService.removeFavorite(userId, insuranceId);
			return Result.success("取消收藏成功");
		} catch (Exception e) {
			log.error("取消收藏失败", e);
			return Result.error(e.getMessage());
		}
	}

	/**
	 * 获取我的收藏列表
	 */
	@GetMapping("/favorites")
	public Result<List<InsuranceListVO>> getMyFavorites(
			@RequestAttribute("userId") Long userId) {
		try {
			List<InsuranceListVO> list = matchService.getMyFavorites(userId);
			return Result.success(list);
		} catch (Exception e) {
			log.error("获取收藏列表失败", e);
			return Result.error(e.getMessage());
		}
	}

	/**
	 * 检查是否已收藏
	 */
	@GetMapping("/favorite/check/{insuranceId}")
	public Result<Boolean> checkFavorite(
			@RequestAttribute("userId") Long userId,
			@PathVariable Long insuranceId) {
		try {
			boolean isFavorited = matchService.checkFavorite(userId, insuranceId);
			return Result.success(isFavorited);
		} catch (Exception e) {
			log.error("检查收藏状态失败", e);
			return Result.error(e.getMessage());
		}
	}
}