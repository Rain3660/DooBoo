package com.koreait.dooboo.member.dao;

import com.koreait.dooboo.member.dto.MemberDTO;

public interface MemberDAO {
	// 회원가입
	public int join(MemberDTO memberDTO);
	// 로그인
	public MemberDTO login(MemberDTO memberDTO);
	// 개인정보 수정
	public int updateInfo(String name , String nickname , long memberNo);
	//회원탈퇴
	public int delete(long no);

	//회원번호에 해당하는 멤버 선택
	public MemberDTO selectMemberByMemberNo(long memberNo);

	
	public MemberDTO apiLoginCheck(MemberDTO memberDTO);
	
	public int updatePassword(String password , long memberNo);
	public int updateContact(String phone , String address , long memberNo);
	
	// 아이디 찾기
	public MemberDTO findIdByEmailAndName(MemberDTO memberDTO);
	
	// 비밀번호 찾기
	public MemberDTO selectMemberByEmailAndId(MemberDTO memberDTO);
	
	// 아이디 존재 여부 조회
	public int searchByMemberId(String memberId);
	
	// 로그인 유저의 지역 인증 조회
	public String locationCheckTest(long memberNo);
}
