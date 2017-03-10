




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title></title>






	
		<meta http-equiv="X-UA-Compatible" content="IE=10" />
	
	


<link rel="stylesheet" type="text/css" href="/common/css/common.css" />	
<script src="/common/js/jquery-1.8.3.js" type="text/javascript"></script>
<script src="/common/js/common.js" type="text/javascript"></script>
<script src="/common/js/product/statlayer.js" type="text/javascript"></script>
<script src="/common/js/slideshow.js" type="text/javascript"></script>
<!-- bxSlider Javascript file -->
<script src="/common/js/jquery.bxslider.js"></script>
<!-- 이미지 슬라이드에 사용 -->
<script src="/common/js/jquery-ui-1.9.1.js" type="text/javascript"></script>
<script src="/common/js/jquery.mousewheel.js" type="text/javascript"></script>
<script src="/common/js/jquery-ui.custom.js" type="text/javascript"></script>
<script src="/common/js/jquery.zclip.js" type="text/javascript"></script>
<script src="/common/js/jquery.colorbox.js" type="text/javascript"></script>
<script src="/common/js/jquery.printElement.js" type="text/javascript"></script>
<script src="/common/js/jquery.number.min.js" type="text/javascript"></script>
<!-- 커뮤니티 공통레이어 -->
<script src="/common/js/community/communityLayer.js" type="text/javascript"></script>
<!-- 커뮤니티 이미지미리보기 -->
<script src="/common/js/community/communityImagePreview.js" type="text/javascript"></script>
<script src="/common/js/jquery.form.js" type="text/javascript"></script>
<!-- 커뮤니티 로그인체크 -->
<script src="/common/js/common/sessionCheck.js" type="text/javascript"></script>
<script src="/common/js/html5shiv.js"></script>
	
<script type="text/javascript">
	var c_url = '';
	c_url = (c_url.length < 2)? '/':c_url+'/';
</script>

</head>
<body>
<dl id="skip">
	<dt>본문 바로가기 링크</dt>
	<dd><a href="#content">바로가기</a></dd>
</dl>
<header>
	<div class="inner">
		


<script src="/common/js/cookie.js" type="text/javascript"></script>

<script type="text/javascript">


/* byte 계산 및 제한 */
//function rtnStringByte(id, _str){
//	var str = _str ? _str : $("#"+id).val();
//	var strLength = str.length;
//	var strByteLength = 0;
//	
//	/* 
//	 * c를 2048로 나누어 몫이 있으면 3byte, 그보다 작을때 128로 나누어 몫이 있으면 2byte, 그 외는 1byte.
//	 * byte가 500보다 클 경우 br에 글자 수 저장.
//	 */
//	strByteLength = (function(s, b, i, c, br, f){	// s=str, b=byte. i=var, c=char, br=break, flag
//		for(b=i=0, f=true;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1, f&&b>500?(br=i, f=false):true);
//		if(b<=500){
//			$("#"+id).val(str);
//			$("#"+id+"Byte").html("<b>"+b+"</b> /500 byte");
//		}else if(br){
////			alert("500byte를 초과 하였습니다.");
//			str = str.substr(0, br-1);
//			rtnStringByte(id, str); // 재귀
//		}
//	})(str);
//}
function rtnStringByte(id, maxByte){
	var obj = document.getElementById(id);
	var str = obj.value;
	var str_len = str.length;

	var rbyte = 0;
	var rlen = 0;
	var one_char = "";
	var str2 = "";

	for(var i=0; i<str_len; i++){
		one_char = str.charAt(i);
		if(escape(one_char).length > 4){
		    rbyte += 2;                                         //한글2Byte
		}else{
		    rbyte++;                                            //영문 등 나머지 1Byte
		}

		if(rbyte <= maxByte){
			rlen = i+1;                                          //return할 문자열 갯수
		}
	}
	if(rbyte > maxByte){
	    alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	    str2 = str.substr(0,rlen);                                  //문자열 자르기
	    obj.value = str2;
	    fnChkByte(obj, maxByte);
	}else{
		$("#"+id+"Byte").html("<b>"+rbyte+"</b> /500 byte");	
	}
}

/*
 * 지역정보 찿기 popup
 */
function openGnbPopup(){ // 이후 진행은 product/statlayer.js 참고
	$("#areaSelectLayer").css("top", "130px").css("left", "225px").show();
}

/**/
function searchLocalWeatherInfo(){ // product/statlayer.js 의 함수 구현
	selList("", "T");
	setCookie("weatherstat",$("#statHdn").val(), 30);
	setCookie("weatherstatname",$("#statSpan").text(), 30);

	var localAreaCode = $("#statHdn").val().split("|");
	var localAreaName = $("#statSpan").text().split(" ");
	var area = {
		code:localAreaCode[1],
		stat:localAreaCode[2],
		type:"getInfo"
	};
	
	$.ajax({
		type: "post",
		url	:c_url+"product/getAreaTopList.do",
		data: area,
		dataType:"json",
		success:function(result){
			var rs = result.apiList;
			var temp = rs.temp+"<span>℃</span>";
			var tMaxMin = (rs.tmm == "-999.0" ? "-" : rs.tmm+"℃") + "<br/>" + (rs.tmn == "-999.0" ? "-" : rs.tmn+"℃");
			$(".weather dl dd[class=tem]").html(temp);
			$(".weather dl dd[class=temHigh]").html(tMaxMin);
		},
		error:function(xhr, tst, err){
			console.log(xhr, tst, err)
		}
	});
}


/*레이어 중간정렬*/
function layerAlignCenter(){
//	var $layerPopupObj = $('.diaryWrite, .diaryView, .todoView');
	var $layerPopupObj = $('.diaryWrite, .diaryView');
	var left = ( $(window).scrollLeft() + ($(window).width() - $layerPopupObj.width()) / 2 );
	var top = ( $(window).scrollTop() + ($(window).height() - $layerPopupObj.height()) / 2 );
	$layerPopupObj.css({'left':left,'top':top, 'position':'absolute'});
	
	left = ( $(window).scrollLeft() + ($(window).width() - $('.todoView').width()) / 2 );
	top = ( $(window).scrollTop() + ($(window).height() - $('.todoView').height()) / 2 );
	$('.todoView').css({'left':left,'top':top, 'position':'absolute'});
//	$('body').css('position','relative').append($layerPopupObj);
}

/* 영농일정 입력 창 생성 */
function popupSchdWriteLayer(e, idx, type){
	$.ajax({
		type:'POST',
		url:c_url+'product/checkSession.do',
		data:{},
		success:function(data){
			
			if(data.loginUrl != ""){						// 세션 종료시
				if( confirm("세션이 종료되었습니다. 로그인 하시겠습니까?") ){
					document.location.href = data.loginUrl + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
				}else{
					return;
				}
				
			}else{	
				
				layerAlignCenter();
				
				var _date = "";
				if(type=="cal"){
					_date = $("#cellNum"+idx).attr("date");
				}else if(type=="list"){
					_date = $("#listNum"+idx).attr("date");
				}
				_date = _date.substr(0,4)+"-"+_date.substr(4,2)+"-"+_date.substr(6,2);
				
				$("#schduWriteType").val("0"); // 값초기화
				
				$("#addSchdul").text("등록");
				$("#delSchdul").attr("style" , "display:none");//삭제버튼
				$("#decpt02, #tarea02").val("");	// 제목, 내용 초기화
				$("#tarea02Byte b").html("0");	// 내용 byte 초기화
			
				$("#taskStartDt, #taskEndDt").val(_date + addTextLunar(_date));	// 날짜 초기화
				if($(".timeLine input:checkbox").attr("checked")=="checked"){	// 체크박스 초기화
					$(".timeLine input:checkbox").click();
				}
				$("#taskStartTm option:first, #taskEndTm option:first, #decpt03 option:first").attr("selected", true);	// selectbox 초기화
				
				$(".todoView").show();
				e.preventDefault ? e.preventDefault(): e.returnValue = false;
				wrapWindowByMask();
			}
		},
		error:function(xhr, sts, err){
			
		}
	})
}


/*
 * 일정 정보 수정 및 저장 레이어 팝업 
 * e: 이벤트 object
 * sn: 키값 
 * */
