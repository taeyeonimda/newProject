<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
				class="input-form">
			</div>
			<div class="input-wrap">
				<label for="memberAddr">주소</label>
				<input type="text" name="memberAddr" id="memberAddr"
				class="input-form">
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
		
		
		function signUpAjax(){
			const memberId = $("#memberId").val();
			const memberPw = $("#memberPw").val();
			const memberName = $("#memberName").val();
			const memberPhone = $("#memberPhone").val();
			const memberAddr = $("#memberAddr").val();
			
			let ajaxCheckIdText = $("#ajaxCheckId").text();
			if(ajaxCheckIdText != "사용가능한 아이디입니다." || ajaxCheckIdText == ""){
				console.log(ajaxCheckIdText);
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
		
	</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>