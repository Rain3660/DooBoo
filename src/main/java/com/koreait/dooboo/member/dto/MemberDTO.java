package com.koreait.dooboo.member.dto;

import java.sql.Date;

public class MemberDTO {

	// 회원번호 1000부터 시작
	private long memberNo;

	// 이름
	private String name;

	// 연락처
	private String phone;

	// 아이디
	private String memberId;

	// 비밀번호
	private String password;

	// 이메일
	private String email;

	// 닉네임
	private String nickname;

	// 성별
	private String gender;



	// 가입일자
	private Date regdate;

	// 탈퇴날짜
	private Date outdate;

	// 회원상태 탈퇴 여부
	private int status;

	// 주소(시) ex)서울특별시
	private String city;

	// 주소(구) ex)마포구
	private String region;

	// 상세주소 ex)서강로136 3층
	private String location;

	// 생일 문자열입니다
	private String birthday;

	// 수정일
	private Date modDate;
	
	private String apiMemberNo;
	
	private int apiNumber;
	
	
	


	public String getApiMemberNo() {
		return apiMemberNo;
	}

	public void setApiMemberNo(String apiMemberNo) {
		this.apiMemberNo = apiMemberNo;
	}

	public int getApiNumber() {
		return apiNumber;
	}

	public void setApiNumber(int apiNumber) {
		this.apiNumber = apiNumber;
	}

	public MemberDTO() {
		// TODO Auto-generated constructor stub
	}

	public long getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getOutdate() {
		return outdate;
	}

	public void setOutdate(Date outdate) {
		this.outdate = outdate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public Date getModDate() {
		return modDate;
	}

	public void setModDate(Date modDate) {
		this.modDate = modDate;
	}

	@Override
	public String toString() {
		return "MemberDTO [memberNo=" + memberNo + ", name=" + name + ", phone=" + phone + ", memberId=" + memberId
				+ ", password=" + password + ", email=" + email + ", nickname=" + nickname + ", gender=" + gender
				+ ", regdate=" + regdate + ", outdate=" + outdate + ", status=" + status + ", city=" + city
				+ ", region=" + region + ", location=" + location + ", birthday=" + birthday + ", modDate=" + modDate
				+ ", apiMemberNo=" + apiMemberNo + ", apiNumber=" + apiNumber + "]";
	}


	
	
	

	
}
