package com.koreait.dooboo.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.koreait.dooboo.api.Kakao_RestApi;
import com.koreait.dooboo.api.NaverLoginBO;
import com.koreait.dooboo.member.command.DeleteCommand;
import com.koreait.dooboo.member.command.JoinCommand;
import com.koreait.dooboo.member.command.LoginCommand;
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
	private DeleteCommand deleteCommand;
	@Autowired
	private NaverLoginBO naverLoginBO;

	@GetMapping("m.joinPage")
	public String joinPage() {
		return "member/join";
	}

	@RequestMapping(value = {"m.loginPage","api/m.loginPage"}, method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("네이버:" + naverAuthUrl);
		// 네이버
		String kakaourl = Kakao_RestApi.getRedirectURL();
		model.addAttribute("naverurl", naverAuthUrl);
		model.addAttribute("kakaourl", kakaourl);
		return "member/login";

	}

	@GetMapping("m.myPage")
	public String mypage() {
		return "member/myPage";
	}

	@PostMapping(value= {"m.join","api/m.join"})
	public void join(Model model, MemberDTO memberDTO, HttpServletResponse response) {
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("response", response);
		joinCommand.execute(sqlSession, model);
	}

	@PostMapping(value={"m.login","api/m.login"})
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
	}

	@GetMapping(value = "m.leave.do")
	public String leave(HttpSession session, Model model) {
		model.addAttribute("session", session);
		deleteCommand.execute(sqlSession, model);
		return "redirect:/";
	}

	@GetMapping(value = "m.logout")
	public String logOut(HttpSession session, Model model) {
		model.addAttribute("session", session);
		return "redirect:index";
	}

}
