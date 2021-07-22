package com.koreait.dooboo.product.dto;

import java.sql.Date;
import java.util.List;

import com.koreait.dooboo.communityboard.dto.ListPagingDTO;
import com.koreait.dooboo.util.FileUpload;

public class ProductDTO extends ListPagingDTO{

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
    
    public ProductDTO() {
    	
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
	
	 // 첨부파일 
    private List<ProductimageDTO> productImageList; 
    
    public List<ProductimageDTO> getProductImageList() {
		return productImageList;
	}


	public void setProductImageList(List<ProductimageDTO> productImageList) {
		this.productImageList = productImageList;
	}

	// 첨부파일 
    private List<FileUpload> fileUploadList; 
    

	public List<FileUpload> getFileUploadList() {
		return fileUploadList;
	}


	public void setFileUploadList(List<FileUpload> fileUploadList) {
		this.fileUploadList = fileUploadList;
	}

    
	@Override
	public String toString() {
		return "ProductDTO [productNo=" + productNo + ", title=" + title + ", price=" + price + ", hit=" + hit
				+ ", content=" + content + ", status=" + status + ", address=" + address + ", regNo=" + regNo
				+ ", modNo=" + modNo + ", regDate=" + regDate + ", modDate=" + modDate + "]";
	}
    
}
