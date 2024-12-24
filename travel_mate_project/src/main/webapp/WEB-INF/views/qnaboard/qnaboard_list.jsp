<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>    

<link href="<c:url value="/css/board.css"/>" type="text/css" rel="stylesheet">

<div class="container board">
	<h1 class="h2 fw-bold tit_board">Q&A</h1>
	 <div style="text-align: right;">
                <button class="button" type="button" onclick="location.href='<c:url value="/qnaboard/register"/>';">글쓰기</button>
            </div>
        
        <table class="listtable">
            <tr>
                <th class="num">글번호</th>
                <th class="writer">작성자</th>
                <th class="subject">제목</th>
                <th class="regdate" >작성일</th>
                <th class="verify">답변여부</th>
            </tr>
            <c:choose>
                <c:when test="${empty resultMap.qnaBoardList }">
                    <tr>
                        <td colspan="5">검색된 게시글이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                	<c:forEach var="qnaBoard" items="${resultMap.qnaBoardList }"  varStatus="status">   
                       <c:if test="${qnaBoard.verify != 2}">
                        <tr>
                             <td>${resultMap.pager.getDisplayNumber(status.index)}</td> 
                             
                             <td> ${qnaBoard.userName}</td>

                             <td style="text-align: left;">
                                <c:if test="${qnaBoard.step != 0}">
                                    <span style="margin-left: ${qnaBoard.indent * 20}px;">ㄴ[답변:] Q:</span>
		                           
                                </c:if>
                                <a href="<c:url value="/qnaboard/detail"/>?num=${qnaBoard.num}&pageNum=${resultMap.pager.pageNum}&pageSize=${resultMap.pager.pageSize }&column=${searchMap.column}&keyword=${searchMap.keyword}">
                                ${qnaBoard.subject }
                                </a>
                             </td>           
                             <td>${qnaBoard.regdate }</td>
                             <td>    
	           					  <c:if test="${qnaBoard.step >= 1}"></c:if>
								  <c:if test="${qnaBoard.step < 1}">
								       ${qnaBoard.verify == 0 ? '문의중' : '답변완료'}
								  </c:if>
							</td>            
                        </tr>
                        </c:if>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
        <div class="paging">
            <c:choose>
                <c:when test="${resultMap.pager.startPage > resultMap.pager.blockSize }">
                    <a href="<c:url value="/qnaboard/list"/>?pageNum=${resultMap.pager.prevPage}&pageSize=${resultMap.pager.pageSize }&column=${searchMap.column}&keyword=${searchMap.keyword}">
                        [이전]
                    </a>
                </c:when>
                <c:otherwise>
                    [이전]
                </c:otherwise>
            </c:choose>
                
            <c:forEach var="i" begin="${resultMap.pager.startPage }" end="${resultMap.pager.endPage }" step="1">
                <c:choose>
                    <c:when test="${resultMap.pager.pageNum != i }">
                        <a href="<c:url value="/qnaboard/list"/>?pageNum=${i}&pageSize=${resultMap.pager.pageSize }&column=${searchMap.column}&keyword=${searchMap.keyword}">
                            ${i }
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span class="txt_paging">${i }</span>
                    </c:otherwise>
                </c:choose>                
            </c:forEach>
            
            <c:choose>
                <c:when test="${resultMap.pager.endPage != resultMap.pager.totalPage }">
                    <a href="<c:url value="/qnaboard/list"/>?pageNum=${resultMap.pager.nextPage}&pageSize=${resultMap.pager.pageSize }&column=${searchMap.column}&keyword=${searchMap.keyword}">
                        [다음]
                    </a>
                </c:when>
                <c:otherwise>
                    [다음]
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="search-container">
		    <form action="<c:url value='/qnaboard/list/'/>" method="post">
		        <div class="select-container">
		            <select name="column" class="selectdropdown">
		              	<option value="user_name">작성자</option>
                   		<option value="subject">제목</option>
                   	 	<option value="content">내용</option>
		            </select>
		            <span class="selectarrow">&#9662;</span>
		        </div>
		        <input type="text" name="keyword" placeholder="검색어를 입력하세요">
		        <sec:csrfInput/>
		        <button type="submit" class="button">검색</button>
		    </form>
		</div>
</div>



