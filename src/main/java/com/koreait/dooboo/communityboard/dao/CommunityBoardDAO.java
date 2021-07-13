package com.koreait.dooboo.communityboard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;


	@Mapper
	public interface CommunityBoardDAO {
		
			public int insertBoard(CommunityBoardDTO params);
			
			public CommunityBoardDTO selectBoardDetail(int idx);
			
			public int updateBoard(CommunityBoardDTO params);
			
			public int deleteBoard(int idx);
			
			public List<CommunityBoardDTO> selectBoardList(CommunityBoardDTO boardDTO);
			
			public List<CommunityBoardDTO> selectHeaderBoardList(CommunityBoardDTO boardDTO);
			
			public int selectBoardTotalCount(CommunityBoardDTO boardDTO);
		
			public int updateHit(int communityboardNo);
			
	}

