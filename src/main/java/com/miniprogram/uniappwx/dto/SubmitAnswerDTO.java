package com.miniprogram.uniappwx.dto;

import lombok.Data;

import java.util.List;

@Data
public class SubmitAnswerDTO {
	private Long questionnaireId;
	private Integer duration;
	private List<AnswerItemDTO> answers;
}