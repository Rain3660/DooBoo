package com.koreait.dooboo.map.dto;

public class MapSessionDTO {
	private long mapNo;
	private long memberNo;
	private String location;
	private int locationOrd;
	private int isChecked;
	private int usenow;
	
	public MapSessionDTO() {}

	
	

	public MapSessionDTO(long mapNo, long memberNo, String location, int locationOrd, int isChecked, int usenow) {
		super();
		this.mapNo = mapNo;
		this.memberNo = memberNo;
		this.location = location;
		this.locationOrd = locationOrd;
		this.isChecked = isChecked;
		this.usenow = usenow;
	}




	public int getUsenow() {
		return usenow;
	}

	public void setUsenow(int usenow) {
		this.usenow = usenow;
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

	public int getIsChecked() {
		return isChecked;
	}

	public void setIsChecked(int isChecked) {
		this.isChecked = isChecked;
	}




	@Override
	public String toString() {
		return "MapSessionDTO [mapNo=" + mapNo + ", memberNo=" + memberNo + ", location=" + location + ", locationOrd="
				+ locationOrd + ", isChecked=" + isChecked + ", usenow=" + usenow + "]";
	}


	
	
	
	
	
	
}
