package com.koreait.dooboo.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.koreait.dooboo.chat.vo.ChatDTO;

public class FileWriterAndReader {

	
	public static void getFileWriter(File file,String nickname,String content,String day,String time) throws IOException, ParseException {
		FileWriter fw = null;
		BufferedWriter bw = null;
		List<ChatDTO> list =  getReadFile(file);
		int lastIndex = list.size()-1;
		ChatDTO checkDTO = list.get(lastIndex);
		if(!checkDTO.getTime().equals(time)) {
		try {
				
			 fw = new FileWriter(file,true);
			 bw = new BufferedWriter(fw);
			 JSONObject obj = new JSONObject();
			 obj.put("nickName", nickname);
			 obj.put("content", content);
			 obj.put("day", day);
			 obj.put("time", time);
			 bw.write(obj.toString());
			 bw.newLine();			 
			 bw.flush();
			 fw.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(bw!= null) {bw.close();}
				if(fw!= null) {fw.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	  }
	}
	
	public static List<ChatDTO> getReadFile(File file) throws IOException, ParseException {
		List<ChatDTO> list = new ArrayList<ChatDTO>();
		FileReader fr = new FileReader(file);
		BufferedReader br = new BufferedReader(fr);
		String readLine = null;
		while((readLine = br.readLine())!= null) {
			JSONParser parser = new JSONParser();		
			JSONObject obj =(JSONObject) parser.parse(readLine);
			String writer = (String) obj.get("nickName");
			String content = (String) obj.get("content");
			String time = (String) obj.get("time");
			ChatDTO chatDTO = new ChatDTO(writer, content,time);
			list.add(chatDTO);
		}
		fr.close();
		br.close();

		return list;
		
	
	}
}
