package com.koreait.dooboo.map.dto;

public class MapSessionDTO {
	private String location;
	private long memberNo;
	private long mapNo;
	private int result;
	
	public MapSessionDTO() {}

	public MapSessionDTO(String location, long memberNo, long mapNo, int result) {
		super();
		this.location = location;
		this.memberNo = memberNo;
		this.mapNo = mapNo;
		this.result = result;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public long getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}

	public long getMapNo() {
		return mapNo;
	}

	public void setMapNo(long mapNo) {
		this.mapNo = mapNo;
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}
	
	
	
	
}
