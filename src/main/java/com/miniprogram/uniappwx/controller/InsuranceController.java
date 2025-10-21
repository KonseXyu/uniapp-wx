package com.miniprogram.uniappwx.controller;

import com.miniprogram.uniappwx.common.Result;
import com.miniprogram.uniappwx.dto.*;
import com.miniprogram.uniappwx.entity.*;
import com.miniprogram.uniappwx.mapper.*;
import com.miniprogram.uniappwx.service.InsuranceMatchService;
import com.miniprogram.uniappwx.vo.*;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

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
	 * 匹配保险产品
	 */
	@GetMapping("/match/{companyId}")
	public Result<MatchResultVO> matchInsurance(@PathVariable Long companyId) {
		try {
			MatchResultVO vo = matchService.matchInsurance(companyId);
			return Result.success(vo);
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
}