package com.web.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.member.model.dao.MemberDao;
import com.web.member.model.vo.Member;
import com.web.member.model.vo.MemberPageData;

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

	public MemberPageData getAllMembers(int reqPage) {
		// 한페이지당 보여줄 게시물 수
				int numPerPage = 5;
				// reqPage에 게시물 번호 읽어오기
				int end = reqPage * numPerPage;
				int start = end - numPerPage + 1;
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("start", start);
				map.put("end", end);
				ArrayList<Member> list = dao.getAllMembers(map);
				// pageNavi 시작
				// 전체페이지 수 계산필요
				int totalCount = dao.selectMembersCnt();
				int totalPage = 0;
				if (totalCount % numPerPage == 0) {
					totalPage = totalCount / numPerPage;
				} else {
					totalPage = totalCount / numPerPage + 1;
				}

				int pageNaviSize = 5;
				int pageNo = 1;
				if (reqPage > 3) {
					pageNo = reqPage - 2;
				}

				String pageNavi = "<nav aria-label=\"Page navigation example\">";
				pageNavi += "<ul class='pagination justify-content-center'>";
				if (pageNo != 1) {
					pageNavi += "<li class='page-item'>";
					pageNavi += "<a class='page-link'  tabindex='-1' aria-disabled='true' href='/adminPage.do?reqPage=" + (pageNo - 1) + "'>";
					pageNavi += "Previous";
					pageNavi += "</a></li>";
				}
				for (int i = 0; i < pageNaviSize; i++) {
					if (pageNo == reqPage) {
						pageNavi += "<li class='page-item' >";
						pageNavi += "<a class='page-link active-page' href='/adminPage.do?reqPage=" + pageNo + "'>";
						pageNavi += pageNo;
						pageNavi += "</a></li>";
					} else {
						pageNavi += "<li class='page-item' >";
						pageNavi += "<a class='page-link' href='/adminPage.do?reqPage=" + pageNo + "'>";
						pageNavi += pageNo;
						pageNavi += "</a></li>";
					}
					pageNo++;
					if (pageNo > totalPage) {
						break;
					}
				}
				// 다음버튼 
				if (pageNo <= totalPage) {
					pageNavi += "<li class='page-item' >";
					pageNavi += "<a class='page-link'  tabindex='-1' aria-disabled='true' href='/adminPage.do?reqPage=" + pageNo + "'>";
					pageNavi += "Nextpage";
					pageNavi += "</a></li>";
				}
				pageNavi += "</ul></nav>";
				MemberPageData mpd = new MemberPageData(list, pageNavi, reqPage, numPerPage);
				return mpd;

	}
}
