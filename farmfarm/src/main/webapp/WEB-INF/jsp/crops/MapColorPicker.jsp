<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>


<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<style>
#divpreview {
	border: 1px solid #e3e3e3;
	width: 80px;
	height: 20px;
	margin: auto;
	visibility: hidden;
}

#selectedcolor {
	border: 1px solid #e3e3e3;
	width: 80%;
	height: 300px;
	margin: auto;
}
</style>
<script>

function clickColor(hex, seltop, selleft, html5) {
    var c, cObj, colormap, areas, i, areacolor, cc;
    if (html5 && html5 == 5)  {
        
    } else {
        
        } else {
            
        }
    }
    document.getElementById("colornamDIV").innerHTML = (cObj.toName() || "");
    document.getElementById("colorhexDIV").innerHTML = cObj.toHexString();
    document.getElementById("colorrgbDIV").innerHTML = cObj.toRgbString();
    document.getElementById("colorhslDIV").innerHTML = cObj.toHslString();    
    




</script>

</head>
<body>

<form id="frm" action="action.jsp">
    <p>색상 입력:</p>
    <div><input type="color" id="usercolor" name="usercolor" value="#ff9999"></div>
    <div><input type="submit" value="전송"></div>
</form>


	<div class="w3-col l4 m12" style="text-align: center;">


		<div id="selectedhexagon"
			style="visibility: visible; position: relative; width: 21px; height: 21px; background-image: url(&quot;img_selectedcolor.gif&quot;); top: -125px; left: 45px;"></div>
		<div id="divpreview"
			style="visibility: hidden; background-color: rgb(255, 0, 0);">&nbsp;</div>

		<br>
		<div id="html5DIV">
			<h3>Or Use HTML5:</h3>
			<input type="color" id="html5colorpicker"
				onchange="clickColor(0, -1, -1, 5)" value="#ff0000"
				style="width: 85%;">
		</div>
		<br> <br>
	</div>


	<div id="huecontainer" style="text-align: center;">
		<h3>색 선택</h3>
		<div class="w3-responsive">
			<table class="w3-table-all colorTable"
				style="width: 100%; white-space: nowrap; font-size: 14px;">
				<tbody>
					<tr>
						<td style="width: 150px;"></td>
						<td style="text-align: right; text-transform: capitalize;">색상&nbsp;</td>
						<td>Hex</td>
					</tr>
					<tr>
						<td style="cursor : pointer; background-color: #ff9999"
							onclick="clickColor(&quot;#ff9999&quot;)"></td>
						<td style="text-align: right;">라이트레드&nbsp;</td>
						<td>#ff9999</td>
					</tr>
					<tr>
						<td style="cursor : pointer; background-color: #ffcc99"
							onclick="clickColor(&quot;#ffcc99&quot;)"></td>
						<td style="text-align: right;">딥 피치&nbsp;</td>
						<td>#ffcc99</td>
					</tr>
					<tr>
						<td style="cursor : pointer; background-color: #ffe699"
							onclick="clickColor(&quot;#ffe699&quot;)"></td>
						<td style="text-align: right;">피치&nbsp;</td>
						<td>#ffe699</td>
					</tr>
					<tr>
						<td style="cursor : pointer; background-color: #ffff99"
							onclick="clickColor(&quot;#ffff99&quot;)"></td>
						<td style="text-align: right;">엘로우&nbsp;</td>
						<td>#ffff99</td>
					</tr>
					<tr>
						<td style="cursor : pointer; background-color: #ccff99"
							onclick="clickColor(&quot;#ccff99&quot;)"></td>
						<td style="text-align: right;">그린&nbsp;</td>
						<td>#ccff99</td>
					</tr>
					<tr>
						<td style="cursor : pointer; background-color: #99e6ff"
							onclick="clickColor(&quot;#99e6ff&quot;)"></td>
						<td style="text-align: right;">블루스카이&nbsp;</td>
						<td>#99e6ff</td>
					</tr>
					<tr>
						<td style="cursor : pointer; background-color: #99ccff"
							onclick="clickColor(&quot;#99ccff&quot;)"></td>
						<td style="text-align: right;">블루코랄&nbsp;</td>
						<td>#99ccff</td>
					</tr>
					<tr>
						<td style="cursor : pointer; background-color: #ff99e6"
							onclick="clickColor(&quot;#ff99e6&quot;)"></td>
						<td style="text-align: right;">핑크&nbsp;</td>
						<td>#ff99e6</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>




</body>
</html>