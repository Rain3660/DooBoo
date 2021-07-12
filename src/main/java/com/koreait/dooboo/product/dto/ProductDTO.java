package com.koreait.dooboo.product.dto;

import java.sql.Date;

public class ProductDTO {

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

    // 상품위치(시) ex)서울특별시
    private String city;

    // 상품위치(구) ex)마포구
    private String region;

    // 상품위치(상세주소) ex)서강로136 3층
    private String location;

    // 등록자 회원번호
    private long regNo;

    // 수정자 회원번호
    private long modNo;

    // 등록일 등록일
    private Date regDate;

    // 수정일 수정일
    private Date modDate;

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

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
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
}
