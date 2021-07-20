package com.koreait.dooboo.map.dto;

public class MapLocationCheckDTO {
	private long mapNo;
	private int isChecked;
	
	public MapLocationCheckDTO() {}

	public MapLocationCheckDTO(long mapNo, int isChecked) {
		super();
		this.mapNo = mapNo;
		this.isChecked = isChecked;
	}

	public long getMapNo() {
		return mapNo;
	}

	public void setMapNo(long mapNo) {
		this.mapNo = mapNo;
	}

	public int getIsChecked() {
		return isChecked;
	}

	public void setIsChecked(int isChecked) {
		this.isChecked = isChecked;
	}

	

	
	
	
}
