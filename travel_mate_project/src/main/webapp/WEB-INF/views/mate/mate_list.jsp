<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>동행 목록</title>
<style>
.content-container {
    max-width: 1200px;
    margin: 40px auto;
    background-color: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}
.top {
    display: flex;
    justify-content: space-between; /* 좌우로 요소 배치 */
    align-items: center; /* 수직 정렬 */
    padding: 10px;
}

/* 새로 추가한 컨테이너에 스타일 적용 */
.right-controls {
    display: flex; /* 버튼과 select 태그를 나란히 배치 */
    align-items: center;
}

.create-course-btn {
    padding: 5px 10px;
    background-color: #fff;
    border: none;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    cursor: pointer;
    font-size: 13px;
    color: #333;
    border-radius: 5px;
    margin-right: 10px; /* 오른쪽 여백을 추가하여 select 태그와 간격 조정 */
}

.create-course-btn:hover {
    background-color: #f5f5f5;
    font-weight: bold;
}

#sort {
    background-color: white; /* 배경색 */
    padding: 5px 10px 5px 10px; /* 내부 여백, 오른쪽에 공간 확보 */
    font-size: 13px; /* 글자 크기 */
    color: #333; /* 글자 색상 */
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
}
h1 {
    font-size: 24px; 
    font-weight: bold;
    color: #333;
    margin-bottom: 10px;
    display: inline;
}
.top-places {
    display: flex;
    flex-direction: column; /* 세로로 쌓이도록 설정 */
    gap: 20px; /* 게시글 간의 간격 */
    margin-top: 10px;
}
.place-item {
    display: flex;
    justify-content: space-between; /* 게시물 내용을 좌우로 정렬 */
    background-color: #fff;
    border-radius: 8px; /* 둥근 모서리로 박스 설정 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    padding: 10px;
    align-items: center; /* 가운데 정렬 */
    height: 80px; /* 전체 높이 설정 */
    overflow: hidden;
    width: 100%;
}

.place-item img {
    width: 60px;
    height: 60px;
    object-fit: cover;
	border-radius: 8px;
}

.left-info {
    display: flex;
    align-items: center; /* 게시물 번호와 제목을 수직 중앙 정렬 */
}
.place-info {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    width: 100%; /* 텍스트가 가득 차도록 설정 */
    margin-left: 10px;
}

.course_header {
    display: flex; /* 한 줄로 배치 */
    align-items: center; /* 수직 중앙 정렬 */
    margin-bottom: 5px;
}

.courseNo {
    margin-right: 10px; /* 번호와 제목 사이 간격 */
    font-size: 18px;
    font-weight: bold;
    color: orange;
}

.courseTitle a {
    font-size: 16px;
    color: #333;
    text-decoration: none; /* 밑줄 제거 */
}
/*
.courseNo, .courseTitle {
    margin: 0; /* 불필요한 기본 마진 제거 */
    padding: 0; /* 불필요한 기본 패딩 제거 */
    margin-right: 10px; /* 요소 사이 간격 조정 */
    font-size: 16px; /* 같은 폰트 크기 지정 */
    line-height: 1.2; /* 같은 줄 높이 지정 */
}
*/
.courseNo {
    font-size: 24px; /* 게시물 번호 크기 */
    font-weight: bold;
    color: orange;
    margin-right: 20px; /* 제목과의 간격 조정 */
}
.courseTitle {
    font-size: 20px; /* 제목 크기 */
    color: #333;
}
.boardWriter {
	font-size: 15px;
    color: #878787;
	padding-left: 20px;
}

