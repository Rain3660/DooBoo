package com.koreait.dooboo.communityboard.command;

import java.util.Map;

import com.koreait.dooboo.communityboard.dto.CommunityBoardDTO;

public interface BoardCommand {

		public boolean registerBoard(CommunityBoardDTO params);

		public CommunityBoardDTO getBoardDetail(long idx);

		public boolean deleteBoard(long idx);

		public  Map<String,Object> getBoardList(CommunityBoardDTO boardDto);
		
		public void updateHit(long boardNo);
}
