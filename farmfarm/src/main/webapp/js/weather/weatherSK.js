
// 완료되면 좌표 정보는 여기서 전역변수로 쓸것. (사용자에 따라 다른지역 날씨 호출)


$(function(){
	var lon = "128.7607121565847";
	var lat = "35.8495347823333";
	var loc = "<c:out value='${loginInfo.region}'/>";
	var locArray = loc.split(',');
	var id = "<c:out value='${loginInfo.mbrId}'/>";
	console.log(id);
	console.log(locArray);
	if(id != "") {
		lon = locArray[1];
		lat = locArray[0];
	}
	/* ------------------------------ 현재날씨 ajax 호출 ------------------------------------ */
	   
	var	todayURL = " http://apis.skplanetx.com/weather/current/hourly?";
		todayURL += "lon=" +lon;
		todayURL += "&lat="+ lat;
		todayURL += "&version=1";
	$.ajax({
		url: todayURL
		,headers : {appkey : 'ff308355-6d4f-3e6a-80c2-730c7ce5c669'}
		,type: 'get'
			,success: function(msg) {
				/* dom 따라서 변수에 저장 */
	/*주소*/	var address = msg.weather.hourly[0].grid.city + " "+ msg.weather.hourly[0].grid.county + " " +msg.weather.hourly[0].grid.village;
	/*시간*/	var time = msg.weather.hourly[0].timeRelease;
	/*기상*/	var skyName = msg.weather.hourly[0].sky.name;
	/*코드*/	var skyCode = msg.weather.hourly[0].sky.code;
	/*특보*/	var alertYn = msg.common.alertYn;
	/*태풍*/	var stormYn = msg.common.stormYn;
	/*최소*/	var tmin = msg.weather.hourly[0].temperature.tmin;
	/*최대*/	var tmax = msg.weather.hourly[0].temperature.tmax;
	/*현재*/	var tc = msg.weather.hourly[0].temperature.tc;
	/*풍향*/	var wdir = msg.weather.hourly[0].wind.wdir;
	/*풍속*/	var wspd = msg.weather.hourly[0].wind.wspd;
	/*강수*/	var type = msg.weather.hourly[0].precipitation.type;
/*누적강수*/	var raindrop = msg.weather.hourly[0].precipitation.sinceOntime;
				
				/* html에 적용하기 */
				// 사진고르기
				var weatherImage = selectImage(skyCode);
				var typeDay = selectType(type);
				
				var weatherTitle = "<b style='color:#0099ff;' >현재날씨</b>&nbsp;";
				weatherTitle += "<b>주소</b><span>" + address + "</span>&nbsp;";
				weatherTitle += "<b>발표</b><span>" + time + "</span>&nbsp;";
				weatherTitle += "<b>태풍</b><span>" + stormYn + "&nbsp;<b>특보</b><span>" + alertYn + "</span>";
				$("#weatherTitle").html(weatherTitle);
				
				var dayWt01_1  = "<image class='dayImage' src="+ weatherImage + "><br>";
					dayWt01_1 += "<b>현재온도</b><span style='color:red'><b> " + tc + "℃ </b></span>";
				$("#dayWt01_1").html(dayWt01_1);
				
				var dayWt01_2 = "<b>최소</b><span>" + tmin + "℃&nbsp;<b>최대</b><span>" + tmax + "℃</span> <br>";
					dayWt01_2 += "<b>강수형태</b><span>" + typeDay +"</span> <br>";
					dayWt01_2 += "<b>강수량</b><span>" + raindrop + "</span> <br>";
					dayWt01_2 += "<b>풍향</b><span><image src='../images/makeImage/weather/wind.png' style='width:25px; height:25px; transform: rotate(" + wdir + "deg);'></span>";
					dayWt01_2 += "<b>풍속</b><span>" + wspd +"m/s</span>";
				$("#dayWt01_2").html(dayWt01_2);

				

			}
	});
	/* ------------------------------ 내일날씨 ajax 호출 ------------------------------------*/
	var	weekURL = "http://apis.skplanetx.com/weather/summary?";
	weekURL += "lon=" +lon;
	weekURL += "&lat="+ lat;
	weekURL += "&version=1";

	$.ajax({
		url: weekURL
		,headers : {appkey : 'ff308355-6d4f-3e6a-80c2-730c7ce5c669'}
	,type: 'get'
		,success: function(msg) {
			var skyName = msg.weather.summary[0].tomorrow.sky.name;
			var skyCode = msg.weather.summary[0].tomorrow.sky.code;
			var tmax = msg.weather.summary[0].tomorrow.temperature.tmax;
			var tmin = msg.weather.summary[0].tomorrow.temperature.tmin;
			var skyCode =selectImageTomorrow(skyCode);
			
			var dayWt01_3 =  "<b>내일날씨</b><br>";
				dayWt01_3 +=  "<image class='tomorrowImage' src="+ skyCode + "><br>";
				dayWt01_3 += "<span class='weekweekWt02'>"+ skyName +"</span><br>";
				dayWt01_3 += "<span class='weekweekWt02'>"+ tmin +"℃</span>/" + tmax + "℃";
			$("#dayWt01_3").html(dayWt01_3);
		}
	});

	/* ------------------------------ 주간날씨 ajax 호출 ------------------------------------*/   
	var	weekURL = "http://apis.skplanetx.com/weather/forecast/6days?";
		weekURL += "lon=" +lon;
		weekURL += "&lat="+ lat;
		weekURL += "&version=1";

	$.ajax({
		url: weekURL
		,headers : {appkey : 'ff308355-6d4f-3e6a-80c2-730c7ce5c669'}
		,type: 'get'
			,success: function(msg) {
				//console.log(msg);
/*2일후오전*/	var amCode2day = msg.weather.forecast6days[0].sky.amCode2day;
/*오후*/		var pmCode2day =  msg.weather.forecast6days[0].sky.pmCode2day;
/*최고*/		var tmax2day =  msg.weather.forecast6days[0].temperature.tmax2day;
/*최저*/		var tmin2day =  msg.weather.forecast6days[0].temperature.tmin2day;
/*3일후*/		var amCode3day = msg.weather.forecast6days[0].sky.amCode3day;
				var pmCode3day =  msg.weather.forecast6days[0].sky.pmCode3day;
				var tmax3day =  msg.weather.forecast6days[0].temperature.tmax3day;
				var tmin3day =  msg.weather.forecast6days[0].temperature.tmin3day;
/*4일후*/		var amCode4day = msg.weather.forecast6days[0].sky.amCode4day;
				var pmCode4day =  msg.weather.forecast6days[0].sky.pmCode4day;
				var tmax4day =  msg.weather.forecast6days[0].temperature.tmax4day;
				var tmin4day =  msg.weather.forecast6days[0].temperature.tmin4day;
/*5일후*/		var amCode5day = msg.weather.forecast6days[0].sky.amCode5day;
				var pmCode5day =  msg.weather.forecast6days[0].sky.pmCode5day;
				var tmax5day =  msg.weather.forecast6days[0].temperature.tmax5day;
				var tmin5day =  msg.weather.forecast6days[0].temperature.tmin5day;
/*6일후*/		var amCode6day = msg.weather.forecast6days[0].sky.amCode6day;
				var pmCode6day =  msg.weather.forecast6days[0].sky.pmCode6day;
				var tmax6day =  msg.weather.forecast6days[0].temperature.tmax6day;
				var tmin6day =  msg.weather.forecast6days[0].temperature.tmin6day;
/*7일후*/		var amCode7day = msg.weather.forecast6days[0].sky.amCode7day;
				var pmCode7day =  msg.weather.forecast6days[0].sky.pmCode7day;
				var tmax7day =  msg.weather.forecast6days[0].temperature.tmax7day;
				var tmin7day =  msg.weather.forecast6days[0].temperature.tmin7day;
/*관측 시간*/	var time = msg.weather.forecast6days[0].timeRelease;
				
				// html에 적용하기
				//사진 고르기
				amCode2day = selectImageWeek(amCode2day);
				pmCode2day = selectImageWeek(pmCode2day);
				var week2day =  "<span class='weekWt'>오전</span>";
					week2day +=	"<span class='weekWt'>오후</span><br>";
					week2day += "<img class='weekImage' src=" + amCode2day + ">";
					week2day += "<img class='weekImage' src=" + pmCode2day + ">";
					week2day += "<hr>";
					week2day += "<span class='weekweekWt02'>"+ tmin2day +"℃</span>/" + tmax2day + "℃";
				$("#week2day").html(week2day);
				
				amCode3day = selectImageWeek(amCode3day);
				pmCode3day = selectImageWeek(pmCode3day);
				var week3day =  "<span class='weekWt'>오전</span>";
					week3day +=	"<span class='weekWt'>오후</span><br>";
					week3day += "<img class='weekImage' src=" + amCode3day + ">";
					week3day += "<img class='weekImage' src=" + pmCode3day + ">";
					week3day += "<hr>";
					week3day += "<span class='weekweekWt02'>"+ tmin3day +"℃</span>/" + tmax3day + "℃";
				$("#week3day").html(week3day);
				
				amCode4day = selectImageWeek(amCode4day);
				pmCode4day = selectImageWeek(pmCode4day);
				var week4day =  "<span class='weekWt'>오전</span>";
					week4day +=	"<span class='weekWt'>오후</span><br>";
					week4day += "<img class='weekImage' src=" + amCode4day + ">";
					week4day += "<img class='weekImage' src=" + pmCode4day + ">";
					week4day += "<hr>";
					week4day += "<span class='weekweekWt02'>"+ tmin4day +"℃</span>/" + tmax4day + "℃";
				$("#week4day").html(week4day);
				
				amCode5day = selectImageWeek(amCode5day);
				pmCode5day = selectImageWeek(pmCode5day);
				var week5day =  "<span class='weekWt'>오전</span>";
					week5day +=	"<span class='weekWt'>오후</span><br>";
					week5day += "<img class='weekImage' src=" + amCode5day + ">";
					week5day += "<img class='weekImage' src=" + pmCode5day + ">";
					week5day += "<hr>";
					week5day += "<span class='weekweekWt02'>"+ tmin5day +"℃</span>/" + tmax5day + "℃";
				$("#week5day").html(week5day);
				
				amCode6day = selectImageWeek(amCode6day);
				pmCode6day = selectImageWeek(pmCode6day);
				var week6day =  "<span class='weekWt'>오전</span>";
					week6day +=	"<span class='weekWt'>오후</span><br>";
					week6day += "<img class='weekImage' src=" + amCode6day + ">";
					week6day += "<img class='weekImage' src=" + pmCode6day + ">";
					week6day += "<hr>";
					week6day += "<span class='weekweekWt02'>"+ tmin6day +"℃</span>/" + tmax6day + "℃";
				$("#week6day").html(week6day);
				
				amCode7day = selectImageWeek(amCode7day);
				pmCode7day = selectImageWeek(pmCode7day);
				var week7day =  "<span class='weekWt'>오전</span>";
					week7day +=	"<span class='weekWt'>오후</span><br>";
					week7day += "<img class='weekImage' src=" + amCode2day + ">";
					week7day += "<img class='weekImage' src=" + pmCode2day + ">";
					week7day += "<hr>";
					week7day += "<span class='weekweekWt02'>"+ tmin7day +"℃</span>/" + tmax7day + "℃";
				$("#week7day").html(week7day);
				
				// 차트 그리기
				var options = {
						'legend':{
							names: ['+2day', '+3day', '+4day','+5day','+6day','+7day',],
							hrefs: []
						},
						'dataset':{
							title:'주간 온도',
							values: [ [Number(tmax2day),Number(tmin2day)],
							          [Number(tmax3day),Number(tmin3day)],
							          [Number(tmax4day),Number(tmin4day)],
							          [Number(tmax5day),Number(tmin5day)],
							          [Number(tmax6day),Number(tmin6day)],
							          [Number(tmax7day),Number(tmin7day)]
									],
							colorset: ['#30a1ce','#FF8C00'],
							fields:['최고온도','최저온도']
						},
						'chartDiv' : 'Nwagon',
						'chartType' : 'line',
						'chartSize' : {width:730, height:150},
						'minValue' : -10,
						'maxValue' : 40,
						'increment' : 10,
						'isGuideLineNeeded' : true  //default set to false
				};
				Nwagon.chart(options);
			}	
	});
});

