package com.miniprogram.uniappwx.controller;

import com.miniprogram.uniappwx.common.Result;

import com.miniprogram.uniappwx.entity.Feedback;
import com.miniprogram.uniappwx.service.FeedBackService;

import com.miniprogram.uniappwx.vo.FeedbackVO;
import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/fB")
public class FeedBackController {
    private final FeedBackService feedBackService;
    public FeedBackController(FeedBackService feedBackService) {
        this.feedBackService = feedBackService;
    }
    /**
     * 根据用户id查询名下所有反馈信息
     */
    @GetMapping("/list/{userId}")
    public Result<List<FeedbackVO>> getUserFeedbackList(@PathVariable Long userId) {
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
    @PostMapping("/save")
    public Result<Long> addFeedback(@RequestBody Feedback feedback) {
        try {
            // 手动设置创建时间
            feedback.setCreatedAt(LocalDateTime.now());
            Long feedbackId = feedBackService.addFeedback(feedback);
            return Result.success("新增成功", feedbackId);
        } catch (Exception e) {
            log.error("新增反馈信息失败", e);
            return Result.error(e.getMessage());
        }
    }
}
