<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<c:url value='/css/egovframework/com/main.css' />" rel="stylesheet" type="text/css">
<title>eGovFrame 공통 컴포넌트</title>
<style>
	#header1 {
    width: 100%;
    height: 52px;
    text-align: center;
	}
	a { color:black; }
	a { text-decoration: none; }
	a:hover { text-decoration: none; }
</style>
</head>
<body>
<div id="wrap">
<div id="header1" >
	<a href="${pageContext.request.contextPath}/crops/farmMap.do" target="_content" class="link"><img src="<c:url value='/images/makeImage/logo/farmlogo.png' />" width="280" height="70" alt="egovframe"></a>
	
	<span style="margin-left:30px; font-size:12px; ">
		<c:if test="${sessionScope.loginInfo != null}">
		${loginInfo.mbrId }님 환영합니다. <a href="${pageContext.request.contextPath }/mbr/logout.do"><b>로그아웃</b></a>
		</c:if>
		<c:if test="${loginInfo == null }">
			<span id="loginLink"><a href="${pageContext.request.contextPath}/mbr/loginView.do" target="_content" class="link">로그인</a></span>
		</c:if>
		
		<span><a href="${pageContext.request.contextPath}/mbr/addMbrView.do" target="_content" class="link">회원가입</a></span>
	</span>
	
	</div>
</div>
</div>
</body>
</html>
