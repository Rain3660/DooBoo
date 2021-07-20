package com.koreait.dooboo.member.command;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;

public class FindIdCommand{
	
	public Map<String , Object> execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		MemberDTO member = (MemberDTO) model.asMap().get("member");

		System.out.println("controller : " + member.toString());

		MemberDTO searchedMember = sqlSession.getMapper(MemberDAO.class).findIdByEmailAndName(member);

		if (searchedMember == null) {
			resultMap.put("status", 500);
		} else {
			resultMap.put("status", 200);
			resultMap.put("id", searchedMember.getMemberId());
		}

		return resultMap;
		
	}
}
