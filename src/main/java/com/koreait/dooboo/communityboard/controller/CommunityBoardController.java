package com.koreait.dooboo.communityboard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.dooboo.communityboard.command.BoardCommand;
import com.koreait.dooboo.communityboard.command.BoardCommandImpl;
import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;

@Controller
@RequestMapping("/CommunityBoard")
public class CommunityBoardController {
	
	@Autowired
	private BoardCommand boardCommand;
	
	
	@GetMapping(value = "/board_sample")
	public ModelAndView openBoardList(CommunityBoardDTO boardDTO) {
		ModelAndView mav = new ModelAndView();
		
		Map<String,Object> resultMap = boardCommand.getBoardList(boardDTO);
		mav.addObject("resultMap", resultMap);
		mav.addObject("params", boardDTO);
		mav.setViewName("CommunityBoard/board_sample");
		return mav;
	}
	
	@GetMapping(value = "/detail")
	public ModelAndView openBoardDetail(CommunityBoardDTO boardDTO) {
		
		ModelAndView mav = new ModelAndView();
		CommunityBoardDTO resultMap = boardCommand.getBoardDetail(boardDTO.getBoardNo());
		
		mav.addObject("board", resultMap);
		mav.setViewName("CommunityBoard/write");
		
		return mav; 
	}
	
	@GetMapping(value = "/read")
	public ModelAndView openBoardRead(CommunityBoardDTO boardDTO) {
		
		ModelAndView mav = new ModelAndView();
		CommunityBoardDTO resultMap = boardCommand.getBoardDetail(boardDTO.getBoardNo());
		
		mav.addObject("board", resultMap);
		mav.setViewName("CommunityBoard/read");
		
		return mav;
	}
	
	
	@GetMapping(value = "/update")
	public ModelAndView openBoardUpdate(CommunityBoardDTO boardDTO) {
		
		ModelAndView mav = new ModelAndView();
		CommunityBoardDTO resultMap = boardCommand.getBoardDetail(boardDTO.getBoardNo());
		
		mav.addObject("board", resultMap);
		mav.setViewName("CommunityBoard/update");
		
		return mav;
	}
	 
	@PostMapping(value ="/save")
	@ResponseBody
	public Map<String,Object> openBoardSave(CommunityBoardDTO boardDTO) {
		boolean saveYn = boardCommand.registerBoard(boardDTO);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("saveYn", saveYn);
		return resultMap;
	}

	@PostMapping(value ="/delete")
	@ResponseBody
	public Map<String,Object> openBoardDelete(CommunityBoardDTO boardDTO) {
		boolean deleteYn = boardCommand.deleteBoard(boardDTO.getBoardNo());
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("deleteYn", deleteYn);
		return resultMap;
	}

}