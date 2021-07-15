package com.koreait.dooboo.api;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;
import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;



@Controller
public class KakaoController {
	@Autowired
	private SqlSession sqlSession;

    
    @RequestMapping(value = "api/kakao", produces = "application/json")
    public String kakaoLogin(@RequestParam("code") String code, Model model, HttpSession session) {
        System.out.println("로그인 할때 임시 코드값");
        //카카오 홈페이지에서 받은 결과 코드
        System.out.println(code);
        System.out.println("로그인 후 결과값");
        
        //카카오 rest api 객체 선언
        Kakao_RestApi kr = new Kakao_RestApi();
        //결과값을 node에 담아줌
        JsonNode node = kr.getAccessToken(code);
        //결과값 출력
        System.out.println(node);
        //노드 안에 있는 access_token값을 꺼내 문자열로 변환
        JsonNode access_token = node.get("access_token");
        String token = access_token.toString();
        //세션에 담아준다.
        session.setAttribute("token", token);
        JsonNode userInfo = Kakao_RestApi.getKakaoUserInfo(access_token);
        
        // Get id
        String apiMemberNo = userInfo.path("id").asText();
        String name = null;
        String email = null;
        String gender = null;
        // 유저정보 카카오에서 가져오기 Get properties
        JsonNode properties = userInfo.path("properties");
        JsonNode kakao_account = userInfo.path("kakao_account");
        
        name = properties.path("nickname").asText();
        email = kakao_account.path("email").asText();
        gender = kakao_account.path("gender").asText();
        System.out.println("유저 아이디 : "+apiMemberNo);//기본키
        System.out.println("유저 이름 : "+name);//닉네임 == 이름
        System.out.println("유저 이메일 : "+email); //이메일
        System.out.println("유저 성별 : "+gender); //성별
        //성별
        //생일
        model.addAttribute("loginApi","1");
        model.addAttribute("name",name);
        model.addAttribute("email",email);
        model.addAttribute("gender",gender);
    	model.addAttribute("apiMemberNo",apiMemberNo);
    	model.addAttribute("apiNumber",2);
        
        String view = "member/join";
        MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
	    MemberDTO memberDTO = new MemberDTO();
	    memberDTO.setApiNumber(2);
	    memberDTO.setApiMemberNo(apiMemberNo);
	    MemberDTO loginUser = memberDAO.apiLoginCheck(memberDTO);
	    if(loginUser!= null) {
	    	session.setAttribute("loginUser",loginUser );
	    	view = "map/apiBeforeLogin";
	    }
        
        return view;
    }
    
    
    @RequestMapping(value = "/kakaologout", produces = "application/json")
    public String Logout(HttpSession session) {
        //kakao restapi 객체 선언
        Kakao_RestApi kr = new Kakao_RestApi();
        //노드에 로그아웃한 결과값음 담아줌 매개변수는 세션에 잇는 token을 가져와 문자열로 변환
        JsonNode node = kr.Logout(session.getAttribute("token").toString());
        //결과 값 출력
        System.out.println("로그인 후 반환되는 아이디 : " + node.get("id"));
        return "redirect:/login";
    }    



}
