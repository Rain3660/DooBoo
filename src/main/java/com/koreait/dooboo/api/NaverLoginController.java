package com.koreait.dooboo.api;
import java.io.IOException;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.koreait.dooboo.member.dao.MemberDAO;
import com.koreait.dooboo.member.dto.MemberDTO;


	
@Controller
public class NaverLoginController {
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private SqlSession sqlSession;
	private String apiResult = null;
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO,
								 SqlSession sqlSession) {
	this.naverLoginBO = naverLoginBO;
	this.sqlSession = sqlSession;
	}

	//네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/api/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {

	OAuth2AccessToken oauthToken;
	oauthToken = naverLoginBO.getAccessToken(session, code, state);
	//1. 로그인 사용자 정보를 읽어온다.
	apiResult = naverLoginBO.getUserProfile(oauthToken); //String형식의 json데이터
	/** apiResult json 구조
	{"resultcode":"00",
	"message":"success",
	"response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
	**/
	//2. String형식인 apiResult를 json형태로 바꿈
	JSONParser parser = new JSONParser();
	Object obj = parser.parse(apiResult);
	JSONObject jsonObj = (JSONObject) obj;
	//3. 데이터 파싱
	//Top레벨 단계 _response 파싱
	JSONObject response_obj = (JSONObject)jsonObj.get("response");
	//response의 nickname값 파싱
	//4.파싱 닉네임 세션으로 저장
	model.addAttribute("result", apiResult);
	
	String apiMemberNo = (String)response_obj.get("id");
	String age = (String) response_obj.get("age");
	String gender = (String) response_obj.get("gender");
	String email  = (String) response_obj.get("email");
	String name = (String) response_obj.get("name");
	String year = (String) response_obj.get("birthyear");
	String birth = (String) response_obj.get("birthday");
	String phone = (String) response_obj.get("mobile");
	String nickname  = (String) response_obj.get("nickname");
	String [] birtharr = birth.split("-");
	String month = birtharr[0];
	String day = birtharr[1];
	String birthday = month+"/"+day+"/"+year; //생년월일 파싱
	
	
	model.addAttribute("birthDay",birthday);
	model.addAttribute("nickname",nickname);
	model.addAttribute("gender",gender);
	model.addAttribute("email",email);
	model.addAttribute("name",name);
	model.addAttribute("birthday",birthday);
	model.addAttribute("apiMemberNo",apiMemberNo);
	model.addAttribute("apiNumber",1);
	String loginApi = "1";
	model.addAttribute("loginApi",loginApi);
	model.addAttribute("phone",phone);
/*	System.out.println("생년월일 : "+birthday);
	System.out.println("id : "+apiMemberNo);
	System.out.println("age : "+age);
	System.out.println("gender : "+gender);
	System.out.println("email : "+email);
	System.out.println("name : "+name);	*/
    String view = "member/join";
	    MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
	    MemberDTO memberDTO = new MemberDTO();
	    memberDTO.setApiNumber(1);
	    memberDTO.setApiMemberNo(apiMemberNo);
	    MemberDTO loginUser = memberDAO.apiLoginCheck(memberDTO);
	    if(loginUser!= null) {
	    	session.setAttribute("loginUser",loginUser );
	    	view = "map/apiBeforeLogin";
	    }
	    return view;
	}
	//로그아웃
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session)throws IOException {
	session.invalidate();
	return "redirect:index";
	}

}