// 기상코드에 따라서 알맞은 이미지를 찾아주는 함수 (현재날씨 api)
function selectImage(skyCode) {
	switch(skyCode) {
	case 'SKY_O00':
		return "'../images/makeImage/weatherSK/38.png'";
		break;
	case 'SKY_O01':
		return "'../images/makeImage/weatherSK/01.png'";
		break;
	case 'SKY_O02':
		return "'../images/makeImage/weatherSK/02.png'";
		break;
	case 'SKY_O03':
		return "'../images/makeImage/weatherSK/03.png'";
		break;
	case 'SKY_O04':
		return "'../images/makeImage/weatherSK/12.png'";
		break;
	case 'SKY_O05':
		return "'../images/makeImage/weatherSK/13.png'";
		break;
	case 'SKY_O06':
		return "'../images/makeImage/weatherSK/14.png'";
		break;
	case 'SKY_O07':
		return "'../images/makeImage/weatherSK/18.png'";
		break;
	case 'SKY_O08':
		return "'../images/makeImage/weatherSK/21.png'";
		break;
	case 'SKY_O09':
		return "'../images/makeImage/weatherSK/32.png'";
		break;
	case 'SKY_O10':
		return "'../images/makeImage/weatherSK/4.png'";
		break;
	case 'SKY_O11':
		return "'../images/makeImage/weatherSK/29.png'";
		break;
	case 'SKY_O12':
		return "'../images/makeImage/weatherSK/26.png'";
		break;
	case 'SKY_O13':
		return "'../images/makeImage/weatherSK/27.png'";
		break;
	case 'SKY_O14':
		return "'../images/makeImage/weatherSK/28.png'";
		break;
	}
}
function selectType(type) {
	switch(Number(type)) {
	case 0:
		return "현상없음";
		break;
	case 1:
		return "비";
		break;
	case 2:
		return "눈/비";
		break;
	case 3:
		return "눈";
		break;
	}
}
//기상코드에 따라서 알맞은 이미지를 찾아주는 함수 (내일날씨 api)
function selectImageTomorrow(skyCode) {
	switch(skyCode) {
	case 'SKY_M01':
		return "'../images/makeImage/weatherSK/01.png'";
		break;
	case 'SKY_M02':
		return "'../images/makeImage/weatherSK/02.png'";
		break;
	case 'SKY_M03':
		return "'../images/makeImage/weatherSK/03.png'";
		break;
	case 'SKY_M04':
		return "'../images/makeImage/weatherSK/19.png'";
		break;
	case 'SKY_M05':
		return "'../images/makeImage/weatherSK/21.png'";
		break;
	case 'SKY_M06':
		return "'../images/makeImage/weatherSK/31.png'";
		break;
	case 'SKY_M07':
		return "'../images/makeImage/weatherSK/28.png'";
		break;
	}
}


//기상코드에 따라서 알맞은 이미지를 찾아주는 함수 (중기예보 api)
function selectImageWeek(skyCode) {
	switch(skyCode) {
	case 'SKY_W00':
		return "'../images/makeImage/weatherSK/38.png'";
		break;
	case 'SKY_W01':
		return "'../images/makeImage/weatherSK/01.png'";
		break;
	case 'SKY_W02':
		return "'../images/makeImage/weatherSK/02.png'";
		break;
	case 'SKY_W03':
		return "'../images/makeImage/weatherSK/03.png'";
		break;
	case 'SKY_W04':
		return "'../images/makeImage/weatherSK/18.png'";
		break;
	case 'SKY_W07':
		return "'../images/makeImage/weatherSK/21.png'";
		break;
	case 'SKY_W09':
		return "'../images/makeImage/weatherSK/12.png'";
		break;
	case 'SKY_W10':
		return "'../images/makeImage/weatherSK/21.png'";
		break;
	case 'SKY_W11':
		return "'../images/makeImage/weatherSK/04.png'";
		break;
	case 'SKY_W12':
		return "'../images/makeImage/weatherSK/13.png'";
		break;
	case 'SKY_W13':
		return "'../images/makeImage/weatherSK/32.png'";
		break;
	}
}