function popupTodoLayer(e , sn){
	layerAlignCenter();
	//sn = "1021";
	//초기화
	var fmDate =$.datepicker.formatDate($.datepicker.ATOM, new Date()); 
	$("#addSchdul").text("등록");
	$("#schduWriteType").val("0");//key값
	$("#decpt02, #tarea02").val("");	// 제목, 내용 초기화
	$("#tarea02Byte").val("<b>0</b> /500 byte");	// 내용 byte 초기화
	$("#taskStartDt, #taskEndDt").val(fmDate + addTextLunar(fmDate));	// 날짜 초기화
	$("#delSchdul").attr("style" , "display:none");
	
	if($("#ck").is(":checked")){	// 체크박스 초기화
		$("#ck").click();
	}

	$("#taskStartTm option:first, #taskEndTm option:first, #decpt03 option:first").attr("selected", true);	// selectbox 초기화
	//수정
	if(sn != null && sn != "0"){
		var diaryData = {
//			"userId":"testadmin",
			"schdulSn":sn
		}
		var _url = "";
		_url = c_url+"product/selectSchdul.do";
		$.ajax({
			type : "POST",
			url	: _url,
			data: diaryData,
			dataType:"json",
			success:function(data){
				if(data.loginUrl != ""){
					if( confirm("세션이 종료되었습니다. 로그인 하시겠습니까?") ){
						document.location.href = data.loginUrl + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
					}else{
						return;
					}
				}else if(typeof data.schMap =="undefined" ){
					alert("해당 정보는 이미 삭제 되었거나 존재하지 않는 정보입니다.");
					return;
				}else{
					$("#delSchdul").attr("style" , "display:block");//삭제버튼
					$("#addSchdul").text("수정");
					$("#schduWriteType").val(data.schMap.schdulSn);//key값
					$("#decpt02, #tarea02").val(data.schMap.schdulSj);	// 제목, 내용 초기화
					$("#tarea02").val(data.schMap.alarmMemo);
					rtnStringByte('tarea02');
					
					var strFDate = data.schMap.fromDate;
					if(strFDate != null && strFDate.length == 8){
						var strartDate = strFDate.substring(0,4) +"-"+strFDate.substring(4,6)+"-"+strFDate.substring(6,8);
						$("#taskStartDt").val(strartDate + addTextLunar(strartDate));	// 날짜 초기화
					}else{
						alert("날짜 정보가 잘못 저장되었습니다.");
					}
					
					var strEDate = data.schMap.todate;
					if(strEDate != null && strEDate.length == 8){
						var endDate = strEDate.substring(0,4) +"-"+strEDate.substring(4,6)+"-"+strEDate.substring(6,8);
						$("#taskEndDt").val(endDate + addTextLunar(endDate));	// 날짜 초기화
					}else{
						alert("날짜 정보가 잘못 저장되었습니다.");
					}
					if($(".timeLine input:checkbox").attr("checked")=="checked"){	// 체크박스 초기화
						$(".timeLine input:checkbox").click();
					}
					
					//시간
					$("#taskStartTm").val(data.schMap.fromHm);
					$("#taskEndTm").val(data.schMap.toHm);

					if(data.schMap.alldayYn=="Y"){
						$("#ck").click();
					}
					
					$(".todoView").show();
					e.preventDefault ? e.preventDefault(): e.returnValue = false;
					wrapWindowByMask();
				}
				//$("#taskStartTm option:first, #taskEndTm option:first, #decpt03 option:first").attr("selected", true);	// selectbox 초기화
			},
			error:function(xhr, tst, err){
				console.log(xhr, tst, err)
				layerClose();
			}
			
		});
	}
}

/* 영농일지 VIEW LAYER 생성 */
function diaryViewGo(e , sn){
	layerAlignCenter();
	
	if(sn!=0 && sn!=undefined){
		var yyyyMM = $("#yearViewSpan").html()+tensNum($("#monthViewSpan").html());
		$.ajax({
			type : "POST",
			url	: c_url+"product/selectViewDiary.do",
			data: {
//				"userId":"testadmin",
				"diarySn":sn,
				"currentDate":yyyyMM
			},
			dataType:"json",
			success:function(data){
				if(data.loginUrl != ""){
					if( confirm("세션이 종료되었습니다. 로그인 하시겠습니까?") ){
						document.location.href = data.loginUrl + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
					}else{
						return;
					}
				}else if(typeof data.sdMap =="undefined" ){
					alert("해당 정보는 이미 삭제 되었거나 존재하지 않는 정보입니다.");
					return;
				}else{
					var sdObj = data.sdMap;
					var stObj = data.stMap;
					var hlObj = data.hlMap;
					var specialDayHtml = "";
					$("#diaryViewSn").val(sdObj.diarySn);		//key값
					$("#diaryViewTitle").html(sdObj.diarySj);	// 제목
					$("#ryOpenCnDiv").html(sdObj.diaryCn);
					//$("#diaryViewContent").html(sdObj.diaryCn);	// 내용
					var obj = "#"+sdObj.wethrCode;
					
					var wthList = {
						"190001":"wtRy07",
						"190002":"wtRy04",
						"190003":"wtRy05",
						"190004":"wtRy06",
						"190005":"wtRy03",
						"190006":"wtRy02",
						"190007":"wtRy01"
					}
					$("#diaryViewWetherImg").attr('src', c_url+"images/product/"+wthList[sdObj.wethrCode]+".gif");
					
					var strFDate = sdObj.diaryDe;
					if(strFDate != null && strFDate.length == 8){
						var dYear = strFDate.substring(0,4);
						var dMonth = strFDate.substring(4,6);
						var dDay = strFDate.substring(6,8);
						var strartDate = dYear +"-"+ dMonth +"-"+ dDay;
						
						var dtHtml = "<b>" + dYear + "년 " + dMonth + "월 " + dDay + "일 </b>"
									+ addTextLunar2(strartDate);
						$("#diaryViewDate").html(dtHtml);	// 날짜 초기화
						
						var solarDate = new myDate(dYear, dMonth, dDay);
				        var lunarDate = lunarCalc(dYear, dMonth, dDay, 1);
				        var memorial = memorialDayCheck2(solarDate, lunarDate, hlObj);

				        if(memorial){
				        	specialDayHtml = memorial.hldyNm;						// 공휴일
				        }else{
				        	for(var sd=0; sd<stObj.length; sd++){
					        	if(stObj[sd].ymd.substr(6) == dDay){
					        		specialDayHtml = stObj[sd].solarTermNm;		// 24절기
					        	}
				        	}
				        }
				        
					}else{
						alert("날짜 정보가 잘못 저장되었습니다.");
					}
					
					$("#diaryViewWeather").html(specialDayHtml);
					
					$(".diaryView").show();
					e.preventDefault ? e.preventDefault(): e.returnValue = false;
					wrapWindowByMask();
				}	
			},error:function(xhr, tst, err){
				console.log(xhr, tst, err);
				layerClose();
			}
		})
	}
}

function changeUpdateLayer(e){
	$(".diaryView").hide();
	var sn = $("#diaryViewSn").val();
	popupDiaryWriteLayer(e, sn);
}

/* 영농일지 INSERT / UPDATE LAYER 생성*/
function popupDiaryWriteLayer(e , sn){
	layerAlignCenter();

	oEditors.getById["se2"].exec("SET_IR", [""]); 
	
	$("#decpt").val("");
	// 제목, 내용 초기화
	var fmDate =$.datepicker.formatDate($.datepicker.ATOM, new Date()); 
	$("#date").val(fmDate + addTextLunar(fmDate));		// 날짜 초기화
	$("#diaryWriteType").val("0");//key값
	$("#delDiary").attr("style" , "display:none");//삭제버튼
	for(var i=1;i<=7;i++){
		imgObj = $("#19000" +i );
		imgObj.attr('src', imgObj.attr('src').replace('_on', ''));
		imgObj.removeClass('on');
	}
	$("#addDiary").text("등록");
//	if(sn != null && sn != "0"){
	var diaryData = {
//			"userId":"testadmin",
		"diarySn":sn
	};
	var _url = "";
	_url = c_url+"product/selectDiary.do";
	$.ajax({
		type : "POST",
		url	: _url,
		data: diaryData,
		dataType:"json",
		success:function(data){
			if(data.loginUrl != ""){						// 세션 종료시
				if( confirm("세션이 종료되었습니다. 로그인 하시겠습니까?") ){
					document.location.href = data.loginUrl + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
				}else{
					return;
				}
				
			}else if( data.sn == 0 || data.sn == null ){	// 최초 작성시
				$("#190001").attr('src', $("#190001").attr('src').replace(".gif", "_on.gif"));
				$("#190001").addClass('on');
				
				$(".diaryWrite").show();
				/* IE의 경우 hide-show 과정이 들어가면 iframe내로 포커스가 안잡히는 현상이 발생. 그를 위한 후처리 부분 */
				oEditors.getById["se2"].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
				oEditors.getById["se2"].exec("RESET_TOOLBAR");
				wrapWindowByMask();
				$("#decpt").focus();
				
			}else if(typeof data.sdMap =="undefined" ){		// 데이터 미 존재시
				alert("해당 정보는 이미 삭제 되었거나 존재하지 않는 정보입니다.");
				return;
				
			}else{											// 수정시
				$("#addDiary").text("수정");
//					$("#delDiary").attr("style" , "display:block");//삭제버튼
				$("#diaryWriteType").val(data.sdMap.diarySn);//key값
				$("#decpt").val(data.sdMap.diarySj);	// 제목
				var imgtag = data.sdMap.diaryCn;
				oEditors.getById["se2"].exec("PASTE_HTML", [imgtag]);
				
				var obj = "#"+data.sdMap.wethrCode;
				$(obj).attr('src', $(obj).attr('src').replace(".gif", "_on.gif"));
				$(obj).addClass('on');
				//rtnStringByte('tarea02');
				var strFDate = data.sdMap.diaryDe;
				if(strFDate != null && strFDate.length == 8){
					var strartDate = strFDate.substring(0,4) +"-"+strFDate.substring(4,6)+"-"+strFDate.substring(6,8);
					$("#date").val(strartDate + addTextLunar(strartDate));	// 날짜 초기화
				}else{
					alert("날짜 정보가 잘못 저장되었습니다.");
				}
				
				$(".diaryWrite").show();
				/* IE의 경우 hide-show 과정이 들어가면 iframe내로 포커스가 안잡히는 현상이 발생. 그를 위한 후처리 부분 */
				oEditors.getById["se2"].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
				oEditors.getById["se2"].exec("RESET_TOOLBAR");
				wrapWindowByMask();
				$("#decpt").focus();
				
			}	
		},
		error:function(xhr, tst, err){
			console.log(xhr, tst, err)
			layerClose();
		}
		
	});
//	}else{
//		$("#190001").attr('src', $("#190001").attr('src').replace(".gif", "_on.gif"));
//		$("#190001").addClass('on');
//	}

	e.preventDefault ? e.preventDefault(): e.returnValue = false;
}

