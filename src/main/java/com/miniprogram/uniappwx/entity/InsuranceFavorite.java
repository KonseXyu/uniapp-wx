package com.miniprogram.uniappwx.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 保险收藏表
 */
@Data
@TableName("tbl_insurance_favorite")
public class InsuranceFavorite {
	@TableId(type = IdType.AUTO)
	private Long id;

	private Long userId;

	private Long insuranceId;

	@TableField(fill = FieldFill.INSERT)
	private LocalDateTime createTime;
}