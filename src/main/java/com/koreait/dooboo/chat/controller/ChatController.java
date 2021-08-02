package com.koreait.dooboo.chat.controller;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.dooboo.chat.dao.ChatDAO;
import com.koreait.dooboo.chat.vo.ChatDTO;
import com.koreait.dooboo.chat.vo.Room;
import com.koreait.dooboo.chat.vo.RoomDTO;
import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;
import com.koreait.dooboo.util.FileWriterAndReader;



@Controller
public class ChatController {
	@Autowired
	private SqlSession sqlSession;
	
	List<Room> roomList = new ArrayList<Room>();
	static int roomNumber = 0;
	//final static String PATH = "C:\\Users\\온석태\\Desktop\\chat"; //local서버에 text저장경로
	final static String PATH = "C:\\chat"; //메인서버text 저장경로
	
	@PostMapping(value="c.getRoomNumber") //메세지함에 들어갔을때 
	@ResponseBody
	public Map<String, Object> getRoomNumber(HttpServletRequest request){
		Map<String, Object> resultMap = new HashMap<>();
		long buyerNo = Long.parseLong(request.getParameter("buyerNo")); //구매자의 기본키
		long sellerNo = Long.parseLong(request.getParameter("sellerNo"));//판매자의 기본키
		RoomDTO roomDTO = new RoomDTO();
		roomDTO.setBuyerNo(buyerNo);
		roomDTO.setSellerNo(sellerNo);
		ChatDAO chatDAO = sqlSession.getMapper(ChatDAO.class); 
		RoomDTO nowRoomDTO = chatDAO.getRoom(roomDTO);//구매자와판매자의 기본키로 일치하는 방을 찾아낸다
		if(nowRoomDTO != null) {
			resultMap.put("roomNumber", nowRoomDTO.getRoomNo()); //방이있다면 resultMap에 저장해주고 반환시킨다.
		}
		return resultMap;
	}
	
	@RequestMapping("chatPage") //메세지함 ->원하는 채팅방 클릭시
	public ModelAndView chat(HttpServletRequest request,HttpSession session) throws IOException, ParseException {
		List<ChatDTO> list = null;
		long memberNo = Long.parseLong(request.getParameter("memberNo")); //구매자의 기본키
		long sellerNo = Long.parseLong(request.getParameter("sellerNo")); //판매자의 기본키
		int buyer = Integer.parseInt(request.getParameter("buyer")); //자신이 구매자인지 판매자인지 구분하기위해
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		MemberDTO sellerDTO = memberDAO.selectMemberByMemberNo(sellerNo); //판매자의 정보를 가져온다
		MemberDTO memberDTO = memberDAO.selectMemberByMemberNo(memberNo); //구매자의 정보를 가져온다
		String sellerNickName = sellerDTO.getNickname(); //방에서 클라이언트의 닉네임을 사용해 누가 전송한 메세지인지 구분하기위해 
		String memberNickName = memberDTO.getNickname(); //방에서 클라이언트의 닉네임을 사용해 누가 전송한 메세지인지 구분하기위해 

		RoomDTO roomDTO = new RoomDTO(); //데이터베이스에 저장할 dto생성
		roomDTO.setBuyerNo(memberNo);
		roomDTO.setSellerNo(sellerNo);
		ChatDAO chatDAO = sqlSession.getMapper(ChatDAO.class);
		RoomDTO nowRoomDTO = chatDAO.getRoom(roomDTO); //dto에 저장을하고 그전에 채팅한 기록이있는지 판단
		String fileName = "";
		ModelAndView mv = new ModelAndView();
		
		if(nowRoomDTO != null) { //그전에 대화한 기록이 있다면~
			fileName = nowRoomDTO.getTextPath(); //파일네임은 dto에서 저장된 파일이름을 가져온다
			File nowFile = new File(PATH,nowRoomDTO.getTextPath()); //현재 파일의경로와이름을 넣어 읽으려는 file 생성
			list = FileWriterAndReader.getReadFile(nowFile);	//파일을 생성후 util로 만든 ReadFile을 통해 text파일안에있는 내용을 읽어온다
			if(buyer == 1) { //본인이 판매자라면  // buyer ==1 판매자 
				mv.addObject("roomName",sellerNickName);				
			}else { //본인이 구매자라면	//seller == 0 구매자
				mv.addObject("roomName",memberNickName);								
			}
			mv.addObject("roomNumber",nowRoomDTO.getRoomNo()); //판매자든 구매자든 room의 번호는 같다
			
		}else { // 그전에 대화한 기록이 없다면~
			
			
			fileName = memberNo+"_"+sellerNo+".txt"; //파일이름은 구매자No_판매자No.txt
			File DIR = new File(PATH);
				if(!DIR.exists()) { //지정한 경로가 없다면 생성
					DIR.mkdirs();				
				} 	
			File textFile = new File(DIR,fileName);
			textFile.createNewFile(); //여기서 txt파일을 생성
			roomDTO.setTextPath(fileName); //db에 txt파일의 경로를 저장하기위해 dto에 담아준다. 
			int result = chatDAO.insertRoom(roomDTO); //db에 추가해준다
			if(result > 0) { //추가가됬다면
				roomDTO.setBuyerNo(memberNo);
				roomDTO.setSellerNo(sellerNo);
				RoomDTO newRoom = chatDAO.getRoom(roomDTO); //다시 추가한 방을 빼온다
				
				if(buyer == 1) { //본인이 구매자라면 (대화창 상단의 누구와의 대화방을 알려주기위해 본인이 누구인지 알아내고 상대방의 nickname을 가져온다.)
					mv.addObject("roomName",sellerNickName);				
				}else { //본인이 판매자라면
					mv.addObject("roomName",memberNickName);								
				}
				mv.addObject("roomNumber",newRoom.getRoomNo());
			}
			
			
		}
		mv.setViewName("chat/chat2/chat");
		if(list != null) {
			mv.addObject("list",list);			
		}
		
		mv.addObject("fileName", fileName);
		return mv;
	}
	


	@GetMapping("c.selectChatList") //메세지함을 클릭했을때 주고받았던 메세지의 리스트를 뿌려준다.
	public String selectChatList(@RequestParam("memberNo") long memberNo,Model model) {
		ChatDAO chatDAO = sqlSession.getMapper(ChatDAO.class);
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		List<RoomDTO> list =  chatDAO.selectChatList(memberNo);
		for (RoomDTO roomDTO : list) {
			if(memberNo == roomDTO.getBuyerNo()) { //본인의 no와 받은 no가 일치하면 상대방의 닉네임을 반환(본인이 누군지 알수없기때문)
				MemberDTO memberDTO = memberDAO.selectMemberByMemberNo(roomDTO.getSellerNo());
				roomDTO.setOthersNickname(memberDTO.getNickname());
			}else {
				MemberDTO memberDTO = memberDAO.selectMemberByMemberNo(roomDTO.getBuyerNo());				
				roomDTO.setOthersNickname(memberDTO.getNickname());
			}
		}
		model.addAttribute("list",list);
		return"chat/chat2/chatList";
	}
	
}