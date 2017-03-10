<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value='/common/css/distribute.css'/>"/>
<link rel="stylesheet" href="<c:url value='/common/css/global.css'/>"/>
<link rel="stylesheet" href="<c:url value='/common/css/reset.css'/>"/>
<link rel="stylesheet" href="<c:url value='/css/chart/Nwagon.css'/>" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="<c:url value='/js/jquery.xdomainajax.js'/>"></script>
<script src="<c:url value='/js/sellInfo/sellInfo.js'/>"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<c:url value='/js/sellInfo/Nwagon.js'/>"></script>
<style>
a {	color: black;}
a:hover {text-decoration: none;}
.rootDiv {	width: 700px;	margin: 0 auto;}
.total { text-align: left; }
.rank1 { text-align: left; }
.volume { float: right; }
</style>
<title>Insert title here</title>
</head>
<body>
<!-- <div id="dialog" title="로딩중">
  <img src='../images/makeImage/logo/data_loading.gif' width="436" height="187"/>
</div> -->
	<div class="rootDiv">
		<div class="dsTit06 selectWrap">
			<h3 id="itemName" class="dpInbk verMd" style="font-size: 25px; font-weight: bold;"></h3>
			<span class="live">실시간</span>
				<select id="scodeVal" name="scodeVal" class="selectDis" onchange="goMainChange(this)">
					<option value="070299" selected="selected" label="대추" ></option>
					<option value="060199" label="사과" ></option>
					<option value="060499" label="복숭아">복숭아</option>
					<option value="050299">고구마</option>
					
			</select>
		</div>
		<div class="disTable">
			<table>
				<caption class="none">전일대비</caption>
				<colgroup>
					<col style="width: 25%;">
					<col style="width: 25%;">
					<col style="width: 25%;">
					<col style="width: 25%;">
				</colgroup>
				<tbody>
					<tr>
						<th rowspan="2" class="tdBg"><span class="number"> <b id= "mainPrice"></b>
						</span>
							<div class="disTableTxt">
								전일대비<span class="dpTbWrap"><br> - 478 <b
									class="dpTb"> (∞%) </b> </span>
							</div></th>
						<td class="btLine">
							<div id="itemNameSub"class="dpTb02">
							</div>
						</td>
						<td class="btLine">
							<div id="maxPrice" class="dpTb02">
								
							</div>
						</td>
						<td id="sumPrice" class="btLine">
						</td>
					</tr>
					<tr>
						<td>
							<div class="dpTb02">
								규격 <span>kg</span>
							</div>
						</td>
						<td>
							<div id="minPrice" class="dpTb02">
								
							</div>
						</td>
						<td id="avgPrice">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="wrapDsMainCt">
			<!-- //탭 -->
			<div class="dsMainCt" id="txtTab1">
				<!-- 실시간경매 -->
				<h3 class="dpInbk verMd">
					<img src="" id="chartTitle">
				</h3>
				<div class="dsMLine dsMLine01">
					<div id="realDateDiv">
						<ul class="innerTab" id="dateRealTypeTab">
							<li id="rtDate2"><a href="javascript:goRealChart('2')">3일</a></li>
						</ul>
					</div>
					<!-- 실시간 경매 그래프 영역 -->
					<div id="Nwagon"></div>
					<!-- //실시간 경매 그래프 영역 -->

				</div>
				<div class="dsMLine dsMLine02" style="border-bottom: 0px;">
					<div class="listType">
						<table class="">
							<colgroup>
								<col style="width: 110px">
								<col>
							</colgroup>
							<thead>
								<tr>
									<th id="itemNameTop5" scope="col" colspan="2"> 
									</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="2" class="volumeList">
										<ul>
											<li class="total">
												<strong class="market">전체</strong>
												<span class="volume" id="tradeAllavg"></span>
											</li>
										</ul>
										<ul id="top5Maket">
											
										</ul>
										
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- //실시간경매 -->

			<div class="dsMainCt" id="txtTab3" style="display: none;">
				<!-- 시황정보 -->
				<h3 class="dpInbk verMd">
					<img src="" alt="시황정보">
				</h3>
				<div class="dsMLine dsMLine01">
					<!-- <span class="unit">단위:가격(원)<b class="">물량(10kg상자)</b></span> -->

					<!-- 시황정보 그래프 영역 -->
					<div style="float: none;">
						<div id="flot-placeholder"
							style="top: 20px; width: 380px; height: 175px; margin: 0 auto; left: -5px;"></div>
					</div>
					<!-- //시황정보 그래프 영역 -->

					<p class="graphInfo">
						<em>※</em>본그래프는 ‘옥답’가격정보의 산지공판장 정보임을 알려드립니다.
					</p>
				</div>
				<div class="dsMLine dsMLine02">
					<div class="listType">
						<table class="tblMarketInfo">
							<caption></caption>
							<colgroup>
								<col style="width: 110px">
								<col>
							</colgroup>
							<thead>
								<tr>
									<th scope="col" colspan="2">자두 시황정보</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>
					<p class="graphInfo">
						<em>※</em>본그래프는 ‘KAMIS’가격정보의 소매정보<br>정보임을 알려드립니다.
					</p>
				</div>
			</div>
			<!-- //시황정보 -->
		</div>

		<div class="dsMainTabCt">
			<!-- //탭 -->
			<div class="tabCont" id="tabResult" style="display: block;">
				<div class="listType">
					<table>
						<colgroup>
							<col style="width: 13%">
							<col style="width: 14%">
							<col style="width: 9%">
							<col style="width: 12%">
							<col style="width: 10%">
							<col style="width: 13%">
							<col style="width: 10%">
							<col style="width: 12%">
							<col style="width: 7%">
						</colgroup>
						<thead>
							<tr class="trPst">
								<th>경매시간<img src="" alt="" class="tbBar"></th>
								<th>품목(품종)<img src="" alt="" class="tbBar"></th>
								<th>규격<img src="" alt="" class="tbBar"></th>
								<th>경락가<img src="" alt="" class="tbBar"></th>
								<th>거래량<img src="" alt="" class="tbBar"></th>
								<th>도매시장<img src="" alt="" class="tbBar"></th>
								<th>도매법인<img src="" alt="" class="tbBar"></th>
								<th>산지<img src="" alt="" class="tbBar"></th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody id="itemList">
						</tbody>
					</table>
				</div>
			</div>
			<!-- //결과 레이어 -->

		</div>
	</div>
</body>
</html>