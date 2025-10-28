package com.miniprogram.uniappwx.vo;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class FeedbackVO {
	/**
	 * 反馈记录ID
	 */
	private Long id;

	/**
	 * 关联的用户ID
	 */
	private Long userId;

	/**
	 * 反馈类型
	 */
	private String feedbackType;

	/**
	 * 反馈内容
	 */
	private String feedbackInfo;

	/**
	 * 反馈创建时间
	 */
	private LocalDateTime createdAt;

	/**
	 * 关联的用户昵称（可选，用于前端展示）
	 */
	private String userNickname;

	/**
	 * 用户手机号
	 */
	private String userPhone;
}
