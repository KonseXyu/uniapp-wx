package com.miniprogram.uniappwx.dto;

import lombok.Data;

import java.util.List;

@Data
public class QuestionDTO {
	private Long id;
	private String title;
	private String type;
	private Boolean isRequired;
	private Integer sortOrder;
	private List<OptionDTO> options;
}