/* diary update layer clear & init */
/*function popupDiaryUpdateLayer(e){
	var udtTitle = $("#diaryViewTitle").text();
	var udtDate = $("#diaryViewDate").text();
	var udtWeather = $("#diaryViewWeather").text();
	var udtContent = $("#diaryViewContent").text();
	udtDate = udtDate.replace("년 ", "-").replace("월 ","-").replace("일","");
	
	$("#diaryWriteType").val("update");						// 삽입/수정 구분
	$(".diaryWrite .rayerTit span").text("일지수정");		// head title 초기화
	$("#decpt").val(udtTitle);								// 제목, 내용 초기화
	//$("#se2").val(udtContent);							// 제목, 내용 초기화
	oEditors.getById["se2"].exec("PASTE_HTML", [udtContent]);
	$("#date").val(udtDate + addTextLunar(udtDate));		// 날짜 초기화
	
	$(".diaryView").hide();
	$(".diaryWrite").show();
	e.preventDefault ? e.preventDefault(): e.returnValue = false;
	wrapWindowByMask();
}*/

function fnTodoDvRemove(){
	$(".todoDv").remove();
}
//일정 삭제
function delSchadul(e){
	if(confirm("일정을 삭제 하시겠습니까?")) {
		var _url = "";
		_url = c_url+"product/saveSchdul.do";
		var diaryData = {
//				"userId":"testadmin",
				"schdulSn":$("#schduWriteType").val() ,//키값
				"deleteYn":"Y"
			}
		$.ajax({
			type : "POST",
			url	: _url,
			data: diaryData,
			dataType:"json",
			success:function(data){
				if(data.result=="success"){
					alert("삭제가 완료 되었습니다.");
				}
				closeReload(e);
			},
			error:function(xhr, tst, err){
				console.log(xhr, tst, err)
			}
		});
	}
}
//일지 삭제
function delDiary(e){
	if(confirm("일지를 삭제 하시겠습니까?")) {
		var _url = "";
		_url = c_url+"product/insertFarmDiary.do";	
		var diaryData = {
//				"userId":"testadmin",
				"diarySn":$("#diaryViewSn").val(),//키값
				"deleteYn":"Y"
			}
		$.ajax({
			type : "POST",
			url	: _url,
			data: diaryData,
			dataType:"json",
			success:function(data){
				if(data.result=="success"){
					alert("삭제가 완료 되었습니다.");
				}
				closeReload(e);
			},
			error:function(xhr, tst, err){
				console.log(xhr, tst, err)
			}
		});
	}
}


function popupDiaryExit(){
	$('.diaryWrite').hide();
}


function setDatepicker(){
	$("#taskStartDt").datepicker({
		onSelect:function(selectedDate){
			var lunarHtml = addTextLunar(selectedDate);
			$('#taskStartDt').val($('#taskStartDt').val()+lunarHtml);
			$('#taskEndDt').val($('#taskEndDt').val().substr(0,10));		// 음력 문장을 제외한 값으로 임시 교체
			$('#taskEndDt').datepicker("option","minDate", selectedDate);
			if($('#taskEndDt').val()!=""){
				$('#taskEndDt').val($('#taskEndDt').val() + addTextLunar($('#taskEndDt').val())); // 음력 문장을 덧대어 생성
			}
		}
	});
	$("#taskEndDt").datepicker({
		onSelect:function(selectedDate){
			var lunarHtml = addTextLunar(selectedDate);
			$('#taskEndDt').val($('#taskEndDt').val()+lunarHtml); 
			$('#taskStartDt').val($('#taskStartDt').val().substr(0,10));	// 음력 문장을 제외한 값으로 임시 교체
			$('#taskStartDt').datepicker("option","maxDate", selectedDate);
			if($('#taskStartDt').val()!=""){
				$('#taskStartDt').val($('#taskStartDt').val() + addTextLunar($('#taskStartDt').val())); // 음력 문장을 덧대어 생성
			}
		}
	});
	$("#date").datepicker({
		onSelect:function(selectedDate){
			var lunarHtml = addTextLunar(selectedDate);
			$('#date').val($('#date').val()+lunarHtml); 
		}
	});
}

/* 지역 정보 검색 창 닫기 */
function layerClose(){
	$(".commonRayer").hide();
}

/* 일지,일정 창 닫은 후 달력 reload */
function closeReload(e){
    e.preventDefault ? e.preventDefault(): e.returnValue = false;  
    $('#mask, .diaryWrite, .diaryView, .todoView').hide();
    var year = $("#yearViewSpan").html();
    var month = $("#monthViewSpan").html();
    setDiaryForm();
}

/* 일정 저장 */
function saveSchadul(e){
	var taskStartDt = $("#taskStartDt").val().split("-").join("").substr(0,8);
	var taskEndDt = $("#taskEndDt").val().split("-").join("").substr(0,8);
	var taskStartTm = $("#taskStartTm").val();
	var taskEndTm = $("#taskEndTm").val();

	if($("#decpt02").val() ==""){
		alert("제목을 입력하세요.");
		$("#decpt02").focus();
		return;
	}else if( taskStartDt == "" ){
		alert("날짜를 입력하세요.");
		$("#taskStartDt").focus();
		return;
	}else if( taskEndDt == ""){
		alert("날짜를 입력하세요.");
		$("#taskEndDt").focus();
		return;
	}else if(taskStartDt > taskEndDt){
		alert("종료일이 시작일보다 이릅니다.");
		$("#taskStartDt").focus();
		return;
	}else if(taskStartDt == taskEndDt && taskStartTm > taskEndTm){
		alert("종료시간이 시작시간보다 이릅니다.");
		$("#taskStartTm").focus();
		return;
	}else if($("#tarea02").val() == ""){
		alert("내용을 입력하세요.");
		$("#tarea02").focus();
		return;
	}

	var ck = 'N';
	if($("#ck").attr("checked")){
		ck = 'Y';
	}
	var diaryData = {
//			"userId":"testadmin",
			"schdulSn":$("#schduWriteType").val() ,		//키값
			"schdulSj":$("#decpt02").val() ,			//제목
			"alarmMemo":$("#tarea02").val() ,			//알람메모
			"fromDate":taskStartDt,						//시작일
			"todate":taskEndDt,							//종료일
			"fromHm":taskStartTm,						//시작시간
			"toHm":taskEndTm,							//종료시간
			"alldayYn":ck  ,							//종일여부
			"alarmTmCode" :$("#decpt03").val()
//			"registerId":"testadmin",
		}
	var _url = "";
	_url = c_url+"product/saveSchdul.do";
	$.ajax({
		type : "POST",
		url	: _url,
		data: diaryData,
		dataType:"json",
		success:function(data){
			if(data.loginUrl != ""){
				if( confirm("세션이 종료되었습니다. 로그인 하시겠습니까?") ){
					document.location.href = data.loginUrl + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
				}else{
					return;
				}
			}else if(data.result=="success"){
				alert("저장 완료 되었습니다.");
			}
			closeReload(e);
		},
		error:function(xhr, tst, err){
			console.log(xhr, tst, err)
//			layerClose();
		}
		
	});
}

//조회
function searchFrm(){
	$("#frm").attr('action',c_url+'product/farmdiary.do').submit();	
}

/* 일지 정보 입력 및 업데이트 */
function insertDiary(e){
	var _url = "";
	_url = c_url+"product/insertFarmDiary.do";	
	var wethrCode = $("#insertDiaryWeatherIcon li a img[class=on]").attr("name");
	//oEditors.getById["se2"].exec("UPDATE_CONTENTS_FIELD", []);
	
	var content = oEditors.getById["se2"].getIR();
	content = content.replace(unescape("%uFEFF"), "");
	                           
	content = content.replace("javascript", "?");
	content = content.replace("cookie", "?");
	content = content.replace("alert", "?");

	var diaryData = {
//		"userId":"testadmin",
		"diarySn":$("#diaryWriteType").val() ,//키값
		"diarySj":$.trim($("#decpt").val()),
		"diaryDe":$("#date").val().split("-").join("").substr(0,8),
		"wethrCode":wethrCode,
		"diaryCn":content
//		"registerId":"testadmin",
	}
	
	if(diaryData.diarySj==""){
		alert("제목을 입력하세요.");
		$("#decpt").focus();
		return;
	}else if(!Number(diaryData.diaryDe) || diaryData.diaryDe.length!=8){
		alert("날짜를 입력하세요.");
		$("#date").focus();
		return;
	}else if(diaryData.diaryCn==""){
		alert("내용을 입력하세요.");
		$("#se2").focus();
		return;
	}
	
	$.ajax({
		type : "POST",
		url	: _url,
		data: diaryData,
		dataType:"json",
		success:function(data){
			if(data.loginUrl != ""){
				if( confirm("세션이 종료되었습니다. 로그인 하시겠습니까?") ){
					document.location.href = data.loginUrl + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
				}else{
					return;
				}
			}else if(data.result=="success"){
				alert("저장 완료 되었습니다.");
			}
			closeReload(e);
//			diaryViewGo(e, $("#diaryWriteType").val());
		},
		error:function(xhr, tst, err){
			console.log(xhr, tst, err)
		}
	});
}

