package com.koreait.dooboo.product.dto;

import java.sql.Date;

// 상품이미지를 저장하는 테이블 이미지는 3개까지
public class ProductimageDTO {

    // 상품번호 
    private int productNo;

    // 파일번호 1부터 시작
    private int fileNo;

    // 파일경로 확장자도 포함한 파일경로, 저장핧때는 파일명이 중복되면 덮어씌어지기 때문에 파일명을 변경해서 넣어준다.
    private String filePath;

    // 파일원본명 
    private String fileName;

    // 등록자 회원번호
    private int regNo;

    // 등록일 등록일
    private Date regDate;

    public int getProductNo() {
        return productNo;
    }

    public void setProductNo(int productNo) {
        this.productNo = productNo;
    }

    public int getFileNo() {
        return fileNo;
    }

    public void setFileNo(int fileNo) {
        this.fileNo = fileNo;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getRegNo() {
        return regNo;
    }

    public void setRegNo(int regNo) {
        this.regNo = regNo;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    // Productimage 모델 복사
    public void CopyData(ProductimageDTO param)
    {
        this.productNo = param.getProductNo();
        this.fileNo = param.getFileNo();
        this.filePath = param.getFilePath();
        this.fileName = param.getFileName();
        this.regNo = param.getRegNo();
        this.regDate = param.getRegDate();
    }
}