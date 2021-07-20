package com.koreait.dooboo.map.dao;

import java.util.List;

import com.koreait.dooboo.map.dto.MapDTO;
import com.koreait.dooboo.map.dto.MapLocationCheckDTO;

public interface MapDAO {
	public int insertLocation(MapDTO mapDTO);
	public int CheckLocation(MapLocationCheckDTO mapLocationCheckDTO);
	public long getMapNo(MapDTO mapDTO);
	public List<MapDTO> getLocation(long loginUserNo);
	public int isChecked(long mapNo);
	public int mapUpdateResult(MapLocationCheckDTO mapLocationCheckDTO);
	public int updateLocation(MapDTO mapDTO);
	public int resetChecked(MapDTO mapDTO);
	public int deleteMapLocationCheck(long mapNo);
	public int deleteMap(long mapNo);
	public MapDTO getOneLocation(long mapNo);
}
