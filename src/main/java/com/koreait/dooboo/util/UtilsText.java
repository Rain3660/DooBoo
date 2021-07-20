package com.koreait.dooboo.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class UtilsText {
	/**
	 * 현재 날짜, 시간으로 정해진 포맷을 리턴한다 파일 업로드시 리네임에 사용한다
	 * 
	 * @Desc :
	 * @Method Name : parseFileRename
	 * @Date : 2021. 07. 19.
	 * @Author : Hong boram
	 * @return
	 */
	public static String parseFileRename() {
		long time = System.currentTimeMillis();
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS", Locale.KOREA);
		String strDt = dayTime.format(new Date(time));
	
		return strDt;
	}
	
	/**
	 * 파일 path 생성
	 * 
	 * @Desc :
	 * @Method Name : getFilePath
	 * @Date : 2021. 07. 19.
	 * @Author : Hong boram
	 * @param path
	 * @return
	 */
	private String getFilePath(String... path) {

		String fileSeparator = "/";
		StringBuilder sb = new StringBuilder();
		long time = System.currentTimeMillis();
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMM", Locale.KOREA);
		String strDt = dayTime.format(new Date(time));

		sb.append(fileSeparator);
		for (String str : path) {
			sb.append(str).append(fileSeparator);
		}
		sb.append(strDt).append(fileSeparator);

		return sb.toString();
	}	
}

