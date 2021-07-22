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

import com.koreait.dooboo.map.command.UpdateLocationCommand;
import com.koreait.dooboo.map.command.UpdateUseNowCommand;
import com.koreait.dooboo.map.command.DeleteLocationCommand;
import com.koreait.dooboo.map.command.FirstInsertLocationCommand;
import com.koreait.dooboo.map.command.MapCheckLocationCommand;
import com.koreait.dooboo.map.command.MapInsertLocationCommand;
import com.koreait.dooboo.map.command.SaveLocationCommand;
import com.koreait.dooboo.map.dto.MapSessionDTO;


@Controller
public class MapController {
	private SqlSession sqlSession;
	private MapCheckLocationCommand mapCheckLocationCommand;
	private MapInsertLocationCommand mapInsertLocationCommand;
	private SaveLocationCommand saveLocationCommand;
	private UpdateLocationCommand changeLocationCommand;
	private DeleteLocationCommand deleteLocationCommand;
	private FirstInsertLocationCommand firstInsertLocationCommand;
	private UpdateUseNowCommand updateUseNowCommand;

	@Autowired	
	public MapController(	SqlSession sqlSession,
							MapCheckLocationCommand mapCheckLocationCommand,
							MapInsertLocationCommand mapInsertLocationCommand,
							SaveLocationCommand saveLocationCommand,
							UpdateLocationCommand changeLocationCommand,
							DeleteLocationCommand deleteLocationCommand,
							FirstInsertLocationCommand firstInsertLocationCommand,
							UpdateUseNowCommand updateUseNowCommand) {
		super();
		this.sqlSession = sqlSession;
		this.mapCheckLocationCommand = mapCheckLocationCommand;
		this.mapInsertLocationCommand = mapInsertLocationCommand;
		this.saveLocationCommand = saveLocationCommand;
		this.changeLocationCommand = changeLocationCommand;
		this.deleteLocationCommand = deleteLocationCommand;
		this.firstInsertLocationCommand = firstInsertLocationCommand;
		this.updateUseNowCommand = updateUseNowCommand;
	}
	@GetMapping(value= "m.checkLocation")
	@ResponseBody
	public Map<String, Object> checkLocation(HttpServletRequest request,MapSessionDTO mapSessionDTO,Model model) {
		model.addAttribute("request",request);
		model.addAttribute("mapSessionDTO",mapSessionDTO);
		return mapCheckLocationCommand.execute(sqlSession, model);
	}
	
	@PostMapping(value= "m.updateLocation")
	@ResponseBody
	public Map<String, Object> changeLocation(HttpServletRequest request,MapSessionDTO mapSessionDTO,Model model){
		model.addAttribute("request",request);
		model.addAttribute("mapSessionDTO",mapSessionDTO);
		return changeLocationCommand.execute(sqlSession, model);
	}
	
	@PostMapping(value="m.deleteLocation")
	@ResponseBody
	public Map<String, Object> deleteLocation(HttpServletRequest request,MapSessionDTO mapSessionDTO,Model model){
		model.addAttribute("request",request);
		model.addAttribute("mapSessionDTO",mapSessionDTO);
		return deleteLocationCommand.execute(sqlSession, model);
	}
	
	@PostMapping(value= "m.insertLocation")
	@ResponseBody
	public Map<String, Object> insertLocation(HttpServletRequest request,HttpServletResponse response,MapSessionDTO mapSessionDTO,Model model) {
		model.addAttribute("request",request);
		model.addAttribute("response",response);
		model.addAttribute("mapSessionDTO",mapSessionDTO);
		return mapInsertLocationCommand.execute(sqlSession, model);
		
	}
	@PostMapping(value="locationSave", produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> locationSave(HttpServletRequest request ,MapSessionDTO mapSessionDTO, Model model) {
		model.addAttribute("request",request);
		model.addAttribute("mapSessionDTO",mapSessionDTO);
		return saveLocationCommand.execute(sqlSession, model);
	}
	
	@GetMapping(value= "mapCheck")
	public String mapCheck() {
		return"map/mapCheck";
	}
	
	@PostMapping(value= "m.firstInsertLocation")
	public String firstInsertLocation(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		firstInsertLocationCommand.execute(sqlSession, model);
		return"map/mapCheckLocation";
	}
	
	
	

	@GetMapping(value= "m.mapInsertLocationPage")
	public String inserLocationPage() {
		return "map/mapInsertLocation";
	}
	@GetMapping(value= "m.mapCheckLocationPage")
	public String checkLocationPage() {
		return "map/mapCheckLocation";
	}

	@PostMapping(value="m.updateUsenow",produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> updateUsenow(MapSessionDTO mapSessionDTO,Model model,HttpServletRequest request) {
		model.addAttribute("mapSessionDTO",mapSessionDTO);
		model.addAttribute("request",request);
		return updateUseNowCommand.execute(sqlSession, model);
	}


	


	
	
	@GetMapping(value="mainPage.do")
	public String mainPage() {
		return"map/mainPage";
	}
	

	
	
}
