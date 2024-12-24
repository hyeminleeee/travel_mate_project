<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행코스 선택</title>
    <!-- 부트스트랩 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- 내부 스타일 -->
    <style>
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f8f9fa; /* 연한 배경 */
        }

        .popup-window {
            width: 600px;
            background-color: #fff; /* 흰색 배경 */
            border-radius: 15px; /* 둥근 모서리 */
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* 그림자 */
        }

        h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
            font-weight:bold;
        }

        .element {
            display: flex;
            justify-content: space-between; /* 제목과 버튼 사이 간격 */
            align-items: center;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            background-color: #f8f9fa;
        }

        .element span {
            font-size: 16px;
            color: #333;
            max-width: 370px; /* 텍스트가 차지할 최대 너비 */
            white-space: nowrap; /* 한 줄로 표시 */
            overflow: hidden; /* 넘치는 부분을 숨김 */
            text-overflow: ellipsis; /* 넘치는 부분을 "..."으로 표시 */
        }

        .button-group { 
            display: flex;
            gap: 10px; /* 버튼 사이 간격 */
        }

        .element button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }

        .element button:hover {
            background-color: #0056b3;
        }

        .element .secondary-button {
            background-color: #6c757d; /* 보조 버튼 색상 */
        }

        .element .secondary-button:hover {
            background-color: #5a6268;
        }
        
        .popup-window {
            max-height: 800px; /* 최대 높이 설정 */
		    overflow-y: auto;  /* 세로 스크롤 허용 */
		    overflow-x: hidden; /* 가로 스크롤 숨기기 */
        }
        .popup-window::-webkit-scrollbar {
    		display: none; 
    </style>

</head>
<body>
    <div class="popup-window" id="popupWindow">
        <div class="post">
            <h2>여행코스 선택</h2>
            <c:forEach var="course" items="${resultMap.courseList}">
                <div class="element">
                    <span>${course.courseTitle}</span>
                    <div class="button-group">
                        <button type="button" onclick="selectCourse('${course}')">선택</button>
                        <!-- <button type="button" class="secondary-button" onclick="selectCoursePlace()'${course.courseNo}')">경로</button> -->
                    	<button type="button" class="secondary-button" onclick="location.href='<c:url value='/mate/registerView' />?num=${course.courseNo}'">경로</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        function adjustWindowSize() {
            // 현재 내용의 높이를 기반으로 창 크기 조정, 가로 길이는 고정
            const popupWindow = document.getElementById('popupWindow');
            const windowHeight = popupWindow.offsetHeight;
            window.resizeTo(616, windowHeight + 74); // 620px 너비로 고정하고 높이만 동적으로 조정
        }

        function selectCourse(course) {
            window.opener.receiveCourse(course); // 부모 창에 데이터 전달
            window.close(); // 창 닫기
        }

        function selectCoursePlace(courseNo) {
            
        }

        function closeWindow() {
            window.close(); // 창 닫기
        }

        // 페이지 로드 시 창 크기 조정
        window.onload = adjustWindowSize;
    </script>
</body>
</html>