function chgWeatherIcon(idx){
	var imgObj;
	var objId = "#1900"+idx;
	for(var i=1;i<=7;i++){
		imgObj = $("#19000" +i );
		imgObj.attr('src', imgObj.attr('src').replace('_on', ''));
		imgObj.removeClass('on');
	}
	imgObj = $(objId);
	imgObj.attr('src', imgObj.attr('src').replace(".gif", "_on.gif"));
	imgObj.addClass('on');
}

/* 해당 달 영농일지, 영농일정 세팅 시작 */
function calDataSet(arrDate, drObj, scObj){
	for(var i=0; i<arrDate.length; i++){
		for(var k=0;k<drObj.length;k++){
			if( arrDate[i]  == drObj[k].diaryDe ){
				addList.diaryBar("#cellNum"+i, drObj[k].diarySn, drObj[k].wethrCode, drObj[k].diarySj);
			}
		}
	}
	for(var i=0; i<arrDate.length; i++){
		for(var k=0;k<scObj.length;k++){
			if( ( scObj[k].fromDate != scObj[k].todate )
				&& ( scObj[k].fromDate <= arrDate[i] )
				&& ( scObj[k].todate >= arrDate[i] ) ){
				addList.taskBar("#cellNum"+i, arrDate[i], scObj[k].schdulSn, scObj[k].fromDate, scObj[k].fromHm, scObj[k].todate, scObj[k].schdulSj);
			}
		}
	}
	for(var i=0; i<arrDate.length; i++){
		for(var k=0, z=0;k<scObj.length;k++){
			if( ( scObj[k].fromDate == scObj[k].todate )
				&& ( scObj[k].fromDate == arrDate[i] ) ){
				addList.taskBarOnly("#cellNum"+i, arrDate[i], scObj[k].schdulSn, scObj[k].fromDate, scObj[k].fromHm, scObj[k].todate, scObj[k].schdulSj);
			}
		}
	}
}


var addList = {
	diaryBar : function(objStr, sn, wth, title){
		var imgObj = {
				"190001":"sico_shine",
				"190004":"sico_blur",
				"190003":"sico_clouds",
				"190002":"sico_cloud",
				"190005":"sico_rain",
				"190006":"sico_snowrain",
				"190007":"sico_snow"
		};
		var listHtml = "<a href='javascript:void(0);' onClick='diaryViewGo(event, \""+sn+"\")' class='diaryBar'><img src='"+c_url+"images/product/ico/"+imgObj[wth]+".png' alt=''>"+title+"</a>";
		addList.chkMoreList(objStr, 'daily', listHtml, 1, sn)
	},
	taskBar : function(objStr, today, sn, fDt, fHm, tDt, title){
		var idx = objStr.substr(8);
		var colSpanVal = 1;
		var aTagCls= "taskBar";
		var afterArrowHtml = "";
		var beforeArrowHtml = "";
		var loopBreakFlag = false;
		for(var i=idx%7,j=0; i<7; i++,j++){	// colspan 길이 계산
			var tmpDate = new Date(today.substr(0,4), Number(today.substr(4,2))-1, Number(today.substr(6,2))+j);
			var tdYMD = tmpDate.getFullYear()+""+tensNum(tmpDate.getMonth()+1)+""+tensNum(tmpDate.getDate());

			if(j==0 && tdYMD > fDt){	// 전날부터 이어지는지 체크
				beforeArrowHtml = "<b class='pr'>◀</b>";
			}
			if( i<6 && tdYMD < tDt ){
				colSpanVal++;
			}else if(tdYMD==tDt){
				loopBreakFlag = true;
				break;
			}
		}
		if(loopBreakFlag){ // 다음날까지 이어지는지 체크
			aTagCls = "taskBar end";
		}else{
			afterArrowHtml = "<b class='nt'>▶</b>";
		}
		
		var listHtml = "<a href='javascript:void(0);' onClick='popupTodoLayer(event, \""+sn+"\")' class='"+aTagCls+"'>"
					+ beforeArrowHtml
					+ fHm.substr(0,2)+":"+fHm.substr(2,2)+" "+ title
					+ afterArrowHtml+"</a>";
		addList.chkMoreList(objStr, "task", listHtml, colSpanVal, sn)
	},
	taskBarOnly : function(objStr, today, sn, fDt, fHm, tDt, title){
		var idx = objStr.substr(8);
		var colSpanVal = 1;
		var aTagCls= "taskBar only";
		
		var listHtml = "<a href='javascript:void(0);' onClick='popupTodoLayer(event, \""+sn+"\")' class='"+aTagCls+"'>"
					+ fHm.substr(0,2)+":"+fHm.substr(2,2)+" "+ title
					+"</a>";
		addList.chkMoreList(objStr, "taskBar only", listHtml, colSpanVal, sn)
	},
	chkMoreList : function(objStr, cls, listHtml, colSpanVal, sn){
		var moreHtml = "";
		var emptyIdx = -1;
		var emptyCnt = 0;
		var tdArrHtml = [];
		var snOverlapYn = false;
		var emptyIdxSchd = -1;
		
		var sibObjList = $("td[id^='"+objStr.substr(1)+"_']");
		for(var i=0; i<sibObjList.length; i++){
			if( $(sibObjList[i]).attr("sn") == sn){
				snOverlapYn = true;
				break;
			}
		}
		
		if(!snOverlapYn){					// 이미 sn이 등록되어있으면 그리지 않음
			/* 빈공간이 있으면 넣고, 없으면 moreHTML 작성 및 기존 TD숨기기 */
			for(var i=2; i>-1; i--){		// 비어있는 td 밑에서부터 위로 체크
				tdArrHtml[i] = $(objStr+"_"+i).html();
				if(tdArrHtml[i]==""){
					emptyIdx=i;
					emptyCnt++;
				}
				if(cls=="task"){
					for(var j=0; j<colSpanVal;j++){
						var nextIdx = objStr.substr(0,8) + (Number(objStr.substr(8))+j)+"_"+emptyIdx ; // 길이만큼 가로행에 diary가 있는지 추가 탐색
						if($(nextIdx).attr("class")=="daily"){					// diary 탐색 시 그 다음 인덱스 지정
							emptyIdxSchd= emptyIdxSchd > emptyIdx+1 ? emptyIdxSchd : emptyIdx+1;
						}
					}
				}
				if(cls=="taskBar only"){
					if($(objStr+"_"+i).attr("class")=="task" || $(objStr+"_"+i).attr("class")=="t_only" || $(objStr+"_"+i).attr("class")=="colHidden"){
						emptyIdx=i+1;
						break;
					}
				}
			}
			
			if(cls == "daily"){				/* @@@일정 추가@@@ */
				var siblingsCnt = $("td[id^='"+objStr.substr(1)+"_']").length;
				if(emptyCnt>0){				// 빈공간이 존재할 경우
					$(objStr+"_"+emptyIdx).attr({"class":cls, "colspan":colSpanVal, "sn":sn, "onclick":""}).html(listHtml);
				}else{
					$(objStr).parent().parent().last().append("<td id='"+objStr.substr(1)+"_"+siblingsCnt+"' sn='"+sn+"' class='hiddenCell' style='display:none;'>"+ listHtml +"</td>");

					moreHtml = "<a href='javascript:void(0);' class='moreBin' style='cursor: default;' onclick='popupSchdWriteLayer(event,"+objStr.substr(8)+",\"cal\")'></a>"
						+"<a href='javascript:void(0);' onClick='viewTodoDv(\""+objStr+"\",event)' class='more'>+"+ (siblingsCnt-2) +"</a>";
					$("#more"+objStr.substr(8)).html(moreHtml).addClass("more");
				}
			}else if(cls == "task"){		/* @@@일지 추가@@@ */
				var siblingsCntArr = [];
				var siblingsCntTop = 0;
				
				for(var j=0; j<colSpanVal;j++){			// 그려질 영역의 일정/일지 분포 및 가장 많은 분포영역을 찾아낸다.
					var colIdx = $("td[id^='cellNum"+(Number(objStr.substr(8))+j)+"_']");
					var count = 0;
					for(var k=0; k<colIdx.length; k++){
						if(colIdx[k].innerHTML!=""){ 	// colIdx[k].className!="more" && 
							count++;
						}
					}
					siblingsCntArr.push(count);
					siblingsCntTop = siblingsCntTop > count ? siblingsCntTop : count;
				}
				
				var resultSchIdx = emptyIdxSchd != -1 ? emptyIdxSchd : emptyIdx ;
				if(siblingsCntTop<3){					// 일반 삽입
					$(objStr+"_"+resultSchIdx).attr({"class":"task", "colspan":colSpanVal, "sn":sn, "onclick": ""}).html(listHtml);
					if(colSpanVal>1){					// colSpan이 1이상이면 옆의 열들을 Hidden 처리 함
						for(var i=0; i<colSpanVal-1; i++){
							var nextTdId = "#cellNum"+(Number(objStr.substr(8))+(i+1));
							$(nextTdId+"_"+resultSchIdx).css("display", "none").attr({"class":"colHidden","sn":sn}).html("hidden");
						}
					}
				}else if(siblingsCntTop>2){				// 하나라도 4를 초과하는 행이 있을 경우 맨 뒤에 none으로 붙여주고 more 행을 추가 함
					for(var i=0; i<colSpanVal; i++){
						objStrInc = '#cellNum'+(Number(objStr.substr(8))+i); // 옆칸으로 이동하면서 수행하도록 인덱스 값을 증가 시킴
						if(siblingsCntArr[i]<4){		// 세로 행이 네개 미만인 경우의 처리
							
							$(objStrInc).parent().parent().last().append("<td id='"+objStrInc.substr(1)+"_"+(siblingsCntTop+1)+"' class='hiddenCell' sn='"+sn+"' style='display:none;'>"+ listHtml +"</td>");
							
							var hdnListLength = $("td[id^='cellNum"+(Number(objStr.substr(8))+i)+"_'].hiddenCell").length;
							moreHtml = "<a href='javascript:void(0);' class='moreBin' style='cursor: default;' onclick='popupSchdWriteLayer(event,"+objStr.substr(8)+",\"cal\")'></a>"
								+ "<a href='javascript:void(0);' onClick='viewTodoDv(\""+objStrInc+"\",event)' class='more'>+"+hdnListLength+"</a>";
							$("#more"+objStrInc.substr(8)).html(moreHtml)
							
						}else if(siblingsCntArr[i]>3){	// 세로 행이 네개 이상인 경우의 처리
							
							$(objStrInc).parent().parent().last().append("<td id='"+objStrInc.substr(1)+"_"+(siblingsCntTop+1)+"' class='hiddenCell' sn='"+sn+"' style='display:none;'>"+ listHtml +"</td>");
							
							var hdnListLength = $("td[id^='cellNum"+(Number(objStr.substr(8))+i)+"_'].hiddenCell").length;
							moreHtml = "<a href='javascript:void(0);' class='moreBin' style='cursor: default;' onclick='popupSchdWriteLayer(event,"+objStr.substr(8)+",\"cal\")'></a>"
								+ "<a href='javascript:void(0);' onClick='viewTodoDv(\""+objStrInc+"\",event)' class='more'>+"+hdnListLength+"</a>";
							$("#more"+objStrInc.substr(8)).html(moreHtml)
						}
					}
				}
			}else if(cls=="taskBar only"){ /* @@@단순 일정 추가@@@ */
				var siblingsCnt = $("td[id^='"+objStr.substr(1)+"_']").length;
				if( /*siblingsCntTop<3 && */emptyCnt>0 && emptyIdx<3){				// 빈공간이 존재할 경우
					$(objStr+"_"+emptyIdx).attr({"class":/*cls*/"t_only", "colspan":colSpanVal, "sn":sn, "onclick":""}).html(listHtml);
				}else{
					$(objStr).parent().parent().last().append("<td id='"+objStr.substr(1)+"_"+siblingsCnt+"' sn='"+sn+"' class='hiddenCell' style='display:none;'>"+ listHtml +"</td>");

					moreHtml = "<a href='javascript:void(0);' class='moreBin' style='cursor: default;' onclick='popupSchdWriteLayer(event,"+objStr.substr(8)+",\"cal\")'></a>"
						+ "<a href='javascript:void(0);' onClick='viewTodoDv(\""+objStr+"\",event)' class='more'>+"+ (siblingsCnt-2) +"</a>";
					$("#more"+objStr.substr(8)).html(moreHtml).addClass("more");
				}
			}
		}
	}
};


