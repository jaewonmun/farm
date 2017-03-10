<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>eGovFrame 공통 컴포넌트</title>
<link href="<c:url value='/css/egovframework/com/com.css' />"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
a { color:black; }
a:hover { text-decoration: none; }
li { list-style-type : none; }
.subMenu { padding-left: 2px;}
/* a { width: 120px;} */
element.style {
	overflow: hidden;
	height: 268px;
	padding-top: 0px;
	margin-top: 0px;
	padding-bottom: 0px;
	margin-bottom: 0px;
	display: none;
}

#header_menu {
	position: relative;
	width: 100%;
	min-width: 1200px;
	height: 45px;
	line-height: 43px;
	background: #0ea40b;
	box-shadow: 0 2px 5px 0 gray;
}

.menu_box {
	width: 1300px;
	margin: 0 auto;
}

.menu_box ul.gnb {
	float: left;
	display: inline;
}

.menu_box ul.gnb li {
	float: left;
	display: inline;
	margin-right: 84px;
}

.menu_box ul.gnb li:first-child {
	margin-left: 68px;
}

.menu_box ul.gnb li:last-child {
	margin-right: 68px;
}

.menu_box ul.gnb li a {
	display: block;
	color: #fff;
	font-size: 16px;
	font-weight: 600;
}

.menu_box ul.gnb li a:hover, .menu_box ul.gnb li a.on {
	opacity: 0.6;
}

.menu_mask {
	position: absolute;
	width: 100%;
	height: 268px;
	z-index: 100;
	border-bottom: 2px solid #0c4ca4; /* overflow: hidden; */
}

.menu_move {
	position: relative;
	width: 100%;
	height: 268px;
	background: #fff;
} /* background: rgba(255, 255, 255, 0.94); 투명도 */
.menu_move .menu_sub_box {
	position: relative;
	width: 1300px;
	padding-top: 10px;
	margin: 0 auto;
}

.menu_sub_box ul {
	float: left;
}

.menu_sub_box ul:nth-child(1) {
	width: 120px;
	margin-left: 97px;
}

.menu_sub_box ul:nth-child(2) {
	width: 130px;
	margin-left: 28px;
}

.menu_sub_box ul:nth-child(3) {
	width: 143px;
	margin-left: 17px;
}

.menu_sub_box ul:nth-child(4) {
	width: 148px;
	margin-left: 10px;
}

.menu_sub_box ul:nth-child(5) {
	width: 142px;
	margin-left: 1px;
}

.menu_sub_box ul:nth-child(6) {
	width: 155px;
	margin-left: 5px;
}

.menu_sub_box ul li {
	clear: both;
}

.menu_sub_box ul li a {
	text-align: left;
	display: block;
	padding: 2px 10px;
	color: #444;
	font-size: 13px;
}

.menu_sub_box ul li a:hover, .menu_sub_box ul li a.on {
	background-color: #bef4ad;
	color: #fff;
	font-weight: bold;
}
</style>
<script>
	$(document).ready(function() {
		var bDisplay = true;
		function doDisplay() {
			var con = document.getElementById("myDIV");
			if (con.style.display == 'none') {
				con.style.display = 'block';
			} else {
				con.style.display = 'none';
			}
		}
		$(".menu_mask").hide();
		$("#header_menu").hover(function() {
			$(".menu_mask").stop().slideDown(200);
		}, function() {
			$(".menu_mask").stop().slideUp(100);
		});

		$(".menu_mask").hover(function() {
			$(".menu_mask").stop().slideDown(200);
		}, function() {
			$(".menu_mask").stop().slideUp(100);
		});
	});

</script>
</head>
<body style="overflow: auto; overflow: hidden;">
	<!-- 상단메뉴 -->
	<div id="header_menu">
		<div class="menu_box">
			<ul class="gnb">
				<li id="#"><a
					href="${pageContext.request.contextPath}/basicinfo/BasicInfo.do"
					target="_content" class="link">농업정보</a></li>
				<li id="#"><a
					href="${pageContext.request.contextPath}/equipment/EquipmentList.do"
					target="_content" class="link">지출관리</a></li>
				<li id="#"><a
					href="${pageContext.request.contextPath}/farmingDiary/monthList.do"
					target="_content" class="link">영농일지</a></li>
				<li id="#"><a
					href="${pageContext.request.contextPath}/item/ItemList.do"
					target="_content" class="link">영농조회</a></li>
				<li id="#"><a
					href="${pageContext.request.contextPath}/sellList/SellListList.do?mbrID=${loginInfo.mbrId}"
					target="_content" class="link">판매관련</a></li>
				<li id="#"><a
					href="javascript:window.open('${pageContext.request.contextPath}/farmdic/FarmDic.do', '', 'top=50,left=800,width=562.727,height=640')" 
					target="_content" class="link">농업용어사전</a></li>
			</ul>

		</div>
	</div>
	<div id="myDIV" class="menu_mask">
		<div class="menu_move">
			<div class="menu_sub_box">
			<ul class="subMenu">
				<li id="#">
					<a href="${pageContext.request.contextPath}/basicinfo/BasicInfo.do" target="_content" class="link">작물정보</a>
					<a href="${pageContext.request.contextPath}/insectsinfo/InsectsInfo.do" target="_content" class="link">병충해정보</a>
					<a href="${pageContext.request.contextPath}/weather/weatherSK.do?time=<%=System.currentTimeMillis() %>" target="_content" class="link">기상정보</a>
				</li>
			</ul>
			<ul class="subMenu">
				<li id="#">
					<a href="${pageContext.request.contextPath}/equipment/EquipmentList.do" target="_content" class="link">장비품목정보</a>
					<a href="${pageContext.request.contextPath}/equipmentUse/EquipmentUseList.do?mbrId=${loginInfo.mbrId}" target="_content" class="link">장비사용량</a>
				</li>
			</ul>
			<ul class="subMenu">
				<li id="#">
					<a href="${pageContext.request.contextPath}/farmingDiary/monthList.do" target="_content" class="link">일지작성</a>
					<a href="${pageContext.request.contextPath}/item/ItemList.do" target="_content" class="link">품목분류</a>
				</li>
			</ul>
			<ul class="subMenu">
				<li id="#">
					<a href="${pageContext.request.contextPath}/item/ItemList.do" target="_content" class="link">영농조회</a>
					<a href="${pageContext.request.contextPath}/crops/farmMap.do" target="_content" class="link">지도조회</a>
				</li>
			</ul>
			<ul class="subMenu">
				<li id="#">
					<li id="#"><a href="${pageContext.request.contextPath}/sellList/sellInfo.do?time=<%=System.currentTimeMillis() %>" target="_content" class="link">시세조회</a>
					<li id="#"><a href="${pageContext.request.contextPath}/sellList/SellListList.do?mbrID=${loginInfo.mbrId}" target="_content" class="link">판매조회</a>
				</li>
			</ul>
			<ul class="subMenu">
				<li id="#" >
				</li>
			</ul>
		</div>
	</div>
	</div>
</body>
</html>
