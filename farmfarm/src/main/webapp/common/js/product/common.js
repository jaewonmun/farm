
document.title="농업을 e-롭게 농촌을 새롭게!";
// Design Select 
$(function(){
    $('div.d_select').find(' > ul').css("visibility", "hidden");
});

$(window).load(function(){
	/*
	if($('body').find('div').hasClass('ceoHome')){
		console.log(123);
		$("#contentWrap").css({'margin-top' : '-35px'}).find('div#content').css({'padding-bottom' : 0});
	};*/
	dSelect();
	var selector = $('div.d_select');
	selector.css({'position' : 'relative'});

	var body_h = $('body').outerHeight();
	var b_dimmed = $('.b_dimmed');
	if (b_dimmed.length > 0){
		b_dimmed.css({'height' : body_h});
	}

/*
	$('.c_table01 table thead tr:first-child th').each(function(){
		//$(this).parent().parent().parent().css({'table-layout' : 'auto'});
		var width = $(this).outerWidth();
		console.log(width);

		if ($(this).outerWidth > 60 && $(this).outerWidth() < 60){
			$(this).css({'width' : 60});
			console.log(1);
		}
	});
*/

	var c_select = $('div.conBanner > div.foodBox2 ul > li > a');

	// 소비 레이어팝업
	// 각 버튼을 누를때마다 이미지가 생성되기때문에 images/consummer/ 경로에 image01.png ~ image02.png 이런식으로 업로드하면 됨.

	c_select.click(function(){
		var newContents = $('#newContents');
		var src = $('div.foodBox2 ul > li > a > img').attr('src').slice(0,18) + 'image';
		var png = '.png';
		var jpg = '.jpg';
		var index = $(this).parent().index();
		newContents.fadeIn(300).find('div').css({'display' : 'block'});

		if (index < 10){
			index = ('0' + (index)) + png;
		}else{
			index = index + png;
		}

		var html = src + index;
		var img = '<img src=' + html + ' alt="" / >';

		newContents.find('div.img').html(img);

		b_dimmed.css({'filter' : 'alpha(opacity=50)'}).fadeIn(300);

		return false;
	});

	b_dimmed.click(function(){
		$(this).fadeOut(300).parents('body').css({'overflow-y' : 'auto'});
	});
});

	function dSelect(){
		var selector = $('div.d_select');
		selector.find('ul > li > a').each(function(width){
			var width = $(this).width();
			if (width > $(this).parents('body').find(selector).find('> a').width()){
				$(this).parents('body').find(selector).find('> a').css({'width' : width});
//				selector.css({'position' : 'relative'}).find('> ul').hide();
				selector.find('> ul').hide();
			}else{
				$(this).parents('body').find(selector).find('> ul').css({'width' : '100' + '%'});
//				selector.css({'position' : 'relative'}).find('> ul').hide();
				selector.find('> ul').hide();
			}
		});

		selector.find('>a').click(function(width){
			$(this).next('ul').stop().slideToggle(300);
			$(this).addClass('on').css({'width' : width});
			$(this).parents('body').find(selector).css({'z-index' : 20000});

			return false;
		});

		selector.mouseleave(function(){
			$(this).css({'z-index' : 0}).find('> a').removeClass('on').next('ul').stop().slideUp(300);
		});

		selector.find('ul').find('a').click(function(){
			var me = $(this);
			var li_index = $(this).parent('li').index();
			var li_height = $(this).outerHeight();

			if (me.parent('li').parent('ul').children('li').length == me.parents('ul').next('select').children('option').length){
				var text = $(this).text();
				me.parent('li').parent('ul').hide().prev('a').text(text);

				me.parents('ul').next('select').find('option').eq(li_index).attr('selected','selected');
				if (me.parents('ul').next('select').find('option').eq(li_index).attr('selected')){
					me.parents('ul').next('select').find('option').eq(li_index).siblings().removeAttr('selected');
				}
			}

			// $(this)를 변수에 저장해서 코드를 줄일 수 있게 조치. 어떤 DOM객체이더라도 2번 이상 사용하게 되면 변수로 저장해서 사용할 것.

		});
		selector.find(' > ul').css({"visibility" : "visible", "z-index" : 20000});
	};

