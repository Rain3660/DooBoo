package com.koreait.dooboo.likeproduct.dto;
import java.sql.Date;

// 좋아요 테이블
public class LikeProductDTO {

    // 상품번호 
    private long productNo;

    // 등록자 회원번호
    private long regNo;

    // 등록일 등록일
    private Date regDate;
    public LikeProductDTO() {
		// TODO Auto-generated constructor stub
	}
    public long getProductNo() {
        return productNo;
    }

    public void setProductNo(long productNo) {
        this.productNo = productNo;
    }

    public long getRegNo() {
        return regNo;
    }

    public void setRegNo(long regNo) {
        this.regNo = regNo;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }
}