package com.koreait.dooboo.map.command;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.member.command.MemberCommand;

public class SaveLocationCommand {
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();
		String location = request.getParameter("location");
		session.setAttribute("nowLocation", location);
		Map<String, Object> resultMap  = new HashMap<String, Object>();
		resultMap.put("result", 1);
		
		return resultMap;
	}
}
