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
	

}
