package com.web.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.member.model.vo.Member;

@Repository
public class MemberDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public Member selectOneMember(Member m) {
		Member member = sqlSession.selectOne("member.selectOneMember",m);
		return member;
	}
}
