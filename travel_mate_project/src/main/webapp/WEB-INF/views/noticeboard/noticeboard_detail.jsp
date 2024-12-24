<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>     


<link href="<c:url value="/css/board.css"/>" type="text/css" rel="stylesheet">

<div class="container board">
    <h1 class="h2 fw-bold tit_board"">공지사항</h1>
    	<sec:authorize access="isAuthenticated()">
        <sec:authorize access="hasRole('ROLE_ADMIN')" var="adminRole"/>
        <sec:authentication property="principal" var="pinfo"/>
   
   	<div class="topfixlabel">
   		<c:if test="${adminRole}">
	   		 <label class="custom-checkbox">
	           <input type="checkbox" id="fixedCheckbox" checked="checked" <c:if test="${noticeBoard.noticeStatus == 0}">checked</c:if> > 상단고정글
	        	<span class="checkmark"></span>
	         </label>   
         </c:if>         
   	</div>
   
    <table class="commontable">
    
        <tr>
            <td><strong>제목</strong></td>
            <td style="font-size: 24px;">${noticeBoard.noticeSubject}</td>
        </tr>
        <tr>
            <td><strong>작성자</strong></td>
            <td>${noticeBoard.userName}</td>
        </tr>
        <tr>
            <td><strong>작성일</strong></td>
            <td>${noticeBoard.noticeRegdate}</td>    
        </tr>
        <tr>
            <td><strong>조회수</strong></td>
            <td>${noticeBoard.noticeCount}</td>
        </tr>
        <tr>
            <td><strong>내용</strong></td>
            <td class="content">
                <pre>${noticeBoard.noticeContent}</pre>
            </td>
        </tr>
    </table>
    
    <div class="wrap_btn">
        <form method="get" id="linkForm">
            <input type="hidden" name="noticeNum" value="${noticeBoard.noticeNum}">
            <input type="hidden" name="noticeId" value="${noticeBoard.noticeId}">
            <input type="hidden" name="userName" value="${noticeBoard.userName}">
            <input type="hidden" name="pageNum" value="${searchMap.pageNum}">
            <input type="hidden" name="pageSize" value="${searchMap.pageSize}">
            <input type="hidden" name="column" value="${searchMap.column}">
            <input type="hidden" name="keyword" value="${searchMap.keyword}">
            <input type="hidden" name="noticeStatus" id="noticeStatus" value="${noticeBoard.noticeStatus}">

            <button type="button" id="NlistBtn" class="button">글목록</button>
            
        
                <c:if test="${adminRole}">
                    <button type="button" id="NmodifyBtn" class="button">글변경</button>
                    <button type="button" id="NremoveBtn" class="button">글삭제</button>              
                </c:if> 
            </sec:authorize>
        </form>
    </div>

    <script type="text/javascript">
        $("#NlistBtn").click(function() {
            $("#linkForm").attr("action","<c:url value='/noticeboard/list'/>").submit();
        });
        
        $("#NmodifyBtn").click(function() {
            $("#linkForm").attr("action","<c:url value='/noticeboard/modify'/>").submit();
        });
            
        $("#NremoveBtn").click(function() {
            $("#linkForm").attr("action","<c:url value='/noticeboard/remove'/>").submit();
        });
        
        $(document).ready(function() {
            // 체크박스 상태 초기화는 JSP에서 처리하므로 필요 없음

            $("#fixedCheckbox").change(function() {
                const noticeStatus = this.checked ? 0 : 1; // 체크 시 0, 체크 해제 시 1
                const noticeNum = ${noticeBoard.noticeNum};

                $.ajax({
                    type: "post",
                    url: "<c:url value='/noticeboard/updateStatus'/>",
                    contentType: "application/json",
                    data: JSON.stringify({ noticeNum: noticeNum, noticeStatus: noticeStatus }),
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    dataType: "text",
                    success: function(result) {
                        if (result === "success") {
                            $("#noticeStatus").val(noticeStatus); // hidden input의 값을 업데이트
                            alert("status가 업데이트 되었습니다."); // 사용자에게 알림
                        } else {
                            alert("Status가 업데이트 실패");
                        }
                    },
                    error: function(xhr) {
                        alert("Error code = " + xhr.status + ": " + xhr.statusText);
                    }
                });
            });
            const initialStatus = ${noticeBoard.noticeStatus}; // 서버에서 가져온 초기 상태
            $('#fixedCheckbox').prop('checked', initialStatus === 0); 
        });
    </script>
</div>