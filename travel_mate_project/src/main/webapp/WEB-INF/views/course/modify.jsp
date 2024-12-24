<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>    

<%-- 부트스트랩 --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

 

<div class="container mt-5">
	<div class="main_div card p-4 shadow" >
		<%-- 글 제목 --%>
		<div class="title_div">
			<div class="form-floating mb-1">
				<input type="text" id="title"  class="form-control" placeholder="title" value="<c:out value="${resultMap.courseTitle}" escapeXml="false" />">
				<label for="floatingInput">코스 제목 :</label>
			</div>
		</div>
		<div class="concept_div mb-3">
		    <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
		        <input type="radio" class="btn-check conceptBtn" name="btnradio" id="btnradio1" value="나홀로 여행" autocomplete="off" checked>
		        <label class="btn btn-outline-secondary" for="btnradio1"># 나홀로 여행
		        <img alt="" src="<c:url value='/images/course/img1.png'/>"/></label>
		      	
		        <input type="radio" class="btn-check conceptBtn" name="btnradio" id="btnradio2" value="연인과 함께" autocomplete="off">
		        <label class="btn btn-outline-secondary" for="btnradio2"># 연인과 함께
		        <img alt="" src="<c:url value='/images/course/img2.png'/>"/></label>
		      	
		        <input type="radio" class="btn-check conceptBtn" name="btnradio" id="btnradio3" value="가족 여행" autocomplete="off">
		        <label class="btn btn-outline-secondary" for="btnradio3"># 가족 여행
		        <img alt="" src="<c:url value='/images/course/img3.png'/>"/></label>
		      	
		        <input type="radio" class="btn-check conceptBtn" name="btnradio" id="btnradio4" value="아이와 함께" autocomplete="off">
		        <label class="btn btn-outline-secondary" for="btnradio4"># 아이와 함께
		        <img alt="" src="<c:url value='/images/course/img4.png'/>"/></label>
		      	
		        <input type="radio" class="btn-check conceptBtn" name="btnradio" id="btnradio5" value="친구들과 여행" autocomplete="off">
		        <label class="btn btn-outline-secondary" for="btnradio5"># 친구들과 여행
		        <img alt="" src="<c:url value='/images/course/img5.png'/>"/></label>
		        
		        <input type="radio" class="btn-check conceptBtn" name="btnradio" id="btnradio6" value="남자끼리" autocomplete="off">
		        <label class="btn btn-outline-secondary" for="btnradio6"># 남자끼리
		        <img alt="" src="<c:url value='/images/course/img6.png'/>"/></label>
		      	
		        <input type="radio" class="btn-check conceptBtn" name="btnradio" id="btnradio7" value="여자끼리" autocomplete="off">
		        <label class="btn btn-outline-secondary" for="btnradio7"># 여자끼리
		        <img alt="" src="<c:url value='/images/course/img7.png'/>"/></label>
		      	
		        
		    </div>
		</div>

		
		<%-- 카카오맵 지도 --%>
		<div class="map_wrap">
		    <div id="map"></div>
		    <div id="menu_wrap" class="bg_white">
			<div class="option">
				<div>
					<form onsubmit="searchPlaces(); return false;">
			    		<b>키워드 : </b><input type="text" value="제주 공항" id="keyword" size="15"> 
						<button type="submit" class="keyBtn" >&nbsp;&nbsp;검색&nbsp;&nbsp;</button> 
		  			</form>
				</div>
			</div>
			<hr>
			<ul id="placesList"></ul>
			<div id="pagination"></div>
			</div>
		</div>
	
		<!-- 장소명, 위도, 경도를 표시할 div -->
		<div id="placeInfo">
		    <div id="placeName" class="form-control"></div>	    
			<div id="latitude" hidden="true"></div> <%-- hidden --%>
			<div id="longitude" hidden="true"></div> <%-- hidden --%>
		    <button type="button" id="placeAdd" class="custom-btn btn-1" onclick="placeAdd()">+</button>
		    <button type="button" id="placeDel" class="custom-btn btn-2" onclick="placeDel()">-</button>
		</div>
		
		<%-- 장소 미입력 --%>
		<div class="nameMsg" id="nameMsg"></div>
	    
		<%-- form 시작부 --%>    
		<form action="<c:url value="/course/modify"/>" method="post" enctype="multipart/form-data" id="mainForm">
			<sec:csrfInput/> <%-- Security 토큰 전달 --%>
	    
		    <%-- 장소 모음 --%>
			<div id="placeSetDiv">
				<table id="placeSet">
		    	
		    	<%-- 장소 추가 공간 --%>
		    	
				</table>
			</div>
	
			<%-- 게시글 내용 --%>
			<div id="contentSetDiv">
			
			<%-- 게시글 추가 공간 --%>
				
		    </div>
		
			<%-- 제목, 대표사진 저장 --%>
			<input type="text" id="courseNo" name="courseNo" readonly="readonly" hidden="true">
			<input type="text" id="courseTitle" name="courseTitle" readonly="readonly" hidden="true" value="<c:out value="${resultMap.courseTitle}" escapeXml="false" />">
			<input type="text" id="courseConcept" name="courseConcept" readonly="readonly" value="나홀로 여행" hidden="true">
			<input type="file" id="mainImage" name="mainImage" readonly="readonly" hidden="true">
			<input type="text" id="updateIndex" name="updateIndex" readonly="readonly" hidden="true">
			
			<%-- 버튼 박스 --%>
			<div class="btnDiv">
				<button type="button" class="imageFileBtn cancelBtn" onclick="confirmCancel()">취소</button>
				<button type="submit" class="imageFileBtn writeBtn">변경</button>
			</div>
		</form>
		<%-- form 종료부 --%>
		
	</div>
