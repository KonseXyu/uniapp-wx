package com.miniprogram.uniappwx.vo;

import lombok.Data;

import java.util.List;

@Data
public class InsuranceDetailVO {

	// --- Basic Fields ---

	private Long id;
	private String insuranceName;
	private String companyName;
	private String insuranceType;
	private String annualFee;

	// --- Contact Fields ---

	private String insuranceContactName;
	private String insuranceContactPhone;
	private String companyContactName;
	private String companyContactPhone;
	private String companyAddress;

	// --- Other/Notes Field ---

	private String otherNotes;

	// --- List Fields (Converted from String/Multi-select) ---
	/* * These fields are inferred to be Lists of Strings based on
	 * the methods setTargetIndustryList(...) and stringToList(...)
	 */

	private List<String> targetIndustryList;
	private List<String> targetYearsList;
	private List<String> targetEmployeesList;
	private List<String> coveredRisksList;
	private List<String> coveredPotentialRisksList;
	private List<String> riskTransferTypesList;


}