//gnb
$(window).load(function(){
	$('#gnb > ul > li > a').on('mouseenter focus', function(){
		$('#gnb > ul > li img').css({'margin' : 0});
		$('#gnb > ul > li > div').hide();
		$(this).find('img').css({'margin-top' : -40}).parent().next('div').show().parents('body').find('div.allMenu').show();
	});
	$('#gnb').mouseleave(function(){
		$(this).find('img').css({'margin' : 0}).parents('#gnb').find('div').hide();
	});

	$('a.gnbClose').click(function(){
		$('#gnb > ul > li div, div.allMenu').hide();
	});
	
	// 통합영농가이드
	$("#gnbFmGuideWrap .closeSub").hide();
	$("#gnbFmGuide li a").each(function(){
		var image = $(this).children("img");
		var imgsrc = $(image).attr("src");		
		$(this).mouseover(function(){
			var on = imgsrc.replace(/_off.gif/,"_on.gif"); 
			$(image).attr("src",on);
			$("#gnbFmGuideWrap .closeSub").show();
		  }); 
		$(this).mouseout(function(){
			var off = imgsrc.replace(/_on.gif/,"_off.gif");
			$(image).attr("src",off);
		});
		$(this).mousedown(function(){
			var dn = imgsrc.replace(/_off.gif/,"_on.gif");
			$(image).attr("src",dn);
		});		  
		$(this).bind('mouseover focus' , function()	{
			$(".gnbFmGuideSub").show();	
			$(".gnbFmGuideSub").css('z-index','30000');	
			$("#gnbFmGuideWrap .closeSub").css('z-index','30010');	
		});	
	});	
	$(".combineGuideHead").bind('mouseleave focusout', function(){
		$(".gnbFmGuideSub").hide();
		$("#gnbFmGuideWrap .closeSub").hide();
	});	
	$("#gnbFmGuideWrap .closeSub").click(function(){
		$(this).hide();
		$(".gnbFmGuideSub").hide();
	});
});	
	
