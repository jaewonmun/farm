<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ImgUrl" value="/images/egovframework/com/cmm/"/>
<c:set var="CssUrl" value="/css/egovframework/com/"/>
<%
 /**
  * @Class Name : FarmingDiaryList.jsp
  * @Description : FarmingDiary List 화면
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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<title>목록</title>

<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
	  #title, #title1, #tabs, #paging, #sysbtn{
	    width: 80%;
	    margin: 0 auto;
	}
</style>


<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */


function fn_egov_select(farmingDiarySeq) {
	document.getElementById("listForm").farmingDiarySeq.value = farmingDiarySeq;
   	document.getElementById("listForm").action = "<c:url value='/farmingDiary/updateFarmingDiaryView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
   	document.getElementById("listForm").action = "<c:url value='/farmingDiary/addFarmingDiaryView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/farmingDiary/FarmingDiaryList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
</head>

<body>
<%-- <DIV id="content" style="width:712px">
<table width="100%" cellpadding="1" class="table-search" border="0">
 <tr>
  <td class="title_left">
  	<h1>
  		<img src="<c:url value="${ImgUrl}" />icon/tit_icon.gif" width="16" height="16" hspace="3" align="middle"  alt="제목아이콘이미지">&nbsp;일정관리 목록
  	</h1>
  </td>
  <tr>
  	<td height="10"></td>
  </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" summary="월별일정보기, 주간별일정보기, 일별일정보기 입니다.">
<tr>
  <td height="20" width="100" bgcolor="#DDDDDD" style="cursor:hand;cursor:pointer;" align="center" id="tabMenu0" onClick="fnTabMenuSelect(0);"><b>월별일정보기</b></td>
  <td height="20" width="1" bgcolor="#FFFFFF"></td>
  <td height="20" width="100"  bgcolor="#DDDDDD" style="cursor:hand;cursor:pointer;" align="center" id="tabMenu1" onClick="fnTabMenuSelect(1);"><b>주간별일정보기</b></td>
  <td height="20" width="1" bgcolor="#FFFFFF" ></td>
  <td height="20" width="100" style="cursor:hand; cursor:pointer;" bgcolor="#DDDDDD" align="center" id="tabMenu2" onClick="fnTabMenuSelect(2);"><b>일별일정보기</b></td>
  <td height="20" width="1" bgcolor="#FFFFFF"> </td>
</tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
  <td height="3" bgcolor="#DDDDDD"></td>
</tr>
</table>
<iframe id="SchdulView" width="100%" height="700" frameborder="0" scrolling="no" marginwidth="0" marginheight="0" title="일정관리">
</iframe>
<form name="IndvdlSchdulManageVO" id="IndvdlSchdulManageVO" action="?" method="post">
<input type="hidden" name="schdulId" id="schdulId" value="" />
<input type="hidden" name="schdulBgnde" id="schdulBgnde" value="" />
<input type="hidden" name="schdulEndde" id="schdulEndde" value="" />
<div style="visibility:hidden;display:none;"><input name="iptSubmit" type="submit" value="전송" title="전송"></div>
</form>


</DIV>
 --%></body>

<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	<input type="hidden" name="farmingDiarySeq" />
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li>영농일지 목록</li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<!-- List -->
	<div id="table">
		<table  class="table table-hover" width="100%" border="0" cellpadding="0" cellspacing="0">
			<thead>
				<th>게시글번호</th>
				<th>사용자ID</th>
				<th>ItemCode</th>
				<th>작성일</th>
				<th>제목</th>
				<th>내용</th>
				<th>Remark</th>
				<th>첨부파일</th>
				<th>기상상태</th>
				<th>최저기온</th>
				<th>최고기온</th>
				<th>강수량</th>
				<th>적설량</th>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			
				<tr>
						<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.farmingDiarySeq}"/>')"><c:out value="${result.farmingDiarySeq}"/></a>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.mbrId}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.itemCode}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.diaryDate}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.diarySubject}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.diaryContent}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.remark}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.diaryUploadFile}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.weatherStatus}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.lowestTemp}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.highestTemp}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.rainfall}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.snowfall}"/>&nbsp;</td>
				   </tr>
			</c:forEach>
			</tbody>
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
					<span class="btn_blue_l"><a href="javascript:fn_egov_addView();">등록</a>
					</span>
				</div>
			</li>
		</ul>
	</div>
</div>
</form:form>
</body>
</html>
