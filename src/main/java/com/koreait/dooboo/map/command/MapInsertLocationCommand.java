package com.koreait.dooboo.map.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.map.dao.MapDAO;
import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.map.dto.MapLocationCheckDTO;
import com.koreait.dooboo.member.command.MemberCommand;

public class MapInsertLocationCommand implements MemberCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();
		String location1 = request.getParameter("location1");
		String location2 = request.getParameter("location2");
		System.out.println(location1);
		System.out.println(location2);
		long memberNo = Long.parseLong(request.getParameter("memberNo"));
		MapDTO mapDTO1 = new MapDTO(memberNo, location1);
		MapDTO mapDTO2 = null;
		if(location2!= null) {
			mapDTO2 = new MapDTO(memberNo, location2);			
		}
		
		MapDAO mapDAO = sqlSession.getMapper(MapDAO.class);
		long mapno1 = 0;
		long mapno2 = 0;
		int result1 = mapDAO.insertLocation(mapDTO1);
		if(result1 > 0) {
			mapno1 = mapDAO.getMapNo(mapDTO1);
			System.out.println("mapno1: "+mapno1);
			mapDTO1.setMapNo(mapno1);
		}
		
		int result2 = 0;
		if(mapDTO2!= null) {
			result2 = mapDAO.insertLocation(mapDTO2);
			if(result2 > 0) {
				mapno2 = mapDAO.getMapNo(mapDTO2);
				System.out.println("mapno2: "+mapno2);
				mapDTO2.setMapNo(mapno2);
			}
		}
		if(mapno1 > 0) {
			MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO();
			mapLocationCheckDTO.setMapNo(mapno1);
			mapLocationCheckDTO.setResult(0);
			mapDAO.CheckLocation(mapLocationCheckDTO);
			session.setAttribute("location1", mapDTO1);
		}
		if(mapno2 > 0) {
			MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO();
			mapLocationCheckDTO.setMapNo(mapno2);
			mapLocationCheckDTO.setResult(0);
			mapDAO.CheckLocation(mapLocationCheckDTO);
			session.setAttribute("location2", mapDTO2);
		}
		System.out.println(mapDTO1);
		System.out.println(mapDTO2);
		
		
		
	}

}
