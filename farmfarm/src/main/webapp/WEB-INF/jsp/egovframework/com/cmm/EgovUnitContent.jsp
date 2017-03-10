<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


<style>
.overlaybox {
	position: relative;
	width: 360px;
	height: 350px;
	background:
		url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png')
		no-repeat;
	padding: 15px 10px;
}

.overlaybox div, ul {
	overflow: hidden;
	margin: 0;
	padding: 0;
}

.overlaybox li {
	list-style: none;
}

.overlaybox .boxtitle {
	color: #fff;
	font-size: 16px;
	font-weight: bold;
	background:
		url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png')
		no-repeat right 120px center;
	margin-bottom: 8px;
}


.overlaybox .first {
	position: relative;
	width: 247px;
	height: 136px;
	background:
		url("<c:url value='/images/makeImage/mainPageImg/site1.jpg'/>")
		no-repeat;
	margin-bottom: 8px;
}

.first .text {
	color: 	#0099ff;
	font-weight: bold;
}


.overlaybox ul {
	width: 247px;
}

.overlaybox li {
	position: relative;
	margin-bottom: 2px;
	background: #2b2d36;
	padding: 5px 10px;
	color: #aaabaf;
	line-height: 1;
}

.overlaybox li span {
	display: inline-block;
}

.overlaybox li .number {
	font-size: 16px;
	font-weight: bold;
}

.overlaybox li .title {
	font-size: 13px;
}

.overlaybox ul .arrow {
	position: absolute;
	margin-top: 8px;
	right: 25px;
	width: 5px;
	height: 3px;
	background:
		url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/updown.png')
		no-repeat;
}

.overlaybox li .up {
	background-position: 0 -40px;
}

.overlaybox li .down {
	background-position: 0 -60px;
}

.overlaybox li .count {
	position: absolute;
	margin-top: 5px;
	right: 15px;
	font-size: 10px;
}

.overlaybox li:hover {
	color: #fff;
	background: #d24545;
}

.overlaybox li:hover .up {
	background-position: 0 0px;
}

.overlaybox li:hover .down {
	background-position: 0 -20px;
}
</style>

<style>
label, input {
	display: block;
}

input.text {
	margin-bottom: 12px;
	width: 95%;
	padding: .4em;
}

fieldset {
	padding: 0;
	border: 0;
	margin-top: 25px;
}

h1 {
	font-size: 1.2em;
	margin: .6em 0;
}

div#users-contain {
	width: 350px;
	margin: 20px 0;
}

div#users-contain table {
	margin: 1em 0;
	border-collapse: collapse;
	width: 100%;
}

div#users-contain table td, div#users-contain table th {
	border: 1px solid #eee;
	padding: .6em 10px;
	text-align: left;
}

.ui-dialog .ui-state-error {
	padding: .3em;
}

.validateTips {
	border: 1px solid transparent;
	padding: 0.3em;
}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		var dialog, form,

		// From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
		emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/, name = $("#name"), email = $("#email"), password = $("#password"), allFields = $(
				[]).add(name).add(email).add(password), tips = $(".validateTips");

		function updateTips(t) {
			tips.text(t).addClass("ui-state-highlight");
			setTimeout(function() {
				tips.removeClass("ui-state-highlight", 1500);
			}, 500);
		}

		function checkLength(o, n, min, max) {
			if (o.val().length > max || o.val().length < min) {
				o.addClass("ui-state-error");
				updateTips("Length of " + n + " must be between " + min
						+ " and " + max + ".");
				return false;
			} else {
				return true;
			}
		}

		function checkRegexp(o, regexp, n) {
			if (!(regexp.test(o.val()))) {
				o.addClass("ui-state-error");
				updateTips(n);
				return false;
			} else {
				return true;
			}
		}

		function addUser() {
			var valid = true;
			allFields.removeClass("ui-state-error");

			valid = valid && checkLength(name, "username", 3, 16);
			valid = valid && checkLength(email, "email", 6, 80);
			valid = valid && checkLength(password, "password", 5, 16);

			valid = valid
					&& checkRegexp(
							name,
							/^[a-z]([0-9a-z_\s])+$/i,
							"Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter.");
			valid = valid
					&& checkRegexp(email, emailRegex, "eg. ui@jquery.com");
			valid = valid
					&& checkRegexp(password, /^([0-9a-zA-Z])+$/,
							"Password field only allow : a-z 0-9");

			if (valid) {
				$("#users tbody").append(
						"<tr>" + "<td>" + name.val() + "</td>" + "<td>"
								+ email.val() + "</td>" + "<td>"
								+ password.val() + "</td>" + "</tr>");
				dialog.dialog("close");
			}
			return valid;
		}

		dialog = $("#dialog-form").dialog({
			autoOpen : false,
			height : 400,
			width : 350,
			modal : true,
			buttons : {
				"닫기" : function() {
					dialog.dialog("close");
				}
			},
			close : function() {
				form[0].reset();
				allFields.removeClass("ui-state-error");
			}
		});

		form = dialog.find("form").on("submit", function(event) {
			event.preventDefault();
			addUser();
		});

		$("#region-info").button().on("click", function() {
			dialog.dialog("open");
			getInfo();

		});
	});
