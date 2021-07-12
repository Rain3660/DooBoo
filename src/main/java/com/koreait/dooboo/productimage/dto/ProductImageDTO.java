package com.koreait.dooboo.productimage.dto;

public class ProductImageDTO {
	
	private long productImageNo;
	private long productNo;
	private String productImage1;
	private String productImage2;
	private String productImage3;
	
	public ProductImageDTO() {
		// TODO Auto-generated constructor stub
	}

	public long getProductImageNo() {
		return productImageNo;
	}

	public void setProductImageNo(long productImageNo) {
		this.productImageNo = productImageNo;
	}

	public long getProductNo() {
		return productNo;
	}

	public void setProductNo(long productNo) {
		this.productNo = productNo;
	}

	public String getProductImage1() {
		return productImage1;
	}

	public void setProductImage1(String productImage1) {
		this.productImage1 = productImage1;
	}

	public String getProductImage2() {
		return productImage2;
	}

	public void setProductImage2(String productImage2) {
		this.productImage2 = productImage2;
	}

	public String getProductImage3() {
		return productImage3;
	}

	public void setProductImage3(String productImage3) {
		this.productImage3 = productImage3;
	}

	@Override
	public String toString() {
		return "ProductImageDTO [productImageNo=" + productImageNo + ", productNo=" + productNo + ", productImage1="
				+ productImage1 + ", productImage2=" + productImage2 + ", productImage3=" + productImage3 + "]";
	}
	
	
}
