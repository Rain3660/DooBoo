package com.koreait.dooboo.member.command;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;
import com.koreait.dooboo.util.SecurityUtils;

public class JoinCommand implements MemberCommand{
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		// response
		HttpServletResponse response = (HttpServletResponse)model.asMap().get("response");
		// 회원가입시 작성한 개인정보들이 들어있다.
		MemberDTO newMember = (MemberDTO)model.asMap().get("memberDTO");
		// 초기 작성한 비밀번호
		String orgPw = newMember.getPassword();
		// 비밀번호의 암호화 작업
		String password = SecurityUtils.encodeBase64(orgPw);		
		newMember.setPassword(password);
		// 회원가입
		int result = sqlSession.getMapper(MemberDAO.class).join(newMember);
		PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8"); 
		
		try {
			out = response.getWriter();
			if(result > 0) { // 가입성공
				out.println("<script>");
				out.println("alert('가입에 성공하였습니다 , 로그인 페이지로 이동합니다.')");
				out.println("location.href='m.loginPage'");
				out.println("</script>");
			}else { // 여기까지 안오게 스크립트 작업으로 막을거임
				out.println("<script>");
				out.println("alert('가입에 실패하였습니다 , 회원가입 페이지로 이동합니다.')");
				out.println("location.href='m.joinPage'");
				out.println("</script>");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
