<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>     

<sec:authorize access="isAuthenticated()">
<%--<sec:authentication property="principal" var="loginUser"/> --%>
<!-- PAGE TITLE -->
<div class="container py-5">
	
	<h1 class="h2 fw-bold">알림</h1>

	<!--
		<ul class="list-inline small text-muted m-0">
		  <li class="list-inline-item">
		    <a href="account-orders.html" class="d-flex align-items-center link-muted">
		      <svg width="18px" height="18px" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" fill="currentColor">
		        <path fill-rule="evenodd" d="M12 8a.5.5 0 0 1-.5.5H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5a.5.5 0 0 1 .5.5z"></path>
		      </svg>
		      <span class="text-muted px-1">back to orders</span>
		    </a>
		  </li>
		</ul>
	-->

</div>
<!-- /PAGE TITLE -->




<!-- -->
<div class="container pb-6">

	<div class="row g-4">
		<!-- sidebar -->
		<jsp:include page="/WEB-INF/views/account/mypage_sidebar.jsp"/>

		<!-- content -->
		<div class="col-12 col-lg-9">
	        <!-- Feedback -->
	        <div class="card mb-4">
	          <c:choose>
	          	<c:when test="${not empty resultMap.alarmList}">
	          		<div class="card-body p-4">
			            <ul class="list_noti">
			            	<c:forEach var="alarm" items="${resultMap.alarmList}">
						    <li class="${alarm.alarmRead == 0 ? 'read' : 'unread'}">
						    	<%-- 코스추천글일 경우 --%>
						    	<c:if test="${alarm.targetCourseNo != 0}">
						    	<a href="#" class="link_noti new_noti"  onclick="markCourseAsRead(event, ${alarm.alarmId}, ${alarm.targetCourseNo})">
							        <c:choose>
							            <c:when test="${alarm.actionType == 'COMMENT'}">
							                <span class="txt_emph txt_user">
							                	${alarm.targetUserNickname}</span>님이 
							                <span class="txt_emph txt_title">
							                	${alarm.targetCourseTitle}
							                </span> 
							                	글에 <span class="txt_emph">댓글</span>을 등록하셨습니다.
							            </c:when>
							            <c:when test="${alarm.actionType == 'LIKE'}">
							            	<span class="txt_emph txt_user">
							                	${alarm.targetUserNickname}</span>님이 
							                <span class="txt_emph txt_title">
							                	${alarm.targetCourseTitle}
							                </span> 
							                	글에 <span class="txt_emph">좋아요</span>를 눌렀습니다.
							            </c:when>
							        </c:choose>
							        <span class="txt_date">${alarm.alarmDate}</span>
						        </a>
						    	</c:if>
						    	
						    	<%-- 동행모집글일 경우 --%>
						    	<c:if test="${alarm.targetBoardNo != 0}">
						    	<a href="#" class="link_noti new_noti"  onclick="markMateAsRead(event, ${alarm.alarmId}, ${alarm.targetBoardNo})">
							        <c:choose>
							            <c:when test="${alarm.actionType == 'COMMENT'}">
							                <span class="txt_emph txt_user">
							                	${alarm.targetUserNickname}</span>님이 
							                <span class="txt_emph txt_title">
							                	${alarm.targetBoardTitle}
							                </span> 
							                	글에 <span class="txt_emph">댓글</span>을 등록하셨습니다.
							            </c:when>
							            <c:when test="${alarm.actionType == 'LIKE'}">
							            	<span class="txt_emph txt_user">
							                	${alarm.targetUserNickname}</span>님이 
							                <span class="txt_emph txt_title">
							                	${alarm.targetBoardTitle}
							                </span> 
							                	글에 <span class="txt_emph">좋아요</span>를 눌렀습니다.
							            </c:when>
							            <%-- 참여신청 수락여부 관련 --%>
							            <c:when test="${alarm.actionType == 'SUBMIT_APPLY'}">
							            	<span class="txt_emph txt_user">
							                	${alarm.targetUserNickname}</span>님이 
							                <span class="txt_emph txt_title">
							                	${alarm.targetBoardTitle}
							                </span> 
							                	글에 <span class="txt_emph">참여신청</span>을 하셨습니다.
							            </c:when>
							            <c:when test="${alarm.actionType == 'SUBMIT_ACCEPT'}">
							            	<span class="txt_emph txt_user">
							                	${alarm.targetUserNickname}</span>님이 
							                <span class="txt_emph txt_title">
							                	${alarm.targetBoardTitle}
							                </span> 
							                	글의 참여신청을 <span class="txt_emph">수락</span> 하셨습니다.
							            </c:when>
							            <c:when test="${alarm.actionType == 'SUBMIT_REFUSAL'}">
							            	<span class="txt_emph txt_user">
							                	${alarm.targetUserNickname}</span>님이 
							                <span class="txt_emph txt_title">
							                	${alarm.targetBoardTitle}
							                </span> 
							                	글의 참여신청을 <span class="txt_emph">거절</span> 하셨습니다.
							            </c:when>
							        </c:choose>
							        <span class="txt_date">${alarm.alarmDate}</span>
						        </a>
						    	</c:if>
						    	
						        <c:if test="${alarm.actionType == 'SUBMIT'}">
						        	<form action="" method="post">
						        		<button type="submit" class="link_allow">수락</button>
								        <input type="hidden" name="boardNo" value="${alarm.targetBoardNo}"> <!-- 게시글 번호 -->
								        <input type="hidden" name="targetUserId" value="${alarm.targetUserId}"> <!-- 알림을 발생시킨 사용자 ID -->
								        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> <!-- CSRF 토큰 -->
						        	</form>
						        </c:if>
						    </li>
							</c:forEach>
			            </ul>
			            <!-- 페이징 처리 -->
					    <div class="paging">
					        <c:forEach var="i" begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" step="1">
					            <c:choose>
					                <c:when test="${resultMap.pager.pageNum != i}">
					                    <a href="<c:url value='/account/travel_noti'/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}" class="page_count">
					                        ${i}
					                    </a>
					                </c:when>
					                <c:otherwise>
					                   <span class="txt_paging">${i}</span>
					                </c:otherwise>
					            </c:choose>
					        </c:forEach>
					    </div>
			         </div>
	          	</c:when>
	          	<c:otherwise>
	         	 	<div class="card-body p-4">
		          		<p class="txt_none">최신 알림이 없습니다.</p>
	          		</div>
	          	</c:otherwise>
	          </c:choose>
	        </div>
		</div>

	</div>

