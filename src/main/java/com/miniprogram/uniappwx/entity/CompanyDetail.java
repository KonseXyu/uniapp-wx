package com.miniprogram.uniappwx.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("company_detail")
public class CompanyDetail {
	@TableId(type = IdType.AUTO)
	private Long id;

	private Long companyId;

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

	@TableField(fill = FieldFill.INSERT)
	private LocalDateTime createTime;

	@TableField(fill = FieldFill.INSERT_UPDATE)
	private LocalDateTime updateTime;
}

