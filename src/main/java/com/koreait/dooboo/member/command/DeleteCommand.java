package com.koreait.dooboo.member.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.http.HttpRequest;
import org.springframework.ui.Model;

import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;

public class DeleteCommand implements MemberCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String,Object> map = model.asMap();
		HttpSession session = (HttpSession) map.get("session");
		
		long no =  ((MemberDTO)session.getAttribute("loginUser")).getMemberNo();
		
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		int count = memberDAO.delete(no);
		
		if(count > 0) {
			session.invalidate();
		}

	}

}
