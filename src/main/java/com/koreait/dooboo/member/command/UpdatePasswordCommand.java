package com.koreait.dooboo.member.command;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;
import com.koreait.dooboo.util.SecurityUtils;

public class UpdatePasswordCommand implements MemberCommand{
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		// Request , Session , Response
		
		HttpServletRequest request = (HttpServletRequest)model.asMap().get("request");
		HttpSession session = request.getSession();
		HttpServletResponse response = (HttpServletResponse)model.asMap().get("response");
		
		
		
		// 변경할 비밀번호
		String password = request.getParameter("password");
		// 비밀번호를 변경할 회원, 회원번호
		MemberDTO loginUser = (MemberDTO)session.getAttribute("loginUser");
		long memberNo = loginUser.getMemberNo();
		
		// 비밀번호의 암호화
		String encPassword = SecurityUtils.encodeBase64(password);
		
		int result = sqlSession.getMapper(MemberDAO.class).updatePassword(encPassword, memberNo);
		
		PrintWriter out = null;
		response.setContentType("text/html; chatset=utf-8"); 
		
		try {
			out = response.getWriter();
			if(result > 0) {// 수정 됨
				loginUser.setPassword(encPassword);
				out.println("<script>");
				out.println("alert('비밀번호를 수정하였습니다.')");
				out.println("location.href='m.myPage'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('비밀번호 수정에 실패하였습니다.')");
				out.println("location.href='m.myPage'");
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
