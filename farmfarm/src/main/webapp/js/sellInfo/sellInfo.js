
var today = new Date();
var year = today.getFullYear();
var month = today.getMonth()+1;
var day = today.getDate();
var hours = today.getHours();
var minutes = today.getMinutes();
if(day < 10) {
	day = "0"+day;
}
var paramDate = year+""+month+""+day;
var dialog;
//디폴트는 사과페이지임 (페이지 처음 띄웠을때 사과정보 보여줌 select를 통해 다른작물으로 변경)
$(function(){
	/*dialog = $( "#dialog" ).dialog({
	      height: 250,
	      width: 500
	    });
	dialog.dialog("open");*/
	goMainChange("070299");
	//dialog.dialog("close");
});
//함수!
function goMainChange(obj) {
	
	var yesterday1 = "";
	var yesterday2 = "";
	/* 어제 오늘 데이터를 미리 호출 */
	if(typeof obj  == "string" || typeof obj  == "number" ) {
		yesterday1 = returnAvg1(obj);
		yesterday2 = returnAvg2(obj);
	}else{
		yesterday1 = returnAvg1(obj.value);
		yesterday2 = returnAvg2(obj.value);
	}
	
	/*------------------------------*/
	
	var apiKey = "4f52e6c2d4ffb5e17973b62d813b6d74d81d91b";
	var urlOkdap  = "http://openapi.okdab.com/price/realtime/pricexml_search_action.jsp?";
	urlOkdap +=	"key=" + apiKey;
	urlOkdap += "&date=" + paramDate;
	if(typeof obj  == "string" || typeof obj  == "number" ) {
		urlOkdap += "&scode=" + obj;
	}else{
		urlOkdap += "&scode=" + obj.value;
	}
	//console.log(urlOkdap);
	/* ------------------------- 오늘 경매 정보-----------------------------------------------------------------------------------*/
	$.ajax({
		url: "../callback/sellInfo_callback.jsp",			// 넘길 주소(위치)
		data: { queryString : urlOkdap },
		dataType: "html",
		async: false
	}).done(function(res) {
		//console.log(res); 
		var parser, xmlDoc;
		parser = new DOMParser();							// xml DOM 을 위해서 파싱
		xmlDoc = parser.parseFromString(res,"text/xml");

		var count = xmlDoc.getElementsByTagName("count")[0].childNodes[0].nodeValue;	// 조회 건수를 가져온다
		if(count == 0) {																// 겨울에 복숭아가 없을때도 있어서 넣은 처리
			alert("최근 경매 기록이 없습니다.");
		}

		var itemName = xmlDoc.getElementsByTagName("mclassname")[0].innerHTML;									// 품목이름

		var result = xmlDoc.getElementsByTagName("result");													// 가격정보 배열

		var pricePerKg = new Array();																			// 배열 선언
		for(var i=0; i<result.length; i++) {																	// 최대가격, 최소가격 찾기
			var price = parseInt(result[i].getElementsByTagName("price")[0].childNodes[0].nodeValue);	// 가격 배열
			var kg = parseInt(result[i].getElementsByTagName("unitname")[0].childNodes[0].nodeValue);	// 단위 배열

			//console.log(parseInt(price/kg));
			pricePerKg[i] = parseInt(price / kg);							// 가격나누기 단위 해서 단가 구하기
		}
		var max=0, min =0 ;
		for(var i=0; i<pricePerKg.length; i++) {
			if(pricePerKg[i] < pricePerKg[i+1]) {				// 최대값 찾는 루프 
				max = pricePerKg[i+1];
			}
		}
		for(var i=0; i<pricePerKg.length; i++) {
			if(pricePerKg[i] > pricePerKg[i+1]) {				// 최소값 찾는 루프 
				min = pricePerKg[i+1];
			}
		}
		var sum = 0, avg = 0;
		for(var i=0; i<pricePerKg.length; i++) {
			sum  = sum + pricePerKg[i];
		}
		avg = parseInt(sum/count);								// 평균 구함
		var sumProduct = 0;
		for(var i=0; i<result.length; i++) {
			sumProduct = sumProduct+ parseInt(result[i].getElementsByTagName("sumamt")[0].childNodes[0].nodeValue);
		}

		// 거래가 많이된 시장 top5 구하기
		var maketname = [];
		for(var i=0; i< result.length; i++) {
			var temp = result[i].getElementsByTagName("marketname")[0].childNodes[0].nodeValue;
			if(maketname[temp] == undefined){
				maketname[temp] = 0;
			}
			maketname[temp]++;
		}
		var makenameSort = [];
		for(var abc in maketname) {
			makenameSort.push({'maketname':abc,'count':maketname[abc]});
		}

		makenameSort.sort(function(a,b){ 
			return Number(b.count) - Number(a.count);
		});
		//console.log(makenameSort[0].count);
		var top5 = "";
		if(makenameSort.length < 5){
			for(var i=0; i<makenameSort.length; i++) {
				top5 += "<li class='rank1'><strong class='market'>" + makenameSort[i].maketname + "</strong><span class='volume'>" + makenameSort[i].count + "건</span></li>";
			}
		}
		else {
			for(var i=0; i<5; i++) {
				top5 += "<li class='rank1'><strong class='market'>" + makenameSort[i].maketname + "</strong><span class='volume'>" + makenameSort[i].count + "건</span></li>";
			}
		}
		// 물품 리스트 테이블 형태 출력을 위함
		var itemList = "";
		if(result.length < 10) {
			for(var i=0; i<result.length; i++) {
				var bidtime =  result[i].getElementsByTagName("bidtime")[0].childNodes[0].nodeValue;
				var mclassname =  result[i].getElementsByTagName("mclassname")[0].childNodes[0].nodeValue;
				var unitname =  result[i].getElementsByTagName("unitname")[0].childNodes[0].nodeValue;
				var price =  result[i].getElementsByTagName("price")[0].childNodes[0].nodeValue;
				var sumamt =  result[i].getElementsByTagName("sumamt")[0].childNodes[0].nodeValue;
				var marketname =  result[i].getElementsByTagName("marketname")[0].childNodes[0].nodeValue;
				var coname =  result[i].getElementsByTagName("coname")[0].childNodes[0].nodeValue;
				var sanji =  result[i].getElementsByTagName("sanji")[0].childNodes[0].nodeValue;

				itemList += "<tr class='tdLineList'>" +
				"<td class='leftNone'>"+ bidtime +
				"<td>" + mclassname + "</td>" +
				"<td>" + unitname + "</td>" +
				"<td class='subjectRt'>" + price + "</td>" +
				"<td class='subjectRt'>"+ sumamt +"</td>" +
				"<td>"+ marketname +"</td>" +
				"<td>" + coname + "</td>" +
				"<td>" + sanji + "</td>" +
				"<td class='rightNone'>경매</td>" +
				"</tr>"
			}
		}
		else {
			for(var i=0; i<10; i++) {
				var bidtime =  result[i].getElementsByTagName("bidtime")[0].childNodes[0].nodeValue;
				var mclassname =  result[i].getElementsByTagName("mclassname")[0].childNodes[0].nodeValue;
				var unitname =  result[i].getElementsByTagName("unitname")[0].childNodes[0].nodeValue;
				var price =  result[i].getElementsByTagName("price")[0].childNodes[0].nodeValue;
				var sumamt =  result[i].getElementsByTagName("sumamt")[0].childNodes[0].nodeValue;
				var marketname =  result[i].getElementsByTagName("marketname")[0].childNodes[0].nodeValue;
				var coname =  result[i].getElementsByTagName("coname")[0].childNodes[0].nodeValue;
				var sanji =  result[i].getElementsByTagName("sanji")[0].childNodes[0].nodeValue;

				itemList += "<tr class='tdLineList'>" +
				"<td class='leftNone'>"+ bidtime +
				"<td>" + mclassname + "</td>" +
				"<td>" + unitname + "</td>" +
				"<td class='subjectRt'>" + price + "</td>" +
				"<td class='subjectRt'>"+ sumamt +"</td>" +
				"<td>"+ marketname +"</td>" +
				"<td>" + coname + "</td>" +
				"<td>" + sanji + "</td>" +
				"<td class='rightNone'>경매</td>" +
				"</tr>"
			}
		}
		
		/* ----------------------------------------   차트 그리기  ------------------------------------------------ */
		var maxmin2 = yesterday2.split(',');	// 2일전
		var maxmin1 = yesterday1.split(',');	// 1일전
		//console.log(maxmin2[0]);
		//console.log(maxmin2[1]);
		//console.log(maxmin1[0]);
		//console.log(maxmin1[1]);
		//console.log(max);
		//console.log(min);
		//  Nwagon 에서 제공하는 형식
		var options = {
				'legend':{
					names: ['2일전', '어제', '오늘'],
					hrefs: []
				},
				'dataset':{
					title:'평균 가격(price/kg)',
					values: [[Number(maxmin2[0]),Number(maxmin2[1])],
					         [Number(maxmin1[0]),Number(maxmin1[1])],
					         [Number(max),Number(min)]],
					colorset: ['#30a1ce','#FF8C00'],
					fields:['최고가','최저가']
				},
				'chartDiv' : 'Nwagon',
				'chartType' : 'line',
				'chartSize' : {width:450, height:230},
				'minValue' : 0,
				'maxValue' : Number(maxmin2[0]) * 2,
				'increment' : 3000,
				'isGuideLineNeeded' : true  //default set to false
		};
		$("#Nwagon").html("");
		Nwagon.chart(options);
		/* ---------------------------------   고생했다 여기서 부터 태그에 값 대입!!!   ----------------------------- */
		$("#itemName").html(itemName);
		$("#itemNameSub").html("이름 <span>" + itemName +"</span>");
		$("#itemNameTop5").html(itemName + "<span id='top5Name'>실시간경매</span> 거래량 top5")
		$("#avgPrice").html("평균가 <span>" + avg +"</span>(모든규격)");				// 평균값 표시
		$("#mainPrice").html(avg);														// 평균값 표시
		$("#sumPrice").html("거래량 <span>" + sumProduct +"</span>(모든규격)");		// 거래량 표시
		$("#maxPrice").html("최고가 <span>" + max +"</span>(보통)");					// 최대값 표시
		$("#minPrice").html("최저가 <span>" + min +"</span>(보통)");					// 최소값 표시
		$("#tradeAllavg").html(count + "건");											// 거래건수 표시
		$("#top5Maket").html(top5);													// top5 거래시장 표시
		$("#itemList").html(itemList);
		
		dialog.dialog("close");
	});	// done 함수 끝



/* ------------------------- 2일전 경매 정보-----------------------------------------------------------------------------------*/
}
/* ------------------------- 어제 경매 정보-----------------------------------------------------------------------------------*/
function returnAvg1(obj){

	var today = new Date();
	today.setTime(new Date().getTime() - (1 * 24 * 60 * 60 * 1000)); 
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	var day = today.getDate();
	var hours = today.getHours();
	var minutes = today.getMinutes();
	if(day < 10) {
		day = "0"+day;
	}
	var paramDate = year+""+month+""+day;
	
	var apiKey = "4f52e6c2d4ffb5e17973b62d813b6d74d81d91b";
	var urlOkdap  = "http://openapi.okdab.com/price/realtime/pricexml_search_action.jsp?";
	urlOkdap +=	"key=" + apiKey;
	urlOkdap += "&date=" + paramDate;
	if(typeof obj  == "string" || typeof obj  == "number" ) {
		urlOkdap += "&scode=" + obj;
	}else{
		urlOkdap += "&scode=" + obj.value;
	}

	
	var max=0, min =0 ;
	$.ajax({
		url: "../callback/sellInfo_callback.jsp",// 넘길 주소(위치)
		async: false,
		data: { queryString : urlOkdap },
		dataType: "html"
	}).done(function(res) {
		//console.log(res); 
		var parser, xmlDoc;
		parser = new DOMParser();							// xml DOM 을 위해서 파싱
		xmlDoc = parser.parseFromString(res,"text/xml");
	

	var count = xmlDoc.getElementsByTagName("count")[0].childNodes[0].nodeValue;
	var result = xmlDoc.getElementsByTagName("result");													// 가격정보 배열

	var pricePerKg = new Array();																			// 배열 선언
	for(var i=0; i<result.length; i++) {																	// 최대가격, 최소가격 찾기
		var price = parseInt(result[i].getElementsByTagName("price")[0].childNodes[0].nodeValue);	// 가격 배열
		var kg = parseInt(result[i].getElementsByTagName("unitname")[0].childNodes[0].nodeValue);	// 단위 배열

		//console.log(parseInt(price/kg));
		pricePerKg[i] = parseInt(price / kg);							// 가격나누기 단위 해서 단가 구하기
	}
	for(var i=0; i<pricePerKg.length; i++) {
		if(pricePerKg[i] < pricePerKg[i+1]) {				// 최대값 찾는 루프 
			max = pricePerKg[i+1];
		}
	}
	for(var i=0; i<pricePerKg.length; i++) {
		if(pricePerKg[i] > pricePerKg[i+1]) {				// 최소값 찾는 루프 
			min = pricePerKg[i+1];
		}
	}
	//console.log(max +","+ min);
	});
	return max +","+ min;
}


