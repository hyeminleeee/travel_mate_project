<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>     

<sec:authorize access="isAuthenticated()">
<%--<sec:authentication property="principal" var="loginUser"/> --%>
<!-- PAGE TITLE -->
<div class="container py-5">
	
	<h1 class="h2 fw-bold">프로필</h1>

	<!--
		<ul class="list-inline small text-muted m-0">
		  <li class="list-inline-item">
		    <a href="account-orders.html" class="d-flex align-items-center link-muted">
		      <svg width="18px" height="18px" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" fill="currentColor">
		        <path fill-rule="evenodd" d="M12 8a.5.5 0 0 1-.5.5H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5a.5.5 0 0 1 .5.5z"></path>
		      </svg>
		      <span class="text-muted px-1">back to orders</span>
		    </a>
		  </li>
		</ul>
	-->

</div>
<!-- /PAGE TITLE -->




<!-- -->
<div class="container pb-6">

	<div class="row g-4">
		
		<!-- sidebar -->
		<jsp:include page="/WEB-INF/views/account/mypage_sidebar.jsp"/>


		<!-- content -->
		<div class="col-12 col-lg-9">

        <!-- Feedback -->
        <div class="card mb-4">
          <div class="card-body p-4">

            <form method="get" action="<c:url value="/account/modify"/>">
			  <input type="hidden" name="userId" value="${loginUser.userId }">
              <dl class="list_profile clear_fix">
              	<dt>이름</dt>
              	<dd>${loginUser.userName }</dd>
              	<dt>닉네임</dt>
              	<dd>${loginUser.userNickname }</dd>
              	<dt>이메일</dt>
              	<dd>${loginUser.userEmail }</dd>
              	<dt>전화번호</dt>
              	<dd>${loginUser.userPhone }</dd>
              	<dt>소개글</dt>
              	<dd>${loginUser.userIntroduction }</dd>
              	<dt>연령대</dt>
              	<dd>${loginUser.userAge }</dd>
              </dl>
              

              <button type="submit" class="btn_modify btn btn-sm btn-primary d-flex align-items-center">
                <span>수정</span>
              </button>

            </form>

          </div>
        </div>


		</div>

	</div>

</div>
<!-- / -->

</sec:authorize>