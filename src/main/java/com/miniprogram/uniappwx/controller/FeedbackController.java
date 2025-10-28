package com.miniprogram.uniappwx.controller;

import com.miniprogram.uniappwx.common.Result;
import com.miniprogram.uniappwx.dto.FeedbackDTO;
import com.miniprogram.uniappwx.entity.Feedback;
import com.miniprogram.uniappwx.service.FeedBackService;
import com.miniprogram.uniappwx.vo.FeedbackVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/feedback")
public class FeedbackController {

	private final FeedBackService feedBackService;

	public FeedbackController(FeedBackService feedBackService) {
		this.feedBackService = feedBackService;
	}

	/**
	 * 根据用户id查询名下所有反馈信息
	 */
	@GetMapping("/list")
	public Result<List<FeedbackVO>> getUserFeedbackList(@RequestAttribute("userId") Long userId) {
		try {
			List<FeedbackVO> feedbackVOList = feedBackService.getUserFeedbackList(userId);
			return Result.success(feedbackVOList);
		} catch (Exception e) {
			log.error("根据用户id查询反馈列表失败", e);
			return Result.error(e.getMessage());
		}
	}

	/**
	 * 新增反馈信息
	 */
	@PostMapping("/submit")
	public Result<Long> submitFeedback(
			@RequestAttribute("userId") Long userId,
			@Validated @RequestBody FeedbackDTO feedbackDTO) {
		try {
			// 创建Feedback实体
			Feedback feedback = new Feedback();
			feedback.setUserId(userId); // 设置用户ID
			feedback.setFeedbackType(feedbackDTO.getFeedbackType()); // 设置反馈类型
			feedback.setFeedbackInfo(feedbackDTO.getFeedbackInfo()); // 设置反馈内容
			feedback.setCreatedAt(LocalDateTime.now()); // 设置创建时间

			Long feedbackId = feedBackService.addFeedback(feedback);
			return Result.success("提交成功", feedbackId);
		} catch (Exception e) {
			log.error("新增反馈信息失败", e);
			return Result.error(e.getMessage());
		}
	}
}