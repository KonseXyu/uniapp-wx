package com.miniprogram.uniappwx.service;


import com.miniprogram.uniappwx.entity.Feedback;
import com.miniprogram.uniappwx.mapper.FeedbackMapper;

import com.miniprogram.uniappwx.vo.FeedbackVO;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class FeedBackService {
    @Resource
    private FeedbackMapper feedBackMapper;
    //根据用户id查询所在名下的所有反馈信息
    public List<FeedbackVO> getUserFeedbackList(Long userId) {
        return feedBackMapper.selectUserFeedback(userId);
    }
    //新增反馈信息
    public Long addFeedback(Feedback feedback) {
        // 调用 Mapper 内置的 insert 方法执行插入
        feedBackMapper.insert(feedback);
        // 返回自增生成的主键ID
        return feedback.getId();
    }


}
