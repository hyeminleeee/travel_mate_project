<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>      



<link href="<c:url value="/css/board.css"/>" type="text/css" rel="stylesheet">

<div class="container board">
    <h1 class="h2 fw-bold tit_board">Q&A 쓰기</h1>
    <form action="<c:url value='/qnaboard/register'/>" method="post" id="boardForm">
        <sec:csrfInput/>
        <input type="hidden" name="writer" value="<sec:authentication property='principal.userId'/>">
        <input type="hidden" name="originalWriter" value="<sec:authentication property='principal.userId'/>"> <!-- 추가된 부분 -->
        <table class="commontable">
            <tr>
                <td><strong>제목</strong></td>
                <td><input type="text" name="subject" id="qsubject" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;"></td>
            </tr>
            <tr>
                <td><strong>내용</strong></td>
                <td><textarea rows="5" name="content" id="qcontent"></textarea></td>
            </tr>
        </table>
        <div class="wrap_btn">
	        <button type="button" onclick="history.back();" class="button">취소</button>
	        <button type="submit" class="button">글저장</button>
        </div>
    </form>
	
    <script type="text/javascript">
        $("#boardForm").submit(function() {
            // 제목이 비어있는지 확인
            if ($("#qsubject").val().trim() === "") {
                alert("제목을 입력해 주세요.");
                return false;
            }
            
            // 내용이 비어있는지 확인
            if ($("#qcontent").val().trim() === "") {
                alert("내용을 입력해 주세요.");
                return false;
            }
        });
    </script>
</div>