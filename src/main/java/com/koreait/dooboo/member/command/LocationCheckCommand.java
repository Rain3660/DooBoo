package com.koreait.dooboo.member.command;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;

public class LocationCheckCommand{
	
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		MemberDTO memberDTO = (MemberDTO)model.asMap().get("memberDTO");
		long memberNo = memberDTO.getMemberNo();
		
		String address = sqlSession.getMapper(MemberDAO.class).locationCheckTest(memberNo);
		
		resultMap.put("address", address);
		
		return resultMap;
		
	}
}