.right-info {
    display: flex;
    flex-direction: column;
    align-items: flex-end; /* 오른쪽 끝에 맞춤 */
}
.place-rating {
    display: flex;
    align-items: center;
    font-size: 14px;
    margin-top: 5px;
    margin-left: auto;
    color: #999;
}
.place-rating span {
    margin-right: 8px;
}
.place-rating .stars {
    margin-right: 5px;
    color: #ff9800;
}
.count {
	padding-right: 8px;
}
.comments {
	padding-right: 8px;
}
.place-rating .count::before {
	content: '👁';
}
.place-rating .comments::before {
	content: '💬';
}
.place-rating .likes::before {
	content: '❤️';
	color: pink;
}
.place-meta {
	display: flex;
    font-size: 12px;
    color: #666;
}
.place-meta span {
	margin-left: auto;
}
.paging {
    display: flex;
    justify-content: center; /* 가로 정렬을 가운데로 */
    margin-top: 20px; /* 원하는 간격을 위해 추가 (선택 사항) */
}
.page_count {
	float: left;
	margin: 0 5px; /* 페이지 번호 간의 간격 조절 */
	color: gray;
}
.page_count:hover {
	font-weight: bold;
}
.search-bar {
    display: flex;
    justify-content: center; /* 가운데 정렬 */
    align-items: center;
    margin-top: 20px; /* 위쪽에 간격 추가 */ 
}

#search-column {
    padding: 5px;
    margin-right: 10px; /* 검색창과 간격 추가 */
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
    font-size: 13px;
}

.search-bar input[type="text"] {
    padding: 5px;
    width: 200px;
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
    margin-right: 10px; /* 검색 버튼과 간격 추가 */
}

.search-bar button {
    padding: 5px 10px;
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
    background-color: #333;
    color: white;
    cursor: pointer;
}

.search-bar button:hover {
    background-color: #555;
}

</style>
</head>
<body>
	<div class="content-container">
	<div class="top">
	    <h1 class="total">
	        <a href="<c:url value='/mate/list'/>">전체 보기</a>
	    </h1>
	    <!-- 새 컨테이너를 추가하여 버튼과 select 태그를 그룹화 -->
	    <div class="right-controls">
	        <!-- '내 코스 작성하기' 버튼 추가 -->
	        <button class="create-course-btn" onclick="location.href='<c:url value='/mate/register' />'">메이트 모집 작성하기</button>
	        <!-- 정렬 선택 태그 추가 -->
	        <!-- 
	        <select name="sort" id="sort" onchange="submitForm()">
	            <option value="popular">인기순</option>
	            <option value="latest">최신순</option>
	            <option value="comments">댓글 많은 순</option>
	        </select>
	         -->
	    </div>
	</div>
    
        <c:choose>
            <c:when test="${empty resultMap.mateBoardList}">
                <p class="txt_none">작성된 게시글이 없습니다.</p>
            </c:when>
            <c:otherwise>
	            <div class="top-places">
	                <c:forEach var="mateBoard" items="${resultMap.mateBoardList}">
	                    <div class="place-item">
	                       	<!-- <img src="<c:url value='/images/upload/mate/${mateBoard.boardImage}'/>" alt="Place ${i}"> -->
	                        <div class="place-info">
	                            <div class="course_header">
	                                <h2 class="courseNo">${mateBoard.rownum}</h2>
	                                <h2 class="courseTitle">
	                                    <a href="<c:url value="/mate/detail"/>?boardNo=${mateBoard.boardNo}&pageNum=${resultMap.pager.pageNum}&pageSize=${resultMap.pager.pageSize }&column=${searchMap.column}&keyword=${searchMap.keyword}">
										 	${mateBoard.boardTitle }
	                                    </a>
	                                </h2>
		                            <div class="place-rating">
		                            	<span class="mateCount">인원: ${mateBoard.mateCount}/${mateBoard.mateMaxCount} </span>
		                                <span class="count">${mateBoard.boardCount}</span>
		                                <span class="comments">${mateBoard.replyCount}</span>
		                                <span class="likes">${mateBoard.likeCount}</span>
		                            </div>
	                            </div>
	                            <div class="place-meta">
		                            <h2 class="boardWriter">${mateBoard.userNickname}</h2>
	                                <span>${mateBoard.boardRegdate}</span>
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
                    <a href="<c:url value='/mate/list'/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}" class="page_count">
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
        <form action="<c:url value='/mate/list'/>" method="get">
            <!-- 검색 옵션 선택 -->
            <select name="column" id="search-column">
                <option value="user_name">작성자</option>
                <option value="board_title">제목</option>
                <option value="board_content">내용</option>
            </select>

            <!-- 검색어 입력 -->
            <input type="text" name="keyword"/>
            <sec:csrfInput/>
            <!-- 검색 버튼 -->
            <button type="submit">검색</button>
        </form>
    </div>
</div>
</body>
</html>












