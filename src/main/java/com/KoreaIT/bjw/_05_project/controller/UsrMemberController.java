package com.KoreaIT.bjw._05_project.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.bjw._05_project.service.MemberService;
import com.KoreaIT.bjw._05_project.vo.Member;


@Controller
public class UsrMemberController {

	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public Member doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {

		int id = memberService.join(loginId, loginPw, name, nickname, cellphoneNum, email);

		Member member = memberService.getMemberById(id);

		return member;
	}

}