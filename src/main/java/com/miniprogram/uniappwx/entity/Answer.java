package com.miniprogram.uniappwx.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.io.Serializable;
import java.time.LocalDateTime;

// ============= Answer 答案实体 =============
@Data
@TableName("answer")
public class Answer implements Serializable {
	private static final long serialVersionUID = 1L;

	@TableId(value = "id", type = IdType.AUTO)
	private Long id;

	@TableField("answer_sheet_id")
	private Long answerSheetId;

	@TableField("question_id")
	private Long questionId;

	@TableField("option_id")
	private Long optionId;

	private String content;

	@TableField("create_time")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime createTime;
}
