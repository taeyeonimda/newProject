<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="icon" href="/resources/img/common/잠만보32.jpg">
<style type="text/css">
.input-wrap {
	padding: 15px;
}

.input-wrap>label {
	font-size: 1.1em;
	margin-bottom: 10px;
	display: block;
}

[name=updateFrm].btn-box {
	text-align: center;
	margin-top: 30px;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>

	<div class="page-content">
		<div class="page-title">마이페이지</div>
		<form action="/updateMember.do" method="post" name="updateFrm">
			<div class="input-wrap">
				<label for="memberId">아이디</label>
				<input type="text" name="memberId" id="memberId"
				class="input-form" value = "${sessionScope.m.memberId }" readonly>
			</div>
			<div class="input-wrap">
				<label for="memberName">이름</label>
				<input type="text" name="memberName" id="memberName"
				class="input-form" value = "${sessionScope.m.memberName }" readonly>
			</div>
			<div class="input-wrap">
				<label for="memberPhone">전화번호</label>
				<input type="text" name="memberPhone" id="memberPhone"
				class="input-form" placeholder="010-0000-0000" value = "${sessionScope.m.memberPhone }">
			</div>
			<div class="input-wrap">
				<label for="memberAddr">주소</label>
				<input type="text" name="memberAddr" id="memberAddr"
				class="input-form" value = "${sessionScope.m.memberLevel }">
			</div>
			<div class="input-wrap">
				<label for="memberLevel">회원등급</label>
				<c:choose>
					<c:when test='${sessionScope.m.memberLevel == 1}'>
						<input type="text" name="memberLevel" id="memberLevel"
							class="input-form" value = "운영자" readonly>
					</c:when>
					<c:when test='${sessionScope.m.memberLevel == 2 }'>
						<input type="text" name="memberLevel" id="memberLevel"
							class="input-form" value = "정회원" readonly>
					</c:when>
					<c:otherwise>
						<input type="text" name="memberLevel" id="memberLevel"
							class="input-form" value = "준회원" readonly>
					</c:otherwise>
				</c:choose>	
			</div>
			<div class="input-wrap">
				<label for="enrollDate">가입일</label>
				<input type="text" name="enrollDate" id="enrollDate"
				class="input-form" value = "${sessionScope.m.enrollDate }" readonly>
			</div>
			<div class="btn-box">
				<button type="submit" class="btn bc11 bs2">정보수정</button>
				<c:choose>
					<c:when test='${sessionScope.m.memberLevel == 1}'>
						<a class="btn bc66 bs2" href="/adminPage.do?reqPage=1">회원관리</a>
					</c:when>
				</c:choose>
				<a class = "btn bc66 bs2" href="/deleteMember.do">회원탈퇴</a>
			</div>
		</form>
		
	</div>

	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>