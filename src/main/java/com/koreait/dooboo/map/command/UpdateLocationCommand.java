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
import com.koreait.dooboo.util.GetMidLocation;
 //끝
public class UpdateLocationCommand {


	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		MapSessionDTO mapSessionDTO = (MapSessionDTO) map.get("mapSessionDTO"); //session에 필요한 컬럼들만 모은 dto
		HttpSession session = request.getSession(); //세션에 등록하기위해 준비
		Map<String, Object> resultMap = new HashMap<String,Object>(); //ajax에 반환을 위해 만든 HashMap
		
		long mapNo = mapSessionDTO.getMapNo();//mapSessionDTO에서 받아온 mapNo
		int locationOrd = mapSessionDTO.getLocationOrd(); //몇번째 지역인지 알기위해 mapSessionDTO에서 꺼낸다
		String location = mapSessionDTO.getLocation();//mapSessionDTO에서 받아온 location
		MapDTO mapDTO = new MapDTO();
		MapDAO mapDAO = sqlSession.getMapper(MapDAO.class);
		int result2 = 0;
		mapDTO.setLocation(location);//불러온 지역을 업데이트하기휘해 mapDTO에 저장한다
		mapDTO.setMapNo(mapNo); //어떤 map의 업데이트인지 알기위해 필요한 map기본키
		int result = mapDAO.updateLocation(mapDTO); // location의 업데이트를 진행한다.
		
		if(location.length() > 5) {//location이 5이상이라는것은 현재주소를 가져와 인증까지 완료 해야한다는 뜻
			location = GetMidLocation.getMidLocation(location);
			if(result > 0) {
				MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO(mapNo, 1);//업데이트된 지역은 현재지역으로 수정하여 인증이 이미 된 상태이기 때문에 mapLocationCheck 테이블도  1로 업데이트 시켜준다
				result2 = mapDAO.mapUpdateResult(mapLocationCheckDTO); // 인증유무 업데이트까지 확인
				if(result2 > 0) {
					mapSessionDTO.setIsChecked(1);//업데이트된 지역은 인증이 된상태이기때문에 dto를 수정해준다 세션업데이트임
					mapSessionDTO.setLocation(GetMidLocation.getMidLocation(mapSessionDTO.getLocation()));//인증이 끝난 지역은 풀 주소를 DB에 저장해두고 클라이언트에게는 '구'만 보여준다
					session.setAttribute("mapSession"+mapSessionDTO.getLocationOrd()+"DTO",mapSessionDTO); //LocationOrd를 통해 순서를 부여해준후 세션에 올려준다.
				}
			}
		}else {
			if(result > 0) { //업데이트가 진행이 잘되었다면
				MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO(mapNo, 0);//업데이트 된 새로운 지역은 인증이 안된상태이기 때문에 mapLocationCheck 테이블도 0 으로 업데이트 시켜준다
				result2 = mapDAO.mapUpdateResult(mapLocationCheckDTO); // 인증유무 업데이트까지 확인
				if(result2 > 0) { //인증유무 업데이트가 잘 됬다하면 세션에 올려줄 준비를한다.
					mapSessionDTO.setIsChecked(0); //업데이트된 지역은 인증이 안된상태이기때문에 dto를 수정해준다
					session.setAttribute("mapSession"+mapSessionDTO.getLocationOrd()+"DTO",mapSessionDTO); //LocationOrd를 통해 순서를 부여해준후 세션에 올려준다.
				}
			}
			
		}
		
		
		resultMap.put("result", result2); //마지막 절차인 인증유무업데이트까지 완료가 됬다면 문제가 없다는 의미이기때문 resultMap저장해 ajax에 반환해준다.
		return resultMap;
	}

}