<!--
//alert('http://login.okdab.com/member/login.do');

// affis.net -> okdab.com 으로 변경
var nowUrl = document.location.href;
if (nowUrl.indexOf('affis.net') > -1) {
	nowUrl = nowUrl.replace('affis.net', 'okdab.com');	
	location.href = nowUrl;
}


$(document).ready(function(){
	gndMenuList();
	recomSearchKwdList();
});

function searchPage(url){
	$("#frm").attr('action',url).submit();
}
//-->

function emailGo(){
	var userId = '';
	if(userId == ''){
		//alert("로그인이 필요한 서비스 입니다.");
		if(confirm("로그인이 필요한 서비스 입니다. 로그인하시겠습니까?") == 1){
			$(location).attr("href", "https://login.okdab.com/member/login.do?preUrl="+$(location).attr("href"));
			//$(location).attr("href", "https://login.okdab.com/member/login.do?preUrl=http://mail.okdab.com/mail/main.html");
		}else{
			return;
		}
	}else{
		$.ajax({
			url : "http://www.okdab.com/util/mypage/chkEmail.do",
			dataType : "jsonp",
			jsonpCallback: "callback",
			success : function(data){
				//alert(data["result"]);
				if(data["result"] == 'success'){
					location.href = "http://mail.okdab.com/portlet/sso.jsp?url=mail ";
				}else{
					if(confirm("옥답 이메일 계정이 없습니다.\r\n이메일 계정을 새로 만드시겠습니까?")){
						$.ajax({
							url : "http://www.okdab.com/util/mypage/insertEmail.do",
							dataType : "jsonp",
							jsonpCallback: "callback",
							success : function(data){
								if(data["result"] == 'success'){
									alert("옥답 이메일 계정을 생성하였습니다.");
									location.href = "http://mail.okdab.com/portlet/sso.jsp?url=mail ";
								}else{
									alert("옥답 이메일 계정 생성에 실패 하였습니다. 관리자에게 문의 바랍니다.ErrorCode["+data.model.result+"]");
								}
							}
						});
					}
				}
			}
		});
	}
}
//통합검색
function fn_Mainsearch(skwd) {
	var kwd = $("#mainSearch").val();
	if(skwd != ''){
		kwd = skwd;		
	}
	if (kwd == ""){
		alert("검색어를 입력하시기 바랍니다.");
		$("#mainSearch").focus();
		return;
	}
	$("#kwd").val(encodeURIComponent(kwd));
	$("#frm").attr('action','/search/mainSearch.do').submit();	
}
function goLogin(){
 	//location.href= 'http://login.okdab.com/member/login.do' + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
 	location.href= 'http://login.okdab.com/member/login.do' + "?preUrl=" +  escape(encodeURIComponent(window.location['href']));
}
function goJoin(){
 	location.href= 'http://login.okdab.com/memberjoin/joinMain.do' + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
}
function goIdPwd(){
 	location.href= 'http://login.okdab.com/member/idpwd.do' + "?preUrl=" + escape(encodeURIComponent(window.location['href']));
}
function goMypage(){
//  	location.href= c_url+'util/mypage/pwdCheckPage.do';
 	location.href= '/util/mypage/pwdCheckPage.do';
}
function goLogout(){
	var preUrl =  escape(encodeURIComponent(window.location['href']));
	var loc = document.location.href.split("//");
	var domain = loc[1].substring(0,loc[1].indexOf("/"));	
	if($("#returnPreUrl").val() != "" && $("#returnPreUrl").val() != null){
		preUrl =  escape(encodeURIComponent("http://"+ domain + $("#returnPreUrl").val())); 
	}
 	location.href= 'https://login.okdab.com/member/logout.do?preUrl='+preUrl;
 	//location.href= c_url+'util/mypage/pwdCheckPage.do';
//  	$("#preUrl").val(preUrl);
//  	$("#frm").attr('action','/check/logout.do').submit();
}

