package com.web.member.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberPageData {
	private ArrayList<Member>list;
	private String pageNavi;
	private int reqPage;
	private int numPerPage;
}