</div>

<%-- CSS --%>
<link rel=stylesheet href="<c:url value='/css/course_write.css'/>" type="text/css">

<%-- JS Start --%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f668f12cefa13f73e2909521572e5b72&libraries=services"></script>
<script>



// 마커를 담을 배열입니다
var markers = [];
var currentMarker = null; // 현재 표시 중인 마커

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.50683984835887, 126.49272304493574), // 지도의 중심좌표
        level: 4 // 지도의 확대 레벨 (100m)
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch(keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) { 

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {
    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for (var i = 0; i < places.length; i++) {
        // 검색 결과 항목 Element를 생성합니다
        var itemEl = getListItem(i, places[i]);
        
        (function(title, lat, lng) {

            // 검색 결과 목록을 클릭했을 때 장소 정보 표시 및 마커 표시
            itemEl.onclick = function() {
                document.getElementById('placeName').innerHTML = title;
                document.getElementById('latitude').innerHTML = lat;
                document.getElementById('longitude').innerHTML = lng;

                // 지도 중심을 클릭한 장소의 좌표로 이동
                map.setCenter(new kakao.maps.LatLng(lat, lng));

                // 기존 마커 제거 후 새로운 마커 추가
                if (currentMarker) {
                    currentMarker.setMap(null); // 이전 마커 제거
                }
                currentMarker = addMarker(new kakao.maps.LatLng(lat, lng)); // 새로운 마커 추가
            };
        })(places[i].place_name, places[i].y, places[i].x);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
}


// 페이지 번호를 표시하는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i;

    // 기존에 추가된 페이지 번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild(paginationEl.lastChild);
    }

    for (i = 1; i <= pagination.last; i++) { 
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i === pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position) {
    var marker = new kakao.maps.Marker({
        position: position // 마커의 위치
    });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    return marker;
}

//지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    if (currentMarker) {
        currentMarker.setMap(null);  // 현재 표시된 마커가 있으면 제거합니다
        currentMarker = null;
    }
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, currentMarker);
}

// 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

<%-- 지도 관련 코드 종료 --%>
var index = 0; // 새로운 항목 추가 시 인덱스를 늘리기 위해 사용
var updateIndex = 0; // PLACE 업데이트, 삽입 구분용

$("#courseNo").val("${resultMap.courseNo}");
/* 
$("#title").val("${resultMap.courseTitle}");
$("#courseTitle").val("${resultMap.courseTitle}");
 */
$("#courseConcept").val("${resultMap.courseConcept}");
$('input[name="btnradio"][value="${resultMap.courseConcept}"]').prop('checked', true)

var courseNumber = ${resultMap.courseNo}; // 게시글 번호(ajax-json 게시글 호출용)

