<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="<c:url value='/css/chart/Nwagon.css'/>" type="text/css">
<script src="<c:url value='/js/sellInfo/Nwagon.js'/>"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>Insert title here</title>
<style>
#content_pop {						// 제일 바깥 외곽
    width: 1000px;
    margin: 0 auto;
}
#topDiv,#weatherDiv,#sellListDiv,#equDiv,#fmdDiv { width:100%; }
hr { margin-top: 10px; margin-bottom: 10px; }
.weatherImgDay { width:30px; height: 30px;}
</style>
<script>
$( function() {
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	var day = today.getDate();
	var hours = today.getHours();
	var minutes = today.getMinutes();
	if(day < 10) {
		day = "0"+day;
	}
	var paramDate = year+""+month+""+day;
	$("#datepicker1").val(paramDate);
    $( "#datepicker1" ).datepicker({
		dateFormat: "yymmdd",	
		changeYear: true,
		changeMonth: true
  	});
    
    
    /* 차트영역 */
 	var data = "${select3day}";
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
	var data3day = data.split(',');
	var price1 = Number(data3day[0].split('=')[1]);
	var date1 = data3day[1].split('=')[1];
	var price2 = Number(data3day[2].split('=')[1]);
	var date2 = data3day[3].split('=')[1];
	var price3 = Number(data3day[4].split('=')[1]);
	var date3 = data3day[5].split('=')[1];
	var max = price1;
	if(max < price2) { max = price2; }
	if(max < price3) { max = price3; }
	var increment = parseInt(max/4);
 	var options = {
		'legend': {
			names: [date3,date2,date1]
		},
		'dataset': {
			title: 'per day',
			values: [price3,price2,price1],
			colorset: ['#ccf2ff', '#1ac6ff', "#007399"]
		},
		'chartDiv': 'Nwagon',
		'chartType': 'column',
		'chartSize': { width: 150, height: 220 },
		'maxValue': max,
		'increment': increment
	};
	Nwagon.chart(options);
    
	var equ1 = "${sumEquList1}";
	var equ2 = "${sumEquList2}";
	var equ3 = "${sumEquList3}";
	var equ4 = "${sumEquList4}";
	equ1 = equ1.replace(/\[/g,''); equ2 = equ2.replace(/\[/g,''); equ3 = equ3.replace(/\[/g,''); equ4 = equ4.replace(/\[/g,'');		// 괄호제거
	equ1 = equ1.replace(/\{/g,''); equ2 = equ2.replace(/\{/g,''); equ3 = equ3.replace(/\{/g,''); equ4 = equ4.replace(/\{/g,'');		// 괄호제거
	equ1 = equ1.replace(/\]/g,''); equ2 = equ2.replace(/\]/g,''); equ3 = equ3.replace(/\]/g,''); equ4 = equ4.replace(/\]/g,'');		// 괄호제거
	equ1 = equ1.replace(/\}/g,''); equ2 = equ2.replace(/\}/g,''); equ3 = equ3.replace(/\}/g,''); equ4 = equ4.replace(/\}/g,'');						// 괄호제거
	equ1 = equ1.replace(/^\s+/,''); equ2 = equ2.replace(/^\s+/,''); equ3 = equ3.replace(/^\s+/,''); equ4 = equ4.replace(/^\s+/,'');// 앞의 공백 제거
	equ1 = equ1.replace(/\s+$/,''); equ2 = equ2.replace(/\s+$/,''); equ3 = equ3.replace(/\s+$/,''); equ4 = equ4.replace(/\s+$/,'');  		// 뒤의 공백 제거
	equ1 = equ1.replace(/^\s+|\s+$/g,''); equ2 = equ2.replace(/^\s+|\s+$/g,''); equ3 = equ3.replace(/^\s+|\s+$/g,'');  equ4 = equ4.replace(/^\s+|\s+$/g,'');// 앞뒤 공백 제거
	equ1 = equ1.replace(/\s/g,''); equ2 = equ2.replace(/\s/g,''); equ3 = equ3.replace(/\s/g,''); equ4 = equ4.replace(/\s/g,'');		// 문자열 내의 공백 제거
	equ1 = equ1.replace(/\n/g,''); equ2 = equ2.replace(/\n/g,''); equ3 = equ3.replace(/\n/g,''); equ4 = equ4.replace(/\n/g,'');	// 개행 제거
	equ1 = equ1.replace(/\r/g,''); equ2 = equ2.replace(/\r/g,''); equ3 = equ3.replace(/\r/g,''); equ4 = equ4.replace(/\r/g,''); 						// 엔터 제거
	
	var equ1Quan = Number(equ1.split(',')[0].split('=')[1]);
	var equ1Price = Number(equ1.split(',')[1].split('=')[1]);
	var equ1Name = equ1.split(',')[2].split('=')[1];
	
	var equ2Quan = Number(equ2.split(',')[0].split('=')[1]);
	var equ2Price = Number(equ2.split(',')[1].split('=')[1]);
	var equ2Name = equ2.split(',')[2].split('=')[1];
	
	var equ3Quan = Number(equ3.split(',')[0].split('=')[1]);
	var equ3Price = Number(equ3.split(',')[1].split('=')[1]);
	var equ3Name = equ3.split(',')[2].split('=')[1];
	
	var equ4Quan = Number(equ4.split(',')[0].split('=')[1]);
	var equ4Price = Number(equ4.split(',')[1].split('=')[1]);
	var equ4Name = equ4.split(',')[2].split('=')[1];
	
	var maxQuan = equ1Quan;
	var maxPrice = equ1Price;
	console.log(equ3Quan);
	if(maxQuan < equ2Quan) { maxQuan = equ2Quan; }
	if(maxQuan < equ3Quan) { maxQuan = equ3Quan; }
	if(maxQuan < equ4Quan) { maxQuan = equ4Quan; }
	if(maxPrice < equ2Price) { maxPrice = equ2Price; }
	if(maxPrice < equ3Price) { maxPrice = equ3Price; }
	if(maxPrice < equ4Price) { maxPrice = equ4Price; }
	var incrementQuan = parseInt(maxQuan/4);
	var incrementPrice = parseInt(maxPrice/4);
	
	$("#equ1Quan").html(equ1Quan);
	$("#equ2Quan").html(equ2Quan);
	$("#equ3Quan").html(equ3Quan);
	$("#equ4Quan").html(equ4Quan);
	$("#equ1Price").html(equ1Price);
	$("#equ2Price").html(equ2Price);
	$("#equ3Price").html(equ3Price);
	$("#equ4Price").html(equ4Price);
	var options1 = {
			'legend': {
				names: [equ1Name,equ2Name,equ3Name,equ4Name]
			},
			'dataset': {
				title: 'per day',
				values: [equ1Quan,equ2Quan,equ3Quan,equ4Quan],
				colorset: ['#DC143C', '#FF8C00', "#30A1CE"]
			},
			'chartDiv': 'NwagonsumQuan',
			'chartType': 'column',
			'chartSize': { width: 250, height: 220 },
			'maxValue': maxQuan,
			'increment': incrementQuan
		};
		Nwagon.chart(options1);

		
	var options2 = {
			'legend': {
				names: [equ1Name,equ2Name,equ3Name,equ4Name]
			},
			'dataset': {
				title: 'per day',
				values: [equ1Price,equ2Price,equ3Price,equ4Price],
				colorset: ['#DC143C', '#FF8C00', "#30A1CE"]
			},
			'chartDiv': 'NwagonsumPrice',
			'chartType': 'column',
			'chartSize': { width: 250, height: 220 },
			'maxValue': maxPrice,
			'increment': incrementPrice
		};
		Nwagon.chart(options2);
});
</script>
</head>
<body>
<!-- 로그인 안했으면 로그인 페이지로 -->
<c:if test="${loginInfo == null }">
		<jsp:forward page="/mbr/loginView.do" />
