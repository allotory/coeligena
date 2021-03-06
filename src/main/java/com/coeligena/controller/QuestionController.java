package com.coeligena.controller;

import com.coeligena.dto.AnswersDTO;
import com.coeligena.dto.UserInfoDTO;
import com.coeligena.function.paging.Page;
import com.coeligena.model.*;
import com.coeligena.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.HyperLogLogOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * question controller
 *
 * Created by Ellery on 2017/8/11.
 */

@Controller
public class QuestionController {

    private QuestionsService questionsService;
    private QuestionTagsService questionTagsService;
    private AnswersService answersService;
    private UsersService usersService;
    private VotesService votesService;
    private ThanksService thanksService;
    private NoHelpsService noHelpsService;
    private FollowService followService;

    @Resource
    private RedisTemplate<String, String> redisTemplate;

    /**
     * 问题页面
     * @param questionId 问题 id
     * @param model model
     * @return 问题页
     */
    @RequestMapping(value = "/question/{questionId}", method = RequestMethod.GET)
    public String question(HttpServletRequest request,
                           @PathVariable int questionId, Model model) {
        // 查询用户信息
        UserInfoDTO userInfoDTO = (UserInfoDTO) request.getSession().getAttribute("userInfoDTO");

        // 查询问题信息
        QuestionsDO questionsDO = questionsService.queryQuestionById(questionId);

        // 处理问题浏览量
        HyperLogLogOperations<String, String> hLLO = redisTemplate.opsForHyperLogLog();
        hLLO.add("question:" + questionsDO.getId() + "::viewCount",
                userInfoDTO.getUsersDO().getId() + "");
        // 更新问题浏览量
        questionsDO.setViewCount(hLLO.size("question::" + questionsDO.getId() + "::viewCount").intValue());
        questionsService.modifyQuestion(questionsDO);

        // 查询问题标签
        List<TopicNodesDO> questionTagsList = questionTagsService.queryQuestionTagByQid(questionsDO.getId());

        // 初始化分页信息
        int count = answersService.queryAnswersCountByQuestionId(questionId);
        Page page = null;
        List<AnswersDTO> answersDTOList = null;
        if (count > 0) {
            page = new Page(1, 5);
            page.setSize(count);
            page.setNavigatePages(3);
            page.init();

            // 查询回答列表
            List<AnswersDO> answersList = answersService.queryAnswersByQuestionIdSortedWSIWithPage(page, questionId);
            answersDTOList = new ArrayList<>();
            for (AnswersDO answersDO : answersList) {
                // 查询作者信息
                UsersDO usersDO = usersService.queryUserByUserId(answersDO.getAuthorId());

                // 查询回答投票信息
                VotesDO votesDO = this.votesService.queryVotesByAnswerIdAndVoterId(
                        answersDO.getId(), usersDO.getId());

                // 查询感谢信息
                ThanksDO thanksDO = thanksService.queryThanksByAnswerIdAndUId(answersDO.getId(), userInfoDTO.getUsersDO().getId());

                // 查询是否提交没有帮助
                NoHelpsDO noHelpsDO = noHelpsService.queryNoHelpByAnswerIdAndUid(answersDO.getId(), userInfoDTO.getUsersDO().getId());

                // 回答信息
                AnswersDTO answersDTO = new AnswersDTO();
                answersDTO.setUsersDO(usersDO);
                answersDTO.setAnswersDO(answersDO);
                answersDTO.setVotesDO(votesDO);

                if (thanksDO != null) {
                    answersDTO.setThanked(true);
                } else {
                    answersDTO.setThanked(false);
                }

                if (noHelpsDO != null) {
                    answersDTO.setNoHelp(true);
                } else {
                    answersDTO.setNoHelp(false);
                }

                answersDTOList.add(answersDTO);
            }
        }

        // 是否已关注
        FollowDO followDO = this.followService.queryFollowByQidAndUid(questionId, userInfoDTO.getUsersDO().getId());
        boolean followed = false;
        if (followDO != null) {
            followed = true;
        }

        model.addAttribute("questionsDO", questionsDO);
        model.addAttribute("questionTagsList", questionTagsList);
        model.addAttribute("fromAnswer", false);
        model.addAttribute("answersDTOList", answersDTOList);
        model.addAttribute("followed", followed);
        model.addAttribute("page", page);
        return "question";
    }

    /**
     * 问题页特定回答
     * @param questionId 问题 id
     * @param answerId 问题回答
     * @param model model
     * @return 问题页
     */
    @RequestMapping(value = "/question/{questionId}/answer/{answerId}", method = RequestMethod.GET)
    public String questionAnswer(@PathVariable int questionId,
                                 @PathVariable int answerId, Model model) {

        QuestionsDO questionsDO = questionsService.queryQuestionById(questionId);

        model.addAttribute("questionsDO", questionsDO);
        return "question";
    }

    @RequestMapping(value = "/question/invited", method = RequestMethod.GET)
    public String questionInvited() {
        return "invited";
    }

    @RequestMapping(value = "/question/{questionId}/log", method = RequestMethod.GET)
    public String questionLog(@PathVariable int questionId, Model model) {
        return "log";
    }

    @Autowired
    public void setQuestionsService(QuestionsService questionsService) {
        this.questionsService = questionsService;
    }

    @Autowired
    public void setQuestionTagsService(QuestionTagsService questionTagsService) {
        this.questionTagsService = questionTagsService;
    }

    @Autowired
    public void setAnswersService(AnswersService answersService) {
        this.answersService = answersService;
    }

    @Autowired
    public void setUsersService(UsersService usersService) {
        this.usersService = usersService;
    }

    @Autowired
    public void setVotesService(VotesService votesService) {
        this.votesService = votesService;
    }

    @Autowired
    public void setThanksService(ThanksService thanksService) {
        this.thanksService = thanksService;
    }

    @Autowired
    public void setNoHelpsService(NoHelpsService noHelpsService) {
        this.noHelpsService = noHelpsService;
    }

    @Autowired
    public void setFollowService(FollowService followService) {
        this.followService = followService;
    }
}
