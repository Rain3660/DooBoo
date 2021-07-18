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
import com.koreait.dooboo.map.dto.MapSessionDTO;

public class MapCheckLocationCommand {

	
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();
		Long mapno = Long.parseLong(request.getParameter("mapno"));
		MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO(mapno, 1);
		MapDAO mapDAO = sqlSession.getMapper(MapDAO.class);
		int result = mapDAO.mapUpdateResult(mapLocationCheckDTO); //1로바꿈
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
		if(result > 0) {
			resultMap.put("result", result);			
		}
		
		long memberNo = Long.parseLong(request.getParameter("memberNo")); //멤버기본키를받아온다
		List<MapDTO> maps = mapDAO.getLocation(memberNo); //멤버기본키가 포함된 map들을 list로 가져온다
		if(maps.size() == 1) { //거래지역을 1개 또는 2개로 정할수있기때문에 size로 걸러준다
			MapDTO location = maps.get(0);  //맵을 꺼낸다 (어느지역인지 알기위해)ex)마포구인지 은평구인지
			String locationName = location.getLocation(); //locationName 변수에 저장
			long mapNo = location.getMapNo(); //맵의 고유번호를 꺼낸다
			int checked = mapDAO.isChecked(mapNo); //맵의 고유번호가 포함된 maplocationCheck 테이블을 찾아 인증유무(result)를 꺼낸다
			MapSessionDTO mapSessionDTO = new MapSessionDTO(locationName, memberNo, mapNo, checked); //세션용 dto를 만들어 저장하고 세션에 올린다
			session.setAttribute("mapSessionDTO", mapSessionDTO);
		}else if(maps.size()==2) {
			
			MapDTO location1 = maps.get(0);
			String location1Name = location1.getLocation();
			long map1No = location1.getMapNo();
			int checked1 = mapDAO.isChecked(map1No);
			MapSessionDTO mapSessionDTO1 = new MapSessionDTO(location1Name, memberNo, map1No, checked1);
			session.setAttribute("mapSessionDTO1", mapSessionDTO1);
			
			MapDTO location2 = maps.get(1);
			String location2Name = location2.getLocation();
			long map2No = location2.getMapNo();
			int checked2 = mapDAO.isChecked(map2No);
			MapSessionDTO mapSessionDTO2 = new MapSessionDTO(location2Name, memberNo, map2No, checked2);	
			session.setAttribute("mapSessionDTO2", mapSessionDTO2);
		}
		
		
		
		
		
		return resultMap;
	}

}
