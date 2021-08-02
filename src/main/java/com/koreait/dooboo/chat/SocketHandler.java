package com.koreait.dooboo.chat;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.koreait.dooboo.chat.dao.ChatDAO;
import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;
import com.koreait.dooboo.util.FileWriterAndReader;

@Component
public class SocketHandler extends TextWebSocketHandler {
	
	//HashMap<String, WebSocketSession> sessionMap = new HashMap<>(); //웹소켓 세션을 담아둘 맵
	List<HashMap<String, Object>> rls = new ArrayList<>(); //웹소켓 세션을 담아둘 리스트 ---roomListSessions
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws ParseException {
		
		//메시지 발송
		String msg = message.getPayload();  //현재 접속한 유저의 방번호와 session아이디,유저이름,메세지내용
		JSONObject obj = jsonToObjectParser(msg);
		String rN = (String) obj.get("roomNumber"); //방번호
		HashMap<String, Object> temp = new HashMap<String, Object>(); //찾아낸 방의 정보를 담기위한 Map
		if(rls.size() > 0) {  //rls에는 모든 방정보가 담겨있다  == 방이 하나라도 있다면 이라는뜻
			for(int i=0; i<rls.size(); i++) {     //반복문을 통해서 방의 번호르 뽑아내내고 그중에 '현재'들어온 방번호를 찾아낸다.
				String roomNumber = (String) rls.get(i).get("roomNumber"); //세션리스트의 저장된 방번호를 가져와서
				if(roomNumber.equals(rN)) { //같은값의 방이 존재한다면
					temp = rls.get(i); //해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다.
					break;
				}
			}
			//해당 방의 세션들만 찾아서 메시지를 발송해준다.
			for(String k : temp.keySet()) { 
				if(k.equals("roomNumber")) { //다만 방번호일 경우에는 건너뛴다.
					continue;
				}
				WebSocketSession wss = (WebSocketSession) temp.get(k);  //temp에서 roomNumber를 제외한 id,url(Map에서 key값임)을 구해 wss에 넣어준다.
				//방금 전송된 메세지는 그대로있고 메세지는 JSON구조이지만 String 받고 JSON으로 파싱하여
				//방금 전송한 사람의 SessionId,RoomNo를 구해 현재 있는 RoomNo와 비교하여 일치하는 곳을 찾고
				//일치된 방의 모든 세션정보를 가져온다(이 세션안에는 현재 들어가있는 클라이언트의 SessionId와 url이 존재한다)
				//그리고 세션정보를 가져와 해당되는 sessionId에게먼 메세지를 다시 전송해준다.				
				if(wss != null) { //해당방에 한명이라도 존재한다면~
					
					try {	
						ChatDAO chatDAO = sqlSession.getMapper(ChatDAO.class);
						chatDAO.messageTitle((String)obj.get("msg"), Long.parseLong(rN));
						
						wss.sendMessage(new TextMessage(obj.toJSONString()));
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}

			try {
			//String DIR = "C:\\Users\\온석태\\Desktop\\chat";
			String DIR = "C:\\chat";
			String fileName = (String) obj.get("fileName");
			File file = new File(DIR,fileName);
			MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
			long memberNo = Long.parseLong((String) obj.get("memberNo"));
			MemberDTO memberDTO = memberDAO.selectMemberByMemberNo(memberNo);
			FileWriterAndReader.getFileWriter(file, (String)obj.get("userName"), (String)obj.get("msg"),(String)obj.get("day"),(String)obj.get("time"));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {//방에 입장을 시도했을때
		//소켓 연결
		super.afterConnectionEstablished(session); //세션을 넣어준다. 순회
		boolean flag = false; 
		String url = session.getUri().toString(); //세션을 통해 url를 자겨온다
		String roomNumber = url.split("/chating/")[1]; 
		//"ws://localhost:9090/ROOT/chating/"+$("#roomNumber").val()
		//이런식으로 url이 넘어오면 /chatting/으로 split 하고 1번째 index의 roomNumber를 가져온다
		int idx = rls.size(); //방의 사이즈를 조사한다. (현재 세션에 들어있는 모든방의 그리고 거기에들어가있는 세션들 조회)
		if(rls.size() > 0) { //방이있다면~
			for(int i=0; i<rls.size(); i++) { //반복문으로 roomNumber와 일치하는것들을 조회
				String rN = (String) rls.get(i).get("roomNumber");
				if(rN.equals(roomNumber)) { //방번호가 일치한다면
					flag = true; //일치하는 방이있다는 신호를 주기위해
					idx = i; 	//방의 인덱스 번호(== rls.get(idx) 일치하는 인덱스번호)
					break;
				}
			}
		}
		
		if(flag) { //존재하는 방이라면 세션만 추가한다.
			HashMap<String, Object> map = rls.get(idx);
			map.put(session.getId(), session); //새로들어온 클라이언트에 id가 저장된 session을 저장한다. map에 저장한다는것을 ==rls.get에 저장한다는것과 같은의미
		}else { //최초 생성하는 방이라면 방번호와 세션을 추가한다.
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("roomNumber", roomNumber);
			map.put(session.getId(), session);
			rls.add(map);
		}
		
		//세션등록이 끝나면 발급받은 세션ID값의 메시지를 발송한다.
		JSONObject obj = new JSONObject();
		obj.put("type", "getId");
		obj.put("sessionId", session.getId());
		session.sendMessage(new TextMessage(obj.toJSONString()));
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		
		//소켓 종료
		if(rls.size() > 0) { //소켓이 종료되면 해당 세션값들을 찾아서 지운다.
			for(int i=0; i<rls.size(); i++) {
				rls.get(i).remove(session.getId());
			}
		}
		super.afterConnectionClosed(session, status);
	}
	
	private static JSONObject jsonToObjectParser(String jsonStr) {
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(jsonStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return obj;
	}
}