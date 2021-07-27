package com.koreait.dooboo.reply.dao;

import java.util.List;
import java.util.Map;

import com.koreait.dooboo.reply.dto.ReplyDTO;

public interface ReplyDAO {
	public int insertReply(ReplyDTO dto);
	public List<ReplyDTO> selectAllReply(long boardNo);
	public int deleteReply(long replyNo);
	public int getReplyCount(long boardNo);
	public List<ReplyDTO> selectReplyListForPaging(Map map);
}
