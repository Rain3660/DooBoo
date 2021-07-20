package com.koreait.dooboo.map.dto;

public class MapDTO {
	private long mapNo;
	private long memberNo;
	private String location;
	private int locationOrd;
	
	public MapDTO() {}

	public MapDTO(long memberNo, String location) {
		super();
		this.memberNo = memberNo;
		this.location = location;
	}

	public long getMapNo() {
		return mapNo;
	}

	public void setMapNo(long mapNo) {
		this.mapNo = mapNo;
	}

	public long getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getLocationOrd() {
		return locationOrd;
	}

	public void setLocationOrd(int locationOrd) {
		this.locationOrd = locationOrd;
	}
	
	



	

	

	
	
	
}
