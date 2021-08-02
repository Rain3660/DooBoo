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
						//메세지함을 열었을때 다른사람들과 주고받았던 메세지 리스트를 뿌려주는데 가장 마지막에 올린 메세지를 보일수있도록 따로 데이터베이스에 저장
						wss.sendMessage(new TextMessage(obj.toJSONString())); //이곳은 서버에서 클라이언트로 다시 보내주는것이다
						//소캣통신의 구조는 클라이언트가 서버에 메세지를 보내면 서버에서 그 메세지를 누구한테 뿌려줄지 판단한후 sessionId를 기준으로
						//해당하는 클라이언트에게 메세지를 다시 반환해준다 
						//클라이언트입장에서는 자신이 보낸 메세지가 대화상단에 바로뜨지만 사실 그 메세지는 서버에갔다가 나에게 그리고 전송하려는 사람에게
						//총 같은메세지가 2번 전송된것이다
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}

			try {
			//String DIR = "C:\\Users\\온석태\\Desktop\\chat";
			String DIR = "C:\\chat";     //파일을 저장하려는 경로
			String fileName = (String) obj.get("fileName"); //서버로 메세지가 넘어왔을때는 이미 파일이 만들어저있는 상태이다.
			File file = new File(DIR,fileName); //경로와 파일이름을 넣어서 새로은 file을 생성한다
			FileWriterAndReader.getFileWriter(file, (String)obj.get("userName"), (String)obj.get("msg"),(String)obj.get("day"),(String)obj.get("time"));
			//미리 만들어둔 FileWriter를 통해 해당하는 파일(text파일) 에 JSON형식으로 내용을 추가해서 저장한다 JSON으로 파싱하는과정은 getFileWriter메소드 안에있다.
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
			map.put("roomNumber", roomNumber); //방의정보를 map에 저장
			map.put(session.getId(), session); //해당하는 SessionId를 map에 저장
			rls.add(map); //저장한 방을 rls에 저장해준다
		}
		
		//세션등록이 끝나면 발급받은 세션ID값의 메시지를 발송한다.
		JSONObject obj = new JSONObject();
		obj.put("type", "getId");
		obj.put("sessionId", session.getId());
		session.sendMessage(new TextMessage(obj.toJSONString())); 
		//이 메세지는 다시 chat.jsp로 돌아가 저장해준다
		//현재 afterConnectionEstablished 이 메소드는 오로지 sessionId 발급을 위한것이다
		//방에 입장하고 클라이언트의 고유 sessionId를 발급을 해주고 다시 클라이언트에게 본인의 sessionId를 알려준다
		//이 SessionId는 방에 입장할때마다 게속 랜덤으로 생성되기에 클라이언트 자신의 sessionId가 무엇인지 알아야 
		//메세지 전송시 서버에갔다 다시 클라이언트로 보낼때 구분이 가능하기때문이다.
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		
		//소켓 종료
		if(rls.size() > 0) { //소켓이 종료되면 해당 세션값들을 찾아서 지운다.
			for(int i=0; i<rls.size(); i++) {
				rls.get(i).remove(session.getId());
			}
		}
		super.afterConnectionClosed(session, status); //나간사람의 세션을 지워준다 
		//나간다는것은 단순히 대화창을 끄면 세션이 없어지고 다시 대화방에 들어가면 다시 생성된다.
	}
	
	private static JSONObject jsonToObjectParser(String jsonStr) { //제이슨으로 변환해주기위해 유틸형식의 메소드 생성
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