$(document).ready(function() {
	var b_dimmed = $('div.b_dimmed');
	// Footer Slide Banner 
	
	var s_ban = $('div.inner div.banner');
	var s_banMargin = parseInt(s_ban.find('li').css('margin-left')) * 2;
	var s_banWidth = s_ban.find('li').outerWidth();

	s_ban.find('> ul').css({'left' : -(s_banMargin + s_banWidth)});

	s_ban.find('button').click(function(){
		if ($(this).hasClass('prev')){
			s_ban.find('> ul').animate({'left' : 0}, 300, function(){
				s_ban.find('> ul').find('li:last').prependTo(s_ban.find('> ul'));

				if (s_ban.find('> ul').css('left') == '0' + 'px'){
					s_ban.find('> ul').css({'left' : -(s_banWidth + s_banMargin)});
				}
			});
		}else if ($(this).hasClass('next')){
			s_ban.find('> ul').animate({'left' : '-=' + (s_banWidth + s_banMargin)}, 300, function(){
				s_ban.find('> ul').find('li:first').appendTo(s_ban.find('> ul'));

				if (s_ban.find('> ul').css('left') == '-' + ((s_banWidth + s_banMargin) * 2) + 'px'){
					s_ban.find('> ul').css({'left' : -(s_banWidth + s_banMargin)});
				}else{
					s_ban.find('> ul').css({'left' : -(s_banWidth + s_banMargin)});
				}
			});
		}
	});

	var f_Time = 3000;

	function f_Slide(){

		s_ban.find('> ul').animate({'left' : '-=' + (s_banWidth + s_banMargin)}, 300, function(){
			s_ban.find('> ul').find('li:first').appendTo(s_ban.find('> ul'));

			if (s_ban.find('> ul').css('left') == '-' + ((s_banWidth + s_banMargin) * 2) + 'px'){
				s_ban.find('> ul').css({'left' : -(s_banWidth + s_banMargin)});
			}else{
				s_ban.find('> ul').css({'left' : -(s_banWidth + s_banMargin)});
			}
		});
	};

	var m_Slide = setInterval(f_Slide, f_Time);

	s_ban.on('mouseenter focus', function(){
		clearInterval(m_Slide);
	});

	s_ban.mouseleave(function(){
		m_Slide = setInterval(f_Slide, f_Time);
	});

	function slideImg(){
		$('.ceoHome .half2 .ceoList').hide();
		$('.ceoTab .thNewsTab').find('li:first').addClass('on');
		$('.list_wrap').find('div:eq(0)').show();
	};

	setTimeout(slideImg, 300);
	
	/*년도선택 셀렉트*/
	$('.sortYM dt a').on('click', function(e){
		$('.selectDv').toggle();
	});
	$('.sortYM').on('mouseleave', function(e){
		$('.selectDv').hide();
	});

	//select
	$('.selectAnchor').on('click', function(){
		$(this).parent().parent().find('.selectList').toggleClass('on');
	});	
	$('.selectList').on('click', function(){
		$(this).removeClass('on');
	});	
	//radio
	$('.rdo').on('click', function(){
		$(this).parent().find('a').toggleClass('check');
	});

	/*레이어 중간정렬
	var $layerPopupObj = $('.diaryWrite, .diaryView, .todoView');
	var left = ( $(window).scrollLeft() + ($(window).width() - $layerPopupObj.width()) / 2 );
	var top = ( $(window).scrollTop() + ($(window).height() - $layerPopupObj.height()) / 2 );
	$layerPopupObj.css({'left':left,'top':top, 'position':'absolute'});
	$('body').css('position','relative').append($layerPopupObj);
	
	/*영농일지 레이어 마스킹(black)
	function wrapWindowByMask(){
		var maskHeight = $(document).height();  
		var maskWidth = $(window).width();  
		$('#mask').css({'width':maskWidth,'height':maskHeight});  
		$('#mask').fadeTo("slow",0.4); 
	}
	$(document).ready(function(){
		$('.diaryWriteGo').click(function(e){
			$('.diaryWrite').show();
			e.preventDefault();
			wrapWindowByMask();
		});
		$('.diaryViewGo').click(function(e){
			$('.diaryView').show();
			e.preventDefault();
			wrapWindowByMask();
		});
		$('.todoViewGo').click(function(e){
			$('.todoView').show();
			e.preventDefault();
			wrapWindowByMask();
		});

		

		$('.close').click(function (e) {
		    e.preventDefault();  
		    $('#mask, .diaryWrite, .diaryView, .todoView').hide();  
		});
		$('#mask').click(function () {  
		    $(this).hide();  
		    $('.diaryWrite, .diaryView, .todoView').hide();  
			 
			 */

	//자주묻는 질문 아코디언
	$('.lineType>ul>li>a').click(function(){
		$(this).parent().toggleClass('on');

	});
	
	//언론사별 뉴스 이미지 swich
	$(".nPaper").bind('click', function() {
		if ($(this).attr("class") == "nPaper") {
		this.src = this.src.replace("_off","_on");
		} else {
		this.src = this.src.replace("_on","_off");
		}
		$(this).toggleClass("on");
	});
	
	
	//yplan tab 농식품3.0
	$(".planHead a").each(function () {
		$(this).bind("click", function () {
			var clickedIndex = $(".planHead a").index(this);
			$(".planHead.on").removeClass("on");
			$(".planView.on").removeClass("on");

			$($(".planHead").get(clickedIndex)).addClass("on");
			$($(".planView").get(clickedIndex)).addClass("on");			
		});
	});	
	$(".planHead a").each(function () {
		$(this).bind("focusin", function () {
			var focusIndex = $(".planHead a").index(this);
			$(".planHead.on").removeClass("on");
			$(".planView.on").removeClass("on");

			$($(".planHead").get(focusIndex)).addClass("on");
			$($(".planView").get(focusIndex)).addClass("on");			
		});
	});

	var pressWrap = $('.pressWrap');

	for (var i = 0; i < pressWrap.find('li').length ; i++){
		if(i % 5 == 4){
			pressWrap.find('li').eq(i).addClass('non');
		}

		pressWrap.find('li:gt(' + (pressWrap.find('li').length - 6) + ')').addClass('last');
	}

	$('div.flip').find('> a').click(function(){
		var list = pressWrap.find('li').height();
		var dep2 = pressWrap.find('> ul').outerHeight();

		if (pressWrap.css('height') == list + 'px'){
			pressWrap.stop().animate({'height' : dep2}, 300);
		}else{
			pressWrap.stop().animate({'height' : list}, 300);
		}
	});

	//뉴스별 열고닫기
	$('.flip a').click(function(e){
	$('.pressWrap .hd').slideToggle();
		if ($(this).text() == "모두닫기")
			$(this).text("모두열기")
		else
			$(this).text("모두닫기");
	$(this).toggleClass('on');
	});
	//기간검색
	$('.btnDvSearh').click(function(e){
		$('.searchDv').show();
	});
	$('.dvClose').click(function(e){
		$('.searchDv').hide();
	});
	
	// 텃밭가이드

	var basiclist01 = $('ul.basic_list01');

	function vTab(){
		basiclist01.find('> li').each(function(){
			var dHeight = $(this).find('> a').next('div').outerHeight();
			if ($(this).find('>a').hasClass('on')){
				$(this).find('>a').next('div').show();
				$(this).parent(basiclist01).css({'height' : dHeight + 35, 'overflow': 'hidden'});
			}

			$(this).css({'height' : dHeight + 35});
		});
	};

	setTimeout(vTab, 200);

	basiclist01.find('> li > a').click(function(){
		var dHeight = $(this).next('div').outerHeight() + 35;
		basiclist01.find('> li').find('>a').removeClass('on').next('div').hide();
		basiclist01.css({'height' : dHeight});
		$(this).addClass('on').next('div').show();
		

		return false;
	});

	pro_btnSelect = $('button.toggle_btn');

	pro_btnSelect.click(function(){
		var calander = $('.c_table > table');
		var buttonDiv = $('div.tog_btn');
		var type1 = $(this).hasClass('toggle_btn02') ? 'core' : 'favor';
		var type2 = $(this).hasClass('toggle_btn02') ? 'favor' : 'core';
		
		if( $(buttonDiv).hasClass('on') ){ // 테이블 영역이 열려 있을 때
			if (! $(this).hasClass('on')){ // 버튼이 선택 상태면
				$(this).removeClass('on').parent('div').removeClass('on');
				$(calander).find('tbody[id="'+type1+'FarmBody"]').find(calander).parent('div').stop().fadeOut(500);
			}else{
				$(this).siblings().addClass('on');
				$(this).addClass('on').parent('div').addClass('on');
				$(calander).find('tbody[id="'+type1+'FarmBody"]').stop().hide();
				$(calander).find('tbody[id="'+type2+'FarmBody"]').stop().show();
//				$(calander).find('tbody[id="'+type2+'FarmBody"]').stop().fadeIn(500, function(){
//					if($.browser.msie){this.style.removeAttribute('filter');}
//				});
					
			}
		}else{
			$(this).addClass('on').parent('div').addClass('on');
			$(calander).find('tbody[id="'+type1+'FarmBody"]').stop().hide();
			$(calander).find('tbody[id="'+type2+'FarmBody"]').stop().show().parent('div').fadeIn(500);
		}
	});

	var process = $('div.process ul li > dl');

	process.find('dt > a').click(function(){
		if (! $(this).parents('dl').hasClass('on')){
			process.removeClass('on').find('dd').slideUp(300);
			$(this).parent('dt').next('dd').slideDown(300).parents('dl').addClass('on');
		}

		return false;
	});


/*
	slide02.find('button').click(function(){
		var list = $('.slide02_wrap ul');
		if ($(this).hasClass('prev')){
			$(this).parent();
		}
	});
*/


	var sublist = $('div.sub_list');
	sublist.find('> div:last').find('div.foodBox').css({'border' : 0});

	var spelling = $('div.s_warp div.list > ul');

	// 텃밭가이드 가변형 탭 margin-bottom 제어함수

	var spelTop = $('.s_warp .top');

	function spelMar(){
		if (spelling.find('li a').hasClass('on')){
			var firstMar = spelling.find('li a.on').next('div').outerHeight();

			spelTop.css({'margin-bottom' : firstMar});
		}
	};

	spelMar();

	spelling.find('>li').each(function(){
		if ($(this).find('>a').hasClass('on')){
			$(this).find('>a').next('div').show();

		}
	});
	spelling.find('>li > a').click(function(){
		var spelHeight = $(this).next('div').outerHeight();

		if (! $(this).hasClass('none')){
			spelling.find('.on').removeClass('on').parents('body').find(spelling).find('div').hide();
			$(this).addClass('on').next('div').show();
			spelTop.css({'margin-bottom' : spelHeight});
		}

		return false;
	});

/*
	$('.basic_list01 > li').each(function(){
		var tHeight = $(this).find('> a').outerHeight();
		var dHeight = $(this).find('a').next('div').outerHeight();

		$(this).css({'height' : tHeight + dHeight});

		console.log(tHeight);
		console.log(dHeight);
	});
*/

	var slide02 = $('div.slide02_wrap');

	slide02.each(function(){
		if ($(this).find('li').length <= 3){
			$(this).find('div.btn_wrap').hide();
		}
	});

	slide02.find('button').click(function(){
		var par = $(this).parent().next('ul');
		if ($(this).hasClass('prev')){
			$(this).parent().next('ul').find('li:first').appendTo(par);
		}else{
			$(this).parent().next('ul').find('li:last').prependTo(par);
		}
	});

	slide02.find('> ul > li > a').click(function(){
		var body = $('body').outerHeight();
		var layer = $('#basic_layer');
		layer.find('div > img').attr('src', $(this).find('img').attr('src'));
		var layer_height = $('#basic_layer').outerHeight() / 2;
		var layer_width = $('#basic_layer').outerWidth() / 2;
		var dimmed = $('.b_dimmed');

		dimmed.css({'height' : body, 'filter' : 'alpha(opacity=50)'}).fadeIn(300);
		layer.css({'margin-top' : -layer_height, 'margin-left' : -layer_width}).fadeIn(300);

		return false;
	});

	$('#basic_layer').find('button').click(function(){
		$(this).parents('#basic_layer').fadeOut(500).parents('body').find('div.b_dimmed').fadeOut(300);
	});

	pro_btnSelect = $('button.toggle_btn');

	pro_btnSelect.click(function(){
		var calander = $('.c_table > table');

		if (! $(this).hasClass('on')){
			$(this).addClass('on').parents('body').find(calander).stop().fadeOut(500);
		}else{
			$(this).removeClass('on').parents('body').find(calander).stop().fadeIn(500);
		}
	});

	var process = $('div.process ul li > dl');

	process.find('dt > a').click(function(){
		if (! $(this).parents('dl').hasClass('on')){
			process.removeClass('on').find('dd').slideUp(300);
			$(this).parent('dt').next('dd').slideDown(300).parents('dl').addClass('on');
		}

		return false;
	});

	$('#newContents').find('a.close_btn').click(function(){
		if ($('div.b_dimmed').css('display') == 'block'){
			$('div.b_dimmed').fadeOut(300);
		}else{
			return false;
		}

		return false;
	});

	// 유통

/*
	var d_color = '#e1e1e1';
	$('.obser .cont > ul > li > div > ul > li > div > ul > li:even > ul').css({'border-left' : '1px solid' + d_color})
	$('.obser .cont > ul > li.list01 > div > ul > li > div > ul > li:even > ul').css({'border-right' : '1px solid' + d_color, 'border-left' : 0});
	$('.obser .cont > ul > li.news > div > ul > li > div > ul > li > ul').css({'border' : 0});
*/
	var divisionHeight;
	var disHeight = $('.cont > ul > li > a').outerHeight();
	var txt = $('div.txt').text();
	var txtList = $('.obser .cont > ul > li');

	$('.obser .cont > ul > li > div > ul > li > div > ul').each(function(){
		var txt = "해당품목에 대한 관측정보가 없습니다.";
		if ($(this).find('a').length < 1){
			$(this).parent('div').text(txt);
		}
	});

/*
	txtList.each(function(){
		if ($(this).find('> div > ul > li > div > ul > li a').length < 1){
			alert(1)
		}
			console.log($(this).find('> div > ul > li'));
	});
*/

	$('.cont > ul > li').find('> div > ul > li > div').each(function(){
		divsionHeight = $(this).outerHeight() - 3;
		$(this).hide();
	});

	$('.cont > ul > li > a').click(function(){
		var depthHeight = $(this).next('div').find('> ul > li > div').outerHeight();
		//console.log(depthHeight);


		var height = ($(this).next('div').find('> ul > li:first-child > div').outerHeight() + $('.obser .cont > ul > li > div > ul').outerHeight()) + 1;
		var last = $('.obser .cont > ul > li > div > ul > li > div');
		last.addClass('last');

		if ($(this).next('div').css('display') == 'block' && ! $(this).hasClass('on')){
			$('.obser .cont > ul > li').find('.on').removeClass('on');
			$('.obser .cont > ul > li').stop().animate({'height' : disHeight}, 300);
			$(this).addClass('on').find('> ul > li > div').hide();
			$(this).next('div').find('> ul').addClass('on').find('> li > div').addClass('on');
			last.hide();
			$('.obser .cont > ul > li > div > ul > li:first-child > div').show();
			$(this).parent('li').stop().animate({'height' : height + disHeight}, 300).find('> div > ul > li:first-child').find('> div').show().prev('a').addClass('on');

			/*
			console.log(height);
			console.log($(this).next('div').find('> ul > li:first-child > div').outerHeight());
			console.log($('.obser .cont > ul > li > div > ul').outerHeight() - 1);
			$(this).removeClass('on').parent('li').removeClass('bg');
			$(this).next('div').slideUp(300);
			*/
		}else{
			$(this).removeClass('on').parent('li').stop().animate({'height' : disHeight}, 300);
			$('.obser .cont > ul > li > div > ul').removeClass('on');
			$('.obser .cont > ul > li > div > ul > li > div').removeClass('on');
			/*
			$('.cont > ul > li').removeClass('bg');
			$('.cont > ul > li > a').removeClass('on').next('div').slideUp(300);
			$('.obser .cont > ul > li').find('.on').removeClass('on');
			$('.obser .cont > ul > li > div > ul > li > div.last').removeClass('on');
			$(this).addClass('on').next('div').slideDown(300).stop().animate({'height' : height}, 300).find(last).addClass('on').first().show();
			$(this).parent('li').addClass('bg').css({'height' : height + disHeight});
			$(this).next('div').find('> ul > li:first-child > a:first-child').addClass('on');
			$(this).next('div').find('> ul').addClass('on');
			*/
		}

		return false;
	});

	$('.obser .cont > ul > li > div > ul > li > a').click(function(){
		var height = $(this).next('div').outerHeight() + 34;

		$('.obser .cont > ul > li > div > ul > li > a').removeClass('on').next('div').hide();
		
		$(this).addClass('on').next('div').show();
		$(this).parent().parent().parent().parent('li').animate({'height' : height + disHeight}, 300);

		return false;
	});

	var priceWidth = $('.listType').outerWidth();
	var price = $('.listType');
	var priceChildren = $('.listType').find('th.price').outerWidth();

	price.find('table').each(function(){
		var length = $(this).find('th.price').length;
		if ($(this).find('thead th.price').length > 1){
			$(this).css({'width' : priceWidth + (length * priceChildren)});
			$(this).find('thead').css({'width' : priceWidth + (length * priceChildren), 'overflow' : 'hidden'});
		}
	});




	// 팝업 가변형

	var fileUrl = $('input.fileUrl');
	var fileUrl_W = $('input.fileUrl').outerWidth();
	var fileBtn = $('.lib_cont .lib_data table td span.file02').outerWidth();
	var per_ = 100;
	var tDataWidth = $('.lib_cont .lib_data table td').width();

	fileUrl.css({'width' : (fileUrl_W - fileBtn) - 20, 'background-color' : '#fff'});
	var txt_ = Math.floor($('.sub_tit').next('textarea').outerWidth());
	$('.sub_tit').css({'width' : tDataWidth + 12});
	$('.sub_tit > input').css({'width' : (tDataWidth - 49)});
	$(window).resize(function(){
//		console.log(tDataWidth);
		if ($(this).find('input.file')){
			fileUrl.css({'width' : tDataWidth - 70});
		}
		if ($('.sub_tit')){
		}
	});
	$('.lib_cont textarea').on('focus click', function(){
		$(this).text('').addClass('on');
	});

	//최신 컨텐츠

	
	var newContents = $('#newContents');

	$('.b_dimmed').click(function(){
		if ($('#basic_layer').length > 0){
			$('#basic_layer').fadeOut(300);
			$(this).fadeOut(300);
			$('body').css({'overflow' : 'auto'});
		}
		if ($('#newContents').length > 0){
			$('#newContents').fadeOut(300);
			$(this).fadeOut(300);
			newContents.find('> div').hide();
		}
	});
/*
	$('.ceoNotice li.more > a').click(function(){
		b_dimmed.fadeIn(300);
		newContents.fadeIn(300).find('div.notice.list').show();
	});

	$('.ceoNew li.more > a').click(function(){
		b_dimmed.fadeIn(300);
		newContents.fadeIn(300).find('div.new').show();
	});
*/
	newContents.find('.close_btn').click(function(){
		$(this).parent('div').fadeOut(300).parent('div').fadeOut(300);
		try{b_dimmed.fadeOut(300);}catch(E){}
	});

	$('.tabWeather.con li > a').click(function(){
		$('.tabWeather.con li > div').hide();
		$('.tabWeather.con li > a').removeClass('on');
		$(this).addClass('on').next('div').show();

		return false;
	});

	// ceoTab

	var ceoSelector = $('.ceoTab');
	var listIndex = $('.list_wrap').find('div').index();

	ceoSelector.find('li > a').click(function(){
		var ceoTabIndex = $(this).parent('li').index();
		$('.list_wrap').find('> div').hide();
		$('.ceoHome .half2 .ceoTab li').removeClass('on');
		$(this).parent('li').addClass('on').parents('body').find('.list_wrap').find('> div').eq(ceoTabIndex).show();

		return false;
	});

	// 소프트웨어

	var sTab = $('.softTab');
	var sTab_len = sTab.find('> ul > li').length;
	var sTablist = $('.softTab ul li').outerWidth();
	var sMargin = parseInt($('.softTab ul li').css('margin-left')) * 2;
	sTab.find('> ul').css({'width' : (sTablist + sMargin + 10) * sTab_len - 70});

	sTab.find('> ul > li > a').click(function(){
		sTab.find('> ul > li > a').removeClass('on');
		$(this).addClass('on');

		return false;
	});

	sTab.find('button').click(function(){
		var sTablist = $('.softTab ul li').outerWidth();
		if ($(this).hasClass('pre')){ // 왼쪽
			/*
			sTab.find('> ul').css({'right' : 'auto' , 'text-align' : 'left'}).stop().animate({'left' : -(sTablist + sMargin + 10)}, 500, function(){
				sTab.find('> ul > li:first').appendTo(sTab.find('ul'));
				sTab.find('> ul').css({'left' : 0});
			});
			*/
			sTab.find('> ul').stop().animate({'left' : -(sTablist + sMargin + 10)}, 500, function(){
				sTab.find('> ul > li:first').appendTo(sTab.find('ul'));
				sTab.find('> ul').css({'left' : 0});
			});
			//sTab.find('> ul').css({'left':-(sTablist + sMargin + 10)}).find('li:last').prependTo(sTab.find('> ul')).animate({'left': 0});
		}else{
			var _obj = sTab.find('> ul');
			var _wid = -(_obj.find('li:last').outerWidth());
				//_obj.find('li:last').css.prependTo(_obj);
				_obj.stop().css({'left' : _wid}).find('li:last').prependTo(_obj);
				_obj.animate({'left' : 0}, 500);
			/*
			sTab.find('> ul').css({'left': 'auto', 'text-align' : 'right'}).stop().animate({'right' : (-(sTablist + sMargin + 10))}, 300, function(){
				sTab.find('> ul').css({'right' : 0});
				sTab.find('> ul > li:last').prependTo(sTab.find('ul'));
			});
			*/
		}
	});

/*
	// 유통 차트보기 레이어팝업
	
	var rightNone = $('td.rightNone');

	rightNone.find('input[type=button]').click(function(){
		newContents.fadeIn(300).find('div').css({'display' : 'block'});
		$('div.b_dimmed').fadeIn(300);
	});

/*
/*
	$('div.newsPLine').on('mouseenter', function(){
		clearInterval(dis_Interval);
	});

	$('div.sideCustom').mouseleave(function(){
		dis_Interval = setInterval(dis_slide, 900);
	});
*/
/*
	$('.tabWeather.con li > div').hide();
	$('.tabWeather.con li:first > div').show();

	// 유통 홈 자동 슬라이드

	var newsProDt = $('div.newsProDt  > div');
	var newsListHeight = $('.newsPLine').outerHeight() + 10;
	function dis_slide(){
		newsProDt.animate({'top' : '-=' + (newsListHeight)}, 300, function(){
			newsProDt.find('div:first').appendTo(newsProDt);
			newsProDt.css({'top' : -5});
		});
	};

	var dis_Interval = setInterval(dis_slide, 900);

	$('div.newsPLine').on('mouseenter', function(){
		clearInterval(dis_Interval);
	});

	$('div.sideCustom').mouseleave(function(){
		dis_Interval = setInterval(dis_slide, 900);
	});
*/

	// 유통 영농일지 자동 슬라이드

	var reportMine = $('div.farmPrice div.inner.ani > div');
	if(reportMine.length>0){
		var reportList = reportMine.find('> div > div');
		var reportListHeight = reportList.outerHeight() + 10;
		
		function reportSlide(){
			reportMine.animate({'top' : '-=' + (40)}, 900, function(){
				reportMine.find('> div:first').appendTo(reportMine);
				reportMine.css({'top' : -0});
			});
		};
	
		var report_Interval = setInterval(reportSlide, 2700);
	}

});


