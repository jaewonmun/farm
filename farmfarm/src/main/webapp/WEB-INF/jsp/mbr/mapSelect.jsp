<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>클릭 이벤트 등록하기</title>
<script>
	
</script>
</head>
<body>
<div id="map" style="width:100%;height:350px;"></div>
<p><em>마우스 휠로 화면 크기 조절하세요</em></p>
<p><em>원하는 위치를 클릭하세요</em></p>
 
<span>다음 좌표가 저장 됩니다</span><p id="result"></p>
<script type="text/javascript" src="https://apis.daum.net/maps/maps3.js?apikey=7fd11462e434594928ac9c7de1c06542&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(37.00249232825852, 127.8369092829465), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
        ,mapTypeId : daum.maps.MapTypeId.SKYVIEW 
    };
var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

var geocoder = new daum.maps.services.Geocoder();	//주소-좌표 변환 객체를 생성합니다

var address = opener.document.getElementById("zipcode").value;
console.log(address);
//주소로 좌표를 검색합니다
geocoder.addr2coord(address, function(status, result) {

 // 정상적으로 검색이 완료됐으면 
  if (status === daum.maps.services.Status.OK) {

     var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);

     // 결과값으로 받은 위치를 마커로 표시합니다
     var marker = new daum.maps.Marker({
         map: map,
         position: coords
     });

     // 인포윈도우로 장소에 대한 설명을 표시합니다
     var infowindow = new daum.maps.InfoWindow({
         content: '<div style="width:150px;text-align:center;padding:6px 0;">여기!</div>'
     });
     infowindow.open(map, marker);

     // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
     map.setCenter(coords);
 } 
});

// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
    
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng;
    var loc = latlng.getLat() + "," + latlng.getLng();
    var resultDiv = document.getElementById('result'); 
    resultDiv.innerHTML = loc;
    opener.document.getElementById("region").value = loc;
});
</script>
</body>
</html>