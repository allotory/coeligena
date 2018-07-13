package com.coeligena.service;

import com.coeligena.model.QuestionCommentsDO;

import java.util.List;

/**
 * 问题评论信息业务接口
 * Created by Ellery on 2018/7/2.
 */
public interface QuestionCommentService {

    /**
     * 添加问题评论
     * @param questionCommentsDO 问题评论信息
     */
    void saveQuestionComment(QuestionCommentsDO questionCommentsDO);

    /**
     * 查询全部问题评论
     * @return 问题评论列表
     */
    List<QuestionCommentsDO> queryQuestionComments();

    /**
     * 用于分页，查询全部数量
     * @return 评论数量
     */
    int queryQuestionCommentsCount();
}