//팝업 오픈
function openPopup(url, width, height){

	if(width == null){
		width = eval(screen.availWidth);//1024;
	}
	if(height == null){
		height= eval(screen.availHeight);//768;
	}
	
	width = parseInt(width,10)+60;
	
	if(parseInt(width,10)>eval(screen.availWidth)){
		width = eval(screen.availWidth);
	}
	if(parseInt(height,10)>eval(screen.availHeight)){
		height= eval(screen.availHeight);
	}
	
	url = url.replace(/&/g,",");
	//alert(url);
	
	window.open(c_url+"common/openPopup.do?rtnUrl="+url, '_blank', "width="+width+", height="+height+", scrollbars=yes, resizable=yes");
	
};

//jquery print plugin (id : 프린트 할 영역 div) 
function jqueryPrint(id){
	var options = {
			printMode: 'popup', //팝업설정 printMode option = popup, iframe,		
			overrideElementCSS:[ '/common/css/common.css', { href:'/common/css/common.css',media:'print' } ], //overrideElement option : boolean, css경로 		
			pageTitle:'농업농촌을 e-롭게!', //팝업 타이틀		
			leaveOpen:true //인쇄하고도 창을 띄우기(true)/안띄우기(false). Default는 false			
		};
	$('#' + id).printElement(options); //팝업으로 띄울 영역 Div 아이디
} 

