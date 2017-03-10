<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : ItemList.jsp
  * @Description : Item List 화면
  * @Modification Information
  * 
  * @author 박석현
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
<meta charset=utf-8" />
<title>ITEM 목록</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javaScript" language="javascript" defer="defer"></script>
<script>

function showSub() {
	var Lcode = document.getElementById("LCODE").value
	
	$.get("selectItemM.do?lcode="+ encodeURIComponent(Lcode),
		function(L){
		//var L = eval("("+data+")");
		console.log(L);
		$("#MCODE").empty();
		$("#MCODE").append('<option disabled="disabled">-- 선택하세요 --</option>');			
		for (i=0; i<L.length; i++) {
			var option = '<option value="'+L[i].mcode+'">'+L[i].mcode+'</option>'
			$("#MCODE").append(option)
		}
	});	
}
     
function showSub1() {
	var Mcode = document.getElementById("MCODE").value
	
	$.get("selectItemS.do?mcode="+ encodeURIComponent(Mcode),
		function(M){
		console.log(M);
		$("#SCODE").empty();
		$("#SCODE").append('<option disabled="disabled">-- 선택하세요 --</option>');			
		for (i=0; i<M.length; i++) {
			var option = '<option value="'+M[i].itemCode+'">'+M[i].scode+'</option>'
			$("#SCODE").append(option)
		}
	});	
}
function selectRes() {
	opener.document.getElementById("userConame").value = $("#SCODE option:selected").text();
	opener.document.getElementById("itemCode").value = $("#SCODE option:selected").val();
}
</script>
</head>

<body> 	

	<select multiple="multiple" size="10" class="form-control" name="LCODE" id="LCODE" onchange="showSub()" >
		<option disabled="disabled">-- 선택하세요 --</option>
	<c:forEach var="L" items="${LList}" >
		<option value="${L.lcode}">${L.lcode}</option>
	</c:forEach>
	</select> 
	
	<select multiple="multiple" size="10" class="form-control" name="MCODE" id="MCODE" onchange="showSub1()" >
		<option disabled="disabled">-- 선택하세요 --</option>
	<c:forEach var="M" items="${MList}" >
		<option value="${M.mcode}">${M.mcode}</option>
	</c:forEach>
	</select> 
	
	<select  multiple="multiple" size="10" class="form-control" name="SCODE" id="SCODE" onclick="selectRes()" >
		<option disabled="disabled">-- 선택하세요 --</option>
	</select>
	

</body>
</html>
