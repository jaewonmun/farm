<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : Login.jsp
  * @Description : Login 화면
  * @Modification Information
  * 
  * @author 문재원
  * @since 20161122
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>목록</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<style>
	#loginDiv {
	    width: 400px;
	/*     border: 1px solid; */
	    margin: 0 auto;
	}
	a { color:black; }
	a:hover { text-decoration: none; }
</style>

</head>
<body>
	<br>
	<br>
	<br>
	<div id="loginDiv">
		<h3>Login</h3>
		<hr>
		<div>
		<form action="${pageContext.request.contextPath}/mbr/login.do" method="post">
			<div class="form-group">
				<label for="exampleInputEmail1">ID</label>
				<input type="text"	class="form-control" id="mbrId" name="mbrId" placeholder="ID를 입력하세요"/>
			</div> 
			<div class="form-group">
				<label for="exampleInputPassword1">PW</label> 
				<input type="password" class="form-control" id="password" name="password" placeholder="Password를 입력하세요"/>
			</div>
			<button type="submit" class="btn btn-default">Login</button>
		</form>
		</div>
		<div>
			<hr>
			<a type="text" href="${pageContext.request.contextPath}/mbr/addMbrView.do">회원가입</a> &nbsp;&nbsp;
			<a type="text" href="#">ID/PW찾기</a>
		</div>
		
	</div>
</body>
</html>
