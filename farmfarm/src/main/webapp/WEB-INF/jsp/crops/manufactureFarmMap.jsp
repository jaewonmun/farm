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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
#content_pop, #tableList, #sysbtn, #title, #paging {
    width: 80%;
    margin: 0 auto;
}
</style>
<script>
$(function(){
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
});
function updateCood(code){
	window.open("${pageContext.request.contextPath}/crops/updateCoopView.do?itemCode="+code, "Coop", "width=728, height=540, left=10, top=5");
}
function deletecheck(code){
	$("#itemCodeDelete").val(code);
	$( "#dialog" ).dialog( "open" );
}
</script>
<title>다음 지도 API</title>
</head>
<body>

	<c:if test="${loginInfo == null }">
		<jsp:forward page="/mbr/loginView.do" />
	</c:if>

	<div id="content_pop">
		<h3>작물 관리</h3>
		<%-- <p>${resultList}</p> --%>
		<b>변경은 각각의 버튼을 이용하시면 됩니다.</b><br>
		<b>삭제는 신중하게 결정하세요.</b><br>
		<b style="color: red;">작물 삭제시 해당 작물과 관련된 모든정보(일지, 판매기록)가 사라집니다.</b><br>
		<b>관련 문의는 053-000-0000으로 연락바랍니다.</b>
	<hr>
	</div>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
<form:hidden path="pageIndex" />	
</form:form>
	<div id="tableList" style="">
		<table class="table table-hover">	  
			<thead>
				<th>작물이름</th>
				<th style="text-align: center;">대표이미지변경</th>
				<th>위치변경</th>
				<th style="text-align: center;">선색변경</th>
				<th>삭제</th>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
		<!-- 이름 표시 부분 -->
				<td style="width:15%"><c:out value="${result.scode}"/>&nbsp;</td>
		<!-- 작물 사진 수정 부분 -->
				<td style="width:35%" style="text-align: center;">
					<form action="${pageContext.request.contextPath}/crops/updateCropsImage.do" method="post" enctype="multipart/form-data">
						<input id="mbrId" name="mbrId" value="${result.mbrId}" hidden="hidden"/>
						<input id="itemCode" name="itemCode" value="${result.itemCode}" hidden="hidden"/>
						<div class="row">
							<div class="col-xs-6">
								<input id="uploadImageTemp" name="uploadImageTemp" type="file" style="border:0px;"/>
							</div>
						<div class="col-xs-6" style="width:20px;">
						</div>
							<div class="col-xs-6" style="width:80px;">
								<button>변경</button>
							</div>
						</div>
					</form>
				</td>
		<!-- 지도 위치 수정 부분 -->
				<td style="width:15%">
					<a onclick="updateCood(${result.itemCode})">위치변경</a>&nbsp;
				</td>
		<!-- 선 색깔 수정 부분 -->
				<td style="width:25%" style="text-align: center;">
					<form action="${pageContext.request.contextPath}/crops/updateCrops.do">
						<input id="mbrId" name="mbrId" value="${result.mbrId}" hidden="hidden"/>
						<input id="itemCode" name="itemCode" value="${result.itemCode}" hidden="hidden"/>
						<input id="strokeColor" name="strokeColor" type="color" value="${result.strokeColor}" style="width:100px;"/>
						<button>변경</button>
					</form>
				</td>
		<!-- 작물 삭제 부분 -->
				<td style="width:10%"><a onclick="deletecheck(${result.itemCode})">삭제</a>&nbsp;</td>
   			</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div id="paging" style="text-align: center;">

		<ui:pagination paginationInfo = "${paginationInfo}"
				   type="image"
				   jsFunction="fn_egov_link_page"
				   />
		
	</div>

	
	<!-- 삭제경고 모달 -->
	<div id="dialog" title="경고">
		<p id="dateUpdate" class="validateTips" style="font-size: 15px;"></p>
		<form action="${pageContext.request.contextPath}/crops/deleteCrops.do"  method="post">
		<fieldset>
			<p>정말 삭제하시겠습니까?</p>
			<b style="color: red;">작물 삭제시 해당 작물과 관련된</b><br>
			<b style="color: red;">모든정보(일지, 판매기록)가 사라집니다.</b><br><br>
			<input type="text" name="itemCode" id="itemCodeDelete" hidden="hidden"/>
			<input type="text" name="mbrId" id="mbrId" value="${loginInfo.mbrId}" hidden="hidden"/>
		</fieldset>
		<button>삭제</button>
		</form>
	</div>
</body>
</html>