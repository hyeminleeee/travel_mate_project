<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%-- 페이지의 뼈대를 제공하기 위한 JSP 문서 - 템플릿 페이지 --%>
<%-- TilesView 기능을 제공하는 태그를 사용하기 위해 JSP 문서에 tags-tiles 태그 라이브러리 추가 --%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, maximum-scale=5, initial-scale=1">
<title>TRAVEL MATE</title>
<!-- up to 10% speed up for external res -->
<link rel="dns-prefetch" href="https://fonts.googleapis.com/">
<link rel="dns-prefetch" href="https://fonts.gstatic.com/">
<link rel="preconnect" href="https://fonts.googleapis.com/">
<link rel="preconnect" href="https://fonts.gstatic.com/">
<!-- preloading icon font is helping to speed up a little bit -->
<link rel="preload" href="<c:url value="/fonts/flaticon/Flaticon.woff2"/>" as="font" type="font/woff2" crossorigin>

<link href="<c:url value="/css/common.css"/>" type="text/css" rel="stylesheet">
<link href="<c:url value="/css/style.css"/>" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="<c:url value="/css/vendor_bundle.min.css"/>">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;700&display=swap" rel="stylesheet">

<!-- favicon -->
<link rel="shortcut icon" href="favicon.ico">
<link rel="apple-touch-icon" href="demo.files/logo/icon_512x512.png">
<link rel="icon" href="<c:url value="/images/favicon.png"/>"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div id="header">
		<%-- tiles:insertAttribute 태그 : TilesView 기능을 제공하는 환경설정 파일에서
		put-attribute 엘리먼트로 제공된 JSP 문서의 실행결과를 제공받아 삽입하기 위한 태그 --%>
		<tiles:insertAttribute name="header"/>
	</div>
	
	<div id="content" class="cont_travel">
		<tiles:insertAttribute name="content"/>
	</div>
	
	<div id="footer">
		<tiles:insertAttribute name="footer"/>
	</div>
	
	<script src="<c:url value="/js/core.min.js"/>"></script>

  <!-- Code injected by live-server -->

</body>
</html>