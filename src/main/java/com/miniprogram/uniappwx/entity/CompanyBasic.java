package com.miniprogram.uniappwx.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("company_basic")
public class CompanyBasic {
	@TableId(type = IdType.AUTO)
	private Long id;

	private Long userId;

	private String companyName;

	private String primaryPhone;

	private String backupPhone;

	@TableField(fill = FieldFill.INSERT)
	private LocalDateTime createTime;

	@TableField(fill = FieldFill.INSERT_UPDATE)
	private LocalDateTime updateTime;
}