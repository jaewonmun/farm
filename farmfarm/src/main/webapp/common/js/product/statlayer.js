
	var parentCode ="";
	var parentValue ="";
	/*
	 * 상위
	 */
	function back(){
		var dataCd = parentCode.split('|');
		var dataVal = parentValue.split(" ");
		dataCd.splice(dataCd.length,1);
		dataVal.splice(dataVal.length,1);
		
		if(dataCd.length >= 2){
			parentCode = dataCd[0];
			parentValue = dataVal[0];
			$(".txtRy").val(parentValue);
			//$("#parentCd").val(parentCode);
			selList(dataCd[0]);
		}else{
			parentCode = "";
			parentValue ="";
			$(".txtRy").val(parentValue);
			//$("#parentCd").val(parentCode);
			selList("", "T");
		}
	}
	/*
	 * 지역정보 셋팅
	 */
	function setStat(code , value){
		var dataCd = parentCode.split('|');
		var dataVal = parentValue.split(" ");
		if(parentCode == ""){
			parentCode = code;
			parentValue = value;
		}else{
			if(dataCd.length != 3){
				parentCode  = parentCode + "|" + code;
				parentValue = parentValue + " " + value;;
			}else{
				dataCd.splice(2,1, code);
				dataVal.splice(2,1,value);
				parentCode = dataCd[0] + "|" +	dataCd[1] + "|" + dataCd[2] ;
				parentValue = dataVal[0] + " " +	dataVal[1] + " " + dataVal[2] ;
			}
		}
		$(".txtRy").val(parentValue);
		//$("#parentCd").val(parentCode);
	}
	/*
	 * 하위 지역정보 가져오기
	 */
	function callListstat(code , value){
		setStat(code , value);
		var data = parentCode.split('|');
		if(data.length !=3){
			selList(code , "");
		}
	}	
	/*
	 * 부모창에 데이터 던짐
	 */
	function parentSetData(){
		var data = parentCode.split('|');
		if(data.length !=3){
			alert("지역을 모두 선택해 주세요.");
			return;
		}
		$("#statSpan").text(parentValue);
		$("#statHdn").val(parentCode);
//		$(".commonRayer").attr("style" , "display:none");
		$("#areaSelectLayer").attr("style" , "display:none");
		parentValue = "";
		parentCode = "";
		$(".txtRy").val("");
		//selList("", "T");
		searchLocalWeatherInfo(); // 각 페이지에서 함수 구현 필요
	}
	/**
	 * 메뉴 리스트 화면상에 뿌림 ( flag 가 T일경우엔 대메뉴(서울특별시 , 광주광역시 등등을 뿌림)
	 */
	function selList(code , flag){
		var url = "/product/stat.do";
		$.ajax({
			type:"POST" , 
			url: url,
			dataType: "json", 
			data:{
				code:code
			} ,
			success:function(data ){ 
				$('.ryTable > table > tbody').empty();
				if(data.dataList.length > 0){
					var htm = "<tr>";
					for(var i=0; i < data.dataList.length;i++){
						var tcnt =  (flag == 'T') ? i : i+1;//T는 대분류 값 가져올떄 사용
						if( tcnt != 1  &&  tcnt %4 == 0 ){
							htm +="</tr>";
						}
						var len = parseInt(data.dataList.length);
						len = len - 1;
						if((tcnt %4 == 0 ) && (tcnt  != len )){
							htm +="<tr>";
						}
						if(flag != "T"){
							if(tcnt == 1){
								htm += "<td style='background-color:#f5f8fd'><a href=\"javascript:back()\"><strong>상위</strong></a></td>";
							}
						}
						
						htm += "<td><a href=\"javascript:callListstat('"+data.dataList[i].code+"' , '"+data.dataList[i].value+"')\">"+data.dataList[i].value+"</a></td>";
					}
					htm+= "</tr>";
					$('.ryTable > table > tbody').html(htm);
				}
			},
			error:function(){
				alert("error");
			}
		});
	}




