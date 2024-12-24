<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- hero -->
 <div class="section py-5 position-relative">
   <div class="container py-5">

     <div class="row g-4 justify-content-md-between align-items-md-center mb-5">

       <div class="col-lg-6 col-xl-6" data-aos="fade-up" data-aos-delay="100">
         
         <h2 class="mb-5 display-2 fw-bold">
           <span class="d-block">제주도 여행</span>
           <span class="d-block text-info fs-1">지금 바로 시작하세요!</span>
         </h2>
         <p class="fs-4 fw-light">아름다운 제주도에서의 특별한 순간을 만끽하세요!<br>제주도의 자연과 문화가 어우러진 여행을 통해 <br>잊지 못할 추억을 만들어 보세요!</p>

         <a href="<c:url value='/course/list'/>" rel="noopener nofollow" class="btn btn-info bg-gradient row-pill fw-medium d-inline-flex align-items-center px-4 mb-3">
           <span class="me-1">여행코스 추천 보기</span>
           <svg width="18" height="18" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">  
             <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"></path>
           </svg>
         </a>
         <a href="<c:url value='/mate/list'/>" rel="noopener nofollow" class="btn btn-info bg-gradient row-pill fw-medium d-inline-flex align-items-center px-4 mb-3">
           <span class="me-1">여행친구 모집글 보기</span>
           <svg width="18" height="18" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">  
             <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"></path>
           </svg>
         </a>
         
       </div>

       <div class="col-12 my-5 d-lg-none"><!-- mobile spacer --></div>

       <div class="col-lg-6 col-xl-6" data-aos="fade-up" data-aos-delay="100">

         <!-- hero images -->
         <div class="position-relative text-center" data-aos="fade-in" data-aos-delay="450">
           
           <!-- svg lines -->
           <svg class="rtl-scalex-n1 position-absolute start-0 top-0 z-index-1 text-info mx-4" fill="currentColor" data-aos="fade-up" data-aos-delay="200">         
             <path d="M35.2,1.6c37.3,18.9,72.2,41.8,107.4,64.1c-0.2,0.4-0.4,0.8-0.6,1.2c-1.9-0.8-3.9-1.5-5.6-2.5c-30.3-17-60.6-34.1-91-51.1c-4.1-2.3-8.1-4.6-12.2-6.9c-2.3-1.2-2.8-2.7-1-4.7C33.2,1.6,34.2,1.6,35.2,1.6z"></path>
             <path d="M137.4,81.7C93.8,56.6,50.2,31.6,6.6,6.5C6.1,6.2,6.1,5.1,5.2,2.5c4.4,1.6,7.6,2.4,10.5,3.9c10,5.3,20,10.6,29.7,16.5c29.9,18.5,59.6,37.2,89.4,55.9c1.1,0.7,2.1,1.5,3.1,2.2C137.7,81.2,137.6,81.5,137.4,81.7z"></path>
             <path d="M122.8,88.8C87.6,68.9,52.4,49,17.2,29c-0.6-0.4-0.8-1.6-1.9-4c3.7,1.1,6.3,1.3,8.3,2.5c20.1,11.4,40.3,22.7,60.1,34.5 c12.1,7.2,23.8,15.3,35.6,23.1c1.4,0.9,2.6,1.9,3.9,2.9C123.1,88.3,122.9,88.6,122.8,88.8z"></path>
             <path d="M111.3,103.9c-1.8-1-3.7-1.9-5.5-2.9c-27-15.4-54.1-30.8-81-46.3c-2.1-1.2-5.3-5.2-5.1-5.4c2.8-3.3,5.4-0.2,7.6,1.2c27.6,17,55.2,34.1,82.7,51.3c0.6,0.4,1.2,0.9,1.7,1.4C111.6,103.3,111.5,103.6,111.3,103.9z"></path>
           </svg>

           <!-- images -->
           <span class="d-inline-block ratio ratio-1x1 rounded-circle bg-cover mx-1 z-index-0" style="max-width:500px;background-image:url('<c:url value="/images/bg_banner.jpg"/>')"></span>
           <div class="position-absolute bottom-0 w-100 z-index-1">
             <span class="d-inline-block ratio ratio-1x1 rounded-circle bg-cover mx-1 mb-n5" data-jarallax-element="-30" style="max-width:200px; background-image:url(demo.files/images/unsplash/team/thumb_330/michael-dam-mEZ3PoFGs_k-unsplash.jpg);"></span>
             <span class="d-inline-block ratio ratio-1x1 rounded-circle bg-cover mx-1 mt-n5" data-jarallax-element="-60" style="max-width:130px; background-image:url(demo.files/images/unsplash/team/thumb_330/foto-sushi-6anudmpILw4-unsplash.jpg);"></span>
           </div>

         </div>

       </div>

     </div>

   </div>
 </div>



 <!-- block : demos -->
 <div id="demos" class="section">
   <div class="container">

     <div class="d-inline-block mx-auto mb-7">
       <small class="fw-medium">제주도 여행을 위한 다양한 콘텐츠</small>
       <h2 class="display-5 mb-0 fw-bold"><span class="text-info">특별한</span> 제주도 여행</h2>
       <p class="lead">제주도 여행을 더욱 특별하게 만들어 줄 다양한 여행코스와 함께할 여행 친구를 찾아보세요!</b>!</p>
     </div>

     <!-- classic -->
     <div class="row g-4 align-items-center mb-8 pb-5">

       <div class="order-2 col-md-6 col-xl-5 ms-xl-auto mb-md-0" data-aos="fade-up">

         <span target="_blank" class="d-block bg-white shadow-md rounded p-2" aria-label="template">
           <div class="position-relative rounded overflow-hidden overlay-dark-hover overlay-opacity-3 show-hover-container bg-cover lazy" style="background-image:url('<c:url value="/images/bg_course.jpg"/>')">
             <svg viewBox="0 0 460 305"><!-- image width; used by lazyload --></svg>
           </div>
         </span>

       </div>

       <div class="order-1 col-md-6 mx-md-auto" data-aos="fade-up" data-aos-delay="100">

         <span class="fw-medium">다양한 여행 코스</span>
         <h2 class="fw-bold mb-4">여행 코스 추천</h2>
         <p class="lead mb-4">다양한 테마의 여행 코스를 통해 제주도의 매력을 새롭게 발견해 보세요.</p>

         <div class="d-flex">
           <a href="<c:url value='/course/write'/>" class="btn btn-sm btn-info me-2 rounded-lg d-flex align-items-center" rel="noopener">
             <span>여행코스 추천하기</span>
             <svg width="18" height="18" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">  
               <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"></path>
             </svg>
           </a>
           <a href="#" class="btn btn-sm btn-light rounded-lg d-none" target="_blank" rel="noopener">여행 코스 보러가기</a>
         </div>

       </div>

     </div>
     
     
     <!--  -->
     
     <div class="row g-4 align-items-center mb-8 pb-5">

       <div class="order-1 col-md-6 col-xl-5 ms-xl-auto mb-md-0" data-aos="fade-up">

         <span" class="d-block bg-white shadow-md rounded p-2" aria-label="template">
           <div class="position-relative rounded overflow-hidden overlay-dark-hover overlay-opacity-3 show-hover-container bg-cover lazy" style="background-image:url('<c:url value="/images/bg_mate.jpg"/>')">
             <svg viewBox="0 0 460 305"><!-- image width; used by lazyload --></svg>
           </div>
         </span>

       </div>

       <div class="order-2 col-md-6 mx-md-auto" data-aos="fade-up" data-aos-delay="100">

         <span class="fw-medium">함께 여행할 친구 찾기</span>
         <h2 class="fw-bold mb-4">여행친구 모집</h2>
         <p class="lead mb-4">함께 여행을 떠날 친구를 찾아, 더 즐거운 제주도 여행을 계획해보세요.</p>

         <div class="d-flex">
           <a href="<c:url value='/mate/register'/>" class="btn btn-sm btn-info me-2 rounded-lg d-flex align-items-center" rel="noopener">
             <span>여행친구 모집하기</span>
             <svg width="18" height="18" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">  
               <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"></path>
             </svg>
           </a>
           <a href="#" class="btn btn-sm btn-light rounded-lg d-none" target="_blank" rel="noopener">여행 메이트 모집 보러가기</a>
         </div>

       </div>

     </div>
     
  
     
     
   


   </div>
 </div>
 <!-- /block : demos -->



