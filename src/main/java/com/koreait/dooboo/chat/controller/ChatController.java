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
	//final static String PATH = "C:\\Users\\온석태\\Desktop\\chat"; //이거바꿔야함
	final static String PATH = "http://sih8859.iptime.org:8081/dooboo"; //이거바꿔야함
	
	@PostMapping(value="c.getRoomNumber")
	@ResponseBody
	public Map<String, Object> getRoomNumber(HttpServletRequest request){
		Map<String, Object> resultMap = new HashMap<>();
		long buyerNo = Long.parseLong(request.getParameter("buyerNo"));
		long sellerNo = Long.parseLong(request.getParameter("sellerNo"));
		RoomDTO roomDTO = new RoomDTO();
		roomDTO.setBuyerNo(buyerNo);
		roomDTO.setSellerNo(sellerNo);
		ChatDAO chatDAO = sqlSession.getMapper(ChatDAO.class);
		RoomDTO nowRoomDTO = chatDAO.getRoom(roomDTO);
		if(nowRoomDTO != null) {
			resultMap.put("roomNumber", nowRoomDTO.getRoomNo());
		}
		return resultMap;
	}
	
	@RequestMapping("chatPage")
	public ModelAndView chat(HttpServletRequest request,HttpSession session) throws IOException, ParseException {
		List<ChatDTO> list = null;
		long memberNo = Long.parseLong(request.getParameter("memberNo"));
		long sellerNo = Long.parseLong(request.getParameter("sellerNo"));
		int buyer = Integer.parseInt(request.getParameter("buyer"));
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		MemberDTO sellerDTO = memberDAO.selectMemberByMemberNo(sellerNo);
		MemberDTO memberDTO = memberDAO.selectMemberByMemberNo(memberNo);
		String sellerNickName = sellerDTO.getNickname();
		String memberNickName = memberDTO.getNickname();
		
/*		session.setAttribute("memberNo", memberNo);
		session.setAttribute("sellerNo", sellerNo);*/
		RoomDTO roomDTO = new RoomDTO();
		roomDTO.setBuyerNo(memberNo);
		roomDTO.setSellerNo(sellerNo);
		ChatDAO chatDAO = sqlSession.getMapper(ChatDAO.class);
		RoomDTO nowRoomDTO = chatDAO.getRoom(roomDTO);
		String fileName = "";
		ModelAndView mv = new ModelAndView();
		
		if(nowRoomDTO != null) {
			fileName = nowRoomDTO.getTextPath();
			File nowFile = new File(PATH,nowRoomDTO.getTextPath());
			list = FileWriterAndReader.getReadFile(nowFile);		
			if(buyer == 1) {
				mv.addObject("roomName",sellerNickName);				
			}else {
				mv.addObject("roomName",memberNickName);								
			}
			mv.addObject("roomNumber",nowRoomDTO.getRoomNo());
			
		}else {
			
			
			fileName = memberNo+"_"+sellerNo+".txt";
			File DIR = new File(PATH);
				if(!DIR.exists()) {
					DIR.mkdirs();				
				}
			File textFile = new File(DIR,fileName);
			textFile.createNewFile();
			roomDTO.setTextPath(fileName);
			int result = chatDAO.insertRoom(roomDTO);
			if(result > 0) {
				roomDTO.setBuyerNo(memberNo);
				roomDTO.setSellerNo(sellerNo);
				RoomDTO newRoom = chatDAO.getRoom(roomDTO);
				
				if(buyer == 1) {
					mv.addObject("roomName",sellerNickName);				
				}else {
					mv.addObject("roomName",memberNickName);								
				}
				mv.addObject("roomNumber",newRoom.getRoomNo());
			}
			
			
		}
		
		//-------------------------------
/*		Room room = new Room();
		room.setRoomNumber(++roomNumber);
		room.setRoomName("테스트방"); */
		//-------------------------------
	
		mv.setViewName("chat/chat2/chat");
		if(list != null) {
			mv.addObject("list",list);			
		}
		
		mv.addObject("fileName", fileName);
		return mv;
	}
	
	/**
	 * 방 페이지
	 * @return
	 */
	@RequestMapping("room")
	public ModelAndView room() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chat/chat2/room");
		return mv;
	}
	
	/**
	 * 방 생성하기
	 * @param params
	 * @return
	 */
	@RequestMapping("createRoom")
	public @ResponseBody List<Room> createRoom(@RequestParam HashMap<Object, Object> params){
		String roomName = (String) params.get("roomName");
		if(roomName != null && !roomName.trim().equals("")) {
			Room room = new Room();
			room.setRoomNumber(++roomNumber);
			room.setRoomName(roomName);
			roomList.add(room);
		}
		return roomList;
	}
	
	/**
	 * 방 정보가져오기
	 * @param params
	 * @return
	 */
	@RequestMapping("getRoom")
	public @ResponseBody List<Room> getRoom(@RequestParam HashMap<Object, Object> params){
		return roomList;
	}
	
	/**
	 * 채팅방
	 * @return
	 */
	@RequestMapping("moveChating")
	public ModelAndView chating(@RequestParam HashMap<Object, Object> params) {
		ModelAndView mv = new ModelAndView();
		long roomNumber = Long.parseLong((String) params.get("roomNumber"));
		
		List<Room> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
		if(new_list != null && new_list.size() > 0) {
			mv.addObject("roomNumber", params.get("roomNumber"));
			//mv.setViewName("chat/chat2/chat");
			mv.setViewName("chatPage");
		}else  {
			//mv.setViewName("room");
			mv.setViewName("index");
		}
		return mv;
	}
	
	
	@GetMapping("c.selectChatList")
	public String selectChatList(@RequestParam("memberNo") long memberNo,Model model) {
		ChatDAO chatDAO = sqlSession.getMapper(ChatDAO.class);
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		List<RoomDTO> list =  chatDAO.selectChatList(memberNo);
		for (RoomDTO roomDTO : list) {
			if(memberNo == roomDTO.getBuyerNo()) {
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