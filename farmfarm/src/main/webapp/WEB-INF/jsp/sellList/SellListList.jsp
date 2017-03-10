<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
 /**
  * @Class Name : SellListList.jsp
  * @Description : SellList List 화면
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
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>jQuery UI Datepicker</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="<c:url value='/css/chart/Nwagon.css'/>" type="text/css">
<script src="<c:url value='/js/sellInfo/Nwagon.js'/>"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
#statSell,#content_pop, #tableList, #sysbtn, #title, #paging {
	    width: 800px;
	    margin: 0 auto;
	}
#statSell { height: 200px;}
#chartSell { width: 500px; }
#top5Div { width: 250px; float: right; }
#datepicker1, #datepicker2 { width: 90px; height: 20px;}
#dateSearchBtn { padding:1px; height:25px; width:40px;}
</style>
<script>
var dialog;		//삽입폼
var dialog2;		//수정폼
$( function() {
    $( "#datepicker1" ).datepicker({
		dateFormat: "yymmdd",	
		changeYear: true,
		changeMonth: true
    });
    $( "#datepicker2" ).datepicker({
		dateFormat: "yymmdd",
		changeYear: true,
		changeMonth: true
      });
    $( "#datepicker3" ).datepicker({
		dateFormat: "yymmdd",	
		changeYear: true,
		changeMonth: true
    });
    var id = "<c:out value='${loginInfo.mbrId}'/>";
    
    $("#dateSearchBtn").click(function(){
    	$('#dateSearchBtn').submit();
    });
    
    dialog = $("#dialog-form").dialog({
	    autoOpen: false,
	    height: 300,
	    width: 300,
	    modal: true
	});
    
    /* 차트 영역 */
    if("<c:out value='${sun}'/>" == "") { var sun = 0; }else { var sun = "<c:out value='${sun}'/>"; }
    if("<c:out value='${mon}'/>" == "") { var mon = 0; }else { var mon = "<c:out value='${mon}'/>"; }
    if("<c:out value='${tus}'/>" == "") { var tus = 0; }else { var tus = "<c:out value='${tus}'/>"; }
    if("<c:out value='${wed}'/>" == "") { var wed = 0; }else { var wed = "<c:out value='${wed}'/>"; }
    if("<c:out value='${thr}'/>" == "") { var thr = 0; }else { var thr = "<c:out value='${thr}'/>"; }
    if("<c:out value='${fri}'/>" == "") { var fri = 0; }else { var fri = "<c:out value='${fri}'/>"; }
    if("<c:out value='${sat}'/>" == "") { var sat = 0; }else { var sat = "<c:out value='${sat}'/>"; }
    var arrWeek = [Number(sun),Number(mon),Number(tus),Number(wed),Number(thr),Number(fri),Number(sat)];
    var maxprice = arrWeek[0];
    for(var i=0; i< arrWeek.length; i++) {
    	if(maxprice < arrWeek[i]){
    		maxprice = arrWeek[i];
    	}
    }
    var increment = parseInt(maxprice/4);
    console.log(maxprice);
	var options = {
		'legend': {
			names: ['일','월','화','수','목','금','토']
		},
		'dataset': {
			title: 'Playing time per day',
			values: [arrWeek[0],arrWeek[1],arrWeek[2],arrWeek[3],arrWeek[4],arrWeek[5],arrWeek[6]],
			colorset: ['#ccf2ff', '#1ac6ff', "#007399"]
		},
		'chartDiv': 'Nwagon',
		'chartType': 'column',
		'chartSize': { width: 500, height: 250 },
		'maxValue': maxprice,
		'increment': increment
	};
	Nwagon.chart(options);
		/* 차트 영역 */
});
function insertSellForm(){
	$("#sumamt").attr('autofocus','autofocus');
	dialog.dialog("open");
}
function selectItem_insert() {
	window.open("${pageContext.request.contextPath}/crops/selectCropsList_sellList.do?searchCondition=0&searchKeyword=${loginInfo.mbrId}","regionOPen","width=200, height=250, left=10, top=5");
}
function apiConame(){
	window.open("${pageContext.request.contextPath}/cpr/CprSelectForSell.do", "coname", "width=400, height=400, left=10, top=5");
}
function deletecheck(UsePk) {	 
	if (confirm("정말 삭제하시겠습니까?")) {
		location.href= "../sellList/deleteSellList.do?sellCode="+UsePk;
	}
}
</script>
</head>
<body>
<!-- 로그인 안했으면 로그인 페이지로 -->
<c:if test="${loginInfo == null }">
		<jsp:forward page="/mbr/loginView.do" />
