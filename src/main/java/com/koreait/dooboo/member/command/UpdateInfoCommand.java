package com.koreait.dooboo.member.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.member.dto.MemberDTO;

// 개인정보를 수정합니다
public class UpdateInfoCommand implements MemberCommand{
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		// Session
		HttpSession session = ((HttpServletRequest)model.asMap().get("request")).getSession();
		
		// 수정할 정보가 담긴 회원
		MemberDTO memberDTO = (MemberDTO)model.asMap().get("memberDTO");
		
		// 세션에 올라가 있는 회원번호
		
		MemberDTO loginUser = (MemberDTO)session.getAttribute("loginUser");
		
		long memberNo = loginUser.getMemberNo();
		
		
		
		
		
	}
}
