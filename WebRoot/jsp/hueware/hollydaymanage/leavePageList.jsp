<%@page import="com.huation.framework.data.DataSet"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%
Map model = (Map)request.getAttribute("MODEL"); 

String Career ="";
Float TotalHolly =null;
Float UsedHolly =null;

String curPage = (String)model.get("curPage");
String searchGb = (String)model.get("searchGb");
String searchGb2 = (String)model.get("searchGb2");
String searchGb3 = (String)model.get("searchGb3");
String searchtxt = (String)model.get("searchtxt");
String StartDT = (String)model.get("StartDT");
String EndDT = (String)model.get("EndDT");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>휴가이력</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<script type="text/javascript">
var  formObj;//form 객체선언

//초기세팅
function init_leavePageList() {
	
	formObj=document.leavePageList; //form객체세팅
	
	searchInit(); //조회옵션 초기화
	searchInit2();
	searchInit3();
	
	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting(); //처리중 메세지 비활성화
		return;
	}
	
	observer = window.setTimeout("init()", 100);  // 0.1초마다 확인

}

//조회옵션 초기값	
function searchInit(){

	 formObj.searchGb.value='<%=searchGb%>';
	 formObj.searchtxt.value='<%=searchtxt%>';

	searchChk();
	
}

//조회옵션 초기값	2
function searchInit2(){

	 formObj.searchGb2.value='<%=searchGb2%>';

	searchChk();
	
}

//조회옵션 초기값	3
function searchInit3(){

	 formObj.searchGb3.value='<%=searchGb3%>';

	searchChk();
	
}

//조회옵션 체크	
	function searchChk(){
		
		
		if( formObj.searchGb[0].selected==true){
			formObj.searchtxt.disabled=true;
			formObj.searchtxt.value='';	
		}else {
			 formObj.searchtxt.disabled=false;
		}
		
	}
 
	//검색
	function goSearch() {
		var gubun= formObj.searchGb.value;
	
		if(gubun=='A'){
			if( formObj.searchtxt.value==''){
				alert('신청자를 입력해 주세요');
				return;
			}
		}else if(gubun=='B'){
			if( formObj.searchtxt.value==''){
				alert('결재자(TL)를 입력해 주세요');
				return;
			}
		}else if(gubun=='C'){
			if( formObj.searchtxt.value==''){
				alert('결재자(CEO)를 입력해 주세요');
				return;
			}
		}
		
		openWaiting();
		
		formObj.curPage.value='1';
		formObj.submit();

	}


	function showCalendar(div){

	   if(div == "1"){
	   	   $('#calendarData1').datepicker("show");
	   } else if(div == "2"){
		   $('#calendarData2').datepicker("show");
	   } 
	}
	
	//Excel Export(엑셀 내려받기)
	function goExcel() {  
		 formObj.action = "<%=request.getContextPath()%>/H_Holly.do?cmd=leavePageExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/H_Holly.do?cmd=leavePageList";	
	}
	
	

	function goModifyForm(seq){
		$('#ModifyForm').dialog({
	        resizable : false, //사이즈 변경 불가능
	        draggable : true, //드래그 불가능
	        closeOnEscape : true, //ESC 버튼 눌렀을때 종료

	        width : 455,
	        height : 500,
	        modal : true, //주위를 어둡게

	        open:function(){
	            //팝업 가져올 url
	            $(this).load('<%= request.getContextPath() %>/H_Holly.do?cmd=leaveModifyForm',
	            		{'seq' : seq});
	            $(".ui-widget-overlay").click(function(){ //레이어팝업외 화면 클릭시 팝업 닫기
	                $("#ModifyForm").dialog('close');
	                });
	        }
	    });
		
		
	}

	function goClose(PopName){
		PopName.dialog('close');
	}
</script>
</head>
<body onload="init_leavePageList();">

				<%
					ListDTO ld = (ListDTO) model.get("listInfo");
				//	UserDTO userDto = (UserDTO) model.get("totalInfo");
					DataSet ds = (DataSet) ld.getItemList();
					
					int iTotCnt = ld.getTotalItemCount();
					int iCurPage = ld.getCurrentPage();
					int iDispLine = ld.getListScale();
					int startNum = ld.getStartPageNum();
				%>
