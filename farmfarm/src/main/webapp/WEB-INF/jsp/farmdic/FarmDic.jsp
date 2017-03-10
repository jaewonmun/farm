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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>농업사전</title>


<!-- 작목별 농업기술정보 시작-->
<link href="http://api.nongsaro.go.kr/css/api.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://api.nongsaro.go.kr/js/framework.js"></script>	
<script type="text/javascript" src="http://api.nongsaro.go.kr/js/openapi_nongsaro.js"></script>
	
<script type="text/javascript">
nongsaroOpenApiRequest.apiKey = "20161118HLJYAZGGW2TWMUHSPSKEW";//변경할 부분 1
/* nongsaroOpenApiRequest.serviceName = "cropTechInfo";
nongsaroOpenApiRequest.operationName = "insttList"; */
nongsaroOpenApiRequest.serviceName = "farmDic";
nongsaroOpenApiRequest.operationName = "searchEqualWord";
nongsaroOpenApiRequest.htmlArea="nongsaroApiLoadingArea";
nongsaroOpenApiRequest.callback = "${pageContext.request.contextPath}/callback/ajax_local_callback.jsp";//변경할 부분 2

</script>
<!-- 작목별 농업기술정보 끝-->



</head>
<body>

<!-- 작목별 농업기술정보 시작-->
<div id="nongsaroApiLoadingArea"></div><!-- 검색어 일치항목 HTML 로딩 영역 -->
<div id="nongsaroApiLoadingArea3"></div><!-- 검색어 전방일치항목 HTML 로딩 영역 -->

<!-- 작목별 농업기술정보 끝-->

</body>
</html>
