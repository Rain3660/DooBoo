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
//완료
public class MapCheckLocationCommand {

	
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		MapSessionDTO mapSessionDTO = (MapSessionDTO) map.get("mapSessionDTO"); //session에 필요한 컬럼들만 모은 dto
		HttpSession session = request.getSession(); //세션에 등록하기위해 준비
		long mapNo = mapSessionDTO.getMapNo(); //이곳에 들어왔다는것 == 이미 인증이 되어 업데이트만 진행하면됨
		MapLocationCheckDTO mapLocationCheckDTO = new MapLocationCheckDTO(mapNo, 1); //mapNo를 꺼내 인증이됬다는 result값을 dto에 담는다

		
		MapDAO mapDAO = sqlSession.getMapper(MapDAO.class); //DB에 저장하기위해 DAO호출
		Map<String, Object> resultMap = new HashMap<String,Object>(); //ajax에 반환을 위해 만든 HashMap
		String fullLocation = mapSessionDTO.getLocation(); //미리 저장해둔 현재위치를 파라미터를 통해 받는다 ex)서울시 은평구 녹번동
		String midLocation = GetMidLocation.getMidLocation(fullLocation); //미리만들어둔 util을 통해 spit을 진행하여 중간에 '구' 만 가져온다.

		
		int result1 = mapDAO.mapUpdateResult(mapLocationCheckDTO); //인증됬다는 result값을 DAO를 통해 DB로 저장(++ 첫 회원가입이라면 선호지역도 인증)
		
		if(result1 > 0) {
			long memberNo = mapSessionDTO.getMemberNo(); //멤버기본키를받아온다
			MapDTO mapDTO = new MapDTO();//인증이 된곳은 풀네임으로 데이터에 올려준다.
			mapDTO.setLocation(fullLocation);
			mapDTO.setMapNo(mapNo);
			int result2 = mapDAO.updateLocation(mapDTO); //풀네임 정보를 DB에 올리기위한 DAO
			if(result2 > 0) {
				resultMap.put("result", result2);		 //업데이트가 잘되었다면 ajax의 반환을 위해 hashMap에 저장	
				int locatioOrd = mapSessionDTO.getLocationOrd(); //지역 1번 2번을 구분하기위한 변수
				mapSessionDTO.setIsChecked(mapLocationCheckDTO.getIsChecked());	//인증이되었고 업데이트도 되었기때문에 dto에 isChecked만 1로 set하여 session에 올린다.
				mapSessionDTO.setLocation(midLocation);//서울시 은평구 녹번동 중 '은평구'만 세션에 올린다.
				
				int firstVisit = (int) session.getAttribute("firstVisit"); //처음 회원가입인지 그냥 지역인증인이지 확인하기위해 세션에서 꺼내 확인
				System.out.println(firstVisit);
				if(firstVisit == 1) { 					 //첫 회원가입에 진행한 지역 인증이라면
					mapLocationCheckDTO.setUsenow(1);   //선호지역으로 자동 업데이트 된다.
					mapSessionDTO.setUsenow(1); 		//세션용 dto에도 추가시켜준다.
					mapDAO.updateUseNow(mapLocationCheckDTO);
				}
				
				session.setAttribute("mapSession"+mapSessionDTO.getLocationOrd()+"DTO", mapSessionDTO);//중간에 locationOrd를 통해 지역중 몇번째인지 넣고 세션에 올린다.				
			}
			
		
		}
		return resultMap;
	}

}
