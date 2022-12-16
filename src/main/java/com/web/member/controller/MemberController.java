package com.web.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.member.model.service.MemberService;
import com.web.member.model.vo.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	
	@ResponseBody
	@RequestMapping(value="/signIn.do")
	public String signIn(Member m,HttpSession session) {
		Member mem = service.selectOneMember(m);
		if(mem != null) {
			if(mem.getMemberLevel()==3) {
				return "3";
			}else {
				session.setAttribute("m", mem);
				return "1";
			}
		}else {
			return "Fail";
		}
	}
	@RequestMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