</c:if>
<p>${week}</p>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
<div id="content_pop">
	<!-- 타이틀 -->
	<img src="<c:url value='/images/makeImage/logo/sellList.png'/>"width="195" height="65"><br>
	<div id="title">
		<a onclick="insertSellForm()">
			<img src="<c:url value='/images/makeImage/logo/sellRegister.png'/>"width="115" height="45">
		</a>
		<div style="padding-left: -10px; float: right;">
			<form id="dateSearch">
			일자별 : <input type="text" name="sellDateMin" id="datepicker1"/> ~ <input type="text"  name="sellDateMax" id="datepicker2"/>
			<button id="dateSearchBtn" class="btn btn-default">조회</button>
			</form>
		</div>
	</div>
	<hr>
	<!-- // 타이틀 -->
	<!-- List -->
	<div id="statSell" class="row">
		<div id="chartSell" class="col-xs-6">
			<b>지난주 매출 동향</b><br>
			<div id="Nwagon"></div>
		</div>
		<div id="top5Div" class="col-xs-6">
			<b>지난달 매출 TOP5</b><br>
			<table class="table table-hover" >
				<thead>
					<th style="text-align: center;"><b>Rank</b></th>
					<th style="text-align: center;"><b>이름</b></th>
					<th style="text-align: right;"><b>금액</b></th>
				</thead>
				<tbody>
					<c:forEach var="top5" items="${top5}" varStatus="status">
					<tr style="padding: 2px;">
						<td style="width:10%; padding: 5px; text-align: center;"><b>${status.count}</b></td>
						<td style="width:60%; padding: 5px; text-align: center;"><c:out value="${top5.itemName}"/>&nbsp;</td>
						<td style="width:30%; padding: 5px; text-align: right;"><c:out value="${top5.price}"/>&nbsp;</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<hr style="position: absolute;">
	<div id="tableList" style="">
		<table class="table table-hover">	  
			<thead>
				<th><b>이름</b></th>
				<th><b>수량</b></th>
				<th><b>단위</b></th>
				<th><b>가격</b></th>
				<th><b>도매법인</b></th>
				<th><b>일자</b></th>
				<th><b>삭제</b></th>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td style="width:25%"><c:out value="${result.itemName}"/>&nbsp;</td>
				<td style="width:10%"><c:out value="${result.sumamt}"/>&nbsp;</td>
				<td style="width:10%"><c:out value="${result.sellUnit}"/>&nbsp;</td>
				<td style="width:15%"><fmt:formatNumber value="${result.price}" pattern="#,###" />&nbsp;</td>
				<td style="width:15%"><c:out value="${result.coname}"/>&nbsp;</td>
				<td style="width:15%"><c:out value="${result.sellDate}"/>&nbsp;</td>
				<td style="width:8%"><a onclick="deletecheck(${result.sellCode})" style="cursor:pointer">삭제</a>&nbsp;</td>
   			</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	
	<!-- /List -->
	<div id="paging" style="text-align: center;">

		<ui:pagination paginationInfo = "${paginationInfo}"
				   type="image"
				   jsFunction="fn_egov_link_page"
				   />
		<form:hidden path="pageIndex" />
	</div>
	
	<!--  -->
	<hr/>
	<!--  -->
	<div id="dialog-form" title="판매정보등록">
		<p id="dateUpdate" class="validateTips" style="font-size: 15px;"></p>
		<form action="${pageContext.request.contextPath}/sellList/addSellList.do"  method="post">
		<fieldset>
			<input type="text" name="mbrId" id="mbrId" value="${loginInfo.mbrId}" hidden="hidden"/>
			<label for="name"><b>작물</b></label>
			<input id="userConame_insert" name="userConame" type="text"  disabled="disabled" value="미선택" style="width:100px; margin-top: 5px;"/>
			<b><a id="selectItem" type="button" onclick="selectItem_insert()" style="border:1px solid; background-color: lightgray;">작물선택</a></b>
			<input id="itemCode" name="itemCode" type="text" hidden="hidden"/><br>
			<label for="name"><b>일자</b></label>
			<input type="text" name="sellDate" id="datepicker3"/><br>
			<label for="name"><b>수량</b></label>
			<input type="text" name="sumamt" id="sumamt" class="text ui-widget-content ui-corner-all" style="width:85px;"/>
			<select id="sellUnitCode" name="sellUnitCode" class="combo">
					<option value="" >단위선택</option>
						<c:forEach var="code" items="${UnitList}">
							<option value="${code.codeNm}">${code.codeNm}</option>
						</c:forEach>
			</select> <br><br>
			<label for="name"><b>판 매 가</b></label>&nbsp;&nbsp;
			<input type="text" name="price" id="price" class="text ui-widget-content ui-corner-all" style="width:140px;"/><br>
			<label for="name"><b>도매법인</b></label>
			<input type="text" name="coname" id="coname" class="text ui-widget-content ui-corner-all" style="width:140px;"/>
			<a onclick="apiConame()" class="btn btn-default btn-sm" style="margin-left:60px;">거래처검색</a>
			<!-- Allow form submission with keyboard without duplicating the dialog button -->
			<hr style="margin:2px;">
		</fieldset>
		<input type="image" style="position:absolute; border:0px; margin-top: 10px;" src="<c:url value='/images/makeImage/button/insertBtn.png' />" width="60" height="40"/>
		</form>
	</div>
	<!--  -->
</div>
</form:form>
</body>
</html>
