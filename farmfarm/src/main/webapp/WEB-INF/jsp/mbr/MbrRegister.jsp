<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : MbrRegister.jsp
  * @Description : Mbr Register 화면 (회원가입)
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
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<style>
	#registerDiv { width: 500px; margin: 0 auto; }
	/* #zipcode {	width: 80%; float: left; } */
	a.btn.btn-default.btn-sm { padding: 2px; float: right; margin-right: 25px;}
</style>
<script>
	//주소 검색하기	
	function zipOPen() {									// daum주소검색 으로 연결해 주소를 검색한다
		new daum.Postcode({
			oncomplete: function(data) {
				document.getElementById("zipcode").
				value=data.roadAddress;
			}
		}).open();
		$("#farmSearch").show();
	}
	// 회사 검색하기
	function apiConame(){
		window.open("${pageContext.request.contextPath}/cpr/CprSelect.do", "coname", "width=400, height=400, left=10, top=5");
	}
	// 농장 검색하기
	function regionOPen() {
		window.open("${pageContext.request.contextPath}/mbr/mapSelect.do","regionOPen","width=350, height=600, left=10, top=5");
	}
	
	// 입력하지 않은값 있을시 가입불가
	$(function(){
		$("#farmSearch").hide();
		$("#signIn").click(function() {				
			var mbrId     = $("#mbrId").val();
			var password     = $("#password").val();
			var mbrName   = $("#mbrName").val();
			var zipcode   = $("#zipcode").val();
			var region   = $("#region").val();
			var userConame   = $("#userConame").val();
			
			if( mbrId==""   || password==""   || mbrName=="" || zipcode=="" || 
					userConame=="" ) {
				alert("입력하지 않은 값이 있습니다.");
				
				return false;
			}
			else {
				
				return true;
			}
		});
		// 아이디 중복 체크
		$("#idCheck").click(function() {
			var id    = $("#mbrId").val();
			 if (id.length == 0    || id == null ){		// ID란에 값이 없을경우
			  alert("아이디를 입력하세요.");
			  return false;
			 }
			 else {
				 $.get("./idCheck.do?mbrId="+ id,
						 function(data){
					 		alert(data);
					 		var check="<c:out value='${check}'/>";
					 		console.log(check);
					 		if (data == "사용가능한 ID 입니다.") {
					 			$("#infoSubmit").html("중복체크를 완료 하였습니다.");
						 		$("#signIn").removeAttr("disabled");	
					 		}
					 		else{
					 		$("#infoSubmit").html("중복된 아이디 입니다.");
					 		}
				 });
			 }
		});
		//$("#signIn").attr("disabled","disabled");
		
	});
	
</script>
</head>
<body>
	<div id="registerDiv">
	<form class="form-horizontal" action="${pageContext.request.contextPath}/mbr/addMbr.do" method="post">
		<div class="form-group">
			<h3>회원가입</h3>
  		</div>
  		<div class="form-group">
  			<a id="idCheck" class="btn btn-default btn-sm">중복체크</a>
			<label class="col-sm-2 control-label">아이디</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="mbrId" name="mbrId" placeholder="ID">
			</div>
  		</div>
  		<div class="form-group">
			<label class="col-sm-2 control-label">패스워드</label>
			<div class="col-sm-10">
				<input type="password" class="form-control" id="password" name="password" placeholder="PW">
			</div>
  		</div>
  		<div class="form-group">
			<label class="col-sm-2 control-label">이름</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="mbrName" name="mbrName" placeholder="이름">
			</div>
  		</div>
  		<div class="form-group">
  			<a onclick="zipOPen()" class="btn btn-default btn-sm">주소검색</a>
			<label class="col-sm-2 control-label">주소</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="zipcode" name="address" placeholder="주소" readonly="readonly">
			</div>
  		</div>
  		<div id=""></div>
  		<div class="form-group">
			<a id="farmSearch" onclick="regionOPen()" class="btn btn-default btn-sm">농장위치검색</a>
  			<label class="col-sm-2 control-label">농장위치</label>
  			<div class="col-sm-10">
				<input type="text" class="form-control" id="region" name="region" placeholder="주소검색을 먼저 해주세요" readonly="readonly">
			</div>
  		</div>
  		<div class="form-group">
			<label class="col-sm-2 control-label">주거래처</label>
			<a onclick="apiConame()" class="btn btn-default btn-sm">거래처검색</a>
			<div class="col-sm-10">
				<input type="text" id="userConame" name="userConame" hidden="hidden">
				<input type="text" class="form-control" id="co_name" name="co_name" placeholder="거래처" readonly="readonly">
			</div>
  		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button id="signIn" type="submit" class="btn btn-info" disabled>Sign in</button>
				<span id="infoSubmit">ID 중복체크를 완료해 주세요</span>
			</div>
		</div>
		</form>
  	</div>
</body>
</html>
