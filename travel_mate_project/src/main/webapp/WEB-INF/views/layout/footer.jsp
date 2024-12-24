<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!-- Footer -->
<footer id="footer" class="bg-gray-900 text-white">

	<!-- line divider -->
	<hr class="bg-gray-500 my-0 container">
	
	<div class="container py-5">

		<div class="row g-4">
			
			<div class="col-12 col-lg-4 mb-4">

				<!-- logo -->
				 <img src="<c:url value="/images/logo_dark.png"/>" width="140" alt="travel_mate">

				<div class="my-4"><!-- copyright -->
					<p class="small mb-0">&copy; 2024 itwill.</p>
					<p class="small mb-0">All rights reserved.</p>
				</div>

				<!-- social icons -->
				<%--
				<a href="#" class="btn btn-sm text-white transition-hover-top mb-2 rounded-circle bg-gray-700" rel="noopener" aria-label="facebook page">
					<i class="fi fi-social-facebook"></i> 
				</a>

				<a href="#" class="btn btn-sm text-white transition-hover-top mb-2 rounded-circle bg-gray-700" rel="noopener" aria-label="twitter page">
					<i class="fi fi-social-twitter"></i> 
				</a>

				<a href="#" class="btn btn-sm text-white transition-hover-top mb-2 rounded-circle bg-gray-700" rel="noopener" aria-label="linkedin page">
					<i class="fi fi-social-linkedin"></i> 
				</a>

				<a href="#" class="btn btn-sm text-white transition-hover-top mb-2 rounded-circle bg-gray-700" rel="noopener" aria-label="youtube page">
					<i class="fi fi-social-youtube"></i> 
				</a>
				 --%>

			</div>

			<div class="col-12 col-lg-4 mb-4">

				<h3 class="small mb-4">연락처</h3>

				<p class="small col-md-10">
					Travel Mate는 여러분이 새로운 여행을 쉽게 시작할 수 있도록 도와드립니다!
				</p>

          <div class="small d-flex align-items-start my-3">
            <svg class="me-3 flex-none my-1" height="24px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
              <circle cx="12" cy="10" r="3"></circle>
            </svg>
            <ul class="list-unstyled p-0 m-0 w-100">
              <li>서울시 강남구</li>
              <li>역삼동</li>
            </ul>
          </div>

          <div class="small d-flex align-items-start my-3">
            <svg class="me-3 flex-none my-1" height="24px" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">  
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"></path>
            </svg>
            <ul class="list-unstyled p-0 m-0 w-100">
              <li>Phone: <a href="tel:010-0000-0000" class="text-white text-dashed">010-0000-0000</a></li>
              <li>Email: <a href="mail:abc@itwill.com" class="text-white text-dashed">abc@itwill.com</a></li>
            </ul>
          </div>

			</div>


			<div class="col-12 col-lg-4 mb-4">

				<h3 class="small mb-4">사이트맵</h3>

				<ul class="list-unstyled"> 
					<li class="list-item mb-2">
						<a class="text-gray-400" href="<c:url value='/course/list'/>">추천코스</a>
					</li> 
					<li class="list-item mb-2">
						<a class="text-gray-400" href="<c:url value='/mate/list'/>">친구모집</a>
					</li> 
					<li class="list-item mb-2">
						<a class="text-gray-400" href="<c:url value='/noticeboard/list'/>">공지사항</a>
					</li> 
					<li class="list-item mb-2">
						<a class="text-gray-400" href="<c:url value='/qnaboard/list'/>">Q&amp;A</a>
					</li> 
				</ul>

			</div>

		</div>

	</div>

</footer>
<!-- /Footer -->
