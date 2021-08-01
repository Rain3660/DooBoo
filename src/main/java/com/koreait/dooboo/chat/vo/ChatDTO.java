package com.koreait.dooboo.chat.vo;

public class ChatDTO {
	private String writer;
	private String content;
	private String time;
	
	public ChatDTO() {}
	
	
	
	
	public ChatDTO(String writer, String content, String time) {
		super();
		this.writer = writer;
		this.content = content;
		this.time = time;
	}




	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
