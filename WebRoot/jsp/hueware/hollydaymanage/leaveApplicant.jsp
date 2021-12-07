<%@page import="com.huation.framework.data.DataSet"%>
<%@page import="com.huation.framework.persist.ListDTO"%>
<%@page import="com.huation.common.config.GroupDTO"%>
<%@page import="com.huation.common.config.SmsGroupDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	Map model = (Map)request.getAttribute("MODEL"); 
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	String State = (String)model.get("State");
%>

<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" /><!-- EI9로 렌더링 -->
<title>휴가신청자</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/jquery-ui-1.9.2.custom.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<script language="javascript">
function Sign(seq,state,sign){
	var signmsg ="";
	
	
	var returnreason = $('#ReturnReason').val();
	if(sign =='Y'){
		signmsg ="휴가를 승인 하시겠습니까?";
	}else{
		signmsg ="휴가를 반려 하시겠습니까?";
	}
	
	

	
	if(!confirm(""+signmsg+""))
		return;
	location.href="<%= request.getContextPath()%>/H_Holly.do?cmd=HollyDaySignPop&Seq="+seq+"&State="+state+"&Sign="+sign+"&ReturnReason="+returnreason+"";

}


//레이어팝업 : 반려사유
function goReturnForm(seq,state,sign){
	
	$('#ReturnForm').dialog({
      resizable : false, //사이즈 변경 불가능
      draggable : true, //드래그 불가능
      closeOnEscape : true, //ESC 버튼 눌렀을때 종료

      width : 350,
      height : 233,
      modal : true, //주위를 어둡게

      open:function(){
          //팝업 가져올 url
          $(this).load('<%= request.getContextPath() %>/H_Holly.do?cmd=ReturnForm',{
        		"Seq" : seq,
        		"State" : state,
        		"Sign" : sign
        	});
          
          

          $(".ui-widget-overlay").click(function(){ //레이어팝업외 화면 클릭시 팝업 닫기
              $("#ReturnForm").dialog('close');
              });
      }
  });

}



function goClose(PopName){

	PopName.dialog('close');
}
function goCloses(){
	self.close();
	
}

</script>
</head>


<body>
<!-- 팝업사이즈 : width:705px -->
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>휴가 신청자</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp" class="leaveApplicant">
		<!-- 리스트 -->
		<table class="tbl_type tbl_type_list" summary="휴가 신청자(신청자, 휴가구분, 일수, 시작일, 종료일, 사유, 결재)">
			<colgroup>
				<col width="90px" />
				<col width="90px" />
				<col width="60px" />
				<col width="90px" />
				<col width="90px" />
				<col width="150px" />
				<col width="*" />
			</colgroup>
			<thead>
			<tr>
						<th>신청자</th>
						<th>휴가구분</th>
						<th>일수</th>
						<th>시작일</th>
						<th>종료일</th>
						<th>사유</th>
						<th>결재</th>
					</tr>
			</thead>
			<tbody>
			<tr>
				<td colspan="7" class="tbl_type_scrollY">
					<div class="scrollY">
						<table class="tbl_type tbl_type_list" summary="휴가 신청자(신청자, 휴가구분, 일수, 시작일, 종료일, 사유, 결재)">
							<colgroup>
								<col width="89px" class="scrollY_FF" /><!-- tbody에 추가되는 테이블의 왼쪽 라인 삭제로 인해 width사이즈를 -1px함. -->
								<col width="90px" />
								<col width="60px" />
								<col width="90px" />
								<col width="90px" />
								<col width="150px" />
								<col width="*" />
							</colgroup>
							<tbody>
								<%
					                if (ld.getItemCount() > 0) {
					                    int i = 0;
					                    while (ds.next()) {
					           				 %>
												<tr>
												
													<td><%=ds.getString("UserName") %></td>
													<td><%=ds.getString("HollyFlagName") %></td>
													<td><%=ds.getString("Day") %></td>
													<td><%=ds.getString("StartDateTime").substring(0,10) %></td>
													<td><%=ds.getString("EndDateTime").substring(0,10) %></td>
													<td class="text_l"><%=ds.getString("Reason") %></td>
													<td><a href="javascript:Sign('<%=ds.getString("Seq")%>','<%=State%>','Y');" class="btn_type03"><span>승인</span></a>&nbsp;<a href="javascript:goReturnForm('<%=ds.getString("Seq")%>','<%=State%>','N')" class="btn_type03"><span>반려</span></a></td>
												</tr>
										<%
								                i++;
								                    }
								                } else {
								         %>
								            <tr>
					          <td colspan="7">결재할 내역이 없습니다.</td>
					        </tr>
					        	
					        	<%
					                }
					            %>
							</tbody>
						</table>
					</div>
				</td>
			</tr>
			</tbody>
		</table>
		<!-- //리스트 -->
		<!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaC"><a href="javascript:window.close();" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
		<!-- //Bottom 버튼영역 -->
	</div>
	<!-- //content -->
</div>
<div id="ReturnForm" title="반려사유"></div>
</body>
</html>