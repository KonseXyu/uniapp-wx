package com.miniprogram.uniappwx.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import com.miniprogram.uniappwx.entity.Feedback;

import com.miniprogram.uniappwx.vo.FeedbackVO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface FeedBackMapper extends BaseMapper<Feedback> {

    @Select("SELECT " +
            "f.id, " +
            "f.feedback_id AS feedbackId, " +
            "f.feedback_info AS feedbackInfo, " +
            "f.created_at AS createdAt, " +
            "u.nickname AS userNickname, " +
            "u.phone AS userPhone " +  // 补充缺失的空格
            "FROM feedback f " +
            "JOIN user u ON f.feedback_id = u.id " +
            "WHERE u.id = #{userId}")
    List<FeedbackVO> selectUserFeedback(@Param("userId") Long userId);
}
