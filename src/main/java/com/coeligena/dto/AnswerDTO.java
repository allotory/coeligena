package com.coeligena.dto;

/**
 * <p>
 *     提交回答
 * </p>
 * Created by Ellery on 2018/6/12.
 */

public class AnswerDTO {

    private String anonymous;

    private String answerContent;

    private String reprintType;

    private String commentType;

    public String getAnonymous() {
        return anonymous;
    }

    public void setAnonymous(String anonymous) {
        this.anonymous = anonymous;
    }

    public String getAnswerContent() {
        return answerContent;
    }

    public void setAnswerContent(String answerContent) {
        this.answerContent = answerContent;
    }

    public String getReprintType() {
        return reprintType;
    }

    public void setReprintType(String reprintType) {
        this.reprintType = reprintType;
    }

    public String getCommentType() {
        return commentType;
    }

    public void setCommentType(String commentType) {
        this.commentType = commentType;
    }
}