// Gnd메뉴
// 2015.06.12 - http, https 를 동시에 수용해야 되므로 jsonp 로 변경해서 자바스크립트에서 처리
function gndMenuList(){
	$.ajax({
		url : "http://www.okdab.com/common/gndMenuList.do",
		type : "GET",
		dataType : "jsonp",
		jsonpCallback: "gndMenu",
		crossDomain: true,
		success : function(data){			
			var html = "";
			html += "<div id=\"gnb\"><ul>";
			for(var i=0; i<data.length; i++) {
				html += "<li id=\"gnb"+(i+1)+"\">";
				html += "<a href=\"#\" class=\"gnb"+(i+1)+"\" onClick=\"searchPage('"+data[i].ctgry_url+"')\">";
				html += "<img class=\"gm\" src=\"/images/global/gnb_"+(i+1)+".gif\" alt=\""+data[i].ctgryNm+"\"></a>";
				html += "<div class=\"sub0"+(i+1)+"\">";
				html += "<p class=\"tit_gnb"+(i+1)+"\">옥답"+data[i].ctgryNm+" 관련 컨텐츠 안내입니다.</p><ul>";
				for(var j=0; j<data[i].gnbMenu2List.length; j++) {
					gnb2 = data[i].gnbMenu2List[j];
					html += "<li class=\"tit tit"+(j+1)+"\">";
					html += "<a href=\"#\" onClick=\"searchPage('"+gnb2.ctgry_url+"')\">"+gnb2.ctgryNm+"</a></li>";
				}
				html += "</ul></div></li>";			
			}
			html += "<div class=\"allMenu\">";	
			for(var k=0; k<data.length; k++) {
				html += "<dl class=\"all0"+(k+1)+"\">";	
				html += "<dt><a href=\"#\" onClick=\"searchPage('"+data[k].ctgry_url+"')\">"+data[k].ctgryNm+"</a></dt>";	
				for(var l=0; l<data[k].gnbMenu2List.length; l++) {
					gnb2 = data[k].gnbMenu2List[l];
					html += "<dd><a href=\"#\" onClick=\"searchPage('"+gnb2.ctgry_url+"')\">"+gnb2.ctgryNm+"</a></dd>";
				}
				html += "</dl>";
			}
			html += "<a href=\"#\" class=\"gnbClose\">닫기</a></div></div>";				
			//console.log(html);
			$("#gnbWrap").html(html);
		},
		error : function(xhr) {
			console.log(xhr);
		}
	});
}
// 추천검색어(통합검색)
// 2015.06.12 - http, https 를 동시에 수용해야 되므로 jsonp 로 변경해서 자바스크립트에서 처리
function recomSearchKwdList() {
	$.ajax({		
		url : "http://www.okdab.com/search/recomSearchKwd.do",
		type : "GET",
		dataType : "jsonp",
		jsonpCallback: "rsKwd",
		crossDomain: true,
		success : function(data){
			//console.log(data);
			var html = "";
			if (data != null && data != "") {
				for(var i=0; i<3; i++) {
					html += "<dd><a href=\"javascript:fn_Mainsearch('"+data[i][0]+"');\">"+data[i][0]+"</a> | </dd>";
				}
				html += "<dd><a href=\"javascript:fn_Mainsearch('"+data[3][0]+"');\">"+data[3][0]+"</a></dd>";
			}
			//console.log(html);
			$("#recomSearchKwd").html(html);
		}
	});
}
//즐겨찿기
var client = function(keyword, spliter){       
	var agent = navigator.userAgent.toLowerCase();        
	return agent.indexOf(keyword)>-1 ?  parseFloat(agent.split(spliter || keyword).pop().replace(/^[^\w;]+/, '')) :            null;  
};  
function bookmark_add(title ){
	var url = "http://www.okdab.com/okdab/main.do";
	var ie = client('msie') || client('trident', 'rv:'); 
	if(ie > 7){ //익스 버젼 7이상일 경우   
		window.external.addFavorite(url, title);
	}else{
		alert("<Ctrl+D>를 누르시면 즐겨찾기에 추가 하실수 있습니다.");
	}
}
function fn_setStartPage(obj){
	var strUrl = "";
	obj.style.behavior='url(#default#homepage)';
	document.body.setHomePage (document.location.href); //시작페이지로 설정
}

// 설문조사 팝업
function rshPopup(refSn){
	var deviceType = "";
	if(navigator.userAgent.match("Android") != null || navigator.userAgent.match("iPhone") != null || navigator.userAgent.match("iPad") != null){
		deviceType = "M";
	} else {
		deviceType = "W";
	}
	window.open(c_url+"rsh/main.do?refSn="+refSn+"&deviceType="+deviceType, "설문조사", "width=620,height=610,scrollbars=yes,resizeable=yes");
}
</script>
<div id="tnb">
	<form name="frm" id="frm" method="post">
		<input type="hidden" id="kwd" name="kwd" value=""/>
		<input type="hidden" id="category" name="category" value="All"/>
		<input type="hidden" id="preUrl" name="preUrl" value=""/>
	</form>
	<div class="favorite" style="padding: 0px; height: 0px; width: auto;">
		<a href="javascript:;" onclick="fn_setStartPage(this);" class="tnStart idt">옥답을시작페이지로</a>
		<a href="javascript:bookmark_add('농업농촌을 e-롭게!');" class="tnFavo idt">즐겨찾기에추가</a>
	</div>				
	<ul class="tnbMenu">
		
		
			<li><a href="#" onClick="goLogin()">로그인 |</a></li>
			<li><a href="#" onClick="goJoin()">회원가입 |</a></li>
			<li><a href="#" onClick="goIdPwd()">아이디비밀번호찾기 |</a></li>
		
		
		<li><a href="javascript:emailGo();">이메일 |</a></li>
		<li><a href="/board/boardList.do?bbsId=1034">고객센터</a></li>
		<li>
			<div class="font_wrap">
				<span class="empty" style="height: 30px;">&nbsp;</span>
				<a href="#" class="up" id="txtLarge">
					<img src="/images/global/up_btn.png" alt="글자 확대" style="vertical-align: top;"/>
				</a>
				<a href="#" class="up" id="txtSmall">
					<img src="/images/global/down_btn.png" alt="글자 축소" style="vertical-align: top;"/>
				</a>
			</div>
		</li>
	</ul>
</div>
<div id="search">
	<h1><a href="#" onClick="searchPage('/okdab/main.do')"><img src="/images/global/logo.png" alt="Okdab" class="logo"></a></h1>
	<div class="recom">
		<div class="searchBar">
			<input type="text" value="" id="mainSearch" name="mainSearch" onkeydown = "if(event.keyCode==13) fn_Mainsearch('');">
			<a href="javascript:fn_Mainsearch('');"  class="btnSearch idt">search</a>
		</div>
		<dl>
			<dt>추천검색어 :</dt>
			<span id="recomSearchKwd"></span>			
		</dl>
	</div>
</div>

<!-- gnb 메뉴 -->
<div id="gnbWrap"></div>	
				

	</div>
</header>
	<div id="contentWrap" class="onePage">
		















	<script type="text/javascript" src="/common/js/jquery.vticker.js"></script>
	
	<script type="text/javascript" src="/common/js/cookie.js" type="text/javascript"></script>
	
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css"/> 
	
	<form name="frm" id="frm" method="post">
		<input type="hidden" id="statHdn" name="statHdn" value="11|11110|1111051000"/>
	</form>
	<div id="contentWrap" class="onePage">
		<div id="content">			
			
			<!-- 레이어 시작 -->
			
			<!--s : 지역선택 layer-->
			<!-- 
 * @FileName   	: openPopup.jsp
 * @Date  		: 2014.03.06 
 * @Author    	: 강의성
 * @Version     : 1.0
 * @Description : 날씨 공통
 * @History     :
-->












<script type="text/javascript">

</script>
<!-- 날씨 정보 시작 -->
<!--s : 지역선택 layer-->
<div id="areaSelectLayer" class="commonRayer rayerColor01" style="display:none; z-index:2; top:130px; left:284px;">
	<div class="rayerTit">
		<span>지역선택</span>
		<img src="/images/global/close01.gif" alt="닫기버튼" class="closeBtn" onClick="layerClose()">
	</div>
	<div class="rayerCt">
		<div class="ryInput">
			<input type="text" placeholder="지역을 선택하세요" class="txtRy"><input type="button" value="예보보기" class="ryBtn" onClick="parentSetData()"> 
		</div>
		<div class="ryTable">
			<table>
				<caption>지역선택</caption>
				<col style="width:25%;">
				<col style="width:25%;">
				<col style="width:25%;">
				<col style="width:25%;">
				<tbody>
					
					  	
					  		
					  	<tr>		
					  			
					  		<td><a href="javascript:callListstat('11' , '서울특별시')">서울특별시</a></td>
						
					  		
					  		<td><a href="javascript:callListstat('26' , '부산광역시')">부산광역시</a></td>
						
					  		
					  		<td><a href="javascript:callListstat('27' , '대구광역시')">대구광역시</a></td>
						
					  		
					  		<td><a href="javascript:callListstat('28' , '인천광역시')">인천광역시</a></td>
						
					  		
						</tr>
					  			
					  	<tr>		
					  			
					  		<td><a href="javascript:callListstat('29' , '광주광역시')">광주광역시</a></td>
						
					  		
					  		<td><a href="javascript:callListstat('30' , '대전광역시')">대전광역시</a></td>
						
					  		
					  		<td><a href="javascript:callListstat('31' , '울산광역시')">울산광역시</a></td>
						
					  		
					  		<td><a href="javascript:callListstat('41' , '경기도')">경기도</a></td>
						
					  		
						</tr>
					  			
					  	<tr>		
					  			
					  		<td><a href="javascript:callListstat('42' , '강원도')">강원도</a></td>
						
					  		
					  		<td><a href="javascript:callListstat('43' , '충청북도')">충청북도</a></td>
						
					  		
					  		<td><a href="javascript:callListstat('44' , '충청남도')">충청남도</a></td>
						
					  		
					  		<td><a href="javascript:callListstat('45' , '전라북도')">전라북도</a></td>
						
					  		
						</tr>
					  			
					  	<tr>		
					  			
					  		<td><a href="javascript:callListstat('46' , '전라남도')">전라남도</a></td>
						
					  		
					  		<td><a href="javascript:callListstat('47' , '경상북도')">경상북도</a></td>
						
					  		
					  		<td><a href="javascript:callListstat('48' , '경상남도')">경상남도</a></td>
						
					  		
					  		<td><a href="javascript:callListstat('50' , '제주특별자치도')">제주특별자치도</a></td>
						
						</tr>
						
				</tbody>
			</table>
		</div>
	</div>
