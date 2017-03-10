<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	/**
	 * @Class Name : farmMap.jsp
	 * @Description : farmMap 화면
	 * @Modification Information
	 * 
	 * @author 김형철
	 * @since 20161123
	 * @version 1.0
	 * @see
	 * @수정 문재원
	 * @일자 20161206
	 * @내용 해당작물의 일지 내용 및 사진 조회
	 * Copyright (C) All right reserved.
	 */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="../js/slider/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="../js/slider/jssor.slider-22.0.6.mini.js"type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>다음 지도 API</title>
<style>
.container {	width: 1000px;	max-width: none !important;}
.wrap_content {	overflow: hidden;}
.wrap_map {	display: inline-block;	position: relative;}
.area {	position: absolute;	background: #fff;	border: 1px solid #888;	border-radius: 3px;
	font-size: 12px;	top: -5px;	left: 15px;	padding: 2px;}
.info {	font-size: 12px;	padding: 5px;}
.info .title {	font-weight: bold;}
.picture {	position: relative;	width: 250px;	height: 180px;}
.fmddate { border:1px solid Gainsboro; width:70px; text-align: center;}
.fmdtitle { border:1px solid Gainsboro; width:130px; text-align: left;}
</style>
<style>
    /* jssor slider arrow navigator skin 05 css */
    /*
    .jssora05l                  (normal)
    .jssora05r                  (normal)
    .jssora05l:hover            (normal mouseover)
    .jssora05r:hover            (normal mouseover)
    .jssora05l.jssora05ldn      (mousedown)
    .jssora05r.jssora05rdn      (mousedown)
    .jssora05l.jssora05lds      (disabled)
    .jssora05r.jssora05rds      (disabled)
    */
    .jssora05l, .jssora05r {
        display: block;
        position: absolute;
        /* size of arrow element */
        width: 40px;
        height: 40px;
        cursor: pointer;
        background: url('../images/slider/a17.png') no-repeat;
        overflow: hidden;
    }
    .jssora05l { background-position: -10px -40px; }
    .jssora05r { background-position: -70px -40px; }
    .jssora05l:hover { background-position: -130px -40px; }
    .jssora05r:hover { background-position: -190px -40px; }
    .jssora05l.jssora05ldn { background-position: -250px -40px; }
    .jssora05r.jssora05rdn { background-position: -310px -40px; }
    .jssora05l.jssora05lds { background-position: -10px -40px; opacity: .3; pointer-events: none; }
    .jssora05r.jssora05rds { background-position: -70px -40px; opacity: .3; pointer-events: none; }
    /* jssor slider thumbnail navigator skin 01 css *//*
    .jssort01 .p            (normal).jssort01 .p:hover      (normal mouseover).jssort01 .p.pav        (active).jssort01 .p.pdn        (mousedown)*/
    .jssort01 .p {    position: absolute;    top: 0;    left: 0;    width: 72px;    height: 72px;}
    .jssort01 .t {    position: absolute;    top: 0;    left: 0;    width: 100%;    height: 100%;    border: none;}
    .jssort01 .w {    position: absolute;    top: 0px;    left: 0px;    width: 100%;    height: 100%;}
    .jssort01 .c {    position: absolute;    top: 0px;    left: 0px;    width: 68px;    height: 68px;  
				      border: #000 2px solid;    box-sizing: content-box; 
				      background: url('../images/slider/t01.png') -800px -800px no-repeat;
				     _background: none;}
     .jssort01 .pav .c {  top: 2px;    _top: 0px;    left: 2px;    _left: 0px;    width: 68px;    height: 68px;   
    					  border: #000 0px solid;    _border: #fff 2px solid;    background-position: 50% 50%;}
     .jssort01 .p:hover .c { top: 0px;    left: 0px;    width: 70px;    height: 70px;    border: #fff 1px solid;
      						 background-position: 50% 50%;}
     .jssort01 .p.pdn .c {    background-position: 50% 50%;    width: 68px;    height: 68px;    border: #000 2px solid;}
     * html .jssort01 .c, * html .jssort01 .pdn .c, * html .jssort01 .pav .c 
     	{    /* ie quirks mode adjust */    width /**/: 72px;    height /**/: 72px;}
</style>
<!-- #region Jssor Slider Begin -->
<!-- Generator: Jssor Slider Maker -->
<!-- Source: http://www.jssor.com -->
<!-- This code works with jquery library. -->

<script type="text/javascript">
	/* 이미지 로드함수 시작 */
    function loadImage($){
    	var jssor_1_SlideshowTransitions = [
           {$Duration:1200,x:0.3,$During:{$Left:[0.3,0.7]},$Easing:{$Left:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,x:-0.3,$SlideOut:true,$Easing:{$Left:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,x:-0.3,$During:{$Left:[0.3,0.7]},$Easing:{$Left:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,x:0.3,$SlideOut:true,$Easing:{$Left:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,y:0.3,$During:{$Top:[0.3,0.7]},$Easing:{$Top:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,y:-0.3,$SlideOut:true,$Easing:{$Top:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,y:-0.3,$During:{$Top:[0.3,0.7]},$Easing:{$Top:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,y:0.3,$SlideOut:true,$Easing:{$Top:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,x:0.3,$Cols:2,$During:{$Left:[0.3,0.7]},$ChessMode:{$Column:3},$Easing:{$Left:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,x:0.3,$Cols:2,$SlideOut:true,$ChessMode:{$Column:3},$Easing:{$Left:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,y:0.3,$Rows:2,$During:{$Top:[0.3,0.7]},$ChessMode:{$Row:12},$Easing:{$Top:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,y:0.3,$Rows:2,$SlideOut:true,$ChessMode:{$Row:12},$Easing:{$Top:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,y:0.3,$Cols:2,$During:{$Top:[0.3,0.7]},$ChessMode:{$Column:12},$Easing:{$Top:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,y:-0.3,$Cols:2,$SlideOut:true,$ChessMode:{$Column:12},$Easing:{$Top:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,x:0.3,$Rows:2,$During:{$Left:[0.3,0.7]},$ChessMode:{$Row:3},$Easing:{$Left:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,x:-0.3,$Rows:2,$SlideOut:true,$ChessMode:{$Row:3},$Easing:{$Left:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,x:0.3,y:0.3,$Cols:2,$Rows:2,$During:{$Left:[0.3,0.7],$Top:[0.3,0.7]},$ChessMode:{$Column:3,$Row:12},$Easing:{$Left:$Jease$.$InCubic,$Top:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,x:0.3,y:0.3,$Cols:2,$Rows:2,$During:{$Left:[0.3,0.7],$Top:[0.3,0.7]},$SlideOut:true,$ChessMode:{$Column:3,$Row:12},$Easing:{$Left:$Jease$.$InCubic,$Top:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,$Delay:20,$Clip:3,$Assembly:260,$Easing:{$Clip:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,$Delay:20,$Clip:3,$SlideOut:true,$Assembly:260,$Easing:{$Clip:$Jease$.$OutCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,$Delay:20,$Clip:12,$Assembly:260,$Easing:{$Clip:$Jease$.$InCubic,$Opacity:$Jease$.$Linear},$Opacity:2},
           {$Duration:1200,$Delay:20,$Clip:12,$SlideOut:true,$Assembly:260,$Easing:{$Clip:$Jease$.$OutCubic,$Opacity:$Jease$.$Linear},$Opacity:2}
         ];

         var jssor_1_options = {
           $AutoPlay: true,
           $SlideshowOptions: {
             $Class: $JssorSlideshowRunner$,
             $Transitions: jssor_1_SlideshowTransitions,
             $TransitionsOrder: 1
           },
           $ArrowNavigatorOptions: {
             $Class: $JssorArrowNavigator$
           },
           $ThumbnailNavigatorOptions: {
             $Class: $JssorThumbnailNavigator$,
             $Cols: 10,
             $SpacingX: 8,
             $SpacingY: 8,
             $Align: 360
           }
         };

         var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);

         /*responsive code begin*/
         /*you can remove responsive code if you don't want the slider scales while window resizing*/
         function ScaleSlider() {
             var refSize = jssor_1_slider.$Elmt.parentNode.clientWidth;
             if (refSize) {
                 refSize = Math.min(refSize, 800);
                 jssor_1_slider.$ScaleWidth(refSize);
             }
             else {
                 window.setTimeout(ScaleSlider, 30);
             }
         }
         ScaleSlider();
         $(window).bind("load", ScaleSlider);
         $(window).bind("resize", ScaleSlider);
         $(window).bind("orientationchange", ScaleSlider);
         /*responsive code end*/
    }
    /* 이미지 로드함수 끝 */
</script>
</head>
<body>
	<c:if test="${loginInfo == null }">
		<jsp:forward page="/mbr/loginView.do" />
	</c:if>
	<div style="margin: 0 auto; width: 900px">
		<img src="<c:url value='/images/makeImage/logo/viewMap.png'/>" width="195" height="55">
		<hr>
		<div class="wrap_content row">
			<div class="wrap_map col-xs-6" style="width: 550px; height: 500px">
				<div id="map" style="width: 500px; height: 500px"></div>
				<!-- 지도를 표시할 div 입니다 -->
			</div>
			<div class="wrap_map col-xs-6"style="border: 2px solid gray; width: 360px; height: 500px;">
				<div id="selectCrop"><b>My Farm Image</b></div>
				<div id="tablefmd" class="row" style="height: 120px;">
					<a id="addCropMap" href="${pageContext.request.contextPath}/crops/addFarmMap.do">
						<img src="<c:url value='/images/makeImage/logo/addCropLink.png' />"width="195" height="55">
					</a>
					<div id="cropsListDiary" class="wrap_map col-xs-6" style="height: 100px; width:250px;"></div>
					<div id="calLink"  class="wrap_map col-xs-6" style="height: 100px; width:80px; padding-left: 0px; margin-top: 10px;"></div>
				</div>
				<div id="cropsListDiaryImage">
					<img src="<c:url value='/images/makeImage/logo/fmdMapInfo.png'/>" width='320' height='300'/>
					
				</div>
			</div>
		</div>
	</div>

	<script	src="//apis.daum.net/maps/maps3.js?apikey=3ee04f6840ac4e5c9329a6b8b9dcd55d"></script>
	<!--  
 	김형철 - 3ee04f6840ac4e5c9329a6b8b9dcd55d   
	문재원 - 7fd11462e434594928ac9c7de1c06542
	박석현 - 97bee5060eb8bb0032557b9d342c6098
 -->
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
			 url: "${pageContext.request.contextPath}/crops/selectCropsMap.do?searchCondition=0&searchKeyword=" + id			// 넘길 주소(위치)
		 }).done(function(res) {
			 //console.log(res);
			  if(res.length != 0){
				var latitudeArraay = new Array();
				var longitudeArraay = new Array();
				var area = [];		
				var path2=[];
				if(res.length != 0){						// 입력한 정보가 없으면 이부분은 그냥 넘어감
					for(var i=0; i< res.length; i++) {
						latitudeArraay = res[i].latitude.split(',');
						longitudeArraay = res[i].longitude.split(',');	
						var path = [];
						for(var j=0; j<latitudeArraay.length; j++ ) {
							path.push(new daum.maps.LatLng(latitudeArraay[j],longitudeArraay[j]));
							path2.push(new daum.maps.LatLng(latitudeArraay[j],longitudeArraay[j]));
						}
						area.push({ 'name':res[i].scode, 'path':path ,
								    'strokeColor':res[i].strokeColor,'uploadImageOriginal':res[i].uploadImageOriginal,
								    'itemCode':res[i].itemCode,'mbrId':res[i].mbrId
							     });
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
		 
		//다각형을 생성하고 이벤트를 등록하는 함수입니다
			function displayArea(area) {
				// 다각형을 생성합니다 
				var polygon = new daum.maps.Polygon({
					map : map, // 다각형을 표시할 지도 객체
					path : area.path,							//
					strokeWeight : 2,
					strokeColor : area.strokeColor,					//
					strokeOpacity : 0.8,
					fillColor :'#fff',					//
					fillOpacity : 0.7
				});

				// 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다 
				
				// 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
				daum.maps.event.addListener(polygon, 'mouseover', function(
						mouseEvent) {
					polygon.setOptions({
						fillColor : '#09f'
					});

					customOverlay.setContent('<div class="area">' + area.name
							+ '</div>');

					customOverlay.setPosition(mouseEvent.latLng);
					customOverlay.setMap(map);
					//console.log(polygon.Bb[0].fillColor);
				});
				
				// 다각형에 mousemove 이벤트를 등록하고 이벤트가 발생하면 커스텀 오버레이의 위치를 변경합니다 
				daum.maps.event.addListener(polygon, 'mousemove', function(
						mouseEvent) {

					customOverlay.setPosition(mouseEvent.latLng);
				});

				// 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
				// 커스텀 오버레이를 지도에서 제거합니다 
				daum.maps.event.addListener(polygon, 'mouseout', function() {
					polygon.setOptions({
						fillColor : '#fff'
					});
					customOverlay.setMap(null);
				});
				
				// 다각형에 click 이벤트를 등록하고 이벤트가 발생하면 다각형의 이름과 면적을 인포윈도우에 표시합니다 
				daum.maps.event.addListener(polygon, 'click', function(mouseEvent) {
					console.log(area.uploadImageOriginal);
					console.log("null");
					var content = '<div class="info" style="float:left">' + '   <div>'
							+ area.name + '</div>'
							+ '	  <div id="dialog" style="display:none" title="대표사진"> '
							+ '	  <img src=${pageContext.request.contextPath}/images/makeImage/crops/'
							+ area.uploadImageOriginal
							+ ' class="picture" />'
							+ '</div> '
							+ '   <div class="size">총 면적 : 약 '
							+ Math.floor(polygon.getArea())
							+ ' m<sup>2</sup></area>' + '</div>'
							+ '   <div class="size">총 둘레 : 약 '
							+ Math.round(polygon.getLength())
							+ ' m</area>' + '</div>';
						 if(area.uploadImageOriginal != null) { 
							content	+= '   <button id="opener" style="float:left" >대표사진</button>';
						 }
					infowindow.setContent(content);
					infowindow.setPosition(mouseEvent.latLng);
					infowindow.setMap(map);
					$( "#dialog" ).dialog({
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
				 
				    $( "#opener" ).on( "click", function() {
				      $( "#dialog" ).dialog( "open" );
				    });
					   
				/* 클릭한 작물의 일지 정보 호출 */
			    /******************************************************************************************************************/
				$.ajax({
			 		url: "${pageContext.request.contextPath}/farmingDiary/selectFarmingDiaryListForMain.do?mbrId=" + area.mbrId + "&itemCode=" + area.itemCode	
				}).done(function(res) {
		 				if(res.length == 0) {
		 					$("#cropsListDiary").html("<br><p>" + area.name + "에 등록한 일지가 없습니다.</p>");
		 					$("#calLink").html("");
		 					var linkInfo  = '<a href="${pageContext.request.contextPath}/farmingDiary/monthList.do"class="link">';
		 						linkInfo += "<img src='../images/makeImage/logo/fmdMapInfoNull.png' width='320' height='300'/>";
		 					$("#cropsListDiaryImage").html(linkInfo);
		 				}
		 				else {
		 					//console.log(area.name);
		 					//console.log(res);	
			 				var contents = "<br>";
			 				var imageDiv = "";
			 				if(res.length > 3) {
			 					for(var i=0; i<3; i++) {
			 						contents += "<table  style='height:30px;'><tr>";
					 				contents += "<td class='fmddate' style='width:90px;'>"+res[i].diaryDate +"</td>";
					 				contents += "<td class='fmdtitle'>"+res[i].diarySubject +"</td>";
					 				contents += "</tr></table>";
			 					}
			 				}else {
				 				for(var i=0; i<res.length; i++) {
				 					contents += "<table style='height:30px;'><tr>";
					 				contents += "<td class='fmddate' style='width:90px;'>"+res[i].diaryDate +"</td>";
					 				contents += "<td class='fmdtitle'>"+res[i].diarySubject +"</td>";
					 				contents += "</tr></table>";
					 			}
			 				}
			 				for(var i=0; i<res.length; i++) {
				 				// 사진이 있는 일지만 사진 가져와서 슬라이드 DIV에 넣음
				 				if(res[i].diaryUploadFileOriginal != null) {
					 				imageDiv += "<div data-p='144.50' style='display: none;''>";
					 				imageDiv += "<img data-u='image' src='../images/makeImage/diaryImage/" + res[i].diaryUploadFileOriginal + "' />";
					 				imageDiv += "<img data-u='thumb' src='../images/makeImage/diaryImage/" + res[i].diaryUploadFileOriginal + "' />";
					 				imageDiv += "</div>";
				 				}
				 			}
			 				// 작물 다이어리 부분
			 				$("#addCropMap").html("");
			 				$("#selectCrop").html("<b>" + area.name + "</b>");
			 				$("#cropsListDiary").html(contents);
			 				var calLinkImage  = '<a href="${pageContext.request.contextPath}/farmingDiary/monthList.do"class="link">';
		 					calLinkImage += "<img src='../images/makeImage/logo/calLink.png' width='90' height='120'/></a>";
		 					$("#calLink").html(calLinkImage);
		 				
			 				// 작물 사진 부분
			 				//console.log(imageDiv);
			 				var sliderDiv  = '<div id="jssor_1" style="position: relative; margin: 0 auto; top:10px; left: 0px; width: 800px; height: 800px; overflow: hidden; visibility: hidden; background-color: #24262e;">';
			 					sliderDiv += '<div data-u="loading" style="position: absolute; top: 0px; left: 0px;">';
			 					sliderDiv += '<div style="filter: alpha(opacity=70); opacity: 0.7; position: absolute; display: block; top: 0px; left: 0px; width: 100%; height: 100%;"></div>';
			 					sliderDiv += '<div style="position:absolute;display:block;background:url("../images/slider/loading.gif") no-repeat center center;top:0px;left:0px;width:100%;height:100%;"></div>';
			 					sliderDiv += '</div>';
			 					sliderDiv += '<div id="fmdImage" data-u="slides" style="cursor: default; position: relative; top: 0px; left: 0px; width: 800px; height: 700px; overflow: hidden;">';
			 					sliderDiv += imageDiv;
			 					sliderDiv += '</div>';
			 					sliderDiv += '<div id="navImage" data-u="thumbnavigator" class="jssort01" style="position:absolute;left:0px;bottom:0px;width:800px;height:100px;" data-autocenter="1">';
			 					sliderDiv += '<div data-u="slides" style="cursor: default;">';
			 					sliderDiv += '<div data-u="prototype" class="p">';
			 					sliderDiv += '<div class="w">';
			 					sliderDiv += '<div data-u="thumbnailtemplate" class="t"></div>';
			 					sliderDiv += '</div>';
			 					sliderDiv += '<div class="c"></div>';
			 					sliderDiv += '</div>';
			 					sliderDiv += '</div>';
			 					sliderDiv += '</div>';
			 					sliderDiv += '<span data-u="arrowleft" class="jssora05l" style="top:358px;left:8px;width:40px;height:40px;"></span>';
			 					sliderDiv += '<span data-u="arrowright" class="jssora05r" style="top:358px;right:8px;width:40px;height:40px;"></span>';
			 					sliderDiv += '</div>';
			 				$("#cropsListDiaryImage").html("");
			 				$("#cropsListDiaryImage").html(sliderDiv);
			 				loadImage($);
		 				}
		 			});
				});
				/******************************************************************************************************************/
			}
/* 		// 마우스 드래그와 모바일 터치를 이용한 지도 이동을 막는다
		map.setDraggable(false);		

		// 마우스 휠과 모바일 터치를 이용한 지도 확대, 축소를 막는다
		map.setZoomable(false);   */
	</script>
</body>
</html>