<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : CprList.jsp
  * @Description : Cpr List 화면
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>목록</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>

function showSub() {
	var whsalMrktCd = document.getElementById("WHSAL_MRKT_CD").value
	
	$.get("./CprSelectSub.do?whsalMrktCd="+ whsalMrktCd,
		function(data){
			data = data.replace(/\[/g,'');			// 괄호제거
			data = data.replace(/\{/g,'');			// 괄호제거
			data = data.replace(/\]/g,'');			// 괄호제거
			data = data.replace(/\}/g,'');			// 괄호제거
			data = data.replace(/^\s+/,''); 		// 앞의 공백 제거
			data = data.replace(/\s+$/,''); 		// 뒤의 공백 제거
			data = data.replace(/^\s+|\s+$/g,'');   // 앞뒤 공백 제거
			data = data.replace(/\s/g,''); 			// 문자열 내의 공백 제거
			data = data.replace(/\n/g,'');			// 개행 제거
			data = data.replace(/\r/g,''); 			// 엔터 제거
			data = data.replace(/cprCd=/gi,'');		// key값제거
			data = data.replace(/cprNm=/gi,'');		// key값제거
			
			
			var res = data.split(',');
			console.log(res.length);
			var output = "<option disabled='disabled'>-- 선택하세요 --</option>";
			for(var i = 0; i < res.length; i=i+2) {
				output += "<option name='selectRes' value='"+ res[i] + "'>"+ res[i+1];
			}
			document.getElementById("CPR").innerHTML = output;
	});	
}
function selectRes() {
	opener.document.getElementById("coname").value =$("#CPR option:selected").text();	
}
</script>
</head>
<body>
 	<select multiple="multiple" size="10" class="form-control" name="WHSAL_MRKT_CD" id="WHSAL_MRKT_CD" onchange="showSub()" >
		<option disabled="disabled">-- 선택하세요 --</option>
	<c:forEach var="MRKT" items="${MRKTList}" >
		<option value="${MRKT.whsalMrktCd}">${MRKT.whsalMrktNm}</option>
	</c:forEach>
	</select> 
	
	<select  multiple="multiple" size="10" class="form-control" name="CPR" id="CPR" onclick="selectRes()" >
		<option disabled="disabled">-- 선택하세요 --</option>
	</select>
</body>
</html>
