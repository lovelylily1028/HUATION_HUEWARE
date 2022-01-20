<%@page import="java.net.URLEncoder"%>
<%@page import="org.directwebremoting.util.SystemOutLoggingOutput"%>
<%@page import="com.huation.framework.data.DataSet"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.huation.common.corpState.CorpStateDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴폐업 조회</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%=request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/default.css"	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/content.css"	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/dev_content.css"	rel="stylesheet" type="text/css" />
<script type="text/javascript"	src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath()%>/js/jquery.banner.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">

	/* 휴폐업 조회 ajax */
	function goSearch(){
		
		var formObj = document.ClosureSearchForm;
		var CorpNum = formObj.checkCorpNum.value;
		var regNumber = /^[0-9]*$/;
		
		
		if(CorpNum == ''){
			alert('사업자 번호를 입력해주세요.');
			return;	
		}else if(CorpNum.search('-') != -1){
			alert("'-'를 제외한 숫자만 입력해주세요.'");
			return;
		}else if(!regNumber.test(CorpNum)){
			alert('숫자만 입력가능합니다.');
			$('#checkCorpNum').val('');
			return;
		}
		
		$.ajax({
			url : "<%=request.getContextPath()%>/B_CorpState.do?cmd=CorpStateSearch",
			type : "POST",
			dataType : "json",
			data : {checkCorpNum : CorpNum},
			success : function(data){
				viewTable(data);
			},
			error : function(err){
				alert(err);
			}
		})
	}
	
	
	function CheckCharacter(obj){
		
		var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
		
		if( regExp.test(obj.value) ){
			
			alert('특수문자는 입력하실수 없습니다.');

		     obj.value = obj.value.substring( 0 , obj.value.length - 1 ); // 입력한 특수문자 한자리 지움

		  }
	}
	
	
	
	/* 결과값 출력 */  
	function viewTable(data){
		
		var result = data.result;
		
		/* 3자리-2자리-5자리 구조로 변경 */
		var beforeCorpNum = result.corpNum;
		var beforeBaseDate = result.baseDate;
		
		AfterCorpNum = beforeCorpNum.substr(0,3) + " - " + beforeCorpNum.substr(3,2) + " - " + beforeCorpNum.substr(5);
		AfterBaseDate = beforeBaseDate.substr(0,4) + "년 " + beforeBaseDate.substr(4,2) + "월 " + beforeBaseDate.substr(6) + "일";
		
		$("#data-form").show();
		$("#corpNum").text(AfterCorpNum);
		$("#taxType").text(result.taxType);
		$("#corpState").text(result.state);
		$("#stateDate").text(result.stateDate);
		$("#baseDate").text(AfterBaseDate);
		
	}

	/* enterkey event */
	$(document).keypress(function(e){
		if(e.keyCode == 13){
			goSearch();
			e.preventDefault();
		}
	})
	
</script>
</head>
<body>

	<div id="wrap">

		<!-- header -->
		<%@ include file="/jsp/hueware/common/include/top.jsp"%>
		<!-- //header -->

		<!-- container -->
		<div id="container">
			<div id="content">
				<div class="content_navi">경영지원 &gt; 휴폐업</div>
				<h3>
					<span>휴</span>폐업 조회
				</h3>
				<!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
				<div class="con">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area"></div>
				<!-- //컨텐츠 상단 영역 -->
				
					<div class="box-table">
						<!-- 컨텐츠 하단 영역 -->
						<!-- <h6 class="title-sub" style="color:  #255A2A;">조회할 사업자등록번호를 입력하세요.</h6>  -->
	
					<form method="post" name="ClosureSearchForm" action="<%=request.getContextPath()%>/B_CorpState.do?cmd=CorpStateSearch">	
						<div class ="box-numInfo">
							<div class="numbox1">사업자 번호</div>
							<div class="numbox2">
								<input type="text" id="checkCorpNum" name="checkCorpNum" maxlength="12" placeholder="'-'를 제외한 숫자만 입력해주세요." onkeyup="CheckCharacter(this)" title="조회하실 사업자번호를 입력해주세요.">
							</div>
							<div class="numbox3">
  								<!-- <input class="img-button" type="button" id="CorpNumSearch" onclick="javascript:goSearch();"> -->
 								<input class="img-button" type="button" id="CorpNumSearch" style="cursor: pointer;" onclick="javascript:goSearch();">
							</div>
						</div>
					</form>
						<div class="data-form" id="data-form" style="display:none">
							<table class="data-table">
								<colgroup>
									<col width="22%"/>								
									<col width="*"/>								
								</colgroup>							
							<thead>
								<!-- <th colspan="2">사업자 번호&emsp;<span id="corpNum" style="font-weight: bold;color: #65BB5D;"></span>&emsp;결과 입니다.</th> -->
								<!-- <td><span id="corpNum" style="color: red;"></span></td> -->
							</thead>
							<tbody>
							<tr>
								<th>사업자 번호 </th>
								<td><span id="corpNum" style="font-weight: bold;color: #65BB5D;"></span></td>
							</tr>
							<tr>
								<th>과세 구분 </th>
								<td id="taxType"></td>
							</tr>
							<tr>
								<th>휴폐업 상태 </th>
								<td id="corpState"></td>
							</tr>
							<tr>
								<th>휴폐업 일자 </th>
								<td id="stateDate"></td>
							</tr>
							<tr>
								<th>기준 일자 </th>
								<td id="baseDate"></td>
							</tr>
							</tbody>
							</table>
						</div>
					</div>
				<!-- // 컨텐츠 하단 영역 -->
				</div>
			</div>
		</div>
		<!-- //container -->

		<!-- footer -->
		<%@ include file="/jsp/hueware/common/include/footer.jsp"%>
		<!-- //footer -->

	</div>
</body>
</html>
<%=comDao.getMenuAuth(menulist, "02")%>