<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	/**
	 * @Description : 작물정보 삽입 화면
	 * @Modification Information
	 * 
	 * @author 문재원
	 * @since 20161205
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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<title>다음 지도 API</title>
<style>
.container { width: 800px;  max-width: none !important;}
.wrap_content {	overflow: hidden; height: 600px; margin: 0 auto; width: 700px;}
.wrap_map { display: inline-block; width: 400px; height: 500px;	position: relative}
.addForm { width: 290px; }
.area {	position: absolute;	background: #fff;	border: 1px solid #888;	border-radius: 3px;	font-size: 12px; top: -5px; left: 15px; padding: 2px; }
.info {	font-size: 12px; padding: 5px;}
.info .title {	font-weight: bold;}
#submit,#reset {font-size: 15px; padding: 3px;}
#selectColor,#selectItem,#pointBtn {font-size: 12px; padding: 2px;}
#point { height:120px; width:270px; border: 3px solid gray;}
#help {  height:120px; width:270px; border: 3px solid gray; }
input {margin: 5px;}
</style>
<script>
$(function(){
	$("#pointBtn").hide();
});

function selectItem() {
	window.open("${pageContext.request.contextPath}/item/ItemList.do","regionOPen","width=450, height=250, left=10, top=5");
}
function selectPoint() {
// 좌표값 삽입
	// 마지막좌표를 처음좌표와 같게 추가
	var latArr = $("#lat").html().split(',');
	var lngArr
	var latFirst = $("#lat").html().split(',');
	var lngFirst = $("#lng").html().split(',');
	// input태그에 넣기
	$("#latitude").attr("value",$("#lat").html() + "," + latFirst[0]); 
	$("#longitude").attr("value",$("#lng").html() + "," + lngFirst[0]);
	
	$("#submit").removeAttr('disabled');
}
</script>
</head>
<body>
<c:if test="${loginInfo == null }">
		<jsp:forward page="/mbr/loginView.do" />
</c:if>
	<div class="wrap_content row">
	<img src="<c:url value='/images/makeImage/logo/addcrops.png'/>"width="195" height="65"><br>
		<div class="wrap_map col-xs-6">
			<div id="map" style="width: 100%; height: 500px"></div>
			<!-- 지도를 표시할 div 입니다 -->
		</div>
		<div class="addForm col-xs-6">
			<form action="${pageContext.request.contextPath}/crops/addCrops.do" style="width:270px; border: 3px solid gray;" method="post" enctype="multipart/form-data">
			<input id="submit" type="submit" class="btn btn-info" value="등록" disabled="disabled"/><br>
				<input id="mbrId" name="mbrId" hidden="hidden" value="${loginInfo.mbrId}"/>
				<a id="selectItem" class="btn btn-default" onclick="selectItem()">작물선택</a>
				<input id="userConame" name="itemCode" type="text" disabled="disabled" style="width:100px;"/>
				<input id="itemCode" name="itemCode" type="text" hidden="hidden" style="width:100px;"/><br>
				선색 <input id="strokeColor" name="strokeColor" type="color" value="#ffe699" style="width:100px;"/> <br>
				<input type="file" id="uploadImage" name="uploadImageTEMP" style="border:0px;"/>
				<input type="text" id="latitude" name="latitude" readonly="readonly" placeholder="위도"/><br>
				<input type="text" id="longitude" name="longitude" readonly="readonly" placeholder="경도"/><br>
			</form>
			<a id="pointBtn" class="btn btn-danger" onclick="selectPoint()">좌표확정</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a id="reset" href="${pageContext.request.contextPath}/crops/addFarmMap.do" ><img src="<c:url value='/images/makeImage/button/resetBtn.png' />" width="60" height="40" /></a><br>
			<div id="point" style="overflow: scroll;">
				<b id='cnt'></b><br>
				<span id='lat'></span><br>
				<span id='lng'></span>
			</div>
			<hr style="margin:2px;">
			<div id="help">
				<p>좌클릭 = 좌표지정</p>
				<p>우클릭 = 그리기 종료</p>
				<p>좌표확정 버튼 클릭시 확정됩니다.</p>
				<p>잘못그렸을 경우는 초기화 클릭</p>
			</div>
		</div>
	</div>

	<script src="//apis.daum.net/maps/maps3.js?apikey=3ee04f6840ac4e5c9329a6b8b9dcd55d"></script>
	<script>

		var loc = "<c:out value='${loginInfo.region}'/>";
		var locArray = loc.split(',');
		var id = "<c:out value='${loginInfo.mbrId}'/>";
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapCenter = new daum.maps.LatLng(locArray[0], locArray[1])
		mapOption = {
			center : mapCenter, // 지도의 중심좌표
			level : 2, // 지도의 확대 레벨
			mapTypeId : daum.maps.MapTypeId.SKYVIEW // 지도종류
		};

		// 지도를 생성한다 
		var map = new daum.maps.Map(mapContainer, mapOption);
		customOverlay = new daum.maps.CustomOverlay({}),
				infowindow = new daum.maps.InfoWindow({
					removable : true
				});
		
		
		
		$.ajax({
			 url: "../crops/selectCropsMap.do?searchCondition=0&searchKeyword=" + id			// 넘길 주소(위치)
		 }).done(function(res) {
			 if(res.length != 0){
				var latitudeArraay = new Array();
				var longitudeArraay = new Array();
				var fillColor; 
				var area = [];
				var path2 = [];
				if(res.length != 0){						// 입력한 정보가 없으면 이부분은 그냥 넘어감
					for(var i=0; i< res.length; i++) {
						latitudeArraay = res[i].latitude.split(',');
						longitudeArraay = res[i].longitude.split(',');	
						var path = [];
						for(var j=0; j<latitudeArraay.length; j++ ) {
							path.push(new daum.maps.LatLng(latitudeArraay[j],longitudeArraay[j]));
							path2.push(new daum.maps.LatLng(latitudeArraay[j],longitudeArraay[j]));
						}
						area.push({ 'name':res[i].scode, 'path':path ,'strokeColor':res[i].strokeColor });
						displayArea(area[i]);
					}
				}
				//지도를 중심 좌표에 고정 시키기 위한 것
				// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
				var bounds = new daum.maps.LatLngBounds();    
				for (var i = 0; i < path2.length; i++) {
				    // LatLngBounds 객체에 좌표를 추가합니다
				    bounds.extend(path2[i]);
				}
					//바운드리에 해당하는 좌표로 지도를 화면에 표시
				   map.setBounds(bounds);
				 }
		}); //end of ajax 맵에 작물별 구역 설정	
			//폴리곤 이벤트 등록
	  
		//다각형을 생성하고 이벤트를 등록하는 함수입니다
		function displayArea(area) {
			// 다각형을 생성합니다 
			var polygon = new daum.maps.Polygon({
				map : map, // 다각형을 표시할 지도 객체
				path : area.path,							//
				strokeWeight : 2,
				strokeColor : area.strokeColor,					//
				strokeOpacity : 0.8,
				fillColor : '#fff',					//
				fillOpacity : 0.7,
				strokestyle : area.strokestyle
			});
		}
		 
		var drawingFlag = false; // 다각형이 그려지고 있는 상태를 가지고 있을 변수입니다
		var drawingPolygon; // 그려지고 있는 다각형을 표시할 다각형 객체입니다
		var polygon; // 그리기가 종료됐을 때 지도에 표시할 다각형 객체입니다
		var areaOverlay; // 다각형의 면적정보를 표시할 커스텀오버레이 입니다

		// 마우스 클릭 이벤트가 발생하고나면 drawingFlag가 그려지고 있는 상태인 ture 값으로 바뀝니다
		// 그려지고 있는 상태인 경우 drawingPolygon 으로 그려지고 있는 다각형을 지도에 표시합니다
		// 마우스 오른쪽 클릭 이벤트가 발생하면 drawingFlag가 그리기가 종료된 상태인 false 값으로 바뀌고
		// polygon 으로 다 그려진 다각형을 지도에 표시합니다


		// 지도에 마우스 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 다각형 그리기가 시작됩니다 그려진 다각형이 있으면 지우고 다시 그립니다
		var countPoint = 0; // 점몇개 찍었는지 전역변수로 저장
		daum.maps.event.addListener(map, 'click', function(mouseEvent) {

		    // 마우스로 클릭한 위치입니다 
		    var clickPosition = mouseEvent.latLng; 
/*-------------------------- 작성 부분 ------------------------------------*/
	
			countPoint++;
			var cnt = countPoint + "번째";
			$("#cnt").html(cnt);
			if(countPoint == 1){
				var cnt = countPoint + "번째";
				var lat = clickPosition.hb;
				var lng = clickPosition.gb;
				$("#cnt").html(cnt);
				$("#lat").html(lat);
				$("#lng").html(lng);
			}
			else if(countPoint > 1) {
				var lat = $("#lat").html() + "," + clickPosition.hb;
				var lng = $("#lng").html() + "," + clickPosition.gb;
				$("#lat").html(lat);
				$("#lng").html(lng);
			}
		    if(countPoint == 3){
		    	$("#pointBtn").show();
		    }
		    
