<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<title>Insert title here</title>
<style>
      #mapDiv { width : 700px; margin: 0 auto; }
      #map {
       	width : 700px;
       	height: 400px;
      }
    </style>
</head>
<body>
	<div id="mapDiv">
		<b>한반도의 구름, 태풍등의 상황을 레이더 사진으로 조회 합니다.</b><br>
		<b>현재 시간의 레이더 자료가 없을경우 아무것도 표시되지 않을 수 있습니다.</b>
		<p id="timeCurrent"></p>
		<div id="map"></div>
	</div>
	<script>
		
		var urlKMLFile;
		var fileName;
		
		var today = new Date();
		today.setTime(new Date().getTime() - (2 * 60 * 60 * 1000));
		var year = today.getFullYear();
		var month = today.getMonth()+1;
		var day = today.getDate();
		var hours = today.getHours();
		var minutes = today.getMinutes();
		if(day < 10) {
			day = "0"+day;
		}
		if(hours < 10) {
			hours = "0"+hours;
		}
		var hours1 = Number(hours) + 1
		var paramDate = year+""+month+""+day+""+hours+"00";						// 현재시간 -2시간 정각
		var paramDate2 = year+""+month+""+day+""+hours1+"00";				// 현재시간 -1시간 정각
		var urlKML = "http://apis.skplanetx.com/weather/wmap/radar?"
			urlKML +="isTimeRange=Y&start="+ paramDate;
			urlKML +="&end="+paramDate2 +"&version=1";
		function initMap() {
			
			// KML 파일 받아옴
	 		$.ajax({		
				url: urlKML
				,headers : {appkey : 'ff308355-6d4f-3e6a-80c2-730c7ce5c669'}
				,type: 'get'
				,async: false
				,success: function(msg) {
					console.log(msg);
					urlKMLFile = msg.weather.radar[0].filePath;					// 레이더 영상 파일 경로 가져옴
					fileName = msg.weather.radar[0].fileName;					// 레이더 영상 파일 이름 가져옴
					var timeCurrent = msg.weather.radar[0].timeObservation;	// 레이더 사진 찍은 시간 출력 
					$("#timeCurrent").html("촬영시간 : " + timeCurrent);					
				}
			}); 
			// 구글 지도 생성
			var map = new google.maps.Map(document.getElementById('map'), {
				center : {
					lat : 36.55,
					lng : 127.95
				},
				// Set mapTypeId to SATELLITE in order
				// to activate satellite imagery.
				mapTypeId : 'satellite',
				scrollwheel : true,
				zoom : 7
			});
			// KML 파일 구글맵에 반영
			
			var georssLayer = new google.maps.KmlLayer({
			    url: urlKMLFile
			  });
			  georssLayer.setMap(map);
		}
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD0moAs1609Oa5xoBwE-p4KwhkUJRKmfOI&callback=initMap"
		async defer></script>
</body>
</html>