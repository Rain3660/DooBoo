package com.koreait.dooboo.chat.dao;

import java.util.List;

import com.koreait.dooboo.chat.vo.RoomDTO;

public interface ChatDAO {
	public RoomDTO getRoom(RoomDTO roomDTO);
	
	public int insertRoom(RoomDTO roomDTO);
	
	public int messageTitle(String message,long roomNo);
	
	public List<RoomDTO> selectChatList(long memberNo);
}
