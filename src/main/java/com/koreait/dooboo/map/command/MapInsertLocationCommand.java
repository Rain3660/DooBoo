package com.koreait.dooboo.map.command;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
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
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		HttpSession session = request.getSession();
		String location1 = request.getParameter("location1");
		System.out.println("1번지역"+location1);
		String location2 = request.getParameter("location2");
		System.out.println("2번지역"+location2);
		int nowLocation = Integer.parseInt(request.getParameter("nowLocation"));
		System.out.println("들어왔니?:"+nowLocation);
		long memberNo = Long.parseLong(request.getParameter("memberNo"));
		MapDAO mapDAO = sqlSession.getMapper(MapDAO.class);
		long mapno1 = 0;
		long mapno2 = 0;
		MapDTO mapDTO1 = null;
		MapDTO mapDTO2 = null;
		int result1 = 0;
		int result2 = 0;
		if(location1 != null) {
			mapDTO1 = new MapDTO(memberNo, location1);
			 result1 = mapDAO.insertLocation(mapDTO1);
			if(result1 > 0) {
				mapno1 = mapDAO.getMapNo(mapDTO1);
				mapDTO1.setMapNo(mapno1);
				if(mapno1 > 0) {
					MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO();
					mapLocationCheckDTO.setMapNo(mapno1);
					mapLocationCheckDTO.setResult(0);
					mapDAO.CheckLocation(mapLocationCheckDTO);
					session.setAttribute("location1", mapDTO1);
					if(nowLocation > 0) {
						mapLocationCheckDTO.setMapNo(mapno1);
						mapLocationCheckDTO.setResult(1);
						mapDAO.mapUpdateResult(mapLocationCheckDTO);
						session.setAttribute("location1IsChecked", 1);
					}
				}
			}
			
		}
		if(location2!= null) {
			mapDTO2 = new MapDTO(memberNo, location2);			
			result2 = mapDAO.insertLocation(mapDTO2);
			if(result2 > 0) {
				mapno2 = mapDAO.getMapNo(mapDTO2);
				mapDTO2.setMapNo(mapno2);
				if(mapno2 > 0) {
					MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO();
					mapLocationCheckDTO.setMapNo(mapno2);
					mapLocationCheckDTO.setResult(0);
					mapDAO.CheckLocation(mapLocationCheckDTO);
					session.setAttribute("location2", mapDTO2);
					if(nowLocation > 0) {
						mapLocationCheckDTO.setMapNo(mapno2);
						mapLocationCheckDTO.setResult(1);
						mapDAO.mapUpdateResult(mapLocationCheckDTO);
						session.setAttribute("location2IsChecked", 1);
					}
				}
			}
		}
		int ajax = Integer.parseInt(request.getParameter("ajax"));
		if(ajax == 1) {		
			JSONObject resultMap = new JSONObject();
			int result = 0;
			if(result1 == 1 || result2 == 1) {
				result = 1;
			}
			
			try {
			resultMap.put("result", result);
			response.setContentType("application/json; charset=utf-8");
			PrintWriter out;
			out = response.getWriter();
			out.println(resultMap);
			out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
	}

}
