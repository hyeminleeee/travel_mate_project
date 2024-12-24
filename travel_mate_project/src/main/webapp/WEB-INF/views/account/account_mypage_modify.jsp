<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>     

<sec:authorize access="isAuthenticated()">
<!-- PAGE TITLE -->
<div class="container py-5">
	<h1 class="h2 fw-bold">프로필</h1>
</div>
<!-- /PAGE TITLE -->

<!-- -->
<div class="container pb-6">

	<div class="row g-4">

		<!-- sidebar -->
		<jsp:include page="/WEB-INF/views/account/mypage_sidebar.jsp"/>

		<!-- content -->
		<div class="col-12 col-lg-9">

        <!-- Feedback -->
        <div class="card mb-4">
          <div class="card-body p-4">

            <form method="post" action="<c:url value="/account/modify"/>" id="formProfile">
			  <sec:csrfInput/>
			  <input type="hidden" name="userId" value="${loginUser.userId }">
              <dl class="list_profile clear_fix">
              	<dt>이름</dt>
              	<dd class="form-floating mb-3">
              		<input type="text" name="userMembername" id="userMembername" class="inp_profile inp_name form-control"  value="${loginUser.userName }" readonly="readonly">
              	</dd>
              	<dt>비밀번호</dt>
              	<dd class="form-floating mb-3">
              		<input id="userPw" type="password" name="userPw" class="inp_profile form-control">
					<span class="txt_info">** 비밀번호를 변경하지 않을 경우 입력하지 마세요.</span>
					<div id="password-validation-message" class="validation-message" style="color:#f00;font-size:14px;"></div>
				</dd>
              	<dt>닉네임(5글자 이하)</dt>
              	<dd class="form-floating mb-3">
              		<input type="text" name="userNickname" id="userNickname" class="inp_profile form-control" value="${loginUser.userNickname }">
              		<span id="nickNameDuplMsg" class="msg txt_warn">이미 사용중인 닉네임입니다.</span>
              		<span id="nickNameMsg" class="msg txt_warn">닉네임을 입력해주세요.</span>
              	</dd>
              	<dt>이메일</dt>
              	<dd class="form-floating mb-3">
              		<input type="text" name="userEmail" id="userEmail" class="inp_profile form-control" value="${loginUser.userEmail }">
              		<span id="emailMsg" class="msg txt_warn">이메일을 입력해주세요.</span>
              	</dd>
              	<dt>전화번호</dt>
              	<dd class="form-floating mb-3">
              		<input type="text" name="userPhone" id="userPhone" class="inp_profile form-control" value="${loginUser.userPhone }">
              		<span id="phoneMsg" class="msg txt_warn">전화번호를 입력해주세요.</span>
              	</dd>
              	<dt>소개글</dt>
              	<dd class="form-floating mb-3">
              		<textarea rows="" cols="" name="userIntroduction" id="userIntroduction"  class="tf_profile form-control">${loginUser.userIntroduction }</textarea>
              	</dd>
              	<dt>연령대</dt>
              	<dd>
              		<%-- <input type="text" name="userAge" id="userAge" value="${loginUser.userAge }"> --%>
              		 <select name="userAge" id="userAge" class="place-item">
				        <option value="10대" <c:if test="${loginUser.userAge == '10대'}">selected</c:if>>10대</option>
				        <option value="20대" <c:if test="${loginUser.userAge == '20대'}">selected</c:if>>20대</option>
				        <option value="30대" <c:if test="${loginUser.userAge == '30대'}">selected</c:if>>30대</option>
				        <option value="40대" <c:if test="${loginUser.userAge == '40대'}">selected</c:if>>40대</option>
				        <option value="50대" <c:if test="${loginUser.userAge == '50대'}">selected</c:if>>50대</option>
				        <option value="60대" <c:if test="${loginUser.userAge == '60대'}">selected</c:if>>60대</option>
				        <option value="70대 이상" <c:if test="${loginUser.userAge == '70대 이상'}">selected</c:if>>70대 이상</option>
				    </select>
              	</dd>
              </dl>
              

              <button type="submit" class="btn_modify btn btn-sm btn-primary d-flex align-items-center">
                <span>저장</span>
              </button>

            </form>

          </div>
        </div>


		</div>

	</div>

</div>
<!-- / -->
</sec:authorize>

<script type="text/javascript">
$(".txt_warn").css("display", "none");

//비밀번호 유효성 검사
$('#userPw').on('input', function() {
    var password = $(this).val();
    var passwordReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

    if (!passwordReg.test(password)) {
        $('#password-validation-message').html('<span class="invalid">8글자 이상의 영문, 숫자, 특수문자만 사용 가능합니다.</span>');
    } else {
        $('#password-validation-message').html("");            
    }
});

var currentNickname = "${loginUser.userNickname}"; // 로그인한 사용자의 닉네임

$("#userNickname").on("blur", function() {
    var userNickname = $(this).val();
    
    $("#userNickname").on("input", function() {
        if ($(this).val() != "") {
            $("#nickNameMsg").css("display", "none"); // 닉네임이 입력되면 경고 메시지 숨김
        }
    });
    
	 // 입력된 닉네임이 현재 로그인한 사용자의 닉네임과 동일하면 중복 검사를 하지 않음
    if (userNickname === currentNickname) {
        $("#nickNameDuplMsg").css("display", "none"); // 경고 메시지 숨기기
        return; // Ajax 호출 중단
    }
	
    // 닉네임 입력 필드가 비어있지 않으면 Ajax 호출
    if (userNickname != "") {
        $.ajax({
            type: "GET",
        	url: "<c:url value='/account/checkNickname'/>", // 서버의 닉네임 중복 검사 URL
			dataType: "json",
            data: {userNickname: userNickname},
            success: function(response) {
                if (response) {
                    // 중복된 닉네임이면 경고 메시지 표시
                    $("#nickNameDuplMsg").css("display", "inline-block");
                } else {
                    // 중복이 아니면 경고 메시지 숨기기
                    $("#nickNameDuplMsg").css("display", "none");
                }
            },
            error: function() {
                alert("닉네임 중복 검사를 진행할 수 없습니다.");
            }
        });
    } else {
        $("#nickNameMsg").css("display", "inline-block");
        $("#nickNameDuplMsg").css("display", "none");
    }
});

$("#formProfile").submit(function() {
	if($("#userNickname").val() == "") {
		$("#nickNameMsg").css("display", "inline-block");
		return false;
	}
	
	if($("#userEmail").val() == "") {
		$("#emailMsg").css("display", "inline-block");
		return false;
	}
	
	if($("#userPhone").val() == "") {
		$("#phoneMsg").css("display", "inline-block");
		return false;
	}
	
	// 중복된 닉네임이 있을 경우, 제출을 중지
    if ($("#nickNameDuplMsg").is(":visible")) {
        return false;
    }
	
});


</script>