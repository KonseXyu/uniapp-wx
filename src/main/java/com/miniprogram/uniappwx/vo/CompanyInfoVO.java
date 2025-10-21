package com.miniprogram.uniappwx.vo;

import lombok.Data;

@Data
public class CompanyInfoVO {
	private Long companyId;
	private String primaryPhone;
	private String companyName;
	private String industry;
	private String employeeCount;
}
