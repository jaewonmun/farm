function realTimeWeather() {
	var today = new Date();
	var week = new Array('일','월','화','수','목','금','토');
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	var day = today.getDate();
	var hours = today.getHours();
	var minutes = today.getMinutes();
	/*
	 * 기상청 30분마다 발표
	 * 30분보다 작으면, 한시간 전 hours 값
	 */
	if(minutes < 30){
		hours = hours - 1;
		if(hours < 0){
			// 자정 이전은 전날로 계산
			today.setDate(today.getDate() - 1);
			day = today.getDate();
			month = today.getMonth()+1;
			year = today.getFullYear();
			hours = 23;
		}
	}

	/* example
	 * 9시 -> 09시 변경 필요
	 */

	if(hours < 10) {
		hours = '0'+hours;
	}
	if(month < 10) {
		month = '0' + month;
	}    
	if(day < 10) {
		day = '0' + day;
	} 

	today = year+""+month+""+day;
	console.log( hours + "00");
	/* 좌표 */
	var _nx = 75, 
	_ny = 127,
	
	apikey = "mBBgaqRFX9y%2FxTGc4qkh1dYEi1hirtBVpfNsZwq0Nav1iRRPPceX6rLGKdvC9oNYFTdixqNVbkk3F%2FqPPfiOZQ%3D%3D",    
	ForecastGribURL = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastGrib";
	ForecastGribURL += "?ServiceKey=" + apikey;
	ForecastGribURL += "&base_date=" + today;
	ForecastGribURL += "&base_time=" + hours + "00";
	ForecastGribURL += "&nx=" + _nx + "&ny=" + _ny;
	ForecastGribURL += "&pageNo=1&numOfRows=7";
	ForecastGribURL += "&_type=json";
	

	$.ajax({
		url: ForecastGribURL
		,type: 'get'
			,success: function(msg) {
				var text = msg.responseText,
				text = text.replace(/(<([^>]+)>)/ig,""); //HTML 태그 모두 공백으로 대체
				text = '[' + text + ']';
				var json = $.parseJSON(text);
				var rain_state = json[0].response.body.items.item[1].obsrValue;
				var rain = json[0].response.body.items.item[3].obsrValue;
				var sky = json[0].response.body.items.item[4].obsrValue;
				var temperature = json[0].response.body.items.item[5].obsrValue;

				$('#todayTemp').html(temperature.toFixed(1) + " ℃");
				$('#todayRN').html("시간당강수량 : "+ rain +"mm");

				if(rain_state != 0) {
					switch(rain_state) {
					case 1:
						$('#todayStatus').html("비");
						break;
					case 2:
						$('#todayStatus').html("비/눈");
						break;
					case 3:
						$('#todayStatus').html("눈");
						break;
					}
				}else {
					switch(sky) {
					case 1:
						$('#todayStatus').html("맑음");
						break;
					case 2:
						$('#todayStatus').html("구름조금");
						break;
					case 3:
						$('#todayStatus').html("구름많음");
						break;
					case 4:
						$('#todayStatus').html("흐림");    
						break;
					}    
				} //if 종료
			} //success func 종료
	})    
}