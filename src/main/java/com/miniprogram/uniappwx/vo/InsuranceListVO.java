package com.miniprogram.uniappwx.vo;

import lombok.Data;

/**
 * 保险列表展示VO
 */
@Data
public class InsuranceListVO {
	private Long id;
	private String insuranceName;
	private String companyName;
	private String insuranceType;
	private String annualFee;
	private String contactName;
	private String contactPhone;
	private Boolean isFavorited; // 是否已收藏
}