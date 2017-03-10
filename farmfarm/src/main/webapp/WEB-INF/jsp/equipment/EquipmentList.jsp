<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	/**
	 * @Class Name : EquipmentList.jsp
	 * @Description : Equipment List 화면
	 * @Modification Information
	 * 
	 * @author 김형철, 정명규
	 * @since 20161123, 20161201
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
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">


<title>목록</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
#title, #title1, #tabs, #paging, #sysbtn {
	width: 800px;
	margin: 0 auto;
}
</style>

<script>
	var category = "${searchVO.searchKeyword}";
	console.log(category);
	var dialog
	$(function() {
		$("#tabs").tabs();
		 $("#tabs").tabs("option", "active" , category==""?0:category);
		
		dialog = $("#modal-body").dialog({
			autoOpen : false,
			height : 350,
			width : 450,
			modal : true	
		});
		

	});

	function modalEquip() {
		var active = $("#tabs").tabs("option", "active");
		$("#categoryName").val(equiparrayName[active]);
		$("#category").val(equiparray[active]);
		dialog.dialog("open");
	}
	var equiparray = [ "0BB1", "0BB2", "0BB3", "0BB4" ]
	var equiparrayName = [ "농약", "비료", "인력", "장비" ]
	
	function deletecheck(id) {
		 
		if (confirm("정말 삭제하시겠습니까?")) {
			location.href= "../equipment/deleteEquipment.do?equipmentId="+id;
		}
	}
	
	function fn_egov_link_page(pageNo){
		document.getElementById("listForm").pageIndex.value = pageNo;
		document.getElementById("listForm").searchKeyword.value =  $("#tabs").tabs("option", "active");
		document.getElementById("listForm").action = "<c:url value='/equipment/EquipmentList.do'/>";
	   	document.getElementById("listForm").submit();
	}
	function fn_egov_link_page2(pageNo2){
		document.getElementById("listForm").pageIndex2.value = pageNo2;
		document.getElementById("listForm").searchKeyword.value =  $("#tabs").tabs("option", "active");
		document.getElementById("listForm").action = "<c:url value='/equipment/EquipmentList.do'/>";
		document.getElementById("listForm").submit();
	}
	function fn_egov_link_page3(pageNo3){
		document.getElementById("listForm").pageIndex3.value = pageNo3;
		document.getElementById("listForm").searchKeyword.value =  $("#tabs").tabs("option", "active");
		document.getElementById("listForm").action = "<c:url value='/equipment/EquipmentList.do'/>";
	   	document.getElementById("listForm").submit();
	}
	function fn_egov_link_page4(pageNo4){
		document.getElementById("listForm").pageIndex4.value = pageNo4;
		document.getElementById("listForm").searchKeyword.value =  $("#tabs").tabs("option", "active");
		document.getElementById("listForm").action = "<c:url value='/equipment/EquipmentList.do'/>";
	   	document.getElementById("listForm").submit();
	}

</script>
</head>

<body>

<c:if test="${loginInfo == null }">
		<jsp:forward page="/mbr/loginView.do" />
</c:if>

	<form:form commandName="searchVO" name="listForm" id="listForm"	method="post">
	<input type="hidden" name="searchKeyword" />
		<input type="hidden" name="equipmentId" />

		<!-- <div id="content_pop"> -->
		<!-- 타이틀 -->
		<div>
			<h3 id="title1">농약/비료/장비설정</h3>
		</div>
		<!-- // 타이틀 -->
 
		<!-- 버튼 -->
		<div id="tabs">
			<ul>
				<li><a href="#table1">농약종류</a></li>
				<li><a href="#table2">비료종류</a></li>
				<li><a href="#table3">인력종류</a></li>
				<li><a href="#table4">장비종류</a></li>
			</ul>

			<!-- List -->
			<!-- 농약종류 -->
			<div id="table1">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>구분</th>
							<th>농약이름</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList1}" varStatus="status">
							<tr>
								<td style="width: 45%"><c:out value="${result.categoryNm}" />&nbsp;</td>
								<td style="width: 45%"><a href="${pageContext.request.contextPath}/equipment/updateEquipmentView.do?equipmentId=${result.equipmentId}">${result.equipmentName}</a>&nbsp;</td>
								<td style="width: 10%"><a onclick="deletecheck(${result.equipmentId})" style="cursor:pointer">삭제</a>&nbsp;</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			<div>
				<ui:pagination paginationInfo="${paginationInfo1}" type="image"
					jsFunction="fn_egov_link_page" />
				<form:hidden path="pageIndex" />
			</div>
			</div>

			<!-- 비료종류 -->
			<div id="table2">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>구분</th>
							<th>비료이름</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList2}" varStatus="status">
							<tr>
								<td style="width: 45%"><c:out value="${result.categoryNm}" />&nbsp;</td>
								<td style="width: 45%"><a href="${pageContext.request.contextPath}/equipment/updateEquipmentView.do?equipmentId=${result.equipmentId}">${result.equipmentName}</a>&nbsp;</td>
								<td style="width: 10%"><a onclick="deletecheck(${result.equipmentId})">삭제</a>&nbsp;</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
 			<div>
				<ui:pagination paginationInfo="${paginationInfo2}" type="image2"
					jsFunction="fn_egov_link_page2" />
				<form:hidden path="pageIndex2" />
			</div>
			</div>

			<!-- 인력종류 -->
			<div id="table3">
				<table class="table table-hover" >
					<thead>
						<tr>
							<th>구분</th>
							<th>인력이름</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList3}" varStatus="status">
							<tr>
								<td style="width: 45%"><c:out value="${result.categoryNm}" />&nbsp;</td>
								<td style="width: 45%"><a href="${pageContext.request.contextPath}/equipment/updateEquipmentView.do?equipmentId=${result.equipmentId}">${result.equipmentName}</a>&nbsp;</td>
								<td style="width: 10%"><a onclick="deletecheck(${result.equipmentId})">삭제</a>&nbsp;</td>
								
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div>
				<ui:pagination paginationInfo="${paginationInfo3}" type="image3"
					jsFunction="fn_egov_link_page3" />
				<form:hidden path="pageIndex3" />
			</div>
			
 			</div>
			
			<!-- 장비종류 -->
			<div id="table4">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>구분</th>
							<th>장비이름</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList4}" varStatus="status">
							<tr>
								<td style="width: 45%"><c:out value="${result.categoryNm}" />&nbsp;</td>
								<td style="width: 45%"><a href="${pageContext.request.contextPath}/equipment/updateEquipmentView.do?equipmentId=${result.equipmentId}">${result.equipmentName}</a>&nbsp;</td>
								<td style="width: 10%"><a onclick="deletecheck(${result.equipmentId})">삭제</a>&nbsp;</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			<div>
				<ui:pagination paginationInfo="${paginationInfo4}" type="image4"
					jsFunction="fn_egov_link_page4" />
				<form:hidden path="pageIndex4" />
			</div>
		
 		</div>
			<!-- /List -->
		</div>

		<!----------------------- 등록 ----------------------->
		<div id="sysbtn1" align="left">
			<ul>
				<li>
					<div id="sysbtn">
						<input type="button" id="addEquip" onclick="modalEquip()" value="등록" />
					</div>
				</li>
			</ul>
		</div>
	</form:form>

	<div id="modal-body" align="center">
		<form id="bidForm" class="form-horizontal"
			action="${pageContext.request.contextPath}/equipment/addEquipment.do">
			
			<input type="hidden" type="text" id="category" name="category" class="form-control" value ="category"/> <br>

			<div class="form-group" align="center">
				<label for="exampleInputName2" class="col-xs-2 control-label">사용자</label>
				<div class="col-xs-5" align="center">
					<input type="text" id="mbrId" name="mbrId" class="form-control"	value="${loginInfo.mbrId}" readonly="readonly" /> <br>
				</div>
			</div>

			<div class="form-group" align="center">
				<label for="exampleInputName2" class="col-xs-2 control-label">구분</label>
				<div class="col-xs-5" align="center">
					<input type="text" id="categoryName" name="categoryName" class="form-control" value ="categoryName" readonly="readonly"/> <br>
				</div>
			</div>

			<div class="form-group" align="center">
				<label for="exampleInputName2" class="col-xs-2 control-label">명칭</label>
				<div class="col-xs-5" align="center">
					<input type="text" id="equipmentName" name="equipmentName" class="form-control" /> <br>
				</div>
			</div>

			<div align="center"><button id="bidbtnModal" type="submit" class="btn btn-info" >등록</button></div>
		</form>
	</div>
	<!----------------------- /등록 ----------------------->

</body>
</html>
