package com.miniprogram.uniappwx.dto;

import lombok.Data;

import java.util.List;

@Data
public class StatisticsDTO {
	private QuestionnaireDTO questionnaire;
	private Integer totalAnswers;
	private List<QuestionStatDTO> questionStats;
}
