<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>      


<link href="<c:url value="/css/board.css"/>" type="text/css" rel="stylesheet">

<div class="container board">
    <h1>답변하기</h1>
    <hr>
    <form action="<c:url value='/qnaboard/reply' />" method="post">
        <input type="hidden" name="num" value="${qnaBoard.num}">
        <input type="hidden" name="userId" value="<sec:authentication property='principal.userId'/>">
        <input type="hidden" name="writer" value="${qnaBoard.writer}"> 
        <input type="hidden" name="originalWriter" value="${qnaBoard.originalWriter}">
        <input type="hidden" name="root" value="${qnaBoard.root}">
        <input type="hidden" name="step" value="${qnaBoard.step}">
        <input type="hidden" name="indent" value="${qnaBoard.indent}">
        <input type="hidden" name="pageNum" value="${searchMap.pageNum}">
        <input type="hidden" name="pageSize" value="${searchMap.pageSize}">
        <input type="hidden" name="column" value="${searchMap.column}">
        <input type="hidden" name="keyword" value="${searchMap.keyword}">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> <!-- CSRF 토큰 -->
        
        <table class="commontable">
            <tr>
                <td><strong>제목</strong></td>
                <td><input type="text" name="subject" value="${qnaBoard.subject}" required style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;"></td>
            </tr>
            <tr>
                <td><strong>내용</strong></td>
                <td><textarea name="content" rows="10" required></textarea></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <button type="submit" class="button">답변 내용 저장</button>
                    <button type="button" onclick="history.back();" class="button">취소</button>
                </td>
            </tr>
        </table>
    </form>
</div>