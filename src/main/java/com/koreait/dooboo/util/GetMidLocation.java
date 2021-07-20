package com.koreait.dooboo.util;

public class GetMidLocation {
	public static String getMidLocation(String FullLocation) {
		String [] FullLocationArr = FullLocation.split(" ");
		String midLocation = FullLocationArr[1];
		
		return midLocation;
	}
}
