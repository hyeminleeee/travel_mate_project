<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>     

<link href="<c:url value="/css/board.css"/>" type="text/css" rel="stylesheet">


<div class="container board">
    <h1 class="h2 fw-bold tit_board">공지사항 변경</h1>
    <form action="<c:url value='/noticeboard/modify'/>" method="post" id="boardForm">
        <sec:csrfInput/>
        <input type="hidden" name="noticeNum" value="${noticeBoard.noticeNum}">
        <input type="hidden" name="noticeId" value="${noticeBoard.noticeId}">
        <input type="hidden" name="userName" value="${noticeBoard.userName}">
        <input type="hidden" name="pageNum" value="${searchMap.pageNum}">
        <input type="hidden" name="pageSize" value="${searchMap.pageSize}">
        <input type="hidden" name="column" value="${searchMap.column}">
        <input type="hidden" name="keyword" value="${searchMap.keyword}">
        <table class="commontable">
            <tr>
                <td><strong>제목</strong></td>
                <td><input type="text" name="noticeSubject" id="Nmodifysubject" value="${noticeBoard.noticeSubject}" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;"></td>
            </tr>
            <tr>
                <td><strong>내용</strong></td>
                <td><textarea rows="5" name="noticeContent" id="Nmodifycontent">${noticeBoard.noticeContent}</textarea></td>
            </tr>
        </table>
        <div class="wrap_btn">
        	<button type="button" onclick="history.back()" class="button">취소</button>
            <button type="submit" class="button">글변경</button>
        </div>
    </form>
	
    <script type="text/javascript">
        $("#boardForm").submit(function() {
            if($("#Nmodifysubject").val() == "") {
                alert("제목을 입력해 주세요.");
                return false;
            }
            
            if($("#Nmodifycontent").val() == "") {
                alert("내용을 입력해 주세요.");
                return false;
            }
        });
    </script>
</div>