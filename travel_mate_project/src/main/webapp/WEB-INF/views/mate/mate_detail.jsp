<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<link rel=stylesheet href="<c:url value='/css/course_view.css'/>" type="text/css">
<link rel=stylesheet href="<c:url value='/css/mateDetail.css'/>" type="text/css">
<div class="post">
	<div class="post-header">
		<div class="post-title">${mateBoard.boardTitle}</div>
	    <div class="post-meta">
	    	<span class="data">
	        ${mateBoard.boardRegdate}
	        </span>
	        
	        <div class="post-actions">
	            <span class="views">${mateBoard.boardCount}</span>
	            <div id="replyCount">
	            	<span class="replyCounts">${totalReply}</span>
	            </div>
	            <!-- 좋아요 추가 -->
	            <div id="likes" class="likes">
	            	<c:choose>
	            		<c:when test="${mateboardLike!= null}">
	            			<button id="heartBtn" onclick="heartBtnClick(${mateBoard.boardNo}, this)">
	            				<img class="heartBtn" src="<c:url value='/images/course/heart.png'/>"/>
	            			</button>
	            		</c:when>
		            	<c:otherwise>
		            		<button id="emptyHeartBtn" class="emptyHeartBtn" onclick="emptyHeartBtnClick(${mateBoard.boardNo}, this)">
		            			<img class="emptyHeartBtn" src="<c:url value='/images/course/heart_empty.png'/>" />
		            		</button>
	    	        	</c:otherwise>
	            	</c:choose>
					<span id="likeCount">${mateboardLikeCount}</span> 
	            </div>
	        </div>
	    </div>
	</div>
	
	<h5>여행 코스</h5>
	<div class="element">
		<a href="<c:url value='view'/>?num=${course.courseNo}" style="display: block;">
		    ${course.courseTitle}
		</a>
	</div>
	
	<h5>여행 소개</h5>
	<div class="element mate">
		<div class="description" style="min-height:300px;">
		    <pre>${mateBoard.boardContent }</pre>
		</div>
	</div>
	
	<h5>여행장</h5>
	<div class='element'>
		<div class="post-author">${mateBoardUser.userNickname}</div>
		<div class="post-actions">
			<span>${mateBoardUser.userAge} ${mateBoardUser.userGender}</span>
		</div>
	</div>
	
	<!-- 
	<sec:authorize access="isAuthenticated()">
	<sec:authorize access="hasRole('ROLE_ADMIN')" var="adminRole"/>
	<sec:authentication property="principal" var="pinfo"/>
	 
		<c:if test="${adminRole || pinfo.userId eq mateBoard.boardWriter }">
		-->
			<div id="mateWaitList"></div>
		<!--
		</c:if>
		 
	</sec:authorize>
	 -->
	
	<div id="mateList" ></div>
	
	<c:if test="${state == 'success'}">
		<div id="chatRoom" ><button class="chatBtn" type="button" onclick="openRoom()">채팅방 입장</button></div>
	</c:if>
	
	<div class="post_change">
		<form method="get" id="linkForm">			
			<input type="hidden" name="boardNo" value="${mateBoard.boardNo }">
			<input type="hidden" name="boardWriter" value="${mateBoard.boardWriter }">
			<input type="hidden" name="pageNum" value="${searchMap.pageNum }">
			<input type="hidden" name="pageSize" value="${searchMap.pageSize }">
			<input type="hidden" name="column" value="${searchMap.column }">
			<input type="hidden" name="keyword" value="${searchMap.keyword }">
			
			<button type="button" id="listBtn">목록</button>
			<sec:authorize access="isAuthenticated()">
				<sec:authorize access="hasRole('ROLE_ADMIN')" var="adminRole"/>
				<sec:authentication property="principal" var="pinfo"/>
				<c:choose>
					<c:when test="${adminRole || pinfo.userId eq mateBoard.boardWriter }">
						<button type="button" id="modifyBtn">변경</button>
						<button type="button" id="removeBtn">삭제</button>
					</c:when>
					<c:otherwise>
						<c:if test="${ state == 'fail'}">
							<button type="button" id="mateBtn">동행하기</button>
						</c:if>
					</c:otherwise>
				</c:choose>
			</sec:authorize>
		</form>
	</div>
</div>

<input type="hidden" id="loginUser" value="${pinfo.userId }">

<!-- 댓글 목록이 출력될 자리 -->
<div id="replyList"></div>

<!-- 댓글창이 들어갈 자리 -->
<div class="reply_write">
    <!-- 사용자 ID 표시 -->
    <div class="user-id">${loginUser.userNickname}</div>
    
    <!-- 텍스트 영역 -->
    <textarea rows="3" id="reply_content" placeholder="댓글을 작성해 주세요."></textarea>
    
    <!-- 제출 버튼 -->
    <button class="addBtn" id="addBtn">등록</button>
