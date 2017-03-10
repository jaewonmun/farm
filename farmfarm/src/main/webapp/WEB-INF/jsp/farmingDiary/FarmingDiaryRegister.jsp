<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : FarmingDiaryRegister.jsp
  * @Description : FarmingDiary Register 화면
  * @Modification Information
  * 
  * @author 박석현
  * @since 20161122
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<c:set var="registerFlag" value="${empty farmingDiaryVO.farmingDiarySeq ? '등록' : '수정'}"/>

<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script -->
<!-- validator:javascript formName="farmingDiaryVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("detailForm").action = "<c:url value='/farmingDiary/FarmingDiaryList.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("detailForm").action = "<c:url value='/farmingDiary/deleteFarmingDiary.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("detailForm");

	/* TODO Validation기능 보완 */
	
  	frm.action = "<c:url value="${registerFlag == '등록' ? '/farmingDiary/addFarmingDiary.do' : '/farmingDiary/updateFarmingDiary.do'}"/>";
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="farmingDiaryVO" name="detailForm" id="detailForm" >
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images//title_dot.gif'/>" alt="" /><c:out value="${registerFlag}"/></li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<div id="table">
	<table width="100%" border="1" cellpadding="0" cellspacing="0" >
		<colgroup>
			<col width="150"/>
			<col width=""/>
		</colgroup>
			
		<c:if test="${registerFlag == '수정'}">
	   <tr>
			<th>FARMING_DIARY_SEQ *</th>
			<td>
				<form:input path="farmingDiarySeq" cssClass="essentiality" readonly="true" />
			</td>			
		</tr>	
		</c:if>
		<c:if test="${registerFlag == '등록'}">
	   <tr>
			<th>FARMING_DIARY_SEQ *</th>
			<td>
				<form:input path="farmingDiarySeq" cssClass="txt" readonly="false" />
			</td>			
		</tr>	
		</c:if>		
		<tr>
			<th>MBR_ID</th>
			<td>
				<form:input path="mbrId" cssClass="txt"/>
				&nbsp;<form:errors path="mbrId" />
			</td>
		</tr>	
		<tr>
			<th>ITEM_CODE</th>
			<td>
				<form:input path="itemCode" cssClass="txt"/>
				&nbsp;<form:errors path="itemCode" />
			</td>
		</tr>	
		<tr>
			<th>DIARY_DATE</th>
			<td>
				<form:input path="diaryDate" cssClass="txt"/>
				&nbsp;<form:errors path="diaryDate" />
			</td>
		</tr>	
		<tr>
			<th>DIARY_SUBJECT</th>
			<td>
				<form:input path="diarySubject" cssClass="txt"/>
				&nbsp;<form:errors path="diarySubject" />
			</td>
		</tr>	
		<tr>
			<th>DIARY_CONTENT</th>
			<td>
				<form:input path="diaryContent" cssClass="txt"/>
				&nbsp;<form:errors path="diaryContent" />
			</td>
		</tr>	
		<tr>
			<th>REMARK</th>
			<td>
				<form:input path="remark" cssClass="txt"/>
				&nbsp;<form:errors path="remark" />
			</td>
		</tr>	
		<tr>
			<th>DIARY_UPLOAD_FILE</th>
			<td>
				<form:input path="diaryUploadFile" cssClass="txt"/>
				&nbsp;<form:errors path="diaryUploadFile" />
			</td>
		</tr>	
		<tr>
			<th>WEATHER_STATUS</th>
			<td>
				<form:input path="weatherStatus" cssClass="txt"/>
				&nbsp;<form:errors path="weatherStatus" />
			</td>
		</tr>	
		<tr>
			<th>LOWEST_TEMP</th>
			<td>
				<form:input path="lowestTemp" cssClass="txt"/>
				&nbsp;<form:errors path="lowestTemp" />
			</td>
		</tr>	
		<tr>
			<th>HIGHEST_TEMP</th>
			<td>
				<form:input path="highestTemp" cssClass="txt"/>
				&nbsp;<form:errors path="highestTemp" />
			</td>
		</tr>	
		<tr>
			<th>RAINFALL</th>
			<td>
				<form:input path="rainfall" cssClass="txt"/>
				&nbsp;<form:errors path="rainfall" />
			</td>
		</tr>	
		<tr>
			<th>SNOWFALL</th>
			<td>
				<form:input path="snowfall" cssClass="txt"/>
				&nbsp;<form:errors path="snowfall" />
			</td>
		</tr>	
	</table>
  </div>
	<div id="sysbtn">
		<ul>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_selectList();">List</a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_save();"><c:out value='${registerFlag}'/></a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li>
			<c:if test="${registerFlag == '수정'}">
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_delete();">삭제</a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li>
			</c:if>
			<li><span class="btn_blue_l"><a href="javascript:document.detailForm.reset();">Reset</a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

