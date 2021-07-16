package com.koreait.dooboo.map.command;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.map.dao.MapDAO;
import com.koreait.dooboo.map.dto.MapLocationCheckDTO;

public class MapCheckLocationCommand {

	
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		Long mapno = Long.parseLong(request.getParameter("mapno"));
		
		MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO(mapno, 1);
		MapDAO mapDAO = sqlSession.getMapper(MapDAO.class);
		int result = mapDAO.mapUpdateResult(mapLocationCheckDTO);
		Map<String, Object> resultMap = new HashMap<String,Object>();
		if(result > 0) {
			resultMap.put("result", result);			
		}
		System.out.println("결과"+result);
		return resultMap;
	}

}