// 이미지 리사이즈
function autoImgResize(obj, maxSize) {
	var objImg = $(obj).find("img");
	objImg.each(function() {
		var width = 0, height = 0;
		width = parseInt($(this).attr("width"), 10) || parseInt($(this).css("width"), 10);
		height = parseInt($(this).attr("height"), 10) || parseInt($(this).css("height"), 10);
	      
		if(width > maxSize) $(this).css({width: maxSize+"px", height: Math.round(height * (maxSize / width))+"px"});
	});
}

 // lnb 메뉴
$(function(){
	$("#lnb ul li span").click(function(){
		$("#lnb ul li").removeClass("on");
		$("#lnb ul li ul").hide();
		$(this).next("ul").show();
		$(this).parent("li").addClass("on");
	}); 
});
	

 //탭관련
$(function(){
	$(".tabCont").hide();
	$(".tabSt").next(".tabCont").show();
	$(".tabSt li a").click(function(){ 
		$(".tabSt li").removeClass("on");
		$(this).parent().addClass("on");
		$(".tabCont").hide();
		var activeTab = $(this).attr("href");
		$(activeTab).show();
		return false;
	});
});
//유통 홈 (실시간경매, 산지가격, 시황정보) 탭

$(function(){
	//$(".dsMainCt").hide();
	//$(".txtTab").next(".dsMainCt").show();
	$(".txtTab a").click(function(){ 
		$(".txtTab a").removeClass("on");
		$(this).addClass("on");
		//$(".dsMainCt").hide();
		//var activeTab = $(this).attr("href");
		//$(activeTab).show();
		//return false;
	});
});

