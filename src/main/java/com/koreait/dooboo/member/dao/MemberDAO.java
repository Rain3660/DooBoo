package com.koreait.dooboo.member.dao;

import com.koreait.dooboo.member.dto.MemberDTO;

public interface MemberDAO {
	// 회원가입
	public int join(MemberDTO memberDTO);
	// 로그인
	public MemberDTO login(MemberDTO memberDTO);
	// 개인정보 수정
	public int updateInfo(MemberDTO memberDTO);
	//회원탈퇴
	public int delete(long no);
	
}
