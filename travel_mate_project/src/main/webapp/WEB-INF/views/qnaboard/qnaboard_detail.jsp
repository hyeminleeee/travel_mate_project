<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>     

<link href="<c:url value="/css/board.css"/>" type="text/css" rel="stylesheet">

<%--
원본글보기(본인,관리자)- 오리진값opq, 라이터값 opq  -권한:오리진(opq),라이터(opq),어드민(abc)
답변글보기(본인,관리자)- 오리진값opq, 라이터값 abc  -권한:오리진(opq),어드민(abc)  =>둘다보기 권한 :오리진,어드민

원본글 글수정(본인,관리자) -오리진값 opq 라이터 opq    - 라이터,어드민 or 오리진,어드민 
답변글 글수정(관리자)      -오리진값 opq 라이터 abc    - 어드민  
=> 권한:오리진,어드민 사용시 답변글수정에 대해 일반유저가 권한을 갖게되므로 라이터,어드민이 맞다

 --%>

<div class="container board">
<h1 class="h2 fw-bold tit_board">Q&A 상세보기</h1>

<sec:authorize access="isAuthenticated()">    
    <sec:authorize access="hasRole('ROLE_ADMIN')" var="adminRole"/>
    <sec:authentication property="principal" var="pinfo"/>             
    <c:if test="${adminRole  || pinfo.userId eq qnaBoard.originalWriter}">
        <table class="commontable">
            <tr>
                <td><strong>제목</strong></td>
                <td style="font-size:20px;">${qnaBoard.subject}</td>
            </tr>
            <tr>
                <td><strong>작성자</strong></td>
                <td>${qnaBoard.userName}</td>
            </tr>
            <tr>
                <td><strong>작성일</strong></td>
                <td>${qnaBoard.regdate}</td>    
            </tr>
            <tr>
                <td><strong>내용</strong></td>
                <td class="content">
                    <pre>${qnaBoard.content}</pre>
                </td>
            </tr>
        </table>

        <div class="wrap_btn">
            <form method="get" id="linkForm">
                <input type="hidden" name="num" value="${qnaBoard.num}">
               	<%--글변경 글삭제를 위해 writer값 전달 userid와조인상태 유저네임사용 --%>
                <input type="hidden" name="writer" value="${qnaBoard.writer}">
          
                <input type="hidden" name="pageNum" value="${searchMap.pageNum}">
                <input type="hidden" name="pageSize" value="${searchMap.pageSize}">
                <input type="hidden" name="column" value="${searchMap.column}">
                <input type="hidden" name="keyword" value="${searchMap.keyword}">
                
                <button type="button" id="listBtn" class="button">글목록</button>
                
                
                    <c:if test="${adminRole || pinfo.userId eq qnaBoard.writer}">
                        <button type="button" id="modifyBtn" class="button">글변경</button>
                        <button type="button" id="removeBtn" class="button">글삭제</button>                
                    </c:if> 
                    <c:if test="${adminRole}">
                        <button type="button" id="replyBtn" class="button">답변하기</button>
                    </c:if>                 
                
            </form>
        </div>
    </c:if>

    <c:if test="${!(adminRole || pinfo.userId eq qnaBoard.originalWriter)}">
        <div style="text-align: center; margin-top: 100px;">
       		 <h1 style="font-size: 36px; text-align:center; color: black;">본인만 볼 수 있습니다.</h1>
    	</div>
    </c:if>
</sec:authorize>

<script type="text/javascript">


    $("#listBtn").click(function() {
        $("#linkForm").attr("action","<c:url value='/qnaboard/list'/>").submit();
    });

    $("#modifyBtn").click(function() {
        $("#linkForm").attr("action","<c:url value='/qnaboard/modify'/>").submit();
    });

    $("#removeBtn").click(function() {
        $("#linkForm").attr("action","<c:url value='/qnaboard/remove'/>").submit();
    });

    $("#replyBtn").click(function() {
        $("#linkForm").attr("action","<c:url value='/qnaboard/reply'/>?num=${qnaBoard.num}'").submit();
    });

   
</script>
</div>