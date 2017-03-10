<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<c:url value='/css/egovframework/com/main.css' />" rel="stylesheet" type="text/css">
<title>eGovFrame 공통 컴포넌트</title>
<style>
	#footer1 {
    width: 100%;
    text-align: center;
	background-color: honeydew;
}
</style>
</head>
<body>
<div id="wrap">
<div id="footer1">
	<p>Copyright(c)2016 Farmfarm</p>
</div>
</div>
<a href="javascript:window.open('${pageContext.request.contextPath}/farmdic/FarmDic.do', '', 'toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=562.727,height=640')" target="_content" class="link">test page FarmDic.do 팝업</a></li>
<a href="${pageContext.request.contextPath}/jobProcess/JobProcessList.do" target="_content" class="link">test page JobProcessList.do</a></li>
</body>
</html>
