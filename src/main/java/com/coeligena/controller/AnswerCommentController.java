package com.coeligena.controller;

import com.coeligena.dto.CommentDTO;
import com.coeligena.dto.PagingListDTO;
import com.coeligena.dto.UserInfoDTO;
import com.coeligena.function.paging.Page;
import com.coeligena.model.AnswerCommentsDO;
import com.coeligena.model.CommentApprovalsDO;
import com.coeligena.model.UsersDO;
import com.coeligena.service.AnswerCommentsService;
import com.coeligena.service.CommentApprovalsService;
import com.coeligena.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * 回答评论 controller
 * Created by Ellery on 2018/8/14.
 */
@Controller
public class AnswerCommentController {

    private AnswerCommentsService answerCommentsService;
    private UsersService usersService;
    private CommentApprovalsService commentApprovalsService;

    /**
     * 回答评论列表
     * @param request http servlet request
     * @return 回答评论列表
     */
    @RequestMapping(value = "/answer-comment-list", method = RequestMethod.GET)
    @ResponseBody
    public PagingListDTO<CommentDTO> answerCommentList(HttpServletRequest request) {
        return answerCommentsPagingList(request, 1);
    }

    /**
     * 分页查询回答评论
     * @param request http servlet request
     * @param pageNum 页数
     * @return 回答评论列表
     */
    private PagingListDTO<CommentDTO> answerCommentsPagingList(HttpServletRequest request, int pageNum) {

        // 查询用户信息
        UserInfoDTO userInfoDTO = (UserInfoDTO) request.getSession().getAttribute("userInfoDTO");

        List<CommentDTO> commentDTOList = new ArrayList<>();

        int count = this.answerCommentsService.queryAnswerCommentsCount();

        // 初始化分页信息
        Page page = new Page(pageNum, 2);
        page.setSize(count);
        page.setNavigatePages(3);
        page.init();

        List<AnswerCommentsDO> answerCommentsDOList = this.answerCommentsService
                .queryAnswerCommentsByPage(page);
        for (AnswerCommentsDO answerCommentsDO: answerCommentsDOList) {
            CommentDTO commentDTO = new CommentDTO();

            // 查询被评论用户信息
            UsersDO reviewer = null;
            if (answerCommentsDO.getReviewerId() != 0) {
                reviewer = this.usersService.queryUserByUserId(answerCommentsDO.getReviewerId());
            }

            // 查询评论用户信息
            UsersDO user = this.usersService.queryUserByUserId(answerCommentsDO.getUserId());

            // 查询是否赞踩
            CommentApprovalsDO commentApprovalsDO = this.commentApprovalsService
                    .queryCommentApprByCommentIdAndUserId(answerCommentsDO.getId(), userInfoDTO.getUsersDO().getId());
            if (commentApprovalsDO != null) {
                if (commentApprovalsDO.getCommentAction() == 2) {
                    commentDTO.setUnlike(true);
                } else if (commentApprovalsDO.getCommentAction() == 1) {
                    commentDTO.setLike(true);
                }
            }

            commentDTO.setReviewer(reviewer);
            commentDTO.setAnswerCommentsDO(answerCommentsDO);
            commentDTO.setUser(user);

            commentDTOList.add(commentDTO);
        }

        return new PagingListDTO<>(commentDTOList, page);
    }

    @Autowired
    public void setAnswerCommentsService(AnswerCommentsService answerCommentsService) {
        this.answerCommentsService = answerCommentsService;
    }

    @Autowired
    public void setUsersService(UsersService usersService) {
        this.usersService = usersService;
    }

    @Autowired
    public void setCommentApprovalsService(CommentApprovalsService commentApprovalsService) {
        this.commentApprovalsService = commentApprovalsService;
    }
}