<div id="wrap">
	<!-- header -->
	<%@ include file="/jsp/hueware/common/include/top.jsp" %>
	<!-- //header -->
	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">휴가관리 &gt; 휴가이력</div>
			<h3><span>휴</span>가이력</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
				<!-- 리스트 -->
			<div class="conTop_area">
				<%=ld.getPageScript("leavePageList", "curPage", "goPage")%>
				<form method="post" action="<%=request.getContextPath()%>/H_Holly.do?cmd=leavePageList" name = "leavePageList" class="search">
				<input type="hidden" name="curPage" value="<%=curPage%>"/>
				<fieldset>
					<legend>검색</legend>
						<ul>
						
							<!-- 달력 시작 -->
				        	<li><span class="ico_calendar"><input name="StartDT"  type="text" value="<%=StartDT %>" class="text textdate" id="calendarData1" readonly="readonly" dispName="날짜" maxlength="8" /><img src="<%=request.getContextPath() %>/images/common/ico_calendar.gif" alt="달력" onclick="showCalendar('1')" /></span> ~ <span class="ico_calendar"><input name="EndDT"  type="text" value="<%=EndDT %>" class="text textdate" id="calendarData2" readonly="readonly" dispName="날짜" maxlength="8"  /><img src="<%=request.getContextPath() %>/images/common/ico_calendar.gif" alt="달력" onclick="showCalendar('2')"/></span></li>
				        	<!-- 달력 종료 -->
						
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<li><select name="searchGb3" onchange="searchChk3()" id="" class="">
								<option checked value="">전체</option>
								<option value="1" >연차</option>
								<option value="2" >오전반차</option>
								<option value="3" >오후반차</option>
								<option value="4" >병가</option>
								<option value="5" >예비군훈련</option>
								<option value="6" >무급휴가</option>
							</select></li>
							
							<li><select name="searchGb2" onchange="searchChk2()" id="" class="">
								<option checked value="">전체</option>
								<option value="D" >신청중</option>
								<option value="E" >승인</option>
								<option value="F" >반려</option>
							</select></li>
							
							
							<li><select name="searchGb" onchange="searchChk()" id="" class="">
								<option checked value="">전체</option>
								<option value="A" >신청자</option>
								<option value="B" >결재자(TL)</option>
								<option value="C" >결재자(CEO)</option>
							</select></li>
							
							<li><input type="text" class="text" onkeydown="javascript:if(event.keyCode==13){goPage('1');}" title="검색어" id="" name="searchtxt" value="<%=searchtxt%>" maxlength="100"/></li>
							<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
						</ul>
					</fieldset>
				</form>
				<!-- Top 버튼영역 -->
					<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray md0"><span>내려받기</span></a></div>
					<!-- //Top 버튼영역 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				
				<table class="tbl_type tbl_type_list" summary="휴가이력(신청자, 진행상태, 휴가구분, 일수, 시작일, 종료일, 등록일, 사유, 결재자)">
					<colgroup>
						<col width="7%" />
						<col width="7%" />
						<col width="7%" />
						<col width="5%" />
						<col width="8%" />
						<col width="8%" />
						<col width="8%" />
						<col width="*" />
						<col width="*" />
						<col width="8%" />
						<col width="8%" />
					</colgroup>
					<thead>
					<tr>
						<th>신청자</th>
						<th>진행상태</th>
						<th>휴가구분</th>
						<th>일수</th>
						<th>시작일</th>
						<th>종료일</th>
						<th>등록일</th>
						<th>사유</th>
						<th>반려사유</th>
						<th>결재자(TL)</th>
						<th>결재자(CEO)</th>
					</tr>
					</thead>
					<tbody>
					
							<%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
           				 %>
							<tr>
								
								<td><a onclick="javascript:goModifyForm('<%=ds.getString("Seq")%>');"><%=ds.getString("UserName")%></a></td>
								<%if(ds.getString("State1").equals("N") || ds.getString("State2").equals("N")){%>
								<td class="return">반려</td>
								<%}else if(ds.getString("State1").equals("Y") && ds.getString("State2").equals("Y")){ %>
								<td class="leaveOk">승인</td>
								<%}else{ %>
								<td class="requesting">신청중</td>
								<%}%>
								<td><%=ds.getString("HollyFlagName") %></td>
								<td><%=ds.getString("Day") %></td>
								<td><%=ds.getString("StartDateTime").substring(0,10) %></td>
								<td><%=ds.getString("EndDateTime").substring(0,10) %></td>
								<td><%=ds.getString("RegDateTime").substring(0,10) %></td>
								<td class="text_l"><%=ds.getString("Reason") %></td>
								<td class="text_l"><%=ds.getString("ReturnReason") %></td>
								<td><%=ds.getString("SignName1") %></td>
								<td><%=ds.getString("SignName2") %></td>
							
							</tr>
					<%
			                i++;
			                    }
			                } else {
			         %>
			            <tr>
          <td colspan="11">휴가 신청 현황이 없습니다.</td>
        </tr>
        	
        	<%
                }
            %>
					
					
					
				</tbody>
				</table>
				<!-- //리스트 -->
					<!-- 페이징 -->
					<div class="paging">
				      <%=ld.getPagging("goPage")%>
				    </div>
					<!-- //페이징 -->
			</div>
		</div>
	</div>
	<!-- //container -->
		<!-- footer -->
		<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
		<!-- //footer -->
</div>
<div id="ModifyForm" title="휴가수정폼"></div>
</body>
<%= comDao.getMenuAuth(menulist,"82") %>
</html>