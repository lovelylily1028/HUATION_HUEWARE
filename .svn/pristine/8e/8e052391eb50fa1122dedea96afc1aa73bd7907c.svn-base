<%@page import="com.huation.framework.data.DataSet"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-ui.multidatespicker.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-ui-1.11.1.js"></script>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/mdp.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/prettify.css">
<script type="text/javascript" src="<%= request.getContextPath()%>/js/prettify.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/lang-css.js"></script>
<title>Insert title here</title>

<script type="text/javascript">
$(function() {
	prettyPrint();
});


$('#simpliest-usage').multiDatesPicker();



var  formObj;//form 객체선언
//초기세팅
function init_leavePageList() {
	//직선그리기
	var canvas = document.getElementById('myCanvas');
	var context = canvas.getContext("2d");
		context.moveTo(0,0);// moveTo 함수는 시작점
		context.lineTo(250,250); // x 부터 y 까지 직선을 그리는 코드
		context.stroke(); // 직선을 그려랏 
	
		
	
	//사각형그리기	
	var canvas2 = document.getElementById('canvas');
	var context2 = canvas2.getContext("2d");
		context2.fillStyle ="#f44"; //색상지정
		context2.rect(0,0,250,250); //(x좌포,y좌표,width,height)
		context2.fill();//지정해준곳에 색깔을 칠해주세여(rect아래에 있어야함) 

	
	var canvas1 =document.getElementById("CANVAS_1");
	var context1 = canvas1.getContext("2d");
	var catImage = new Image();
	//catImage라는 변수에 Image를 생성해서 넣고 catImage.src를 통해 그림의 위치를 지정해 넣었다.
	catImage.src = "http://cfile26.uf.tistory.com/image/25679E435319402A2BFD61";
	
	catImage.addEventListener('load', eventCatImageLoaded, false); 
	//catImage에 load이벤트를 걸었다.
	//load가되면 eventCatImageLoaded()라는 함수를 호출하게 했고,
	//함수안에선 캔버스 컨텍스트에 이미지 좌표 0,0에 그리게 했다.

	function eventCatImageLoaded()
	{
		
	    context1.drawImage(catImage, 20, 20);
	    		//drawImage(이미지, x , y ,width,height)
	}

}

</script>



</head>
<body onload="init_leavePageList();">

				
<div id="wrap">
	<!-- container -->
	<div id="container">
		<canvas id="myCanvas" backgroupd="" width="250" height="250"></canvas>
		<canvas id="canvas" backgroupd="" width="250" height="250"></canvas>
		<canvas id="CANVAS_1" width="250" height="250"></canvas>
	</div>
	<!-- //container -->
	
</div>
</body>
</html>