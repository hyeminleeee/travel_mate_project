<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>   

 <!-- Header -->
 <header id="header" class="shadow-xs">

   <!-- Navbar -->
   <div class="container position-relative">


     <nav class="navbar navbar-expand-lg navbar-light justify-content-lg-between justify-content-md-inherit">

       <!-- navbar : brand (logo) -->
       <a class="navbar-brand" href="<c:url value="/"/>">
         <img src="<c:url value="/images/logo.png"/>" width="140" alt="travel_mate">
       </a>

       <div class="align-items-start">

         <!-- mobile menu button : show -->
         <button class="navbar-toggler border-0 m-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMainNav" aria-controls="navbarMainNav" aria-expanded="false" aria-label="Toggle navigation">
           <svg width="25" viewBox="0 0 20 20">
             <path d="M 19.9876 1.998 L -0.0108 1.998 L -0.0108 -0.0019 L 19.9876 -0.0019 L 19.9876 1.998 Z"></path>
             <path d="M 19.9876 7.9979 L -0.0108 7.9979 L -0.0108 5.9979 L 19.9876 5.9979 L 19.9876 7.9979 Z"></path>
             <path d="M 19.9876 13.9977 L -0.0108 13.9977 L -0.0108 11.9978 L 19.9876 11.9978 L 19.9876 13.9977 Z"></path>
             <path d="M 19.9876 19.9976 L -0.0108 19.9976 L -0.0108 17.9976 L 19.9876 17.9976 L 19.9876 19.9976 Z"></path>
           </svg>
         </button>

       </div>
       <div class="collapse navbar-collapse justify-content-end navbar-animate-fadein" id="navbarMainNav">


         <!-- navbar : mobile menu -->
         <div class="navbar-xs d-none"><!-- .sticky-top -->

           <!-- mobile menu button : close -->
           <button class="navbar-toggler pt-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMainNav" aria-controls="navbarMainNav" aria-expanded="false" aria-label="Toggle navigation">
             <svg width="20" viewBox="0 0 20 20">
               <path d="M 20.7895 0.977 L 19.3752 -0.4364 L 10.081 8.8522 L 0.7869 -0.4364 L -0.6274 0.977 L 8.6668 10.2656 L -0.6274 19.5542 L 0.7869 20.9676 L 10.081 11.679 L 19.3752 20.9676 L 20.7895 19.5542 L 11.4953 10.2656 L 20.7895 0.977 Z"></path>
             </svg>
           </button>

           <!-- 
             Mobile Menu Logo 
             Logo : height: 70px max
           -->
           <a class="navbar-brand" href="/travel">
             <img src="<c:url value="/images/logo/logo_dark.svg"/>" width="110" height="38" alt="...">
           </a>

         </div>
         <!-- /navbar : mobile menu -->



         <!-- navbar : navigation -->
         <ul class="navbar-nav">
           <!-- mobile only image + simple search (d-block d-sm-none) -->
           <li class="nav-item d-block d-sm-none">

             <!-- image -->
             <div class="mb-4">
               <img width="600" height="600" class="img-fluid" src="demo.files/svg/artworks/people_crossbrowser.svg" alt="...">
             </div>

             <!-- search -->
             <form method="get" action="#!search" class="input-group-over mb-4 bg-light p-2 form-control-pill">
               <input type="text" name="keyword" value="" placeholder="Quick search..." class="form-control border-dashed">
               <button class="btn btn-sm fi fi-search mx-3"></button>
             </form>

           </li>
           <!-- home -->
           <li class="nav-item dropdown active">

             <a href="<c:url value='/course/list'/>" id="mainNavHome" class="nav-link" >
               여행코스 추천 
             </a>
           </li>


           <!-- pages -->
           <li class="nav-item dropdown">

             <a href="<c:url value='/mate/list'/>" id="mainNavPages" class="nav-link" >
               여행친구 모집
             </a>
			
           </li>
            
			

           <!-- features -->
           <li class="nav-item dropdown">

             <a href="<c:url value='/noticeboard/list'/>" id="mainNavFeatures" class="nav-link">
               공지사항
             </a>
			
           </li>

			
           <!-- blog -->
           <li class="nav-item dropdown">

             <a href="<c:url value='/qnaboard/list'/>" id="mainNavBlog" class="nav-link">
               Q&A
             </a>


           </li>
           
            <!-- 마이페이지 -->
		   <sec:authorize access="isAuthenticated()">
		   <sec:authentication property="principal" var="loginUser"/>
	           <li class="nav-item dropdown">
	             <a href="<c:url value='/account/mypage'/>" id="mainNavBlog" class="nav-link">
	               마이페이지
	             </a>
	           </li>
		   </sec:authorize>
          

           <!-- social icons : mobile only -->
           <li class="nav-item d-block d-sm-none text-center mb-4">

             <h3 class="h6 text-muted">Follow Us</h3>

               <!-- facebook -->
             <a href="#" class="btn btn-sm btn-facebook transition-hover-top mb-2 rounded-circle text-white" rel="noopener">
               <i class="fi fi-social-facebook"></i> 
             </a>

             <!-- twitter -->
             <a href="#" class="btn btn-sm btn-twitter transition-hover-top mb-2 rounded-circle text-white" rel="noopener">
               <i class="fi fi-social-twitter"></i> 
             </a>

             <!-- linkedin -->
             <a href="#" class="btn btn-sm btn-linkedin transition-hover-top mb-2 rounded-circle text-white" rel="noopener">
               <i class="fi fi-social-linkedin"></i> 
             </a>

             <!-- youtube -->
             <a href="#" class="btn btn-sm btn-youtube transition-hover-top mb-2 rounded-circle text-white" rel="noopener">
               <i class="fi fi-social-youtube"></i> 
             </a>

           </li>



           <!-- Get Smarty : mobile only (d-block d-sm-none)-->
           <li class="nav-item d-block d-sm-none">
             <a target="_blank" rel="noopener" href="#buy_now" class="btn w-100 btn-primary shadow-none text-white m-0">
               Get Smarty
             </a>
           </li>

         </ul>
         <!-- /navbar : navigation -->


       </div>
       
       <div class="info_login">
			   	<%-- 로그인 사용자 정보(Authentication 객체의 Principal 필드값)를 Scope 속성값으로 
				저장하여 사용 가능 --%>
				<sec:authentication property="principal" var="loginUser"/>
			   <!-- /Navbar -->
			   
			   <sec:authorize access="isAnonymous()">
				   <a href="<c:url value='/account/login'/>" id="mainNavDocumentation" class="link_loginout">
				        <span>로그인</span>
			       </a>
		       </sec:authorize>
			   <sec:authorize access="isAuthenticated()">
				    <sec:authentication property="principal" var="loginUser"/>
					<%-- authentication 태그 : 인증된 사용자(UserDetails 객체)를 제공하기 위한 태그 --%>
					<%-- 인증된 사용자만 사용 가능한 태그 --%>
					<%-- JSP 문서에 Authentication 객체를 제공하기 위한 태그 --%>
					<%-- => 인증된 사용자에게 필요한 정보를 제공 --%>
					<%-- property 속성 : 인증된 사용자의 값이 저장된 필드의 이름을 속성값으로 설정 --%>
					<%--<h3><sec:authentication property="principal.username"/>님, 환영합니다.</h3>--%>
					<%-- UserDetails 인터페이스를 상속받은 클래스로 인증된 사용자 정보가 저장되어 있는 경우
					클래스의 필드값을 제공받아 사용 가능 --%>
					<%--<h3><sec:authentication property="principal.userid"/>님, 환영합니다.</h3>--%>
					<%-- 로그아웃 처리 기능을 제공하는 페이지는 반드시 form 태그를 사용해 요청 --%>
					<%-- => CSRF 토큰을 전달하기 위한 form 태그 사용(POST 방식요청) --%>
					<span class="txt_login"><b>${loginUser.userMemberName}</b>님, 환영합니다.</span>
					<form action="<c:url value="/logout"/>" method="post" class="form_logout link_login">
						<%-- <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> --%>
						<%-- csrfInput 태그 : CSRF 토큰을 전달하기 위한 태그 --%>
						<sec:csrfInput/>
						<button type="submit" class="link_loginout">로그아웃</button>
					</form>		
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					 <c:choose>
					        <c:when test="${currentPage == 'adminPage'}"> <!-- eq를 ==로 수정 -->
					            <a href="<c:url value='/'/>" id="mainNavBlog" class="link_admin">
					                메인으로
					            </a>
					        </c:when>
					        <c:otherwise>
					            <a href="<c:url value='/adminPage'/>" id="mainNavBlog" class="link_admin">
					                관리자 페이지
					            </a>
					        </c:otherwise>
					    </c:choose>
				 </sec:authorize>
		</div>

     </nav>

   </div>
   
   
 </header>
 <!-- /Header -->