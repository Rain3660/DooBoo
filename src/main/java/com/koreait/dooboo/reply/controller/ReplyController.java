package com.koreait.dooboo.reply.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.dooboo.reply.command.DeleteReplyCommand;
import com.koreait.dooboo.reply.command.InsertReplyCommand;
import com.koreait.dooboo.reply.command.SelectAllReplyCommand;
import com.koreait.dooboo.reply.dto.ReplyDTO;

@Controller
public class ReplyController {

	@Autowired
	private SqlSession session;

	@Autowired
	private InsertReplyCommand insertReplyCommand;

	@Autowired
	private SelectAllReplyCommand selectAllReplyCommand;
	
	@Autowired
	private DeleteReplyCommand deleteReplyCommand;
	

	@PostMapping(value = "b.insertReply")
	public String insertReply(HttpServletRequest request, Model model) {
		
		model.addAttribute("request", request);
		insertReplyCommand.execute(session, model);
		long boardNo= Long.parseLong(request.getParameter("boardNo"));
		
		return "redirect:b.detail?boardNo=" + boardNo;
	}
	

	@PostMapping(value = "r.selectAllReply", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> selectAllReply(@RequestBody ReplyDTO dto, Model model) {
		
		System.out.println("Controller's selectAllReply");
		System.out.println(dto.getBoardNo());
		System.out.println(dto.getPage());
		
		model.addAttribute("boardNo", dto.getBoardNo());
	    model.addAttribute("page", dto.getPage());
		  
		  
		return selectAllReplyCommand.execute(session, model);
	}
	
	@GetMapping(value="r.delete", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> deleteReply(ReplyDTO dto ,  Model model) {
		  
		  model.addAttribute("replyNo",dto.getReplyNo());
	
		return  deleteReplyCommand.execute(session, model);
		 
	}
	
	
	
	
   
}
