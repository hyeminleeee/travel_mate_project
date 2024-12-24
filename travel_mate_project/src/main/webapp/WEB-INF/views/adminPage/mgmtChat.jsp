<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 부트스트랩 --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<%-- CSS --%>
<link rel=stylesheet href="<c:url value='/css/adminPage.css'/>" type="text/css">

<div class="container main_div row">
	<h1 class="titleWord mb-5">채팅 관리</h1>

	<jsp:include page="/WEB-INF/views/adminPage/admin_sidebar.jsp"/>

	<div class="col container text-center mb-5" id="adminDiv">

		


		<div class="my-3">
			<form>
				<div class="row">
					<div class="col d-flex align-items-center justify-content-start title"><img class="me-2" alt="" src="<c:url value='/images/adminPage/adminChat.png'/>"/>채팅 정보</div>
					<div class="col d-flex align-items-center justify-content-end"><img class="me-2 mb-1" alt="" src="<c:url value='/images/adminPage/search.png'/>"/>
						<div class="input-group input-group-sm mb-1 w-75">
							
								<select class="form-select form-select-sm pe-0" name="column">
									<option value="room_no" ${searchMap.column == 'room_no' ? 'selected' : ''}>방 번호</option>
									<option value="writer" ${searchMap.column == 'writer' ? 'selected' : ''}>채팅 작성자</option>
									<option value="content" ${searchMap.column == 'content' ? 'selected' : ''}>채팅 내용</option>
									<option value="regdate" ${searchMap.column == 'regdate' ? 'selected' : ''}>채팅 일시</option>
								</select>
							
								<input type="text" class="form-control w-25" name="keyword" value="${searchMap.keyword }">
								<button class="btn btn-dark" type="submit" id="button-addon2">&nbsp;검색&nbsp;</button>
						</div>
					</div>
				</div>
			</form>
				<div class="col overflow-auto pe-0" style="max-height:690px;">
					<table class="table table-sm border table-striped table-hover text-truncate mb-0">
						<tr>
							<th class="th_custom">No</th>
							<th class="th_custom" colspan="2">채팅방 번호</th>
							<th class="th_custom">채팅 작성자</th>
							<th class="th_custom" style="max-width:600px;width:600px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">채팅 내용</th>
							<th class="th_custom_end" style="width:170px;" >채팅 일시</th>
						</tr>
						
						<c:forEach var="chat" items="${chatList }" varStatus="status" >
							<tr>
								<td>${status.index + 1}</td>
							    <td>${chat.roomNo }번방</td>
							    <td><button class="btn btn-sm btn-warning" onclick="openRoom(${chat.roomNo })" style="height:23px;padding:1px 5px;">이동</button></td>
							    <td>${chat.writer }</td>
							    <td style="text-align:left;padding-left:10px;">${chat.content }</td>
							    <td><fmt:formatDate value="${chat.regdate}" pattern="yy.MM.dd HH:mm:ss" /></td>
							    
							</tr>
						
						</c:forEach>
					</table>
				</div>
			</div>
		</div>

	<div class="my-5" style="height:30px;"></div>
</div>

<script>

function openRoom(roomNo) {
	var url = "${pageContext.request.contextPath}"+"/chat/room/"+roomNo; // 채팅방 URL
       var windowName = 'ChatRoom'; // 새 창의 이름
       popupWindow = window.open(url, windowName, "resizeable");
       
       popupWindow.resizeTo(400, 800);
	   	popupWindow.onresize = (_=>{
	   	    popupWindow.resizeTo(400, 800);
	   	})
}


</script>




