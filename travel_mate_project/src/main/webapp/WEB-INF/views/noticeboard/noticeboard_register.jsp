<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>      

<link href="<c:url value="/css/board.css"/>" type="text/css" rel="stylesheet">

<div class="container board">
	 <h1 class="h2 fw-bold tit_board">공지사항 쓰기</h1>
	 <form action="<c:url value='/noticeboard/register'/>" method="post" id="boardForm">
	     <sec:csrfInput/>
	     <input type="hidden" name="noticeId" 
	         value="<sec:authentication property='principal.userId'/>">
	     <table class="commontable">
	         <tr>
	             <td><strong>제목</strong></td>
	             <td><input type="text" name="noticeSubject" id="Nsubject" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;"></td>
	         </tr>
	         <tr>
	             <td><strong>내용</strong></td>
	             <td><textarea rows="5" name="noticeContent" id="Ncontent"></textarea></td>
	         </tr>
	     </table>
	     <div class="wrap_btn">
		     <button type="button" onclick="history.back()" class="button">취소</button>
		     <button type="submit" class="button">글저장</button>
	     </div>
	 </form>
	
	 <script type="text/javascript">
	     $("#boardForm").submit(function() {
	         // 제목이 비어있는지 확인
	         if ($("#Nsubject").val().trim() === "") {
	             alert("제목을 입력해 주세요.");
	             return false;
	         }
	         
	         // 내용이 비어있는지 확인
	         if ($("#Ncontent").val().trim() === "") {
	             alert("내용을 입력해 주세요.");
	             return false;
	         }
	     });
	 </script>
 </div>