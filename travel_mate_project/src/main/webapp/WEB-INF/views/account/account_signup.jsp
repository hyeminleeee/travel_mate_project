<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
  .validation-message {
    color: red;
    font-size: 0.9rem;
    margin-top: 0.5rem;
  }

  .valid {
    color: green;
  }

  .invalid {
    color: red;
  }
</style>
</head>
<body>
<div class="row g-0 bg-white min-vh-100 align-items-center">
  <div class="col-lg-6 text-center text-lg-start overflow-hidden z-index-2">
    <div class="px-3 py-6">
      <div class="row">
        <div class="col-sm-8 col-md-6 col-lg-9 col-xl-12 mx-auto max-w-450">

          <h1 class="fw-bold mb-5">회원가입</h1>

          <form novalidate class="bs-validate" method="POST" action="<c:url value='/account/register'/>">
			<sec:csrfInput/> <%-- Security 토큰 전달 --%>

            <!-- 아이디 입력 및 중복 체크 -->
            <div class="form-floating mb-3" id="id-div">
              <input required placeholder="아이디" id="userId" name="userId" type="text" class="form-control">
              <label for="userId">아이디</label>
              <div id="id-validation-message" class="validation-message"></div>
            </div>

            <!-- 비밀번호 입력 및 유효성 검사 -->
            <div class="input-group-over">
              <div class="form-floating mb-3">
                <input required placeholder="비밀번호" id="userPw" name="userPw" type="password" class="form-control">
                <label for="userPw">비밀번호</label>
                <div id="password-validation-message" class="validation-message"></div>
              </div>
            </div>

            <!-- 이메일 입력 -->
            <div class="form-floating mb-3">
              <input placeholder="이메일주소" id="userEmail" name="userEmail" type="email" class="form-control">
              <label for="userEmail">이메일주소</label>
            </div>

            <!-- 이름 입력 -->
            <div class="form-floating mb-3">
              <input required placeholder="이름" id="userName" name="userName" type="text" class="form-control">
              <label for="userName">이름</label>
            </div>

            <!-- 생년월일 입력 및 유효성 검사 -->
            <div class="form-floating mb-3">
              <input required placeholder="생년월일 8자리" id="userAge" name="userAge" type="text" class="form-control">
              <label for="userAge">생년월일 8자리</label>
              <div id="birthdate-validation-message" class="validation-message"></div>
            </div>

            <!-- 성별과 국적 선택 -->
            <div class="row mb-3">
              <div class="col">
                <div class="form-check">
                  <input class="form-check-input" type="radio" name="userGender" id="male" value="남">
                  <label class="form-check-label" for="male">남자</label>
                </div>
              </div>
              <div class="col">
                <div class="form-check">
                  <input class="form-check-input" type="radio" name="userGender" id="female" value="여">
                  <label class="form-check-label" for="female">여자</label>
                </div>
              </div>
            </div>

            <!-- 휴대전화번호 입력 및 유효성 검사 -->
            <div class="form-floating mb-3">
              <input required placeholder="휴대전화번호" id="userPhone" name="userPhone" type="text" class="form-control">
              <label for="userPhone">휴대전화번호</label>
              <div id="phone-validation-message" class="validation-message"></div>
            </div>

            <!-- 닉네임 입력 및 중복 체크 -->
            <div class="form-floating mb-3">
              <input required placeholder="닉네임" id="userNickname" name="userNickname" type="text" class="form-control">
              <label for="userNickname">닉네임 (5글자 이하)</label>
              <div id="nickname-validation-message" class="validation-message"></div>
            </div>

            <!-- 내 소개 -->
			<div class="form-floating mb-3">
				<textarea placeholder="내 소개" id="userIntroduction" name="userIntroduction" class="form-control" style="height: 100px; resize: none; width: 100%;"></textarea>
				<label for="userIntro">내 소개</label>
			</div>

            <!-- Submit 버튼 -->
            <div class="d-grid mb-4">
              <button type="submit" class="btn btn-primary">
                회원가입
              </button>
            </div>

          </form>

        </div>
      </div>
    </div>
  </div>

  <!-- Background Image -->
  <div class="d-none d-lg-block min-vh-100 col-lg-6 bg-cover py-8 overlay-dark overlay-opacity-25" style="background-image:url('<c:url value="/images/bg_signin.jpg"/>')">
    <svg class="d-none d-lg-block position-absolute h-100 top-0 text-white ms-n5" style="width:6rem" fill="currentColor" viewBox="0 0 100 100" preserveAspectRatio="none">
      <polygon points="50,0 100,0 50,100 0,100"></polygon>
    </svg>
  </div>
