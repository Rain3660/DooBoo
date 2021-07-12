package com.koreait.dooboo.product.dto;

import java.sql.Date;

public class ProductDTO {
	private long productNo;
	private String productTitle;
	private int price;
	private int hit;
	private String productContent;
	private String nickname;
	private Date postdate;
	private Date lastmodified;
	private int productOnsale;
	private String productCity;
	private String productRegion;
	private String productLocation;
	
	public ProductDTO() {
		// TODO Auto-generated constructor stub
	}

	public long getProductNo() {
		return productNo;
	}

	public void setProductNo(long productNo) {
		this.productNo = productNo;
	}

	public String getProductTitle() {
		return productTitle;
	}

	public void setProductTitle(String productTitle) {
		this.productTitle = productTitle;
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

	public String getProductContent() {
		return productContent;
	}

	public void setProductContent(String productContent) {
		this.productContent = productContent;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public Date getPostdate() {
		return postdate;
	}

	public void setPostdate(Date postdate) {
		this.postdate = postdate;
	}

	public Date getLastmodified() {
		return lastmodified;
	}

	public void setLastmodified(Date lastmodified) {
		this.lastmodified = lastmodified;
	}

	public int getProductOnsale() {
		return productOnsale;
	}

	public void setProductOnsale(int productOnsale) {
		this.productOnsale = productOnsale;
	}

	public String getProductCity() {
		return productCity;
	}

	public void setProductCity(String productCity) {
		this.productCity = productCity;
	}

	public String getProductRegion() {
		return productRegion;
	}

	public void setProductRegion(String productRegion) {
		this.productRegion = productRegion;
	}

	public String getProductLocation() {
		return productLocation;
	}

	public void setProductLocation(String productLocation) {
		this.productLocation = productLocation;
	}

	@Override
	public String toString() {
		return "ProductDTO [productNo=" + productNo + ", productTitle=" + productTitle + ", price=" + price + ", hit="
				+ hit + ", productContent=" + productContent + ", nickname=" + nickname + ", postdate=" + postdate
				+ ", lastmodified=" + lastmodified + ", productOnsale=" + productOnsale + ", productCity=" + productCity
				+ ", productRegion=" + productRegion + ", productLocation=" + productLocation + "]";
	}
	
	
}
