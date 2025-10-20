package com.miniprogram.uniappwx.dto;

import lombok.Data;

import java.util.List;

@Data
public class AnswerItemDTO {
	private Long questionId;
	private List<Long> optionIds; // 多选题用
	private String content; // 填空题用
}