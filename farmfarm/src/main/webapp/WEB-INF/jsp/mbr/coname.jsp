<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function(){
		$.get("conameSearch.jsp",
			function(data){
				var output = "<select id ='lcode'>";
				$(data).find('result').each(function(){
					output +=  "<option value=" +$(data).find('name').text() + "/>" ;
					output +=  "</select>";
				});
				document.getElementById("list").innerHTML = output;
		});
	});
</script>
</head>
<body>
	<div id ='list'>dd</div>
	ddddddddddd
</body>
</html>