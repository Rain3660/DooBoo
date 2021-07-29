package com.koreait.dooboo.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.dooboo.api.Kakao_RestApi;
import com.koreait.dooboo.api.NaverLoginBO;
import com.koreait.dooboo.member.command.CurrentPasswordCheckCommand;
import com.koreait.dooboo.member.command.DeleteCommand;
import com.koreait.dooboo.member.command.FindIdCommand;
import com.koreait.dooboo.member.command.IdCheckCommand;
import com.koreait.dooboo.member.command.JoinCommand;
import com.koreait.dooboo.member.command.LocationCheckCommand;
import com.koreait.dooboo.member.command.LogOutCommand;
import com.koreait.dooboo.member.command.LoginCommand;
import com.koreait.dooboo.member.command.MyPageCommand;
import com.koreait.dooboo.member.command.SendTempPasswordEmailCommand;
import com.koreait.dooboo.member.command.UpdateContactCommand;
import com.koreait.dooboo.member.command.UpdateInfoCommand;
import com.koreait.dooboo.member.command.UpdatePasswordCommand;
import com.koreait.dooboo.member.dto.MemberDTO;

@Controller
public class MemberController {

	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private JoinCommand joinCommand;
	@Autowired
	private LoginCommand loginCommand;
	@Autowired
	private LogOutCommand logOutCommand;
	@Autowired
	private DeleteCommand deleteCommand;
	@Autowired
	private NaverLoginBO naverLoginBO;
	@Autowired
	private UpdateInfoCommand updateInfoCommand;
	@Autowired
	private CurrentPasswordCheckCommand currentPasswordCheckCommand;
	@Autowired
	private UpdatePasswordCommand updatePasswordCommand;
	@Autowired
	private UpdateContactCommand updateContactCommand;
	@Autowired
	private FindIdCommand findIdCommand;
	@Autowired
	private SendTempPasswordEmailCommand sendTempPasswordEmailCommand;
	@Autowired
	private IdCheckCommand idCheckCommand;
	@Autowired
	private MyPageCommand selectMyFavoriteProductList;
	@Autowired
	private LocationCheckCommand locationCheckCommand;
	@GetMapping("m.joinPage")
	public String joinPage() {
		return "member/join";
	}

	@RequestMapping(value = "m.loginPage", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		// 네이버
		String kakaourl = Kakao_RestApi.getRedirectURL();
		model.addAttribute("naverurl", naverAuthUrl);
		model.addAttribute("kakaourl", kakaourl);
		
		
		return "member/login";

	}

	@GetMapping(value= "m.myPage")
	public String mypage(Model model , HttpSession session) {
		model.addAttribute("session", session);
		selectMyFavoriteProductList.execute(sqlSession, model);
		return "member/myPage";
	}

	@PostMapping(value= "m.join")
	public void join(Model model, MemberDTO memberDTO, HttpServletResponse response,HttpSession session) {
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("response", response);
		joinCommand.execute(sqlSession, model);
	}

	@PostMapping(value="m.login")
	public void login(Model model, MemberDTO memberDTO, HttpServletRequest request, HttpServletResponse response) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		model.addAttribute("memberDTO", memberDTO);
		loginCommand.execute(sqlSession, model);
	}

	@PostMapping("m.updateInfo")
	public void updateInfo(Model model, HttpServletResponse response, HttpServletRequest request, MemberDTO memberDTO) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		model.addAttribute("memberDTO", memberDTO);
		updateInfoCommand.execute(sqlSession, model);
	}

	@GetMapping(value = "m.leave.do")
	public String leave(HttpSession session, Model model) {
		model.addAttribute("session", session);
		deleteCommand.execute(sqlSession, model);
		return "redirect:/";
	}

	@GetMapping(value = {"m.logout" , "api/m.logout"})
	public String logOut(HttpSession session, Model model) {
		model.addAttribute("session", session);
		logOutCommand.execute(sqlSession, model);
		return "home";
	}
	@PostMapping(value="m.currentPwCheck" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Integer> currentPwCheck(@RequestBody MemberDTO memberDTO , Model model){
		
		model.addAttribute("memberDTO", memberDTO);
		return currentPasswordCheckCommand.execute(sqlSession, model);
	}
	@PostMapping(value="m.updatePassword")
	public void updatePassword(Model model , HttpServletRequest request , HttpServletResponse response) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		
		updatePasswordCommand.execute(sqlSession, model);
	}
	@PostMapping(value="m.updateContact")
	public void updateContact(Model model , HttpServletRequest request , HttpServletResponse response) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		
		updateContactCommand.execute(sqlSession, model);

	}
	
	@GetMapping("m.findInfoPage")
	public String findInfoPage() {
		return "member/findInfoPage";
	}
	@PostMapping(value="m.findId" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> findId(Model model , @RequestBody MemberDTO member){
		
		model.addAttribute("member", member);
		return findIdCommand.execute(sqlSession, model);
	}
	@PostMapping(value="m.findPw" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> findPw(Model model , @RequestBody MemberDTO memberDTO){
		model.addAttribute("memberDTO", memberDTO);
		return sendTempPasswordEmailCommand.execute(sqlSession, model);
	}
	
	@PostMapping(value= "m.idCheck")
	@ResponseBody
	public Map<String, Integer> idCheck(Model model , @RequestBody MemberDTO memberDTO){
		
		model.addAttribute("memberDTO", memberDTO);
		return idCheckCommand.execute(sqlSession, model);
	}
	
	// 로그인한 유저가 상품탭을 클릭했을때 지역인증 유무를 판단한다.
	@PostMapping(value = "m.locationCheckTest")
	@ResponseBody
	public Map<String, Object> locationCheckTest(Model model , @RequestBody MemberDTO memberDTO){
		model.addAttribute("memberDTO", memberDTO);
		return locationCheckCommand.execute(sqlSession, model);
	}
	
	@GetMapping(value = "p.myHomeProductListPage")
	public String myHomeProductListPage(@ModelAttribute("address") String address) {
		return "product/myHomeProductListPage";
	}
}
