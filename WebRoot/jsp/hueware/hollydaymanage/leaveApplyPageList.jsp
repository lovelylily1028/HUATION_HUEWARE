<%@page import="com.huation.framework.data.DataSet"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>휴가신청</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>


</head>
<%
Map model = (Map)request.getAttribute("MODEL"); 
HollyDTO hollyDto = (HollyDTO)model.get("hollyDto");

String Career ="";
Float TotalHolly =null;
Float UsedHolly =null;

String curPage = (String)model.get("curPage");
String searchGb = (String)model.get("searchGb");
String searchtxt = (String)model.get("searchtxt");
String StartDT = (String)model.get("StartDT");
String EndDT = (String)model.get("EndDT");


 TotalHolly = hollyDto.getTotalHollyDay();

 if(hollyDto.getUsedHollyDay().equals("")){
	UsedHolly =null;
}else{
 UsedHolly = hollyDto.getUsedHollyDay();
}


 if(hollyDto.getCareer().equals("0")){
	Career = "1년미만";
}else{
	Career = "만"+hollyDto.getCareer()+"년차";
}

 String HireDate = hollyDto.getHireDateTime().substring(0,10);
%>


<script language="javascript">
var UseableHollyDay = <%=TotalHolly-UsedHolly%>;
//레이어팝업 : 휴가등록 폼
function goRegistForm(){
	/* 
	if(UseableHollyDay <= 0) {
		alert("사용 가능한 휴가 일수를 모두 소진 하였습니다.");
		return;
	}
	 */
	$('#RegistForm').dialog({
        resizable : false, //사이즈 변경 불가능
        draggable : true, //드래그 불가능
        closeOnEscape : true, //ESC 버튼 눌렀을때 종료

        width : 441,
        height : 413,
        modal : true, //주위를 어둡게

        open:function(){
            //팝업 가져올 url
            $(this).load('<%= request.getContextPath() %>/H_Holly.do?cmd=leaveRegistForm');

            $(".ui-widget-overlay").click(function(){ //레이어팝업외 화면 클릭시 팝업 닫기
                $("#RegistForm").dialog('close');
                });
        }
    });
 
}

function goClose(PopName){
	PopName.dialog('close');
}

function goModifyForm(seq){
	/* 
	if(UseableHollyDay <= 0) {
		alert("사용 가능한 휴가 일수를 모두 소진 하였습니다.");
		return;
	}
	 */
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


function hollydayHelp(){
	var a = window.open("<%=request.getContextPath() %>/H_Holly.do?cmd=hollydayHelp","","width=430,height=480,left=200,top=50,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
}


</script>
<body>

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
		<div id="content" class="leaveApplyPageList">
			<div class="content_navi">휴가관리 &gt; 휴가신청</div>
			<!-- 휴가정보 -->
			<%=ld.getPageScript("leaveApplyPageList", "curPage", "goPage")%>
			<form method="post" action="<%=request.getContextPath()%>/H_Holly.do?cmd=leaveApplyPageList" name = "leaveApplyPageList" class="search">
			<input type="hidden" name="curPage" value="<%=curPage%>"/>
			<div class="con leaveInfo_area">
				<ul class="leaveInfo">
					<li><span class="hidden_obj">이름</span><%=hollyDto.getUserName()%></li>
					<li class="firstDate"><span class="hidden_obj">입사일</span><%=HireDate%></li>
					<li><span class="hidden_obj">연차</span><%=Career%></li>
					<li><span class="hidden_obj">휴가일수</span><%=hollyDto.getTotalHollyDay()%></li>
					<li class="leaveNum"><strong class="fontGreen"><%=hollyDto.getUserName()%></strong>님의<br /><span class="fontBig"><span class="fontBold">휴가</span>는 <strong><span class="fontNum"><%=TotalHolly-UsedHolly %></span></strong>일 
					<span class="fontBold">남았습니다.</span></span></li>
				</ul>
				<!-- Top 버튼영역 -->
				<div class="btn_Apply"><a href="javascript:goRegistForm();"><img src="<%= request.getContextPath()%>/images/sub/leaveInfo_btn.jpg" alt="휴가신청" /></a></div>
				<!-- //Top 버튼영역 -->
				</form>
			</div>
			<!-- //휴가정보 -->
			<!-- 휴가신청현황 -->
			<h3><span>휴</span>가신청현황</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- Top 버튼영역 -->
					<div class="Tbtn_areaR"><a href="javascript:hollydayHelp();" class="btn_type01 md0"><span>휴가구분안내</span></a></div>
					<!-- //Bottom 버튼영역 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				<!-- 리스트 -->
				<table class="tbl_type tbl_type_list" summary="휴가신청현황(진행상태, 휴가구분, 일수, 시작일, 종료일, 등록일, 사유, 결재자)">
					<colgroup>
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
							<tr >
							
								<%if(ds.getString("State1").equals("N") || ds.getString("State2").equals("N")){%>
								<td class="return">반려</td>
								<%}else if(ds.getString("State1").equals("Y") && ds.getString("State2").equals("Y")){ %>
								<td class="leaveOk">승인</td>
								<%}else{ %>

								<%-- <td class="requesting"><a onclick="javascript:goModifyForm('<%=ds.getString("Seq")%>');">신청중</a></td> --%>
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
          <td colspan="10">휴가 신청 현황이 없습니다.</td>
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
			<!-- //휴가신청현황 -->
		</div>
	</div>
	<!-- //container -->
		<!-- footer -->
		<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
		<!-- //footer -->
</div>
<div id="RegistForm" title="휴가신청폼"></div>
<div id="ModifyForm" title="휴가수정폼"></div>
</body>
<%= comDao.getMenuAuth(menulist,"80") %>
</html>