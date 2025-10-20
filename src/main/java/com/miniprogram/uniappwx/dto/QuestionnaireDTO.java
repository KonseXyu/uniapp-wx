package com.miniprogram.uniappwx.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class QuestionnaireDTO {
	private Long id;
	private String title;
	private String description;
	private String coverImage;
	private Integer status;
	private LocalDateTime startTime;
	private LocalDateTime endTime;
	private Integer maxAnswers;
	private Integer answerCount;
	private Boolean isAnonymous;
	private Boolean needLogin;
	private List<QuestionDTO> questions;
}