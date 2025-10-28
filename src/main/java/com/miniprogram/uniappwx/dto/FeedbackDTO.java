package com.miniprogram.uniappwx.dto;

import lombok.Data;

@Data
public class FeedbackDTO {
    /**
     * 关联的用户ID
     */
    private Long feedbackId;

    /**
     * 反馈内容
     */
    private String feedbackInfo;
}
