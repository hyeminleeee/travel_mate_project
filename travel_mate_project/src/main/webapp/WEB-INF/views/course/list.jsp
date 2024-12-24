<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HOT한 방문지 TOP 10</title>
<link rel="stylesheet" href="<c:url value='/css/course_list.css'/>" type="text/css">
</head>
<body>
<div class="content-container"> 
	<div class="top">
	    <h1 class="total">
	        <a href="<c:url value='/course/list'/>">전체 보기</a>
	    </h1>
	    <!-- 새 컨테이너를 추가하여 버튼과 select 태그를 그룹화 -->
	    <div class="right-controls">
	        <!-- '내 코스 작성하기' 버튼 추가 -->
	        <button class="create-course-btn" onclick="location.href='<c:url value='/course/write' />'">내 코스 작성하기</button>
	        <!-- 정렬 선택 태그 추가 -->
	        <form id="sortForm" action="<c:url value='/course/list'/>?pageNum=${resultMap.pager.pageNum}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}&sort=${searchMap.sort}" method="get">
		        <select name="sort" id="sort" onchange="submitForm()">
		            <option value="course_regdate">최신순</option>
		            <option value="like_count" <c:if test="${searchMap.sort == 'like_count'}">selected</c:if>>인기순</option>
		            <option value="reply_count" <c:if test="${searchMap.sort == 'reply_count'}">selected</c:if>>댓글 많은 순</option>
		        </select>
		        
				<input type="hidden" name="pageNum" value="${searchMap.pageNum }">
				<input type="hidden" name="pageSize" value="${searchMap.pageSize }">
				<input type="hidden" name="column" value="${searchMap.column }">
				<input type="hidden" name="keyword" value="${searchMap.keyword }">
			</form>
	    </div>
	</div>
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
                                <h2 class="courseNo">${course.rownum}</h2>
                                <h2 class="courseTitle">
                                    <a href="<c:url value='view'/>?num=${course.courseNo}&pageNum=${resultMap.pager.pageNum}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}&sort=${searchMap.sort}">
                                        ${course.courseTitle}
                                    </a>
                                </h2>
                            </div>
                            <h2 class="courseWriter">${course.userNickname}</h2>
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
		</c:otherwise>
	</c:choose>
    

    <!-- 페이징 처리 -->
    <div class="paging">
        <c:forEach var="i" begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" step="1">
            <c:choose>
                <c:when test="${resultMap.pager.pageNum != i}">
                    <a href="<c:url value='/course/list'/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}&sort=${searchMap.sort}" class="page_count">
                        ${i}
                    </a>
                </c:when>
                <c:otherwise>
                    <span class="txt_paging">${i}</span> 
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>

    <!-- 검색 태그 추가 -->
    <div class="search-bar">
        <form action="<c:url value='/course/list'/>" method="get">
        	<input type="hidden" name="sort" value="${searchMap.sort }">
            <!-- 검색 옵션 선택 -->
            <select name="column" id="search-column">
                <option value="course_writer">작성자</option>
                <option value="course_title">제목</option>
                <option value="place_content">내용</option>
            </select>

            <!-- 검색어 입력 -->
            <input type="text" name="keyword"/>
            <sec:csrfInput/>
            <!-- 검색 버튼 -->
            <button type="submit">검색</button>
        </form>
    </div>
</div>
<script>
	function submitForm(){
		document.getElementById("sortForm").submit();
	}
</script>
</body>
</html>