</div>
	
<script type="text/javascript">
$("#listBtn").click(function() {
	$("#linkForm").attr("action","<c:url value='/mate/list'/>").submit();
});

$("#modifyBtn").click(function() {
	$("#linkForm").attr("action","<c:url value='/mate/modify'/>").submit();
});
	
$("#removeBtn").click(function() {
	$("#linkForm").attr("action","<c:url value='/mate/remove'/>").submit();
});

$("#mateBtn").click(function() {
	var alarmUserId = '${mateBoard.boardWriter}'; // 알림을 받는 사용자
	var targetUserId = $("#loginUser").val();
	var boardNo = ${mateBoard.boardNo}; // 관련된 모집글 번호
	
	const result = confirm("참가 하시겠습니까?");
	if(result) {
	  $.ajax({
	    type: "post",
	    url: "<c:url value='/mateList/register'/>",
	    contentType: "application/json",  // 반드시 JSON 형식으로 설정
	    dataType: "text",  // 응답 형식
	    data: JSON.stringify({
	      boardNo: boardNo,
	      userId: targetUserId,
	      // 추가적으로 필요한 Mate 객체의 필드들
	    }),
	    success: function(result) {
	      if(result == "success") {
	        alert("메이트 참여 신청이 완료되었습니다.");
	        mateWaitListDisplay();
	        mateListDisplay();
	      } else if(result=="fail") {
	        alert("이미 참가 신청 중 입니다.");
	      } else if(result=="full") {
	        alert("참가 인원이 만료되었습니다.");
	      } else if(result=="already") {
	        alert("이미 참가되어있습니다.");
	      } else {
	        alert("정상적으로 참여 신청이 완료되지 않았습니다.");
	      }
	    },
	    beforeSend: function(xhr) {
	      xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    },
	    error: function(xhr) {
	      alert("메이트에러 = " + xhr.status);
	     }
	 });
	
	 
	 $.ajax({
	     type: "post",
	     url: "<c:url value='/travel_alarm/register'/>",
	     contentType: "application/json",
	     data: JSON.stringify({
	         "alarmUserId": alarmUserId,
	         "targetUserId": targetUserId,
	         "targetBoardNo": boardNo,
	         "actionType": "SUBMIT_APPLY" // 알림 유형
	     }),
	     dataType: "text",
	     success: function(result) {
	
	   	  // 동작 구간
	   	  
	     },
	     beforeSend: function(xhr) {
	         xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	     },
	     error: function(xhr) {
	         alert("에러코드 = " + xhr.status);
	     }
	 }); 
		
  }
	
});

function mateWaitListDisplay() {
	$.ajax({
		type: "get",
		url: "<c:url value="/mateList/listWait"/>",
		data: { boardNo: ${mateBoard.boardNo}},
		dataType: "json",
		success: function(result) {
			
			var html="";

			if(result.length != 0) {

				html += "<h5>동행 신청 목록</h5>";
				html += "<div class='element'>";
				html += "<div style='display: flex; text-align:flex-start;flex-direction: column;'>";
				
				html += "<div style='margin: 0;display:flex;align-items: center;'>";
				html += "<p class='waitDiv' style='font-weight:bold;background:#f4f4f4;width: 75px; border: 1px solid #ebebeb;'>닉네임</p>";
				html += "<p class='waitDiv' style='font-weight:bold;background:#f4f4f4;width: 75px;border: 1px solid #ebebeb;'>나이대</p>";
				html += "<p class='waitDiv' style='font-weight:bold;background:#f4f4f4;width: 75px;border: 1px solid #ebebeb;'>성별</p>";
				html += "<p class='waitDiv' style='font-weight:bold;background:#f4f4f4;width:500px;max-width:500px;border: 1px solid #ebebeb;'>자기소개</p>";
				html += "</div>";
			
			
			}
			
			$(result).each(function(){
				
				html += "<div style='margin: 0;display:flex;align-items: center;'>";
				html += "<p class='waitDiv' style='width:75px;'>"+this.userName+"</p>";
				html += "<p class='waitDiv' style='width:75px;'>"+this.userAge+"</p>";
				html += "<p class='waitDiv' style='width:75px;'>"+this.userGender+"</p>";
				html += "<p class='waitDiv' style='width:500px;max-width:500px;text-align:left;'>"+this.userIntroduction+"</p>";
				html += "<button class='accept' onclick='accept("+this.mateNo+")'>수락</button>";
				html += "<button class='refusal' onclick='refusal("+this.mateNo+")'>거절</button>";	
				html += "<input type='hidden' id='mateChk"+this.mateNo+"' value='"+this.userId+"'>";
				html += "</div>";
				
				
			});
			html += "</div>";
			html += "</div>";
			$("#mateWaitList").html(html);
		},
		error: function(xhr){
   			alert("메이트 에러코드 = "+xhr.status);
   		}
		 
	})
}

