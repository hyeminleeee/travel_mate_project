<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>     

<sec:authorize access="isAuthenticated()">
<%--<sec:authentication property="principal" var="loginUser"/> --%>
<!-- PAGE TITLE -->
<div class="container py-5">
	
	<h1 class="h2 fw-bold">참여여행</h1>
	
	
	

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
			            <c:when test="${empty resultMap.mateBoardList}">
			            
			               <p class="txt_none">참여한 여행이 없습니다.</p>
			            </c:when>
			            <c:otherwise>
            			<div class="top-places">
			                <c:forEach var="mate" items="${resultMap.mateBoardList}">
			                    <div class="place-item mypage">
			                        <%--<img src="<c:url value='/images/upload/course/${mate.boardImage}'/>" alt="Place ${i}">--%>
			                        <div class="place-info">
			                            <div class="course_header">
			                                <h2 class="courseNo">${mate.boardNo}</h2>
			                                <h2 class="courseTitle">
			                                    <a href="<c:url value='/mate/detail'/>?boardNo=${mate.boardNo}&pageNum=${resultMap.pager.pageNum}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
			                                        ${mate.boardTitle}
			                                    </a>
			                                </h2>
			                            </div>
			                            <h2 class="courseWriter">${mate.userNickname}</h2>
			                            <div class="place-rating">
			                                <span class="count">${mate.boardCount}</span>
			                                <span class="comments">${mate.replyCount}</span>
			                                <span class="likes">${mate.likeCount}</span>
				                            <div class="place-meta">
				                                <span>등록일&nbsp;${mate.boardRegdate}</span>
				                            </div>
			                            </div>
			                        </div>
			                    </div>
			                </c:forEach>
			 		   </div>
			            </c:otherwise>
			        </c:choose>
			
			    <!-- 페이징 처리 -->
			    <div class="paging">
			        <c:forEach var="i" begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" step="1">
			            <c:choose>
			                <c:when test="${resultMap.pager.pageNum != i}">
			                    <a href="<c:url value='/account/travel_join'/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}" class="page_count">
			                        ${i}
			                    </a>
			                </c:when>
			                <c:otherwise>
			                    <span class="txt_paging">${i}</span>
			                </c:otherwise>
			            </c:choose>
			        </c:forEach>
			    </div>

          </div>
        </div>


		</div>

	</div>

</div>
<!-- / -->

</sec:authorize>