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
import com.koreait.dooboo.map.dto.MapSessionDTO;
import com.koreait.dooboo.member.command.MemberCommand;
import com.koreait.dooboo.util.GetMidLocation;

public class SaveLocationCommand {
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		MapSessionDTO mapSessionDTO = (MapSessionDTO) map.get("mapSessionDTO"); //session에 필요한 컬럼들만 모은 dto
		HttpSession session = request.getSession(); //세션에 등록하기위해 준비
		Map<String, Object> resultMap = new HashMap<String,Object>(); //ajax에 반환을 위해 만든 HashMap
		

		String location = mapSessionDTO.getLocation(); //현재 위치를 받아온다 ex) 서울특별시 은평구 녹번동
		String midLocation = GetMidLocation.getMidLocation(location); // util을 사용해 '은평구' 만 뽑아낸다
		
		
		session.setAttribute("nowLocation", midLocation); //뽑아낸 지역이름을 세션에 올린다(클라이언트에게 보여주기 용으로) ex) 현재 계신지역은'서울특별시 은평구 녹번동' 입니다 (x) // 현재 계신지역은 '은평구'입니다 (o)
		session.setAttribute("fullLocation", location);  //풀 주소를 세션에 올려준다.
		resultMap.put("result", 1); //다른 jsp로 넘어가기위해 불가피하게 ajax를 사용해 세션만 올리고 다시 돌아가 location.href 를 통해 페이지 이동을 시켜준다 그러기 위해 만든 resultMap
		
		return resultMap;
	}
}
