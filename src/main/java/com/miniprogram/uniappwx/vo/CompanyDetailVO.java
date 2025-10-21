package com.miniprogram.uniappwx.vo;

import lombok.Data;

@Data
public class CompanyDetailVO {
	private Long id;
	private Long companyId;
	CompanyBasicVO  companyBasicVO;
	private String industry;
	private String mainAssets;
	private String establishedYears;
	private String employeeCount;
	private String annualRevenue;
	private String registeredCapital;
	private String specialEquipment;
	private String hasImportExport;
	private String purchasedInsurance;
	private String riskCoverage;
	private String potentialRisk;
	private String riskTransfer;
	private String annualBudget;


}
