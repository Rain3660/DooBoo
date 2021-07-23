package com.koreait.dooboo.product.dto;

import java.sql.Date;

import com.koreait.dooboo.communityboard.dto.ListPagingDTO;

public class ProductVO extends ListPagingDTO {
	// 상품번호 100 부터 시작
	private long productNo;

	// 상품제목
	private String title;

	// 상품가격
	private int price;

	// 조회수
	private int hit;

	// 상품내용
	private String content;

	// 상품상태 1 : 판매중 , 0 : 판매완료
	private int status;

	// 상품위치(상세주소) ex)서강로136 3층
	private String address;

	// 등록자 회원번호
	private long regNo;

	// 수정자 회원번호
	private long modNo;

	// 등록일 등록일
	private Date regDate;
	// 수정일 수정일
	private Date modDate;

	// 삭제여부
	private String delYn;

	// 좋아요 수
	private int likecount;

}
