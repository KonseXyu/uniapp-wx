package com.miniprogram.uniappwx.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.io.Serializable;
import java.time.LocalDateTime;

// ============= Question 题目实体 =============
@Data
@TableName("question")
public class Question implements Serializable {
	private static final long serialVersionUID = 1L;

	@TableId(value = "id", type = IdType.AUTO)
	private Long id;

	@TableField("questionnaire_id")
	private Long questionnaireId;

	private String title;

	private String type;

	@TableField("is_required")
	private Boolean isRequired;

	@TableField("sort_order")
	private Integer sortOrder;

	@TableField("create_time")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime createTime;
}
