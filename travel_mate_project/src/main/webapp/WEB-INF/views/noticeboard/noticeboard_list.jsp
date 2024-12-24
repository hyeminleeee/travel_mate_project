<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>   

<link href="<c:url value="/css/board.css"/>" type="text/css" rel="stylesheet">

<div class="container board">
 <h1 class="h2 fw-bold tit_board">공지사항</h1>
        <sec:authorize access="hasRole('ROLE_ADMIN')" var="adminRole"/>
        <c:if test="${adminRole}">
            <div style="text-align: right;">
                <button class="button" type="button" onclick="location.href='<c:url value="/noticeboard/register"/>';">글쓰기</button>
            </div>
        </c:if>
        <table class="listtable">
            <tr>
                <th class="num">번호</th>
                <th class="subject">제목</th>
                <th class="regdate">작성일</th>
                <th class="writer">작성자</th>
                <th class="count">조회수</th>
            </tr>
            <c:choose>
                <c:when test="${empty resultMap.noticeBoardList}">
                    <tr>
                        <td colspan="5">검색된 게시글이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="noticeBoard" items="${resultMap.noticeBoardList}" varStatus="status" >
                        <c:if test="${noticeBoard.noticeStatus != 2}">                   
                        <tr>
                            <td>
                                <c:if test="${noticeBoard.noticeStatus == 0}">
                                    <span class="pinned">📌</span>
                                </c:if>
                            	${resultMap.pager.getDisplayNumber(status.index)}
                            </td>
                            <td>
                                <a href="<c:url value='/noticeboard/detail'/>?noticeNum=${noticeBoard.noticeNum}&pageNum=${resultMap.pager.pageNum}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
                                    <c:if test="${noticeBoard.noticeStatus == 0}"><span class="bold">${noticeBoard.noticeSubject}</span></c:if>
                                    <c:if test="${noticeBoard.noticeStatus != 0}">${noticeBoard.noticeSubject}</c:if>
                                </a>
                            </td>
                            <td>${noticeBoard.noticeRegdate}</td>
                            <td>${noticeBoard.userName}</td>
                            <td>${noticeBoard.noticeCount}</td>            
                        </tr>
                        </c:if>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
        
        <div class="paging">
            <c:choose>
                <c:when test="${resultMap.pager.startPage > resultMap.pager.blockSize}">
                    <a href="<c:url value='/noticeboard/list'/>?pageNum=${resultMap.pager.prevPage}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
                        [이전]
                    </a>
                </c:when>
                <c:otherwise>
                    [이전]
                </c:otherwise>
            </c:choose>
                
            <c:forEach var="i" begin="${resultMap.pager.startPage}" end="${resultMap.pager.endPage}" step="1">
                <c:choose>
                    <c:when test="${resultMap.pager.pageNum != i}">
                        <a href="<c:url value='/noticeboard/list'/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
                            ${i}
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span class="txt_paging">${i}</span>
                    </c:otherwise>
                </c:choose>                
            </c:forEach>
            
            <c:choose>
                <c:when test="${resultMap.pager.endPage != resultMap.pager.totalPage}">
                    <a href="<c:url value='/noticeboard/list'/>?pageNum=${resultMap.pager.nextPage}&pageSize=${resultMap.pager.pageSize}&column=${searchMap.column}&keyword=${searchMap.keyword}">
                        [다음]
                    </a>
                </c:when>
                <c:otherwise>
                    [다음]
                </c:otherwise>
            </c:choose>
        </div>
        
		<div class="search-container">
		    <form action="<c:url value='/noticeboard/list/'/>" method="post">
		        <div class="select-container">
		            <select name="column" class="selectdropdown">
		                <option value="user_name">작성자</option>
		                <option value="notice_subject">제목</option>
		                <option value="notice_content">내용</option>
		            </select>
		            <span class="selectarrow">&#9662;</span>
		        </div>
		        <input type="text" name="keyword" placeholder="검색어를 입력하세요">
		        <sec:csrfInput/>
		        <button type="submit" class="button">검색</button>
		    </form>
		</div>
 </div>