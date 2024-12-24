<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>     

<sec:authorize access="isAuthenticated()">
<%--<sec:authentication property="principal" var="loginUser"/> --%>
<!-- PAGE TITLE -->
<div class="container py-5">
	
	<h1 class="h2 fw-bold">내 여행코스</h1>


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
		        <c:choose>
		            <c:when test="${empty resultMap.courseList}">
		            
		               <p class="txt_none">작성된 게시글이 없습니다.</p>
		            </c:when>
		            <c:otherwise>
           			<div class="top-places">
		                <c:forEach var="course" items="${resultMap.courseList}">
		                    <div class="place-item">
		                        <img src="<c:url value='/images/upload/course/${course.courseImage}'/>" alt="Place ${i}">
		                        <div class="place-info">
		                            <div class="course_header">
		                                <h2 class="courseNo">${course.courseNo}</h2>
		                                <h2 class="courseTitle">
		                                    <a href="<c:url value='/course/view'/>?num=${course.courseNo}&pageNum=${resultMap.pager.pageNum}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
		                                        ${course.courseTitle}
		                                    </a>
		                                </h2>
		                            </div>
		                            <h2 class="courseWriter">${loginUser.userNickname}</h2>
		                            <div class="place-rating">
		                                <span class="count">${course.courseCount}</span>
		                                <span class="comments">${course.replyCount}</span>
		                                <span class="likes">${course.likeCount}</span>
		                            </div>
		                            <div class="place-meta">
		                                <span>등록일&nbsp;${course.courseRegdate}</span>
		                            </div>
		                        </div>
		                    </div>
		                </c:forEach>
		 		   </div>
		 		   <!-- 페이징 처리 -->
				    <div class="paging">
				        <c:forEach var="i" begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" step="1">
				            <c:choose>
				                <c:when test="${resultMap.pager.pageNum != i}">
				                    <a href="<c:url value='/account/travel_course'/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}" class="page_count">
				                        ${i}
				                    </a>
				                </c:when>
				                <c:otherwise>
				                    <span class="txt_paging">${i}</span>
				                </c:otherwise>
				            </c:choose>
				        </c:forEach>
				    </div>
		            </c:otherwise>
		        </c:choose>
          </div>
        </div>


		</div>

	</div>

</div>
<!-- / -->

</sec:authorize>