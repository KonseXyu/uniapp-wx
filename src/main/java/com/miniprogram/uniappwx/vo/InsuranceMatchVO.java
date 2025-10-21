package com.miniprogram.uniappwx.vo;

import lombok.Data;

@Data
public class InsuranceMatchVO {
	private Long id;
	private String insuranceName;
	private String companyName;
	private String insuranceType;
	private String annualFee;
	private String contactName;
	private String contactPhone;
	private Double matchScore;
	private String matchReason;
}