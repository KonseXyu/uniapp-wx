package com.miniprogram.uniappwx.vo;

import lombok.Data;


@Data
public class LoginVO {
	private String token;
	private UserInfoVO userInfo;
	private Boolean hasCompany;
}
