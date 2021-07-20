package com.koreait.dooboo.map.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.map.dao.MapDAO;
import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.map.dto.MapLocationCheckDTO;
import com.koreait.dooboo.map.dto.MapSessionDTO;
import com.koreait.dooboo.member.command.MemberCommand;

public class FirstInsertLocationCommand implements MemberCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request"); //파라미터를 받아오기위해 request를 받는다
		MapDAO mapDAO = sqlSession.getMapper(MapDAO.class);//DB저장을 위해 DAO호출
		HttpSession session = request.getSession();
		long memberNo = Long.parseLong(request.getParameter("memberNo")); //어떤 클라이언트의 맵에 저장하는지 알기위해 클라이언트의 기본키를 받아온다
		String location1 = request.getParameter("location1"); //지역 1번을 받아온다
		String location2 = request.getParameter("location2"); //지역2번을 받아온다.
		if(location1 != null) {
			MapDTO mapDTO1 = new MapDTO(); //DB에 저장하기위해 DTO에 미리저장
			mapDTO1.setMemberNo(memberNo);//mapNo를 구하기위해 memberNo도 DTO에 저장시켜준다
			mapDTO1.setLocation(location1); //map의 저장과 locationCheck테이블에서 mapNo를 구하기위해 추가시켜준다
			mapDTO1.setLocationOrd(1); //순서를 미리 저장
			int result1 = mapDAO.insertLocation(mapDTO1); //지역1을 DB에 저장
			if(result1 > 0) { //저장이 잘 되었다면
				long mapNo = mapDAO.getMapNo(mapDTO1);  
				MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO(mapNo, 0); //지역 인증유무 추가 아직 인증전이기 때문에 0 이다.
				int result2 = mapDAO.CheckLocation(mapLocationCheckDTO);
					if(result2 > 0) { //지역인증유무에 저장이 잘되었다면
						MapSessionDTO mapSessionDTO = new MapSessionDTO(mapNo, memberNo, location1, 1, 0);
						session.setAttribute("mapSession"+mapSessionDTO.getLocationOrd()+"DTO", mapSessionDTO);
					}
				
			}
			
		}
		if(location2 != null) {
			MapDTO mapDTO2 = new MapDTO();
			mapDTO2.setMemberNo(memberNo);//mapNo를 구하기위해 memberNo도 DTO에 저장시켜준다
			mapDTO2.setLocation(location2);
			mapDTO2.setLocationOrd(2);
			int result1 = mapDAO.insertLocation(mapDTO2); //지역2를 DB에 저장
			if(result1 > 0) {//저장이 잘 되었다면
				long mapNo = mapDAO.getMapNo(mapDTO2);  
				MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO(mapNo, 0); //지역 인증유무 추가 아직 인증전이기 때문에 0 이다.
				int result2 = mapDAO.CheckLocation(mapLocationCheckDTO);
					if(result2 > 0) { //지역인증유무에 저장이 잘되었다면
						MapSessionDTO mapSessionDTO = new MapSessionDTO(mapNo, memberNo, location2, 2, 0);						
						session.setAttribute("mapSession"+mapSessionDTO.getLocationOrd()+"DTO", mapSessionDTO);
					}
			}
		}
		session.setAttribute("firstVisit", 1);
		
	}

}
