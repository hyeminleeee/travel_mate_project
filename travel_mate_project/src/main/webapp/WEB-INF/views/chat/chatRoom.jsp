<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> --%>    



<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel=stylesheet href="<c:url value='/css/chat.css'/>" type="text/css">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메이트 채팅방</title>

</head>
<body>
<div class="main-container">
	<div class="name-container">Mate - ${roomNo}    채팅방</div>
	<div class="chat-container">
	    <div class="chatSpace">
	    	
	    </div>
    </div>
    <div class="write-container">
    		<textarea id="writeInput" class="writeInput" name="content" placeholder="메시지 입력" spellcheck="false"></textarea>
    		<button type="button" class="sendBtn" onclick="chatWrite()" disabled="disabled">전송</button>
    </div>

</div>
    
<script type="text/javascript">
var beforeWriter = '';
var writerChk = false;
var beforeDate = '';
var dateChk = false;
var nickName = "${nickName}"; 

/* 스크롤 최하단 */
function scrollToBottom() {
	var chatContainer = $(".chatSpace");
    chatContainer.scrollTop(chatContainer.prop("scrollHeight"));
}

$(document).ajaxSend(function(event, xhr) {
	xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
});

/* 채팅방 내용 */
function callChats() {
    var chatContainer = $(".chatSpace");
    var isAtBottom = chatContainer.scrollTop() + chatContainer.innerHeight() >= chatContainer.prop("scrollHeight");

    $.ajax({
        type: "post",
        url: "<c:url value='/chat/callChats'/>",
        dataType: "json",
        data: { roomNo: "${roomNo}" },
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
            var html = '';

            // 기존 메시지를 비우고 새로운 메시지 추가
            $(".chatSpace").html('');

            // 받은 메시지를 HTML로 변환하여 추가
            $(result).each(function() {
            	// 시간 포맷
            	var date = new Date(this.regdate);

			    // 월, 일, 시간, 분을 두 자리 숫자로 변환
			    var month = ('0' + (date.getMonth() + 1)).slice(-2);
			    var day = ('0' + date.getDate()).slice(-2);
			    var hours = ('0' + date.getHours()).slice(-2);
			    var minutes = ('0' + date.getMinutes()).slice(-2);
			
			    // 원하는 형식으로 날짜 포맷
			    var formatdDate = month + '월' + day + '일 - ' + hours + ':' + minutes;
			    var formatdTime = hours + ':' + minutes;
			    var formatday = month + '.' + day;
            	

			    
            	if(this.writer == beforeWriter) {
            		writerChk = true;
            	} else {
            		writerChk = false;
            		beforeWriter = this.writer;
            	}
            	
            	if(formatday == beforeDate) {
            		dateChk = true;
            	} else {
            		dateChk = false;
            		beforeDate = formatday;
            	}
            	
			    if(!writerChk && this.writer != nickName) {
			   		html += "<div class='writer'>" + this.writer + "</div>";
			    }
			   	
			    
                if(this.writer != nickName) {
               		html +=
                    "<div class='message received'>" +
                    "<div class='bubble'>" + this.content + "</div>";
                } else {
               		html +=
                	"<div class='message sent'>";
                }         
                
				if(!dateChk) {
                	html +=	
                    "<div class='time'>" + formatdDate + "</div>";           
				} else {
					html +=
					"<div class='time'>" + formatdTime + "</div>";
                    
				}
				
				if(this.writer == nickName) {
					html +=
					"<div class='bubble'>" + this.content + "</div>" +
                	"</div>";
				} else {
					html += "</div>";					
				}
            });

            $(".chatSpace").append(html);

            // 스크롤이 최하단에 있었을 경우 최하단으로 유지
            if (isAtBottom) {
                scrollToBottom();
            }
        },
        /* 
        error: function(error) {
            console.log("Error:", error);
        }
         */
    });
}

//callChats();
setInterval(callChats, 1000); // 1초마다 채팅 내용 확인

function chatWrite() {
    var writeInput = $(".writeInput").val();
    
    if (writeInput == null || writeInput.trim() === "") {
        return;
    }

    // 줄바꿈을 <br>로 변환
    var formattedInput = writeInput.replace(/\n/g, "<br>");

    $.ajax({
        type: "post",
        url: "<c:url value='/chat/write'/>",
        dataType: "text",
        data: { 
            roomNo: "${roomNo}",
            writer: "${nickName}",
            content: formattedInput // 변환된 값 전송
        },
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function() {
            $(".writeInput").val(''); // 입력값 초기화
            callChats(); // 채팅 기록 갱신
            $(".sendBtn").prop('disabled', true); // 전송 버튼 비활성화
        },
    });
}


document.getElementById("writeInput").addEventListener("keydown", function(event) {
    // Enter 키를 눌렀을 때
    if (event.key === "Enter") {
        if (event.shiftKey) {
            // Shift + Enter일 때
            setTimeout(function() {
                var writeTextArea = $("#writeInput");
                // 텍스트가 추가된 후에 스크롤을 최하단으로 이동
                writeTextArea.scrollTop(writeTextArea[0].scrollHeight);
            }, 0);
        } else {
            // 그냥 Enter일 때는 chatWrite() 호출
            chatWrite();
        }
    }
});



$("#writeInput").on('input', function() {
	var writeInput = $(".writeInput").val();
	
	if(writeInput==null || writeInput.trim() === "") {
		 $(".sendBtn").prop('disabled', true); // 버튼 비활성화
    } else {
        $(".sendBtn").prop('disabled', false); // 버튼 활성화
    }
});
    		
</script>

</body>
</html>