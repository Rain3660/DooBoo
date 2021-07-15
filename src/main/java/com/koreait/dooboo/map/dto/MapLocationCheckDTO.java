package com.koreait.dooboo.map.dto;

public class MapLocationCheckDTO {
	private long mapNo;
	private int result;
	
	public MapLocationCheckDTO() {}

	public MapLocationCheckDTO(long mapNo, int result) {
		super();
		this.mapNo = mapNo;
		this.result = result;
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
