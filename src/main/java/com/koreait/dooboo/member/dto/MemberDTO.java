package com.koreait.dooboo.member.dto;

import java.sql.Date;

public class MemberDTO {
	private long memberNo;
	private String memberName;
	private String memberPhone;
	private String memberId;
	private String memberPw;
	private String memberEmail;
	private String nickname;
	private char memberGender;
	private Date regdate;
	private Date memberOutdate;
	private int memberStatus;
	private String memberCity;
	private String memberRegion;
	private String memberLocation;
	private Date lastmodified;
	private String birthDay;
	private String birthMonth;
	private String birthYear;
	
	public MemberDTO() {
		// TODO Auto-generated constructor stub
	}

	public long getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberPhone() {
		return memberPhone;
	}

	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberPw() {
		return memberPw;
	}

	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public char getMemberGender() {
		return memberGender;
	}

	public void setMemberGender(char memberGender) {
		this.memberGender = memberGender;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getMemberOutdate() {
		return memberOutdate;
	}

	public void setMemberOutdate(Date memberOutdate) {
		this.memberOutdate = memberOutdate;
	}

	public int getMemberStatus() {
		return memberStatus;
	}

	public void setMemberStatus(int memberStatus) {
		this.memberStatus = memberStatus;
	}

	public String getMemberCity() {
		return memberCity;
	}

	public void setMemberCity(String memberCity) {
		this.memberCity = memberCity;
	}

	public String getMemberRegion() {
		return memberRegion;
	}

	public void setMemberRegion(String memberRegion) {
		this.memberRegion = memberRegion;
	}

	public String getMemberLocation() {
		return memberLocation;
	}

	public void setMemberLocation(String memberLocation) {
		this.memberLocation = memberLocation;
	}

	public Date getLastmodified() {
		return lastmodified;
	}

	public void setLastmodified(Date lastmodified) {
		this.lastmodified = lastmodified;
	}

	public String getBirthDay() {
		return birthDay;
	}

	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}

	public String getBirthMonth() {
		return birthMonth;
	}

	public void setBirthMonth(String birthMonth) {
		this.birthMonth = birthMonth;
	}

	public String getBirthYear() {
		return birthYear;
	}

	public void setBirthYear(String birthYear) {
		this.birthYear = birthYear;
	}

	@Override
	public String toString() {
		return "MemberDTO [memberNo=" + memberNo + ", memberName=" + memberName + ", memberPhone=" + memberPhone
				+ ", memberId=" + memberId + ", memberPw=" + memberPw + ", memberEmail=" + memberEmail + ", nickname="
				+ nickname + ", memberGender=" + memberGender + ", regdate=" + regdate + ", memberOutdate="
				+ memberOutdate + ", memberStatus=" + memberStatus + ", memberCity=" + memberCity + ", memberRegion="
				+ memberRegion + ", memberLocation=" + memberLocation + ", lastmodified=" + lastmodified + ", birthDay="
				+ birthDay + ", birthMonth=" + birthMonth + ", birthYear=" + birthYear + "]";
	}
	
	
}
