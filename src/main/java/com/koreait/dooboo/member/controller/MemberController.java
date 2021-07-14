package com.koreait.dooboo.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

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
	
	@GetMapping("m.joinPage")
	public String joinPage() {
		return "member/join";
	}
	@GetMapping("m.loginPage")
	public String loginPage() {
		return "member/login";
	}
	@GetMapping("m.myPage")
	public String mypage() {
		return "member/myPage";
	}
	@PostMapping("m.join")
	public void join(Model model, MemberDTO memberDTO , HttpServletResponse response) {
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("response", response);
		joinCommand.execute(sqlSession, model);
		
	}
	@PostMapping("m.login")
	public void login(Model model , MemberDTO memberDTO , HttpServletRequest request , HttpServletResponse response) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		model.addAttribute("memberDTO", memberDTO);
		
		loginCommand.execute(sqlSession, model);
	}
}
