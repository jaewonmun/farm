<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EquipmentUseList.jsp
  * @Description : EquipmentUse List 화면
  * @Modification Information
  * 
  * @author 김형철
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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">


<title>목록</title>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  <style>
  #title, #title1, #tabs, #paging, #sysbtn{
	    width: 80%;
	    margin: 0 auto;
	}
  </style>
  
  <script>
  var catego = "${searchVO.searchKey}";
  console.log(catego);
  /* 글 수정 화면 function        */
  function fn_egov_select(equipmentUsePk, mbrId) {
	  	document.getElementById("listForm").equipmentUsePk.value = equipmentUsePk;
  		document.getElementById("listForm").mbrId.value = mbrId;
     	document.getElementById("listForm").action = "<c:url value='/equipmentUse/updateEquipmentUseView.do'/>";
     	document.getElementById("listForm").submit();
  }


  var dialog
  $( function() {
    $( "#tabs" ).tabs();
    $("#tabs").tabs("option", "active" , catego==""?0:catego);
    
    dialog = $("#modal-body").dialog ({ 
    	autoOpen: false,
        height: 400,
        width: 350,
        modal: true});  
  } );
  
 
  
  function modalEquipUse() {
	  var active = $( "#tabs" ).tabs( "option", "active" );
	  		$("#categoryCode").html("");
	  		$("#categoryCode").append('<option value="" >선택하세요</option>');
	  	for ( i=0; i<equipcombo.length; i++) {
	  		if(equipcombo[i].mbrId == "${loginInfo.mbrId}"){
		  		if (equipcombo[i].category == equiparray[active]) {
		  		$("#categoryCode").append('<option value="'+ equipcombo[i].equipmentId +'">'+ equipcombo[i].equipmentName +'</option>');
	  		}
	  	}}
	  	var today = new Date();
		var year = today.getFullYear();
		var month = today.getMonth()+1;
		var day = today.getDate();
		var hours = today.getHours();
		var minutes = today.getMinutes();
		if(day < 10) {
			day = "0"+day;
		}
		var paramDate = year+"-"+month+"-"+day;
		$("#equipmentQuantity").attr('autofocus','autofocus');
		$("#equipmentUseDate").val(paramDate);
		
		$( "#equipmentUseDate" ).datepicker({
	  		dateFormat: "yy-mm-dd",	
	  		changeYear: true,
	  		changeMonth: true
	      });
	  	
	  	dialog.dialog( "open" );
  }
  	var equiparray = ["0BB1", "0BB2", "0BB3", "0BB4"]
  	var equipcombo = eval("(" + '${equipcomboList}'   + ")") 
  
  	function deletecheck(UsePk) {	 
		if (confirm("정말 삭제하시겠습니까?")) {
			location.href= "../equipmentUse/deleteEquipmentUse.do?equipmentUsePk="+UsePk;
		}
	}
  	
	function pageLink(pageNo){
		document.getElementById("listForm").pageIndex.value = pageNo;
		document.getElementById("listForm").searchKey.value =  $("#tabs").tabs("option", "active");
		document.getElementById("listForm").action = "<c:url value='/equipmentUse/EquipmentUseList.do'/>";
	   	document.getElementById("listForm").submit();
	}
	function pageLink2(pageNo2){
		document.getElementById("listForm").pageIndex2.value = pageNo2;
		document.getElementById("listForm").searchKey.value =  $("#tabs").tabs("option", "active");
		document.getElementById("listForm").action = "<c:url value='/equipmentUse/EquipmentUseList.do'/>";
		document.getElementById("listForm").submit();
	}
	function pageLink3(pageNo3){
		document.getElementById("listForm").pageIndex3.value = pageNo3;
		document.getElementById("listForm").searchKey.value =  $("#tabs").tabs("option", "active");
		document.getElementById("listForm").action = "<c:url value='/equipmentUse/EquipmentUseList.do'/>";
	   	document.getElementById("listForm").submit();
	}
	function pageLink4(pageNo4){
		document.getElementById("listForm").pageIndex4.value = pageNo4;
		document.getElementById("listForm").searchKey.value =  $("#tabs").tabs("option", "active");
		document.getElementById("listForm").action = "<c:url value='/equipmentUse/EquipmentUseList.do'/>";
	   	document.getElementById("listForm").submit();
	}
  	
  </script>
