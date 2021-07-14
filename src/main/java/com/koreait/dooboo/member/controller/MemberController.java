package com.koreait.dooboo.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {
	
	
	@GetMapping("m.join")
	public String join() {
		return "member/join";
	}
	@GetMapping("m.login")
	public String login() {
		return "member/login";
	}
	@GetMapping("m.mypage")
	public String mypage() {
		return "member/myPage";
	}
}
