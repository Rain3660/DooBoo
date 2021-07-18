package com.koreait.dooboo.map.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.dooboo.map.command.ChangeLocationCommand;
import com.koreait.dooboo.map.command.ChangeToNowLocation;
import com.koreait.dooboo.map.command.DeleteLocationCommand;
import com.koreait.dooboo.map.command.MapCheckLocationCommand;
import com.koreait.dooboo.map.command.MapInsertLocationCommand;
import com.koreait.dooboo.map.command.SaveLocationCommand;

@Controller
public class MapController {
	private SqlSession sqlSession;
	private MapCheckLocationCommand mapCheckLocationCommand;
	private MapInsertLocationCommand mapInsertLocationCommand;
	private SaveLocationCommand saveLocationCommand;
	private ChangeLocationCommand changeLocationCommand;
	private ChangeToNowLocation changeToNowLocation;
	private DeleteLocationCommand deleteLocationCommand;

	@Autowired	
	public MapController(	SqlSession sqlSession,
							MapCheckLocationCommand mapCheckLocationCommand,
							MapInsertLocationCommand mapInsertLocationCommand,
							SaveLocationCommand saveLocationCommand,
							ChangeLocationCommand changeLocationCommand,
							ChangeToNowLocation changeToNowLocation,
							DeleteLocationCommand deleteLocationCommand) {
		super();
		this.sqlSession = sqlSession;
		this.mapCheckLocationCommand = mapCheckLocationCommand;
		this.mapInsertLocationCommand = mapInsertLocationCommand;
		this.saveLocationCommand = saveLocationCommand;
		this.changeLocationCommand = changeLocationCommand;
		this.changeToNowLocation = changeToNowLocation;
		this.deleteLocationCommand = deleteLocationCommand;
	}

	@GetMapping(value= {"m.mapInsertLocationPage","api/m.mapInsertLocationPage"})
	public String inserLocationPage() {
		return "map/mapInsertLocation";
	}
	@GetMapping(value= {"m.mapCheckLocationPage","api/m.mapCheckLocationPage"})
	public String checkLocationPage() {
		return "map/mapCheckLocation";
	}
	@PostMapping(value= {"locationSave","api/locationSave"})
	@ResponseBody
	public Map<String, Object> locationSave(HttpServletRequest request , Model model) {
		model.addAttribute("request",request);
		
		return saveLocationCommand.execute(sqlSession, model);
	}
	@GetMapping(value= {"mapCheck","api/mapCheck"})
	public String mapCheck() {
		return"map/mapCheck";
	}

	@GetMapping(value= {"m.insertLocation","api/m.insertLocation"})
	public String insertLocation(HttpServletRequest request,HttpServletResponse response,Model model) {
		model.addAttribute("request",request);
		model.addAttribute("response",response);
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
	
	
	
	@PostMapping(value= {"m.changeLocation","api/m.changeLocation"})
	@ResponseBody
	public Map<String, Object> changeLocation(HttpServletRequest request,Model model){
		model.addAttribute("request",request);
		return changeLocationCommand.execute(sqlSession, model);
	}
	
	@PostMapping(value= {"m.changeToNowLocation","api/m.changeToNowLocation"})
	@ResponseBody
	public Map<String, Object> changeToNowLocation(HttpServletRequest request,Model model){
		model.addAttribute("request",request);
		return changeToNowLocation.execute(sqlSession, model);
	}
	
	
	@PostMapping(value= {"m.deleteLocation","api/m.deleteLocation"})
	@ResponseBody
	public Map<String, Object> deleteLocation(HttpServletRequest request,Model model){
		model.addAttribute("request",request);
		return deleteLocationCommand.execute(sqlSession, model);
	}

	
	
}