</head>

<body>
<c:if test="${loginInfo == null }">
		<jsp:forward page="/mbr/loginView.do" />
</c:if>


<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	<input type="hidden" name="searchKey" />
	
	<input type="hidden" name="equipmentUsePk" />

	<input type="hidden" name="mbrId" />

<!-- <div id="content_pop"> -->
	<!-- 타이틀 -->
	<div>
		<h3 id = "title1">농약/비료/장비 사용량</h3>
	</div>
	<!-- // 타이틀 -->
	
	
	<!-- 버튼 -->
<div id="tabs">
  <ul>
    <li><a href="#table1">농약사용량</a></li>
    <li><a href="#table2">비료사용량</a></li>
    <li><a href="#table3">인력사용량</a></li>
    <li><a href="#table4">장비사용량</a></li>
  </ul>
	
	<!-- List -->

	<!-- 농약사용량 -->
	<div id="table1">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>구분</th>
					<th>명칭</th>
					<th>사용량</th>
					<th>단위</th>
					<th>비용</th>
					<th>사용일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList1}" varStatus="status">
					<tr>						
						<td style="width: 10%"><c:out value="${result.category}"/>&nbsp;</td>
						<td style="width: 15%"><a href="javascript:fn_egov_select('<c:out value="${result.equipmentUsePk}"/>', '<c:out value="${result.mbrId}"/>')"><c:out value="${result.equipmentName}"/></a>&nbsp;</td>
						<td style="width: 10%"><c:out value="${result.equipmentQuantity}"/>&nbsp;</td>
						<td style="width: 10%"><c:out value="${result.equipmentUnitNm}"/>&nbsp;</td>
						<td style="width: 15%"><c:out value="${result.equipmentPrice}"/>&nbsp;</td>
						<td style="width: 20%"><c:out value="${result.equipmentUseDate}"/>&nbsp;</td>
						<td style="width: 10%"><a onclick="deletecheck(${result.equipmentUsePk})" style="cursor:pointer">삭제</a>&nbsp;</td>
				    </tr>
				</c:forEach>
			</tbody>
		</table>
			<div>
				<ui:pagination paginationInfo="${paginationInfo1}" type="image01"
					jsFunction="pageLink" />
				<form:hidden path="pageIndex" />
			</div>
	</div>
	
	<!-- 비료사용량 -->
	<div id="table2">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>구분</th>
					<th>명칭</th>
					<th>사용량</th>
					<th>단위</th>
					<th>비용</th>
					<th>사용일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList2}" varStatus="status">
					<tr>
						<td style="width: 10%"><c:out value="${result.category}"/>&nbsp;</td>
						<td style="width: 15%"><a href="javascript:fn_egov_select('<c:out value="${result.equipmentUsePk}"/>', '<c:out value="${result.mbrId}"/>')"><c:out value="${result.equipmentName}"/></a>&nbsp;</td>
						<td style="width: 10%"><c:out value="${result.equipmentQuantity}"/>&nbsp;</td>
						<td style="width: 10%"><c:out value="${result.equipmentUnitNm}"/>&nbsp;</td>
						<td style="width: 15%"><c:out value="${result.equipmentPrice}"/>&nbsp;</td>
						<td style="width: 20%"><c:out value="${result.equipmentUseDate}"/>&nbsp;</td>
						<td style="width: 10%"><a onclick="deletecheck(${result.equipmentUsePk})" style="cursor:pointer">삭제</a>&nbsp;</td>
				    </tr>
				</c:forEach>
			</tbody>
		</table>
			<div>
				<ui:pagination paginationInfo="${paginationInfo2}" type="image02"
					jsFunction="pageLink2" />
				<form:hidden path="pageIndex2" />
			</div>
	</div>
	
	<!-- 인력사용량 -->
	<div id="table3">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>구분</th>
					<th>명칭</th>
					<th>인력(명수)</th>
					<th>단위</th>
					<th>비용</th>
					<th>사용일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList3}" varStatus="status">
					<tr>
						<td style="width: 10%"><c:out value="${result.category}"/>&nbsp;</td>
						<td style="width: 15%"><a href="javascript:fn_egov_select('<c:out value="${result.equipmentUsePk}"/>', '<c:out value="${result.mbrId}"/>')"><c:out value="${result.equipmentName}"/></a>&nbsp;</td>
						<td style="width: 10%"><c:out value="${result.equipmentQuantity}"/>&nbsp;</td>
						<td style="width: 10%"><c:out value="${result.equipmentUnitNm}"/>&nbsp;</td>
						<td style="width: 15%"><c:out value="${result.equipmentPrice}"/>&nbsp;</td>
						<td style="width: 20%"><c:out value="${result.equipmentUseDate}"/>&nbsp;</td>
						<td style="width: 10%"><a onclick="deletecheck(${result.equipmentUsePk})" style="cursor:pointer">삭제</a>&nbsp;</td>
				    </tr>
				</c:forEach>
			</tbody>
		</table>
			<div>
				<ui:pagination paginationInfo="${paginationInfo3}" type="image03"
					jsFunction="pageLink3" />
				<form:hidden path="pageIndex3" />
			</div>
	</div>
	
	<!-- 장비사용량 -->
	<div id="table4">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>구분</th>
					<th>명칭</th>
					<th>사용량</th>
					<th>단위</th>
					<th>비용</th>
					<th>사용일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList4}" varStatus="status">
					<tr>					
						<td style="width: 10%"><c:out value="${result.category}"/>&nbsp;</td>
						<td style="width: 15%"><a href="javascript:fn_egov_select('<c:out value="${result.equipmentUsePk}"/>', '<c:out value="${result.mbrId}"/>')"><c:out value="${result.equipmentName}"/></a>&nbsp;</td>
						<td style="width: 10%"><c:out value="${result.equipmentQuantity}"/>&nbsp;</td>
						<td style="width: 10%"><c:out value="${result.equipmentUnitNm}"/>&nbsp;</td>
						<td style="width: 15%"><c:out value="${result.equipmentPrice}"/>&nbsp;</td>
						<td style="width: 20%"><c:out value="${result.equipmentUseDate}"/>&nbsp;</td>
						<td style="width: 10%"><a onclick="deletecheck(${result.equipmentUsePk})" style="cursor:pointer">삭제</a>&nbsp;</td>
				    </tr>
				</c:forEach> 
			</tbody>
		</table>
			<div>
				<ui:pagination paginationInfo="${paginationInfo4}" type="image04"
					jsFunction="pageLink4" />
				<form:hidden path="pageIndex4" />
			</div>		
	</div>
	
	<!-- /List -->

