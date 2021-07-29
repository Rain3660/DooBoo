package com.koreait.dooboo.member.command;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;

import com.koreait.dooboo.map.dao.MapDAO;
import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.map.dto.MapSessionDTO;
import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;
import com.koreait.dooboo.util.GetMidLocation;
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
		int apiNumber = memberDTO.getApiNumber();
		if(apiNumber == 0) {
			String orgPw = memberDTO.getPassword();		
			String password = SecurityUtils.encodeBase64(orgPw);
			memberDTO.setPassword(password);			
		}
		
		PrintWriter out = null;
		MemberDTO loginUser = sqlSession.getMapper(MemberDAO.class).login(memberDTO);
		
	
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
					MapSessionDTO mapSessionDTO = null;
					String midLocation = GetMidLocation.getMidLocation(map.getLocation());
					if(result > 0) {
						mapSessionDTO = new MapSessionDTO(mapNo, loginUserNo, midLocation, map.getLocationOrd(), result ,1);
						//지역이 1개있고 인증까지 되었다는 이야기는 선호지역이라는 의미
						session.setAttribute("mapSession"+mapSessionDTO.getLocationOrd()+"DTO", mapSessionDTO);
						message = "로그인 성공!";
						view="index";
					}else {
						mapSessionDTO = new MapSessionDTO(mapNo, loginUserNo, midLocation, map.getLocationOrd(), result , 0);
						session.setAttribute("mapSession"+mapSessionDTO.getLocationOrd()+"DTO", mapSessionDTO);
						message = "지역인증을 하셔야 원활한 거래가 가능합니다 인증하시겠습니까?(확인시 인증페이지로 이동)";
						view="m.mapCheckLocationPage?firstVisit=1";
					}
				}else {
					MapDTO map1 = list.get(0);
					MapDTO map2 = list.get(1);
					long map1No = map1.getMapNo();
					long map2No = map2.getMapNo();
					int result1 = mapDAO.isChecked(map1No);
					int result2 = mapDAO.isChecked(map2No);
					int useNow1 = mapDAO.getUseNow(map1No);
					int useNow2 = mapDAO.getUseNow(map2No);
					MapSessionDTO mapSession1DTO = new MapSessionDTO(map1No, loginUserNo, map1.getLocation(), map1.getLocationOrd(), result1,useNow1);
					MapSessionDTO mapSession2DTO = new MapSessionDTO(map2No, loginUserNo, map2.getLocation(), map2.getLocationOrd(), result2,useNow2);
					session.setAttribute("mapSession"+mapSession1DTO.getLocationOrd()+"DTO", mapSession1DTO);
					session.setAttribute("mapSession"+mapSession2DTO.getLocationOrd()+"DTO", mapSession2DTO);
					
					
					if(result1 > 0 && result2 > 0){
						String midLocation1 = GetMidLocation.getMidLocation(map1.getLocation());
						String midLocation2 =GetMidLocation.getMidLocation(map2.getLocation());
						mapSession1DTO.setLocation(midLocation1);
						mapSession2DTO.setLocation(midLocation2);
						session.setAttribute("mapSession"+mapSession1DTO.getLocationOrd()+"DTO", mapSession1DTO);
						session.setAttribute("mapSession"+mapSession2DTO.getLocationOrd()+"DTO", mapSession2DTO);
						message = "로그인 성공!";
						view="index";
					}else if(result1 > 0) {
						String midLocation1 = GetMidLocation.getMidLocation(map1.getLocation());
						mapSession1DTO.setLocation(midLocation1);
						session.setAttribute("mapSession"+mapSession1DTO.getLocationOrd()+"DTO", mapSession1DTO);
						message = "로그인 성공!";
						view="index";
					}else if(result2 > 0){
						String midLocation2 =GetMidLocation.getMidLocation(map2.getLocation());
						mapSession2DTO.setLocation(midLocation2);
						session.setAttribute("mapSession"+mapSession2DTO.getLocationOrd()+"DTO", mapSession2DTO);
						message = "로그인 성공!";
						view="index";
					}else{
						message = "지역인증을 하셔야 원활한 거래가 가능합니다 인증하시겠습니까?(확인시 인증페이지로 이동)";
						view="m.mapCheckLocationPage?firstVisit=1";
					}
				}		
				
				session.setAttribute("loginUser", loginUser);
				// 최근 본 게시물의 번호를 저장할 arrayList
				session.setAttribute("recentlyViewProductNo", new ArrayList<Long>());
				out.println("<script>");
				out.println("if(confirm('"+message+"')){");
				out.println("location.href='"+view+"'}else{location.href='m.logout'}");
				out.println("</script>");				
			}else{
				out.println("<script>");
				out.println("confirm('정보에 맞는 회원이 없습니다 , 다시 로그인 해주세요')");
				out.println("location.href='m.loginPage'");
				out.println("</script>");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			out.flush();
			out.close();
		}
	}
}
