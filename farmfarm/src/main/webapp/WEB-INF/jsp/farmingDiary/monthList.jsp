<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="egovframework.rte.psl.dataaccess.util.EgovMap"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	java.util.Calendar cal = java.util.Calendar.getInstance();
	String sImgUrl = "/images/egovframework/com/cop/smt/sim/";
	String sCssUrl = "/css/egovframework/com/cop/smt/sim/";

	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");

	int year = cal.get(java.util.Calendar.YEAR);
	int month = cal.get(java.util.Calendar.MONTH);
	int date = cal.get(java.util.Calendar.DATE);

	if (strYear != null) {
		year = Integer.parseInt(strYear);
		month = Integer.parseInt(strMonth);
	} else {

	}
	//년도/월 셋팅
	cal.set(year, month, 1);

	int startDay = cal.getMinimum(java.util.Calendar.DATE);
	int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
	int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
	int newLine = 0;
	HashMap<String,String> weatherCode = new HashMap<String,String>();
	weatherCode.put("SKY_O00","38.png");
	weatherCode.put("SKY_O01","01.png");
	weatherCode.put("SKY_O02","02.png");
	weatherCode.put("SKY_O03","03.png");
	weatherCode.put("SKY_O04","12.png");
	weatherCode.put("SKY_O05","13.png");
	weatherCode.put("SKY_O06","14.png");
	weatherCode.put("SKY_O07","18.png");
	weatherCode.put("SKY_O08","12.png");
	weatherCode.put("SKY_O09","32.png");
	weatherCode.put("SKY_O10","04.png");
	weatherCode.put("SKY_O11","29.png");
	weatherCode.put("SKY_O12","26.png");
	weatherCode.put("SKY_O13","27.png");
	weatherCode.put("SKY_O14","28.png");
