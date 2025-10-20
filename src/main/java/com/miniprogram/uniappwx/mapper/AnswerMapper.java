package com.miniprogram.uniappwx.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.miniprogram.uniappwx.entity.Answer;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface AnswerMapper extends BaseMapper<Answer> {

	@Select("SELECT content FROM answer WHERE question_id = #{questionId} AND content IS NOT NULL")
	List<String> findTextAnswersByQuestionId(@Param("questionId") Long questionId);

	@Select("SELECT COUNT(*) FROM answer WHERE question_id = #{questionId} AND option_id = #{optionId}")
	Integer countByQuestionIdAndOptionId(@Param("questionId") Long questionId,
																			 @Param("optionId") Long optionId);
}