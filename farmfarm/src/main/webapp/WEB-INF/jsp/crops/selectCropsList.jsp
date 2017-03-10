<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>
function selectRes() {
	opener.document.getElementById("userConame").value = $("#SCODE option:selected").text();
	opener.document.getElementById("diarySubject").value = $("#SCODE option:selected").text();
	opener.document.getElementById("itemCode").value = $("#SCODE option:selected").val();
}
</script>
</head>
<body>
<%-- <p>${resultList}</p> --%>
<select multiple="multiple" size="10" class="form-control" name="SCODE" id="SCODE" style="width:100px;" onclick="selectRes()">
	<c:forEach var="list" items="${resultList}">
		<option value="${list.itemCode}" >${list.scode}</option>
	</c:forEach>	
</select>
</body>
</html>