<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SECURITY</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<div class="container mt-5">
	<div class="main_div card p-4 shadow">
       <form action="<c:url value='/mate/modify' />" method="post" id="boardForm">
           <sec:csrfInput />
           <input type="hidden" name="boardNo" value="${mateBoard.boardNo }">
			<input type="hidden" name="boardWriter" value="${mateBoard.boardWriter }">
			<input type="hidden" name="pageNum" value="${searchMap.pageNum }">
			<input type="hidden" name="pageSize" value="${searchMap.pageSize }">
			<input type="hidden" name="column" value="${searchMap.column }">
			<input type="hidden" name="keyword" value="${searchMap.keyword }">
           
           <div class="form-floating mb-1">
               <input type="text" name="boardTitle" id="title" class="form-control"  value="${mateBoard.boardTitle }">
               <label for="floatingInput">제목 :</label>
           </div>
           
           <div class="form-floating mb-1">
               <textarea class="form-control" name="boardContent" id="boardContent" style="resize:none; min-height:300px;">${mateBoard.boardContent }</textarea>
               <label for="floatingInput">내용 :</label>
           </div>
           
           <!-- 인원 수 조정 섹션 -->
		<div class="card-body text-left">
		    <h5 class="card-title mb-3">최대 인원</h5>
		    <div class="input-group justify-content-center" style="max-width: 150px;">
		        <!-- 빼기 버튼 -->
		        <button id="minusBtn" class="btn btn-outline-danger" type="button" onclick="changeMateCount(-1); return false;">-</button>
		        
		        <!-- 인원 수 표시 -->
		        <input type="number" id="mateMaxCount" name="mateMaxCount"  class="form-control text-center" value="${mateBoard.mateMaxCount}" min="1" max="99" oninput="updateMateInput()" onkeydown="preventEnter(event)">
		        
		        <!-- 더하기 버튼 -->
		        <button id="plusBtn" class="btn btn-outline-success" type="button" onclick="changeMateCount(1); return false;">+</button>
		    </div>
		</div>
           
           <button type="button" class="btn btn-primary mt-2" onclick="openCourseWindow()">여행코스 선택</button>
           <div class="mt-3 mb-3">
               <input type="text" name="courseTitle" id="selectedCourse" value="${course.courseTitle}" class="form-control" readonly>
           </div>
           <div id="courseNomber">
           	<input type='hidden' name='courseNo' value="${mateBoard.courseNo}">
           </div> 
           <div class="btnDiv">
			<button type="submit" class="btn btn-primary">등록</button>
		</div>
       </form>
       
       <c:if test="${not empty errorMessage}">
            <script type="text/javascript">
                alert("${errorMessage}");
            </script>
        </c:if>
   </div>
</div>
	
<script type="text/javascript">
// 코스 선택창 열기
function openCourseWindow() {
    window.open("<c:url value='/mate/selectCourse' />", "CourseWindow", "width=520,height=650");
}

// 작은 창에서 코스 값을 받아서 처리하는 함수
function receiveCourse(value) {

	const courseNoMatch = value.match(/courseNo=([^,]+)/);
    const courseNo = courseNoMatch ? courseNoMatch[1] : "0";
	
	const courseTitleMatch = value.match(/courseTitle=([^,]+)/);
    const courseTitle = courseTitleMatch ? courseTitleMatch[1] : "제목 없음";

    // 필요한 값으로 필드 업데이트
    document.getElementById("selectedCourse").value = courseTitle;
    var html="";
    html += "<input type='hidden' name='courseNo' value="+courseNo+">";
    
    $("#courseNomber").html(html);
}

//폼 제출 전 유효성 검사
$("#boardForm").submit(function() {
    if ($("#title").val() == "") {
        alert("제목을 입력해 주세요.");
        return false;
    }
    else if ($("#boardContent").val().length >= 1000) {
        alert("제목은 100자 이내로 입력해 주세요.");
        return false;
    }
    else if ($("#boardContent").val() == "") {
        alert("내용을 입력해 주세요.");
        return false;
    }
    else if ($("#boardContent").val().length >= 1000) {
        alert("내용은 1000자 이내로 입력해 주세요.");
        return false;
    }
    else if ($("#selectedCourse").val() == "") {
        alert("여행코스를 선택해 주세요.");
        return false;
    }
    else if ($("#mateMaxCount").val() < 1 || $("#mateMaxCount").val() > 99) {
    	alert("최대 인원을 확인해주세요.(1 ~ 99)");
        return false;	
    }
});
   
//초기 인원 수
let count = ${mateBoard.mateMaxCount};

// + - 버튼으로 인원 수 조절
function changeMateCount(value) {
    count += value;

    // 인원 수가 1보다 작아지지 않도록 제한
    if (count < 1) {
        count = 1;
    } else if(count > 99) {
    	count = 99;
    } 

    // 인원 수 업데이트
    document.getElementById('mateMaxCount').value = count;
}

// 사용자가 직접 입력한 숫자를 처리
function updateMateInput() {
    const inputValue = parseInt(document.getElementById('mateMaxCount').value);
	
    // 숫자가 1 미만이면 1로 설정
    if (isNaN(inputValue) || inputValue < 1) {
        count = 1;
    } else if(inputValue > 99) {
    	count = 99;
    } 
    else {
        count = inputValue;
    }
    
    changeMateCount(0);
}

// 엔터 키 입력 방지 함수
function preventEnter(event) {
    if (event.key === "Enter") {
        event.preventDefault();  // 기본 동작 방지
        
     	// 숫자 값 검사 및 업데이트
        updateMateInput();
        
        // 인원 수 입력 필드에서 포커스를 제거하여 커서 깜박임 제거
        document.getElementById('mateMaxCount').blur();
    }
}

</script>
</body>
</html>
