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

public class UpdateContactCommand implements MemberCommand {
	@Override
	public void execute(SqlSession sqlSession, Model model) {

		// Request , Session , Response 등 넘어온 정보들

		HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
		HttpSession session = request.getSession();
		HttpServletResponse response = (HttpServletResponse) model.asMap().get("response");
		String phone = request.getParameter("phone");
		String city = request.getParameter("city");
		String region = request.getParameter("region");
		String location = request.getParameter("location");
		
		// session에 저장된 로그인 정보
		MemberDTO loginUser = (MemberDTO)session.getAttribute("loginUser");
		long memberNo = loginUser.getMemberNo();
		
		// DB 수정
		int result = sqlSession.getMapper(MemberDAO.class).updateContact(phone ,city, region, location, memberNo);
		
		PrintWriter out = null;
		response.setContentType("text/html; chatset=utf-8"); 
		
		try {
			out = response.getWriter();
			if(result > 0) {// 수정 됨
				loginUser.setPhone(phone);
				loginUser.setCity(city);
				loginUser.setRegion(region);
				loginUser.setLocation(location);
				
				out.println("<script>");
				out.println("alert('연락처와 주소를 수정하였습니다.')");
				out.println("location.href='m.myPage'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('연락처와 주소 수정에 실패하였습니다.')");
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
