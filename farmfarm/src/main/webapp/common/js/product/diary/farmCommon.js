$(document).ready(function(){
	/*레이어 중간정렬*/
	var $layerPopupObj = $('.diaryWrite, .diaryView, .todoView');
	var left = ( $(window).scrollLeft() + ($(window).width() - $layerPopupObj.width()) / 2 );
	var top = ( $(window).scrollTop() + ($(window).height() - $layerPopupObj.height()) / 2 );
	$layerPopupObj.css({'left':left,'top':top, 'position':'absolute'});
	$('body').css('position','relative').append($layerPopupObj);
	$('body').prepend('<div id="mask"><!--레이어 검은바탕--></div>');
	/*영농일지 레이어 마스킹(black)*/
	function wrapWindowByMask(){
		var maskHeight = $(document).height();  
		var maskWidth = $(window).width();  
		$('#mask').css({'width':maskWidth,'height':maskHeight});  
		$('#mask').fadeTo("slow",0.4); 
	}
	
//	$('.diaryWriteGo').click(function(e){
//		$('.diaryWrite').show();
//		e.preventDefault();
//		wrapWindowByMask();
//	});
//	$('.diaryViewGo').click(function(e){
//		$('.diaryView').show();
//		e.preventDefault();
//		wrapWindowByMask();
//	});
	$('.todoViewGo').click(function(e){
		$('.todoView').show();
		e.preventDefault();
		wrapWindowByMask();
	});
	

			
	
	/* 일정작성 옵션 설정 시작 */
	$.datepicker.setDefaults({
		inline: true, 
		dateFormat: "yy-mm-dd",    /* 날짜 포맷 */ 
		prevText: 'prev', 
		nextText: 'next', 
		showButtonPanel: true,    /* 버튼 패널 사용 */ 
		changeMonth: true,        /* 월 선택박스 사용 */ 
		changeYear: true,        /* 년 선택박스 사용 */ 
		showOtherMonths: true,    /* 이전/다음 달 일수 보이기 */ 
		selectOtherMonths: true,    /* 이전/다음 달 일 선택하기 */ 
//		showOn: "button", 
//		buttonImage: "img/calendar03.gif", 
		buttonImageOnly: true, 
		minDate: '-30y', 
		closeText: '닫기', 
		currentText: '오늘', 
		showMonthAfterYear: true,        /* 년과 달의 위치 바꾸기 */ 
		showAnim: 'slideDown'
	})
	

	$('.close').click(function (e) {
	    e.preventDefault();  
	    $('#mask, .diaryWrite, .diaryView, .todoView').hide();  
	});
	$('#mask').click(function () {  
	    $(this).hide();  
	    $('.diaryWrite, .diaryView, .todoView').hide();  
	});      
});