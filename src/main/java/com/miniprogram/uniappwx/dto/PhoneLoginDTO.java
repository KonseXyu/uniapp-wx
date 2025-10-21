// src/main/java/com/miniprogram/uniappwx/dto/PhoneLoginDTO.java
package com.miniprogram.uniappwx.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 手机号登录请求体
 */
@Data
public class PhoneLoginDTO {
	@NotBlank(message = "登录code不能为空")
	private String loginCode;

	@NotBlank(message = "手机号code不能为空")
	private String phoneCode;
}