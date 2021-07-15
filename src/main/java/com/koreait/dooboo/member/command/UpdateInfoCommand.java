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

// 개인정보(이름 , 닉네임)를 수정합니다
public class UpdateInfoCommand implements MemberCommand{
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		// Session , response , request
		HttpSession session = ((HttpServletRequest)model.asMap().get("request")).getSession();
		HttpServletResponse response = (HttpServletResponse)model.asMap().get("response");
		
		
		// 수정할 정보가 담김 회원
		MemberDTO memberDTO = (MemberDTO)model.asMap().get("memberDTO");
		
		String name = memberDTO.getName();
		String nickname = memberDTO.getNickname();
		// 세션에 올라가 있는 회원 , 회원번호
		MemberDTO loginUser = (MemberDTO)session.getAttribute("loginUser");		
		long memberNo = loginUser.getMemberNo();
		
		// 수정 하고,
		int result = sqlSession.getMapper(MemberDAO.class).updateInfo(name , nickname , memberNo);
		
		PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		
		try {
			out = response.getWriter();
			
			if(result >0) { // 수정 성공하면
				loginUser.setName(name);
				loginUser.setNickname(nickname);
				out.println("<script>");
				out.println("alert('개인정보를 수정하였습니다.')");
				out.println("location.href='m.myPage'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('개인정보 수정에 실패했습니다.')");
				out.println("location.href='m.myPage'");
				out.println("</script>");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