mateWaitListDisplay();



function mateListDisplay() {
	
	
	$.ajax({
		type: "get",
		url: "<c:url value="/mateList/listAccept"/>",
		data: { boardNo: ${mateBoard.boardNo}},
		dataType: "json",
		success: function(result) {
			
			var html="";
			/* 
			if(result.length == 0) {
				return;	
			}
			 */
			html += "<h5>참여중인 동행</h5>";
			html += "<div class='element' style='overflow: auto;'>";
			html += "<span align='right' style='font-size:20px;'>인원 "+result.length+"/${mateBoard.mateMaxCount}</span><br>";
			html += "<div style='display: flex; text-align: center;'>";
			
			var count=0;
			$(result).each(function(){
				count++;
				
				html += "<div style='margin: 10px;'>";
				html += "<img style='width:70px; height:70px;' src='<c:url value='/images/default_profile.png'/>' alt="+ this.userId+ " style='width: 150px; height: 150px; border: 2px solid black;'>";
				html += "<p>"+this.userName+"</p>";
				html += "</div>";
				
			});
			html += "</div>";
			html += "</div>";
			$("#mateList").html(html);
		},
		error: function(xhr){
   			alert("메이트 에러코드 = "+xhr.status);
   		}
		
	})
}

mateListDisplay();



