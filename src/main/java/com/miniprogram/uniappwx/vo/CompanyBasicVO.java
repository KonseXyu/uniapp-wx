package com.miniprogram.uniappwx.vo;

import lombok.Data;

@Data
public class CompanyBasicVO {
	private Long companyId;
	private String companyName;
	private String primaryName;
	private String primaryPhone;
	private String backupPhone;
	private String backupName;
}