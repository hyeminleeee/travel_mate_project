<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel=stylesheet href="<c:url value='/css/course_view.css'/>" type="text/css">


<div class="post">
	<!-- 게시글 상단 정보 -->
	<div class="post-header">
	    <div class="post-title">${course.courseTitle}</div>
	    <div class="post-author">${course.userNickname}</div>
	    <div class="post-meta">
	         
	        <span class="data">
	        <c:choose>
	        	<c:when test="${course.courseUpdate == null}">
	        		${course.courseRegdate}
	        	</c:when>
	        	<c:otherwise>
	        		${course.courseUpdate}
	        	</c:otherwise>
	        </c:choose>
	        </span>
	        
	        <div class="post-actions">
	            <!-- <span class="views">5024</span> -->
	            <span class="views">${course.courseCount}</span>
	            <div id="replyCount">
	            	<span class="replyCounts">${totalReply}</span>
	            </div>
	            <!-- 좋아요 추가 -->
	            <div id="likes" class="likes">
	            	<c:choose>
	            		<c:when test="${courseLike != null}">
	            			<button id="heartBtn" onclick="heartBtnClick(${course.courseNo}, this)">
	            				<img class="heartBtn" src="<c:url value='/images/course/heart.png'/>"/>
	            			</button>
	            		</c:when>
		            	<c:otherwise>
		            		<button id="emptyHeartBtn" class="emptyHeartBtn" onclick="emptyHeartBtnClick(${course.courseNo}, this)">
		            			<img class="emptyHeartBtn" src="<c:url value='/images/course/heart_empty.png'/>" />
		            		</button>
	    	        	</c:otherwise>
	            	</c:choose>
					<span id="likeCount">${courseLikeCount.likeCount}</span> 
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- 카카오 맵 추가 -->
	<div id="map"></div>
	
	<div class="wrap_shortview">
		<c:forEach var="place" items="${course.placeList}" varStatus="status">
		<div class="course_shortview">
			<a href="#courseView${status.index}" class="link_shortview">
				<span class="wrap_img">
					<img class="img_shortview" src="<c:url value='/images/upload/course/${place.placeImage}'/>">	
				</span>
				<span class="txt_course">${place.placeName }</span>
			</a>
		</div>
		</c:forEach> 
	</div>
	
	<c:forEach var="place" items="${course.placeList}" varStatus="status">
		<div class="element" id="courseView${status.index}">
		    <div class="description">
		    <h2 style="font-size:22px;">${place.placeName }</h2>
		    <pre>${place.placeContent }</pre>
		    </div>
			<img src="<c:url value='/images/upload/course/${place.placeImage}'/>">
	    </div>
	</c:forEach> 
	 
	<div class="post_change">
		<form method="get" id="linkForm">			
			<input type="hidden" name="courseNo" value="${course.courseNo }">
			<input type="hidden" name="courseWriter" value="${course.courseWriter }">
			<input type="hidden" name="pageNum" value="${searchMap.pageNum }">
			<input type="hidden" name="pageSize" value="${searchMap.pageSize }">
			<input type="hidden" name="column" value="${searchMap.column }">
			<input type="hidden" name="keyword" value="${searchMap.keyword }">
			<input type="hidden" name="sort" value="${searchMap.sort }">
			
			<button type="button" id="listBtn">목록</button>
		<sec:authorize access="isAuthenticated()">
			<sec:authorize access="hasRole('ROLE_ADMIN')" var="adminRole"/>
			<sec:authentication property="principal" var="pinfo"/>
			
			<!-- 로그인 사용자 아이디와 게시글 작성자의 아이디가 같은 경우에만 출력 -->
			<c:if test="${adminRole || pinfo.userId eq course.courseWriter}">
				<button type="button" id="modifyBtn">변경</button>
				<button type="button" id="removeBtn">삭제</button>
			</c:if>
		</sec:authorize>	
		</form>
	</div>
</div>

<!-- 댓글 목록이 출력될 자리 --> 
<div id="replyList"></div>

