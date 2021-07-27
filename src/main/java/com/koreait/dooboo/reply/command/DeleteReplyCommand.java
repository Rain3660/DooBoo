package com.koreait.dooboo.reply.command;


import java.util.HashMap;
import java.util.Map;


import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.reply.dao.ReplyDAO;

public class DeleteReplyCommand  {

	
	public Map< String, Object> execute(SqlSession session, Model model) {
	    Map<String, Object> map = model.asMap();
	
		
		long no = (long) map.get("replyNo");
		
		
		ReplyDAO replyDAO = session.getMapper(ReplyDAO.class);
		int count = replyDAO.deleteReply(no);
		
		Map<String, Object> result  =  new HashMap<String, Object>();
		result.put("count", count);
		
		return result;
		
		
		
		
		
		
		

	}

}