function placeListDisplay() { // place 불러오기
	
	$.ajax({
		type : "get",
		url : "<c:url value="/course/placeList"/>/"+courseNumber,
		dataType: "json",
		success: function(result) {
			
			$(result.placeList).each(function() {
				
				var html1 = "";
				
				<%-- 작대기 --%>
				if (index > 0) {
					html1 += 
						"<tr id='bar" + index + "'>" +
						"<td class='lineTd'>｜</td>" +
						"</tr>";
				}
				
				<%-- 약식 코스 --%>
				html1 += 
					"<tr class='placeTr' id='placeTr" + index + "'>" +
						"<td><input type='text' class='eleOrder' name='placeList[" + index + "].placeOrder' value='" + this.placeOrder + "'><span class='eleOrder'>.&nbsp;</span></td>" +
						"<td><input type='text' class='eleName' name='placeList[" + index + "].placeName' value='" + this.placeName + "'></td>" +
						"<td><input type='text' name='placeList[" + index + "].placeX' value='" + this.placeX + "' hidden='true'></td>" +
						"<td><input type='text' name='placeList[" + index + "].placeY' value='" + this.placeY + "' hidden='true'></td>" +
					"</tr>";

				$("#placeSet").append(html1);
 

				var html2 = 
				    "<div class='contentSetDiv-1' id='contentDiv" + index + "'>" +
						"<div class='contentSetDiv-1-1'>" +
							"<div class='contentSetDiv-1-1-1'>" +
								"<span>"+this.placeOrder+".&nbsp;</span><span>" + this.placeName + "</span>" +
							"</div>" +
							"<div class='contentSetDiv-1-1-2'>" +
								"<img alt='' src='<c:url value='/images/upload/course/" + this.placeImage + "'/>' class='imgView'>" +
							"</div>" +
							"<div class='contentSetDiv-1-1-3'>" +
								/* "<button type='button' class='repButton imageFileBtn ChoiceBtn' disabled>대표사진 변경</button>" + */
								"<button type='button' class='repButton imageFileBtn ChoiceBtn' hidden='true'>대표사진 변경</button>" +
							"</div>" +
						"</div>" +
						"<div class='contentSetDiv-1-2'>" +
							"<div class='contentSetDiv-1-2-1'>" +
								"<p>*.jpg, *.png</p><label for='file"+index+"' class='imageFileBtn'>사진첨부</label>" +
								"<input type='file' id='file"+index+"' class='inputImage' name='placeList[" + index + "].imageFile'>" + 
							"</div>" +
							"<div class='contentSetDiv-1-2-2'>" +
								"<textarea rows='10' cols='60' class='plcetextArea' name='placeList[" + index + "].placeContent'>" + this.placeContent + "</textarea>" +
							"</div>" +
						"</div>" +
					"</div>";

				    
				$("#contentSetDiv").append(html2);
				

				index++;
			});
			
			updateIndex = index-1;
			$("#updateIndex").val(updateIndex);
		}
	});
}


placeListDisplay(); // place 불러오기




// 장소 추가
function placeAdd() {
	var eleOrder = index+1;
	var elePlace = $("#placeName").html();
	var eleX = $("#latitude").html();
	var eleY = $("#longitude").html();
	var html1 = "";
	
	$("#nameMsg").html("");
	
	if(elePlace == "") {
		$("#nameMsg").html("장소를 선택해 주세요.");
		return;
	}
	
	if(eleOrder > 10) {
		$("#nameMsg").html("장소는 최대 10곳까지 등록 가능합니다.");
		return;
	}
	
	
	<%-- 연결작대기 --%>
	if (index > 0) {
		html1 += 
			"<tr id='bar" + index + "'>" +
			"<td class='lineTd'>｜</td>" +
			"</tr>";
	}
	
	<%-- 약식 코스 --%>
	html1 += 
		"<tr class='placeTr' id='placeTr" + index + "'>" +
			"<td><input type='text' class='eleOrder' name='placeList[" + index + "].placeOrder' value='" + eleOrder + "'><span class='eleOrder'>.&nbsp;</span></td>" +
			"<td><input type='text' class='eleName' name='placeList[" + index + "].placeName' value='" + elePlace + "'></td>" +
			"<td><input type='text' name='placeList[" + index + "].placeX' value='" + eleX + "' hidden='true'></td>" +
			"<td><input type='text' name='placeList[" + index + "].placeY' value='" + eleY + "' hidden='true'></td>" +
		"</tr>";

	$("#placeSet").append(html1);


	var html2 = 
	    "<div class='contentSetDiv-1' id='contentDiv" + index + "'>" +
			"<div class='contentSetDiv-1-1'>" +
				"<div class='contentSetDiv-1-1-1'>" +
					"<span>"+eleOrder+".&nbsp;</span><span>" + elePlace + "</span>" +
				"</div>" +
				"<div class='contentSetDiv-1-1-2'>" +
					"<img alt='' src='<c:url value='/images/course/default.png'/>' class='imgView'>" +
				"</div>" +
				"<div class='contentSetDiv-1-1-3'>" +
					"<button type='button' class='repButton imageFileBtn ChoiceBtn'>대표사진 변경</button>" +
				"</div>" +
			"</div>" +
			"<div class='contentSetDiv-1-2'>" +
				"<div class='contentSetDiv-1-2-1'>" +
					"<p>*.jpg, *.png</p><label for='file"+index+"' class='imageFileBtn'>사진첨부</label>" +
					"<input type='file' id='file"+index+"' class='inputImage' name='placeList[" + index + "].imageFile'>" + 
				"</div>" +
				"<div class='contentSetDiv-1-2-2'>" +
					"<textarea rows='10' cols='60' class='plcetextArea' name='placeList[" + index + "].placeContent'></textarea>" +
				"</div>" +
			"</div>" +
		"</div>";

	    
	$("#contentSetDiv").append(html2);
	

	index++;
}

