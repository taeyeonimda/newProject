package com.web.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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

	public int insertMember(Member m) {
		int result = sqlSession.insert("member.insertMember",m);
		return result;
	}

	public ArrayList<Member> getAllMembers(HashMap<String, Object> map) {
		List list = sqlSession.selectList("member.allMembmerList",map);
		return (ArrayList<Member>)list;
	}

	public int selectMembersCnt() {
		int totalCount = sqlSession.selectOne("member.totalCount");
		return totalCount;
	}

	public int changeLevel(Member m) {
		int result = sqlSession.update("member.changeLevel",m);
		return result;
	}
}
