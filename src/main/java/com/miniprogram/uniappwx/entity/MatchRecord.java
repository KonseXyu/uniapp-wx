package com.miniprogram.uniappwx.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("match_record")
public class MatchRecord {
	@TableId(type = IdType.AUTO)
	private Long id;

	private Long companyId;

	private Long insuranceId;

	private Double matchScore;

	private String matchReason;

	@TableField(fill = FieldFill.INSERT)
	private LocalDateTime matchTime;
}