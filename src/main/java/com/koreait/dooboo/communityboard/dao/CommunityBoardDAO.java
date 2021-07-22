package com.koreait.dooboo.communityboard.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;
import com.koreait.dooboo.product.dto.ProductimageDTO;

@Mapper
public interface CommunityBoardDAO {
	
		public int insertBoard(CommunityBoardDTO params);
		
		public CommunityBoardDTO selectBoardDetail(long idx);
		
		public int updateBoard(CommunityBoardDTO params);
		
		public int deleteBoard(long idx);
		
		public List<CommunityBoardDTO> selectBoardList(CommunityBoardDTO boardDTO);
		
		public int selectBoardTotalCount(CommunityBoardDTO boardDTO);
	
		public int updateHit(long boardNo);
		
		public int insertProductImage(CommunityBoardDTO params);
		
		public int deleteFile(ProductimageDTO productImageDto);
}

