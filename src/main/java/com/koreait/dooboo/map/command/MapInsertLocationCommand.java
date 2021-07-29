package com.koreait.dooboo.map.command;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.map.dao.MapDAO;
import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.map.dto.MapLocationCheckDTO;
import com.koreait.dooboo.map.dto.MapSessionDTO;
import com.koreait.dooboo.util.GetMidLocation;

public class MapInsertLocationCommand {

	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		MapSessionDTO mapSessionDTO = (MapSessionDTO) map.get("mapSessionDTO"); //session에 필요한 컬럼들만 모은 dto
		HttpSession session = request.getSession(); //세션에 등록하기위해 준비
		Map<String, Object> resultMap = new HashMap<String,Object>(); //ajax에 반환을 위해 만든 HashMap
		MapDAO mapDAO = sqlSession.getMapper(MapDAO.class);//DB에 저장하기 위해 만든 DAO
		long memberNo = mapSessionDTO.getMemberNo(); //어떤 클라이언트에 저장할지 알수있는 회원의 기본키		
		String location = mapSessionDTO.getLocation();//새로 저장할 location
		MapDTO mapDTO = new MapDTO(memberNo, location); //생성자로 만들어둔곳에 넣어준다	
		mapDTO.setLocationOrd(mapSessionDTO.getLocationOrd());
		int result1 = mapDAO.insertLocation(mapDTO); //DB에 저장해준다
		int result2 = 0;
		long mapNo = mapDAO.getMapNo(mapDTO); //인증유무 DTO를 만들어 0으로 저장해준다
		int usenowCount = mapDAO.didntUseNowYet(mapSessionDTO.getMemberNo());
		if(location.length() > 5) {
			if(result1 > 0 && usenowCount > 0) {
				MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO(mapNo, 1);
				result2 = mapDAO.CheckLocation(mapLocationCheckDTO); //DB에 저장한다
				if(result2 > 0) { // 저장에 성공하였다면 세션에 저장
					mapSessionDTO.setIsChecked(1);
					mapSessionDTO.setMapNo(mapNo);
					mapSessionDTO.setLocation(GetMidLocation.getMidLocation(mapSessionDTO.getLocation()));//인증이 끝난 지역은 풀 주소를 DB에 저장해두고 클라이언트에게는 '구'만 보여준다
					session.setAttribute("mapSession"+mapSessionDTO.getLocationOrd()+"DTO", mapSessionDTO);//세션에 등록
				}
			}else if(result1 > 0 && usenowCount == 0) {
				MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO(mapNo, 1);
				mapLocationCheckDTO.setUsenow(1);
				result2 = mapDAO.CheckLocation(mapLocationCheckDTO); //DB에 저장한다
				if(result2 > 0) { // 저장에 성공하였다면 세션에 저장
					mapSessionDTO.setIsChecked(1);
					mapSessionDTO.setMapNo(mapNo);
					mapSessionDTO.setUsenow(1);
					mapDAO.updateUseNow(mapLocationCheckDTO);
					mapSessionDTO.setLocation(GetMidLocation.getMidLocation(mapSessionDTO.getLocation()));//인증이 끝난 지역은 풀 주소를 DB에 저장해두고 클라이언트에게는 '구'만 보여준다
					session.setAttribute("mapSession"+mapSessionDTO.getLocationOrd()+"DTO", mapSessionDTO);//세션에 등록
				}
			}
		}else {
			if(result1 > 0) { //DB에 저장이 됬다면 
				MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO(mapNo, 0);
				result2 = mapDAO.CheckLocation(mapLocationCheckDTO); //DB에 저장한다
				if(result2 > 0) { // 저장에 성공하였다면 세션에 저장
					mapSessionDTO.setIsChecked(0);
					mapSessionDTO.setMapNo(mapNo);
					session.setAttribute("mapSession"+mapSessionDTO.getLocationOrd()+"DTO", mapSessionDTO);
				}
			}			
		}
		
		resultMap.put("result", result2);//모든것이 정상작동하였다면 ajax의 반환을 위해 반환값 저장	
		return resultMap;
	}

}
