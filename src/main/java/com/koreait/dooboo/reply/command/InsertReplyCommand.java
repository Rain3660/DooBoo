package com.koreait.dooboo.reply.command;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.dooboo.reply.dao.ReplyDAO;
import com.koreait.dooboo.reply.dto.ReplyDTO;

public class InsertReplyCommand implements ReplyCommand {

	@Override
	public void execute(SqlSession session, Model model) {
			
		HttpServletRequest request  = (HttpServletRequest) model.asMap().get("request");
		HttpServletResponse response = null;
		ReplyDTO dto = new ReplyDTO();
		dto.setBoardNo(Long.parseLong(request.getParameter("boardNo")));
		dto.setRegNo(Long.parseLong(request.getParameter("memberNo")));
		dto.setReplyContent(request.getParameter("content"));
		
		ReplyDAO dao = session.getMapper(ReplyDAO.class);
		
	      int count= dao.insertReply(dto);
		
	     
				
	}

}
