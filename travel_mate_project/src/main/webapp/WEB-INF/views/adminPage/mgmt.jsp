<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%-- 부트스트랩 --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<%-- CSS --%>
<link rel=stylesheet href="<c:url value='/css/adminPage.css'/>" type="text/css">


<div class="container main_div row">
	<h1 class="titleWord mb-5">관리자 페이지</h1>

	<jsp:include page="/WEB-INF/views/adminPage/admin_sidebar.jsp"/>
	
	<div class="col container text-center mb-5 p-4" id="adminDiv">

		


		<div class="row">
			<div class="col me-3">
				<div class="col row">
					<div class="col d-flex align-items-center justify-content-start title"><img class="me-2" alt="" src="<c:url value='/images/adminPage/mate.png'/>"/>여행 모집</div>
					<div class="col d-flex align-items-center justify-content-end"><a href="mate/list">바로가기</a><img class="ms-1" alt="" src="<c:url value='/images/adminPage/move.png'/>"/></div>
				</div>
				<div class="col overflow-auto pe-0" style="max-height:350px;">
					<table class="table table-sm border table-striped table-hover text-truncate mb-0">
						<tr>
							<th class="th_custom">번호</th>
							<th class="th_custom">모집글제목</th>
							<th class="th_custom">작성자</th>
							<th class="th_custom">작성일자</th>
							<th class="th_custom">조회수</th>
							<th class="th_custom_end">동행원</th>
						</tr>
						
						<c:forEach var="mateBoard" items="${mateBoardList }">
							<tr>

							    <td>${mateBoard.boardNo }</td>
							    <td style="max-width:130px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" class="text-start"><a href="mate/detail?boardNo=${mateBoard.boardNo }" style="color:black;">${mateBoard.boardTitle }</a></td>
							    <td>${mateBoard.boardWriter }</td>
							    <td>${mateBoard.boardRegdate.substring(2, 10) }</td>
							    <td>${mateBoard.boardCount }</td>
							    
							     <c:choose>
							    	<c:when test="${empty mateBoard.mateCount }">
									    <td>0</td>
							    	</c:when>
							    	<c:otherwise>
									    <td>${mateBoard.mateCount }</td>
							    	</c:otherwise>
							    </c:choose>
							    
							    
							</tr>
						</c:forEach>

						
					</table>
				</div>
			</div>
			<div class="col ms-3">
				<div class="col row">
					<div class="col d-flex align-items-center justify-content-start title"><img class="me-2" alt="" src="<c:url value='/images/adminPage/course.png'/>"/>여행 코스</div>
					<div class="col d-flex align-items-center justify-content-end"><a href="course/list">바로가기</a><img class="ms-1" alt="" src="<c:url value='/images/adminPage/move.png'/>"/></div>
				</div>
				<div class="col overflow-auto pe-0" style="max-height:350px;">
					<table class="table table-sm border table-striped table-hover text-truncate mb-0">
						<tr>
							<th class="th_custom">번호</th>
							<th class="th_custom">코스제목</th>
							<th class="th_custom">작성자</th>
							<th class="th_custom">작성일자</th>
							<th class="th_custom_end">조회수</th>
							<th class="th_custom_end">댓글수</th>
						</tr>
						<c:forEach var="course" items="${courseList }">
							<tr>

							    <td>${course.courseNo }</td>
							    <td style="max-width:130px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" class="text-start"><a href="course/view?num=${course.courseNo }" style="color:black;">${course.courseTitle }</a></td>
							    <td>${course.courseWriter }</td>
							    <td>${course.courseRegdate.substring(2, 10) }</td>
							    <td>${course.courseCount }</td>
							    
							     <c:choose>
							    	<c:when test="${empty course.replyCount }">
									    <td>0</td>
							    	</c:when>
							    	<c:otherwise>
									    <td>${course.replyCount }</td>
							    	</c:otherwise>
							    </c:choose>
							    
							    
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>

		<div class="row mt-5">
			<div class="col me-3">
				<div class="col row">
					<div class="col d-flex align-items-center justify-content-start title"><img class="me-2" alt="" src="<c:url value='/images/adminPage/Q&A.png'/>"/>고객 문의</div>
					<div class="col d-flex align-items-center justify-content-end"><a href="">바로가기</a><img class="ms-1" alt="" src="<c:url value='/images/adminPage/move.png'/>"/></div>
				</div>
				<div class="col overflow-auto pe-0" style="max-height:350px;">
					<table class="table table-sm border table-striped table-hover text-truncate mb-0">
						<tr>
							<th class="th_custom">번호</th>
							<th class="th_custom">문의제목</th>
							<th class="th_custom">작성자</th>
							<th class="th_custom">작성일자</th>
							<th class="th_custom_end">상태</th>
						</tr>
						<tr>
					        <td>15</td>
					        <td class="titleOver">게시글 삭제가 안됨</td>
					        <td>test11</td>
					        <td>24.10.17</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>14</td>
					        <td class="titleOver">회원탈퇴 문의</td>
					        <td>test22</td>
					        <td>24.10.16</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>13</td>
					        <td class="titleOver">로그인 문제 발생</td>
					        <td>user01</td>
					        <td>24.10.15</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>12</td>
					        <td class="titleOver">비밀번호 변경 요청</td>
					        <td>user02</td>
					        <td>24.10.14</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>11</td>
					        <td class="titleOver">프로필 사진 수정 불가</td>
					        <td>user03</td>
					        <td>24.10.13</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>10</td>
					        <td class="titleOver">게시판 버그 제보</td>
					        <td>test33</td>
					        <td>24.10.12</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>9</td>
					        <td class="titleOver">회원가입 오류 문의</td>
					        <td>newuser</td>
					        <td>24.10.11</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>8</td>
					        <td class="titleOver">메일 인증 실패</td>
					        <td>user04</td>
					        <td>24.10.10</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>7</td>
					        <td class="titleOver">알림 설정 관련 문의</td>
					        <td>user05</td>
					        <td>24.10.09</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>6</td>
					        <td class="titleOver">댓글 작성 불가</td>
					        <td>user06</td>
					        <td>24.10.08</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>5</td>
					        <td class="titleOver">게시물 수정 오류</td>
					        <td>test44</td>
					        <td>24.10.07</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>4</td>
					        <td class="titleOver">비밀번호 찾기 문제</td>
					        <td>user07</td>
					        <td>24.10.06</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>3</td>
					        <td class="titleOver">이용약관 문의</td>
					        <td>test55</td>
					        <td>24.10.05</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>2</td>
					        <td class="titleOver">서비스 업데이트 일정</td>
					        <td>user08</td>
					        <td>24.10.04</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>1</td>
					        <td class="titleOver">이벤트 참여 방법</td>
					        <td>user09</td>
					        <td>24.10.03</td>
					        <td>-</td>
					    </tr>
					</table>
				</div>
			</div>
			<div class="col ms-3">
				<div class="col row">
					<div class="col d-flex align-items-center justify-content-start title"><img class="me-2" alt="" src="<c:url value='/images/adminPage/notice.png'/>"/>공지 사항</div>
					<div class="col d-flex align-items-center justify-content-end"><a href="">바로가기</a><img class="ms-1" alt="" src="<c:url value='/images/adminPage/move.png'/>"/></div>
				</div>
				<div class="col overflow-auto pe-0" style="max-height:350px;">
					<table class="table table-sm border table-striped table-hover text-truncate mb-0">
						<tr>
							<th class="th_custom">번호</th>
							<th class="th_custom">공지제목</th>
							<th class="th_custom">작성자</th>
							<th class="th_custom">작성일자</th>
							<th class="th_custom_end">상태</th>
						</tr>
						
						<tr>
					        <td>15</td>
					        <td class="titleOver">회원정보 보관 갱신 안내</td>
					        <td>test_admin2</td>
					        <td>24.10.17</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>14</td>
					        <td class="titleOver">제주도 여행권 할인 이벤트</td>
					        <td>test_admin1</td>
					        <td>24.10.16</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>13</td>
					        <td class="titleOver">서비스 점검 일정 공지</td>
					        <td>admin_team</td>
					        <td>24.10.15</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>12</td>
					        <td class="titleOver">추석 연휴 배송 안내</td>
					        <td>logistics</td>
					        <td>24.10.14</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>11</td>
					        <td class="titleOver">비밀번호 변경 권장</td>
					        <td>security_admin</td>
					        <td>24.10.13</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>10</td>
					        <td class="titleOver">신규 기능 업데이트 알림</td>
					        <td>dev_team</td>
					        <td>24.10.12</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>9</td>
					        <td class="titleOver">포인트 만료 안내</td>
					        <td>marketing</td>
					        <td>24.10.11</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>8</td>
					        <td class="titleOver">이용약관 개정 안내</td>
					        <td>legal_team</td>
					        <td>24.10.10</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>7</td>
					        <td class="titleOver">정기점검 완료 보고</td>
					        <td>infra_team</td>
					        <td>24.10.09</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>6</td>
					        <td class="titleOver">이벤트 참여자 발표</td>
					        <td>event_team</td>
					        <td>24.10.08</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>5</td>
					        <td class="titleOver">긴급 공지: 서비스 중단</td>
					        <td>operation_team</td>
					        <td>24.10.07</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>4</td>
					        <td class="titleOver">앱 사용법 가이드</td>
					        <td>guide_admin</td>
					        <td>24.10.06</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>3</td>
					        <td class="titleOver">고객센터 운영시간 변경</td>
					        <td>cs_team</td>
					        <td>24.10.05</td>
					        <td>삭제</td>
					    </tr>
					    <tr>
					        <td>2</td>
					        <td class="titleOver">할인 쿠폰 지급 안내</td>
					        <td>promotion</td>
					        <td>24.10.04</td>
					        <td>-</td>
					    </tr>
					    <tr>
					        <td>1</td>
					        <td class="titleOver">회원 가입 감사 인사</td>
					        <td>admin_team</td>
					        <td>24.10.03</td>
					        <td>삭제</td>
					    </tr>
						
						
						
					</table>		
				</div>
			</div>
		</div>


		<div class="my-5">
			<div class="row">
				<div class="col d-flex align-items-center justify-content-start title"><img class="me-2" alt="" src="<c:url value='/images/adminPage/user.png'/>"/>회원 정보</div>
				<div class="col d-flex align-items-center justify-content-end"><a href="<c:url value="/adminPage/mgmtUser"/>">바로가기</a><img class="ms-1" alt="" src="<c:url value='/images/adminPage/move.png'/>"/></div>
			</div>
			
				<div class="col overflow-auto pe-0" style="max-height:350px;">
					<table class="table table-sm border table-striped table-hover text-truncate mb-0">
						<tr>
							<th class="th_custom">No</th>
							<th class="th_custom">아이디</th>
							<th class="th_custom">이름</th>
							<th class="th_custom">닉네임</th>
							<th class="th_custom">이메일</th>
							<th class="th_custom">전화번호</th>
							<th class="th_custom">연령대</th>
							<th class="th_custom">성별</th>
							<th class="th_custom">가입일</th>
							<th class="th_custom">상태</th>
							<th class="th_custom_end">소개글</th>
						</tr>
						
						<c:forEach var="user" items="${travelUserList }" varStatus="status" >
							<tr>
								<td>${status.index + 1}</td>
							    <td>${user.userId }</td>
							    <td>${user.userName }</td>
							    <td>${user.userNickname }</td>
							    <td>${user.userEmail }</td>
							    <td>${user.userPhone }</td>
							    <td>${user.userAge }</td>
							    <td>${user.userGender }</td>
							    <td>${user.userRegdate.substring(2, 10)}</td>
							    
							    <%-- 상태 --%>
							    <c:choose>
							    	<c:when test="${user.userEnabled == 0 }">
									    <td style="color:#e30000;">탈퇴</td>
							    	</c:when>
							    	<c:when test="${user.userEnabled == 1 }">
									    <td>-</td>
							    	</c:when>
							    </c:choose>
							    	        
							    <td class="text-start">${user.userIntroduction }</td>
							</tr>
						</c:forEach>
						
					</table>
				</div>
			</div>
		</div>
</div>
<div class="my-5" style="height:30px;"></div>





