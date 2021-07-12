package com.koreait.dooboo.communityboard.dto;

import java.sql.Date;

public class CommunityBoardDTO {
	private long communityBoardNo;
	private String communityBoardTitle;
	private String communityBoardContent;
	private long memberNo;
	private Date regdate;
	private Date lastmodified;
	private int hit;
	private String nickname;
	
	public CommunityBoardDTO() {
		// TODO Auto-generated constructor stub
	}

	public long getCommunityBoardNo() {
		return communityBoardNo;
	}

	public void setCommunityBoardNo(long communityBoardNo) {
		this.communityBoardNo = communityBoardNo;
	}

	public String getCommunityBoardTitle() {
		return communityBoardTitle;
	}

	public void setCommunityBoardTitle(String communityBoardTitle) {
		this.communityBoardTitle = communityBoardTitle;
	}

	public String getCommunityBoardContent() {
		return communityBoardContent;
	}

	public void setCommunityBoardContent(String communityBoardContent) {
		this.communityBoardContent = communityBoardContent;
	}

	public long getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
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

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@Override
	public String toString() {
		return "CommunityBoardDTO [communityBoardNo=" + communityBoardNo + ", communityBoardTitle="
				+ communityBoardTitle + ", communityBoardContent=" + communityBoardContent + ", memberNo=" + memberNo
				+ ", regdate=" + regdate + ", lastmodified=" + lastmodified + ", hit=" + hit + ", nickname=" + nickname
				+ "]";
	}
	
	
}
