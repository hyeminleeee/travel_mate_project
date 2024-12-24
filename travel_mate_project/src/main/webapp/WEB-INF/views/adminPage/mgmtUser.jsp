<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%-- 부트스트랩 --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<%-- CSS --%>
<link rel=stylesheet href="<c:url value='/css/adminPage.css'/>" type="text/css">

<div class="container main_div row">
	<h1 class="titleWord mb-5">회원 관리</h1>

	<jsp:include page="/WEB-INF/views/adminPage/admin_sidebar.jsp"/>

	<div class="col container text-center mb-5" id="adminDiv">

		


		<div class="my-3">
			<form>
				<div class="row">
					<div class="col d-flex align-items-center justify-content-start title"><img class="me-2" alt="" src="<c:url value='/images/adminPage/user.png'/>"/>회원 정보</div>
					<div class="col d-flex align-items-center justify-content-end"><img class="me-2 mb-1" alt="" src="<c:url value='/images/adminPage/search.png'/>"/>
						<div class="input-group input-group-sm mb-1 w-75">
							
								<select class="form-select form-select-sm pe-0" name="column" >
									<option value="user_id" ${searchMap.column == 'user_id' ? 'selected' : ''}>아이디</option>
									<option value="user_name" ${searchMap.column == 'user_name' ? 'selected' : ''}>이름</option>
									<option value="user_nickname" ${searchMap.column == 'user_nickname' ? 'selected' : ''}>닉네임</option>
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
							<th class="th_custom">아이디</th>
							<th class="th_custom">이름</th>
							<th class="th_custom">닉네임</th>
							<th class="th_custom">이메일</th>
							<th class="th_custom">전화번호</th>
							<th class="th_custom">연령대</th>
							<th class="th_custom">성별</th>
							<th class="th_custom">가입일</th>
							<th class="th_custom">상태</th>
							<th class="th_custom">변경</th>
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
							    	<c:when test="${user.userStatus == 1}">
							    		<td style="font-weight:bold;">관리자</td>
							    		<td>-</td>
							    	</c:when>
							    	<c:otherwise>
							    		<c:choose>
									    	<c:when test="${user.userEnabled == 0 }">
											    <td class="userStatus" style="color:#e30000;">탈퇴</td>
									    	</c:when>
									    	<c:when test="${user.userEnabled == 1 }">
											    <td class="userStatus">-</td>
									    	</c:when>
									    </c:choose>
									    
									    <td class="d-flex justify-content-center align-items-center">
										    <c:choose>
										    	<c:when test="${user.userEnabled == 0 }">
												    <button type="button" class="btn btn-sm btn-success py-0" onclick="rest('${user.userId }', this)">복구</button>
										    	</c:when>
										    	<c:when test="${user.userEnabled == 1 }">
												    <button type="button" class="btn btn-sm btn-danger py-0" onclick="del('${user.userId }', this)">탈퇴</button>
										    	</c:when>
										    </c:choose>
									    </td>							    	
							    	</c:otherwise>
							    </c:choose>
							    
							    
							    
									    
							    	        
							    <td class="text-start">${user.userIntroduction }</td>
							</tr>
						
						</c:forEach>
					</table>
				</div>
			</div>
		</div>

	<div class="my-5" style="height:30px;"></div>
</div>

<script>

function rest(id, button) {
	
	$.ajax({
		type : "get",
		url : "<c:url value="/adminPage/userModify"/>/"+id+"/1", // 1 = 사용자 0 = 탈퇴
		dataType: "text",
		success: function(result) {	
	
	
			$(button).removeClass("btn-success").addClass("btn-danger");
			$(button).text("탈퇴")
			
			button.onclick = function() { del(id, button); };
			
			var fileInput = $(button).closest('tr').find('.userStatus');
			fileInput.text("-").css("color", "black");
		
		}
	});
}

function del(id, button) {
	
	$.ajax({
		type : "get",
		url : "<c:url value="/adminPage/userModify"/>/"+id+"/0", // 1 = 사용자 0 = 탈퇴
		dataType: "text",
		success: function(result) {	
	
			$(button).removeClass("btn-danger").addClass("btn-success");
			$(button).text("복구")
			
			
			button.onclick = function() { rest(id, button); };
			
			var fileInput = $(button).closest('tr').find('.userStatus');
			fileInput.text("탈퇴").css("color", "#e30000");
	
		}
	});
}


</script>




