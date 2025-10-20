package com.miniprogram.uniappwx.dto;

import lombok.Data;

import java.util.List;

@Data
public class QuestionStatDTO {
	private Long questionId;
	private String title;
	private String type;
	private List<OptionStatDTO> optionStats;
	private List<String> textAnswers; // 填空题答案列表
}