</script>
<!-- <script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=3ee04f6840ac4e5c9329a6b8b9dcd55d"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=3ee04f6840ac4e5c9329a6b8b9dcd55d&libraries=LIBRARY"></script>
services 라이브러리 불러오기
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=3ee04f6840ac4e5c9329a6b8b9dcd55d&libraries=services"></script>
services와 clusterer, drawing 라이브러리 불러오기
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=3ee04f6840ac4e5c9329a6b8b9dcd55d&libraries=services,clusterer,drawing"></script> -->
<!--  
 	김형철 - 3ee04f6840ac4e5c9329a6b8b9dcd55d   
	문재원 - 7fd11462e434594928ac9c7de1c06542
	박석현 - 97bee5060eb8bb0032557b9d342c6098
 -->

<script>
	var loc = "<c:out value='${loginInfo.region}'/>";
	var locArray = loc.split(',');
</script>

</head>
<body>
	<c:if test="${loginInfo == null }">
		<jsp:forward page="/mbr/loginView.do" />
	</c:if>
	<br />
	<button id="region-info">지도 정보 상세 보기</button>
	<div class="map_wrap">
		<div id="map"
			style="width: 100%; height: 500px; position: relative; overflow: hidden;"></div>
		
	</div>


	<!-- <p><button onclick="getInfo()">지도 정보 보기</button> <br></p>
<p id="infoDiv"></p> -->

	<script type="text/javascript"
		src="https://apis.daum.net/maps/maps3.js?apikey=7fd11462e434594928ac9c7de1c06542&libraries=services"></script>
	<!--  
 	김형철 - 3ee04f6840ac4e5c9329a6b8b9dcd55d   
	문재원 - 7fd11462e434594928ac9c7de1c06542
	박석현 - 97bee5060eb8bb0032557b9d342c6098
 -->
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(locArray[0], locArray[1]), // 지도의 중심좌표
			level : 2,
			mapTypeId : daum.maps.MapTypeId.SKYVIEW
		// 지도의 확대 레벨
		};

		var map = new daum.maps.Map(mapContainer, mapOption);
		customOverlay = new daum.maps.CustomOverlay({}),
				infowindow = new daum.maps.InfoWindow({
					removable : true
				});
		// 마우스 드래그와 모바일 터치를 이용한 지도 이동을 막는다
		//map.setDraggable(false);		

		// 마우스 휠과 모바일 터치를 이용한 지도 확대, 축소를 막는다
		//map.setZoomable(false);
		
		
		
		
		//커스텀 오버레이에 표시할 내용입니다     
		//HTML 문자열 또는 Dom Element 입니다 
		var content = '<div class="overlaybox">'
				+ '    <a href="${pageContext.request.contextPath}/farmdicpop/FarmDicpop.do" target="_content" class="link"><div class="boxtitle">탐스러운 밭 상세정보</div></a>'
				+ '    <div class="first">'
				+ '    </div>' + '    <ul>' + '        <li class="up">'
				+ '            <span class="title">이팝나무</span>'
				+ '            <span class="count">10개</span>' + '        </li>'
				+ '    </ul>' + '</div>';

		//커스텀 오버레이가 표시될 위치입니다 
		var loc = "<c:out value='${loginInfo.region}'/>";
		var locArray = loc.split(',');
		var position = new daum.maps.LatLng(locArray[0], locArray[1]);

		//커스텀 오버레이를 생성합니다
		var customOverlay = new daum.maps.CustomOverlay({
			position : position,
			content : content,
			xAnchor : 1,
			yAnchor : 1
		});

		//커스텀 오버레이를 지도에 표시합니다
		customOverlay.setMap(map);
		//주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();

		var marker = new daum.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		infowindow = new daum.maps.InfoWindow({
			zindex : 1
		}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

		//현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);

		//지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		daum.maps.event
				.addListener(
						map,
						'click',
						function(mouseEvent) {
							searchDetailAddrFromCoords(
									mouseEvent.latLng,
									function(status, result) {
										if (status === daum.maps.services.Status.OK) {
											var detailAddr = !!result[0].roadAddress.name ? '<div>도로명주소 : '
													+ result[0].roadAddress.name
													+ '</div>'
													: '';
											detailAddr += '<div>지번 주소 : '
													+ result[0].jibunAddress.name
													+ '</div>';

											var content = '<div class="bAddr">'
													+ '<span class="title">법정동 주소정보</span>'
													+ detailAddr + '</div>';

											// 마커를 클릭한 위치에 표시합니다 
											marker
													.setPosition(mouseEvent.latLng);
											marker.setMap(map);

											// 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
											infowindow.setContent(content);
											infowindow.open(map, marker);
										}
									});
						});

		//중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		daum.maps.event.addListener(map, 'idle', function() {
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		});

		function searchAddrFromCoords(coords, callback) {
			// 좌표로 행정동 주소 정보를 요청합니다
			geocoder.coord2addr(coords, callback);
		}

		function searchDetailAddrFromCoords(coords, callback) {
			// 좌표로 법정동 상세 주소 정보를 요청합니다
			geocoder.coord2detailaddr(coords, callback);
		}

		//지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(status, result) {
			if (status === daum.maps.services.Status.OK) {
				/* var infoDiv = document.getElementById('centerAddr'); */
				var infoDiv = document.getElementById('address');
				infoDiv.innerHTML = result[0].fullName;
			}
		}

