package com.miniprogram.uniappwx.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.miniprogram.uniappwx.entity.Feedback;
import com.miniprogram.uniappwx.vo.FeedbackVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface FeedbackMapper extends BaseMapper<Feedback> {

	@Select("SELECT " +
			"f.id, " +
			"f.user_id AS userId, " +
			"f.feedback_type AS feedbackType, " +
			"f.feedback_info AS feedbackInfo, " +
			"f.created_at AS createdAt, " +
			"u.nickname AS userNickname, " +
			"u.phone AS userPhone " +
			"FROM tbl_feedback f " +
			"JOIN tbl_user u ON f.user_id = u.id " +
			"WHERE u.id = #{userId} " +
			"ORDER BY f.created_at DESC")
	List<FeedbackVO> selectUserFeedback(@Param("userId") Long userId);
}