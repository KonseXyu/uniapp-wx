package com.miniprogram.uniappwx.dto;

import lombok.Data;

@Data
public class OptionStatDTO {
	private Long optionId;
	private String content;
	private Integer count;
	private Double percentage;
}