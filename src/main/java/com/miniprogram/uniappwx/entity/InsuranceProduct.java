package com.miniprogram.uniappwx.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;


@Data
@TableName("insurance_product")
public class InsuranceProduct {
	@TableId(type = IdType.AUTO)
	private Long id;

	private String companyName;

	private String companyContactName;

	private String companyContactPhone;

	private String companyAddress;

	private String insuranceName;

	private String insuranceContactName;

	private String insuranceContactPhone;

	private String insuranceType;

	private String targetIndustry;

	private String targetYears;

	private String targetEmployees;

	private String targetRevenue;

	private String targetCapital;

	private String targetAssets;

	private String targetEquipment;

	private String targetImportExport;

	private String coveredInsuranceTypes;

	private String coveredRisks;

	private String coveredPotentialRisks;

	private String riskTransferTypes;

	private String annualFee;

	private String otherNotes;

	@TableField(fill = FieldFill.INSERT)
	private LocalDateTime createTime;

	@TableField(fill = FieldFill.INSERT_UPDATE)
	private LocalDateTime updateTime;
}