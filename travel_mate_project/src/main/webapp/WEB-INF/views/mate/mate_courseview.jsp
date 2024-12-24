<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel=stylesheet href="<c:url value='/css/course_view.css'/>" type="text/css">
</head>
<body>
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
	    </div>
	</div>
	
	<!-- 카카오 맵 추가 -->
	<div id="map"></div>
	<!-- 
	<c:forEach var="place" items="${course.placeList}">
		<div class="element">
		<h2>${place.placeName }</h2>
		    <div class="description">
		    <pre>${place.placeContent }</pre>
		    </div>
			<img src="${place.placeImage}">
	    </div>
	</c:forEach>
	 --> 
	 
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
   
	//ajaxSend() 메소드를 호출하여 페이지를 Ajax 기능으로 페이지를 요청할 경우 무조건 CSRF 토큰 전달
	$(document).ajaxSend(function(event, xhr) {
		xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	});
	
</script>

</body>
</html>
