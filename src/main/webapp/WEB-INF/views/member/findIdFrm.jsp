<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	label{
	height:80px;
	font-size:40px;
	text-align:center;
	width:1200px;
	display:inline-block;
	box-sizing:border-box;}
</style>
<title>아이디 찾기</title>
</head>
<body>
<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">아이디 찾기</div>
	<form>
		<label for="memberName">이름</label>
		<input type="text" name ="memberName" id="memberName" class="input-form">
		<label for="memberPhone">휴대전화</label>
		<input type="text" name ="memberPhone" id="memberPhone" class="input-form"><br>
		<button type="button" class="btn bc4 bs1 findIdbtn" onclick="findIdAjax();">아이디 찾기</button>
		<button type="button" class="btn bc4 bs1" onclick="location.href='./'">홈으로 가기</button>
	</form>
	</div>
</body>
<script>

	function findIdAjax(){
		let memberName = $("#memberName").val();
		let memberPhone = $("#memberPhone").val();
		
		if(memberName==""){
			alert("이름을 입력해주세요");
			return false;
		}
		if(memberPhone==""){
			alert("번호를 입력해주세요");
			return false;
		}
		
		$.ajax({
			url:"/findId.do",
			data:{
				memberName:memberName,
				memberPhone:memberPhone
			},
			success :function(data){
				if(data==0){
					Swal.fire({
						  title: "아이디 찾기",//제목
						  text: "계정을 찾을수 없습니다.",//내용
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인',
						})
				}else{
					Swal.fire({
						  title: "아이디 찾기",//제목
						  text: "조회 결과 : "+data,//내용
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인',
						})	
				}
			},
			error : function(data){
				alert("에러가 발생하였습니다. 다시 시도해주세요.");
			}
		});
	}
</script>
</html>