package com.koreait.dooboo.map.command;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.map.dao.MapDAO;
import com.koreait.dooboo.map.dto.MapSessionDTO;
import com.koreait.dooboo.member.command.MemberCommand;
//완료
public class DeleteLocationCommand {


	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
			Map<String, Object> map = model.asMap();
			HttpServletRequest request = (HttpServletRequest) map.get("request");
			MapSessionDTO mapSessionDTO = (MapSessionDTO) map.get("mapSessionDTO"); //session에 필요한 컬럼들만 모은 dto
			HttpSession session = request.getSession(); //세션에 등록하기위해 준비
			Map<String, Object> resultMap = new HashMap<String,Object>(); //ajax에 반환을 위해 만든 HashMap
		
			long mapNo = mapSessionDTO.getMapNo(); //어떤 지역을 삭제하고싶은지 알기위해 map의 기본키를 받아온다
			MapDAO mapDAO = sqlSession.getMapper(MapDAO.class);//DB에 올리기위해 만든 DAO
			
			int result1 = mapDAO.deleteMapLocationCheck(mapNo); //인증유무 페이지를 먼저 삭제해준다
			int result2 = 0;
			if(result1 > 0) { //인증유무의 삭제가 확인되면 실제 map테이블에있는 컬럼을 삭제해준다.
				result2 = mapDAO.deleteMap(mapNo);
			}
			
			if(result2 > 0) { //map까지 삭제가되었다면 session에 올라가있는 정보를 제거해준다
				resultMap.put("result", result2); //모든것이 삭제가 되면 마지막 result2의 값을 ajax반환값으로 넣어준다.
				session.removeAttribute("mapSession"+mapSessionDTO.getLocationOrd()+"DTO"); //세션 제거
			}
			
			return resultMap;
	}

}
