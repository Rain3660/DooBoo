package com.koreait.dooboo.member.command;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;
import com.koreait.dooboo.util.SecurityUtils;

public class CurrentPasswordCheckCommand{
	
	public Map<String, Integer> execute(SqlSession sqlSession, Model model) {
		
		MemberDTO memberDTO = (MemberDTO)model.asMap().get("memberDTO");
		
		// 현재 회원번호
		long memberNo = memberDTO.getMemberNo();
		
		// 입력한 비밀번호
		String password = memberDTO.getPassword();
		// 암호화
		String encPassword = SecurityUtils.encodeBase64(password);
		
		// DB 에 저장된 정보와 비교한다.
		// 같으면 1 다르면 0
		int result = encPassword.equals(sqlSession.getMapper(MemberDAO.class).selectMemberByMemberNo(memberNo).getPassword()) ? 1 : 0;
		
		Map<String, Integer> resultMap = new HashMap<>();
		resultMap.put("result", result);
		return resultMap;
		
	}
}
