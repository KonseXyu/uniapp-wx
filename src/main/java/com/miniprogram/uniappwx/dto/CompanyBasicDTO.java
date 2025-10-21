package com.miniprogram.uniappwx.dto;
import lombok.Data;
import jakarta.validation.constraints.NotBlank;

@Data
public class CompanyBasicDTO {
	@NotBlank(message = "企业名称不能为空")
	private String companyName;

	@NotBlank(message = "主要联系电话不能为空")
	private String primaryPhone;

	private String backupPhone;
}