package com.koreait.dooboo.vo;

import java.sql.Date;
import java.util.List;

import com.koreait.dooboo.product.dto.ProductimageDTO;

public class ProductVO {
	
	private String nickname;
	private long regNo;
	private String content;
	private long modNo;
	private Date modDate;
	private Date regDate;
	private long productNo;
	private String title;
	private String address;
	private int price;
	private int hit;
	private int likeCount;
	private String images;
	private List<ProductimageDTO> productImageList;
	private List<String> imageList;
	
	public List<String> getImageList() {
		return imageList;
	}

	public void setImageList(List<String> imageList) {
		this.imageList = imageList;
	}

	public ProductVO() {
		// TODO Auto-generated constructor stub
	}

	public List<ProductimageDTO> getProductImageList() {
		return productImageList;
	}

	public void setProductImageList(List<ProductimageDTO> productImageList) {
		this.productImageList = productImageList;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public long getRegNo() {
		return regNo;
	}

	public void setRegNo(long regNo) {
		this.regNo = regNo;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public long getModNo() {
		return modNo;
	}

	public void setModNo(long modNo) {
		this.modNo = modNo;
	}

	public Date getModDate() {
		return modDate;
	}

	public void setModDate(Date modDate) {
		this.modDate = modDate;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public String getImages() {
		return images;
	}

	public void setImages(String images) {
		this.images = images;
	}

	@Override
	public String toString() {
		return "ProductVO [nickname=" + nickname + ", regNo=" + regNo + ", content=" + content + ", modNo=" + modNo
				+ ", modDate=" + modDate + ", regDate=" + regDate + ", productNo=" + productNo + ", title=" + title
				+ ", address=" + address + ", price=" + price + ", hit=" + hit + ", likeCount=" + likeCount
				+ ", images=" + images + "]";
	}
}
