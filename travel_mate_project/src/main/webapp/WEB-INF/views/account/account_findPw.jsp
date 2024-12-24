<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row g-0 bg-white min-vh-100 align-items-center">
  <div class="col-lg-6 text-center text-lg-start overflow-hidden z-index-2">
    <div class="px-3 py-6">
      <div class="row">
        <div class="col-sm-8 col-md-6 col-lg-9 col-xl-12 mx-auto max-w-450">

          <h1 class="fw-bold mb-5">비밀번호 찾기</h1>

          <form novalidate class="bs-validate" method="POST" action="<c:url value='/account/findPwCheck'/>">

            <!-- id -->
            <div class="form-floating mb-3">
              <input class="form-control"  name="userId" id="userId" placeholder="Your Id">
              <label for="userName">아이디</label>
            </div>
            
            <!-- name -->
            <div class="form-floating mb-3">
              <input class="form-control"  name="userName" id="userName" placeholder="Your Name">
              <label for="userName">이름</label>
            </div>

            <!-- password -->
            <div class="form-floating mb-3">
              <input required type="text" class="form-control"  name="userEmail" id="userEmail" placeholder="Your Email">
              <label for="userEmail">이메일</label>
            </div>

            <!-- 비밀번호 찾기 버튼 -->
            <div class="d-grid mb-3">
              <button type="submit" class="btn btn-primary">
                <span>비밀번호 찾기</span>
                <svg class="rtl-flip" height="18px" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg" fill="currentColor">
                  <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"></path>
                </svg>
              </button>
            </div>
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
          </form>

        </div>
      </div>

    </div>
  </div>
  <div class="d-none d-lg-block min-vh-100 col-lg-6 bg-cover py-8 overlay-dark overlay-opacity-25" style="background-image:url('<c:url value="/images/bg_login.png"/>')">
    <svg class="d-none d-lg-block position-absolute h-100 top-0 text-white ms-n5" style="width:6rem" fill="currentColor" viewBox="0 0 100 100" preserveAspectRatio="none">
      <polygon points="50,0 100,0 50,100 0,100"></polygon>
    </svg>
  </div>
</div>