function returnAvg2(obj){

	var today = new Date();
	today.setTime(new Date().getTime() - (2 * 24 * 60 * 60 * 1000) );
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	var day = today.getDate();
	var hours = today.getHours();
	var minutes = today.getMinutes();
	if(day < 10) {
		day = "0"+day;
	}
	var paramDate = year+""+month+""+day;
	
	var apiKey = "4f52e6c2d4ffb5e17973b62d813b6d74d81d91b";
	var urlOkdap  = "http://openapi.okdab.com/price/realtime/pricexml_search_action.jsp?";
	urlOkdap +=	"key=" + apiKey;
	urlOkdap += "&date=" + paramDate;
	if(typeof obj  == "string" || typeof obj  == "number" ) {
		urlOkdap += "&scode=" + obj;
	}else{
		urlOkdap += "&scode=" + obj.value;
	}

	var max=0, min =0 ;
	$.ajax({
		url: "../callback/sellInfo_callback.jsp",// 넘길 주소(위치)
		async: false,
		data: { queryString : urlOkdap },
		dataType: "html"
	}).done(function(res) {
		//console.log(res); 
		var parser, xmlDoc;
		parser = new DOMParser();							// xml DOM 을 위해서 파싱
		xmlDoc = parser.parseFromString(res,"text/xml");
	

	var count = xmlDoc.getElementsByTagName("count")[0].childNodes[0].nodeValue;
	var result = xmlDoc.getElementsByTagName("result");													// 가격정보 배열

	var pricePerKg = new Array();																			// 배열 선언
	for(var i=0; i<result.length; i++) {																	// 최대가격, 최소가격 찾기
		var price = parseInt(result[i].getElementsByTagName("price")[0].childNodes[0].nodeValue);	// 가격 배열
		var kg = parseInt(result[i].getElementsByTagName("unitname")[0].childNodes[0].nodeValue);	// 단위 배열

		//console.log(parseInt(price/kg));
		pricePerKg[i] = parseInt(price / kg);							// 가격나누기 단위 해서 단가 구하기
	}
	for(var i=0; i<pricePerKg.length; i++) {
		if(pricePerKg[i] < pricePerKg[i+1]) {				// 최대값 찾는 루프 
			max = pricePerKg[i+1];
		}
	}
	for(var i=0; i<pricePerKg.length; i++) {
		if(pricePerKg[i] > pricePerKg[i+1]) {				// 최소값 찾는 루프 
			min = pricePerKg[i+1];
		}
	}
	//console.log(max +","+ min);
	});
	return max +","+ min;
}