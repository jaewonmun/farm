<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="<c:url value='/js/jquery.xdomainajax.js'/>"></script>
<script src="<c:url value='/js/weather/weather.js'/>"></script>

<title>Insert title here</title>
<style>
.all{
	    width: 80%;
	    margin: 0 auto;
	}
.weatherImageWeek { width: 30px; height: 30px; }
.mapIcon { width: 60px; height: 60px; }
.staticIcon { width: 15px; height: 15px; }
.threeDayWeather { width: 40px; height: 40px; }
talble { border-bottom-color: whitesmoke; }
</style>
<script>
$(function(){
	var today = new Date();
	var week = new Array('일','월','화','수','목','금','토');
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	var day = today.getDate();
	var hours = today.getHours();
	var minutes = today.getMinutes();
	$('#todayDate').html(month +"월 " + day + "일 " + week[today.getDay()]+"요일");
	realTimeWeather(today,year,month,day,hours,minutes);
});


</script>
</head>
<body>
	<div class="section">
		<div class="container">
			<div class="row all">
				<!-- 오늘 날씨 -->
				<div class="selectloc">
					<h3>날씨 정보</h3>
					<span id="todayDate"></span>
					<select>
						<option>선택하세요
					</select>
				</div>
				<hr>
					<div class="col-md-6 row">
						<table>
						<colgroup>
							<col style="width: 10%;">
							<col style="width: 40%;">
							<col style="width: 40%;">
							<col style="width: 10%;">
						</colgroup>
						<tr><td><strong>오늘</strong></td></tr>
						<tr>
							<td></td>
							<td>
								<img id="todayImg" src="<c:url value='/images/makeImage/weather/littleClowdy.png'/>" alt="" class="mapIcon"><br>
								<span id="todayStatus" class="tWtTit"></span><br>
								<span id="todayRN" class="tWtTxt"></span>
							</td>
							<td>
								<img src="<c:url value='/images/makeImage/weather/temperature.png'/>" alt="" class="staticIcon">
								<span id="todayTemp" class="temp"></span><br>
								<span class="maximum">최고 -</span> <span class="minimum">최저-</span> <br>
								<img src="<c:url value='/images/makeImage/weather/humidity.png'/>" alt="" class="staticIcon">
								<span class="temperature humidity">습도 <b>47%</b></span> <br>
								<img src="<c:url value='/images/makeImage/weather/rainy.png'/>" alt="" class="staticIcon">
								<span class="temperature rainfall">강수량 <b>-mm</b></span> <br>
								<img src="<c:url value='/images/makeImage/weather/windy.png'/>" alt="" class="staticIcon">
								<span class="temperature airVolume">풍향 <b>서1.9m/s</b></span>
							</td>
							<td></td>
						</tr>
						</table>
					</div>
				<%-- <!-- 내일 날씨 -->
				<div class="col-md-6">
						<table>
						<colgroup>
							<col style="width: 10%;">
							<col style="width: 40%;">
							<col style="width: 40%;">
							<col style="width: 10%;">
						</colgroup>
						<tr><td><strong>내일</strong></td></tr>
						<tr>
							<td></td>
							<td>
								<img id="todayImg" src="<c:url value='/images/makeImage/weather/littleClowdy.png'/>" alt="" class="mapIcon"><br>
								<span id="todayStatus" class="tWtTit"></span><br>
								<span id="todayRN" class="tWtTxt"></span>
							</td>
							<td>
								<img src="<c:url value='/images/makeImage/weather/temperature.png'/>" alt="" class="staticIcon">
								<span id="todayTemp" class="temp"></span><br>
								<span class="maximum">최고 -</span> <span class="minimum">최저-</span> <br>
								<img src="<c:url value='/images/makeImage/weather/humidity.png'/>" alt="" class="staticIcon">
								<span class="temperature humidity">습도 <b>47%</b></span> <br>
								<img src="<c:url value='/images/makeImage/weather/rainy.png'/>" alt="" class="staticIcon">
								<span class="temperature rainfall">강수량 <b>-mm</b></span> <br>
								<img src="<c:url value='/images/makeImage/weather/windy.png'/>" alt="" class="staticIcon">
								<span class="temperature airVolume">풍향 <b>서1.9m/s</b></span>
							</td>
							<td></td>
						</tr>
						</table>
					</div>
			</div>
			<hr>
			<!-- 1주일 날씨 -->
			<div class="row all">
				<div class="col-md-12">
					<table class="bg01 bg02" style="width=100%">
						<colgroup>
							<col style="width: 16%;">
							<col style="width: 16%;">
							<col style="width: 16%;">
							<col style="width: 16%;">
							<col style="width: 16%;">
							<col style="width: 16%;">
						</colgroup>
						<thead>
							<tr class="wt01">
								<th><strong>화</strong>/11.29</th>
								<th><strong>수</strong>/11.30</th>
								<th><strong>목</strong>/12.01</th>
								<th><strong>금</strong>/12.02</th>
								<th><strong>토</strong>/12.03</th>
								<th><strong>일</strong>/12.04</th>
							</tr>
						</thead>
						<tbody>
							<tr class="wt02">
								<td>
									<div>
										<img class="weatherImageWeek" src="<c:url value='/images/makeImage/weather/littleClowdy.png'/>" alt="맑음">
									</div> <span class="weekWt">구름많음</span> <span class="weekWt02">3℃</span>/11℃
								</td>
								<td>
									<div>
										<img class="weatherImageWeek" src="<c:url value='/images/makeImage/weather/littleClowdy.png'/>" alt="맑음">
									</div> <span class="weekWt">구름많음</span> <span class="weekWt02">4℃</span>/12℃
								</td>
								<td>
									<div>
										<img class="weatherImageWeek" src="<c:url value='/images/makeImage/weather/littleClowdy.png'/>" alt="맑음">
									</div> <span class="weekWt">맑음</span> <span class="weekWt02">-1℃</span>/10℃
								</td>
								<td>
									<div>
										<img class="weatherImageWeek" src="<c:url value='/images/makeImage/weather/littleClowdy.png'/>" alt="맑음">
									</div> <span class="weekWt">맑음</span> <span class="weekWt02">0℃</span>/12℃
								</td>
								<td>
									<div>
										<img class="weatherImageWeek" src="<c:url value='/images/makeImage/weather/littleClowdy.png'/>" alt="맑음">
									</div> <span class="weekWt">구름많음</span> <span class="weekWt02">2℃</span>/11℃
								</td>
								<td>
									<div>
										<img class="weatherImageWeek" src="<c:url value='/images/makeImage/weather/littleClowdy.png'/>" alt="맑음">
									</div> <span class="weekWt">구름조금</span> <span class="weekWt02">2℃</span>/11℃
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div> --%>
	</div>
	<hr>
</body>
</html>