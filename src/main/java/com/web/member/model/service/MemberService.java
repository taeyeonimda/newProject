package com.web.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.member.model.dao.MemberDao;
import com.web.member.model.vo.Member;

@Service
public class MemberService {

	@Autowired
	private MemberDao dao;

	public Member selectOneMember(Member m) {
		Member mem = dao.selectOneMember(m);
		return mem;
	}

	public int insertMember(Member m) {
		int result = dao.insertMember(m);
		return result;
	}
}
