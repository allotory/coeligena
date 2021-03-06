package com.coeligena.service.impl;

import com.coeligena.dao.QuestionsDAO;
import com.coeligena.model.QuestionsDO;
import com.coeligena.service.QuestionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *     问题业务实现类
 * </p>
 * Created by Ellery on 2018/5/18.
 */
@Service("questionsService")
public class QuestionsServiceImpl implements QuestionsService {

    private QuestionsDAO questionsDAO;

    /**
     * 添加问题
     * @param questionsDO 问题对象
     */
    @Override
    public void saveQuestion(QuestionsDO questionsDO) {
        this.questionsDAO.addQuestion(questionsDO);
    }

    /**
     * 由问题 id 查询问题信息
     * @param questionId 问题 id
     * @return 问题信息
     */
    @Override
    public QuestionsDO queryQuestionById(int questionId) {
        return questionsDAO.queryQuestionById(questionId);
    }

    /**
     * 更新问题信息
     * @param questionsDO 问题信息
     */
    @Override
    public void modifyQuestion(QuestionsDO questionsDO) {
        this.questionsDAO.updateQuestion(questionsDO);
    }

    @Autowired
    public void setQuestionsDAO(QuestionsDAO questionsDAO) {
        this.questionsDAO = questionsDAO;
    }
}
