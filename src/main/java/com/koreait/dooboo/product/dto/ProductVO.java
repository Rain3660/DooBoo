package com.koreait.dooboo.product.dto;

import java.sql.Date;

import com.koreait.dooboo.communityboard.dto.ListPagingDTO;

public class ProductVO extends ListPagingDTO{
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
    
    //좋아요 수
    private int likecount;
    
    public ProductVO() {}

	public ProductVO(long productNo, String title, int price, int hit, String content, int status, String address,
			long regNo, long modNo, Date regDate, Date modDate, String delYn, int likecount) {
		super();
		this.productNo = productNo;
		this.title = title;
		this.price = price;
		this.hit = hit;
		this.content = content;
		this.status = status;
		this.address = address;
		this.regNo = regNo;
		this.modNo = modNo;
		this.regDate = regDate;
		this.modDate = modDate;
		this.delYn = delYn;
		this.likecount = likecount;
	}

	public long getProductNo() {
		return productNo;
	}

	public void setProductNo(long productNo) {
		this.productNo = productNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public long getRegNo() {
		return regNo;
	}

	public void setRegNo(long regNo) {
		this.regNo = regNo;
	}

	public long getModNo() {
		return modNo;
	}

	public void setModNo(long modNo) {
		this.modNo = modNo;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getModDate() {
		return modDate;
	}

	public void setModDate(Date modDate) {
		this.modDate = modDate;
	}

	public String getDelYn() {
		return delYn;
	}

	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}

	public int getLikecount() {
		return likecount;
	}

	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}
    
    
    
}
