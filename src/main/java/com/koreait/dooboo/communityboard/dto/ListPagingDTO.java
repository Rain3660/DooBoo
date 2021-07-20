package com.koreait.dooboo.communityboard.dto;

public class ListPagingDTO{
	private int currentPageNo=1; // 현재 페이지 번호
	private int recordsPerPage=2; // 페이지당 출력할 데이터 개수
	private int pageSize=10; // 화면 화단에 출력할 페이지 사이즈
	private String searchKeyword; // 검색 키워드
	private String searchType; // 검색 유형
	
	public int getStartPage() {
		return(currentPageNo -1) * recordsPerPage + 1;
	}
	
	public int getEndPage() {
		return currentPageNo * recordsPerPage;
	}	

	public int getCurrentPageNo() {
		return currentPageNo;
	}

	public void setCurrentPageNo(int currentPageNo) {
		this.currentPageNo = currentPageNo;
	}

	public int getRecordsPerPage() {
		return recordsPerPage;
	}

	public void setRecordsPerPage(int recordsPerPage) {
		this.recordsPerPage = recordsPerPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	// 검색 조건을 한 글자로 하고, 배열로 만들어서 한 번에 처리
	public String[] getTypeArr() {
		return searchType == null?new String[] {} : searchType.split("");
	}
	
	
	
}
