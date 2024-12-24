<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<style type="text/css">
/* 버튼 스타일 */
.button-container {
  display: flex;
  justify-content: center;
  gap: 20px;
}

.btn {
  padding: 10px 20px;
  font-size: 1rem;
  color: white;
  background-color: #4a43c9;
  border-radius: 5px;
  cursor: pointer;
  text-decoration: none;
  font-family: 'Arial', sans-serif;
}

.btn:hover {
  background-color: lightgray;
} 

.row {
text-align: center;
}

.meg{
	font-size: 25px;
	font-weight: bold;
	margin-bottom: 10px;
	margin-top: 10px;
}
.searchTitle {
	font-size: 35px;
	margin-bottom: 10px;
}
.subMeg{
	margin-bottom: 20px;
}
.failMeg {
	font-size: 15px;
	font-weight: bold;
	margin-bottom: 20px;
}
.inline-text {
    display: inline;
}
.successMeg {
	margin-bottom: 20px;
}
.findPw {
	margin-top: 20px;
}
</style>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<div class="row g-0 bg-white min-vh-100 align-items-center">
  <div class="col-lg-6 text-center text-lg-start overflow-hidden z-index-2">
    <div class="px-3 py-6">
      <div class="row">
        <div class="col-sm-8 col-md-6 col-lg-9 col-xl-12 mx-auto max-w-450">
			<h1 class="searchTitle">아이디 조회</h1>
			<c:choose>
				<c:when test="${result.response == 'fail'}">
					<p class="failMeg">입력하신 회원정보가 존재하지 않습니다.</p>					
				</c:when>
				<c:otherwise>
					<div class="successMeg">
						<p class="inline-text">회원님의 아이디는</p>
						<span class="meg inline-text">&nbsp;${result.userId}&nbsp;</span>
						<p class="subMeg inline-text">입니다.</p>
					</div>
				</c:otherwise>
			</c:choose>
			
			<div class="button-container">
			  <!-- 비밀번호 찾기 버튼 -->
			<c:choose>
				<c:when test="${result.response == 'fail'}">
					<a href="<c:url value='/account/findId'/>" class="btn">아이디 찾기</a>				
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/account/findPw'/>" class="btn">비밀번호 찾기</a>
				</c:otherwise>
			</c:choose>
			<!-- 로그인 버튼 -->
			<a href="<c:url value='/account/login'/>" class="btn">로그인</a>
			
			</div>
        </div>
      </div>
    </div>
  </div>

  <!-- Background Image -->
  <div class="d-none d-lg-block min-vh-100 col-lg-6 bg-cover py-8 overlay-dark overlay-opacity-25" style="background-image:url('<c:url value="/images/bg_signin.jpg"/>')">
    <svg class="d-none d-lg-block position-absolute h-100 top-0 text-white ms-n5" style="width:6rem" fill="currentColor" viewBox="0 0 100 100" preserveAspectRatio="none">
      <polygon points="50,0 100,0 50,100 0,100"></polygon>
    </svg>
  </div>
</div>
</body>

</html>
