package com.koreait.dooboo.member.command;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;

import com.koreait.dooboo.map.dao.MapDAO;
import com.koreait.dooboo.map.dto.MapDTO;
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
		System.out.println("적은아이디: "+memberDTO.getMemberId());
		System.out.println("적은비밀번호: "+memberDTO.getPassword());
		// 비밀번호 암호화
		int apiNumber = memberDTO.getApiNumber();
		System.out.println(apiNumber);
		if(apiNumber == 0) {
			String orgPw = memberDTO.getPassword();		
			String password = SecurityUtils.encodeBase64(orgPw);
			memberDTO.setPassword(password);			
		}
		
		PrintWriter out = null;
		MemberDTO loginUser = sqlSession.getMapper(MemberDAO.class).login(memberDTO);
		System.out.println("확인된 아이디: "+loginUser.getMemberId());
		System.out.println("확인된 회원번호 : "+loginUser.getMemberNo());
		
	
		try {
			out = response.getWriter();
			response.setContentType("text/html; charset=utf-8");
			String message = "";
			if(loginUser != null) { // 로그인 성공
				long loginUserNo = loginUser.getMemberNo();
				MapDAO mapDAO = sqlSession.getMapper(MapDAO.class);
				String view = "";
				List<MapDTO> list = mapDAO.getLocation(loginUserNo);
				if(list.size() == 0) {
					view = "m.mapInsertLocationPage";
					message = "지역을 선택하셔야 원활한 거래가 가능합니다 지정페이지로 이동하시겠습니까?(확인시 지정페이지로 이동)";
				}else if(list.size() == 1) {
					MapDTO map = list.get(0);
					long mapNo = map.getMapNo();
					int result = mapDAO.isChecked(mapNo);
					if(result > 0) {
						message = "로그인 성공!";
						view="index";
					}else {
						message = "지역인증을 하셔야 원활한 거래가 가능합니다 인증하시겠습니까?(확인시 인증페이지로 이동)";
						view="m.mapChecklocationPage";
					}
				}else {
					MapDTO map1 = list.get(0);
					MapDTO map2 = list.get(1);
					long map1No = map1.getMapNo();
					long map2No = map2.getMapNo();
					int result1 = mapDAO.isChecked(map1No);
					int result2 = mapDAO.isChecked(map2No);
					if(result1 > 0 || result2 > 0) {
						message = "로그인 성공!";
						view="index";
					}else {
						message = "지역인증을 하셔야 원활한 거래가 가능합니다 인증하시겠습니까?(확인시 인증페이지로 이동)";
						view="m.mapCheckLocationPage";
					}
				}
				System.out.println(view);			
				System.out.println(message);			
				session.setAttribute("loginUser", loginUser);
				out.println("<script>");
				out.println("confirm('"+message+"')");
				out.println("location.href='"+view+"'");
				out.println("</script>");				
			}else{
				out.println("<script>");
				out.println("confirm('정보에 맞는 회원이 없습니다 , 다시 로그인 해주세요')");
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