</div>
<!-- / -->

</sec:authorize>

<script type="text/javascript">

function markCourseAsRead(event, alarmId, targetCourseNo) {
        $.ajax({
            type: "POST",
            url: "<c:url value='/travel_alarm/alarm_read'/>", // 읽음 상태 업데이트를 처리할 URL
            data: JSON.stringify({ "alarmId": alarmId }), // 객체를 JSON 문자열로 변환
            contentType: "application/json", // Content-Type 설정
            dataType: "text",
            success: function(response) {
                console.log("알림이 읽음 상태로 업데이트되었습니다.");// AJAX 요청이 성공하면 페이지를 이동시킵니다.
                window.location.href = "<c:url value='/course/view?num='/>" + targetCourseNo;
            },
    		beforeSend: function(xhr) {
    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		},
            error: function(xhr) {
                alert("알림 읽음 상태 업데이트 중 오류가 발생했습니다.");
            }
        });
    }
    
function markMateAsRead(event, alarmId, targetBoardNo) {
   $.ajax({
       type: "POST",
       url: "<c:url value='/travel_alarm/alarm_read'/>", // 읽음 상태 업데이트를 처리할 URL
       data: JSON.stringify({ "alarmId": alarmId }), // 객체를 JSON 문자열로 변환
       contentType: "application/json", // Content-Type 설정
       dataType: "text",
       success: function(response) {
           console.log("알림이 읽음 상태로 업데이트되었습니다.");// AJAX 요청이 성공하면 페이지를 이동시킵니다.
           window.location.href = "<c:url value='/mate/detail?boardNo='/>"+targetBoardNo;
       },
		beforeSend: function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
       error: function(xhr) {
           alert("알림 읽음 상태 업데이트 중 오류가 발생했습니다.");
       }
   });
}

/*
$(".link_allow").click(function() {
	alert("aaa");
	$(this).text("수락완료"); // 버튼 텍스트 변경
	$(this).prop("type", "button"); // 버튼 타입 변경
	$(this).prop("disabled", true); // 버튼 비활성화
});
*/

/*
function acceptInvitation(alarmId, element) {
    if (confirm("이 알림을 수락하시겠습니까?")) {
        var boardNo = ${alarm.targetBoardNo}; // 게시글 번호
        var targetUserId = ${alarm.targetUserId}; // 알림을 발생시킨 사용자 ID

        $.ajax({
            type: "post",
            url: "<c:url value='/travel_alarm/mate_accept'/>", // 수락을 처리할 URL
            contentType: "application/json",
            data: JSON.stringify({ 
                "boardNo": boardNo,
                "userId": targetUserId, 
            }),
            dataType: "text",
            success: function(response) {
                if (response == "success") {
                    alert("초대 수락이 완료되었습니다.");
                    $(".link_allow").text("수락완료").removeClass("link_allow").addClass("link_completed");
                    $(".link_allow").off("click"); // 클릭 이벤트 제거
                } else {
                    alert("수락 처리 중 오류가 발생했습니다.");
                }
            },
    		beforeSend: function(xhr) {
    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		},
            error: function(xhr) {
                alert("에러코드 = " + xhr.status);
            }
        });
    }
}
*/

</script>
