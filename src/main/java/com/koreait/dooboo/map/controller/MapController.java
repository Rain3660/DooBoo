package com.koreait.dooboo.map.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.dooboo.map.command.MapCheckLocationCommand;
import com.koreait.dooboo.map.command.MapInsertLocationCommand;

@Controller
public class MapController {
	private SqlSession sqlSession;
	private MapCheckLocationCommand mapCheckLocationCommand;
	private MapInsertLocationCommand mapInsertLocationCommand;

	@Autowired	
	public MapController(	SqlSession sqlSession,
							MapCheckLocationCommand mapCheckLocationCommand,
							MapInsertLocationCommand mapInsertLocationCommand) {
		super();
		this.sqlSession = sqlSession;
		this.mapCheckLocationCommand = mapCheckLocationCommand;
		this.mapInsertLocationCommand = mapInsertLocationCommand;
	}

	@GetMapping(value= {"m.mapInsertLocatinPage","api/m.mapInsertLocationPage"})
	public String inserLocationPage() {
		return "map/mapInsertLocation";
	}
	@GetMapping(value= {"m.mapCheckLocationPage","api/m.mapCheckLocationPage"})
	public String checkLocationPage() {
		return "map/mapCheckLocation";
	}
	

	@GetMapping(value= {"m.insertLocation","api/m.insertLocation"})
	public String insertLocation(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		mapInsertLocationCommand.execute(sqlSession, model);
		return"map/mapCheckLocation";
	}
	


	@GetMapping(value= {"m.checkLocation","api/m.checkLocation"})
	@ResponseBody
	public Map<String, Object> checkLocation(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		return mapCheckLocationCommand.execute(sqlSession, model);
	}
	
	
	@GetMapping(value="mainPage.do")
	public String mainPage() {
		return"map/mainPage";
	}
	
	
}
