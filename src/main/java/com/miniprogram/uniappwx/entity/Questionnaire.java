package com.miniprogram.uniappwx.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.io.Serializable;
import java.time.LocalDateTime;

// ============= Questionnaire 问卷实体 =============
@Data
@TableName("questionnaire")
public class Questionnaire implements Serializable {
	private static final long serialVersionUID = 1L;

	@TableId(value = "id", type = IdType.AUTO)
	private Long id;

	private String title;

	private String description;

	@TableField("cover_image")
	private String coverImage;

	@TableField("creator_id")
	private Long creatorId;

	private Integer status;

	@TableField("start_time")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime startTime;

	@TableField("end_time")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime endTime;

	@TableField("max_answers")
	private Integer maxAnswers;

	@TableField("answer_count")
	private Integer answerCount;

	@TableField("is_anonymous")
	private Boolean isAnonymous;

	@TableField("need_login")
	private Boolean needLogin;

	@TableField("create_time")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime createTime;

	@TableField("update_time")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updateTime;
}
