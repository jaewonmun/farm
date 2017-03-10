<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>농업경영장부 영농일지</title>
<!-- css -->
<link rel="stylesheet" href="/css/menu.css">
<link rel="stylesheet" href="/css/homepage.css">
<link rel="stylesheet" href="/css/board.css">
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet"
	href="/css/jquery-ui-1.10.3.custom.min.css">
<link rel="stylesheet" href="/css/jquery.ui.accordion.css">
<link rel="stylesheet" href="/css/jquery.ui.dialog.css">
<link rel="stylesheet" href="/css/prism.css">
<link rel="stylesheet" href="/css/chosen.css">
<link rel="stylesheet" href="/css/jquery.ui.datepicker.css">
<link href="/css/fullcalendar.css" rel="stylesheet">
<link href="/css/fullcalendar.print.css"
	rel="stylesheet" media="print">
<link href="/css/flexslider.css" rel="stylesheet"
	media="screen">

<script type="text/javascript" src="/js/dojo/dojo.js"
	data-dojo-config="parseOnLoad: true, isDebug: false"></script>
<script src="/js/billion/json2.js"></script>
<script src="/js/billion/billion.member.js"></script>
<script src="/js/billion/billion.menu.js"></script>
<script src="/js/billion/common.js"></script>
<script src="/js/billion/callback.js"></script>
<script src="/js/billion/xgrid.js"></script>
<script src="/js/billion/db.js"></script>
<script src="/js/billion/acc.js"></script>
<script src="/js/jquery/jquery-1.10.2.min.js"></script>
<script src="/js/jquery/jquery-ui-1.10.3.custom.min.js"></script>
<script src="/js/jquery/jquery.ui.dialog.js"></script>
<script src="/js/jquery/chosen.jquery.js"></script>
<script src="/js/jquery/prism.js"></script>
<script src="/js/jquery/jquery.number.min.js"></script>
<script src="/js/jquery/fullcalendar/fullcalendar.js"></script>
<script src="/js/jquery/flexslider/jquery.flexslider.js"></script>
<script src="/js/openapi/lib_farm.js" type="text/javascript"></script>
<script src="/js/billion/weather.js"></script>
<script src="/js/billion/mooncal.js"></script>
<script type="text/javascript">
	function run() {
		eFarm.getDiaryData("frm_list", function(result) {
			if (result.message == "success") {
				//console.log(result);
				callbackfuncn_workdiary(result, "", function() {
				});
			} else {

			}
		});
		eFarm.getTableData("frm_list_mon", function(result) {
			if (result.status == "success") {
				if ($("#notfind_mon") != undefined)
					$('#notfind_mon').remove();
				var params = {
					pagenum : result.pagenum,
					numrow : result.numrow,
					totalcnt : result.totalcnt
				};
				//console.log("# eFarm.getTableData('frm_list_mon',function(result) = " + result.data);
				callbackfuncn_work_list_mon(result.data, params, function() {
				});
			} else {
				if ($("#notfind_mon") != undefined)
					$('#notfind_mon').remove();

				$("#news_view_paging_mon").empty();
				$("#sub_board_news_mon").empty();
				$("#news_totalcnt_mon").text("0 건");
				$("#news_curpage_mon").text("0");
				$("<label>").text(result.message).attr("id", "notfind_mon")
						.appendTo($("#board_box_mon"));
			}
		});
		return;
	}

	function search_step_list() {
		eFarm.getTableData("frm_steplist", function(result) {
			if (result.status == "success") {
				if ($("#notfind22") != undefined)
					$('#notfind22').remove();

				var params = {
					pagenum : result.pagenum,
					numrow : result.numrow,
					totalcnt : result.totalcnt
				};
				callbackfuncn_usr_work_step_bymain(result.data, params,
						function() {
						});
			} else {
				if ($("#notfind22") != undefined)
					$('#notfind22').remove();
				$("#news_view_paging_search").empty();
				$("#sub_board_news_search").empty();
				$("#news_totalcnt_search").text("0 건");
				$("#news_curpage_search").text("0");
				$("<label>").text(result.message).attr("id", "notfind22")
						.appendTo($("#board_box2"));
			}
		});
		return;
	}

	function search_prd_list() {
		eFarm.getTableData("frm_prdlist", function(result) {
			if (result.status == "success") {
				if ($("#notfind222") != undefined)
					$('#notfind222').remove();
				var params = {
					pagenum : result.pagenum,
					numrow : result.numrow,
					totalcnt : result.totalcnt
				};
				callbackfuncn_usrenvprd_diary(result.data, params, function() {
				});
			} else {
				if ($("#notfind222") != undefined)
					$('#notfind222').remove();

				$("#news_view_paging_sub").empty();
				$("#sub_board_news_sub").empty();
				$("#news_totalcnt_sub").text("0 건");
				$("#news_curpage_sub").text("0");
				$("<label>").text(result.message).attr("id", "notfind222")
						.appendTo($("#board_box1"));
			}
		});
		return;
	}

	(function() {
		var highest = 1;
		$.fn.bringToTop = function() {
			this.css('z-index', ++highest); // increase highest by 1 and set the style
		};
	})();

	$(function() {
		$.datepicker.regional['ko'] = {
			buttonImage : "/images/icon/calendar.gif",
			buttonImageOnly : true,
			showOn : "button",
			closeText : '닫기',
			prevText : '이전달',
			nextText : '다음달',
			currentText : '오늘',
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
					'9월', '10월', '11월', '12월' ],
			monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
					'9월', '10월', '11월', '12월' ],
			dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			weekHeader : 'Wk',
			dateFormat : 'yy-mm-dd',
			firstDay : 0,
			isRTL : false,
			duration : 200,
			showAnim : 'show',
			showMonthAfterYear : true,
			changeMonth : true, // 월선택 select box 표시 (기본은 false)
			changeYear : true, // 년선택 selectbox 표시 (기본은 false)		
			yearSuffix : '년'
		};
		$.datepicker.setDefaults($.datepicker.regional['ko']);
	});

	function iframeonload() {
		get_photo_list();
		$("#photpfile").remove();
		dojo
				.create(
						"input",
						{
							id : "photpfile",
							name : "photpfile",
							"type" : "file",
							"accept" : "image/jpeg,image/gif,image/png,image/jpg,image/bmp,image/tif"
						}, dojo.byId("filepos"));
		get_photo_cnt();
		//$( "#dlg_photo_edit" ).dialog("close");
	}

	require(
			[ "dojo/ready" ],
			function(ready) {
				ready(function() {
					$(document).mouseup(function(e) {
						if (e.target.className != 'guideIcon') {
							PopLayer.Close();
						}
					});
					var islogined = eval('true');
					if (islogined) {
						set_menu(
								'true',
								'{"menu0102":[{"ID" : "0","NAM_KOR" : "간편회계관리","IDD" : "01      ","GRADE" : "0","CSS_CLS_NAM" : "first","URL_KOR" : "/rest/acc_input","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/account/acc_input.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "get_acclist","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_input"},{"ID" : "1","NAM_KOR" : "인쇄","IDD" : "41      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/print","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/print.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "print"},{"ID" : "2","NAM_KOR" : "입출금월별통계(총괄)","IDD" : "42      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/print_stat","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/print_stat.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "print_stat"},{"ID" : "3","NAM_KOR" : "입출금월별통계(수입)","IDD" : "43      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/print_stat_income","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/print_stat_income.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "print_stat_income"},{"ID" : "4","NAM_KOR" : "입출금월별통계(지출)","IDD" : "44      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/print_stat_outgo","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/print_stat_outgo.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "print_stat_outgo"},{"ID" : "5","NAM_KOR" : "자산통계","IDD" : "45      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/print_stat_ast","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/print_stat_ast.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "print_stat_ast"},{"ID" : "6","NAM_KOR" : "부채통계","IDD" : "46      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/print_stat_deb","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/print_stat_deb.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "print_stat_deb"},{"ID" : "7","NAM_KOR" : "간이생산원가명세서","IDD" : "47      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/print_spec_cost","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/print_spec_cost.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "print_spec_cost"},{"ID" : "8","NAM_KOR" : "간이손익계산서","IDD" : "48      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/print_spec_profit","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/print_spec_profit.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "print_spec_profit"},{"ID" : "9","NAM_KOR" : "가정비통계","IDD" : "49      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/print_stat_home","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/print_stat_home.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "print_stat_home"},{"ID" : "10","NAM_KOR" : "영농일지","IDD" : "50      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/print_diary","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/print_diary.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "print_diary"},{"ID" : "11","NAM_KOR" : "년도별 작업일지 비교조회","IDD" : "51      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/print_diary_compare","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/print_diary_compare.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "print_diary_compare"},{"ID" : "12","NAM_KOR" : "입출금장부 수정","IDD" : "52      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/acc_list_selected","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/account/acc_list_selected.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_list_selected"},{"ID" : "13","NAM_KOR" : "사업구분설정목록","IDD" : "53      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/usr_env_dep_list","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/env/usr_env_dep_list.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "usr_env_dep_list"},{"ID" : "14","NAM_KOR" : "거래처설정목록","IDD" : "54      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/usr_env_cmp_list","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/env/usr_env_cmp_list.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "usr_env_cmp_list"},{"ID" : "15","NAM_KOR" : "영농일지조회","IDD" : "55      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_view","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_view.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_view"},{"ID" : "16","NAM_KOR" : "영농일지입력","IDD" : "56      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_insert","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_insert.jsp","DEPTH" : "D01","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_insert"},{"ID" : "17","NAM_KOR" : "비밀번호찾기","IDD" : "36      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/send_pw","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/member/find.jsp","DEPTH" : "D01","ORD" : "1","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "send_pw"},{"ID" : "18","NAM_KOR" : "비밀번호갱신","IDD" : "37      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/reset_pw","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/member/reset_pw.jsp","DEPTH" : "D01","ORD" : "1","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "reset_pw"},{"ID" : "19","NAM_KOR" : "생산관리","IDD" : "39      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/diary","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary.jsp","DEPTH" : "D01","ORD" : "2","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary"},{"ID" : "20","NAM_KOR" : "환경설정","IDD" : "04      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/getpastdata","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/env/getpastdata.jsp","DEPTH" : "D01","ORD" : "4","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "getpastdata"},{"ID" : "21","NAM_KOR" : "입출력목록","IDD" : "40      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/acc_list","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/account/acc_list.jsp","DEPTH" : "D01","ORD" : "4","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_list"},{"ID" : "22","NAM_KOR" : "회원약관","IDD" : "05      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/member_reg_pre","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/member/pre_user_reg.jsp","DEPTH" : "D01","ORD" : "5","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "member_reg_pre"},{"ID" : "23","NAM_KOR" : "우편번호","IDD" : "06      ","GRADE" : "0","CSS_CLS_NAM" : "mehu_dep_01","URL_KOR" : "/rest/zip_code","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/member/zip_code.jsp","DEPTH" : "D01","ORD" : "6","QRY_ID" : "get_zipcode","ISCONLT" : "null","ISUSE" : "Y","NAM" : "zip_code"},{"ID" : "24","NAM_KOR" : "회원중복확인","IDD" : "07      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/dupcheck","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/member/chk_dup.jsp","DEPTH" : "D01","ORD" : "7","QRY_ID" : "get_member","ISCONLT" : "null","ISUSE" : "Y","NAM" : "dupcheck"},{"ID" : "25","NAM_KOR" : "게시판","IDD" : "35      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/board_info","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/board/board_opinion.jsp","DEPTH" : "D01","ORD" : "7","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "board_info"},{"ID" : "26","NAM_KOR" : "로그인","IDD" : "08      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/login","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/member/login.jsp","DEPTH" : "D01","ORD" : "8","QRY_ID" : "get_member","ISCONLT" : "null","ISUSE" : "Y","NAM" : "login"},{"ID" : "27","NAM_KOR" : "경영분석 관리","IDD" : "65      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/anal_home","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/anal/anal_home.jsp","DEPTH" : "D01","ORD" : "8","QRY_ID" : "null","ISCONLT" : "Y","ISUSE" : "Y","NAM" : "anal_home"},{"ID" : "28","NAM_KOR" : "품목검색","IDD" : "09      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/usrenvprd","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/env/usr_env_prd.jsp","DEPTH" : "D01","ORD" : "9","QRY_ID" : "get_prd","ISCONLT" : "null","ISUSE" : "Y","NAM" : "usrenvprd"},{"ID" : "29","NAM_KOR" : "메인","IDD" : "10      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/main","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/main.jsp","DEPTH" : "D01","ORD" : "10","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "main"},{"ID" : "30","NAM_KOR" : "회원가입","IDD" : "12      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/member_reg","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/member/user_reg.jsp","DEPTH" : "D01","ORD" : "11","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "member_reg"},{"ID" : "31","NAM_KOR" : "내역사업코드","IDD" : "13      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/spa_code","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/member/spa_code.jsp","DEPTH" : "D01","ORD" : "13","QRY_ID" : "get_spacode","ISCONLT" : "null","ISUSE" : "Y","NAM" : "spa_code"},{"ID" : "32","NAM_KOR" : "공간테스트","IDD" : "14      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/test","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/member/spa_test.jsp","DEPTH" : "D01","ORD" : "14","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "test"},{"ID" : "33","NAM_KOR" : "공간로그인","IDD" : "15      ","GRADE" : "0","CSS_CLS_NAM" : "menu_dep_01","URL_KOR" : "/rest/login_spa","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/member/login_spa.jsp","DEPTH" : "D01","ORD" : "15","QRY_ID" : "get_member","ISCONLT" : "null","ISUSE" : "Y","NAM" : "login_spa"},{"ID" : "34","NAM_KOR" : "회원정보수정","IDD" : "34      ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/user_reg_edit","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "00","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/member/user_reg_edit.jsp","DEPTH" : "D01","ORD" : "16","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "user_reg_edit"},{"ID" : "35","NAM_KOR" : "간이장부","IDD" : "0101    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/acc_input","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "01","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/account/acc_input.jsp","DEPTH" : "D02","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_input"},{"ID" : "36","NAM_KOR" : "영농일지","IDD" : "3901    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/diary","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "39","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary.jsp","DEPTH" : "D02","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary"},{"ID" : "37","NAM_KOR" : "간이통계","IDD" : "0301    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/acc_stat","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "01","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/stat/acc_stat.jsp","DEPTH" : "D02","ORD" : "1","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_stat"},{"ID" : "38","NAM_KOR" : "성과대비표","IDD" : "0307    ","GRADE" : "1","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/acc_spec_compare","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "03","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/spec/acc_spec_compare.jsp","DEPTH" : "D02","ORD" : "1","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_spec_compare"},{"ID" : "39","NAM_KOR" : "기존데이터가져오기","IDD" : "0409    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/getpastdata","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "04","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/env/getpastdata.jsp","DEPTH" : "D02","ORD" : "1","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "getpastdata"},{"ID" : "40","NAM_KOR" : "공지사항","IDD" : "0501    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/board_info","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "35","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/board/board_opinion.jsp","DEPTH" : "D02","ORD" : "1","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "board_info"},{"ID" : "41","NAM_KOR" : "조회 및 출력","IDD" : "3902    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/diary_identify","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "39","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_indentify.jsp","DEPTH" : "D02","ORD" : "1","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_identify"},{"ID" : "42","NAM_KOR" : "역할관리","IDD" : "6501    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/cont_reg","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "65","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/anal/anal_home.jsp","DEPTH" : "D02","ORD" : "1","QRY_ID" : "null","ISCONLT" : "Y","ISUSE" : "Y","NAM" : "cont_reg"},{"ID" : "43","NAM_KOR" : "부채관리장부","IDD" : "0302    ","GRADE" : "1","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/deb_input","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "03","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/account/deb_input.jsp","DEPTH" : "D02","ORD" : "2","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "deb_input"},{"ID" : "44","NAM_KOR" : "자료초기화","IDD" : "0410    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/resetmydata","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "04","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/env/resetmydata.jsp","DEPTH" : "D02","ORD" : "2","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "resetmydata"},{"ID" : "45","NAM_KOR" : "질문답변","IDD" : "0502    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/board_qa","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "35","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/board/board.jsp","DEPTH" : "D02","ORD" : "2","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "board_qa"},{"ID" : "46","NAM_KOR" : "고정자산관리장부","IDD" : "0303    ","GRADE" : "1","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/ast_input","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "03","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/account/ast_input.jsp","DEPTH" : "D02","ORD" : "3","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "ast_input"},{"ID" : "47","NAM_KOR" : "계정설정","IDD" : "0402    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/env_acc_itm","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "01","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/env/usr_env_itm_test.jsp","DEPTH" : "D02","ORD" : "3","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "env_acc_itm"},{"ID" : "48","NAM_KOR" : "생산경영장부 데이터 이전","IDD" : "0411    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/nfarmbookdata","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "04","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/env/nfarmbookdata.jsp","DEPTH" : "D02","ORD" : "3","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "nfarmbookdata"},{"ID" : "49","NAM_KOR" : "자유게시판","IDD" : "0503    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/board_free","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "35","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/board/board_free.jsp","DEPTH" : "D02","ORD" : "3","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "board_free"},{"ID" : "50","NAM_KOR" : "재무상태표","IDD" : "0306    ","GRADE" : "1","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/acc_spec_stat","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "03","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/spec/acc_spec_stat.jsp","DEPTH" : "D02","ORD" : "4","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_spec_stat"},{"ID" : "51","NAM_KOR" : "거래처설정","IDD" : "0403    ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/usr_env_cmp","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "01","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/env/usr_env_cmp.jsp","DEPTH" : "D02","ORD" : "4","QRY_ID" : "get_env_usr_cmp","ISCONLT" : "null","ISUSE" : "Y","NAM" : "usr_env_cmp"},{"ID" : "52","NAM_KOR" : "경영시뮬레이션 시스템","IDD" : "3801    ","GRADE" : "1","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/self_consulting","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "99","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/consulting/self.jsp","DEPTH" : "D02","ORD" : "4","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "self_consulting"},{"ID" : "53","NAM_KOR" : "사업구분설정","IDD" : "0401    ","GRADE" : "1","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/usr_env_dep","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "01","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/env/usr_env_dep.jsp","DEPTH" : "D02","ORD" : "5","QRY_ID" : "","ISCONLT" : "null","ISUSE" : "Y","NAM" : "usr_env_dep"},{"ID" : "54","NAM_KOR" : "화상컨설팅","IDD" : "3802    ","GRADE" : "1","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/screen_consulting","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "99","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/consulting/screen_consulting.jsp","DEPTH" : "D02","ORD" : "5","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "screen_consulting"},{"ID" : "55","NAM_KOR" : "경영시뮬레이션 시스템(6년근인삼)","IDD" : "3803    ","GRADE" : "1","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/jinsang_consulting","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "N","PAT_IDD" : "99","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/consulting/jinsang.jsp","DEPTH" : "D02","ORD" : "6","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "jinsang_consulting"},{"ID" : "56","NAM_KOR" : "입출금장부","IDD" : "010101  ","GRADE" : "0","CSS_CLS_NAM" : "menu","URL_KOR" : "/rest/acc_input","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "0101","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/account/acc_input.jsp","DEPTH" : "D03","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_input"},{"ID" : "57","NAM_KOR" : "총괄통계","IDD" : "030101  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/acc_stat","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "0301","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/stat/acc_stat.jsp","DEPTH" : "D03","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_stat"},{"ID" : "58","NAM_KOR" : "영농일지","IDD" : "390101  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3901","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary.jsp","DEPTH" : "D03","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary"},{"ID" : "59","NAM_KOR" : "작업일지조회","IDD" : "390201  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_identify","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3902","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_indentify.jsp","DEPTH" : "D03","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_identify"},{"ID" : "60","NAM_KOR" : "수입통계","IDD" : "010602  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/acc_stat_income","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "0301","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/stat/acc_stat_income.jsp","DEPTH" : "D03","ORD" : "1","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_stat_income"},{"ID" : "61","NAM_KOR" : "영농일지품목설정","IDD" : "390103  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_prd","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3901","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_prd.jsp","DEPTH" : "D03","ORD" : "1","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_prd"},{"ID" : "62","NAM_KOR" : "년도별 작업일지 비교조회","IDD" : "390202  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_compare","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3902","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_compare.jsp","DEPTH" : "D03","ORD" : "1","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_compare"},{"ID" : "63","NAM_KOR" : "지출통계","IDD" : "010603  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/acc_stat_outgo","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "0301","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/stat/acc_stat_outgo.jsp","DEPTH" : "D03","ORD" : "2","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_stat_outgo"},{"ID" : "64","NAM_KOR" : "작업과정설정","IDD" : "390102  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_step","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3901","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_step.jsp","DEPTH" : "D03","ORD" : "2","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_step"},{"ID" : "65","NAM_KOR" : "농약/비료/인력/장비조회","IDD" : "390203  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_detail","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3902","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_detail.jsp","DEPTH" : "D03","ORD" : "2","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_detail"},{"ID" : "66","NAM_KOR" : "자산통계","IDD" : "010605  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/acc_stat_ast","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "0301","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/stat/acc_stat_ast.jsp","DEPTH" : "D03","ORD" : "3","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_stat_ast"},{"ID" : "67","NAM_KOR" : "농약/비료/장비설정","IDD" : "390105  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_env","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3901","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_env.jsp","DEPTH" : "D03","ORD" : "3","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_env"},{"ID" : "68","NAM_KOR" : "부채통계","IDD" : "010604  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/acc_stat_deb","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "0301","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/stat/acc_stat_deb.jsp","DEPTH" : "D03","ORD" : "4","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_stat_deb"},{"ID" : "69","NAM_KOR" : "날씨지역설정","IDD" : "390104  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_weather","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3901","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_weather.jsp","DEPTH" : "D03","ORD" : "4","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_weather"},{"ID" : "70","NAM_KOR" : "가정비통계","IDD" : "030106  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/acc_stat_home","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "0301","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/stat/acc_stat_home.jsp","DEPTH" : "D03","ORD" : "5","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "acc_stat_home"},{"ID" : "71","NAM_KOR" : "공통비분배","IDD" : "030107  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/comm_dest","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "0301","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/account/usr_comm_dest.jsp","DEPTH" : "D03","ORD" : "6","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "comm_dest"},{"ID" : "72","NAM_KOR" : "생산원가명세서","IDD" : "030201  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/spec_cost","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "0301","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/spec/acc_spec_cost.jsp","DEPTH" : "D03","ORD" : "7","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "spec_cost"},{"ID" : "73","NAM_KOR" : "간이손익계산서","IDD" : "030202  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/spec_profit","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "0301","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/spec/acc_spec_profit.jsp","DEPTH" : "D03","ORD" : "8","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "spec_profit"},{"ID" : "74","NAM_KOR" : "통계청자료","IDD" : "030203  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/prod_cost_stat","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "0301","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/stat/prod_cost_stat.jsp","DEPTH" : "D03","ORD" : "9","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "prod_cost_stat"}],"menu03":[{"NAM_KOR" : "영농일지","IDD" : "390101  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3901","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary.jsp","DEPTH" : "D03","ORD" : "0","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary"},{"NAM_KOR" : "영농일지품목설정","IDD" : "390103  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_prd","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3901","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_prd.jsp","DEPTH" : "D03","ORD" : "1","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_prd"},{"NAM_KOR" : "작업과정설정","IDD" : "390102  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_step","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3901","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_step.jsp","DEPTH" : "D03","ORD" : "2","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_step"},{"NAM_KOR" : "농약/비료/장비설정","IDD" : "390105  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_env","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3901","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_env.jsp","DEPTH" : "D03","ORD" : "3","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_env"},{"NAM_KOR" : "날씨지역설정","IDD" : "390104  ","GRADE" : "0","CSS_CLS_NAM" : "null","URL_KOR" : "/rest/diary_weather","URL_OTH" : "null","NAM_OTH" : "null","ISVIEW" : "Y","PAT_IDD" : "3901","ISADMIN" : "N","SRC_POS" : "/farm2013/contents/diary/diary_weather.jsp","DEPTH" : "D03","ORD" : "4","QRY_ID" : "null","ISCONLT" : "null","ISUSE" : "Y","NAM" : "diary_weather"}],"navi_menu":[{"NAM_KOR" : "생산관리","URL_KOR" : "/rest/diary"},{"NAM_KOR" : "영농일지","URL_KOR" : "/rest/diary"},{"NAM_KOR" : "영농일지","URL_KOR" : "/rest/diary"}]}',
								'{"usr_email" : "cbnmzxcvb@gmail.com","usr_name" : "팜팜","addr_f" : "대구광역시 중구 경상감영길 55","addr_s" : "(서문로1가)","zip_code" : "41919 ","tel" : "null","fax" : "null","mobile" : "null","farm_id" : "null","site_code" : "null","spa_key" : "null","kma_cde" : "2711052000","usr_grade" : "1","is_share" : "null","isadmin" : "null","isdept" : "true","reg_p" : "01","ages" : "20","okdab_birthday" : "null","okdab_sex" : "null","okdab_email" : "null","okdab_id" : "null"}',
								"diary", "diary", "diary");
						var formURL = OpenApiHostUrl_raw + "/uploadfile";

						$("#frm_prd_photo").attr("action", formURL);
						$("#frm_prd_photo_edit").attr("action", formURL);

						document.getElementById('frm_prd_photo').target = 'uploadIFrame'; //'upload_target' is the name of the iframe
						document.getElementById('frm_prd_photo_edit').target = 'uploadIFrame'; //'upload_target' is the name of the iframe

						$("#uploadIFrame").attr("onload",
								"return iframeonload();");

						var data = $
								.parseJSON('{"usr_email" : "cbnmzxcvb@gmail.com","usr_name" : "팜팜","addr_f" : "대구광역시 중구 경상감영길 55","addr_s" : "(서문로1가)","zip_code" : "41919 ","tel" : "null","fax" : "null","mobile" : "null","farm_id" : "null","site_code" : "null","spa_key" : "null","kma_cde" : "2711052000","usr_grade" : "1","is_share" : "null","isadmin" : "null","isdept" : "true","reg_p" : "01","ages" : "20","okdab_birthday" : "null","okdab_sex" : "null","okdab_email" : "null","okdab_id" : "null"}');
						console.log(data);
						$(".select_value").chosen({
							disable_search_threshold : 10
						});
						$(".select_value").trigger("chosen:updated");

						frm_prd.usr_email.value = data.usr_email;
						frm_prd.farm_id.value = data.farm_id;
						frm_prd.is_share.value = data.is_share;
						frm_list_mon.usr_email.value = data.usr_email;
						frm_prd_edit.usr_email.value = data.usr_email;
						//frm_delete.usr_email.value =  data.usr_email;								
						frm_reg_step.usr_email.value = data.usr_email;
						frm_list.usr_email.value = data.usr_email;
						frm_prdlist.usr_email.value = data.usr_email;
						frm_steplist.usr_email.value = data.usr_email;
						frm_reg_pest.usr_email.value = data.usr_email;
						frm_reg_fer.usr_email.value = data.usr_email;
						frm_reg_man.usr_email.value = data.usr_email;
						frm_reg_dev.usr_email.value = data.usr_email;
						frm_steplist_title.usr_email.value = data.usr_email;
						frm_prd_photo.usr_email.value = data.usr_email;
						frm_list_photo.usr_email.value = data.usr_email;
						frm_prd_photo_edit.usr_email.value = data.usr_email;

						var date = new Date();
						var d = date.getDate();
						var m = date.getMonth();
						var y = date.getFullYear();

						$('#calendar')
								.fullCalendar(
										{
											height : 450,
											editable : false,

											viewRender : function(view, element) {
												var s_m = (view.start
														.getMonth() + 1) < 10 ? ("0" + (view.start
														.getMonth() + 1))
														: view.start.getMonth() + 1;
												var s_d = view.start.getDate() < 10 ? ("0" + view.start
														.getDate())
														: view.start.getDate();
												var e_m = (view.end.getMonth() + 1) < 10 ? ("0" + (view.end
														.getMonth() + 1))
														: view.end.getMonth() + 1;
												var e_d = view.end.getDate() < 10 ? ("0" + view.end
														.getDate())
														: view.end.getDate();
												var now_date_s = view.start
														.getFullYear()
														+ "-" + s_m + "-" + s_d;
												var now_date_e = view.end
														.getFullYear()
														+ "-" + e_m + "-" + e_d;

												dojo.byId("now_date_s_select").value = now_date_s;
												dojo.byId("now_date_e_select").value = now_date_e;
												frm_list_mon.now_date.value = y
														+ "-"
														+ ((m + 1) < 10 ? "0"
																+ (m + 1)
																: (m + 1))
														+ "-"
														+ (d < 10 ? "0" + d : d);
												frm_list_photo.now_date.value = y
														+ "-"
														+ ((m + 1) < 10 ? "0"
																+ (m + 1)
																: (m + 1))
														+ "-"
														+ (d < 10 ? "0" + d : d);
												run();
											},
											eventClick : function(calEvent,
													jsEvent, view) {
												if (!calEvent.ismoon) {
													worklist_view(calEvent);
												}
												if (calEvent.isphoto) {
													frm_list_photo.now_date.value = calEvent.id;
													frm_prd_photo.now_date.value = calEvent.id;

													$("#photpfile").remove();
													dojo
															.create(
																	"input",
																	{
																		id : "photpfile",
																		name : "photpfile",
																		"type" : "file",
																		"accept" : "image/jpeg,image/gif,image/png,image/jpg,image/bmp,image/tif"
																	},
																	dojo
																			.byId("filepos"));
													$("#dlg_photo").dialog(
															"open");
													get_photo_list();
												}
											}
										});

						//품목 설정
						get_work_dep("prd_seq");
						//$("#prd_seq").bringToTop();

						//단위설정
						get_pastfer_unt_cde([ {
							"id" : "pest_unt_cde",
							"selected_value" : ""
						}, {
							"id" : "fer_unt_cde",
							"selected_value" : ""
						}, {
							"id" : "pest_unt_cde_edit",
							"selected_value" : ""
						}, {
							"id" : "fer_unt_cde_edit",
							"selected_value" : ""
						} ]);

						get_man_unt_cde([ {
							"id" : "man_unt_cde",
							"selected_value" : ""
						}, {
							"id" : "dev_unt_cde",
							"selected_value" : ""
						}, {
							"id" : "man_unt_cde_edit",
							"selected_value" : ""
						}, {
							"id" : "dev_unt_cde_edit",
							"selected_value" : ""
						} ]);
						//종류설정
						get_diary_knd("pest_knd_cde", "", "get_diary_pestknd");
						get_diary_knd("fer_knd_cde", "", "get_diary_ferknd");
						get_diary_knd("man_knd_cde", "", "get_diary_manknd");
						get_diary_knd("dev_knd_cde", "", "get_diary_devknd");

						$("#now_date").datepicker({
							buttonImage : "/images/icon/calendar.gif",
							buttonImageOnly : true,
							showOn : "button"
						})
								.change(
										function(dateText) {
											frm_list_mon.now_date.value = $(
													"#now_date").val();
											frm_list_photo.now_date.value = $(
													"#now_date").val();
											frm_prd_photo.now_date.value = $(
													"#now_date").val();
											today_weather_past(data.kma_cde, $(
													"#now_date").val());
											get_photo_cnt();
											run();
											return;
										});
						$("#now_date_edit").datepicker({
							buttonImage : "/images/icon/calendar.gif",
							buttonImageOnly : true,
							showOn : "button"
						}).change(
								function(dateText) {
									today_weather_past_edit(data.kma_cde, $(
											"#now_date_edit").val());
									return;

								});
						$("#now_date_add_photo_s").datepicker({
							buttonImage : "/images/icon/calendar.gif",
							buttonImageOnly : true,
							showOn : "button"
						});
						$("#now_date_add_photo_e").datepicker({
							buttonImage : "/images/icon/calendar.gif",
							buttonImageOnly : true,
							showOn : "button"
						});
						set_now("now_date", data.aa, data.bb, function() {
							get_photo_cnt();
							//날씨 가져오기
							if (data.kma_cde != "null") {
								//today_weather(data.kma_cde);										
								today_weather_past(data.kma_cde, $("#now_date")
										.val());
							} else {
								alert("날씨 정보를 설정하기 위하여 날씨지역설정기능을 실행하십시오.");
							}
						});
						var select_list = $(".select_value");
						//z-index 수정
						$.each(select_list, function(index, value) {
							$(value).bind(
									"chosen:showing_dropdown",
									function() {
										$(this).parents("div").css("overflow",
												"visible");
									});
							$(value).on("liszt:hiding_dropdown", function() {
								$(this).parents("div").css("overflow", "");
							});
						});
						//동적추가
						$("#btn_pest_knd_add").click(function() {
							dynmin_add_diary_knd("pest", "pest");
						});
						$("#btn_fer_knd_add").click(function() {
							dynmin_add_diary_knd("fer", "fer");
						});
						$("#btn_man_knd_add").click(function() {
							dynmin_add_diary_knd("man", "man");
						});
						$("#btn_dev_knd_add").click(function() {
							dynmin_add_diary_knd("dev", "dev");
						});
						$("#btn_pest_knd_add_edit").click(function() {
							dynmin_add_diary_knd_for_edit("pest_edit", "pest");
						});
						$("#btn_fer_knd_add_edit").click(function() {
							dynmin_add_diary_knd_for_edit("fer_edit", "fer");
						});
						$("#btn_man_knd_add_edit").click(function() {
							dynmin_add_diary_knd_for_edit("man_edit", "man");
						});
						$("#btn_dev_knd_add_edit").click(function() {
							dynmin_add_diary_knd_for_edit("dev_edit", "dev");
						});
						$("#btn_search_title").click(function() {
							get_worktitle();
						});
						$('#dlg_search_title').submit(function(e) {
							e.preventDefault();
						});
						$("#btn_write_step").click(function() {
							add_work_step();
						});
						$("#btn_write").click(function() {
							add_work(data.is_share);
						});
						$("#btn_write_edit").click(function() {
							if (update_work()) {
								get_photo_cnt();
								run();
								$("#dlg_edit").dialog("close");
							}
						});
						$("#btn_usr_dep_write").click(
								function() {
									if ($("#notfind222") != undefined)
										$('#notfind222').remove();
									$("#news_view_paging_sub").empty();
									$("#sub_board_news_sub").empty();
									$("#news_totalcnt_sub").text("0 건");
									$("#news_curpage_sub").text("0");
									var label = $("<label>").text("검색 전 입니다.")
											.attr("id", "notfind222").appendTo(
													$("#board_box1"));
									$("#zip_code").val("");
									$("#prd_nam").val("");

									frm_prdlist.pagenum.value = 1;
									$("#dlg_ret").dialog("open");
								});
						$('#dlg_ret').submit(function(e) {
							e.preventDefault();
						});
						$("#btn_prd_search").click(function() {
							if (dojo.byId("zip_code").value == "") {
								alert("검색어를 입력하십시오.");
								return;
							}
							search_prd_list();
						});
						$("#zip_code").bind("keydown", function(e) {
							if (e.keyCode == 13) {
								if (dojo.byId("zip_code").value == "") {
									alert("검색어를 입력하십시오.");
									return;
								}
								search_prd_list();
							}
						});
						$("#btn_pest_knd_cde_write").click(function() {
							$("#dlg_add_pest").dialog("open");
						});
						$('#dlg_add_pest').submit(function(e) {
							e.preventDefault();
						});
						$("#btn_write_pest")
								.click(
										function() {
											var usr_email = dojo
													.byId("usr_email").value;
											var unt_nam = dojo.byId("pest_add").value;

											if (unt_nam == "") {
												alert("종류를 설정하십시오.");
												frm_reg_pest.unt_nam.focus();
												return;
											}
											var param = {
												id : "get_diary_dupcheck_pest",
												usr_email : usr_email,
												unt_nam : unt_nam,
												method : "read_List"
											};
											DbUtils
													.getData(
															param,
															function(data) {
																if (data.message == undefined) {
																	alert(unt_nam
																			+ '은(는) 중복됩니다.');
																} else {
																	Acc_opp
																			.insert(
																					"/rest/process/insert",
																					"frm_reg_pest",
																					function() {
																						alert("정상적으로 등록되었습니다.");
																						dojo
																								.byId("pest_add").value = "";
																						$(
																								"#dlg_add_pest")
																								.dialog(
																										"close");
																						get_diary_knd(
																								"pest_knd_cde",
																								data.seq,
																								"get_diary_pestknd");
																					});
																}
															});
										});
						$("#btn_fer_knd_cde_write").click(function() {
							$("#dlg_add_fer").dialog("open");
						});
						$('#dlg_add_fer').submit(function(e) {
							e.preventDefault();
						});

						$("#btn_write_fer")
								.click(
										function() {
											var usr_email = dojo
													.byId("usr_email").value;
											var unt_nam = dojo.byId("fer_add").value;

											if (unt_nam == "") {
												alert("종류를 설정하십시오.");
												frm_reg_fer.unt_nam.focus();
												return;
											}
											var param = {
												id : "get_diary_dupcheck_fer",
												usr_email : usr_email,
												unt_nam : unt_nam,
												method : "read_List"
											};
											DbUtils
													.getData(
															param,
															function(data) {
																if (data.message == undefined) {
																	alert(unt_nam
																			+ '은(는) 중복됩니다.');
																} else {
																	Acc_opp
																			.insert(
																					"/rest/process/insert",
																					"frm_reg_fer",
																					function(
																							result) {
																						alert("정상적으로 입력되었습니다.");
																						dojo
																								.byId("fer_add").value = "";
																						$(
																								"#dlg_add_fer")
																								.dialog(
																										"close");
																						get_diary_knd(
																								"fer_knd_cde",
																								result.seq,
																								"get_diary_ferknd");
																					});
																}
															});
										});
						$("#btn_man_knd_cde_write").click(function() {
							$("#dlg_add_man").dialog("open");
						});
						$('#dlg_add_man').submit(function(e) {
							e.preventDefault();
						});
						$("#btn_write_man")
								.click(
										function() {
											var usr_email = dojo
													.byId("usr_email").value;
											var unt_nam = dojo.byId("man_add").value;

											if (unt_nam == "") {
												alert("종류를 설정하십시오.");
												frm_reg_man.unt_nam.focus();
												return;
											}
											var param = {
												id : "get_diary_dupcheck_man",
												usr_email : usr_email,
												unt_nam : unt_nam,
												method : "read_List"
											};
											DbUtils
													.getData(
															param,
															function(data) {
																if (data.message == undefined) {
																	alert(unt_nam
																			+ '은(는) 중복됩니다.');
																} else {
																	Acc_opp
																			.insert(
																					"/rest/process/insert",
																					"frm_reg_man",
																					function(
																							result) {
																						alert("정상적으로 입력되었습니다.");
																						dojo
																								.byId("man_add").value = "";
																						$(
																								"#dlg_add_man")
																								.dialog(
																										"close");
																						get_diary_knd(
																								"man_knd_cde",
																								result.seq,
																								"get_diary_manknd");
																					});
																}
															});
										});

						$("#btn_dev_knd_cde_write").click(function() {
							$("#dlg_add_dev").dialog("open");
						});
						$('#dlg_add_dev').submit(function(e) {
							e.preventDefault();
						});

						$("#btn_write_dev")
								.click(
										function() {
											var usr_email = dojo
													.byId("usr_email").value;
											var unt_nam = dojo.byId("dev_add").value;

											if (unt_nam == "") {
												alert("종류를 설정하십시오.");
												frm_reg_dev.unt_nam.focus();
												return;
											}
											var param = {
												id : "get_diary_dupcheck_dev",
												usr_email : usr_email,
												unt_nam : unt_nam,
												method : "read_List"
											};
											DbUtils
													.getData(
															param,
															function(data) {
																if (data.message == undefined) {
																	alert(unt_nam
																			+ '은(는) 중복됩니다.');
																} else {
																	Acc_opp
																			.insert(
																					"/rest/process/insert",
																					"frm_reg_dev",
																					function(
																							result) {
																						alert("정상적으로 입력되었습니다.");
																						dojo
																								.byId("dev_add").value = "";
																						$(
																								"#dlg_add_dev")
																								.dialog(
																										"close");
																						get_diary_knd(
																								"dev_knd_cde",
																								result.seq,
																								"get_diary_devknd");
																					});
																}
															});
										});
						$("#btn_usr_step_write").click(
								function() {
									get_work_dep("prd_seq_add", dojo
											.byId("prd_seq").value);
									get_work_step_add("step_cde_add");
									$("#dlg_step").dialog("open");
								});
						$("#btn_prd_apply").click(
								function() {
									if ($("#zip_code").val() == ""
											|| $("#prd_nam").val() == "") {
										alert("품종명을 검색하여 리스트에서 품목을 선택해 주세요.");
										return;
									} else {
										add_diary_prd_bymain_appay();
									}
								});
						$("#dlg_photo").dialog({
							autoOpen : false,
							modal : true,
							// height: 500,    // 창의 높이 설정. 기본 auto.
							width : 660, // 창의 넓이 설정. 기본 auto.
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						$("#dlg_photo_view").dialog({
							autoOpen : false,
							modal : true,
							// height: 500,    // 창의 높이 설정. 기본 auto.
							width : 560, // 창의 넓이 설정. 기본 auto.
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						$("#dlg_photo_edit").dialog({
							autoOpen : false,
							modal : true,
							// height: 500,    // 창의 높이 설정. 기본 auto.
							width : 660, // 창의 넓이 설정. 기본 auto.
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						$("#dlg_edit").dialog({
							autoOpen : false,
							position : [ 'center', 20 ],
							modal : true,
							// height: 500,    // 창의 높이 설정. 기본 auto.
							width : 1064, // 창의 넓이 설정. 기본 auto.
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						$("#dlg_search_title").dialog({
							autoOpen : false,
							modal : true,
							//height: 200,    // 창의 높이 설정. 기본 auto.
							width : 440, // 창의 넓이 설정. 기본 auto.
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						$("#dlg_step").dialog({
							autoOpen : false,
							modal : true,
							//height: 200,    // 창의 높이 설정. 기본 auto.
							width : 400, // 창의 넓이 설정. 기본 auto.
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						$("#dlg_ret").dialog({
							autoOpen : false,
							modal : true,
							// height: 150,    // 창의 높이 설정. 기본 auto.
							width : 460, // 창의 넓이 설정. 기본 auto.
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						$("#dlg_step_search").dialog({
							autoOpen : false,
							modal : true,
							// height: 150,    // 창의 높이 설정. 기본 auto.
							width : 460, // 창의 넓이 설정. 기본 auto.
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						$("#dlg_add_pest").dialog({
							autoOpen : false,
							modal : true,
							width : 460, // 창의 넓이 설정. 기본 auto.
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						$("#dlg_add_fer").dialog({
							autoOpen : false,
							modal : true,
							width : 460, // 창의 넓이 설정. 기본 auto.
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						$("#dlg_add_man").dialog({
							autoOpen : false,
							modal : true,
							width : 460, // 창의 넓이 설정. 기본 auto.
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						$("#dlg_add_dev").dialog({
							autoOpen : false,
							modal : true,
							width : 460, // 창의 넓이 설정. 기본 auto.
							buttons : {
								"닫기" : function() {
									$(this).dialog("close");
								}
							}
						});
						/* $("#dlg_kma_past").dialog({
							autoOpen : false,
							modal : true,
							width : 300
						// 창의 넓이 설정. 기본 auto.
						//,buttons:{ "닫기": function() { $(this).dialog("close"); } }
						}); */
						$("#btn_photo_add_open")
								.click(
										function() {
											frm_prd_photo.now_date.value = $(
													"#now_date").val();
											frm_list_photo.now_date.value = $(
													"#now_date").val();

											$("#photpfile").remove();

											dojo
													.create(
															"input",
															{
																id : "photpfile",
																name : "photpfile",
																"type" : "file",
																"accept" : "image/jpeg,image/gif,image/png,image/jpg,image/bmp,image/tif"
															},
															dojo
																	.byId("filepos"));

											$("#dlg_photo").dialog("open");
											get_photo_list();
										});
						$("#btn_photo_add_open_edit").click(
								function() {
									frm_prd_photo.now_date.value = $(
											"#now_date_edit").val();
									$("#dlg_photo").dialog("open");
									get_photo_list();
								});
						$("#btn_delete")
								.click(
										function() {
											if (confirm("관련된 농약,비료,인력,장비 및 사진정보가 모두 삭제됩니다. \n 정말로 삭제 하시겠습니까?")) {
												Acc_opp
														.insert(
																"/rest/process/insert",
																"frm_delete",
																function() {
																	$(
																			"#dlg_edit")
																			.dialog(
																					"close");
																	var xhrArgs = {
																		handleAs : "json",
																		form : dojo
																				.byId("frm_list"),
																		load : function(
																				result) {
																			if (result.message == "success") {
																				alert("정상적으로 삭제 되었습니다.");
																				run();
																				//callbackfuncn_workdiary(result.data, "", function() {});
																			} else {
																				dojo
																						.empty("news_view_paging");
																				dojo
																						.empty("sub_board_news");
																				dojo
																						.create(
																								"label",
																								{
																									id : "notfind",
																									innerHTML : "검색결과가 없습니다."
																								},
																								dojo
																										.byId("board_box"));
																			}
																		},
																		error : function(
																				error) {
																			var targetNode = "영농일지 오류"
																					+ error;
																			alert(targetNode);
																			return;
																		}
																	};
																	var deferred = dojo
																			.xhrPost(xhrArgs);
																});
											} else {
												//doc-ument.write("승인 취소.");
											}
										});
						$("#btn_step_list_all")
								.click(
										function() {
											dojo.byId("frm_steplist_prd_seq").value = dojo
													.byId("prd_seq").value;
											search_step_list();
											$("#dlg_step_search")
													.dialog("open");
										});

						$("#search_btn_prd_search").click(function() {
							search_step_list();
						});

						$("#search_work_title").bind("keydown", function(e) {
							if (e.keyCode == 13) {
								search_step_list();
							}
						});

						$("#search_btn_prd_search_title").click(function() {
							get_worktitle();
						});

						$('#dlg_step_search').submit(function(e) {
							e.preventDefault();
						});
						$("#accordion").tabs();
						$("#accordion_edit").tabs();
						$('#prd_seq').bind("mousedown", function() {
							$(this).bringToTop();
						});
					} else {
						alert("로그인 후 이용하실 수 있습니다.");
						location.href = "/rest/login";
					}
				});
			});
	$(function() {
		$("#accordion-resizer").resizable({
			minHeight : 240,
			//minWidth: 200,
			resize : function() {
				$("#accordion").accordion("refresh");
			}
		});
	});
</script>
<style>
textarea {
	width: 98%;
	height: 98%;
	overflow: visible;
	border: 1px solid #333;
	padding: 4px;
}

.listPhoto {
	color: #170B3B;
	background: url("/images/camera.png") right center no-repeat;
}
</style>
</head>

<body class="claro">
	<div id="warp">
		<div id="header_warp">
			<div id="header">
				<div class="logo"></div>
				<div id="top_menu_top">
					<span class="welcome">팜팜 님 환영합니다.</span><a href="/rest/main"><span>홈</span></a><span>
						| </span><span><a href="#">로그아웃</a></span><span> | </span><span><a
						href="/rest/user_reg_edit">회원정보수정</a></span>
				</div>
				<div id="top_menu">
					<div class="depth00_container">
						<ul>
							<li id="01      " class="depth00_grade0 first"><a
								href="/rest/acc_input"><span>간편회계관리</span></a></li>
							<li class="spliter"><span class="spliter">|</span></li>
							<li id="39      " class="depth00_grade0 current"><a
								href="/rest/diary"><span>생산관리</span></a></li>
							<li class="spliter"><span class="spliter">|</span></li>
							<li id="04      " class="depth00_grade0"><a
								href="/rest/getpastdata"><span>환경설정</span></a></li>
							<li class="spliter"><span class="spliter">|</span></li>
							<li id="35      " class="depth00_grade0"><a
								href="/rest/board_info"><span>게시판</span></a></li>
						</ul>
					</div>
					<div class="depth01_container">
						<div id="PP01" class="sub_container"
							style="left: 0px; width: 760px;">
							<ul id="01">
								<li class="subsub"><a href="/rest/acc_input"><span>간이장부</span></a></li>
								<li class="spliter"><span class="spliter">|</span></li>
								<li class="subsub"><a href="/rest/acc_stat"><span>간이통계</span></a></li>
								<li class="spliter"><span class="spliter">|</span></li>
								<li class="subsub"><a href="/rest/env_acc_itm"><span>계정설정</span></a></li>
								<li class="spliter"><span class="spliter">|</span></li>
								<li class="subsub"><a href="/rest/usr_env_cmp"><span>거래처설정</span></a></li>
								<li class="spliter"><span class="spliter">|</span></li>
								<li class="subsub"><a href="/rest/usr_env_dep"><span>사업구분설정</span></a></li>
							</ul>
						</div>
						<div id="PP39" class="sub_container current"
							style="left: 260px; width: 480px;">
							<ul id="39">
								<li class="subsub current"><a href="/rest/diary"><span>영농일지</span></a></li>
								<li class="spliter"><span class="spliter">|</span></li>
								<li class="subsub"><a href="/rest/diary_identify"><span>조회
											및 출력</span></a></li>
							</ul>
						</div>
						<div id="PP04" class="sub_container"
							style="left: 400px; width: 550px;">
							<ul id="04">
								<li class="subsub"><a href="/rest/getpastdata"><span>기존데이터가져오기</span></a></li>
								<li class="spliter"><span class="spliter">|</span></li>
								<li class="subsub"><a href="/rest/resetmydata"><span>자료초기화</span></a></li>
								<li class="spliter"><span class="spliter">|</span></li>
								<li class="subsub"><a href="/rest/nfarmbookdata"><span>생산경영장부
											데이터 이전</span></a></li>
							</ul>
						</div>
						<div id="PP35" class="sub_container"
							style="left: 715px; width: 450px;">
							<ul id="35">
								<li class="subsub"><a href="/rest/board_info"><span>공지사항</span></a></li>
								<li class="spliter"><span class="spliter">|</span></li>
								<li class="subsub"><a href="/rest/board_qa"><span>질문답변</span></a></li>
								<li class="spliter"><span class="spliter">|</span></li>
								<li class="subsub"><a href="/rest/board_free"><span>자유게시판</span></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="navi_area">
			<div id="navi_box">
				<div class="div_navi_content">
					<a href="/" class="bullet_home"><span>홈</span></a><span>
						&gt; </span><a href="/rest/diary"><span>생산관리</span></a><span> &gt;
					</span><a href="/rest/diary"><span>영농일지</span></a><span> &gt; </span><a
						href="/rest/diary"><span>영농일지</span></a>
				</div>
				<div class="div_title_content">
					<span class="bullet_home">영농일지</span>
				</div>
			</div>
		</div>
		<div id="page_menu_area">
			<div id="page_menu_box">
				<div class="depth02_container">
					<div id="390101" class="current fixwidth">
						<a href="/rest/diary"><span>영농일지</span></a>
					</div>
					<div id="390103" class="fixwidth">
						<a href="/rest/diary_prd"><span>영농일지품목설정</span></a><img
							src="/images/guide_icon.gif" class="guideIcon"
							onmousedown="PopLayer.Action(this,'layer1');">
					</div>
					<div id="390102" class="fixwidth">
						<a href="/rest/diary_step"><span>작업과정설정</span></a>
					</div>
					<div id="390105" class="fixwidth">
						<a href="/rest/diary_env"><span>농약/비료/장비설정</span></a>
					</div>
					<div id="390104" class="fixwidth">
						<a href="/rest/diary_weather"><span>날씨지역설정</span></a><img
							src="/images/guide_icon.gif" class="guideIcon"
							onmousedown="PopLayer.Action(this,'layer2');">
					</div>
				</div>
			</div>
		</div>
		<div id="main_contents">
			<div id="where_area" style="min-height: 400px;">
				<div id="where_box">
					<div class="acc_diary" style="width: 1004px;">
						<form enctype="multipart/mixed"
							action="/rest/process/diary_new/insert" id="frm_prd"
							name="frm_prd" method="post">
							<div class="top">
								<div
									style="position: relative; float: left; width: 200px; background: url(/images/diary/date_bak.gif); font-size: 14px; font-weight: bold; margin-top: 0px; height: 35px; padding-top: 10px;">
									<input type="text" name="now_date" id="now_date" value=""
										style="width: 126px; font-size: 12px !important; text-align: center;"
										class="hasDatepicker"><img
										class="ui-datepicker-trigger" src="/images/icon/calendar.gif"
										alt="..." title="...">
								</div>
								<div style="padding-top: 10px;">
									<div class="label" style="width: 50px;">
										<span>날씨</span><img src="/images/guide_icon.gif"
											class="guideIcon"
											onmousedown="PopLayer.Action(this,'layer3');">
									</div>
									<div class="value" style="width: 80px;">
										<select id="wfKor" name="wfKor" class="select_value"
											data-placeholder="선택" style="width: 78px; display: none;">
											<option value="1">맑음</option>
											<option value="2">구름 조금</option>
											<option value="3">구름 많음</option>
											<option value="4">흐림</option>
											<option value="5">비</option>
											<option value="6">눈/비</option>
											<option value="7">눈</option>
										</select>
										<div
											class="chosen-container chosen-container-single chosen-container-single-nosearch"
											style="width: 78px;" title="" id="wfKor_chosen">
											<a class="chosen-single" tabindex="-1"><span>맑음</span>
											<div>
													<b></b>
												</div></a>
											<div class="chosen-drop">
												<div class="chosen-search">
													<input type="text" autocomplete="off" readonly="">
												</div>
												<ul class="chosen-results"></ul>
											</div>
										</div>
									</div>
									<div class="label var" style="width: 90px;">
										<span>기온(℃)</span>
									</div>
									<div class="value var">
										<input name="current_temp" id="current_temp"
											style="width: 36px;">
									</div>
									<div class="label" style="width: 90px;">
										<span>최저기온(℃)</span>
									</div>
									<div class="value">
										<input name="low_temp" id="low_temp" style="width: 36px;">
									</div>
									<div class="label" style="width: 90px;">
										<span>최고기온(℃)</span>
									</div>
									<div class="value">
										<input name="high_temp" id="high_temp" style="width: 36px;">
									</div>
									<div class="label var " style="width: 60px;">
										<span>습도(%)</span>
									</div>
									<div class="value var">
										<input name="reh" id="reh" style="width: 36px;">
									</div>
									<div class="label var" style="width: 90px;">
										<span>강수확률(%)</span>
									</div>
									<div class="value var">
										<input name="pop" id="pop" style="width: 36px;">
									</div>
									<div class="label" style="width: 90px;">
										<span>강수량(mm)</span>
									</div>
									<div class="value">
										<input name="r12" id="r12" style="width: 36px;">
									</div>
									<div class="label" style="width: 90px;">
										<span>적설량(cm)</span>
									</div>
									<div class="value">
										<input name="s12" id="s12" style="width: 36px;">
									</div>
									<div class="label" style="width: 150px; text-align: center;">
										<span id="kma_load"><b style="color: #58AA52;">조회
												완료</b></span>
									</div>
								</div>
							</div>
							<div class="title">
								<span>영 농 일 지 작 성</span>
							</div>
							<div class="leftff">
								<div class="sub_title">일반정보</div>
								<div style="height: 68px;" class="outline">
									<div class="label bgcol" style="width: 80px;">
										<span>품목선택</span>
									</div>
									<div class="value" style="text-align: left;">
										<select class="select_value" data-placeholder="선택"
											id="prd_seq" name="prd_seq"
											style="width: 256px; display: none;" onchange=""><option
												value=""></option>
											<option value="30536">과실류/사과/사과(사과)</option>
											<option value="30537">과실류/복숭아/복숭아(복숭아)</option>
											<option value="30538">과실류/복숭아/사자(사자)</option>
											<option value="30550">과실류/사과/홍로(홍로)</option></select>
										<div
											class="chosen-container chosen-container-single chosen-container-single-nosearch"
											style="width: 256px;" title="" id="prd_seq_chosen">
											<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
											<div>
													<b></b>
												</div></a>
											<div class="chosen-drop">
												<div class="chosen-search">
													<input type="text" autocomplete="off" readonly="">
												</div>
												<ul class="chosen-results"></ul>
											</div>
										</div>
									</div>
									<div style="position: relative; float: right;">
										<button id="btn_usr_dep_write" type="button"
											class="small-button"
											style="font-size: 12px; width: 40px !important;">신규</button>
									</div>
									<div style="clear: both;"></div>
									<div
										style="position: relative; float: left; padding: 2px 0px 0px 80px;">
										<span>품목선택은 대분류/중분류/소분류(명칭)로 구분됩니다.</span>
									</div>
									<div style="clear: both;"></div>
									<div class="label bgcol" style="width: 80px;">
										<span>영농과정</span>
									</div>
									<div class="value" style="text-align: left; padding-top: 1px;">
										<select class="select_value" data-placeholder="선택"
											name="step_seq" id="step_seq"
											style="width: 256px; display: none;" onchange=""></select>
										<div
											class="chosen-container chosen-container-single chosen-container-single-nosearch"
											style="width: 256px;" title="" id="step_seq_chosen">
											<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
											<div>
													<b></b>
												</div></a>
											<div class="chosen-drop">
												<div class="chosen-search">
													<input type="text" autocomplete="off" readonly="">
												</div>
												<ul class="chosen-results"></ul>
											</div>
										</div>
									</div>
									<div style="position: relative; float: right;">
										<button id="btn_step_list_all" type="button"
											class="small-button"
											style="font-size: 12px; width: 40px !important;">검색</button>
										<button id="btn_usr_step_write" type="button"
											class="small-button"
											style="font-size: 12px; width: 40px !important;">신규</button>
									</div>
								</div>
								<div style="height: 100px;" class="outline">
									<div class="label bgcol" style="width: 80px;">
										<span>작업명</span>
									</div>
									<div class="value" style="text-align: left; padding-top: 1px;">
										<input id="work_title" name="work_title"
											style="width: 252px; height: 19px;">
									</div>
									<div style="clear: both;"></div>
									<div class="label bgcol"
										style="width: 80px; height: 64px; margin-top: 5px;">
										<span>작업내용</span>
									</div>
									<div class="label" style="width: 400px; height: 60px;">
										<textarea name="work_des" id="work_des" rows="6" cols="88"
											placeholder="작업내용을 입력하세요."></textarea>
									</div>
								</div>
								<div style="height: 30px;" class="outline">
									<div class="label" style="width: 80px;">
										<span>작업사진</span>
									</div>
									<div class="value" style="text-align: left; padding-top: 6px;">
										<span id="photo_count">2016-11-24 등록사진 0 장</span>
									</div>
									<div
										style="position: relative; float: right; padding-top: 6px;">
										<button id="btn_photo_add_open" type="button"
											class="small-button"
											style="font-size: 12px; width: 80px !important;">사진관리</button>
										<img src="/images/guide_icon.gif" class="guideIcon"
											onmousedown="PopLayer.Action(this,'layer4');">
									</div>
								</div>
							</div>
							<div class="right">
								<div class="sub_title2">추가정보</div>
								<div id="accordion"
									class="ui-tabs ui-widget ui-widget-content ui-corner-all">
									<ul
										class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all"
										role="tablist">
										<li
											class="ui-state-default ui-corner-top ui-tabs-active ui-state-active"
											role="tab" tabindex="0" aria-controls="tabs-1"
											aria-labelledby="ui-id-13" aria-selected="true"><a
											href="#tabs-1" class="ui-tabs-anchor" role="presentation"
											tabindex="-1" id="ui-id-13">농약사용량</a></li>
										<li class="ui-state-default ui-corner-top" role="tab"
											tabindex="-1" aria-controls="tabs-2"
											aria-labelledby="ui-id-14" aria-selected="false"><a
											href="#tabs-2" class="ui-tabs-anchor" role="presentation"
											tabindex="-1" id="ui-id-14">비료사용량</a></li>
										<li class="ui-state-default ui-corner-top" role="tab"
											tabindex="-1" aria-controls="tabs-3"
											aria-labelledby="ui-id-15" aria-selected="false"><a
											href="#tabs-3" class="ui-tabs-anchor" role="presentation"
											tabindex="-1" id="ui-id-15">인력사용량</a></li>
										<li class="ui-state-default ui-corner-top" role="tab"
											tabindex="-1" aria-controls="tabs-4"
											aria-labelledby="ui-id-16" aria-selected="false"><a
											href="#tabs-4" class="ui-tabs-anchor" role="presentation"
											tabindex="-1" id="ui-id-16">장비사용량</a></li>
									</ul>
									<div id="tabs-1" aria-labelledby="ui-id-13"
										class="ui-tabs-panel ui-widget-content ui-corner-bottom"
										role="tabpanel" aria-expanded="true" aria-hidden="false">
										<div class="label" style="width: 80px;">
											<span>농약종류</span>
										</div>
										<div class="value"
											style="float: left !important; text-align: left;">
											<select id="pest_knd_cde" name="pest_knd_cde"
												class="select_value" data-placeholder="선택"
												style="width: 232px; display: none;" onchange=""><option
													value=""></option>
												<option value="11780">농약1</option>
												<option value="11781">농약2</option>
												<option value="11784">ㅁㄴㅇㄴㅇ</option></select>
											<div
												class="chosen-container chosen-container-single chosen-container-single-nosearch"
												style="width: 232px;" title="" id="pest_knd_cde_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off" readonly="">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="position: relative; float: right;">
											<button id="btn_pest_knd_cde_write" type="button"
												class="small-button" style="width: 80px !important;">농약추가</button>
										</div>
										<div style="clear: both;"></div>
										<div class="label" style="width: 80px;">
											<span>사용량</span>
										</div>
										<div class="value"
											style="float: left !important; text-align: left;">
											<input name="pest_amt" id="pest_amt" style="width: 58px;">
										</div>
										<div class="label" style="width: 70px;">
											<span>단위</span>
										</div>
										<div class="value"
											style="width: 100px; float: left !important; text-align: left;">
											<select id="pest_unt_cde" name="pest_unt_cde"
												class="select_value" data-placeholder="선택"
												style="width: 100px; display: none;" onchange=""><option
													value=""></option>
												<option value="10">상자(BOX)</option>
												<option value="11">낱개(EA)</option>
												<option value="12">통</option>
												<option value="13">포</option>
												<option value="14">망</option>
												<option value="15">그리티(C/T)</option>
												<option value="16">콘티</option>
												<option value="17">m²</option>
												<option value="18">kg</option>
												<option value="19">병(통)</option>
												<option value="20">병</option>
												<option value="21">봉지</option>
												<option value="22">포대</option>
												<option value="23">실린</option>
												<option value="24">봉</option>
												<option value="25">약통(캔)</option>
												<option value="26">봉지(통)</option>
												<option value="27">g</option>
												<option value="28">ml</option>
												<option value="29">L</option>
												<option value="99">기타</option></select>
											<div class="chosen-container chosen-container-single"
												style="width: 100px;" title="" id="pest_unt_cde_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="position: relative; float: right;">
											<button id="btn_pest_knd_add" type="button"
												class="small-button " style="width: 80px !important;">신규등록</button>
										</div>
										<div style="clear: both;"></div>
									</div>
									<div id="tabs-2" aria-labelledby="ui-id-14"
										class="ui-tabs-panel ui-widget-content ui-corner-bottom"
										role="tabpanel" aria-expanded="false" aria-hidden="true"
										style="display: none;">
										<div class="label" style="width: 80px;">
											<span>비료종류</span>
										</div>
										<div class="value" style="float: left;">
											<select id="fer_knd_cde" name="fer_knd_cde"
												class="select_value" data-placeholder="선택"
												style="width: 232px; display: none;" onchange=""><option
													value=""></option>
												<option value="7595">비료1</option></select>
											<div
												class="chosen-container chosen-container-single chosen-container-single-nosearch"
												style="width: 232px;" title="" id="fer_knd_cde_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off" readonly="">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="position: relative; float: right;">
											<button id="btn_fer_knd_cde_write" type="button"
												class="small-button " style="width: 80px !important;">비료추가</button>
										</div>
										<div style="clear: both;"></div>
										<div class="label" style="width: 80px;">
											<span>사용량</span>
										</div>
										<div class="value"
											style="float: left !important; text-align: left;; float: left;">
											<input name="fer_amt" id="fer_amt" style="width: 58px;">
										</div>
										<div class="label" style="width: 70px;">
											<span>단위</span>
										</div>
										<div class="value" style="width: 100px;">
											<select id="fer_unt_cde" name="fer_unt_cde"
												class="select_value" data-placeholder="선택"
												style="width: 100px; display: none;" onchange=""><option
													value=""></option>
												<option value="10">상자(BOX)</option>
												<option value="11">낱개(EA)</option>
												<option value="12">통</option>
												<option value="13">포</option>
												<option value="14">망</option>
												<option value="15">그리티(C/T)</option>
												<option value="16">콘티</option>
												<option value="17">m²</option>
												<option value="18">kg</option>
												<option value="19">병(통)</option>
												<option value="20">병</option>
												<option value="21">봉지</option>
												<option value="22">포대</option>
												<option value="23">실린</option>
												<option value="24">봉</option>
												<option value="25">약통(캔)</option>
												<option value="26">봉지(통)</option>
												<option value="27">g</option>
												<option value="28">ml</option>
												<option value="29">L</option>
												<option value="99">기타</option></select>
											<div class="chosen-container chosen-container-single"
												style="width: 100px;" title="" id="fer_unt_cde_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="position: relative; float: right;">
											<button id="btn_fer_knd_add" type="button"
												class="small-button " style="width: 80px !important;">신규등록</button>
										</div>
										<div style="clear: both;"></div>
									</div>
									<div id="tabs-3" aria-labelledby="ui-id-15"
										class="ui-tabs-panel ui-widget-content ui-corner-bottom"
										role="tabpanel" aria-expanded="false" aria-hidden="true"
										style="display: none;">
										<div class="label" style="width: 80px;">
											<span>인력종류</span>
										</div>
										<div class="value" style="float: left;">
											<select id="man_knd_cde" name="man_knd_cde"
												class="select_value" data-placeholder="선택"
												style="width: 232px; display: none;" onchange=""><option
													value=""></option></select>
											<div
												class="chosen-container chosen-container-single chosen-container-single-nosearch"
												style="width: 232px;" title="" id="man_knd_cde_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off" readonly="">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="position: relative; float: right;">
											<button id="btn_man_knd_cde_write" type="button"
												class="small-button " style="width: 80px !important;">인력추가</button>
										</div>
										<div style="clear: both;"></div>
										<div class="label" style="width: 80px;">
											<span>작업시간</span>
										</div>
										<div class="value"
											style="float: left !important; text-align: left;; float: left;">
											<input name="man_amt" id="man_amt" style="width: 58px;">
										</div>
										<div class="label" style="width: 70px;">
											<span>단위</span>
										</div>
										<div class="value" style="width: 100px;">
											<select id="man_unt_cde" name="man_unt_cde"
												class="select_value" data-placeholder="선택"
												style="width: 100px; display: none;" onchange=""><option
													value=""></option>
												<option value="01">시간</option>
												<option value="02">일</option>
												<option value="03">분</option></select>
											<div
												class="chosen-container chosen-container-single chosen-container-single-nosearch"
												style="width: 100px;" title="" id="man_unt_cde_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off" readonly="">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="position: relative; float: right;">
											<button id="btn_man_knd_add" type="button"
												class="small-button " style="width: 80px !important;">신규등록</button>
										</div>
										<div style="clear: both;"></div>
									</div>
									<div id="tabs-4" aria-labelledby="ui-id-16"
										class="ui-tabs-panel ui-widget-content ui-corner-bottom"
										role="tabpanel" aria-expanded="false" aria-hidden="true"
										style="display: none;">
										<div class="label" style="width: 80px;">
											<span>장비종류</span>
										</div>
										<div class="value" style="float: left;">
											<select id="dev_knd_cde" name="dev_knd_cde"
												class="select_value" data-placeholder="선택"
												style="width: 232px; display: none;" onchange=""><option
													value=""></option>
												<option value="9418">곡괭이</option></select>
											<div
												class="chosen-container chosen-container-single chosen-container-single-nosearch"
												style="width: 232px;" title="" id="dev_knd_cde_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off" readonly="">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="position: relative; float: right;">
											<button id="btn_dev_knd_cde_write" type="button"
												class="small-button " style="width: 80px !important;">장비추가</button>
										</div>
										<div style="clear: both;"></div>
										<div class="label" style="width: 80px;">
											<span>사용기간</span>
										</div>
										<div class="value" style="float: left;">
											<input name="dev_amt" id="dev_amt" style="width: 58px;">
										</div>
										<div class="label" style="width: 70px;">
											<span>단위</span>
										</div>
										<div class="value" style="width: 100px;">
											<select id="dev_unt_cde" name="dev_unt_cde"
												class="select_value" data-placeholder="선택"
												style="width: 100px; display: none;" onchange=""><option
													value=""></option>
												<option value="01">시간</option>
												<option value="02">일</option>
												<option value="03">분</option></select>
											<div
												class="chosen-container chosen-container-single chosen-container-single-nosearch"
												style="width: 100px;" title="" id="dev_unt_cde_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off" readonly="">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="position: relative; float: right;">
											<button id="btn_dev_knd_add" type="button"
												class="small-button " style="width: 80px !important;">신규등록</button>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
								<div class="detail">
									<table id="board_add_pest" class="boardList_diary_simple"
										style="width: 100% !important; color: #ccc !important; border-collapse: collapse;"
										summary="게시판목록">
										<caption>게시판목록</caption>
										<colgroup>
											<col width="100px">
											<col>
											<col width="100px">
											<col width="80px">
											<col width="50px">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">구분</th>
												<th scope="col">종류</th>
												<th scope="col">사용량</th>
												<th scope="col">단위</th>
												<th scope="col">삭제</th>
											</tr>
										</thead>
										<tbody id="sub_board_pest"></tbody>
									</table>
								</div>
							</div>
							<input type="hidden" id="usr_email" name="usr_email"
								value="cbnmzxcvb@gmail.com"> <input type="hidden"
								name="diary_seq" value=""> <input type="hidden"
								name="insert_id" value="insert_work"> <input
								type="hidden" id="dep_seq" name="dep_seq" value=""> <input
								type="hidden" id="dep_cde_hidden" name="dep_cde_hidden" value="">
							<input type="hidden" id="prd_l1_cde" name="prd_l1_cde" value="">
							<input type="hidden" id="ord" name="ord" value=""> <input
								type="hidden" id="work_knd" name="work_knd" value=""> <input
								type="hidden" id="work" name="work" value=""> <input
								type="hidden" id="step_cde" name="step_cde" value=""> <input
								type="hidden" id="farm_id" name="farm_id" value="null">
							<input type="hidden" id="is_share" name="is_share" value="null">
						</form>
					</div>
				</div>
			</div>
			<div style="width: 100%; position: relative;">
				<div style="width: 1024px; text-align: center; margin: 0 auto;">
					<button id="btn_write" type="button"
						class="rc-button rc-button-submit"
						style="width: 200px !important;">작성완료</button>
				</div>
			</div>
			<div id="list_area">
				<div id="list_box"
					style="min-height: 1060px !important; overflow: auto; overflow-x: hidden;">
					<div id="condition_area">
						<div id="condition_box">
							<form action="/rest/data/get" id="frm_list_mon"
								name="frm_list_mon" method="post">
								<input type="hidden" id="usr_email" name="usr_email"
									value="cbnmzxcvb@gmail.com"> <input type="hidden"
									id="method" name="method" value="read_List"> <input
									type="hidden" id="pagenum" name="pagenum" value="1"> <input
									type="hidden" id="numrow" name="numrow" value="5"> <input
									type="hidden" name="now_date" value="2016-11-24"> <input
									type="hidden" id="id" name="id" value="worklistforidentify">
								<input type="hidden" name="callback"
									value="callbackfuncn_work_list_mon"> <input
									type="hidden" name="filename" value="영농일지">
							</form>
							<div class="board_area">
								<div id="board_box_mon">
									<div style="position: relative; float: left; width: 260px;">
										<div
											style="text-align: left; margin-bottom: 4px; font-size: 14px;">
											<span id="list_date">2016-11-24 영농일지 작업</span>
										</div>
									</div>
									<div class="hitbox"
										style="width: 400px; float: right; text-align: right; padding-right: 80px;">
										총 :<span id="news_totalcnt_mon" class="ft_color"> 1 건 </span>,
										현재페이지 :<span id="news_curpage_mon" class="ft_color">1</span>
									</div>
									<div style="clear: both;"></div>
									<table class="boardList" style="width: 990px !important;"
										summary="게시판목록">
										<caption>게시판목록</caption>
										<colgroup>
											<col width="80px">
											<col width="100px">
											<col width="80px">
											<col width="60px">
											<col width="60px">
											<col width="60px">
											<col width="100px">
											<col>
											<col width="80px">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">작업일자</th>
												<th scope="col">품목</th>
												<th scope="col">영농과정</th>
												<th scope="col">날씨</th>
												<th scope="col">최저온도</th>
												<th scope="col">최고온도</th>
												<th scope="col">작업명</th>
												<th scope="col">작업내용</th>
												<th scope="col">관리</th>
											</tr>
										</thead>
										<tbody id="sub_board_news_mon">
											<tr>
												<td class="center"><label>2016-11-24</label></td>
												<td class="center"><label>과실류/사과/사과(사과)</label></td>
												<td class="center"><label>준비기</label></td>
												<td class="center"><label>맑음</label></td>
												<td class="center"><label></label></td>
												<td class="center"><label></label></td>
												<td class="center"><label>낙엽</label></td>
												<td class="left last"><label>낙엽</label></td>
												<td class="center"><input type="button" value="수정"
													class="btn_edit"><input type="button" value="삭제"
													class="btn_delete"></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="paging" id="news_view_paging_mon">
									<span class="num"><a id="pagging_num1" class="on"
										href="javascript:tttt(1,callbackfuncn_work_list_mon,'frm_list_mon')">1</a></span>
								</div>
							</div>
							<div style="clear: both;"></div>
							<div class="acc_list" style="width: 990px !important;">
								<div id="calendar" class="fc fc-ltr">
									<table class="fc-header" style="width: 100%">
										<tbody>
											<tr>
												<td class="fc-header-left"><span
													class="fc-header-title"><h2>2016년 11월</h2></span></td>
												<td class="fc-header-center"></td>
												<td class="fc-header-right"><span
													class="fc-button fc-button-today fc-state-default fc-corner-left fc-corner-right fc-state-disabled"
													unselectable="on">today</span><span class="fc-header-space"></span><span
													class="fc-button fc-button-prev fc-state-default fc-corner-left"
													unselectable="on"><span class="fc-text-arrow">‹</span></span><span
													class="fc-button fc-button-next fc-state-default fc-corner-right"
													unselectable="on"><span class="fc-text-arrow">›</span></span></td>
											</tr>
										</tbody>
									</table>
									<div class="fc-content" style="position: relative;">
										<div class="fc-view fc-view-month fc-grid"
											style="position: relative" unselectable="on">
											<div class="fc-event-container"
												style="position: absolute; z-index: 8; top: 0; left: 0">
												<div
													class="fc-event fc-event-hori fc-event-start fc-event-end listPhoto"
													style="position: absolute; left: 426px; width: 136px; top: 207px;">
													<div class="fc-event-inner">
														<span class="fc-event-title">사진 : 1</span>
													</div>
												</div>
												<div
													class="fc-event fc-event-hori fc-event-start fc-event-end listPhoto"
													style="position: absolute; left: 567px; width: 136px; top: 188px;">
													<div class="fc-event-inner">
														<span class="fc-event-title">사진 : 1</span>
													</div>
												</div>
												<div
													class="fc-event fc-event-hori fc-event-start fc-event-end"
													style="position: absolute; left: 567px; width: 136px; top: 248px;">
													<div class="fc-event-inner">
														<span class="fc-event-title">낙엽</span>
													</div>
												</div>
												<div
													class="fc-event fc-event-hori fc-event-start fc-event-end"
													style="position: absolute; left: 426px; width: 136px; top: 169px;">
													<div class="fc-event-inner">
														<span class="fc-event-title">개화</span>
													</div>
												</div>
												<div
													class="fc-event fc-event-hori fc-event-start fc-event-end"
													style="position: absolute; left: 426px; width: 136px; top: 188px;">
													<div class="fc-event-inner">
														<span class="fc-event-title">낙엽</span>
													</div>
												</div>
												<div
													class="fc-event fc-event-hori fc-event-start fc-event-end"
													style="position: absolute; left: 567px; width: 136px; top: 169px;">
													<div class="fc-event-inner">
														<span class="fc-event-title">낙엽</span>
													</div>
												</div>
												<div
													class="fc-event fc-event-hori fc-event-start fc-event-end"
													style="position: absolute; left: 567px; width: 136px; top: 207px;">
													<div class="fc-event-inner">
														<span class="fc-event-title">성숙 착색</span>
													</div>
												</div>
												<div
													class="fc-event fc-event-hori fc-event-start fc-event-end diary_moon"
													style="position: absolute; left: 144px; background-color: rgb(255, 255, 255); border-color: rgb(255, 255, 255); color: blue; width: 136px; top: 105px;">
													<div class="fc-event-inner">
														<span class="fc-event-title">입동 (2016년 10월 8일 )</span>
													</div>
												</div>
												<div
													class="fc-event fc-event-hori fc-event-start fc-event-end diary_moon"
													style="position: absolute; left: 285px; background-color: rgb(255, 255, 255); border-color: rgb(255, 255, 255); color: blue; width: 136px; top: 248px;">
													<div class="fc-event-inner">
														<span class="fc-event-title">소설 (2016년 10월 23일 )</span>
													</div>
												</div>
												<div
													class="fc-event fc-event-hori fc-event-start fc-event-end diary_moon"
													style="position: absolute; left: 426px; background-color: rgb(255, 255, 255); border-color: rgb(255, 255, 255); color: blue; width: 136px; top: 376px;">
													<div class="fc-event-inner">
														<span class="fc-event-title">대설 (2016년 11월 9일 )</span>
													</div>
												</div>
											</div>
											<table class="fc-border-separate" style="width: 100%"
												cellspacing="0">
												<thead>
													<tr class="fc-first fc-last">
														<th class="fc-day-header fc-sun fc-widget-header fc-first"
															style="width: 140px;">일</th>
														<th class="fc-day-header fc-mon fc-widget-header"
															style="width: 140px;">월</th>
														<th class="fc-day-header fc-tue fc-widget-header"
															style="width: 140px;">화</th>
														<th class="fc-day-header fc-wed fc-widget-header"
															style="width: 140px;">수</th>
														<th class="fc-day-header fc-thu fc-widget-header"
															style="width: 140px;">목</th>
														<th class="fc-day-header fc-fri fc-widget-header"
															style="width: 140px;">금</th>
														<th class="fc-day-header fc-sat fc-widget-header fc-last">토</th>
													</tr>
												</thead>
												<tbody>
													<tr class="fc-week fc-first">
														<td
															class="fc-day fc-sun fc-widget-content fc-other-month fc-past fc-first"
															data-date="2016-10-30"><div
																style="min-height: 64px;">
																<div class="fc-day-number">30</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-mon fc-widget-content fc-other-month fc-past"
															data-date="2016-10-31"><div>
																<div class="fc-day-number">31</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-tue fc-widget-content fc-past"
															data-date="2016-11-01"><div>
																<div class="fc-day-number">1</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-wed fc-widget-content fc-past"
															data-date="2016-11-02"><div>
																<div class="fc-day-number">2</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-thu fc-widget-content fc-past"
															data-date="2016-11-03"><div>
																<div class="fc-day-number">3</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-fri fc-widget-content fc-past"
															data-date="2016-11-04"><div>
																<div class="fc-day-number">4</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-sat fc-widget-content fc-past fc-last"
															data-date="2016-11-05"><div>
																<div class="fc-day-number">5</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
													</tr>
													<tr class="fc-week">
														<td
															class="fc-day fc-sun fc-widget-content fc-past fc-first"
															data-date="2016-11-06"><div
																style="min-height: 63px;">
																<div class="fc-day-number">6</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-mon fc-widget-content fc-past"
															data-date="2016-11-07"><div>
																<div class="fc-day-number">7</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-tue fc-widget-content fc-past"
															data-date="2016-11-08"><div>
																<div class="fc-day-number">8</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-wed fc-widget-content fc-past"
															data-date="2016-11-09"><div>
																<div class="fc-day-number">9</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-thu fc-widget-content fc-past"
															data-date="2016-11-10"><div>
																<div class="fc-day-number">10</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-fri fc-widget-content fc-past"
															data-date="2016-11-11"><div>
																<div class="fc-day-number">11</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-sat fc-widget-content fc-past fc-last"
															data-date="2016-11-12"><div>
																<div class="fc-day-number">12</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
													</tr>
													<tr class="fc-week">
														<td
															class="fc-day fc-sun fc-widget-content fc-past fc-first"
															data-date="2016-11-13"><div
																style="min-height: 63px;">
																<div class="fc-day-number">13</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 57px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-mon fc-widget-content fc-past"
															data-date="2016-11-14"><div>
																<div class="fc-day-number">14</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 57px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-tue fc-widget-content fc-past"
															data-date="2016-11-15"><div>
																<div class="fc-day-number">15</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 57px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-wed fc-widget-content fc-past"
															data-date="2016-11-16"><div>
																<div class="fc-day-number">16</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 57px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-thu fc-widget-content fc-past"
															data-date="2016-11-17"><div>
																<div class="fc-day-number">17</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 57px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-fri fc-widget-content fc-past"
															data-date="2016-11-18"><div>
																<div class="fc-day-number">18</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 57px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-sat fc-widget-content fc-past fc-last"
															data-date="2016-11-19"><div>
																<div class="fc-day-number">19</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 57px;">&nbsp;</div>
																</div>
															</div></td>
													</tr>
													<tr class="fc-week">
														<td
															class="fc-day fc-sun fc-widget-content fc-past fc-first"
															data-date="2016-11-20"><div
																style="min-height: 63px;">
																<div class="fc-day-number">20</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 29px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-mon fc-widget-content fc-past"
															data-date="2016-11-21"><div>
																<div class="fc-day-number">21</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 29px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-tue fc-widget-content fc-past"
															data-date="2016-11-22"><div>
																<div class="fc-day-number">22</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 29px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-wed fc-widget-content fc-past"
															data-date="2016-11-23"><div>
																<div class="fc-day-number">23</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 29px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-thu fc-widget-content fc-today fc-state-highlight"
															data-date="2016-11-24"><div>
																<div class="fc-day-number">24</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 29px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-fri fc-widget-content fc-future"
															data-date="2016-11-25"><div>
																<div class="fc-day-number">25</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 29px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-sat fc-widget-content fc-future fc-last"
															data-date="2016-11-26"><div>
																<div class="fc-day-number">26</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 29px;">&nbsp;</div>
																</div>
															</div></td>
													</tr>
													<tr class="fc-week">
														<td
															class="fc-day fc-sun fc-widget-content fc-future fc-first"
															data-date="2016-11-27"><div
																style="min-height: 63px;">
																<div class="fc-day-number">27</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-mon fc-widget-content fc-future"
															data-date="2016-11-28"><div>
																<div class="fc-day-number">28</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-tue fc-widget-content fc-future"
															data-date="2016-11-29"><div>
																<div class="fc-day-number">29</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
														<td class="fc-day fc-wed fc-widget-content fc-future"
															data-date="2016-11-30"><div>
																<div class="fc-day-number">30</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-thu fc-widget-content fc-other-month fc-future"
															data-date="2016-12-01"><div>
																<div class="fc-day-number">1</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-fri fc-widget-content fc-other-month fc-future"
															data-date="2016-12-02"><div>
																<div class="fc-day-number">2</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-sat fc-widget-content fc-other-month fc-future fc-last"
															data-date="2016-12-03"><div>
																<div class="fc-day-number">3</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 0px;">&nbsp;</div>
																</div>
															</div></td>
													</tr>
													<tr class="fc-week fc-last">
														<td
															class="fc-day fc-sun fc-widget-content fc-other-month fc-future fc-first"
															data-date="2016-12-04"><div
																style="min-height: 66px;">
																<div class="fc-day-number">4</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-mon fc-widget-content fc-other-month fc-future"
															data-date="2016-12-05"><div>
																<div class="fc-day-number">5</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-tue fc-widget-content fc-other-month fc-future"
															data-date="2016-12-06"><div>
																<div class="fc-day-number">6</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-wed fc-widget-content fc-other-month fc-future"
															data-date="2016-12-07"><div>
																<div class="fc-day-number">7</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-thu fc-widget-content fc-other-month fc-future"
															data-date="2016-12-08"><div>
																<div class="fc-day-number">8</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-fri fc-widget-content fc-other-month fc-future"
															data-date="2016-12-09"><div>
																<div class="fc-day-number">9</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
														<td
															class="fc-day fc-sat fc-widget-content fc-other-month fc-future fc-last"
															data-date="2016-12-10"><div>
																<div class="fc-day-number">10</div>
																<div class="fc-day-content">
																	<div style="position: relative; height: 15px;">&nbsp;</div>
																</div>
															</div></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<form action="/rest/data_diary/diary" id="frm_list"
									name="frm_list" method="post">
									<input type="hidden" name="usr_email"
										value="cbnmzxcvb@gmail.com"> <input type="hidden"
										name="now_date_s" id="now_date_s_select" value="2016-11-01">
									<input type="hidden" name="now_date_e" id="now_date_e_select"
										value="2016-12-01"> <input type="hidden" id="id"
										name="id" value="worklist"> <input type="hidden"
										id="method" name="method" value="read_List"> <input
										type="hidden" id="pagenum" name="pagenum" value="1"> <input
										type="hidden" id="numrow" name="numrow" value="10">
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="footer">
			<div class="copyright">
				<!-- 자동 로그아웃 스크립트  -->
				<script src="/js/jquery/jquery.ui.dialog.js"></script>
				<script type="text/javascript">
					require(
							[ "dojo/ready" ],
							function(ready) {
								ready(function() {
									var islogined = eval('true');
									//console.log(islogined);
									if (islogined) {
										$("#dlg_timer")
												.dialog(
														{
															autoOpen : false,
															modal : true,
															//height: 200,    // 창의 높이 설정. 기본 auto.
															width : 400, // 창의 넓이 설정. 기본 auto.
															closeOnEscape : false,
															open : function(
																	event, ui) {
																$(
																		".ui-dialog-titlebar-close",
																		$(this)
																				.parent())
																		.hide();
																$(
																		".ui-dialog-title",
																		$(this)
																				.parent())
																		.css(
																				"width",
																				"100%");
															},
															buttons : {
																"로그인 연장하기" : function() {
																	refreshTimer();
																	$(this)
																			.dialog(
																					"close");
																},
																"지금 로그아웃" : function() {
																	logoutUser("로그아웃 되었습니다.");
																	$(this)
																			.dialog(
																					"close");
																},
															}
														});
										Lpad = function(str, len) {
											str = str + "";
											while (str.length < len) {
												str = "0" + str;
											}
											return str;
										};
										// 사용자로부터 페이지이동 및 서버호출이 없을경우의 자동로그아웃까지의 대기시간, 분단위 (세션 유지 시간)			
										var iMinute = eval('10800');
										//자동로그아웃 처리 몇초전에 경고를 보여줄지 설정하는 부분, 초단위 
										var noticeSecond = 60;
										var iSecond = (iMinute / 60) * 60;
										var timerchecker = null;

										initTimer = function() {
											//사용자부터 마우스 또는 키보드 이벤트가 발생했을경우 자동로그아웃까지의 대기시간을 다시 초기화 
											rMinute = parseInt((iSecond - 1) / 60);
											rSecond = (iSecond - 1) % 60;
											if (iSecond > 0) {
												//지정한 시간동안 페이지이동 및 서버호출이 발생되지 않았을 경우 
												if (iSecond <= noticeSecond) {
													$("#dlg_timer").dialog(
															"open"); // 자동로그아웃 경고레이어 활성 
												}
												//자동로그아웃 경고레이어에 경고문+남은 시간 보여주는 부분 
												$("#dlg_timer")
														.html(
																"<font family=tahoma style='font-size:14px;font-weight:bold;'>자동 로그아웃 남은시간</font><br><font color=red style='font-size:20px;font-weight:bold;line-height:2.2em;'>"
																		+ Lpad(
																				rMinute,
																				2)
																		+ ":"
																		+ Lpad(
																				rSecond,
																				2));
												iSecond--;
												timerchecker = setTimeout(
														"initTimer()", 1000); // 1초 간격으로 체크 					
											} else {
												logoutUser("장시간 미사용으로 자동 로그아웃 처리되었습니다.");
											}
										};
										function refreshTimer() {
											$
													.get(
															'/rest/process/extension',
															function(data) {
																if (data.message == "success") {
																	// data.ext_time = web.xml에 설정되어 있는 세션 유지시간
																	iSecond = (data.ext_time / 60) * 60;
																	initTimer;
																	$(
																			"#dlg_timer")
																			.dialog(
																					"close"); // 자동로그아웃 경고레이어 해제 						
																} else {
																	logoutUser("장시간 미사용으로 자동 로그아웃 처리되었습니다.");
																}
															}, "json");
										}
										function logoutUser(msg) {
											clearTimeout(timerchecker);
											$.get('/rest/process/logout',
													function() {
													}); // 로그아웃 처리
											$("#dlg_timer").dialog("close");
											alert(msg);
											location.href = "/rest/login"; // 로그아웃 처리 페이지 
										}
										onload = initTimer; //현재 페이지 대기시간 
									}
								});
							});
				</script>

				<span style="line-height: 18px;"> | 시스템이용·오류 문의 :
					044-868-2058 | 사용방법 문의 : 044-861-8755 | 이메일 : rokjin@epis.or.kr |<br>
					COPYRIGHT© 2013 농림수산식품교육문화정보원 정보화사업본부 정보기획실. ALL RIGHTS RESERVED.<br>
					<span style="color: red;" id="footer_last">※ 농업경영장부는 익스플로러
						8이상, 크롬 브라우저에 최적화 되어 있습니다.</span>
				</span>


			</div>
		</div>
	</div>










	<form action="/rest/data/get" id="frm_delete" name="frm_delete"
		method="post">
		<input type="hidden" id="seq_delete" name="seq" value=""> <input
			type="hidden" name="insert_id" value="delete_work">
	</form>














	<!-- <div id="dlg_kma_past" title="날씨정보" style="display: none;">
		<span style="color: blue; font-size: 12px;">기상청에서 과거자료를 검색 중 입니다.</br> 잠시만 기다려 주십시오.</span>
	</div> -->

	<!-- 가이드뷰 레이어 -->

	<div id="layer1" onclick="PopLayer.Close();">영농일지 작성 대상 품목을 추가 또는
		변경 할 수 있습니다.</div>
	<div id="layer2" onclick="PopLayer.Close();">기상청에서 자동으로 불러올 날씨정보의
		지역을 설정합니다.</div>
	<div id="layer3" onclick="PopLayer.Close();">기상청이 제공하는 날씨정보를 제공하며
		지역별 실제 날씨와 다를 수 있습니다.</div>
	<div id="layer4" onclick="PopLayer.Close();">
		영농일지 관련 사진을 등록·확인 하실 수 있습니다.<br>(jpg,jpeg,gif,png,bmp,tif 확장자만
		가능)
	</div>


	<div id="ui-datepicker-div"
		class="ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
		<div
			class="ui-datepicker-header ui-widget-header ui-helper-clearfix ui-corner-all">
			<a class="ui-datepicker-prev ui-corner-all" data-handler="prev"
				data-event="click" title="이전달"><span
				class="ui-icon ui-icon-circle-triangle-w">이전달</span></a><a
				class="ui-datepicker-next ui-corner-all" data-handler="next"
				data-event="click" title="다음달"><span
				class="ui-icon ui-icon-circle-triangle-e">다음달</span></a>
			<div class="ui-datepicker-title">
				<select class="ui-datepicker-year" data-handler="selectYear"
					data-event="change"><option value="2006">2006</option>
					<option value="2007">2007</option>
					<option value="2008">2008</option>
					<option value="2009">2009</option>
					<option value="2010">2010</option>
					<option value="2011">2011</option>
					<option value="2012">2012</option>
					<option value="2013">2013</option>
					<option value="2014">2014</option>
					<option value="2015">2015</option>
					<option value="2016" selected="selected">2016</option>
					<option value="2017">2017</option>
					<option value="2018">2018</option>
					<option value="2019">2019</option>
					<option value="2020">2020</option>
					<option value="2021">2021</option>
					<option value="2022">2022</option>
					<option value="2023">2023</option>
					<option value="2024">2024</option>
					<option value="2025">2025</option>
					<option value="2026">2026</option></select>년<select
					class="ui-datepicker-month" data-handler="selectMonth"
					data-event="change"><option value="0">1월</option>
					<option value="1">2월</option>
					<option value="2">3월</option>
					<option value="3">4월</option>
					<option value="4">5월</option>
					<option value="5">6월</option>
					<option value="6">7월</option>
					<option value="7">8월</option>
					<option value="8">9월</option>
					<option value="9">10월</option>
					<option value="10" selected="selected">11월</option>
					<option value="11">12월</option></select>
			</div>
		</div>
		<table class="ui-datepicker-calendar">
			<thead>
				<tr>
					<th class="ui-datepicker-week-end"><span title="일">일</span></th>
					<th><span title="월">월</span></th>
					<th><span title="화">화</span></th>
					<th><span title="수">수</span></th>
					<th><span title="목">목</span></th>
					<th><span title="금">금</span></th>
					<th class="ui-datepicker-week-end"><span title="토">토</span></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td
						class=" ui-datepicker-week-end ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
					<td
						class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">1</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">2</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">3</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">4</a></td>
					<td class=" ui-datepicker-week-end " data-handler="selectDay"
						data-event="click" data-month="10" data-year="2016"><a
						class="ui-state-default" href="#">5</a></td>
				</tr>
				<tr>
					<td class=" ui-datepicker-week-end " data-handler="selectDay"
						data-event="click" data-month="10" data-year="2016"><a
						class="ui-state-default" href="#">6</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">7</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">8</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">9</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">10</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">11</a></td>
					<td class=" ui-datepicker-week-end " data-handler="selectDay"
						data-event="click" data-month="10" data-year="2016"><a
						class="ui-state-default" href="#">12</a></td>
				</tr>
				<tr>
					<td class=" ui-datepicker-week-end " data-handler="selectDay"
						data-event="click" data-month="10" data-year="2016"><a
						class="ui-state-default" href="#">13</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">14</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">15</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">16</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">17</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">18</a></td>
					<td class=" ui-datepicker-week-end " data-handler="selectDay"
						data-event="click" data-month="10" data-year="2016"><a
						class="ui-state-default" href="#">19</a></td>
				</tr>
				<tr>
					<td class=" ui-datepicker-week-end " data-handler="selectDay"
						data-event="click" data-month="10" data-year="2016"><a
						class="ui-state-default" href="#">20</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">21</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">22</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">23</a></td>
					<td
						class=" ui-datepicker-days-cell-over  ui-datepicker-current-day ui-datepicker-today"
						data-handler="selectDay" data-event="click" data-month="10"
						data-year="2016"><a
						class="ui-state-default ui-state-highlight ui-state-active ui-state-hover"
						href="#">24</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">25</a></td>
					<td class=" ui-datepicker-week-end " data-handler="selectDay"
						data-event="click" data-month="10" data-year="2016"><a
						class="ui-state-default" href="#">26</a></td>
				</tr>
				<tr>
					<td class=" ui-datepicker-week-end " data-handler="selectDay"
						data-event="click" data-month="10" data-year="2016"><a
						class="ui-state-default" href="#">27</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">28</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">29</a></td>
					<td class=" " data-handler="selectDay" data-event="click"
						data-month="10" data-year="2016"><a class="ui-state-default"
						href="#">30</a></td>
					<td
						class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
					<td
						class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
					<td
						class=" ui-datepicker-week-end ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_photo"
		aria-labelledby="ui-id-1" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-1" class="ui-dialog-title">작업사진관리</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_photo" class="ui-dialog-content ui-widget-content">
			<div id="list_area">
				<div id="list_box"
					style="min-height: 600px !important; width: 610px; overflow: auto; overflow-y: hidden; overflow-x: hidden;">
					<div id="condition_area">
						<form id="frm_prd_photo" name="frm_prd_photo" method="post"
							enctype="multipart/form-data"
							action="https://villagebook.farmware.org/uploadfile"
							target="uploadIFrame">
							<div class="acc" style="height: 60px; padding-top: 10px;">
								<div id="filepos"
									style="width: 340px; position: relative; float: left; padding-top: 16px;">
									<input name="photpfile" id="photpfile" type="file"
										accept="image/jpeg,image/gif,image/png,image/jpg,image/bmp,image/tif">
									<input id="photpfile" name="photpfile" type="file"
										accept="image/jpeg,image/gif,image/png,image/jpg,image/bmp,image/tif">
								</div>
								<div style="position: relative; float: left; width: 150px;">
									<input type="submit" name="action"
										class="rc-button rc-button-submit" value="사진등록">
								</div>
								<input type="hidden" name="usr_email"
									value="cbnmzxcvb@gmail.com"> <input type="hidden"
									name="now_date" value="2016-11-24">
							</div>
							<iframe id="uploadIFrame" name="uploadIFrame"
								style="display: none; visibility: hidden"
								onload="return iframeonload();"></iframe>
						</form>
						<form action="/rest/data/get" id="frm_list_photo"
							name="frm_list_photo" method="post">
							<input type="hidden" name="usr_email" value="cbnmzxcvb@gmail.com">
							<input type="hidden" name="id" value="work_usr_photo"> <input
								type="hidden" name="method" value="read_List"> <input
								type="hidden" name="pagenum" value="1"> <input
								type="hidden" name="numrow" value="4"> <input
								type="hidden" name="now_date" value="2016-11-24">
						</form>
						<div class="board_area" style="width: 600px !important;">
							<div id="board_box_photo">
								<div class="hitbox">
									총 :<span id="news_totalcnt_photo" class="ft_color">0 건</span>,
									현재페이지 :<span id="news_curpage_photo" class="ft_color">0</span>
								</div>
								<div style="clear: both;"></div>
								<table class="boardList"
									style="width: 600px !important; table-layout: fixed;"
									summary="게시판목록">
									<thead>
										<tr>
											<th style="width: 100px;">작업일자</th>
											<th style="width: 140px;">사진</th>
											<th style="width: 300px;">파일명</th>
											<th style="width: 60px;">관리</th>
										</tr>
									</thead>
									<tbody id="sub_board_news_photo"></tbody>
								</table>
								<label id="notfind_photo">조건에 해당하는 자료가 없음</label>
							</div>
							<div class="paging" id="news_view_paging_photo"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">닫기</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_photo_view"
		aria-labelledby="ui-id-2" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-2" class="ui-dialog-title">작업사진보기</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_photo_view" class="ui-dialog-content ui-widget-content">
			<div id="list_area">
				<div id="list_box"
					style="min-height: 500px !important; width: 520px; overflow: auto;">
					<div class="acc" style="width: 520px; height: 20px;">
						<div style="position: relative; float: left; margin-bottom: 20px;">
							<span id="photo_view_title"></span>
						</div>
						<div style="clear: both;"></div>
						<div style="position: relative; float: left;">
							<img id="photo_view_img" style="width: 500px;">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">닫기</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_photo_edit"
		aria-labelledby="ui-id-3" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-3" class="ui-dialog-title">작업사진 수정</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_photo_edit" class="ui-dialog-content ui-widget-content">
			<div id="list_area">
				<div id="list_box"
					style="min-height: 560px !important; width: 520px; overflow: auto;">
					<form enctype="multipart/form-data" id="frm_prd_photo_edit"
						name="frm_prd_photo_edit" method="post"
						action="https://villagebook.farmware.org/uploadfile"
						target="uploadIFrame">
						<div class="acc"
							style="height: 60px; padding-top: 10px; width: 520px;">
							<div
								style="width: 340px; position: relative; float: left; padding-top: 16px;">

							</div>
							<div style="position: relative; float: left; width: 150px;">
								<input type="submit" name="action"
									class="rc-button rc-button-submit" value="사진수정">
							</div>
							<div
								style="position: relative; float: left; width: 150px; margin-bottom: 20px; margin-top: 20px;">
								<span id="photo_view_title_edit"></span>
							</div>
							<div style="clear: both;"></div>
							<div style="position: relative; float: left; width: 150px;">
								<img id="photo_view_img_edit" style="width: 500px;">
							</div>
							<input type="hidden" name="usr_email" value="cbnmzxcvb@gmail.com">
							<input type="hidden" name="seq" id="photo_edit_seq" value="">
						</div>
					</form>
					<form action="/rest/data/get" id="frm_prd_photo_delete"
						name="frm_prd_photo_delete" method="post">
						<input type="hidden" name="seq" value=""> <input
							type="hidden" name="insert_id" value="delete_work_photo">
					</form>
				</div>
			</div>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">닫기</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_edit"
		aria-labelledby="ui-id-4" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-4" class="ui-dialog-title">작업내용수정</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_edit" class="ui-dialog-content ui-widget-content">
			<div id="where_area">
				<div id="where_box">
					<div class="acc_diary" style="width: 1004px;">
						<form enctype="multipart/form-data" action="/rest/data/get"
							id="frm_prd_edit" name="frm_prd_edit" method="post">
							<div class="top">
								<div
									style="position: relative; float: left; width: 200px; background: url(/images/diary/date_bak.gif); font-size: 14px; font-weight: bold; margin-top: 0px; height: 35px; padding-top: 10px;">
									<input type="text" name="now_date" id="now_date_edit" value=""
										style="width: 126px; font-size: 16px !important;"
										class="hasDatepicker"><img
										class="ui-datepicker-trigger" src="/images/icon/calendar.gif"
										alt="..." title="...">
								</div>
								<div style="padding-top: 12px;">
									<div class="label" style="width: 30px;">
										<span>날씨</span>
									</div>
									<div class="value" style="width: 80px;">
										<select id="wfKor_edit" name="wfKor" class="select_value"
											data-placeholder="선택" style="width: 78px; display: none;">
											<option value="1">맑음</option>
											<option value="2">구름 조금</option>
											<option value="3">구름 많음</option>
											<option value="4">흐림</option>
											<option value="5">비</option>
											<option value="6">눈/비</option>
											<option value="7">눈</option>
										</select>
										<div
											class="chosen-container chosen-container-single chosen-container-single-nosearch"
											style="width: 78px;" title="" id="wfKor_edit_chosen">
											<a class="chosen-single" tabindex="-1"><span>맑음</span>
											<div>
													<b></b>
												</div></a>
											<div class="chosen-drop">
												<div class="chosen-search">
													<input type="text" autocomplete="off" readonly="">
												</div>
												<ul class="chosen-results"></ul>
											</div>
										</div>
									</div>
									<div class="label var" style="width: 80px;">
										<span>현재기온(℃)</span>
									</div>
									<div class="value var">
										<input name="current_temp" id="current_temp_edit"
											style="width: 36px;">
									</div>
									<div class="label" style="width: 80px;">
										<span>최저기온(℃)</span>
									</div>
									<div class="value">
										<input name="low_temp" id="low_temp_edit" style="width: 36px;">
									</div>
									<div class="label" style="width: 80px;">
										<span>최고기온(℃)</span>
									</div>
									<div class="value">
										<input name="high_temp" id="high_temp_edit"
											style="width: 36px;">
									</div>
									<div class="label var" style="width: 80px;">
										<span>습도(%)</span>
									</div>
									<div class="value var">
										<input name="reh" id="reh_edit" style="width: 36px;">
									</div>
									<div class="label var" style="width: 80px;">
										<span>강수확률(%)</span>
									</div>
									<div class="value var">
										<input name="pop" id="pop_edit" style="width: 36px;">
									</div>
									<div class="label" style="width: 100px;">
										<span>강수량(mm)</span>
									</div>
									<div class="value">
										<input name="r12" id="r12_edit" style="width: 36px;">
									</div>
									<div class="label" style="width: 100px;">
										<span>적설량(cm)</span>
									</div>
									<div class="value">
										<input name="s12" id="s12_edit" style="width: 36px;">
									</div>
									<div class="label" style="width: 150px; text-align: center;">
										<span id="kma_load_edit"></span>
									</div>
								</div>
							</div>
							<div style="clear: both;"></div>
							<div class="title">
								<span>영 농 일 지 작 성</span>
							</div>
							<div class="leftff">
								<div class="sub_title">일반정보</div>
								<div style="height: 50px;" class="outline">
									<div class="label" style="width: 80px;">
										<span>품목선택</span>
									</div>
									<div class="value" style="text-align: left;">
										<select class="select_value" data-placeholder="선택"
											id="prd_seq_edit" name="prd_seq"
											style="width: 326px; display: none;" onchange=""></select>
										<div
											class="chosen-container chosen-container-single chosen-container-single-nosearch"
											style="width: 326px;" title="" id="prd_seq_edit_chosen">
											<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
											<div>
													<b></b>
												</div></a>
											<div class="chosen-drop">
												<div class="chosen-search">
													<input type="text" autocomplete="off" readonly="">
												</div>
												<ul class="chosen-results"></ul>
											</div>
										</div>
									</div>
									<div style="clear: both;"></div>
									<div class="label" style="width: 80px;">
										<span>영농과정</span>
									</div>
									<div class="value" style="text-align: left; padding-top: 3px;">
										<select class="select_value" data-placeholder="선택"
											id="step_seq_edit" name="step_seq"
											style="width: 326px; display: none;" onchange=""></select>
										<div
											class="chosen-container chosen-container-single chosen-container-single-nosearch"
											style="width: 326px;" title="" id="step_seq_edit_chosen">
											<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
											<div>
													<b></b>
												</div></a>
											<div class="chosen-drop">
												<div class="chosen-search">
													<input type="text" autocomplete="off" readonly="">
												</div>
												<ul class="chosen-results"></ul>
											</div>
										</div>
									</div>
								</div>
								<div style="height: 117px;" class="outline">
									<div class="label" style="width: 80px;">
										<span>작업명</span>
									</div>
									<div class="value" style="text-align: left;">
										<input id="work_title_edit" name="work_title"
											style="width: 322px;">
									</div>
									<div style="clear: both;"></div>
									<div class="label" style="width: 80px;">
										<span>작업내용</span>
									</div>
									<div class="label" style="width: 400px; height: 80px;">
										<textarea name="work_des" id="work_des_edit" rows="19"
											cols="88" placeholder="작업내용을 입력하세요."></textarea>
									</div>
								</div>
								<div style="height: 30px;" class="outline">
									<div class="label" style="width: 80px;">
										<span>작업사진</span>
									</div>
									<div class="value" style="text-align: left; padding-top: 6px;">
										<span id="photo_count_edit"></span>
									</div>
									<div
										style="position: relative; float: right; padding-top: 6px;">
										<button id="btn_photo_add_open_edit" type="button"
											class="small-button"
											style="font-size: 12px; width: 80px !important;">사진관리</button>
									</div>
								</div>
							</div>
							<div class="right">
								<div class="sub_title">상세정보</div>
								<div id="accordion_edit"
									class="ui-tabs ui-widget ui-widget-content ui-corner-all">
									<ul
										class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all"
										role="tablist">
										<li
											class="ui-state-default ui-corner-top ui-tabs-active ui-state-active"
											role="tab" tabindex="0" aria-controls="tabs-11"
											aria-labelledby="ui-id-17" aria-selected="true"><a
											href="#tabs-11" class="ui-tabs-anchor" role="presentation"
											tabindex="-1" id="ui-id-17">농약사용량</a></li>
										<li class="ui-state-default ui-corner-top" role="tab"
											tabindex="-1" aria-controls="tabs-21"
											aria-labelledby="ui-id-18" aria-selected="false"><a
											href="#tabs-21" class="ui-tabs-anchor" role="presentation"
											tabindex="-1" id="ui-id-18">비료사용량</a></li>
										<li class="ui-state-default ui-corner-top" role="tab"
											tabindex="-1" aria-controls="tabs-31"
											aria-labelledby="ui-id-19" aria-selected="false"><a
											href="#tabs-31" class="ui-tabs-anchor" role="presentation"
											tabindex="-1" id="ui-id-19">인력사용량</a></li>
										<li class="ui-state-default ui-corner-top" role="tab"
											tabindex="-1" aria-controls="tabs-41"
											aria-labelledby="ui-id-20" aria-selected="false"><a
											href="#tabs-41" class="ui-tabs-anchor" role="presentation"
											tabindex="-1" id="ui-id-20">장비사용량</a></li>
									</ul>
									<div id="tabs-11" aria-labelledby="ui-id-17"
										class="ui-tabs-panel ui-widget-content ui-corner-bottom"
										role="tabpanel" aria-expanded="true" aria-hidden="false">
										<div class="label" style="width: 80px;">
											<span>농약종류</span>
										</div>
										<div class="value"
											style="float: left !important; text-align: left;">
											<select id="pest_knd_cde_edit" name="pest_knd_cde"
												class="select_value" data-placeholder="선택"
												style="width: 242px; display: none;" onchange=""></select>
											<div
												class="chosen-container chosen-container-single chosen-container-single-nosearch"
												style="width: 242px;" title="" id="pest_knd_cde_edit_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off" readonly="">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="clear: both;"></div>
										<div class="label" style="width: 80px;">
											<span>사용량</span>
										</div>
										<div class="value"
											style="float: left !important; text-align: left;">
											<input name="pest_amt" id="pest_amt_edit"
												style="width: 58px;">
										</div>
										<div class="label" style="width: 80px;">
											<span>단위</span>
										</div>
										<div class="value"
											style="width: 100px; float: left !important; text-align: left;">
											<select id="pest_unt_cde_edit" name="pest_unt_cde"
												class="select_value" data-placeholder="선택"
												style="width: 100px; display: none;" onchange=""><option
													value=""></option>
												<option value="10">상자(BOX)</option>
												<option value="11">낱개(EA)</option>
												<option value="12">통</option>
												<option value="13">포</option>
												<option value="14">망</option>
												<option value="15">그리티(C/T)</option>
												<option value="16">콘티</option>
												<option value="17">m²</option>
												<option value="18">kg</option>
												<option value="19">병(통)</option>
												<option value="20">병</option>
												<option value="21">봉지</option>
												<option value="22">포대</option>
												<option value="23">실린</option>
												<option value="24">봉</option>
												<option value="25">약통(캔)</option>
												<option value="26">봉지(통)</option>
												<option value="27">g</option>
												<option value="28">ml</option>
												<option value="29">L</option>
												<option value="99">기타</option></select>
											<div class="chosen-container chosen-container-single"
												style="width: 100px;" title="" id="pest_unt_cde_edit_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="position: relative; float: right;">
											<button id="btn_pest_knd_add_edit" type="button"
												class="small-button " style="width: 40px !important;">추가</button>
										</div>
										<div style="clear: both;"></div>
									</div>
									<div id="tabs-21" aria-labelledby="ui-id-18"
										class="ui-tabs-panel ui-widget-content ui-corner-bottom"
										role="tabpanel" aria-expanded="false" aria-hidden="true"
										style="display: none;">
										<div class="label" style="width: 80px;">
											<span>비료종류</span>
										</div>
										<div class="value" style="float: left;">
											<select id="fer_knd_cde_edit" name="fer_knd_cde"
												class="select_value" data-placeholder="선택"
												style="width: 242px; display: none;" onchange=""></select>
											<div
												class="chosen-container chosen-container-single chosen-container-single-nosearch"
												style="width: 242px;" title="" id="fer_knd_cde_edit_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off" readonly="">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="clear: both;"></div>
										<div class="label" style="width: 80px;">
											<span>사용량</span>
										</div>
										<div class="value"
											style="float: left !important; text-align: left;; float: left;">
											<input name="fer_amt" id="fer_amt_edit" style="width: 58px;">
										</div>
										<div class="label" style="width: 80px;">
											<span>단위</span>
										</div>
										<div class="value" style="width: 100px;">
											<select id="fer_unt_cde_edit" name="fer_unt_cde"
												class="select_value" data-placeholder="선택"
												style="width: 100px; display: none;" onchange=""><option
													value=""></option>
												<option value="10">상자(BOX)</option>
												<option value="11">낱개(EA)</option>
												<option value="12">통</option>
												<option value="13">포</option>
												<option value="14">망</option>
												<option value="15">그리티(C/T)</option>
												<option value="16">콘티</option>
												<option value="17">m²</option>
												<option value="18">kg</option>
												<option value="19">병(통)</option>
												<option value="20">병</option>
												<option value="21">봉지</option>
												<option value="22">포대</option>
												<option value="23">실린</option>
												<option value="24">봉</option>
												<option value="25">약통(캔)</option>
												<option value="26">봉지(통)</option>
												<option value="27">g</option>
												<option value="28">ml</option>
												<option value="29">L</option>
												<option value="99">기타</option></select>
											<div class="chosen-container chosen-container-single"
												style="width: 100px;" title="" id="fer_unt_cde_edit_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="position: relative; float: right;">
											<button id="btn_fer_knd_add_edit" type="button"
												class="small-button " style="width: 40px !important;">추가</button>
										</div>
										<div style="clear: both;"></div>
									</div>
									<div id="tabs-31" aria-labelledby="ui-id-19"
										class="ui-tabs-panel ui-widget-content ui-corner-bottom"
										role="tabpanel" aria-expanded="false" aria-hidden="true"
										style="display: none;">
										<div class="label" style="width: 80px;">
											<span>인력종류</span>
										</div>
										<div class="value" style="float: left;">
											<select id="man_knd_cde_edit" name="man_knd_cde"
												class="select_value" data-placeholder="선택"
												style="width: 242px; display: none;" onchange=""></select>
											<div
												class="chosen-container chosen-container-single chosen-container-single-nosearch"
												style="width: 242px;" title="" id="man_knd_cde_edit_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off" readonly="">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="clear: both;"></div>
										<div class="label" style="width: 80px;">
											<span>작업시간</span>
										</div>
										<div class="value"
											style="float: left !important; text-align: left;; float: left;">
											<input name="man_amt" id="man_amt_edit" style="width: 58px;">
										</div>
										<div class="label" style="width: 80px;">
											<span>단위</span>
										</div>
										<div class="value" style="width: 100px;">
											<select id="man_unt_cde_edit" name="man_unt_cde"
												class="select_value" data-placeholder="선택"
												style="width: 100px; display: none;" onchange=""><option
													value=""></option>
												<option value="01">시간</option>
												<option value="02">일</option>
												<option value="03">분</option></select>
											<div
												class="chosen-container chosen-container-single chosen-container-single-nosearch"
												style="width: 100px;" title="" id="man_unt_cde_edit_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off" readonly="">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="position: relative; float: right;">
											<button id="btn_man_knd_add_edit" type="button"
												class="small-button " style="width: 40px !important;">추가</button>
										</div>
										<div style="clear: both;"></div>
									</div>
									<div id="tabs-41" aria-labelledby="ui-id-20"
										class="ui-tabs-panel ui-widget-content ui-corner-bottom"
										role="tabpanel" aria-expanded="false" aria-hidden="true"
										style="display: none;">
										<div class="label" style="width: 80px;">
											<span>장비종류</span>
										</div>
										<div class="value" style="float: left;">
											<select id="dev_knd_cde_edit" name="dev_knd_cde"
												class="select_value" data-placeholder="선택"
												style="width: 242px; display: none;" onchange=""></select>
											<div
												class="chosen-container chosen-container-single chosen-container-single-nosearch"
												style="width: 242px;" title="" id="dev_knd_cde_edit_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off" readonly="">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="clear: both;"></div>
										<div class="label" style="width: 80px;">
											<span>사용기간</span>
										</div>
										<div class="value" style="float: left;">
											<input name="dev_amt" id="dev_amt_edit" style="width: 58px;">
										</div>
										<div class="label" style="width: 80px;">
											<span>단위</span>
										</div>
										<div class="value" style="width: 100px;">
											<select id="dev_unt_cde_edit" name="dev_unt_cde"
												class="select_value" data-placeholder="선택"
												style="width: 100px; display: none;" onchange=""><option
													value=""></option>
												<option value="01">시간</option>
												<option value="02">일</option>
												<option value="03">분</option></select>
											<div
												class="chosen-container chosen-container-single chosen-container-single-nosearch"
												style="width: 100px;" title="" id="dev_unt_cde_edit_chosen">
												<a class="chosen-single chosen-default" tabindex="-1"><span>선택</span>
												<div>
														<b></b>
													</div></a>
												<div class="chosen-drop">
													<div class="chosen-search">
														<input type="text" autocomplete="off" readonly="">
													</div>
													<ul class="chosen-results"></ul>
												</div>
											</div>
										</div>
										<div style="position: relative; float: right;">
											<button id="btn_dev_knd_add_edit" type="button"
												class="small-button " style="width: 40px !important;">추가</button>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
								<div style="clear: both;"></div>
								<div class="detail">
									<table id="board_add_pest_edit" class="boardList_diary_simple"
										style="width: 100% !important; color: #ccc !important;"
										summary="게시판목록">
										<caption>게시판목록</caption>
										<colgroup>
											<col width="100px">
											<col>
											<col width="100px">
											<col width="80px">
											<col width="50px">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">구분</th>
												<th scope="col">종류</th>
												<th scope="col">사용량</th>
												<th scope="col">단위</th>
												<th scope="col">삭제</th>
											</tr>
										</thead>
										<tbody id="sub_board_pest_edit"></tbody>
									</table>
								</div>
							</div>
							<input type="hidden" id="usr_email_edit" name="usr_email"
								value="cbnmzxcvb@gmail.com"> <input type="hidden"
								name="insert_id" value="update_work"> <input
								type="hidden" id="work_edit" name="work" value=""> <input
								type="hidden" id="seq_edit" name="seq" value=""> <input
								type="hidden" name="diary_seq" value=""> <input
								type="hidden" id="step_cde_edit" name="step_cde" value="">
						</form>
					</div>
				</div>
				<button id="btn_write_edit" type="button"
					class="rc-button rc-button-submit" style="width: 200px !important;">수정</button>
				<button id="btn_delete" type="button"
					class="rc-button rc-button-submit" style="width: 200px !important;">삭제</button>
			</div>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">닫기</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_search_title"
		aria-labelledby="ui-id-5" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-5" class="ui-dialog-title">작업명검색</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_search_title" style=""
			class="ui-dialog-content ui-widget-content">
			<div id="where_area">
				<div id="where_box"
					style="width: 380px !important; height: 120px !important;">
					<div class="info">
						<form action="/rest/data/get" id="frm_steplist_title"
							name="frm_steplist_title" method="post">
							<div class="label" style="width: 80px;">
								<span>작업명</span>
							</div>
							<div class="value">
								<input id="search_work_title_title" name="work_title"
									style="width: 134px; ime-mode: active;" value="">
							</div>
							<div class="value">
								<button id="search_btn_prd_search_title" type="button">검색</button>
							</div>
							<input type="hidden" name="id" value="worktitle"> <input
								type="hidden" name="method" value="read_List"> <input
								type="hidden" name="pagenum" value="1"> <input
								type="hidden" name="numrow" value="10"> <input
								type="hidden" name="usr_email" value="cbnmzxcvb@gmail.com">
							<input type="hidden" name="prd_seq"
								id="frm_steplist_prd_title_seq" value=""> <input
								type="hidden" name="step_seq" id="frm_steplist_step_title_seq"
								value="">
						</form>
					</div>
				</div>
			</div>

			<div id="list_area">
				<div id="list_box"
					style="height: 400px !important; width: 380px !important;">
					<div id="condition_area">
						<div id="condition_box" style="width: 380px !important;">
							<div class="board_area" style="">
								<div id="board_box3" class="board_box"
									style="width: 340px !important;">
									<div class="hitbox" style="width: 340px !important;">
										총 :<span id="news_totalcnt_search_title" class="ft_color">
											0 건</span>, 현재페이지 :<span id="news_curpage_search_title"
											class="ft_color"> 0</span>
									</div>
									<div style="clear: both;"></div>
									<table class="boardList" style="width: 370px !important;"
										summary="게시판목록">
										<caption>게시판목록</caption>
										<colgroup>
											<col>
											<col width="100px">
											<col width="100px">
											<col width="100px">
										</colgroup>
										<thead style="height: 20px !important; border: 1px solid">
											<tr>
												<th scope="col">품목</th>
												<th scope="col">영농과정</th>
												<th scope="col">작업과정</th>
												<th scope="col">작업명</th>
											</tr>
										</thead>
										<tbody id="sub_board_news_search_title"></tbody>
									</table>
								</div>
								<div class="paging" id="news_view_paging_search_title"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">닫기</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_step"
		aria-labelledby="ui-id-6" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-6" class="ui-dialog-title">사용자영농과정 신규등록</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_step" class="ui-dialog-content ui-widget-content">
			<form action="/rest/process/reg" id="frm_reg_step"
				name="frm_reg_step" method="post">
				<div
					style="width: 300px; margin: 0 auto; padding-bottom: 20px; padding-left: 20px; padding-right: 20px;">
					<div
						style="width: 300px; padding-top: 10px; padding-right: 30px; padding-bottom: 10px; text-align: left; float: left; position: relative;">
						<div>
							<fieldset>
								<legend>
									<strong>품목구분</strong>
								</legend>
								<label> <select class="select_value"
									data-placeholder="품목구분" id="prd_seq_add" name="prd_seq"
									style="width: 250px; display: none;" onchange=""></select>
								<div
										class="chosen-container chosen-container-single chosen-container-single-nosearch"
										style="width: 250px;" title="" id="prd_seq_add_chosen">
										<a class="chosen-single chosen-default" tabindex="-1"><span>품목구분</span>
										<div>
												<b></b>
											</div></a>
										<div class="chosen-drop">
											<div class="chosen-search">
												<input type="text" autocomplete="off" readonly="">
											</div>
											<ul class="chosen-results"></ul>
										</div>
									</div>
								</label>
							</fieldset>
						</div>
						<div>
							<fieldset>
								<legend>
									<strong>영농과정</strong>
								</legend>
								<label> <select class="select_value"
									data-placeholder="영농과정" id="step_cde_add" name="step_cde"
									style="width: 250px; display: none;" onchange=""></select>
								<div
										class="chosen-container chosen-container-single chosen-container-single-nosearch"
										style="width: 250px;" title="" id="step_cde_add_chosen">
										<a class="chosen-single chosen-default" tabindex="-1"><span>영농과정</span>
										<div>
												<b></b>
											</div></a>
										<div class="chosen-drop">
											<div class="chosen-search">
												<input type="text" autocomplete="off" readonly="">
											</div>
											<ul class="chosen-results"></ul>
										</div>
									</div>
								</label>
							</fieldset>
						</div>
						<div>
							<fieldset>
								<legend>
									<strong>명칭</strong>
								</legend>
								<label> <input type="text" data-placeholder="작업과정"
									id="work_add" name="work" style="width: 250px;" onchange="">
								</label>
							</fieldset>
						</div>
						<button id="btn_write_step" class="rc-button rc-button-submit"
							type="button">등록</button>
					</div>
				</div>
				<input type="hidden" name="usr_email" value="cbnmzxcvb@gmail.com">
				<input type="hidden" id="insert_id" name="insert_id"
					value="insert_usr_step">
			</form>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">닫기</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_ret"
		aria-labelledby="ui-id-7" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-7" class="ui-dialog-title">품목추가</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_ret" style="" class="ui-dialog-content ui-widget-content">
			<div id="where_area">
				<div id="where_box"
					style="width: 380px !important; height: 140px !important;">
					<div class="info">
						<form action="/rest/data/get" id="frm_prdlist" name="frm_prdlist"
							method="post">
							<div class="label" style="width: 80px;">
								<span>품종명</span>
							</div>
							<div class="value">
								<input id="zip_code" name="zip_code"
									style="width: 134px; ime-mode: active;" value="">
							</div>
							<div class="value" style="padding-top: 0px; margin-top: 0px;">
								<button id="btn_prd_search" type="button" class="rc-button">검색</button>
							</div>
							<div class="title"
								style="margin-bottom: 0px; background-color: none !important;">
								<span>품종명에 품종명을 입력하십시오. 예) "사과" 입력</span>
							</div>
							<div style="clear: both;"></div>
							<div class="label" style="width: 80px;">
								<span>품목명칭</span>
							</div>
							<div class="value">
								<input id="prd_nam" name="prd_nam" readonly="readonly"
									style="width: 134px; ime-mode: active;" value="">
							</div>
							<div class="value" style="padding-top: 0px; margin-top: 0px;">
								<button id="btn_prd_apply" type="button"
									class="rc-button rc-button-submit">등록</button>
							</div>
							<div class="title"
								style="margin-bottom: 0px; background-color: none !important;">
								<span>품종명을 검색하여 아래 리스트에서 품목을 선택하세요.</span>
							</div>
							<input type="hidden" name="id" value="prd"> <input
								type="hidden" name="method" value="read_List"> <input
								type="hidden" name="pagenum" value="1"> <input
								type="hidden" name="numrow" value="7"> <input
								type="hidden" id="edit_prd_cde" name="prd_cde" value="">
							<input type="hidden" name="usr_email" value="cbnmzxcvb@gmail.com">
							<input type="hidden" name="check_use" value="on"> <input
								type="hidden" id="insert_id" name="insert_id"
								value="insert_diary_prd">
						</form>
					</div>
				</div>
			</div>

			<div id="list_area">
				<div id="list_box"
					style="height: 400px !important; width: 380px !important;">
					<div id="condition_area">
						<div id="condition_box" style="width: 380px !important;">
							<div class="board_area" style="">
								<div id="board_box1" class="board_box"
									style="width: 340px !important;">
									<div class="hitbox" style="width: 340px !important;">
										총 :<span id="news_totalcnt_sub" class="ft_color"> 0 건</span>,
										현재페이지 :<span id="news_curpage_sub" class="ft_color"> 0</span>
									</div>
									<div style="clear: both;"></div>
									<table class="boardList" style="width: 370px !important;"
										summary="게시판목록">
										<caption>게시판목록</caption>
										<colgroup>
											<col width="100px">
											<col width="100px">
											<col width="100px">
										</colgroup>
										<thead
											style="height: 20px !important; border: 1px solid; cursor: pointer;">
											<tr>
												<th scope="col">대분류</th>
												<th scope="col">품종명</th>
												<th scope="col">품목명</th>
											</tr>
										</thead>
										<tbody id="sub_board_news_sub"></tbody>
									</table>
								</div>
								<div class="paging" id="news_view_paging_sub"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">닫기</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_step_search"
		aria-labelledby="ui-id-8" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-8" class="ui-dialog-title">작업명 검색</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_step_search" style=""
			class="ui-dialog-content ui-widget-content">
			<div id="where_area">
				<div id="where_box"
					style="width: 380px !important; height: 85px !important;">
					<div class="info">
						<form action="/rest/data/get" id="frm_steplist"
							name="frm_steplist" method="post">
							<div class="label" style="width: 70px;">
								<span>작업명</span>
							</div>
							<div class="value">
								<input id="search_work_title" name="work"
									style="width: 200px; ime-mode: active;" value="">
							</div>
							<div class="value">
								<button id="search_btn_prd_search" type="button"
									style="height: 36px;">검색</button>
							</div>
							<input type="hidden" name="id" value="worksteplist"> <input
								type="hidden" name="method" value="read_List"> <input
								type="hidden" name="pagenum" value="1"> <input
								type="hidden" name="numrow" value="7"> <input
								type="hidden" name="usr_email" value="cbnmzxcvb@gmail.com">
							<input type="hidden" name="prd_seq" id="frm_steplist_prd_seq"
								value="">
						</form>
						<div class="title"
							style="width: 300px !important; background-color: none !important;">
							<span>검색창에서 작업과정명을 입력하십시오. <br> 예) "개화" 입력
							</span>
						</div>
					</div>
				</div>
			</div>
			<div id="list_area">
				<div id="list_box"
					style="height: 400px !important; width: 380px !important;">
					<div id="condition_area">
						<div id="condition_box" style="width: 380px !important;">
							<div class="board_area" style="">
								<div id="board_box2" class="board_box"
									style="width: 340px !important;">
									<div class="hitbox" style="width: 340px !important;">
										총 :<span id="news_totalcnt_search" class="ft_color"> 0
											건</span>, 현재페이지 :<span id="news_curpage_search" class="ft_color">
											0</span>
									</div>
									<div style="clear: both;"></div>
									<table class="boardList" style="width: 380px !important;"
										summary="게시판목록">
										<caption>게시판목록</caption>
										<colgroup>
											<col>
											<col width="100px">
											<col width="100px">
										</colgroup>
										<thead style="height: 20px !important; border: 1px solid">
											<tr>
												<th scope="col">품목</th>
												<th scope="col">영농과정</th>
												<th scope="col">작업명</th>
											</tr>
										</thead>
										<tbody id="sub_board_news_search"></tbody>
									</table>
								</div>
								<div class="paging" id="news_view_paging_search"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">닫기</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_add_pest"
		aria-labelledby="ui-id-9" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-9" class="ui-dialog-title">농약종류 추가</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_add_pest" style=""
			class="ui-dialog-content ui-widget-content">
			<form action="/rest/process/reg" id="frm_reg_pest"
				name="frm_reg_pest" method="post">
				<div
					style="width: 300px; margin: 0 auto; padding-bottom: 30px; padding-left: 30px; padding-right: 30px;">
					<div
						style="width: 300px; padding-top: 10px; padding-right: 30px; padding-bottom: 10px; text-align: left; float: left; position: relative;">
						<div>
							<fieldset>
								<legend>
									<strong>농약종류</strong>
								</legend>
								<label> <input type="text" data-placeholder="작업과정"
									id="pest_add" name="unt_nam" style="width: 200px;" onchange="">
								</label>
							</fieldset>
						</div>
						<button id="btn_write_pest" class="rc-button rc-button-submit"
							type="button">등록</button>
					</div>
				</div>
				<input type="hidden" name="usr_email" value="cbnmzxcvb@gmail.com">
				<input type="hidden" id="insert_id" name="insert_id"
					value="insert_diary_pest">
			</form>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">닫기</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_add_fer"
		aria-labelledby="ui-id-10" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-10" class="ui-dialog-title">비료종류 추가</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_add_fer" style=""
			class="ui-dialog-content ui-widget-content">
			<form action="/rest/process/reg" id="frm_reg_fer" name="frm_reg_fer"
				method="post">
				<div
					style="width: 300px; margin: 0 auto; padding-bottom: 30px; padding-left: 30px; padding-right: 30px;">
					<div
						style="width: 300px; padding-top: 10px; padding-right: 30px; padding-bottom: 10px; text-align: left; float: left; position: relative;">
						<div>
							<fieldset>
								<legend>
									<strong>비료종류</strong>
								</legend>
								<label> <input type="text" data-placeholder="작업과정"
									id="fer_add" name="unt_nam" style="width: 200px;" onchange="">
								</label>
							</fieldset>
						</div>
						<button id="btn_write_fer" class="rc-button rc-button-submit"
							type="button">등록</button>
					</div>
				</div>
				<input type="hidden" name="usr_email" value="cbnmzxcvb@gmail.com">
				<input type="hidden" id="insert_id" name="insert_id"
					value="insert_diary_fer">
			</form>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">닫기</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_add_man"
		aria-labelledby="ui-id-11" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-11" class="ui-dialog-title">인력종류 추가</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_add_man" style=""
			class="ui-dialog-content ui-widget-content">
			<form action="/rest/process/reg" id="frm_reg_man" name="frm_reg_man"
				method="post">
				<div
					style="width: 300px; margin: 0 auto; padding-bottom: 30px; padding-left: 30px; padding-right: 30px;">
					<div
						style="width: 300px; padding-top: 10px; padding-right: 30px; padding-bottom: 10px; text-align: left; float: left; position: relative;">
						<div>
							<fieldset>
								<legend>
									<strong>인력종류</strong>
								</legend>
								<label> <input type="text" data-placeholder="작업과정"
									id="man_add" name="unt_nam" style="width: 200px;" onchange="">
								</label>
							</fieldset>
						</div>
						<button id="btn_write_man" class="rc-button rc-button-submit"
							type="button">등록</button>
					</div>
				</div>
				<input type="hidden" name="usr_email" value="cbnmzxcvb@gmail.com">
				<input type="hidden" id="insert_id" name="insert_id"
					value="insert_diary_man">
			</form>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">닫기</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_add_dev"
		aria-labelledby="ui-id-12" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-12" class="ui-dialog-title">장비종류 추가</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_add_dev" style=""
			class="ui-dialog-content ui-widget-content">
			<form action="/rest/process/reg" id="frm_reg_dev" name="frm_reg_dev"
				method="post">
				<div
					style="width: 300px; margin: 0 auto; padding-bottom: 30px; padding-left: 30px; padding-right: 30px;">
					<div
						style="width: 300px; padding-top: 10px; padding-right: 30px; padding-bottom: 10px; text-align: left; float: left; position: relative;">
						<div>
							<fieldset>
								<legend>
									<strong>장비종류</strong>
								</legend>
								<label> <input type="text" data-placeholder="작업과정"
									id="dev_add" name="unt_nam" style="width: 200px;" onchange="">
								</label>
							</fieldset>
						</div>
						<button id="btn_write_dev" class="rc-button rc-button-submit"
							type="button">등록</button>
					</div>
				</div>
				<input type="hidden" name="usr_email" value="cbnmzxcvb@gmail.com">
				<input type="hidden" id="insert_id" name="insert_id"
					value="insert_diary_dev">
			</form>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">닫기</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
	<div
		class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
		tabindex="-1" role="dialog" aria-describedby="dlg_timer"
		aria-labelledby="ui-id-21" style="display: none; position: absolute;">
		<div
			class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-21" class="ui-dialog-title">자동 로그아웃 안내</span>
			<button
				class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close"
				role="button" aria-disabled="false" title="close">
				<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span
					class="ui-button-text">close</span>
			</button>
		</div>
		<div id="dlg_timer" style="z-index: 999;"
			class="ui-dialog-content ui-widget-content">
			<font family="tahoma" style="font-size: 14px; font-weight: bold;">자동
				로그아웃 남은시간</font><br>
			<font color="red"
				style="font-size: 20px; font-weight: bold; line-height: 2.2em;">179:14</font>
		</div>
		<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">로그인 연장하기</span>
				</button>
				<button type="button"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
					role="button" aria-disabled="false">
					<span class="ui-button-text">지금 로그아웃</span>
				</button>
			</div>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
		<div
			class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
			style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
	</div>
</body>
</html>