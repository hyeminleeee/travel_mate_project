<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="<c:url value="/css/board.css"/>" type="text/css" rel="stylesheet">
<!-- PAGE SEARCH -->
<div class="section bg-gradient-primary text-white">

	<div class="position-relative container pt-6 pb-4 z-index-1">

		<div class="">

			<h1 class="h3 mb-4">
				공지사항
			</h1>


			<!-- 

				[SOW] SEARCH SUGGEST PLUGIN
				++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++
				PLEASE READ DOCUMENTATION
				documentation/plugins-sow-search-suggest.html
				++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++

			-->
			<form 	action="#search-page" 
					method="GET" 
					data-autosuggest="on" 

					data-mode="json" 
					data-json-max-results='10'
					data-json-related-title='Explore Smarty'
					data-json-related-item-icon='fi fi-star-empty'
					data-json-suggest-title='Suggestions for you'
					data-json-suggest-noresult='No results for'
					data-json-suggest-item-icon='fi fi-search'
					data-json-suggest-min-score='5'
					data-json-highlight-term='true'
					data-contentType='application/json; charset=utf-8'
					data-dataType='json'

					data-container="#sow-search-container" 
					data-input-min-length="2" 
					data-input-delay="250" 
					data-related-keywords="" 
					data-related-url="_ajax/search_suggest_related.json" 
					data-suggest-url="_ajax/search_suggest_input.json" 
					data-related-action="related_get" 
					data-suggest-action="suggest_get" 
					class="js-ajax-search sow-search d-block">
				<div class="sow-search-input w-100">

					<!-- rounded: form-control-pill -->
					<div class="input-group-over d-flex align-items-center w-100 h-100 rounded">

						<input placeholder="How can we help you?" aria-label="How can we help you?" name="s" type="text" class="form-control-sow-search form-control form-control-custom border-0 text-white bg-diff" value="" autocomplete="off">

						<span class="sow-search-buttons">

							<!-- search button -->
							<button aria-label="Global Search" type="submit" class="btn shadow-none m-0 px-3 py-2 bg-transparent text-white">
								<i class="fi fi-search fs-5 m-0"></i>
							</button>

						</span>

					</div>

				</div>

				<!-- search suggestion container -->
				<div class="sow-search-container w-100 p-0 hide shadow-md" id="sow-search-container">
					<div class="sow-search-container-wrapper">

						<!-- main search container -->
						<div class="sow-search-loader p-3 text-center hide">
							<i class="fi fi-circle-spin fi-spin text-muted fs-1"></i>
						</div>

						<!-- 
							AJAX CONTENT CONTAINER 
							SHOULD ALWAYS BE AS IT IS : NO COMMENTS OR EVEN SPACES!
						--><div class="sow-search-content rounded w-100 scrollable-vertical"></div>

					</div>
				</div>
				<!-- /search suggestion container -->

				<!-- 

					overlay combinations:
						overlay-dark opacity-* [1-9]
						overlay-light opacity-* [1-9]

				-->
				<div class="sow-search-backdrop backdrop-dark hide"><!-- alternate: overlay-dark opacity-3 --></div>

			</form>
			<!-- /SEARCH -->


		</div>

	</div>

	<!-- svg shape -->
	<svg class="absolute-full z-index-0" width="100%" height="100%" viewBox="0 0 1920 90" preserveAspectRatio="none">
		<path fill="rgba(0,0,0,0.03)" d="M1920,0C1217,0,120.574,155.567,0,0v90h1920V0z"></path>
	</svg>

</div>
<!-- /PAGE SEARCH -->






<!-- start :: help center -->
<div class="container py-6">
	<div class="shadow-xs wrap_tbl">
		<table class="tbl_board">
			<thead>
			  <tr>
                   <th class="board_num">번호</th>
                   <th class="board_title">제목</th>
                   <th class="board_date">날짜</th>
                   <th class="board_writer">작성자</th>
                   <th class="board_count">조회</th>
               </tr>
            </thead>
            <tbody>        
	            <tr class="board_table_content">
	                <!-- 일련번호 출력 -->
	                <td>1</td>
	                <!-- 공지사항 제목 출력 -->
	                <td class="board_tit">
	                    <a href="#" class="link_tit">제목 테스트</a>
	                </td>
	                <!-- 게시글 작성일 출력 -->
	                <td class="board_date">2024-07-29</td>
	                <!-- 작성자 출력 -->
	                <td class="board_writer">관리자</td>
	                <!-- 게시글 조회수 출력 -->
	                <td class="board_count">37</td>
	            </tr>
	            
           </tbody>
		</table>
	</div>

</div>
<!-- end :: help center -->
