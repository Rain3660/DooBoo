package com.koreait.dooboo.reply.dto;

import java.sql.Date;

// Community Board 의 댓글게시판
public class ReplyDTO {

    // 댓글번호 1부터 시작
    private long replyNo;

    // 원글번호 
    private long boardNo;

    // 댓글내용 
    private String replyContent;

    // 삭제여부 
    private String delYn;

    // 작성자 
    private long regNo;

    // 수정자 
    private long modNo;

    // 등록날짜 
    private Date regDate;

    // 수정날짜 
    private Date modDate;

    public long getReplyNo() {
        return replyNo;
    }

    public void setReplyNo(long replyNo) {
        this.replyNo = replyNo;
    }

    public long getBoardNo() {
        return boardNo;
    }

    public void setBoardNo(long boardNo) {
        this.boardNo = boardNo;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public String getDelYn() {
        return delYn;
    }

    public void setDelYn(String delYn) {
        this.delYn = delYn;
    }

    public long getRegNo() {
        return regNo;
    }

    public void setRegNo(long regNo) {
        this.regNo = regNo;
    }

    public long getModNo() {
        return modNo;
    }

    public void setModNo(long modNo) {
        this.modNo = modNo;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    public Date getModDate() {
        return modDate;
    }

    public void setModDate(Date modDate) {
        this.modDate = modDate;
    }

}