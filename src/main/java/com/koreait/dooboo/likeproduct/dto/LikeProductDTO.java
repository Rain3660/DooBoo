package com.koreait.dooboo.likeproduct.dto;

public class LikeProductDTO {
	private long likeProductNo;
	private long productNo;
	private long memberNo;
	
	public LikeProductDTO() {
		// TODO Auto-generated constructor stub
	}

	public long getLikeProductNo() {
		return likeProductNo;
	}

	public void setLikeProductNo(long likeProductNo) {
		this.likeProductNo = likeProductNo;
	}

	public long getProductNo() {
		return productNo;
	}

	public void setProductNo(long productNo) {
		this.productNo = productNo;
	}

	public long getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}

	@Override
	public String toString() {
		return "LikeProductDTO [likeProductNo=" + likeProductNo + ", productNo=" + productNo + ", memberNo=" + memberNo
				+ "]";
	}
	
	
}