%>
<html lang="ko">
<HEAD>
<TITLE>월간일정관리</TITLE>
<meta charset="utf-8">
<style TYPE="text/css">
body {
	scrollbar-face-color: #F6F6F6;
	scrollbar-highlight-color: #bbbbbb;
	scrollbar-3dlight-color: #FFFFFF;
	scrollbar-shadow-color: #bbbbbb;
	scrollbar-darkshadow-color: #FFFFFF;
	scrollbar-track-color: #FFFFFF;
	scrollbar-arrow-color: #bbbbbb;
	margin-left: "0px";
	margin-right: "0px";
	margin-top: "0px";
	margin-bottom: "0px";
}
#btnDiv {margin:0 auto; width: 712px;}
#selectColor,#selectItem,#pointBtn {font-size: 12px; padding: 2px;}
#navDate { background-color: #F3F9D7; border: 1px solid #CED99C; width: 100%; }
td { font-family: "돋움"; font-size: 9pt; color: #595959; }
th { font-family: "돋움"; font-size: 9pt; color: #000000; }
select { font-family: "돋움"; font-size: 9pt; color: #595959; }
.divDotText { overflow: hidden; text-overflow: ellipsis; }
A:link { font-size: 9pt; font-family: "돋움"; color: #000000; text-decoration: none; }
A:visited { font-size: 9pt; font-family: "돋움"; color: #000000; text-decoration: none; }
A:active { font-size: 9pt; font-family: "돋움"; color: red; text-decoration: none; }
A:hover { font-size: 9pt; font-family: "돋움"; color: red; text-decoration: none; }

.boderTD { border:3px solid white; }
/* 날씨폼 영역 */
#weather {	width: 700px; margin: 0 auto; }
#todayWeather { height: 200px; }
#todayTable{ margin: 0 auto; }
#dayWt01_1,#dayWt01_2,#dayWt01_3 { padding: 3px; }
#dayWt01_1{ text-align: center; }
.dayWt01 { border: 1px solid lightgray; border-radius: 5px; height: 150px; }
#dayWt01_1 { border-right-style: none}
#dayWt01_2 { border-left-style: none; }
.dayImage { width:120px; height:120px; }
span, b { margin: 5px; line-height:2.0em; }
.weatherImgDay {width:25px; height:25px; position: absolute;}

</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
var dialog;
var dialog2;
var dialog3;
var dialog4;
$(function(){
	dialog = $("#dialog-form").dialog({
	    autoOpen: false,
	    height: 510,
	    width: 400,
	    modal: true
	});
	dialog2 = $("#dialog-insert_form").dialog({
	    autoOpen: false,
	    height: 400,
	    width: 430,
	    modal: true
	});
	
	dialog3 = $("#dialog-weather_form").dialog({
	    autoOpen: false,
	    height:500,
	    width: 500,
	    modal: true
	});
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
    dialog4 = $( "#dialog-image" ).dialog({
	      autoOpen: false,
	      show: {
	        effect: "fade",
	        duration: 700,
	      },
	      hide: {
	        effect: "fade",
	        duration: 700
	      }
	    });
});
function viewImage() {
	dialog4.dialog( "open" );
}
function selectDate(seq, date,subject,content,code,scode,image) {
	$("#farmingDiarySeq").val(seq);
	$("#dateUpdate").html(date);
	$("#datepicker1").val(date);
	$("#diarySubject").val(subject);
	$("#diarySubject").attr('autofocus','autofocus');
	$("#diaryContent").val(content);
	$("#itemCode").val(code);
	$("#userConame").val(scode);
	if(image != 'null') {
		$("#imageModalView").attr('src','${pageContext.request.contextPath}/images/makeImage/diaryImage/'+image);
		$("#diaryUploadFileTEMP").attr('value',image);
	}
	if(image == 'null') {
		$("#infoImage").html("등록된 사진이 없습니다.");
		$("#imageModalView").removeAttr('src');
	/* 	$("#imageModalView").removeAttr('height');
		$("#imageModalView").removeAttr('width'); */
	}
	dialog.dialog("open");
}
function insertForm(){
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
	$("#diarySubject_insert").attr('autofocus','autofocus');
	$("#datepicker2").val(paramDate);
	dialog2.dialog("open");
}
function jobSelect_insert(obj) {
	//console.log(obj.value);
	var subject = $("#diarySubject_insert").val();
	//console.log(subject);
	$("#diarySubject_insert").val(subject + " " + obj.value);
}
function jobSelect(obj) {
	//console.log(obj.value);
	var subject = $("#diarySubject").val();
	//console.log(subject);
	$("#diarySubject").val(subject + " " + obj.value);
}
function reset_insert(){
	$("#diarySubject_insert").val("");
}
function reset_update(){
	$("#diarySubject").val("");
}

function weatherForm(){
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
	//console.log(paramDate);
	weatherToday();
	$("#datepicker3").val(paramDate);
	$("#lowestTemp").attr('autofocus','autofocus');
	dialog3.dialog("open");
}
function selectItem() {
	window.open("${pageContext.request.contextPath}/crops/selectCropsList.do?searchCondition=0&searchKeyword=${loginInfo.mbrId}","regionOPen","width=200, height=250, left=10, top=5");
}
function selectItem_insert() {
	window.open("${pageContext.request.contextPath}/crops/selectCropsList_insert.do?searchCondition=0&searchKeyword=${loginInfo.mbrId}","regionOPen","width=200, height=250, left=10, top=5");
}
var codeSkyForFrom;
function weatherToday(){
	var lon = "128.7607121565847";		// 디폴트
	var lat = "35.8495347823333";		// 디폴트
	var loc = "<c:out value='${loginInfo.region}'/>";
	var locArray = loc.split(',');
	var id = "<c:out value='${loginInfo.mbrId}'/>";
	//console.log(id);
	//console.log(locArray);
	if(id != "") {
		lon = locArray[1];
		lat = locArray[0];
	}
	/* ------------------------------ 현재날씨 ajax 호출 ------------------------------------ */
	   
	var	todayURL = " http://apis.skplanetx.com/weather/current/hourly?";
		todayURL += "lon=" +lon;
		todayURL += "&lat="+ lat;
		todayURL += "&version=1";
	$.ajax({
		url: todayURL
		,headers : {appkey : 'ff308355-6d4f-3e6a-80c2-730c7ce5c669'}
		,type: 'get'
			,success: function(msg) {
				/* dom 따라서 변수에 저장 */
	/*주소*/	var address = msg.weather.hourly[0].grid.city + " "+ msg.weather.hourly[0].grid.county + " " +msg.weather.hourly[0].grid.village;
	/*시간*/	var time = msg.weather.hourly[0].timeRelease;
	/*기상*/	var skyName = msg.weather.hourly[0].sky.name;
	/*코드*/	var skyCode = msg.weather.hourly[0].sky.code;
	/*특보*/	var alertYn = msg.common.alertYn;
	/*태풍*/	var stormYn = msg.common.stormYn;
	/*최소*/	var tmin = msg.weather.hourly[0].temperature.tmin;
	/*최대*/	var tmax = msg.weather.hourly[0].temperature.tmax;
	/*현재*/	var tc = msg.weather.hourly[0].temperature.tc;
	/*풍향*/	var wdir = msg.weather.hourly[0].wind.wdir;
	/*풍속*/	var wspd = msg.weather.hourly[0].wind.wspd;
	/*강수*/	var type = msg.weather.hourly[0].precipitation.type;
/*누적강수*/	var raindrop = msg.weather.hourly[0].precipitation.sinceOntime;
				
				codeSkyForFrom = skyCode;
				/* html에 적용하기 */
				// 사진고르기
				var weatherImage = selectImage(skyCode);
				
				var typeDay = selectType(type);
				
				var weatherTitle = "<b style='color:#0099ff;' >현재날씨</b>&nbsp;";
				weatherTitle += "<b>주소</b><span>" + address + "</span>&nbsp;<br>";
				weatherTitle += "<b>발표</b><span>" + time + "</span>&nbsp;";
				weatherTitle += "<b>태풍</b><span>" + stormYn + "&nbsp;<b>특보</b><span>" + alertYn + "</span>";
				$("#weatherTitle").html(weatherTitle);
				
				var dayWt01_1  = "<image class='dayImage' src="+ weatherImage + "><br>";
					dayWt01_1 += "<b>현재온도</b><span style='color:red'><b> " + tc + "℃ </b></span>";
				$("#dayWt01_1").html(dayWt01_1);
				
				var dayWt01_2 = "<b>최소</b><span id='lowestTemp_api'>" + tmin + "</span>℃&nbsp;<b>최대</b><span id='highestTemp_api'>" + tmax + "</span>℃ <br>";
					dayWt01_2 += "<b>강수형태</b><span>" + typeDay +"</span> <br>";
					dayWt01_2 += "<b>강수량</b><span id='rainfall_api'>" + raindrop + "</span> <br>";
					dayWt01_2 += "<b>풍향</b><span><image src='../images/makeImage/weather/wind.png' style='width:25px; height:25px; transform: rotate(" + wdir + "deg);'></span>";
					dayWt01_2 += "<b>풍속</b><span>" + wspd +"m/s</span>";
				$("#dayWt01_2").html(dayWt01_2);

				

			}
	});
}
//기상코드에 따라서 알맞은 이미지를 찾아주는 함수 (현재날씨 api)
function selectImage(skyCode) {
	switch(skyCode) {
	case 'SKY_O00':
		return "'../images/makeImage/weatherSK/38.png'";
		break;
	case 'SKY_O01':
		return "'../images/makeImage/weatherSK/01.png'";
		break;
	case 'SKY_O02':
		return "'../images/makeImage/weatherSK/02.png'";
		break;
	case 'SKY_O03':
		return "'../images/makeImage/weatherSK/03.png'";
		break;
	case 'SKY_O04':
		return "'../images/makeImage/weatherSK/12.png'";
		break;
	case 'SKY_O05':
		return "'../images/makeImage/weatherSK/13.png'";
		break;
	case 'SKY_O06':
		return "'../images/makeImage/weatherSK/14.png'";
		break;
	case 'SKY_O07':
		return "'../images/makeImage/weatherSK/18.png'";
		break;
	case 'SKY_O08':
		return "'../images/makeImage/weatherSK/21.png'";
		break;
	case 'SKY_O09':
		return "'../images/makeImage/weatherSK/32.png'";
		break;
	case 'SKY_O10':
		return "'../images/makeImage/weatherSK/4.png'";
		break;
	case 'SKY_O11':
		return "'../images/makeImage/weatherSK/29.png'";
		break;
	case 'SKY_O12':
		return "'../images/makeImage/weatherSK/26.png'";
		break;
	case 'SKY_O13':
		return "'../images/makeImage/weatherSK/27.png'";
		break;
	case 'SKY_O14':
		return "'../images/makeImage/weatherSK/28.png'";
		break;
	}
}
function selectType(type) {
	switch(Number(type)) {
	case 0:
		return "현상없음";
		break;
	case 1:
		return "비";
		break;
	case 2:
		return "눈/비";
		break;
	case 3:
		return "눈";
		break;
	}
}
function weatherForm_insert() {
	$("#weatherStatus").val(codeSkyForFrom);
	$("#lowestTemp").val($("#lowestTemp_api").html());
	$("#highestTemp").val($("#highestTemp_api").html());
	$("#rainfall").val($("#rainfall_api").html());
}
function selectCode() {
	$("#weatherStatus").val($("#selectCD option:selected").val());
}
function deleteDiary() {
	if(confirm("삭제하시겠습니까?")) {
		location.href= "../farmingDiary/deleteFarmingDiary.do?farmingDiarySeq="+$("#farmingDiarySeq").val();
	}
}



</script>
</HEAD>
<BODY>
<c:if test="${loginInfo == null }">
		<jsp:forward page="/mbr/loginView.do" />
</c:if>
	<div id="btnDiv">
		<a onclick="insertForm()"><img src="<c:url value='/images/makeImage/logo/adddiary.png' />" width="175" height="65" style="cursor:pointer"></a>
		<a onclick="weatherForm()"><img src="<c:url value='/images/makeImage/logo/weatheradd.png' />" width="175" height="65" style="cursor:pointer"></a>
	</div>
	<form name="IndvdlSchdulManageVO" id="IndvdlSchdulManageVO" action="" method="post">
		<DIV id="content" style="width: 712px; margin: 0 auto;">
			<!--날짜 네비게이션  -->
			<table id="navDate">
				<tr>
					<td width="250"></td>
					<td width="110" align="center">
						<a href="<c:url value='/farmingDiary/monthList.do' />?year=<%=year - 1%>&amp;month=<%=month%>" target="_self">
							<img src="<c:url value='/images/egovframework/com/cmm/icon/icoPrev.gif' />" style="margin-right: 4px; border: 0px;" alt="이전으로가기아이콘표시">
						</a>
						<font size="3"><b><%=year%>년</b></font>
						<a href="<c:url value='/farmingDiary/monthList.do' />?year=<%=year + 1%>&amp;month=<%=month%>" target="_self">
							<img src="<c:url value='/images/egovframework/com/cmm/icon/icoNxt.gif' />" style="margin-left: 4px; border: 0px;" alt="다음으로가기아이콘표시">
						</a>
					</td>
					<td width="95" align="center">
						<%
							if (month > 0) {
						%>
						<a href="<c:url value='/farmingDiary/monthList.do' />?year=<%=year%>&amp;month=<%=month - 1%>" target="_self">
							<img src="<c:url value='/images/egovframework/com/cmm/icon/icoPrev.gif' />" style="margin-right: 4px; border: 0px;" alt="이전으로가기아이콘표시">
						</a>
						<%	}	%>
						<font size="3"><b><%=month + 1%>월</b></font>
						<% 	if (month < 11) {	%>
						<a href="<c:url value='/farmingDiary/monthList.do' />?year=<%=year%>&amp;month=<%=month + 1%>" target="_self">
							<img src="<c:url value='/images/egovframework/com/cmm/icon/icoNxt.gif' />" style="margin-left: 4px; border: 0px;" alt="다음으로가기아이콘표시">
						</a>
						<%	}	%>
					</td>
					<td></td>
				</tr>
			</table>
			<!-- 날짜 네이게이션 끝 -->
			<br>
			<table>
				<THEAD>
					<TR bgcolor="#CECECE">
						<TD width='100px' class='boderTD'><DIV align="center"><font color="red">일</font></DIV></TD>
						<TD width='100px' class='boderTD'><DIV align="center">월</DIV></TD>
						<TD width='100px' class='boderTD'><DIV align="center">화</DIV></TD>
						<TD width='100px' class='boderTD'><DIV align="center">수</DIV></TD>
						<TD width='100px' class='boderTD'><DIV align="center">목</DIV></TD>
						<TD width='100px' class='boderTD'><DIV align="center">금</DIV></TD>
						<TD width='100px' class='boderTD'><DIV align="center"><font color="#529dbc">토</font></DIV></TD>
					</TR>
				</THEAD>
				<TBODY>
					<TR>
						<%
							List listResult = (List) request.getAttribute("resultList");
							List listWeather = (List) request.getAttribute("resultWeather");
							//System.out.println(listWeather);
							//System.out.println(listResult);
							EgovMap egovMap = new EgovMap();
							EgovMap weatherMap = new EgovMap();
							//처음 빈공란 표시
							for (int index = 1; index < start; index++) {
								out.println("<TD >&nbsp;</TD>");
								newLine++;
							}

							for (int index = 1; index <= endDay; index++) {
								String color = "";

								if (newLine == 0) {
									color = "RED";
								} else if (newLine == 6) {
									color = "#529dbc";
								} else {
									color = "BLACK";
								}
								;

								String sUseDate = Integer.toString(year);

								sUseDate += Integer.toString(month + 1).length() == 1 ? "0"
										+ Integer.toString(month + 1) : Integer
										.toString(month + 1);
								sUseDate += Integer.toString(index).length() == 1 ? "0"
										+ Integer.toString(index) : Integer.toString(index);

								int iUseDate = Integer.parseInt(sUseDate);

								// 일일 td 태그 연다
								out.println("<TD class='boderTD' valign='top' align='left' height='92px' bgcolor='WhiteSmoke' nowrap>");
						%>
						<!-- 날짜 표시하는 부분 -->
						<span><font color='<%=color%>'><%=index%></font></span>	
						<%
						if (listWeather != null) {
							for (int i = 0; i < listWeather.size(); i++) {
								weatherMap = (EgovMap) listWeather.get(i);
								int iBeginDate = Integer.parseInt(((String) weatherMap.get("weatherDate")).substring(0, 8));
								//System.out.println(iUseDate);
								//System.out.println(iBeginDate);
								if (iUseDate == iBeginDate){
						%>
							<span><img class="weatherImgDay" src='../images/makeImage/weatherSK/<%=weatherCode.get(weatherMap.get("weatherStatus")) %>' /></span>
						<%
								}
							}
						}
							out.println("<BR>");
						if (listResult != null) {

							for (int i = 0; i < listResult.size(); i++) {
								egovMap = (EgovMap) listResult.get(i);
								//System.out.println(egovMap);
								int iBeginDate = Integer.parseInt(((String) egovMap.get("diaryDate")).substring(0, 8));
								//System.out.println(egovMap);
								//System.out.println(iUseDate);
								//System.out.println(iBeginDate);
								if (iUseDate == iBeginDate) {
						%>
						<table>
							<tr>
								<td nowrap>
									<div class='divDotText' style='width: 92px; border: solid 0px;'>
									 	<a id="date<%=egovMap.get("diaryDate")%>" 
									 	   onclick="selectDate(<%=egovMap.get("farmingDiarySeq")%>,<%=egovMap.get("diaryDate")%>,
									 	   					   '<%=egovMap.get("diarySubject")%>','<%=egovMap.get("diaryContent")%>',
									 	   					   <%=egovMap.get("itemCode")%>,'<%=egovMap.get("scode")%>',
									 	   					   '<%=egovMap.get("diaryUploadFileOriginal")%>')" 
									 	   target="_parent"><%=egovMap.get("diarySubject")%></a>
									</div>
								</td>
							</tr>
						</table>
						<%
								}
							}
						}

	out.println("</TD>");					// 일일 td 태그 닫음
	newLine++;

	if(newLine == 7)
	{
	  out.println("</TR>");
	  if(index <= endDay)
	  {
	    out.println("<TR>");
	  }
	  newLine=0;
	}
}
//마지막 공란 LOOP
while(newLine > 0 && newLine < 7)
{
  out.println("<TD>&nbsp;</TD>");
  newLine++;
}
%>
					</TR>
				</TBODY>
			</TABLE>
		</DIV>
	</form>
<!-- **************************************************** 여기서부터 수정/조회 모달 ******************************************************  -->	
	<div id="dialog-form" title="일지 조회 및 수정">
		<p id="dateUpdate" class="validateTips" style="font-size: 15px;"></p>
		<form action="${pageContext.request.contextPath}/farmingDiary/updateFarmingDiary.do"  method="post" enctype="multipart/form-data">
		<fieldset>
			<input type="text" name="farmingDiarySeq" id="farmingDiarySeq" hidden="hidden"/>
			<input type="text" name="mbrId" id="mbrId" value="${loginInfo.mbrId}" hidden="hidden"/>
			<label for="name"><b>작물</b></label>
			<input id="userConame" name="userConame" type="text"  disabled="disabled" value="미선택" style="width:100px; margin-top: 5px;"/>
			<b><a id="selectItem" type="button" onclick="selectItem()" style="border:1px solid; background-color: lightgray;">작물선택</a></b>
			<input id="itemCode" name="itemCode" type="text" hidden="hidden" style="width:100px;"/><br>
			<label for="name"><b>작업</b></label>
			<select id="jobSelect_update" onchange="jobSelect(this)">
				<option value="준비">준비
				<option value="로타리">로타리
				<option value="파종">파종
				<option value="전지">전지
				<option value="제초">제초
				<option value="농약">농약
				<option value="급수">급수
				<option value="수확">수확
				<option value="추수">추수
			</select><br>
			<label for="name"><b>일자</b></label>
			<input type="text" name="diaryDate" id="datepicker1"/><br>
			<label for="name"><b>제목</b></label>
			<input type="text" name="diarySubject" id="diarySubject" class="text ui-widget-content ui-corner-all" maxlength="12" >
			<i onclick="reset_update()">리셋</i><br>
			<label for="name"><b>내용</b></label>
			<textarea name="diaryContent" id="diaryContent" rows="5" cols="30"></textarea><br>
			<b>사진</b><span><input type="file" id="diaryUploadFileTEMP" name="diaryUploadFileTEMP"  style="border:0px; display: inline;" /></span>
			<br>
			<a id="opener" onclick="viewImage()">
				<img src="../images/makeImage/button/currentImage.png" width="140" height="50"/>
			</a>
			<div id="dialog-image" style="display:none" title="현장사진">
				<p id="infoImage"></p>
				<img id="imageModalView" class="picture" width="250" height="250"/>
			</div>
			<!-- Allow form submission with keyboard without duplicating the dialog button -->
		<hr>
		</fieldset>
		<input type="image" style="position:absolute; border:0px; margin-top: 10px;" src="<c:url value='/images/makeImage/button/updateBtn.png' />" width="60" height="40"/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a id="deleteBtn" onclick="deleteDiary()"><img style="position:absolute; margin-top: 10px;" src="<c:url value='/images/makeImage/button/deleteBtn.png' />" width="60" height="40"/></a>
		</form>
	</div>
<!-- **************************************************** 여기서부터 삽입 모달 ******************************************************  -->
	<div id="dialog-insert_form" title="일지 등록">
		<p id="dateUpdate" class="validateTips" style="font-size: 15px;"></p>
		<form action="${pageContext.request.contextPath}/farmingDiary/addFarmingDiary.do" method="post" enctype="multipart/form-data">
		<fieldset>
			<input id="itemCode_insert" name="itemCode" type="text" hidden="hidden" style="width:100px;"/>
			<input type="text" name="mbrId" id="mbrId" value="${loginInfo.mbrId}" hidden="hidden"/>
			<label for="name"><b>작물</b></label>
			<input id="userConame_insert" name="userConame" type="text"  disabled="disabled" value="미선택" style="width:100px; margin-top: 5px;"/>
			<b><a id="selectItem_insert" type="button" onclick="selectItem_insert()" style="border:1px solid; background-color: lightgray;">작물선택</a></b>
			<br><label for="name"><b>작업</b></label>
			<select id="jobSelect_insert_menu" onchange="jobSelect_insert(this)" required="required">
				<option value="준비">준비
				<option value="로타리">로타리
				<option value="파종">파종
				<option value="전지">전지
				<option value="제초">제초
				<option value="농약">농약
				<option value="급수">급수
				<option value="수확">수확
				<option value="추수">추수
			</select><br>
			<label for="name"><b>일자</b></label>
			<input type="text" name="diaryDate" id="datepicker2" required="required"/> <br/>
			<label for="name"><b>제목</b></label>
			<input type="text" name="diarySubject" readonly="readonly" id="diarySubject_insert" class="text ui-widget-content ui-corner-all" maxlength="12" required="required">
			<i onclick="reset_insert()">리셋</i><br>
			<label for="name"><b>내용</b></label>
			<textarea name="diaryContent" id="diaryContent_insert" rows="5" cols="30" required="required"></textarea><br>
			<label for="name"><b>사진</b></label>
			<span><input type="file" id="diaryUploadFileTEMP" name="diaryUploadFileTEMP"  style="border:0px; display: inline;"/></span>
			<!-- Allow form submission with keyboard without duplicating the dialog button -->
		</fieldset>
		<input type="image" style="position:absolute; border:0px; margin-top: 10px;" src="<c:url value='/images/makeImage/button/insertBtn.png' />" width="60" height="40"/>
		</form>
	</div>
<!-- **************************************************** 여기서부터 날씨 등록 모달 ******************************************************  -->	
	<div id="dialog-weather_form" title="날씨 정보 등록">
		<p class="validateTips" style="font-size: 15px;">조회는 오늘날씨만 가능합니다...</p>
		<div id="todayWeather" class="todayWt">
			<table id="todayTable">
				<caption id="weatherTitle">현재 날씨</caption>
				<colgroup>
					<col style="width: 30%;">
					<col style="width: 45%;">
					<col style="width: 25%;">
				</colgroup>
				<tbody>
					<tr>
						<td id="dayWt01_1" class="dayWt01"></td>
						<td id="dayWt01_2" class="dayWt01"></td>
						<td id="dayWt01_3" class="dayWt01">
							<a onclick="weatherForm_insert()"><img src="<c:url value='/images/makeImage/logo/diaryweather.png' />" width="100" height="100"></a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<form action="${pageContext.request.contextPath}/farmWeather/procedureWeather.do">
		<fieldset>
			<input type="text" name="mbrId" id="mbrId" value="${loginInfo.mbrId}" hidden="hidden"/>
			<label for="name"><b>일&nbsp;&nbsp;&nbsp;&nbsp;자</b></label>&nbsp;&nbsp;
			<input type="text" name="weatherDate" id="datepicker3" style="margin-left:2px;"/> <br>
			<label for="name"><b>기상상태</b></label>
			<input type="text" name="weatherStatus" id="weatherStatus" class="text ui-widget-content ui-corner-all" style="width:100px" readonly="readonly">
			<select id="selectCD" onchange="selectCode()" class="text ui-widget-content ui-corner-all" style="margin-top:4px;">
				<option value="SKY_O00">미입력
				<option value="SKY_O01">맑음
				<option value="SKY_O02">구름조금
				<option value="SKY_O03">구름많음
				<option value="SKY_O04">구름많고 비
				<option value="SKY_O05">구름많고 눈
				<option value="SKY_O06">구름많고 비/눈
				<option value="SKY_O07">흐림
				<option value="SKY_O08">흐리고 비
				<option value="SKY_O09">흐리고 눈
				<option value="SKY_O10">흐리고 비 또는 눈
				<option value="SKY_O11">흐리고 낙뢰
				<option value="SKY_O12">뇌우, 비
				<option value="SKY_O13">뇌우, 눈
				<option value="SKY_O14">뇌우, 비 또는 눈
			</select>
			<br>
			<label for="name"><b>최저기온</b></label>
			<input type="text" name="lowestTemp" id="lowestTemp" class="text ui-widget-content ui-corner-all" style="width:100px"><br>
			<label for="name"><b>최대기온</b></label>
			<input type="text" name="highestTemp" id="highestTemp" class="text ui-widget-content ui-corner-all" style="width:100px"><br>
			&nbsp;&nbsp;&nbsp;<label for="name"><b>강수량</b></label>
			<input type="text" name="rainfall" id="rainfall" class="text ui-widget-content ui-corner-all" value=0 style="width:100px"><br>
			<!-- Allow form submission with keyboard without duplicating the dialog button -->
		</fieldset>
		<input type="image" style="position:absolute;  border:0px; " src="<c:url value='/images/makeImage/button/insertBtn.png' />" width="60" height="40"/>
		</form>
	</div>
<!-- ************************************************************ 모달 끝  ******************************************************************  -->
</BODY>
</HTML>