</div><!-- /#wrapper -->



<!-- offcanvas : demos -->
<div class="offcanvas offcanvas-start" style="width:500px" tabindex="-1" id="offcanvasDemos" aria-labelledby="offcanvasDemosLabel">
 
 <!-- offcanvas : header -->
 <div class="offcanvas-header border-bottom">
   <div class="offcanvas-title lh-1" id="offcanvasDemosLabel">
     <span class="d-block fs-4 mb-1 text-danger-gradient fw-bold">Smarty 5</span>
     <span class="d-block small fw-medium">Frontend + Admin</span>
   </div>
   <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
 </div>

 <!-- offcanvas : body -->
 <div class="offcanvas-body p-4 p-xl-5">

   <div class="d-flex align-items-center justify-content-between mb-2">
     <h3 class="h5 text-dark fw-bold">Licenses</h3>
     <a class="small fw-medium" href="https://support.wrapbootstrap.com/help/usage-licenses" target="_blank" rel="noopener nofollow">License FAQ</a>
   </div>

   <!-- licenses -->
   <div class="border border-dashed rounded p-3 mb-3">
     <h6 class="d-flex justify-content-between mb-0">
       <span>Single license</span>
       <span class="fs-5"><span class="smaller text-muted">$</span>39</span>
     </h6>
     <p class="mb-0 text-muted small">For single end product used by you or one client</p>

     <div class="border border-dashed border-bottom-0 my-3"><!-- divider --></div>

     <h6 class="d-flex justify-content-between mb-0">
       <span>Multiple license</span>
       <span class="fs-5"><span class="smaller text-muted">$</span>150</span>
     </h6>
     <p class="mb-0 text-muted small">Multiple instalations used by you or one client</p>

     <div class="border border-dashed border-bottom-0 my-3"><!-- divider --></div>

     <h6 class="d-flex justify-content-between mb-0">
       <span>Extended license</span>
       <span class="fs-5"><span class="smaller text-muted">$</span>1800</span>
     </h6>
     <p class="mb-0 text-muted small">For single SaaS app, paying users</p>
   </div>

   <div class="d-grid mb-5">
     <a href="https://wrapbootstrap.com/theme/smarty-website-admin-rtl-WB02DSN1B" target="_blank" rel="noopener nofollow" class="btn btn-primary bg-gradient w-100">
       Buy Now
     </a>
   </div>

   <!-- smarty performance -->
    <img width="403" height="167" class="img-fluid" src="demo.files/images/smarty_lighthouse_403.png" alt="smarty performance">

  </div>

</div>
<!-- /offcanvas : demos -->
