package com.koreait.dooboo.map.command;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.map.dao.MapDAO;
import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.map.dto.MapLocationCheckDTO;

public class ChangeLocationCommand {


	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String location = request.getParameter("location");
		long mapNo = Long.parseLong(request.getParameter("mapNo"));
		long memerNo = Long.parseLong(request.getParameter("memberNo"));//필요없으면 지워도됨
		int locationNo = Integer.parseInt(request.getParameter("locationNo"));
		MapDTO mapDTO = new MapDTO();
		mapDTO.setLocation(location);
		mapDTO.setMapNo(mapNo);
		//인증초기화시켜야함
		MapDAO mapDAO = sqlSession.getMapper(MapDAO.class);
		int result = mapDAO.changelocation(mapDTO);
		int result2 = 0;
		int resultForMap = 0;
		if(result > 0) {
			MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO(mapNo, 0);
			 result2 = mapDAO.mapUpdateResult(mapLocationCheckDTO);
			if(result2 > 0) {
				MapDTO mapDTO1 = mapDAO.getOneLocation(mapNo);
				session.setAttribute("location"+locationNo, mapDTO1);
				resultForMap = 1;
				session.removeAttribute("location"+locationNo+"IsChecked");
			}
		}
		
		resultMap.put("result", resultForMap);
		return resultMap;
	}

}
