package com.koreait.dooboo.communityboard.command;


import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.dooboo.communityboard.dao.CommunityBoardDAO;
import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;
import com.koreait.dooboo.communityboard.dto.ListPagingDTO;
import com.koreait.dooboo.communityboard.dto.ListPagingInfo;

@Service("boardCommand")
public class BoardCommand{
	
	@Autowired
	private CommunityBoardDAO communityBoardDAO;
	
	@Autowired
	private ListPagingDTO listpagingDTO;
	
	public boolean registerBoard(CommunityBoardDTO params) {
		int queryResult = 0;

		if (params.getBoardNo() == 0) {
			queryResult = communityBoardDAO.insertBoard(params);
		} else {
			queryResult = communityBoardDAO.updateBoard(params);
		}

		return (queryResult == 1) ? true : false;
		
	}

	public CommunityBoardDTO getBoardDetail(long idx) {
		updateHit(idx);
		return communityBoardDAO.selectBoardDetail(idx);
	}
	
	public void updateHit(long boardNo) {
		communityBoardDAO.updateHit(boardNo);
	}
	
	public boolean deleteBoard(long idx) {
		int queryResult = 0;
		queryResult = communityBoardDAO.deleteBoard(idx);
		return (queryResult == 1) ? true : false;
	}

	public Map<String,Object> getBoardList(CommunityBoardDTO boardDTO) {
		Map<String,Object> resultMap = new HashMap<String, Object>();
		List<CommunityBoardDTO> boardList = Collections.emptyList();
		int boardTotalCount = communityBoardDAO.selectBoardTotalCount(boardDTO);
		
		ListPagingInfo listPagingInfo = new ListPagingInfo();
		listPagingInfo.setListPagingVo(listpagingDTO);
		listPagingInfo.setTotalRecordCount(boardTotalCount);
		resultMap.put("boardTotalCount", boardTotalCount);
		if (boardTotalCount > 0) {
			boardList = communityBoardDAO.selectBoardList(boardDTO);
			resultMap.put("boardList", boardList);
		}
		resultMap.put("listPagingInfo", listPagingInfo);

		return resultMap;
	}
}


