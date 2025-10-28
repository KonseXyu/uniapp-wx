package com.miniprogram.uniappwx.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("tbl_feedback")
public class Feedback {

    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 关联用户表的id
     */
    @TableField("feedback_id")
    private Long feedbackId;

    /**
     * 反馈内容
     */
    @TableField("feedback_info")
    private String feedbackInfo;

    /**
     * 反馈创建时间
     */
    @TableField(value = "created_at", fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
}
