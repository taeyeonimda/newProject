<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	  
    <!-- 구글 아이콘 -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!-- jquery -->
    <script src="/resources/js/common/jquery-3.6.0.js"></script>
    <!-- 기본 CSS -->
    <link rel="stylesheet" href="/resources/css/common/default.css" />
    <!-- 기본 js -->
    <script src="/resources/js/common/default.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <script src="/resources/summernote/summernote-lite.js"></script>
	<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
	<header>
      <div class="site-logo">
        <a href="/">Taeyeon`S WORLD</a>
      </div>
      <nav>
        <ul class="navi">
          <li><a href="/noticeList.do?reqPage=1">공지사항</a></li>
          <li><a href="#">자유게시판</a></li>
          <li><a href="/ajax.do">AJAX</a></li>
          <li><a href="/photoList.do">사진게시판</a></li>
          <li>
			<a href="#">API</a>
            <ul class="sub-navi">
              <li><a href="/email.do">EMAIL</a></li>
              <li><a href="/map.do">MAP</a></li>
              <li><a href="/pay.do">결제모듈</a></li>
            </ul>
           </li>
        </ul>
      </nav>
      <div class="header-link">
      <!-- m이 null일때 -->
      <c:choose>
	      <c:when test="${empty sessionScope.m}">
	        <button class="btn bc11 modal-open-btn" target="#login-modal">SIGN IN</button>
       		<a class="btn bc11" href="/signupFrm.do">SIGN UP</a>
	      </c:when>
	      <c:otherwise>
	      	<a class="btn bc11" href="/myPage.do">${sessionScope.m.memberName }님 환영합니다.</a>
          	<a class="btn bc11" href="/logout.do">LOGOUT</a>
	      </c:otherwise>
      </c:choose>
      </div>
    </header>
    
    <!-- 로그인모달 -->
    <!-- m이 널일떄 -->
    <c:choose>
	      <c:when test="${empty sessionScope.m}">
	          <div id="login-modal" class="modal-bg">
		      	<div class="modal-wrap">
			        <div class="modal-head">
			          <h2>SIGN IN</h2>
			          <span class="material-icons close-icon modal-close">close</span>
			        </div>
		        <form action="/signin.do" method="post">
			        <div class="modal-content">
			          <div class="input-box">
			          	<label for="signId">아이디</label>
			          	<input type="text" name="memberId" id="signId" class="input-form" placeholder="아이디입력">
			          </div>
			          <div class="input-box">
			          	<label for="signPw">비밀번호</label>
			          	<input type="password" name="memberPw" id="signPw" class="input-form" placeholder="비밀번호입력">
			          </div>
			          <div class="input-box link-box">
			          	<a href="/findIdFrm.do">아이디 찾기</a>
			          	<a href="/findPwFrm.do">비밀번호 찾기</a>
			          </div>
			        </div>
			        <div class="modal-foot">
			          <button type="button" class="btn bc11 loginBtn">로그인</button>
			          <button type="button" class="btn bc1 modal-close">취소</button>
			        </div>
		        </form>
				</div>      
    		 </div>
	      </c:when>
      </c:choose>
 
    
    <script>
    $(".loginBtn").on("click",function(){
    	loginAjax();
    });
    $("#signPw").on("keyup",function(e){
    	  if (e.keyCode === 13) {
    		  loginAjax();
    	  }
    });
    
    function loginAjax(){
    	const memberId = $("[name=memberId]").val();
    	const memberPw = $("[name=memberPw]").val();
    	 $.ajax({
    	    	url: "/signIn.do",
    	    	data: {
    	    		memberId:memberId,
    	    		memberPw:memberPw},
    	    	success : function(data){
    	    		if(data==1){
    	    			alert("로그인 성공");
    	    			location.href="/";
    	    		}else if(data==3){
    	    			alert("로그인 권한이 없습니다.");
    	    			location.href="/";
    	    		}else{
    	    			alert("아이디 혹은 비밀번호를 확인해주세요.");
    	    		}
    	    	},
    	    	error : function(data){
    	    		alert("에러가 발생하였습니다. 다시 시도해주세요.");
    	    		
    	    	}
    	    	
    	    })	
    }
   
    
    </script>