function closeDsMainCt(){
	$(".wrapDsMainCt").toggle();
}
//옥담 EDU 강사소개 더보기
$(function(){
    var more = 0;
    $("#careerList .more").click(function(){
        if(more == 0){
            $("#careerList").addClass("open");
            $("#careerList .more").text("닫기");
            more = 1;
        }else{
            $("#careerList").removeClass("open");
            $("#careerList .more").text("+ 더보기");
            more = 0;
        }
        return false;
    });
});

//화면 크게/작게 버튼
$(function(){
	$("#txtLarge").on("click", function(){
		setZoomInOut("in");
	});
	
	$("#txtSmall").on("click", function(){
		setZoomInOut("out");
	});
});

// 화면 크게/작게
var currFFZoom = 1;
var currIEZoom = 100;
function setZoomInOut(inOut) {
	if (navigator.userAgent.indexOf('Firefox') != -1 && parseFloat(navigator.userAgent.substring(navigator.userAgent.indexOf('Firefox') + 8)) >= 3.6){//Firefox
		switch (inOut) {
		case "in":
			currFFZoom += 0.1;
			break;
		case "out":
			currFFZoom -= 0.1;
			break;
		}
		$('body').css('MozTransform','scale(' + currFFZoom + ')');
	} else {				
		switch (inOut) {
		case "in":
			currIEZoom += 10;
			break;
		case "out":
			currIEZoom -= 10;
			break;
		}
		$('body').css('zoom', ' ' + currIEZoom + '%');
	}			
}

// 즐겨찾기 추가
function bookmarksite(title,url) { 

   if (window.sidebar) // firefox 
		window.sidebar.addPanel(title, url, "");
	else if (window.opera && window.print)

	{ // opera 
		var elem = document.createElement('a');
		elem.setAttribute('href', url);
		elem.setAttribute('title', title);
		elem.setAttribute('rel', 'sidebar');
		elem.click();
	}
	else if (document.all) // ie
		window.external.AddFavorite(url, title);
}


/*
	바이트를 이용하여 substring 하기
	파리미터 : 앞에서부터 원하는 바이트만큼 자를 바이트
	리턴값 : 바이트만큼 잘라진 문자열
*/
function cutByte(pStr, pLen)
{
	var str = pStr;
	var len = 0;
	for(var i = 0; i<str.length; i++)
	{
		if(str.charCodeAt(i)>128)
		{
			tmp = 2;
		}
		else
		{
			tmp = 1;
		}
		
		len = len + tmp;
		if(len>pLen)
		{
			return str.substring(0, i) + "..." ;
		}
	}
	return str;
}

