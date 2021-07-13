package com.koreait.dooboo.util;

public class ListPagingInfo {


	/** 페이징 계산에 필요한 파라미터들이 담긴 클래스 */
	private ListPagingDTO listPagingVo;
	
	/** 전체 데이터 개수 */
	private int totalRecordCount;

	/** 전체 페이지 개수 */
	private int totalPageCount;

	/** 페이지 리스트의 첫 페이지 번호 */
	private int firstPage;

	/** 페이지 리스트의 마지막 페이지 번호 */
	private int lastPage;
	
	/** SQL의 조건절에 사용되는 첫 RNUM */
	private int firstRecordIndex;

	/** SQL의 조건절에 사용되는 마지막 RNUM */
	private int lastRecordIndex;

	/** 이전 페이지 존재 여부 */
	private boolean hasPreviousPage;

	/** 다음 페이지 존재 여부 */
	private boolean hasNextPage;
	
	
	public ListPagingDTO getListPagingVo() {
		return listPagingVo;
	}



	public void setListPagingVo(ListPagingDTO boardDTO) {
		this.listPagingVo = boardDTO;
	}



	public int getTotalPageCount() {
		return totalPageCount;
	}



	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}



	public int getFirstPage() {
		return firstPage;
	}



	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}



	public int getLastPage() {
		return lastPage;
	}



	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}



	public int getFirstRecordIndex() {
		return firstRecordIndex;
	}



	public void setFirstRecordIndex(int firstRecordIndex) {
		this.firstRecordIndex = firstRecordIndex;
	}



	public int getLastRecordIndex() {
		return lastRecordIndex;
	}



	public void setLastRecordIndex(int lastRecordIndex) {
		this.lastRecordIndex = lastRecordIndex;
	}



	public boolean isHasPreviousPage() {
		return hasPreviousPage;
	}



	public void setHasPreviousPage(boolean hasPreviousPage) {
		this.hasPreviousPage = hasPreviousPage;
	}



	public boolean isHasNextPage() {
		return hasNextPage;
	}



	public void setHasNextPage(boolean hasNextPage) {
		this.hasNextPage = hasNextPage;
	}



	public int getTotalRecordCount() {
		return totalRecordCount;
	}



	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;

		if (totalRecordCount > 0) {
			calculation();
		}
	}

	private void calculation() {

		/* 전체 페이지 수 (현재 페이지 번호가 전체 페이지 수보다 크면 현재 페이지 번호에 전체 페이지 수를 저장) */
		totalPageCount = ((totalRecordCount - 1) / listPagingVo.getRecordsPerPage()) + 1;
		if (listPagingVo.getCurrentPageNo() > totalPageCount) {
			listPagingVo.setCurrentPageNo(totalPageCount);
		}

		/* 페이지 리스트의 첫 페이지 번호 */
		firstPage = ((listPagingVo.getCurrentPageNo() - 1) / listPagingVo.getPageSize()) * listPagingVo.getPageSize() + 1;

		/* 페이지 리스트의 마지막 페이지 번호 (마지막 페이지가 전체 페이지 수보다 크면 마지막 페이지에 전체 페이지 수를 저장) */
		lastPage = firstPage + listPagingVo.getPageSize() - 1;
		if (lastPage > totalPageCount) {
			lastPage = totalPageCount;
		}

		
		/* SQL의 조건절에 사용되는 첫 RNUM */
		firstRecordIndex = (listPagingVo.getCurrentPageNo() - 1) * listPagingVo.getRecordsPerPage();

		/* SQL의 조건절에 사용되는 마지막 RNUM */
		lastRecordIndex = listPagingVo.getCurrentPageNo() * listPagingVo.getRecordsPerPage();

		/* 이전 페이지 존재 여부 */
		hasPreviousPage = firstPage != 1;

		/* 다음 페이지 존재 여부 */
		hasNextPage = (lastPage * listPagingVo.getRecordsPerPage()) < totalRecordCount;
	}

}

