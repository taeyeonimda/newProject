<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="icon" href="/resources/img/common/잠만보32.jpg">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=vpkvkhu7rd&submodules=geocoder"></script>
<script src="/resources/js/common/jquery-3.6.0.js"></script>
<style>
.input-wrap {
	padding: 15px;
}
.input-wrap>label {
	font-size: 1.1em;
	margin-bottom: 10px;
	display: block;
}
.submit-btn {
	padding: 15px;
	margin: 20px 0px;
}
.input-wrap>.id-wrap {
	display: flex;
}
.input-wrap>.id-wrap>#memberId {
	width: 80%;
}
.input-wrap>.id-wrap>#idChkbtn {
	width: 20%
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
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">회원가입</div>
		<form name="checkIdFrm" action="/checkId.do">
			<input type="hidden" name="checkId">
		</form>
		<form action="/signUp.do" method="post">
			<div class="input-wrap">
				<label for="memberId">아이디<span id="ajaxCheckId"></span></label>
				<div class="id-wrap">
				<input type="text" name="memberId" id="memberId"
				class="input-form">
				<button type="button" id="idChkbtn" class="btn bc2">중복체크</button>
				</div>
			</div>
			<div class="input-wrap">
				<label for="memberPw">비밀번호</label>
				<input type="password" name="memberPw" id="memberPw"
				class="input-form">
			</div>
			<div class="input-wrap">
				<label for="memberName">이름</label>
				<input type="text" name="memberName" id="memberName"
				class="input-form">
			</div>
			<div class="input-wrap">
				<label for="memberPhone">전화번호</label>
				<input type="text" name="memberPhone" id="memberPhone"
				class="input-form" oninput="autoHyphen(this);" maxlength="13" placeholder="전화번호를 입력하세요.">
			</div>
			<div class="input-wrap">
				<label for="memberAddr">주소</label>
				<div class="addr-wrap">
					<input type="text" name="memberAddr" id="memberAddr" class="input-form" readonly>
					<button type="button" id="searchAddr" onclick="searchMap();" class="btn bc2">주소찾기</button>
				</div>
			</div>
			<div class="submit-btn">
				<button type="button" class="btn bc22 bs4 signUpBtn">회원가입</button>
			</div>
		</form>
	</div>
	<script>
		$("[name=memberId]").on("change",function(){
			const memberId = $(this).val();
			$.ajax({
				url:"/ajaxCheckId.do",
				type:"get",
				data:{memberId:memberId},
				success:function(data){
					if(data=="1"){
						$("#ajaxCheckId").text("이미 사용중인 아이디입니다.");
						$("#ajaxCheckId").css("color","red");
					}else{
						$("#ajaxCheckId").text("사용가능한 아이디입니다.");
						$("#ajaxCheckId").css("color","blue");
					}
				}
			})
		});
		
	
		$("#idChkbtn").on("click",function(){
			const memberId = $(this).prev().val();
			if(memberId ==""){
				alert("아이디를 입력하세요");
				return;
			}
			$("[name=checkId]").val(memberId);
			const popup = window.open("","checkId","left=700px,top=300px,width=300px, height=250px, menubar=no,status=no,scrollbars=yes");
			//새창에서 form을 전송하기 위한 연결작업
			$("[name=checkIdFrm]").attr("target","checkId");
			$("[name=checkIdFrm]").submit();
		})
		
		
		$(".signUpBtn").on("click",function(){
			signUpAjax();
	    });
	    $("#memberAddr").on("keyup",function(e){
	    	  if (e.keyCode === 13) {
	    		  signUpAjax();
	    	  }
	    });
		
	
	 	//휴대전화 형식 고치기
	    const autoHyphen = (target) => {
	    	 target.value = target.value
	    	   .replace(/[^0-9]/g, '')
	    	  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	    }
	    
	    
		function signUpAjax(){
			const memberId = $("#memberId").val();
			const memberPw = $("#memberPw").val();
			const memberName = $("#memberName").val();
			const memberPhone = $("#memberPhone").val();
			const memberAddr = $("#memberAddr").val();
			
			let ajaxCheckIdText = $("#ajaxCheckId").text();
			if(ajaxCheckIdText != "사용가능한 아이디입니다." || ajaxCheckIdText == ""){
				console.log(ajaxCheckIdText);
				alert("아이디를 확인해주세요.");
				return false;
			}
			if(memberPw==""){
				alert("비밀번호를 입력해주세요");
				return false;
			}
			if(memberName==""){
				alert("이름을 입력해주세요");
				return false;
			}
			if(memberPhone==""){
				alert("핸드폰 번호를 입력해주세요");
				return false;
			}
			if(memberAddr==""){
				alert("주소를 입력해주세요");
				return false;
			}
			
			$.ajax({
				url: "/signUp.do",
		    	data: {
		    		memberId:memberId,
		    		memberPw:memberPw,
		    		memberName:memberName,
		    		memberPhone:memberPhone,
		    		memberAddr:memberAddr},
		    	success : function(data){
					if(data==1){
						console.log(data);
						alert("회원가입에 성공하였습니다.");
						location.href="/";
					}else{
						console.log(data);
						alert("회원가입에 실패하였습니다. 다시 시도해주세요.");
						
					}

		    		
		    	},
		    	error : function(data){
		    		alert("에러가 발생하였습니다. 다시 시도해주세요.");
		    		
		    	}
			})
		}
		
		
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
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>