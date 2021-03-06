package com.coeligena.dao;

import com.coeligena.function.paging.Page;
import com.coeligena.model.AnswersDO;

import java.util.List;

/**
 * <p>
 *     回答数据访问对象
 * </p>
 * Created by Ellery on 2018/6/14.
 */
public interface AnswersDAO {

    /**
     * 添加回答
     * @param answersDO 回答
     */
    void addAnswer(AnswersDO answersDO);

    /**
     * 由问题 id 查询回答列表
     * @param questionId 问题 id
     * @return 回答列表
     */
    List<AnswersDO> queryAnswersByQuestionId(int questionId);

    /**
     * 由问题 id 查询回答列表， 由排序分数进行排序
     * @param questionId 问题 id
     * @return 回答列表
     */
    List<AnswersDO> queryAnswersByQuestionIdSortedWSI(int questionId);

    /**
     * 由问题 id 查询回答列表并分页
     * @param questionId 问题 id
     * @return 回答列表
     */
    List<AnswersDO> queryAnswersByQuestionIdWithPage(Page page, int questionId);

    /**
     * 由问题 id 查询回答列表，由排序分数进行排序，并分页
     * @param questionId 问题 id
     * @return 回答列表
     */
    List<AnswersDO> queryAnswersByQuestionIdSortedWSIWithPage(Page page, int questionId);

    /**
     * 由回答 id 查询回答
     * @param answersId 回答 id
     * @return 回答信息
     */
    AnswersDO queryAnswersById(int answersId);

    /**
     * 更新回答数据
     * @param answersDO 回答数据
     */
    void updateAnswers(AnswersDO answersDO);

    /**
     * 由问题 id 查询回答数量
     * @param questionId 问题 id
     * @return 回答数量
     */
    int queryAnswersCountByQuestionId(int questionId);
}
