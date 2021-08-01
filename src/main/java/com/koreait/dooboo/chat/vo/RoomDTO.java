package com.koreait.dooboo.chat.vo;

import java.sql.Date;

public class RoomDTO {
	private long roomNo;
	private long buyerNo;
	private long sellerNo;
	private String textPath;
	private String lastMessage; 
	private Date lastModDate;
	private Date regdate;
	private String othersNickname;
	public RoomDTO() {}

	
	

	public RoomDTO(long roomNo, long buyerNo, long sellerNo, String textPath, String lastMessage, Date lastModDate,
			Date regdate) {
		super();
		this.roomNo = roomNo;
		this.buyerNo = buyerNo;
		this.sellerNo = sellerNo;
		this.textPath = textPath;
		this.lastMessage = lastMessage;
		this.lastModDate = lastModDate;
		this.regdate = regdate;
	}




	public String getOthersNickname() {
		return othersNickname;
	}




	public void setOthersNickname(String othersNickname) {
		this.othersNickname = othersNickname;
	}




	public String getLastMessage() {
		return lastMessage;
	}

	public void setLastMessage(String lastMessage) {
		this.lastMessage = lastMessage;
	}

	public long getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(long roomNo) {
		this.roomNo = roomNo;
	}

	public long getBuyerNo() {
		return buyerNo;
	}

	public void setBuyerNo(long buyerNo) {
		this.buyerNo = buyerNo;
	}

	public long getSellerNo() {
		return sellerNo;
	}

	public void setSellerNo(long sellerNo) {
		this.sellerNo = sellerNo;
	}

	public String getTextPath() {
		return textPath;
	}

	public void setTextPath(String textPath) {
		this.textPath = textPath;
	}

	public Date getLastModDate() {
		return lastModDate;
	}

	public void setLastModDate(Date lastModDate) {
		this.lastModDate = lastModDate;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "RoomDTO [roomNo=" + roomNo + ", buyerNo=" + buyerNo + ", sellerNo=" + sellerNo + ", textPath="
				+ textPath + ", lastMessage=" + lastMessage + ", lastModDate=" + lastModDate + ", regdate=" + regdate
				+ "]";
	}

	
}