</c:if>
<div id="content_pop" style=" width: 950px; margin: 0 auto;">
	<!-- 타이틀 -->
	<h3>금일 종합조회</h3>
	<hr>
	<div id="topDiv" class="row">
	<form id="dateSearch" action="${pageContext.request.contextPath}/basicinfo/totalInfo.do">
			<b>일자선택</b> <input type="text" name="weatherDate" id="datepicker1"/>
			<button id="dateSearchBtn" class="btn btn-default">조회</button>
	</form>
	</div>
	<hr><!-- 날씨리포트 -->
	<div id="weatherDiv" class="row">
		<div class="col-xs-6" style="width:500px;">
			<table style="width:95%;">
			 	<tr>
			 		<td style="width:30%;"><b>사용자</b> : ${loginInfo.mbrId}</td>
			 		<td style="width:70%;"><%-- <b>주소</b> : ${loginInfo.address} --%></td>
			 	</tr>
			</table>
		
		</div>
		<div class="col-xs-6"  style="width:400px;">
			<table style="width:95%;">
			 	<tr>
			 		<td style="width:25%;"><img class="weatherImgDay" src='../images/makeImage/weatherSK/${weatherStatus}'/></td>
			 		<td style="width:25%;"><b>최저</b> : ${weather.lowestTemp} ℃</td>
			 		<td style="width:25%;"><b>최대</b> : ${weather.highestTemp} ℃</td>
			 		<td style="width:25%;"><b>강수량</b> : ${weather.rainfall} </td>
			 	</tr>
			</table>
		</div>
	</div>
	<hr><!-- 판매리포트 -->
	<div id="sellListDiv" class="row" style="height:250px;">
		<b>판매내역 (5건까지 조회,더 보고싶다면 판매조회페이지를 이용하세요)</b> <br>
		<div id="tableList" class="col-xs-6" style="width:550px; height:220px; border:1px solid lightgray;">
			<table class="table table-hover">	  
				<thead>
					<th><b>이름</b></th>
					<th><b>수량</b></th>
					<th><b>단위</b></th>
					<th><b>가격</b></th>
					<th><b>도매법인</b></th>
				</thead>
				<tbody>
				<c:forEach var="sellListList" items="${sellListList}" varStatus="status">
				<tr>
					<td style="width:25%"><c:out value="${sellListList.itemName}"/>&nbsp;</td>
					<td style="width:10%"><c:out value="${sellListList.sumamt}"/>&nbsp;</td>
					<td style="width:10%"><c:out value="${sellListList.sellUnit}"/>&nbsp;</td>
					<td style="width:15%"><fmt:formatNumber value="${sellListList.price}" pattern="#,###" />&nbsp;</td>
					<td style="width:15%"><c:out value="${sellListList.coname}"/>&nbsp;</td>
	   			</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="todaystat" class="col-xs-6" style="width:150px; height:220px; border:1px solid lightgray;">
			<b>금일 통계</b>
			<br><br><br>
			<p>총판매금액</p><br><br>
			<p>이번달 누계<p><br>
		</div>
		<div id="day3" class="col-xs-6" style="width:200px; height:220px; border:1px solid lightgray;">
			<b>3일간 매출</b>
			<!-- 차트 -->
			<div id="Nwagon"></div>
		</div>
	</div>
	<hr><!-- 장비리포트 -->
	<div id="equDiv" class="row">
		<b>장비사용내역</b><br>
		<div id="sumQuan" class="col-xs-6" style="width:300px; height:220px; border:1px solid lightgray;">
			<b>수량비교</b>
			<div id="NwagonsumQuan"></div>
		
		</div>
		<div id="sumPrice" class="col-xs-6" style="width:300px; height:220px; border:1px solid lightgray;">
			<b>소요금액비교</b>
			<div id="NwagonsumPrice"></div>
		</div>
		<div id="sumStat" class="col-xs-6" style="width:300px; height:220px; border:1px solid lightgray;">
			<br>
			<br>
			<table class="table table-hover">	  
				<thead>
					<th>구분</th>
					<th><b>장비</b></th>
					<th><b>인력</b></th>
					<th><b>비료</b></th>
					<th><b>농약</b></th>
				</thead>
				<tbody>
					<tr>
						<td><b>수량</b></td>
						<td id="equ1Quan"></td>
						<td id="equ2Quan"></td>
						<td id="equ3Quan"></td>
						<td id="equ4Quan"></td>
		   			</tr>
		   			<tr>
						<td><b>금액</b></td>
						<td id="equ1Price"></td>
						<td id="equ2Price"></td>
						<td id="equ3Price"></td>
						<td id="equ4Price"></td>
		   			</tr>
				</tbody>
			</table>
		</div>
	</div>
	<hr><!-- 일지리포트 -->
</div>
</body>
</html>