</div>

	<!-- 등록버튼 -->
	<div id="sysbtn1" align="left">
		<ul>
			<li>
				<div id="sysbtn">
					<input type = "button" id = "addEquipUse" onclick = "modalEquipUse()" value="등록" />
				</div>
			</li>
		</ul>
	</div>
</form:form>

	<div id="modal-body" >
		<form id="bidForm" action="${pageContext.request.contextPath}/equipmentUse/addEquipmentUse.do">
			
			<label for="exampleInputName2">장비명(인력명)</label><br/>
				<select id="categoryCode" name="equipmentId" class="combo" required="required">
				</select> <br/>
				
			<label for="exampleInputName2">사용자</label> <br/>
			<input type="text" id="mbrId" name="mbrId" value="${loginInfo.mbrId}" readonly="readonly"/> <br>
			
			<label for="exampleInputName2">사용량(인원수)</label> <br/>
			<input type="text" id="equipmentQuantity" name="equipmentQuantity" style="width:70px" "required="required"/>
			
				<select id="equipmentUnit" name="equipmentUnit" class="combo" required="required">
					<option value="" >단위선택</option>
						<c:forEach var="code" items="${UnitList}">
							<option value="${code.code}">${code.codeNm}</option>
						</c:forEach>
				</select> <br>
				
			<label for="exampleInputName2">비용</label> <br/>
			<input type="text" id="equipmentPrice" name="equipmentPrice" required="required" required="required"/> <br>
			
			<label for="exampleInputName2">사용일자</label> <br/>
			<input type="text" id="equipmentUseDate" name="equipmentUseDate" required="required"/> <br>
			
			<button id="bidbtnModal" type="submit" class="btn btn-info">등록</button>
		</form>
	</div>

</body>
</html>
