package com.koreait.dooboo.reply.command;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.springframework.ui.Model;

import com.koreait.dooboo.reply.dao.ReplyDAO;
import com.koreait.dooboo.reply.dto.ReplyDTO;

public class SelectAllReplyCommand {

	public Map<String, Object> execute(SqlSession session, Model model) {
       
		
		Map<String, Object> map = model.asMap();
		long boardNo = (long) map.get("boardNo");
	   int page = (int) map.get("page");
	
		
		ReplyDAO replyDAO = session.getMapper(ReplyDAO.class);
		

		
		int totalRecord = replyDAO.getReplyCount(boardNo);

		
		int recordPerPage = 5;
				
		int beginRecord = (page - 1) * recordPerPage + 1;
		int endRecord = beginRecord + recordPerPage - 1;
		endRecord = (endRecord < totalRecord) ? endRecord : totalRecord;
		
		
		Map<String, Object> record = new HashMap<String, Object>();
		 record.put("beginRecord", beginRecord);
		 record.put("endRecord", endRecord);
		 record.put("boardNo", boardNo);
		
		 
	    List<ReplyDTO> list = replyDAO.selectReplyListForPaging(record);
		
		
		int totalPage = totalRecord / recordPerPage;
		if (totalRecord % recordPerPage != 0) {
			totalPage++;
		}
		int pagePerBlock = 3;
		int beginPage = ((page - 1) / pagePerBlock) * pagePerBlock + 1;
		int endPage = beginPage + pagePerBlock - 1;
		endPage = endPage < totalPage ? endPage : totalPage;
		
		
		Map<String, Integer> paging = new HashMap<>();
		paging.put("totalRecord", totalRecord);
		paging.put("page", page);
		paging.put("totalPage", totalPage);
		paging.put("pagePerBlock", pagePerBlock);
		paging.put("beginPage", beginPage);
		paging.put("endPage", endPage);
		
		
		
		Map<String, Object> result = new HashMap<>();
	
		result.put("list", list);
		result.put("paging", paging);
	   
		return result;

	}

}
