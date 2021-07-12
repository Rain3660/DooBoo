package com.koreait.dooboo.reply.dto;

import java.sql.Date;

public class ReplyDTO {
	
	private long replyNo;
	private String replyContent;
	private Date regdate;
	private Date lastmodified;
	private String nickname;
	private long communityBoardNo;
	public ReplyDTO() {
		// TODO Auto-generated constructor stub
	}
	public long getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(long replyNo) {
		this.replyNo = replyNo;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getLastmodified() {
		return lastmodified;
	}
	public void setLastmodified(Date lastmodified) {
		this.lastmodified = lastmodified;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public long getCommunityBoardNo() {
		return communityBoardNo;
	}
	public void setCommunityBoardNo(long communityBoardNo) {
		this.communityBoardNo = communityBoardNo;
	}
	@Override
	public String toString() {
		return "ReplyDTO [replyNo=" + replyNo + ", replyContent=" + replyContent + ", regdate=" + regdate
				+ ", lastmodified=" + lastmodified + ", nickname=" + nickname + ", communityBoardNo=" + communityBoardNo
				+ "]";
	}
	
	
	
}
