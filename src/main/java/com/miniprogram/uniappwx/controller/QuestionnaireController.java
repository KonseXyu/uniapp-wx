package com.miniprogram.uniappwx.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.miniprogram.uniappwx.dto.*;
import com.miniprogram.uniappwx.security.CustomUserDetails;
import com.miniprogram.uniappwx.service.QuestionnaireService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/questionnaire")
@RequiredArgsConstructor
public class QuestionnaireController {

	private final QuestionnaireService questionnaireService;

	/**
	 * 创建问卷
	 */
	@PostMapping
	@PreAuthorize("hasRole('ADMIN')")
	public Result<QuestionnaireDTO> create(
			@RequestBody QuestionnaireDTO dto,
			@AuthenticationPrincipal UserDetails userDetails) {
		Long userId = ((CustomUserDetails) userDetails).getId();
		QuestionnaireDTO result = questionnaireService.createQuestionnaire(dto, userId);
		return Result.success(result);
	}

	/**
	 * 更新问卷
	 */
	@PutMapping("/{id}")
	@PreAuthorize("hasRole('ADMIN')")
	public Result<QuestionnaireDTO> update(
			@PathVariable Long id,
			@RequestBody QuestionnaireDTO dto) {
		QuestionnaireDTO result = questionnaireService.updateQuestionnaire(id, dto);
		return Result.success(result);
	}

	/**
	 * 发布问卷
	 */
	@PostMapping("/{id}/publish")
	@PreAuthorize("hasRole('ADMIN')")
	public Result<Void> publish(@PathVariable Long id) {
		questionnaireService.publishQuestionnaire(id);
		return Result.success(null);
	}

	/**
	 * 删除问卷
	 */
	@DeleteMapping("/{id}")
	@PreAuthorize("hasRole('ADMIN')")
	public Result<Void> delete(@PathVariable Long id) {
		questionnaireService.deleteQuestionnaire(id);
		return Result.success(null);
	}

	/**
	 * 获取问卷列表
	 */
	@GetMapping
	public Result<Page<QuestionnaireDTO>> list(
			@RequestParam(required = false) Integer status,
			@RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "10") Integer size) {
		Page<QuestionnaireDTO> result = questionnaireService.getQuestionnaireList(status, page, size);
		return Result.success(result);
	}

	/**
	 * 获取问卷详情
	 */
	@GetMapping("/{id}")
	public Result<QuestionnaireDTO> detail(@PathVariable Long id) {
		QuestionnaireDTO result = questionnaireService.getQuestionnaireDetail(id);
		return Result.success(result);
	}

	/**
	 * 提交答卷
	 */
	@PostMapping("/submit")
	public Result<Void> submit(
			@RequestBody SubmitAnswerDTO dto,
			@AuthenticationPrincipal UserDetails userDetails,
			HttpServletRequest request) {
		Long userId = userDetails != null ? ((CustomUserDetails) userDetails).getId() : null;
		String ipAddress = getClientIp(request);
		questionnaireService.submitAnswer(dto, userId, ipAddress);
		return Result.success(null);
	}

	/**
	 * 获取统计数据
	 */
	@GetMapping("/{id}/statistics")
	@PreAuthorize("hasRole('ADMIN')")
	public Result<StatisticsDTO> statistics(@PathVariable Long id) {
		StatisticsDTO result = questionnaireService.getStatistics(id);
		return Result.success(result);
	}

	/**
	 * 获取客户端IP
	 */
	private String getClientIp(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
		}
		if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
}