//메이트 수락하기
function accept(mateNo) {
	
	
  $.ajax({
      type: "get",
      url: "<c:url value='/mateList/accept'/>",
      dataType: "text",
      data: { 
      	mateNo: mateNo,
      	boardNo: ${mateBoard.boardNo},
      },
      success: function(result) {
    	  if(result == "success") {
    		  alert("메이트 참여를 수락 하였습니다.");
	    	  mateWaitListDisplay();
	    	  mateListDisplay();
    	  } else if(result == "full"){
    		  alert("참가 인원이 만료되었습니다.");
    	  }	else {
              alert("정상적으로 수락 되지 않았습니다.");
          }
      	
      }
  });

  var alarmUserId = '${mateBoard.boardWriter}'; // 알림을 받는 사용자 (로그인 사용자)
  var targetUserId = $("#mateChk"+mateNo).val(); // 알림을 발생시킨 사용자 (게시글 작성자) ## 테스트 포인트
  
  
  var boardNo = ${mateBoard.boardNo}; // 관련된 모집글 번호
  
  $.ajax({
      type: "post",
      url: "<c:url value='/travel_alarm/register'/>",
      contentType: "application/json",
      data: JSON.stringify({
          "alarmUserId": targetUserId,
          "targetUserId": alarmUserId,
          "targetBoardNo": boardNo,
          "actionType": "SUBMIT_ACCEPT" // 알림 유형
      }),
      dataType: "text",
      success: function(result) {

    	  // 동작 구간
    	  
      },
      beforeSend: function(xhr) {
          xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
      error: function(xhr) {
          alert("에러코드 = " + xhr.status);
      }
  }); 

}
 
//메이트 거절하기
function refusal(mateNo) {
	
  $.ajax({
      type: "get",
      url: "<c:url value='/mateList/refusal'/>",
      dataType: "text",
      data: { 
      	mateNo: mateNo
      },
      success: function(result) {
    	  if(result == "success") {
	    	  alert("메이트 참여를 거절 하였습니다.");
	    	  mateWaitListDisplay();
	    	  mateListDisplay();
    	  } else {
              alert("정상적으로 거절 되지 않았습니다.");
          }
      }
  });
  
  var alarmUserId = '${mateBoard.boardWriter}'; // 알림을 받는 사용자 (로그인 사용자)
  var targetUserId = $("#mateChk"+mateNo).val(); // 알림을 발생시킨 사용자 (게시글 작성자) ## 테스트 포인트
  
  
  var boardNo = ${mateBoard.boardNo}; // 관련된 모집글 번호
  
  $.ajax({
      type: "post",
      url: "<c:url value='/travel_alarm/register'/>",
      contentType: "application/json",
      data: JSON.stringify({
          "alarmUserId": targetUserId,
          "targetUserId": alarmUserId,
          "targetBoardNo": boardNo,
          "actionType": "SUBMIT_REFUSAL" // 알림 유형
      }),
      dataType: "text",
      success: function(result) {

    	  // 동작 구간
    	  
      },
      beforeSend: function(xhr) {
          xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
      error: function(xhr) {
          alert("에러코드 = " + xhr.status);
      }
  }); 
}


function replyListDisplay() {
   	$.ajax({
   		type: "get",
   		url: "<c:url value="/matereply/list"/>",
   		data: { boardNo: ${mateBoard.boardNo}},
   		dataType: "json",
   		success: function(response) {
   			var replyList=response.replyList;
   			var userNickname=response.userNickname;
   			
   			if(replyList.length == 0){
   				var html="<div class='no_reply' style='text-align: center; font-size: 14px; max-width: 1200px; margin-left: auto; margin-right: auto; border: 1px solid #ddd; border-radius: 5px; resize: none; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); height: auto;'>";
   				html+="첫 댓글을 작성해보세요!",
   				html+="</div>";
   				$("#replyList").html(html);
   				return;
   			}
   			
   			var html="";
   			$(replyList).each(function(){
   			    html += "<div reply-id='" + this.replyNo + "' style='max-width: 1200px; margin-left: auto; margin-right: auto; margin-bottom: 5px; border: 1px solid #ddd; border-radius: 5px; resize: none; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); height: auto;'>";
   			    html += "<div style='margin: 10px; text-align: left;'>";
   			    html += "<strong>" + this.replyUserName + "</strong><br>";
   			    html += "<pre>" + this.replyContent + "</pre>";
   			    html += "<p style='font-size: 12px;'>" + this.replyRegdate + "</p>";
   			    html += "<div style='font-size: 12px; text-align: right;'>";
   			    if(this.replyWriter === response.userId ) {
   			    html += "<button class='modify-btn' onclick='modifyReply(" + this.replyNo + ")' style='border: none; background: none;'>수정</button>";
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
		url: "<c:url value='/matereply/register'/>",
		contentType: "application/json",
		data: JSON.stringify({"replyContent":replyContent, "boardNo":${mateBoard.boardNo}}),
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
			if(xhr.status == 500) {
				alert("로그인 후 이용바랍니다.");
				window.location.href = "<c:url value='/account/login'/>";
			} else {
				alert("에러코드 = "+xhr.status);	
			}
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
function saveReply(replyNo, replyContent) {
    var replyDiv = $('#replyList').find('div[reply-id="' + replyNo + '"]');
    var newContent = replyDiv.find('textarea.reply-edit-content').val(); // 입력된 새 댓글 내용을 가져옴

    // AJAX 요청으로 댓글 수정
    $.ajax({
        type: "post",
        url: "<c:url value='/matereply/modify'/>", // 댓글 수정에 대한 URL
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
            url: "<c:url value='/matereply/remove'/>", // 댓글 삭제에 대한 URL로 변경하세요.
            data: JSON.stringify({ replyNo: replyNo }),
            contentType: "application/json",
            success: function(result) {
                if (result === "success") {
                    alert("댓글이 삭제되었습니다.");
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

//댓글 수 증가 함수
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
function emptyHeartBtnClick(boardNo, button) {		
    $.ajax({
        type: "get",
        url: "<c:url value='/mateboardlike/likeUp'/>",
        data: { boardNo: boardNo }, // boardNo를 서버로 전송

        success: function(response) {
        	if(response.status == "success") {
	            // 서버 응답이 성공하면 버튼 상태를 변경
	            $(button).removeClass("heartBtn").addClass("emptyHeartBtn");
	            
	            $(button).find('img').attr('src', '<c:url value="/images/course/heart.png"/>');
	            
	            // 클릭 이벤트를 heartBtnClick 함수로 변경
	            button.onclick = function() { heartBtnClick(boardNo, button); };
        	}
        	$("#likeCount").text(response.likeCount);
        },
        error: function(xhr, status, error) {
            console.error("좋아요 요청 실패:", error);
        }
    });
}

function heartBtnClick(boardNo, button) {	
    $.ajax({
        type: "get",
        url: "<c:url value='/mateboardlike/likeDown'/>",
        data: { boardNo: boardNo }, // boardNo를 서버로 전송
        
        success: function(response) {
        	if(response.status == "success") {
	            // 서버 응답이 성공하면 버튼 상태를 변경
	            $(button).removeClass("emptyHeartBtn").addClass("heartBtn");
	            $(button).find('img').attr('src', '<c:url value="/images/course/heart_empty.png"/>');
	            
	            // 클릭 이벤트를 emptyHeartBtnClick 함수로 변경
	            button.onclick = function() { emptyHeartBtnClick(boardNo, button); };
        	}
        	$("#likeCount").text(response.likeCount);
        },
        error: function(xhr, status, error) {
            // 에러 발생 시 처리할 내용
            console.error("좋아요 취소 요청 실패:", error);
        }
    });
}

/* 채팅방 이동 */
function openRoom() {
	var url = "${pageContext.request.contextPath}"+"/chat/room/${mateBoard.boardNo}"; // 채팅방 URL
       var windowName = 'ChatRoom'; // 새 창의 이름
       popupWindow = window.open(url, windowName, "resizeable");
       
       popupWindow.resizeTo(400, 800);
	   	popupWindow.onresize = (_=>{
	   	    popupWindow.resizeTo(400, 800);
	   	})
}
</script>