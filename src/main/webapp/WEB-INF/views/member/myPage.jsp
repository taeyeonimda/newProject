<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="icon" href="/resources/img/common/잠만보32.jpg">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=vpkvkhu7rd&submodules=geocoder"></script>
<script src="/resources/js/common/jquery-3.6.0.js"></script>
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
.input-wrap>.addr-wrap {
	display: flex;
}
.input-wrap>.addr-wrap>#memberAddr {
	width: 80%;
}
.input-wrap>.addr-wrap>#searchAddr {
	width: 20%
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
				class="input-form" placeholder="010-0000-0000" maxlength="13" value = "${sessionScope.m.memberPhone }">
			</div>
			<div class="input-wrap">
				<label for="memberAddr">주소</label>
				<div class="addr-wrap">
					<input type="text" name="memberAddr" id="memberAddr" class="input-form" value="${sessionScope.m.memberAddr }">
					<button type="button" id="searchAddr" onclick="searchMap();" class="btn bc2">주소찾기</button>
				</div>
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
	<script>
	function searchMap() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                console.log(data.address);
                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
               	$("#memberAddr").val(data.address);
                //
                
               
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
               
                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                }
            }
        }).open();
    }
	</script>
</body>
</html>