/* 		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new daum.maps.MapTypeControl();

		// 지도 타입 컨트롤을 지도에 표시합니다
		map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT); */

		function getInfo() {
			// 지도의 현재 중심좌표를 얻어옵니다 
			var center = map.getCenter();

			// 지도의 현재 레벨을 얻어옵니다
			var level = map.getLevel();

			// 지도타입을 얻어옵니다
			var mapTypeId = map.getMapTypeId();

			// 지도의 현재 영역을 얻어옵니다 
			var bounds = map.getBounds();

			// 영역의 남서쪽 좌표를 얻어옵니다 
			var swLatLng = bounds.getSouthWest();

			// 영역의 북동쪽 좌표를 얻어옵니다 
			var neLatLng = bounds.getNorthEast();

			// 영역정보를 문자열로 얻어옵니다. ((남,서), (북,동)) 형식입니다
			var boundsStr = bounds.toString();

			var message = '위도 ' + center.getLat() + ', <br>';
			message += '경도 ' + center.getLng() + ' <br>';
			message += '지도 레벨 ' + level + ' <br> <br>';
			message += '지도 타입 ' + mapTypeId + ' <br> ';

			var infoDiv = document.getElementById('infoDiv');
			infoDiv.innerHTML = message;
		}

		$(function() {
			var center = map.getCenter();
			$("#address").text(center.getLat());
		});

		$(function() {
			var center = map.getCenter();
			$("#loadaddress").text(center.getLat());
		});

		$(function() {
			var center = map.getCenter();
			$("#lati").text(center.getLat());
		});

		$(function() {
			var center = map.getCenter();
			$("#long").text(center.getLng());
		});
	</script>


	<div id="dialog-form" title="지도 정보 보기">
		<p class="validateTips">상세 지도 정보 보기</p>

		<form>
			<fieldset>
				<label for="name">지도 정보 보기</label> <span id="centerAddr"></span>
				<p id="infoDiv"></p>



				<!-- Allow form submission with keyboard without duplicating the dialog button -->
				<input type="submit" tabindex="-1"
					style="position: absolute; top: -1000px">
			</fieldset>
		</form>
	</div>


	<div id="users-contain" class="ui-widget">
		<h1>지도 정보</h1>
		<table id="users" class="ui-widget ui-widget-content">
			<thead>
				<tr class="ui-widget-header ">
					<th>주소</th>
					<th>도로명주소</th>
					<th>경도</th>
					<th>위도</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><span id="address"></span></td>
					<td><span id="loadaddress"></span></td>

					<!-- <td><span id="centerAddr"></span></td> -->
					<td><span id="lati"></span></td>
					<td><span id="long"></span></td>
				</tr>
			</tbody>
		</table>
	</div>









</body>
</html>