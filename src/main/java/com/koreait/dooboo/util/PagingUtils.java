package com.koreait.dooboo.util;

import com.koreait.dooboo.vo.PageVO;

public class PagingUtils {

	// 메인페이지에 뿌려줄 리스트의 페이지를 정의
	// 한 페이지당 12개 , 블럭당 5페이지를 가져오겠다.
	// field
	public static int recordPerPage = 12;
	public static int beginRecord;
	public static int endRecord;

	public static int pagePerBlock = 5;
	public static int totalPage;
	public static int beginPage;
	public static int endPage;
	
	// ajax 처리하기 떄문에 여기까지~
	public static PageVO getPage(int totalRecord, int page) {
		beginRecord = (page - 1) * recordPerPage + 1;
		endRecord = Math.min(beginRecord + recordPerPage - 1, totalRecord);

		totalPage = (totalRecord / recordPerPage) + (totalRecord % recordPerPage > 0 ? 1 : 0);
		beginPage = ((page - 1) / pagePerBlock) * pagePerBlock + 1;
		endPage = Math.min(beginPage + pagePerBlock - 1, totalPage);

		PageVO pageVO = new PageVO();

		pageVO.setPage(page);
		pageVO.setTotalRecord(totalRecord);
		pageVO.setTotalPage(totalPage);
		pageVO.setRecordPerPage(recordPerPage);
		pageVO.setBeginRecord(beginRecord);
		pageVO.setEndRecord(endRecord);
		pageVO.setPagePerBlock(pagePerBlock);
		pageVO.setEndPage(endPage);
		pageVO.setBeginPage(beginPage);

		return pageVO;
	}
}
