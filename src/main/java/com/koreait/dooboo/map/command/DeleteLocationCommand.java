package com.koreait.dooboo.map.command;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.map.dao.MapDAO;
import com.koreait.dooboo.member.command.MemberCommand;

public class DeleteLocationCommand {


	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
			Map<String, Object> map = model.asMap();
			HttpServletRequest request = (HttpServletRequest) map.get("request");
			int locationNo = Integer.parseInt(request.getParameter("locationNo"));
			HttpSession session = request.getSession();
			long mapNo = Long.parseLong(request.getParameter("mapNo"));
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			MapDAO mapDAO = sqlSession.getMapper(MapDAO.class);
			int result1 = mapDAO.deleteMapLocationCheck(mapNo);
			int result2 = 0;
			if(result1 > 0) {
				result2 = mapDAO.deleteMap(mapNo);
			}
			
			if(result2 > 0) {
				resultMap.put("result", result2);
				session.removeAttribute("location"+locationNo);
			}
			return resultMap;
	}

}
