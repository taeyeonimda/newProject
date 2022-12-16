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
	
	//회원가입페이지이동
	@RequestMapping(value="/signupFrm.do")
	public String sinupFrm() {
		return "member/signUpFrm";
	}
	
	//로그인
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
	//로그아웃
	@RequestMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	//중복아이디체크
	@RequestMapping(value="/ajaxCheckId.do")
	@ResponseBody
	public String ajaxCheckId(Member m) {
		Member mem = service.selectOneMember(m);
		if(mem==null) {
			return "0";
		}else {
			return "1";
		}
	}
	
	//회원가입
	@RequestMapping(value="/signUp.do")
	@ResponseBody
	public String signUp(Member m) {
		int result = service.insertMember(m);
		if(result>0) {
			return "1";
		}else {
			return "0";
		}
	}
}
