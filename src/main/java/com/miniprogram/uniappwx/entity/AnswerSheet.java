package com.miniprogram.uniappwx.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.io.Serializable;
import java.time.LocalDateTime;

// ============= AnswerSheet 答卷实体 =============
@Data
@TableName("answer_sheet")
public class AnswerSheet implements Serializable {
	private static final long serialVersionUID = 1L;

	@TableId(value = "id", type = IdType.AUTO)
	private Long id;

	@TableField("questionnaire_id")
	private Long questionnaireId;

	@TableField("user_id")
	private Long userId;

	@TableField("ip_address")
	private String ipAddress;

	@TableField("submit_time")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime submitTime;

	private Integer duration;
}