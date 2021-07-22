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


public class UpdateUseNowCommand {


	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		MapSessionDTO mapSessionDTO = (MapSessionDTO) map.get("mapSessionDTO");
		MapDAO mapDAO = sqlSession.getMapper(MapDAO.class);
		HttpSession session = request.getSession();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(mapSessionDTO);
		List<MapDTO> list = mapDAO.getLocation(mapSessionDTO.getMemberNo()); //파라미터로 가져온 memberNo로 가지고있는 map2개를 조회한다
		int usenowNO = (int) mapSessionDTO.getMapNo(); 							//선호지역 변경시 jsp단에서 둘다 인증이 되어있어야하고 지역이 2개가 있어야 백단으로 넘어오게 만들었다 그렇기때문에 이곳에 왔다는건 둘중에 한개가인증이 되었다 이야기고 지역이 2개가있다는 의미이기 때문에 null 예외는 안뜰것으로 에상
		MapDTO mapDTO1 = list.get(0);
		String midLocation1 =GetMidLocation.getMidLocation(mapDTO1.getLocation());
		MapDTO mapDTO2 = list.get(1);
		String midLocation2 =GetMidLocation.getMidLocation(mapDTO2.getLocation());
		int result1 = 0;
		int result2 = 0;
		System.out.println(mapDTO1.getMapNo());
		System.out.println(usenowNO);
		System.out.println(mapDTO1.getMapNo()==usenowNO);
		if(mapDTO1.getMapNo() == usenowNO) { //맵2개중 첫번재 반환된 mapDTO의 mapNo와 바꾸려는(일반->선호지역) mapNo를 대조해본다
			
			MapLocationCheckDTO mapLocationCheckDTO1 = new MapLocationCheckDTO(); //비교한 지역과 일치하면 usenow를 0에서 1로 바꾸고 나머지 반환된 mapDTO에는 usenow를 0으로 업데이트 해준다
			mapLocationCheckDTO1.setMapNo(mapDTO1.getMapNo());
			mapLocationCheckDTO1.setUsenow(1); 
			result1 = mapDAO.updateUseNow(mapLocationCheckDTO1);
			
			MapSessionDTO mapSession1DTO = new MapSessionDTO(mapDTO1.getMapNo(), mapDTO1.getMemberNo(),midLocation1, mapDTO1.getLocationOrd(), 1, 1); //일치하는 지역은 무조건 인증이 되어있는 상태이기때문에 ischecked 변수에는 1을 저장
			session.setAttribute("mapSession"+mapDTO1.getLocationOrd()+"DTO", mapSession1DTO);//비교후 mapNO가 같은 mapDTO 에는 1을 저장한후 업데이트 후 세션용 dto에 저장해 세션에 올려준다
			
			
			MapLocationCheckDTO mapLocationCheckDTO2 = new MapLocationCheckDTO(); //반대로 비교한 나머지의 mapDTO 에는 0을 저장한후 업데이트 후 세션용 dto에 저장해 세션에 올려준다
			mapLocationCheckDTO2.setMapNo(mapDTO2.getMapNo());
			mapLocationCheckDTO2.setUsenow(0);
			result2 = mapDAO.updateUseNow(mapLocationCheckDTO2);
			
			
			MapSessionDTO mapSession2DTO = new MapSessionDTO(mapDTO2.getMapNo(), mapDTO2.getMemberNo(), midLocation2, mapDTO2.getLocationOrd(), 1, 0); 
			session.setAttribute("mapSession"+mapDTO2.getLocationOrd()+"DTO", mapSession2DTO);
			if(result1 == 1 && result2 == 1) {
				resultMap.put("result", 1);
			}
		}else {
			MapLocationCheckDTO mapLocationCheckDTO2 = new MapLocationCheckDTO();
			mapLocationCheckDTO2.setMapNo(mapDTO2.getMapNo());
			mapLocationCheckDTO2.setUsenow(1);
			result1 = mapDAO.updateUseNow(mapLocationCheckDTO2);
			
			MapSessionDTO mapSession2DTO = new MapSessionDTO(mapDTO2.getMapNo(), mapDTO2.getMemberNo(), midLocation2, mapDTO2.getLocationOrd(), 1, 1); 
			session.setAttribute("mapSession"+mapDTO2.getLocationOrd()+"DTO", mapSession2DTO);
			
			
			MapLocationCheckDTO mapLocationCheckDTO1 = new MapLocationCheckDTO();
			mapLocationCheckDTO1.setMapNo(mapDTO1.getMapNo());
			mapLocationCheckDTO1.setUsenow(0);
			result2 = mapDAO.updateUseNow(mapLocationCheckDTO1);	
			
			MapSessionDTO mapSession1DTO = new MapSessionDTO(mapDTO1.getMapNo(), mapDTO1.getMemberNo(), midLocation1, mapDTO1.getLocationOrd(), 1, 0); 
			session.setAttribute("mapSession"+mapDTO1.getLocationOrd()+"DTO", mapSession1DTO);
			if(result1 == 1 && result2 == 1) {
				resultMap.put("result", 1);
			}
		}
		
		
		
		return resultMap;

	}

}
