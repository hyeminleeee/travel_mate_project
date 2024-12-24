<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>      


<link href="<c:url value="/css/board.css"/>" type="text/css" rel="stylesheet">

    
<div class="container board">
    <h1 class="h2 fw-bold tit_board">Q&A 변경</h1>
    <form action="<c:url value='/qnaboard/modify'/>" method="post" id="boardForm">
        <sec:csrfInput/>
        <input type="hidden" name="num" value="${qnaBoard.num}">
        <input type="hidden" name="writer" value="${qnaBoard.writer}">
        <input type="hidden" name="pageNum" value="${searchMap.pageNum}">
        <input type="hidden" name="pageSize" value="${searchMap.pageSize}">
        <input type="hidden" name="column" value="${searchMap.column}">
        <input type="hidden" name="keyword" value="${searchMap.keyword}">
        <table class="commontable">
            <tr>
                <td><strong>제목</strong></td>
                <td><input type="text" name="subject" id="subject" value="${qnaBoard.subject}" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;"></td>
            </tr>
            <tr>
                <td><strong>내용</strong></td>
                <td><textarea rows="5" name="content" id="modifycontent">${qnaBoard.content}</textarea></td>
            </tr>
            <tr>
        </table>
        <div class="wrap_btn">
	        <button type="button" onclick="history.back()" class="button">취소</button>
	        <button type="submit" class="button">글변경</button>
        </div>	
    </form>
	
    <script type="text/javascript">
        $("#boardForm").submit(function() {
            if($("#subject").val() == "") {
                alert("제목을 입력해 주세요.");
                return false;
            }
            
            if($("#modifycontent").val() == "") {
                alert("내용을 입력해 주세요.");
                return false;
            }
        });
    </script>   
</div>