package com.koreait.dooboo.member.command;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;

import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;
import com.koreait.dooboo.util.SecurityUtils;

public class LoginCommand implements MemberCommand {
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		// response , request , session
		HttpServletResponse response = (HttpServletResponse)model.asMap().get("response");
		HttpServletRequest request = (HttpServletRequest)model.asMap().get("request");
		HttpSession session = request.getSession();
		
		// 로그인 시도한 아이디
		MemberDTO memberDTO = (MemberDTO) model.asMap().get("memberDTO");
		
		// 비밀번호 암호화
		String orgPw = memberDTO.getPassword();


		String password = SecurityUtils.encodeBase64(orgPw);
		memberDTO.setPassword(password);
		
		PrintWriter out = null;
		MemberDTO loginUser = sqlSession.getMapper(MemberDAO.class).login(memberDTO);
		
		try {
			out = response.getWriter();
			response.setContentType("text/html; charset=utf-8");
			if(loginUser != null) { // 로그인 성공
				session.setAttribute("loginUser", loginUser);
				out.println("<script>");
				out.println("alert('로그인 성공.')");
				out.println("location.href='index'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('정보에 맞는 회원이 없습니다 , 다시 로그인 해주세요')");
				out.println("location.href='m.loginPage'");
				out.println("</script>");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			out.flush();
			out.close();
		}
	}
}
