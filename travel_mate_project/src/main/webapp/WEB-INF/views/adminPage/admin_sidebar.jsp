<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<link rel="stylesheet" href="<c:url value='/css/course_list.css'/>" type="text/css">
<link rel=stylesheet href="<c:url value='/css/adminPage.css'/>" type="text/css">

<!-- sidebar -->
<div class="col col-12 col-lg-3" style="width:260px;">

	<nav class="sticky-kit nav-deep nav-deep-light">

		<div class="card">
			<div class="p-0 p-md-4" >

				<!-- mobile only -->
			<button class="clearfix btn btn-toggle btn-sm w-100 text-align-left shadow-md border rounded d-block d-lg-none" data-bs-target="#nav_responsive" data-toggle-container-class="d-none d-sm-block bg-white shadow-md border animate-fadein rounded p-3">
				<span class="group-icon px-2 py-2 float-start">
					<i class="fi fi-bars-2"></i>
					<i class="fi fi-close"></i>
				</span>

				<span class="h5 py-2 m-0 float-start">
					Account Menu
				</span>
			</button>

		
			<!-- navbar : navigation -->
			<ul id="nav_responsive" class="nav flex-column d-none d-lg-block mt-1 mt-lg-0">
				<li><!-- account name -->
					<div class="d-flex align-items-center mb-2 pb-4 border-bottom">
	                  <div class="flex-none p-3 border rounded-circle">
	                    <svg class="text-gray-300" width="34px" height="34px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460.8 460.8" fill="currentColor">
	                      <path d="M230.432,0c-65.829,0-119.641,53.812-119.641,119.641s53.812,119.641,119.641,119.641s119.641-53.812,119.641-119.641S296.261,0,230.432,0z"></path>
	                      <path d="M435.755,334.89c-3.135-7.837-7.314-15.151-12.016-21.943c-24.033-35.527-61.126-59.037-102.922-64.784c-5.224-0.522-10.971,0.522-15.151,3.657c-21.943,16.196-48.065,24.555-75.233,24.555s-53.29-8.359-75.233-24.555c-4.18-3.135-9.927-4.702-15.151-3.657c-41.796,5.747-79.412,29.257-102.922,64.784c-4.702,6.792-8.882,14.629-12.016,21.943c-1.567,3.135-1.045,6.792,0.522,9.927c4.18,7.314,9.404,14.629,14.106,20.898c7.314,9.927,15.151,18.808,24.033,27.167c7.314,7.314,15.673,14.106,24.033,20.898c41.273,30.825,90.906,47.02,142.106,47.02s100.833-16.196,142.106-47.02c8.359-6.269,16.718-13.584,24.033-20.898c8.359-8.359,16.718-17.241,24.033-27.167c5.224-6.792,9.927-13.584,14.106-20.898C436.8,341.682,437.322,338.024,435.755,334.89z"></path>
	                    </svg>
	                  </div>
	                  <div class="w-100 px-3">
	                    <span>안녕하세요,</span>
	                    <span class="d-block fw-bold">
	                     관리자 님
		                    </span>
		                  </div>
		                </div>
					</li>
					<li class="nav-item ${currentPage == 'mypage' ? 'active' : ''}">
	                 <a class="nav-link px-0 d-flex align-items-center" href="<c:url value="/adminPage"/>">
	                   <svg class="text-gray-600 float-start" width="18px" height="18px" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" fill="currentColor">
	                     <path fill-rule="evenodd" d="M8 3.293l6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6zm5-.793V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"></path>
	                     <path fill-rule="evenodd" d="M7.293 1.5a1 1 0 0 1 1.414 0l6.647 6.646a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708L7.293 1.5z"></path>
	                   </svg>
	                   <span>전체관리</span>
	                 </a>
	               </li>
	               	<li class="nav-item ${currentPage == 'travel_join' ? 'active' : ''}">
	                 <a class="nav-link px-0 d-flex align-items-center" href="<c:url value="/adminPage/mgmtUser"/>">
	                   <svg class="text-gray-600 float-start" width="18px" height="18px" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" fill="currentColor">
	                     <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"></path>
	                     <path fill-rule="evenodd" d="M11.315 10.014a.5.5 0 0 1 .548.736A4.498 4.498 0 0 1 7.965 13a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .548-.736h.005l.017.005.067.015.252.055c.215.046.515.108.857.169.693.124 1.522.242 2.152.242.63 0 1.46-.118 2.152-.242a26.58 26.58 0 0 0 1.109-.224l.067-.015.017-.004.005-.002zM4.756 4.566c.763-1.424 4.02-.12.952 3.434-4.496-1.596-2.35-4.298-.952-3.434zm6.488 0c1.398-.864 3.544 1.838-.952 3.434-3.067-3.554.19-4.858.952-3.434z"></path>
	                   </svg>
	                   <span>회원관리</span>
	                 </a>
	               	</li>
	               <li class="nav-item ${currentPage == 'travel_course' ? 'active' : ''}">
	                 <a class="nav-link px-0 d-flex align-items-center" href="<c:url value="/adminPage/mgmtChat"/>">
	                   <svg class="text-gray-600 float-start" width="18px" height="18px" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" fill="currentColor">
	                     <path fill-rule="evenodd" d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1v-1z"></path>
	                     <path fill-rule="evenodd" d="M9.5 1h-3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3zm4.354 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"></path>
	                   </svg>
	                   <span>채팅관리</span>
	                 </a>
	                </li>

				</ul>

			</div>
		</div>

	</nav>

</div>

<script type="text/javascript">

$(".btn_disable").click(function() {
	$(".modal_confirm").fadeIn(250);
	
});
//모달) 아니오 버튼 클릭시
$(".btn_no").click(function() {
	$(".modal_confirm").fadeOut(250);
	
})

$(".nav_aside").click(function() {
	$(this).toggleClass("on");
});

//ajaxSend() 메소드를 호출하여 페이지를 Ajax 기능으로 요청할 경우 무조건 CSRF 토큰 전달
$(document).ajaxSend(function(event, xhr) {
	xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
});


</script>

