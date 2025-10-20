package com.miniprogram.uniappwx.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.miniprogram.uniappwx.dto.*;
import com.miniprogram.uniappwx.entity.*;
import com.miniprogram.uniappwx.mapper.*;
import com.miniprogram.uniappwx.dto.OptionDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class QuestionnaireService extends ServiceImpl<QuestionnaireMapper, Questionnaire> {

	private final QuestionnaireMapper questionnaireMapper;
	private final QuestionMapper questionMapper;
	private final OptionMapper optionMapper;
	private final AnswerSheetMapper answerSheetMapper;
	private final AnswerMapper answerMapper;

	/**
	 * 创建问卷
	 */
	@Transactional(rollbackFor = Exception.class)
	public QuestionnaireDTO createQuestionnaire(QuestionnaireDTO dto, Long creatorId) {
		// 保存问卷基本信息
		Questionnaire questionnaire = new Questionnaire();
		BeanUtils.copyProperties(dto, questionnaire);
		questionnaire.setCreatorId(creatorId);
		questionnaire.setStatus(0); // 草稿
		questionnaire.setAnswerCount(0);
		questionnaire.setCreateTime(LocalDateTime.now());
		questionnaire.setUpdateTime(LocalDateTime.now());

		questionnaireMapper.insert(questionnaire);

		// 保存题目和选项
		if (dto.getQuestions() != null && !dto.getQuestions().isEmpty()) {
			saveQuestions(questionnaire.getId(), dto.getQuestions());
		}

		return getQuestionnaireDetail(questionnaire.getId());
	}

	/**
	 * 更新问卷
	 */
	@Transactional(rollbackFor = Exception.class)
	public QuestionnaireDTO updateQuestionnaire(Long id, QuestionnaireDTO dto) {
		Questionnaire questionnaire = questionnaireMapper.selectById(id);
		if (questionnaire == null) {
			throw new RuntimeException("问卷不存在");
		}

		// 更新问卷基本信息
		questionnaire.setTitle(dto.getTitle());
		questionnaire.setDescription(dto.getDescription());
		questionnaire.setCoverImage(dto.getCoverImage());
		questionnaire.setStartTime(dto.getStartTime());
		questionnaire.setEndTime(dto.getEndTime());
		questionnaire.setMaxAnswers(dto.getMaxAnswers());
		questionnaire.setIsAnonymous(dto.getIsAnonymous());
		questionnaire.setNeedLogin(dto.getNeedLogin());
		questionnaire.setUpdateTime(LocalDateTime.now());

		questionnaireMapper.updateById(questionnaire);

		// 删除旧题目和选项
		LambdaQueryWrapper<Question> questionWrapper = new LambdaQueryWrapper<>();
		questionWrapper.eq(Question::getQuestionnaireId, id);
		List<Question> oldQuestions = questionMapper.selectList(questionWrapper);

		for (Question oldQuestion : oldQuestions) {
			// 删除选项
			LambdaQueryWrapper<Option> optionWrapper = new LambdaQueryWrapper<>();
			optionWrapper.eq(Option::getQuestionId, oldQuestion.getId());
			optionMapper.delete(optionWrapper);
		}
		questionMapper.delete(questionWrapper);

		// 保存新题目
		if (dto.getQuestions() != null && !dto.getQuestions().isEmpty()) {
			saveQuestions(id, dto.getQuestions());
		}

		return getQuestionnaireDetail(id);
	}

	/**
	 * 发布问卷
	 */
	@Transactional(rollbackFor = Exception.class)
	public void publishQuestionnaire(Long id) {
		Questionnaire questionnaire = questionnaireMapper.selectById(id);
		if (questionnaire == null) {
			throw new RuntimeException("问卷不存在");
		}

		questionnaire.setStatus(1);
		questionnaire.setUpdateTime(LocalDateTime.now());
		questionnaireMapper.updateById(questionnaire);
	}

	/**
	 * 删除问卷
	 */
	@Transactional(rollbackFor = Exception.class)
	public void deleteQuestionnaire(Long id) {
		// MyBatis-Plus会自动级联删除（如果数据库设置了外键约束）
		questionnaireMapper.deleteById(id);
	}

	/**
	 * 获取问卷列表（分页）
	 */
	public Page<QuestionnaireDTO> getQuestionnaireList(Integer status, Integer pageNum, Integer pageSize) {
		Page<Questionnaire> page = new Page<>(pageNum, pageSize);

		LambdaQueryWrapper<Questionnaire> wrapper = new LambdaQueryWrapper<>();
		if (status != null) {
			wrapper.eq(Questionnaire::getStatus, status);
		}
		wrapper.orderByDesc(Questionnaire::getCreateTime);

		Page<Questionnaire> resultPage = questionnaireMapper.selectPage(page, wrapper);

		// 转换为DTO
		Page<QuestionnaireDTO> dtoPage = new Page<>();
		BeanUtils.copyProperties(resultPage, dtoPage, "records");

		List<QuestionnaireDTO> dtoList = resultPage.getRecords().stream()
				.map(this::convertToDTO)
				.collect(Collectors.toList());
		dtoPage.setRecords(dtoList);

		return dtoPage;
	}

	/**
	 * 获取问卷详情
	 */
	public QuestionnaireDTO getQuestionnaireDetail(Long id) {
		Questionnaire questionnaire = questionnaireMapper.selectById(id);
		if (questionnaire == null) {
			throw new RuntimeException("问卷不存在");
		}

		QuestionnaireDTO dto = convertToDTO(questionnaire);

		// 查询题目
		LambdaQueryWrapper<Question> questionWrapper = new LambdaQueryWrapper<>();
		questionWrapper.eq(Question::getQuestionnaireId, id)
				.orderByAsc(Question::getSortOrder);
		List<Question> questions = questionMapper.selectList(questionWrapper);

		List<QuestionDTO> questionDTOs = questions.stream()
				.map(this::convertQuestionToDTO)
				.collect(Collectors.toList());

		dto.setQuestions(questionDTOs);

		return dto;
	}

	/**
	 * 提交答卷
	 */
	@Transactional(rollbackFor = Exception.class)
	public void submitAnswer(SubmitAnswerDTO dto, Long userId, String ipAddress) {
		Questionnaire questionnaire = questionnaireMapper.selectById(dto.getQuestionnaireId());
		if (questionnaire == null) {
			throw new RuntimeException("问卷不存在");
		}

		if (questionnaire.getStatus() != 1) {
			throw new RuntimeException("问卷未发布或已结束");
		}

		if (questionnaire.getMaxAnswers() > 0
				&& questionnaire.getAnswerCount() >= questionnaire.getMaxAnswers()) {
			throw new RuntimeException("问卷已达到最大答卷数");
		}

		// 创建答卷
		AnswerSheet sheet = new AnswerSheet();
		sheet.setQuestionnaireId(dto.getQuestionnaireId());
		sheet.setUserId(userId);
		sheet.setIpAddress(ipAddress);
		sheet.setSubmitTime(LocalDateTime.now());
		sheet.setDuration(dto.getDuration());
		answerSheetMapper.insert(sheet);

		// 保存答案
		for (AnswerItemDTO item : dto.getAnswers()) {
			if (item.getOptionIds() != null && !item.getOptionIds().isEmpty()) {
				// 选择题
				for (Long optionId : item.getOptionIds()) {
					Answer answer = new Answer();
					answer.setAnswerSheetId(sheet.getId());
					answer.setQuestionId(item.getQuestionId());
					answer.setOptionId(optionId);
					answer.setCreateTime(LocalDateTime.now());
					answerMapper.insert(answer);
				}
			} else if (item.getContent() != null && !item.getContent().trim().isEmpty()) {
				// 填空题
				Answer answer = new Answer();
				answer.setAnswerSheetId(sheet.getId());
				answer.setQuestionId(item.getQuestionId());
				answer.setContent(item.getContent());
				answer.setCreateTime(LocalDateTime.now());
				answerMapper.insert(answer);
			}
		}

		// 更新答卷数
		questionnaire.setAnswerCount(questionnaire.getAnswerCount() + 1);
		questionnaireMapper.updateById(questionnaire);
	}

	/**
	 * 获取统计数据
	 */
	public StatisticsDTO getStatistics(Long questionnaireId) {
		QuestionnaireDTO questionnaireDTO = getQuestionnaireDetail(questionnaireId);

		StatisticsDTO stats = new StatisticsDTO();
		stats.setQuestionnaire(questionnaireDTO);
		stats.setTotalAnswers(questionnaireDTO.getAnswerCount());

		List<QuestionStatDTO> questionStats = new ArrayList<>();

		for (QuestionDTO question : questionnaireDTO.getQuestions()) {
			QuestionStatDTO questionStat = new QuestionStatDTO();
			questionStat.setQuestionId(question.getId());
			questionStat.setTitle(question.getTitle());
			questionStat.setType(question.getType());

			if ("TEXT".equals(question.getType()) || "TEXTAREA".equals(question.getType())) {
				// 填空题统计
				List<String> textAnswers = answerMapper.findTextAnswersByQuestionId(question.getId());
				questionStat.setTextAnswers(textAnswers);
			} else {
				// 选择题统计
				List<OptionStatDTO> optionStats = new ArrayList<>();
				int totalAnswers = stats.getTotalAnswers();

				for (OptionDTO option : question.getOptions()) {
					Integer count = answerMapper.countByQuestionIdAndOptionId(
							question.getId(), option.getId()
					);

					OptionStatDTO optionStat = new OptionStatDTO();
					optionStat.setOptionId(option.getId());
					optionStat.setContent(option.getContent());
					optionStat.setCount(count);
					optionStat.setPercentage(
							totalAnswers > 0 ? (count * 100.0 / totalAnswers) : 0.0
					);
					optionStats.add(optionStat);
				}
				questionStat.setOptionStats(optionStats);
			}

			questionStats.add(questionStat);
		}

		stats.setQuestionStats(questionStats);
		return stats;
	}

	// ========== 私有辅助方法 ==========

	private void saveQuestions(Long questionnaireId, List<QuestionDTO> questionDTOs) {
		for (QuestionDTO questionDTO : questionDTOs) {
			Question question = new Question();
			question.setQuestionnaireId(questionnaireId);
			question.setTitle(questionDTO.getTitle());
			question.setType(questionDTO.getType());
			question.setIsRequired(questionDTO.getIsRequired());
			question.setSortOrder(questionDTO.getSortOrder());
			question.setCreateTime(LocalDateTime.now());
			questionMapper.insert(question);

			// 保存选项
			if (questionDTO.getOptions() != null && !questionDTO.getOptions().isEmpty()) {
				for (OptionDTO optionDTO : questionDTO.getOptions()) {
					Option option = new Option();
					option.setQuestionId(question.getId());
					option.setContent(optionDTO.getContent());
					option.setSortOrder(optionDTO.getSortOrder());
					option.setCreateTime(LocalDateTime.now());
					optionMapper.insert(option);
				}
			}
		}
	}

	private QuestionnaireDTO convertToDTO(Questionnaire questionnaire) {
		QuestionnaireDTO dto = new QuestionnaireDTO();
		BeanUtils.copyProperties(questionnaire, dto);
		return dto;
	}

	private QuestionDTO convertQuestionToDTO(Question question) {
		QuestionDTO dto = new QuestionDTO();
		BeanUtils.copyProperties(question, dto);

		// 查询选项
		LambdaQueryWrapper<Option> optionWrapper = new LambdaQueryWrapper<>();
		optionWrapper.eq(Option::getQuestionId, question.getId())
				.orderByAsc(Option::getSortOrder);
		List<Option> options = optionMapper.selectList(optionWrapper);

		List<OptionDTO> optionDTOs = options.stream()
				.map(this::convertOptionToDTO)
				.collect(Collectors.toList());

		dto.setOptions(optionDTOs);
		return dto;
	}

	private OptionDTO convertOptionToDTO(Option option) {
		OptionDTO dto = new OptionDTO();
		BeanUtils.copyProperties(option, dto);
		return dto;
	}
}