/*-------------------------------------------------------------------------*/
		    // 지도 클릭이벤트가 발생했는데 다각형이 그려지고 있는 상태가 아니면
		    if (!drawingFlag) {

		        // 상태를 true로, 다각형을 그리고 있는 상태로 변경합니다
		        drawingFlag = true;
		        
		        // 지도 위에 다각형이 표시되고 있다면 지도에서 제거합니다
		        if (polygon) {  
		            polygon.setMap(null);      
		            polygon = null;  
		            $("#cnt").html("");
					$("#lat").html("");
					$("#lng").html("");
					countPoint = 0;
		        }
		        
		        // 지도 위에 면적정보 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
		        if (areaOverlay) {
		            areaOverlay.setMap(null);
		            areaOverlay = null;
		        }
		    
		        // 그려지고 있는 다각형을 표시할 다각형을 생성하고 지도에 표시합니다
		        drawingPolygon = new daum.maps.Polygon({
		            map: map, // 다각형을 표시할 지도입니다
		            path: [clickPosition], // 다각형을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
		            strokeWeight: 3, // 선의 두께입니다 
		            strokeColor: '#00a0e9', // 선의 색깔입니다
		            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
		            strokeStyle: 'solid', // 선의 스타일입니다
		            fillColor: '#00a0e9', // 채우기 색깔입니다
		            fillOpacity: 0.2 // 채우기 불투명도입니다
		        }); 
		        
		        // 그리기가 종료됐을때 지도에 표시할 다각형을 생성합니다 
		        polygon = new daum.maps.Polygon({ 
		            path: [clickPosition], // 다각형을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다 
		            strokeWeight: 3, // 선의 두께입니다 
		            strokeColor: '#00a0e9', // 선의 색깔입니다   
		            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
		            strokeStyle: 'solid', // 선의 스타일입니다
		            fillColor: '#00a0e9', // 채우기 색깔입니다
		            fillOpacity: 0.2 // 채우기 불투명도입니다
		        });

		        
		    } else { // 다각형이 그려지고 있는 상태이면 
		        
		        // 그려지고 있는 다각형의 좌표에 클릭위치를 추가합니다
		        // 다각형의 좌표 배열을 얻어옵니다
		        var drawingPath = drawingPolygon.getPath();
		    
		        // 좌표 배열에 클릭한 위치를 추가하고
		        drawingPath.push(clickPosition);
		        
		        // 다시 다각형 좌표 배열을 설정합니다
		        drawingPolygon.setPath(drawingPath);
		         
		    
		        // 그리기가 종료됐을때 지도에 표시할 다각형의 좌표에 클릭 위치를 추가합니다
		        // 다각형의 좌표 배열을 얻어옵니다
		        var path = polygon.getPath();
		    
		        // 좌표 배열에 클릭한 위치를 추가하고
		        path.push(clickPosition);
		        
		        // 다시 다각형 좌표 배열을 설정합니다
		        polygon.setPath(path);
		    }

		});

		// 지도에 마우스무브 이벤트를 등록합니다
		// 다각형을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 다각형의 위치를 동적으로 보여주도록 합니다
		daum.maps.event.addListener(map, 'mousemove', function (mouseEvent) {

		    // 지도 마우스무브 이벤트가 발생했는데 다각형을 그리고있는 상태이면
		    if (drawingFlag){

		        // 마우스 커서의 현재 위치를 얻어옵니다 
		        var mousePosition = mouseEvent.latLng; 
		        
		        // 그려지고있는 다각형의 좌표배열을 얻어옵니다
		        var path = drawingPolygon.getPath();
		        
		        // 마우스무브로 추가된 마지막 좌표를 제거합니다
		        if (path.length > 1) {
		            path.pop();
		        } 
		        
		        // 마우스의 커서 위치를 좌표 배열에 추가합니다
		        path.push(mousePosition);

		        // 그려지고 있는 다각형의 좌표를 다시 설정합니다
		        drawingPolygon.setPath(path);
		    }             
		});     

		// 지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
		// 다각형을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 그리기를 종료합니다
		daum.maps.event.addListener(map, 'rightclick', function (mouseEvent) {

		    // 지도 오른쪽 클릭 이벤트가 발생했는데 다각형을 그리고있는 상태이면
		    if (drawingFlag) {
		        
		        // 그려지고있는 다각형을  지도에서 제거합니다
		        drawingPolygon.setMap(null);
		        drawingPolygon = null;  
		        
		        // 클릭된 죄표로 그릴 다각형의 좌표배열을 얻어옵니다
		        var path = polygon.getPath();
		    
		        // 다각형을 구성하는 좌표의 개수가 3개 이상이면 
		        if (path.length > 2) {  
		            // 지도에 다각형을 표시합니다
		            polygon.setMap(map);         
		        } else { 	            
		            // 다각형을 구성하는 좌표가 2개 이하이면 다각형을 지도에 표시하지 않습니다 
		            polygon = null;  
		        }      
		        // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
		        drawingFlag = false;          
		    }  

		}); 
	</script>
</body>
</html>