</div>
<!-- 날씨 정보 종료 -->
			
			<!-- 일지작성 -->
			<form name="brdForm" method="post" action="/product/insertFarmDiary.do" enctype="multipart/form-data">
			<input type="hidden" id="diaryWriteType" />
			<div class="commonRayer rayerColor01 diaryWrite" style="width: 790px; display:block; visibility:hidden; <!-- height:580px; -->">
				<div class="rayerTit">
					<span>일지작성</span>
					<a href="#"><img src="/images/global/close01.gif" alt="닫기버튼" class="closeBtn close closeDiary"></a>
				</div>
				<div class="rayerCt rayerCt02">		
					<div class="rayerWt"> 
						<table>
							<caption></caption>
							<col style="width:10%;">
							<col style="width:90%;">
							<tbody>
								<tr>
									<th><label for="decpt" class="titleTb">제목</label></th>
									<td><input type="text" value="제목" id="decpt" class="textBox"></td>
								</tr>
								<tr>
									<th><label for="date" class="titleTb">날짜</label></th>
									<td><input type="text" id="date" value="" style="width:150px;" class="pc50"></td>
								</tr>
								<tr>
									<th class="thLn"><span class="titleTb lb">날씨</span></th>
									<td>
										<ul id="insertDiaryWeatherIcon" class="wtIcon">
											<li><a href="javascript:chgWeatherIcon('01');"><img name="190001" id="190001" class="on" src="/images/product/wtRy07_on.gif" alt="맑음"></a></li>
											<li><a href="javascript:chgWeatherIcon('02');"><img name="190002" id="190002" src="/images/product/wtRy04.gif" alt="구름조금"></a></li>
											<li><a href="javascript:chgWeatherIcon('03');"><img name="190003" id="190003" src="/images/product/wtRy05.gif" alt="구름많음"></a></li>
											<li><a href="javascript:chgWeatherIcon('04');"><img name="190004" id="190004" src="/images/product/wtRy06.gif" alt="흐림"></a></li>
											<li><a href="javascript:chgWeatherIcon('05');"><img name="190005" id="190005" src="/images/product/wtRy03.gif" alt="비"></a></li>
											<li><a href="javascript:chgWeatherIcon('06');"><img name="190006" id="190006" src="/images/product/wtRy02.gif" alt="눈/비"></a></li>
											<li class="wtRyLast"><a href="javascript:chgWeatherIcon('07');"><img name="190007" id="190007" src="/images/product/wtRy01.gif" alt="눈"></a></li>
										</ul>
									</td>
								</tr>
								<tr>			
									<th class="thLn"><label for="tarea" class="titleTb"> 일지작성</label></th>
									<td><textarea class="tarea" id="se2" name="se2" style="width:98%;height:120px"  cols="130" rows="25"></textarea></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="dvFoot">
						<span class="button blue strong"><button type="button" id="addDiary" onClick="insertDiary(event)">등록</button></span>
						<!--
						<span class="button blue strong"><button type="button" onClick="delDiary(event)" id="delDiary">삭제</button></span>
						-->
						<span class="button gray strong closeDiary close"><button type="button">취소</button></span>
					</div>
				</div>
			</div>
			</form>
			
			<!-- 일지보기 -->
			<input type="hidden" id="diaryViewSn" />
			<div class="commonRayer rayerColor01 diaryView" style="width: 790px;" >
				<div class="rayerTit">
					<span>일지보기</span>
					<a href="#"><img src="/images/global/close01.gif" alt="닫기버튼" class="closeBtn close"></a>
				</div>
				<div class="rayerCt rayerCt02">		
					<div class="ryOpen">
						<div class="ryOpenTit">
							<div class="ryOpWrap"><span class="tit" id="diaryViewTitle">보리밭 배수로 정리</span></div>
							<div class="record">
								<img id="diaryViewWetherImg" src="/images/product/wtRy07.gif" alt="맑음">
								<div class="recordDate">
									<span id="diaryViewDate"><b>2013년 12월 19일</b>  (음)11.13</span>
									<span id="diaryViewWeather">대설</span>
								</div>
							</div>
						</div>
						<div class="ryOpenCn" id="ryOpenCnDiv">
							<p class="reportTxt" id="diaryViewContent">아침부터 흐리다가 눈이 잠깐 왔습니다.<br />
							흐린날은 허리가 아픈지라 나가지 않으려고 하였으나,<br />
							미뤄놓은 일들을 빨리 마무리하고 새해를 준비하기 위해 <br />
							밭에 나갔더니, 펄펄 눈이 내려오네요.<br />
							눈송이가 커질듯하여, 빨리 정리를 했는데 끝날 때쯤에는 눈은 <br />
							그치고 하늘이 좀 맑아지네요.<br />
							오락가락 정신없는 하루 였습니다 </p>
							<!--
							<img src="/images/product/reportImg.gif" alt="일지이미지" class="reportImg">
							-->
						</div>
					</div>
					<div class="dvFoot">
						<span class="button blue strong"><button type="button" onclick="changeUpdateLayer(event)">수정</button></span>
						<span class="button gray strong red" onclick="delDiary(event)" ><button type="button">삭제</button></span>
						<span class="button gray strong close"><button type="button">취소</button></span>
					</div>
				</div>
			</div>
			
			<!-- 일정작성 -->
			<div class="commonRayer rayerColor02 todoView">
				<input type="hidden" id="schduWriteType" value="0"/>
				<div class="rayerTit">
					<span>일정작성</span>
					<a href="#"><img src="/images/global/close03.gif" alt="닫기버튼" class="closeBtn close"></a>
				</div>
				<div class="rayerCt rayerCt02">		
					<div class="rayerWt">
						<table>
							<caption></caption>
							<col style="width:20%;">
							<col style="width:80%;">
							<tbody>
								<tr>
									<th><label for="decpt02" class="titleTb">제목</label></th>
									<td><input type="text" value="제목" id="decpt02" class="textBox textBox02"></td>
								</tr>
								<tr>
									<th class="date" rowspan="2"><label for="taskStartDt" class="titleTb">기간</label></th>
									<td class="timeLine">
										<span class="start">시작</span><input type="text" id="taskStartDt" title="시작날짜" value="" class="textBox textBox03">
										<select title="시작시간" id="taskStartTm" class="textBox textBox04" style="background:white;">
											<option value="0000">오전 12:00</option>
											<option value="0100">오전 01:00</option>
											<option value="0200">오전 02:00</option>
											<option value="0300">오전 03:00</option>
											<option value="0400">오전 04:00</option>
											<option value="0500">오전 05:00</option>
											<option value="0600">오전 06:00</option>
											<option value="0700">오전 07:00</option>
											<option value="0800">오전 08:00</option>
											<option value="0900">오전 09:00</option>
											<option value="1000">오전 10:00</option>
											<option value="1100">오전 11:00</option>
											<option value="1200">오후 12:00</option>
											<option value="1300">오후 01:00</option>
											<option value="1400">오후 02:00</option>
											<option value="1500">오후 03:00</option>
											<option value="1600">오후 04:00</option>
											<option value="1700">오후 05:00</option>
											<option value="1800">오후 06:00</option>
											<option value="1900">오후 07:00</option>
											<option value="2000">오후 08:00</option>
											<option value="2100">오후 09:00</option>
											<option value="2200">오후 10:00</option>
											<option value="2300">오후 11:00</option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="timeLine">
										<span class="start">종료</span><input type="text" id="taskEndDt" title="종료날짜" value="" class="textBox textBox03">
										<select title="시작시간" id="taskEndTm" class="textBox textBox04" style="background:white;">
											<option value="0000">오전 12:00</option>
											<option value="0100">오전 01:00</option>
											<option value="0200">오전 02:00</option>
											<option value="0300">오전 03:00</option>
											<option value="0400">오전 04:00</option>
											<option value="0500">오전 05:00</option>
											<option value="0600">오전 06:00</option>
											<option value="0700">오전 07:00</option>
											<option value="0800">오전 08:00</option>
											<option value="0900">오전 09:00</option>
											<option value="1000">오전 10:00</option>
											<option value="1100">오전 11:00</option>
											<option value="1200">오후 12:00</option>
											<option value="1300">오후 01:00</option>
											<option value="1400">오후 02:00</option>
											<option value="1500">오후 03:00</option>
											<option value="1600">오후 04:00</option>
											<option value="1700">오후 05:00</option>
											<option value="1800">오후 06:00</option>
											<option value="1900">오후 07:00</option>
											<option value="2000">오후 08:00</option>
											<option value="2100">오후 09:00</option>
											<option value="2200">오후 10:00</option>
											<option value="2300">오후 11:00</option>
										</select>
										<div class="timeLineCk"><input type="checkbox" id="ck" onClick="allDay()" ><label for="ck">하루종일</label></div>
									</td>
								</tr>
								<!--
								<tr>
									<th><label for="decpt03" class="titleTb">알림</label></th>
									<td>
										<select id="decpt03" class="textBox textBox003">
											<option value="" selected >알림없음</option>
											<option value="M10" >10분</option>
											<option value="M30" >30분</option>
											<option value="H01" >1시간</option>
											<option value="H02" >2시간</option>
											<option value="H03" >3시간</option>
											<option value="H06" >6시간</option>
											<option value="H24" >전날</option>
										</select>
									</td>
								</tr>
								-->
								<tr>
									<th class="thLn"><label for="tarea02" class="titleTb">일정작성</label></th>
									<td><textarea class="tarea tarea02" id="tarea02" onKeyUp="rtnStringByte('tarea02' , 500)"></textarea><span class="byte" id="tarea02Byte"><b>0</b> /500 byte</span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="dvFoot">
						<span class="button blue strong"><button type="button" onClick="saveSchadul(event)" id="addSchdul">등록</button></span>
						<span class="button gray strong"><button type="button" onClick="delSchadul(event)" id="delSchdul">삭제</button></span>
						<span class="button gray strong close"><button type="button">취소</button></span>
					</div>
				</div>
			</div>

			<!-- 레이어 종료 -->
			
			
			<!-- 메인 메뉴 시작 -->
			
			<h2 class="tit"><img src="/images/product/tit02.gif" alt="텃밭 만들기"></h2>
			<div class="path">
				<span class="skip">현재위치 :</span>
				<a href="#">HOME</a><a href="#">&gt; 생산</a><a href="#">&gt; 영농일지</a>
			</div>
			<input type="hidden" id="todayWeatherVal1" value="Clear"></input>
			<input type="hidden" id="todayWeatherDsc1" value="맑음"></input>
			<input type="hidden" id="todayWeatherVal2" value="Cloudy"></input>
			<input type="hidden" id="todayWeatherDsc2" value="흐림"></input>
			<input type="hidden" id="todayWeatherVal3" value="Clear"></input>
			<input type="hidden" id="todayWeatherDsc3" value="맑음"></input>
			
			<div class="farmCalendar">
				<div class="farmHeader">
					<div class="farmInfo">
						<div class="farmBtn">
							<span>작목선택</span>
							<div class="inner">
								<ul>
								
									<li><a href="javascript:void(0);" onClick="viewCropInfo('208','파');" value="208"><span>파</span></a></li>
								
									<li><a href="javascript:void(0);" onClick="viewCropInfo('209','배추');" value="209"><span>배추</span></a></li>
								
									<li><a href="javascript:void(0);" onClick="viewCropInfo('210','무');" value="210"><span>무</span></a></li>
								
									<li><a href="javascript:void(0);" onClick="viewCropInfo('215','시금치');" value="215"><span>시금치</span></a></li>
								
									<li><a href="javascript:void(0);" onClick="viewCropInfo('233','부추');" value="233"><span>부추</span></a></li>
								
								</ul>
							</div>
						</div>
						<div class="farmPrice" id="mainRealTimeFarmPrice" style="height:100%; overflow: hidden;">
						</div>
						<div class="farmNews">
							<span>뉴스</span>
							<div class="inner">
							</div>
						</div>
					</div>
					<!-- 날씨 정보 시작 -->
					<!-- 
 * @FileName   	: openPopup.jsp
 * @Date  		: 2014.03.06 
 * @Author    	: 강의성
 * @Version     : 1.0
 * @Description : 날씨 공통
 * @History     :
