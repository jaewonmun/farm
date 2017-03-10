<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : JobProcessList.jsp
  * @Description : JobProcess List 화면
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>목록</title>

<!-- 병해충검색 시작-->
<link href="http://ncpms.rda.go.kr/css/api.css" rel="stylesheet" type="text/css"><!-- CSS 선언 -->
<script type="text/javascript" src="http://ncpms.rda.go.kr/js/framework.js"></script><!-- 공통 JS 선언 -->	
<script type="text/javascript" src="http://ncpms.rda.go.kr/js/openapi_dngss.js"></script><!-- 공통 JS 선언 -->

<script type="text/javascript">
npmsApiRequestInfo.apiKey = "20161118HLJYAZGGW2TWMUHSPSKEW";//apiKey - NCPMS에서 신청 후 승인되면 확인 가능
npmsApiRequestInfo.serviceCode = "SVC11"; // 사진검색 1의 서비스코드(상세한 내용은 Open API 이용안내 참조)
npmsApiRequestInfo.callback = "${pageContext.request.contextPath}/callback/ajax_local_callback.jsp";//Call Back URL : 제공하는 callBack 페이지를 서버에 배포후 해당 경로를 적용
</script>
<!-- 병해충검색 끝-->

<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */


function fn_egov_select(jobSeq) {
	document.getElementById("listForm").jobSeq.value = jobSeq;
   	document.getElementById("listForm").action = "<c:url value='/jobProcess/updateJobProcessView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
   	document.getElementById("listForm").action = "<c:url value='/jobProcess/addJobProcessView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/jobProcess/JobProcessList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
</head>
<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	<input type="hidden" name="jobSeq" />
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images/example/farmlogo.gif'/>" alt="title" /> List </li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<!-- List -->
	<div id="table">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<colgroup>
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
							</colgroup>		  
			<tr>
								<th align="center">JobSeq</th>
								<th align="center">MbrId</th>
								<th align="center">ItemCode</th>
								<th align="center">FarmingProcess</th>
								<th align="center">JobProcess</th>
							</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
													<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.jobSeq}"/>')"><c:out value="${result.jobSeq}"/></a>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.mbrId}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.itemCode}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.farmingProcess}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.jobProcess}"/>&nbsp;</td>
				    			</tr>
			</c:forEach>
		</table>
	</div>
	<!-- /List -->
	<div id="paging">
		<ui:pagination paginationInfo = "${paginationInfo}"
				   type="image"
				   jsFunction="fn_egov_link_page"
				   />
		<form:hidden path="pageIndex" />
	</div>
	<div id="sysbtn1">
		<ul>
			<li>
				<div id="sysbtn">
					<span class="btn_blue_l"><a href="javascript:fn_egov_addView();">등록</a><img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" alt="" />
					</span>
				</div>
			</li>
		</ul>
	</div>
</div>
</form:form>
<!-- 병해충검색 시작 -->
<!-- HTML 로딩 영역(DIV 태그의 ID는 변경 금지) -->
<div id="npms_api_data"></div>
<!-- 병해충검색 시작 -->
</body>
</html>
