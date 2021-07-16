package com.koreait.dooboo.member.command;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;

public class IdCheckCommand{
	
	public Map<String, Integer> execute(SqlSession sqlSession, Model model) {
		
		String memberId = ((MemberDTO)model.asMap().get("memberDTO")).getMemberId();
		
		// 있으면 1 없으면 0
		int result = sqlSession.getMapper(MemberDAO.class).searchByMemberId(memberId);
		
		Map<String, Integer> resultMap = new HashMap<>();
		resultMap.put("result", result);
		return resultMap;
	}
}