-->










<script type="text/javascript">
$(document).ready(function(){	
	/*
	 * 지역정보 찿기 popup
	 */
	function openGnbPopup(){ // 이후 진행은 product/statlayer.js 참고
		$("#areaSelectLayer").show();
	}
});
</script>
<!-- 날씨 정보 시작 -->
<div class="weather">
	<a href="javascript:openGnbPopup();" id="statSpan" class="temArea">서울특별시 종로구 청운동</a>
	<img src="/images/product/ico/ico_l_shine.gif" alt="맑음"/>
	<dl>
		<dt class="skip">오늘의날씨</dt>
		<dd class="tem">5.0<span>℃</span></dd>
	</dl>
	<p class="temTxt temTxt02" style="padding: 70px 0 0 20px;">
		<span class="weath">
			<b style="padding-left: 15px; padding-bottom: 5px;">맑음</b>강수확률 : 0%		
		</span>
		<span class="temHigh lh">
			<span class="dpBk">
				
					최고 <b>-</b>
				
				
			</span>
			<span class="dpBk">
				
					최저 <b>-</b>
				
				
			</span>
		</span>
	</p>
</div>
<!-- 날씨 정보 종료 -->
					<!-- 날씨 정보 종료 -->
				</div>
				<div class="calWrap">
					<!-- 작목별 영농 일정 레이어 -->
					<div class="calRy" style="z-index:101; top:0px; left:0px; display:none;">
						<div class="calRyTit">
							<span class="titleName">호박</span>
							<a href="javascript:void(0);"><img src="/images/global/close02.gif" alt="닫기버튼" class="closeBtn02"></a>
						</div>
						<div class="calTxt" style="overflow-x: hidden; overflow-y: auto;">
							<div class="calTxt01">
							</div>
							<div class="calTxt02">
							</div>
						</div>
					</div>
					<div class="calHeader">			
						<a href="javascript:void(0);" onclick="popupDiaryWriteLayer(event);" class="writeBtn diaryWriteGo idt">영농일지작성</a>
						<a href="javascript:void(0);" title="이전" class="cPre idt" onClick="monthMove('dn')" >이전</a>
						<span><b id="yearViewSpan"></b>년 <b id="monthViewSpan"></b>월</span>
						<a href="javascript:void(0);" title="다음" class="cNext idt" onClick="monthMove('up')">다음</a>
						<a href="javascript:void(0);" title="오늘" class="btnToday idt" onClick="goToday()">오늘</a>			
						<div class="viewSelect">
							<a href="javascript:void(0);" class="sel01 on idt" onclick="chgDiaryForm('table')">월보기</a><a href="javascript:void(0);" class="sel02 idt" onClick="chgDiaryForm('list')">목록보기</a>
						</div>
					</div>
					<!-- 상단메뉴 종료 -->

					<!-- 영농일지(표) 시작 -->
					<div class="calTable">
					</div>
					<!-- 영농일지(표) 종료 -->
					
					<!-- 영농일지(리스트) 시작 -->
					<div class="calList" style="display:none;">
						<table>
							<caption>영농일지 캘린더</caption>
							<col style="width:10%;">
							<col style="width:8%;">
							<col style="width:7%;">
							<col style="width:10%;">
							<col style="width:15%;">
							<col style="width:50%;">
							<thead>
								<tr>
									<th>일자</th>
									<th>일정추가</th>
									<th>구분</th>
									<th>시간</th>
									<th>농작업</th>
									<th>제목</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
					<!-- 영농일지(리스트) 종료 -->
				</div>
			</div>
		</div>
		
	</div>
	<footer>
		<div class="inner">
			
		</div>
	</footer>

<script type="text/javascript" src="/testCalender/farmCommon.js"></script>
<script type="text/javascript" src="/testCalender/farmDiary.js"></script>
<script type="text/javascript" src="/se2/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">


var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "se2",
    sSkinURI: "/se2/SmartEditor2Skin.html",
    htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		fOnBeforeUnload : function(){
//			alert("완료!");
		}
	}, //boolean
	fOnAppLoad : function(){
//		//예제 코드
		oEditors.getById["se2"].exec("PASTE_HTML", [""]);
		$("#se2").next().css("width", "100%").css("height", "254px"); // IE에서 iframe height가 0으로 되는 증상 보정
		$("div.commonRayer").hide().css("visibility", "visible");
	},
    fCreator: "createSEditor2"
});

</script>
</body>
</html>

	</div>
<footer>
	<div class="inner">
		


<script type="text/javascript">
	function fn_goLink(linkUrl, target){
		if(linkUrl != ""){
			window.open(linkUrl, target);
		}
		$("#familySite").val("");
	}
</script>


			
<!-- <div class="footLogo">
	<a href="http://www.epis.or.kr" target="_blank"><img src="/images/global/footBnr02.gif" alt=""></a>
</div> -->

<div class="foot_qc" style="position: absolute; right: 200px; top: 115px;  padding: 0 0 0 10px;width: 250px;  height: 54px;  text-align: right; z-index: -1;">
	<div style="float: left;">
		<img src="/images/footer/mark2.png" style="height:65px;" />
	</div>
	<div style="float: left;">
		<a href="https://www.goodcontent.kr/main.do" target="_blank"><img src="/images/footer/qc.png" style="height:65px;padding-left:10px;" /></a>
	</div>
	<!-- <div style="float:left;padding-top: 20px;text-align: left;font-family: '돋움', Dotum, Tahoma, sans-serif; text-decoration: none; font-style: normal; color: #666;">
		콘텐츠 제공 서비스<br />품질인증 우수상
	</div> -->
</div>



//스마트폰 WEB 접속 확인
/*
var uAgent = navigator.userAgent.toLowerCase();
var mobilePhones = new Array('iphone', 'ipod', 'android', 'blackberry', 'windows ce', 'nokia', 'webos', 
		'opera mini', 'sonyericsson', 'opera mobi', 'iemobile');   //기기종류 나열

for (var i = 0; i < mobilePhones.length; i++) {
    if (uAgent.indexOf(mobilePhones[i]) > -1){
       document.location.replace("http://mobile.okdab.com/");   //히스토리 없이 페이지 이동
     }
}
*/
</script>
<!-- 
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-52006258-1', 'okdab.com');
  ga('send', 'pageview');

</script>

Withpang Tracker v2.0 start
<script type="text/javascript">
<!--
	(function (w, d, i) {
		w[i]={
			sc : (encodeURIComponent("")),
			form : (encodeURIComponent(d.referrer)),
			url : (encodeURIComponent(w.location.href))
		};

		if(w[i]) {
			var _ar = _ar || [];
			var _s = "log.dreamsearch.or.kr/servlet/rf";
			for(x in w[i]) _ar.push(x + "=" + w[i][x]);
			(new Image).src = d.location.protocol +"//"+ _s +"?"+ _ar.join("&");
		}
	})(window, document, "wp_rf");

</script>
Withpang Tracker v2.0 end
 -->

	</div>
</footer>
</body>
</html>
