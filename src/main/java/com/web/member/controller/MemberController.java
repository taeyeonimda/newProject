package com.web.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.member.model.service.MemberService;
import com.web.member.model.vo.Member;
import com.web.member.model.vo.MemberPageData;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	
	//회원가입페이지이동
	@RequestMapping(value="/signupFrm.do")
	public String sinupFrm() {
		return "member/signUpFrm";
	}
	
	//마이페이지로 이동
	@RequestMapping(value="/myPage.do")
	public String myPageFrm() {
			return "member/myPage";
	}
	
	//아이디찾기 이동
	@RequestMapping(value="/findIdFrm.do")
	public String findIdFrm() {
		return "member/findIdFrm";
	}
	
	//어드민페이지
	@RequestMapping(value="/adminPage.do")
	public String adminPage(int reqPage, Model model) {
		MemberPageData mpd = service.getAllMembers(reqPage);
		model.addAttribute("list",mpd.getList());
		model.addAttribute("pageNavi",mpd.getPageNavi());
		model.addAttribute("numPerPage",mpd.getNumPerPage());
		model.addAttribute("reqPage",mpd.getReqPage());
		return "member/adminPage";
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
	
	//운영자페이지에서 멤버등급 변경
	@RequestMapping(value="/changeLevel")
	public String changeLevel(Member m) {
		int result = service.changeLevel(m);
		if(result>0) {
			return "redirect:/adminPage.do?reqPage=1";
		}else {
			return "redirect:/adminPage.do?reqPage=1";
		}
	}
	
	//운영자페이지에서 체크된 멤버등급 변경
	@RequestMapping(value="/checkedChangeLevel")
	public String checkedChangeLevel(String num, String level) {
		boolean result = service.checkedChangeLevel(num,level);
		if(result) {
			return "redirect:/adminPage.do?reqPage=1";
		}else {
			return "redirect:/adminPage.do?reqPage=1";
		}
	}
	@ResponseBody
	@RequestMapping(value="/findId.do")
	public String findId(Member m,Model model) {
		Member mem = service.findId(m);
		if(mem==null) {
			return "0";
		}else {
			return mem.getMemberId();
		}
	}
}