<!-- 댓글창이 들어갈 자리 -->
<div class="reply_write">
    <!-- 사용자 아이콘 (기본 아이콘을 나타내기 위해 간단한 배경과 이니셜 사용) -->
    <!-- <div class="user-icon">U</div> -->
    
    <!-- 사용자 ID 표시 -->
    <div class="user-id">${travelUser.userNickname}</div>
    
    <!-- 텍스트 영역 -->
    <textarea rows="3" id="reply_content" placeholder="댓글을 작성해 주세요."></textarea>
    
    <!-- 제출 버튼 -->
    <button class="addBtn" id="addBtn">등록</button>
</div>



<!-- 카카오 맵 스크립트 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f668f12cefa13f73e2909521572e5b72"></script>
<script>
    // 마커를 표시할 위치와 title 객체 배열입니다 
    var positions = [
        <c:forEach var="place" items="${course.placeList}" varStatus="status">
            { title: '${place.placeName}', latlng: new kakao.maps.LatLng(${place.placeX}, ${place.placeY}) }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    // 지도에 표시할 모든 마커의 좌표를 가져와 영역을 조정합니다
    var bounds = new kakao.maps.LatLngBounds();
    
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
        mapOption = { 
            center: positions[0].latlng, // 지도의 중심좌표를 첫 번째 마커의 위치로 설정
            level: 3 // 지도의 확대 레벨
        };

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 마커 이미지의 이미지 주소입니다
    var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png";

    // 이동 경로를 그릴 좌표 배열을 저장할 배열
    var linePath = [];

    for (var i = 0; i < positions.length; i++) {
        // 마커 이미지의 이미지 크기입니다
        var imageSize = new kakao.maps.Size(36, 37);

        // 스프라이트 이미지를 사용할 경우, 이미지의 특정 위치를 지정해줘야 합니다
        var imgOptions = {
            spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 전체 크기
            spriteOrigin: new kakao.maps.Point(0, (i * 46) + 10), // 마커 번호에 해당하는 스프라이트 위치
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        };

        // 마커 이미지를 생성합니다    
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);

        // 마커를 생성합니다
        var marker = new kakao.maps.Marker({
            map: map, // 마커를 표시할 지도
            position: positions[i].latlng, // 마커를 표시할 위치
            title: positions[i].title, // 마커의 타이틀
            image: markerImage // 마커 이미지 
        });

        // 마커의 좌표를 경로 배열에 추가합니다
        linePath.push(positions[i].latlng);
        
        // 마커의 위치를 LatLngBounds 객체에 추가합니다
        bounds.extend(positions[i].latlng);
    }

    // 지도에 폴리라인을 표시합니다
    var polyline = new kakao.maps.Polyline({
        path: linePath, // 선을 그릴 좌표 배열
        strokeWeight: 3, // 선의 두께
        strokeColor: '#2E2EFE', // 선의 색상
        strokeOpacity: 0.5, // 선의 불투명도
        strokeStyle: 'shortdash' // 선의 스타일
    });
    
    polyline.setMap(map);
    
    // 지도 범위를 재설정하여 모든 마커가 보이도록 합니다
    map.setBounds(bounds);

    $("#listBtn").click(function() {
        $("#linkForm").attr("action","<c:url value='/course/list'/>").submit();
    });
    
    $("#modifyBtn").click(function() {
    	var courseNo="${course.courseNo}";
    	var url="<c:url value='/course/modify/'/>" + courseNo;
        $("#linkForm").attr("action", url).submit();
    });
        
    $("#removeBtn").click(function() {
    	alert("삭제하시겠습니까?");
        $("#linkForm").attr("action","<c:url value='/course/remove'/>").submit();
    });
    
    function replyListDisplay() {
    	$.ajax({
    		type: "get",
    		url: "<c:url value="/reply/list"/>",
    		data: { courseNo: ${course.courseNo}},
    		dataType: "json",
    		success: function(response) {
    			var replyList=response.replyList;
    			var loginUserid=response.loginUserid;
    			var userNickname=response.userNickname;
    			
    			if(replyList.length == 0){
    				var html="<div class='no_reply' style='text-align: center; font-size: 14px; max-width: 1200px; margin-left: auto; margin-right: auto; border: 1px solid #ddd; border-radius: 5px; resize: none; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); height: auto;'>";
    				html+="작성된 댓글이 없습니다.",
    				html+="</div>";
    				$("#replyList").html(html);
    				return;
    			}
    			
    			var html="";
    			$(replyList).each(function(){
    			    html += "<div reply-id='" + this.replyNo + "' style='max-width: 1200px; margin-left: auto; margin-right: auto; margin-bottom: 5px; border: 1px solid #ddd; border-radius: 5px; resize: none; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); height: auto;'>";
    			    html += "<div style='margin: 10px; text-align: left;'>";
    			    html += "<strong>" + this.userNickname + "</strong><br>";
    			    html += "<pre>" + this.replyContent + "</pre>";
    			    if(this.replyUpdate === null) {
	    			    html += "<p style='font-size: 12px;'>" + this.replyRegdate + "</p>";    			    	
    			    } else {
    			    	html += "<p style='font-size: 12px;'>수정일&nbsp;" + this.replyUpdate + "</p>";
    			    }
    			    html += "<div style='font-size: 12px; text-align: right;'>";
    			    if(this.replyWriter === loginUserid ) {
	    			    html += "<button class='modify-btn' onclick='modifyReply(" + this.replyNo + ")' style='border: none; background: none; margin-right: 10px;'>수정</button>";
	    			    html += "<button onclick='removeReply(" + this.replyNo + ")' style='border: none; background: none;'>삭제</button>";
    			    }
    			    html += "</div>";
    			    html += "</div>";
    			    html += "</div>";
    			});
    			$("#replyList").html(html);
    			
    		},
    		error: function(xhr){
    			alert("댓글 에러코드 = "+xhr.status);
    		}
    	});
    }
    
    replyListDisplay();
    
    
	//ajaxSend() 메소드를 호출하여 페이지를 Ajax 기능으로 페이지를 요청할 경우 무조건 CSRF 토큰 전달
	$(document).ajaxSend(function(event, xhr) {
		xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	});
    
	
	$("#addBtn").click(function() {
		var replyContent=$("#reply_content").val();
		
		$("#reply_content").val("");
		
		$.ajax({
			type: "post",
			url: "<c:url value='/reply/register'/>",
			contentType: "application/json",
			data: JSON.stringify({"replyContent":replyContent, "courseNo":${course.courseNo}}),
			dataType: "text",
			success: function(result) {
				if(result == "success") {
					replyListDisplay();
					replyCountPlus();
				}
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			error: function(xhr) {
				
					alert("에러코드 = "+xhr.status);	
				
			}
		});
	});
	
	// 댓글 수정 함수
	function modifyReply(replyNo) {
	    // 댓글 내용을 포함하는 태그를 찾아서 변수에 저장
	    var replyDiv = $('#replyList').find('div[reply-id="' + replyNo + '"]');
	    var replyContent = replyDiv.find('pre').text(); // 현재 댓글 내용을 가져옴

	    // 댓글 내용을 textarea로 바꾸고 수정 버튼을 저장 버튼으로 바꿔줌
	    replyDiv.find('pre').replaceWith('<textarea class="form-control reply-edit-content">' + replyContent + '</textarea>');
	    replyDiv.find('button.modify-btn').text('저장').attr('onclick', 'saveReply(' + replyNo + ')');
	}

	// 댓글 저장 함수
	function saveReply(replyNo) {
    var replyDiv = $('#replyList').find('div[reply-id="' + replyNo + '"]');
    var newContent = replyDiv.find('textarea.reply-edit-content').val(); // 입력된 새 댓글 내용을 가져옴

    // AJAX 요청으로 댓글 수정
    $.ajax({
        type: "post",
        url: "<c:url value='/reply/modify'/>", // 댓글 수정에 대한 URL
        data: JSON.stringify({ "replyNo": replyNo, "replyContent": newContent }), // JSON 문자열 생성
        contentType: "application/json; charset=utf-8", // charset 설정 추가
        dataType: "text", // 서버로부터 반환되는 데이터 타입 설정
        success: function(result) {
            if (result === "success") {
                replyListDisplay(); // 댓글 목록을 다시 불러옴
            } else {
                alert("댓글 수정에 실패했습니다.");
            }
        },
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        error: function(xhr) {
            alert("댓글 수정 에러코드 = " + xhr.status);
        }
    });
}

	// 댓글 삭제 함수
	function removeReply(replyNo) {
	    if (confirm("댓글을 삭제하시겠습니까?")) {
	        $.ajax({
	            type: "post",
	            url: "<c:url value='/reply/remove'/>", // 댓글 삭제에 대한 URL로 변경하세요.
	            data: JSON.stringify({ replyNo: replyNo }),
	            contentType: "application/json",
	            success: function(result) {
	                if (result === "success") {
	                    replyListDisplay(); // 댓글 목록을 다시 불러옵니다.
	                    replyCountMinus();
	                    
	                } else {
	                    alert("댓글 삭제에 실패했습니다.");
	                }
	            },
				beforeSend: function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
	            error: function(xhr) {
	                alert("댓글 삭제 에러코드 = " + xhr.status);
	            }
	        });
	    }
	}
	
	// 댓글 수 증가 함수
	function replyCountPlus() {
	    var replyCountElement = document.querySelector(".replyCounts");
	    var currentCount = parseInt(replyCountElement.innerText);
	    replyCountElement.innerText = currentCount + 1;
	}

	// 댓글 수 감소 함수
	function replyCountMinus() {
	    var replyCountElement = document.querySelector(".replyCounts");
	    var currentCount = parseInt(replyCountElement.innerText);
	    replyCountElement.innerText = currentCount - 1;
	}

	//빈 하트 클릭 시 발생 함수
	function emptyHeartBtnClick(courseNo, button) {		
	    $.ajax({
	        type: "get",
	        url: "<c:url value='/like/likeUp'/>",
	        data: { courseNo: courseNo }, // courseNo를 서버로 전송
	        success: function(response) {
	        	if(response.status == "success") {
		            // 서버 응답이 성공하면 버튼 상태를 변경
		            $(button).removeClass("heartBtn").addClass("emptyHeartBtn");
		            
		            $(button).find('img').attr('src', '<c:url value="/images/course/heart.png"/>');
		            
		            // 클릭 이벤트를 heartBtnClick 함수로 변경
		            button.onclick = function() { heartBtnClick(courseNo, button); };
	            	/*
		            var likeCount = parseInt($("#likeCount").text());
		            $("#likeCount").text(likeCount + 1);
		            */
	        	}
	        	$("#likeCount").text(response.likeCount);
	            
	        },
	        error: function(xhr, status, error) {
	            console.error("좋아요 요청 실패:", error);
	        }
	    });
	}
	
	function heartBtnClick(courseNo, button) {		
	    $.ajax({
	        type: "get",
	        url: "<c:url value='/like/likeDown'/>",
	        data: { courseNo: courseNo }, // courseNo를 서버로 전송
	        success: function(response) {
	        	if(response.status == "success") {
		            // 서버 응답이 성공하면 버튼 상태를 변경
		            $(button).removeClass("emptyHeartBtn").addClass("heartBtn");
		            $(button).find('img').attr('src', '<c:url value="/images/course/heart_empty.png"/>');
		            
		            // 클릭 이벤트를 emptyHeartBtnClick 함수로 변경
		            button.onclick = function() { emptyHeartBtnClick(courseNo, button); };
					/*
		            var likeCount = parseInt($("#likeCount").text());
		            $("#likeCount").text(likeCount - 1);
		            */
	        	}
	        	$("#likeCount").text(response.likeCount);
	        },
	        error: function(xhr, status, error) {
	            // 에러 발생 시 처리할 내용
	            console.error("좋아요 취소 요청 실패:", error);
	        }
	    });
	}
</script>
