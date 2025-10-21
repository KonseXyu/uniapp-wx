package com.miniprogram.uniappwx.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;
import jakarta.validation.constraints.NotBlank;

import java.util.List;

@Data
public class CompanyDetailDTO {
	@NotNull(message = "企业ID不能为空")
	private Long companyId;

	@NotBlank(message = "所属行业不能为空")
	private String industry;

	private List<String> mainAssets;

	@NotBlank(message = "成立年限不能为空")
	private String establishedYears;

	@NotBlank(message = "员工总数不能为空")
	private String employeeCount;

	@NotBlank(message = "年营业额不能为空")
	private String annualRevenue;

	@NotBlank(message = "注册资本金不能为空")
	private String registeredCapital;

	private List<String> specialEquipment;

	@NotBlank(message = "是否涉及进出口贸易不能为空")
	private String hasImportExport;

	private List<String> purchasedInsurance;

	private List<String> riskCoverage;

	private List<String> potentialRisk;

	private List<String> riskTransfer;

	private String annualBudget;
}
