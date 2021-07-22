package com.koreait.dooboo.communityboard.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.dooboo.communityboard.command.BoardCommand;
import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;
import com.koreait.dooboo.product.dto.ProductimageDTO;
import com.koreait.dooboo.util.FileUpload;

@Controller
/*@RequestMapping("/CommunityBoard")*/
public class CommunityBoardController {
	
	@Autowired
	private BoardCommand boardCommand;
	
	
	@GetMapping(value = "b.list")
	public ModelAndView openBoardList(CommunityBoardDTO boardDTO) {
		ModelAndView mav = new ModelAndView();
		
		Map<String,Object> resultMap = boardCommand.getBoardList(boardDTO);
		mav.addObject("resultMap", resultMap);
		mav.addObject("params", boardDTO);
		mav.setViewName("CommunityBoard/boardList");
		return mav;
	}
	
	@GetMapping(value = "b.detail")
	public ModelAndView openBoardDetail(CommunityBoardDTO boardDTO) {
		
		ModelAndView mav = new ModelAndView();
		CommunityBoardDTO resultMap = boardCommand.getBoardDetail(boardDTO.getBoardNo());
		
		mav.addObject("board", resultMap);
		mav.setViewName("CommunityBoard/read");
		
		return mav; 
	}
	
	@GetMapping(value = "b.write")
	public ModelAndView openBoardRead(CommunityBoardDTO boardDTO) {
		
		ModelAndView mav = new ModelAndView();
		CommunityBoardDTO resultMap = boardCommand.getBoardDetail(boardDTO.getBoardNo());
		
		mav.addObject("board", resultMap);
		mav.setViewName("CommunityBoard/write");
		
		return mav;
	}
	
	
	@GetMapping(value = "b.update")
	public ModelAndView openBoardUpdate(CommunityBoardDTO boardDTO) {
		
		ModelAndView mav = new ModelAndView();
		CommunityBoardDTO resultMap = boardCommand.getBoardDetail(boardDTO.getBoardNo());
		
		mav.addObject("board", resultMap);
		mav.setViewName("CommunityBoard/update");
		
		return mav;
	}
	 
	@PostMapping(value ="b.save")
	@ResponseBody
	public Map<String,Object> openBoardSave(CommunityBoardDTO boardDTO,@RequestParam("uploadFile") MultipartFile[] uploadFiles) {
		
		List<FileUpload> files = new ArrayList<FileUpload>(); 
		if(null != uploadFiles) {
			for(MultipartFile multiPartFile : uploadFiles) {
				FileUpload file = new FileUpload(multiPartFile);
				System.out.println(file.getFileName());
				System.out.println(file.getOrgFileName());
				files.add(file);
			}
			boardDTO.setFileUploadList(files);
		}
		
		boolean saveYn = boardCommand.registerBoard(boardDTO);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("saveYn", saveYn);
		return resultMap;
	}

	@PostMapping(value ="b.delete")
	@ResponseBody
	public Map<String,Object> openBoardDelete(CommunityBoardDTO boardDTO) {
		boolean deleteYn = boardCommand.deleteBoard((int) boardDTO.getBoardNo());
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("deleteYn", deleteYn);
		return resultMap;
	}
	
	@PostMapping(value ="deleteFile")
	@ResponseBody
	public Map<String,Object> setDeleteFile(ProductimageDTO productImageDTO) {
		boolean deleteYn = boardCommand.setDeleteFile(productImageDTO);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("deleteYn", deleteYn);
		return resultMap;
	}

}