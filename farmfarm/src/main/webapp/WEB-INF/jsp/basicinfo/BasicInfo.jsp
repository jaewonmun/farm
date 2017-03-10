<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EquipmentList.jsp
  * @Description : Equipment List 화면
  * @Modification Information
  * 
  * @author 김형철
  * @since 20161123
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>목록</title>


<!-- 작목별 농업기술정보 시작-->
<link href="http://api.nongsaro.go.kr/css/api.css" rel="stylesheet" type="text/css"/>
<script src="<c:url value='https://code.jquery.com/jquery-1.12.4.js'/>"></script>
<script type="text/javascript" src="http://api.nongsaro.go.kr/js/framework.js"></script>	
<script type="text/javascript" src="http://api.nongsaro.go.kr/js/openapi_nongsaro.js"></script>

<script type="text/javascript">
nongsaroOpenApiRequest.apiKey = "20161118HLJYAZGGW2TWMUHSPSKEW";//변경할 부분 1
nongsaroOpenApiRequest.serviceName = "cropTechInfo";
nongsaroOpenApiRequest.operationName = "insttList";
/* nongsaroOpenApiRequest.serviceName = "farmDic";
nongsaroOpenApiRequest.operationName = "searchEqualWord"; */
nongsaroOpenApiRequest.htmlArea="nongsaroApiLoadingAreaInstt";
nongsaroOpenApiRequest.callback = "${pageContext.request.contextPath}/callback/ajax_local_callback.jsp";//변경할 부분 2
</script>
<!-- 작목별 농업기술정보 끝-->
</head>
<body>

<div style="width:950px; margin:0 auto;">
	<!-- 작목별 농업기술정보 시작-->
	<div id="nongsaroApiLoadingAreaInstt"></div><!-- 기관명 목록 HTML 로딩 영역 -->
	<div id="nongsaroApiLoadingArea"></div><!-- 메인카테고리 HTML 로딩 영역 -->
	<div id="nongsaroApiLoadingArea1"></div><!-- 중분류카테고리 HTML 로딩 영역 -->
	<div id="nongsaroApiLoadingArea3"></div><!-- 대분류기술코드 HTML 로딩 영역 -->
	<div id="nongsaroApiLoadingArea4"></div><!-- 소분류기술코드 HTML 로딩 영역 -->
	<div id="nongsaroApiLoadingArea5"></div><!-- 작목기술목록 HTML 로딩 영역 -->
	<!-- 작목별 농업기술정보 끝-->
</div>
</body>
</html>
