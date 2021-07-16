package com.koreait.dooboo.map.dto;

public class MapDTO {
	private long mapNo;
	private long memberNo;
	private String location;
	
	public MapDTO() {}
	
	

	public MapDTO( long memberNo, String location) {
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



	@Override
	public String toString() {
		return "MapDTO [mapNo=" + mapNo + ", memberNo=" + memberNo + ", location=" + location + "]";
	}

	
	
	
}