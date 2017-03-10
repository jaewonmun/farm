<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	
	var url_static = "http://openapi.okdab.com/price/realtime/pricexml_class_action.jsp?key=4f52e6c2d4ffb5e17973b62d813b6d74d81d91b&date=20151024%20&lcode=&mcode=&scode=";
	var url_date = "";
	var url_lcode = "";
$(function(){
	$.ajax({
		url : url_static,
		dataType : 'xml',
		sucess : function(data){
			var output = "<select id ='lcode'>";
			$(data).find('result').each(function(){
				output +=  "<option value=" +$(data).find('name').text() + "/>" ;
				output +=  "</select>";
			});
			document.getElementById("list").innerHTML = output;
		},
		error : function(){
			alert('실패');	
		}
	});
});
	
</script>
</head>
<body>

	<div id ='list'></div>
	<button id="btn">클릭</button>
</body>
</html>