// 장소 삭제
function placeDel() {
	$("#nameMsg").html("");
	
	if (index > 0) {  // 삭제할 요소가 있는지 확인
		var delNo = index - 1;
		$("#placeTr" + delNo).remove();
		$("#contentDiv" + delNo).remove();
		
		if (index > 1) {			
			$("#bar" + delNo).remove();
		}
        
		// 인덱스 감소
		index--;
	} else {
		$("#nameMsg").html("삭제할 장소가 없습니다.");
	}
}

$("#mainForm").submit(function (event) {
    
    event.preventDefault();// 기본 폼 제출 동작 막기

    // 게시글 제목 검증
    if ($("#title").val().trim() === "") {
        alert("게시글 제목을 입력해 주세요.");
        $("#title").focus();
        return false;
    }
    
    if ($("#title").val().length > 50) {
        alert("제목을 50자 이내로 입력해 주세요.");
        $("#title").focus();
        return false;
    }

    // 장소 최소 개수 검증
    if (index < 2) {
        alert("2개 이상의 장소를 입력해 주세요.");
        return false;
    }

    // 장소 설명 길이 검증
    var isValid = true;

    $(".plcetextArea").each(function () {
        
        if ($(this).val().trim().length < 10) {
            alert("장소설명을 10글자 이상 작성해 주세요.");
            $(this).focus();
            isValid = false;
            return false; 
        }

        if ($(this).val().length > 300) {
            alert("장소설명을 300글자 이하로 작성해 주세요.");
            $(this).focus();
            isValid = false;
            return false;
        }
    });

    // 모든 검증이 통과되지 않으면 제출 중지
    if (!isValid) return false;

    // 모든 검증이 통과한 경우 폼 제출
    this.submit();
});




$("#title").on("input", function() {
	var titleValue = $(this).val();  // #title의 값 가져오기
    $("#courseTitle").val(titleValue);  // #courseTitle에 값 설정
});

// 게시판 대표 사진 지정
$(document).on('click', '.repButton', function() {
	
    var fileInput = $(this).closest('.contentSetDiv-1').find('.inputImage')[0]; // 버튼 바로 앞의 파일 input 요소 찾기
    if (fileInput && fileInput.files.length > 0) {
        var mainImg = fileInput.files[0];
        
        if (mainImg) {
            var dataTransfer = new DataTransfer();
            dataTransfer.items.add(mainImg);
            
            $('#mainImage')[0].files = dataTransfer.files; //✔ ✓
            
            <%-- 다른버튼 초기화 --%>
            $(".ChoiceBtn").html("대표사진 변경")
        	$(".ChoiceBtn").css("border", "1px solid #adadad");
            
            $(this).html("대표사진 <span id='checkSpan'>&nbsp;&nbsp;&nbsp;&nbsp;✓</span>")
            $(this).css("border", "2px solid #adadad");
            
        }
    } else {
    	alert("업로드 된 파일이 없습니다.");
    }
});


$(document).on('change', '.inputImage', function() {
    var file = this.files[0];
    
    if (file) {
    	// 파일 형식 검사 (jpg, jpeg, png만 허용)
        var validExtensions = ['image/jpeg', 'image/png'];
        if (!validExtensions.includes(file.type)) {
        	alert('*.jpg, *.png 타입의 파일만 업로드 가능합니다.');
            this.value = '';  // 선택된 파일 초기화
            return;
        }
        
     	// 파일 크기 검사 (2MB 이하만 허용)
        var maxSize = 2 * 1024 * 1024; // 2Mbyte
        if (file.size > maxSize) {
            alert('이미지 파일 크기는 2Mbyte 이하여야 합니다.');
            this.value = '';  // 선택된 파일 초기화
            return;
        }
    	
    	
        // 파일 이름을 얻고 싶을 때
        var fileName = file.name;
        
        // 이미지 미리보기를 위한 URL 생성
        var imageUrl = URL.createObjectURL(file);

        //이미지 미리보기
        var imgTag = $(this).closest('.contentSetDiv-1').find('.imgView');
        imgTag.attr('src', imageUrl);
        
        var imgTag = $(this).closest('.contentSetDiv-1').find('.imgView');
        
		var imageFileBtn = $(this).closest('.contentSetDiv-1').find('.imageFileBtn');
		/* imageFileBtn.prop('disabled', false); */
		imageFileBtn.prop('hidden', false);
    }
});

$(".conceptBtn").change(function() {
	
	var conceptSel = $(this).val();
	$("#courseConcept").val(conceptSel);
	
});

function confirmCancel() {
    if (confirm("작성을 취소하시겠습니까?")) {
        window.location.href = '<c:url value="/course/list"/>';
    }
}

</script>
