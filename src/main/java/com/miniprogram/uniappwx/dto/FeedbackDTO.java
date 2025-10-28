package com.miniprogram.uniappwx.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class FeedbackDTO {
	/**
	 * 反馈类型：功能问题/界面问题/产品建议/其他
	 */
	private String feedbackType;

	/**
	 * 反馈内容
	 */
	@NotBlank(message = "反馈内容不能为空")
	private String feedbackInfo;
}