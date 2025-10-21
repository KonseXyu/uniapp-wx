package com.miniprogram.uniappwx.vo;

import lombok.Data;

import java.util.List;

@Data
public class MatchResultVO {
	private CompanyInfoVO companyInfo;
	private List<InsuranceMatchVO> matchResults;
}