</div>

<script>
$(document).ready(function() {
    // 아이디 중복 체크
    $('#userPw').focus(function() {
        var userId = $('#userId').val();

        if (!userId) {
            $('#id-validation-message').html('<span class="invalid">아이디를 입력해주세요.</span>');
            return;
        }

        // Ajax를 이용한 중복 체크
        $.ajax({
            url: "<c:url value='/account/checkId'/>", // 실제 서버의 API URL을 설정해주세요.
            method: 'GET',
            data: { userId: userId },
            success: function(response) {
                if (response == "exist") {
                    $('#id-validation-message').html('<span class="invalid">이미 사용중인 아이디입니다.</span>');
                } else if(response == "available") {
                    $('#id-validation-message').html('<span class="valid">사용 가능한 아이디입니다.</span>');
                }
            },
            error: function() {
                $('#id-validation-message').html('<span class="invalid">아이디 중복 체크에 실패했습니다. 다시 시도해주세요.</span>');
            }
        });
    });

    // 비밀번호 유효성 검사
    $('#userPw').on('input', function() {
        var password = $(this).val();
        var passwordReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

        if (!passwordReg.test(password)) {
            $('#password-validation-message').html('<span class="invalid">8글자 이상의 영문, 숫자, 특수문자만 사용 가능합니다.</span>');
        } else {
            $('#password-validation-message').html("");            
        }
    });

    // 생년월일 유효성 검사 (숫자 8자리)
    $('#userAge').on('input', function() {
        var birthdate = $(this).val();
        var birthdateReg = /^\d{8}$/;

        if (!birthdateReg.test(birthdate)) {
            $('#birthdate-validation-message').html('<span class="invalid">생년월일은 숫자 8자리로 입력해주세요. (예: 19900101)</span>');
        } else {
            $('#birthdate-validation-message').html("");
        }
    });

    // 닉네임 유효성 검사 (5글자 이하) 및 중복 체크
    $('#userNickname').on('input', function() {
        var nickname = $(this).val();

        if (nickname.length > 5) {
            $('#nickname-validation-message').html('<span class="invalid">닉네임은 5글자 이하로 작성해주세요.</span>');
            return;
        }

        // 닉네임 중복 체크 Ajax
        $.ajax({
            url: "<c:url value='/account/checkNick'/>", // 실제 서버의 API URL을 설정해주세요.
            method: 'GET',
            data: { userNickname: nickname },
            success: function(response) {
                if (response == "exist") {
                    $('#nickname-validation-message').html('<span class="invalid">이미 사용중인 닉네임입니다.</span>');
                } else if(response == "available") {
                    $('#nickname-validation-message').html('<span class="valid">사용 가능한 닉네임입니다.</span>');
                }
            },
            error: function() {
                $('#nickname-validation-message').html('<span class="invalid">닉네임 중복 체크에 실패했습니다. 다시 시도해주세요.</span>');
            }
        });
    });

    // 휴대전화 유효성 검사 (숫자만 입력)
    $('#userPhone').on('input', function() {
        var phone = $(this).val();
        var phoneReg = /^\d+$/;  // 숫자만 허용

        if (!phoneReg.test(phone)) {
            $('#phone-validation-message').html('<span class="invalid">숫자만 입력해주세요.</span>');
        } else {
            $('#phone-validation-message').html("");
        }
    });
});
</script>
</body>

</html>
