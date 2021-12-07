<%@page import="com.baroservice.ws.SMSMessage"%>
<%@page import="com.baroservice.ws.CERTKEY"%>
<%@page import="com.baroservice.ws.BaroService_SMSSoapProxy"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="com.huation.framework.data.DataSet"%>
<%@page import="com.huation.framework.util.StringUtil"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%

	Map model = (Map)request.getAttribute("MODEL");
	
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String StartDT = (String)model.get("StartDT");
	String EndDT = (String)model.get("EndDT");

%> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>SMS 예약 내역</title>
<script language="javascript">
var SelectMenu='smsSendPageList';

//레이어팝업 : 유저 수정 폼
function goDetailsView(sendkey,sendDT){
  $('#smsSendView').dialog({
      resizable : false, //사이즈 변경 불가능
      draggable : true, //드래그 불가능
      closeOnEscape : true, //ESC 버튼 눌렀을때 종료
      width : 610,
      height : 429,
      modal : true, //주위를 어둡게

      open:function(){
          //팝업 가져올 url
          $(this).load('<%= request.getContextPath() %>/S_Sms.do?cmd=smsSendView',
          		{'SendKey' : sendkey,
        	  	 'sendDT' : sendDT
          		}
          );

          $(".ui-widget-overlay").click(function(){ //레이어팝업외 화면 클릭시 팝업 닫기
              $("#smsSendView").dialog('close');
              });
      }
  });
};

function goSearch(){
	
	var frm = document.smsSendPageList;
	
	frm.submit();
	
}

function goClose(PopName){
	
	PopName.dialog('close');
}


</script>
</head>
<body>
<!-- 팝업사이즈 : width:834px / height:574px; -->
<div id="wrapWp" class="smsSendPageList">
	<!-- header -->
	<div id="headerWp">
	 <%@ include file="/jsp/hueware/common/include/smsTop.jsp" %> 
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp" class="smsSendPageList_area">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<!-- 조회 -->
			
			  <%
					ListDTO ld = (ListDTO) model.get("listInfo");
				//	UserDTO userDto = (UserDTO) model.get("totalInfo");
					DataSet ds = (DataSet) ld.getItemList();
					
					int iTotCnt = ld.getTotalItemCount();
					int iCurPage = ld.getCurrentPage();
					int iDispLine = ld.getListScale();
					int startNum = ld.getStartPageNum();
				%>
  
			  <%=ld.getPageScript("smsSendPageList", "curPage", "goPage")%>
			<form method="post" action="<%=request.getContextPath()%>/S_Sms.do?cmd=smsSendPageList" name = "smsSendPageList" class="search">
			<input type="hidden" name="curPage" value="<%=curPage%>"/>
		    <input type="hidden" name="SeqRep" value=""></input>
			<fieldset>
				<legend>검색</legend>
				<ul>
					<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
					<li><span class="ico_calendar">
					<input type="text" class="text textdate" value="<%=StartDT%>" name="StartDT" title="검색시작일" id="calendarData1" /></span> ~ <span class="ico_calendar">
					<input type="text" class="text textdate" value="<%=EndDT%>" name="EndDT" title="검색종료일" id="calendarData2" /></span></li>
					<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
				</ul>
			</fieldset>
			</form>
			<!-- //조회 -->
			<!-- Top 버튼영역 -->
			<!-- <div class="Tbtn_areaR"><a href="#none" class="btn_type01 btn_type01_gray md0"><span>내려받기</span></a></div> -->
			<!-- //Top 버튼영역 -->
		</div>
		<!-- //컨텐츠 상단 영역 -->
		<!-- 리스트 -->
		<table class="tbl_type tbl_type_list" summary="SMS전송내역(No., 구분, 발신자, 수신자, 전체, 대기, 성공, 실패, 전송일시, 상세)">
			<colgroup>
				<col width="8%" />
				 <col width="8%" />
				<col width="13%" />
				<col width="19%" />
				<col width="*" />
				<col width="10%" />
				<col width="10%" />
				<col width="9%" />
			</colgroup>
			<thead>
			<tr>
				<th>전송구분</th>
				<!-- <th>No.</th> -->
				<th>발신자</th>
				<th>발신번호</th>
				<th>수신자</th>
				<th>메세지</th>
				<th>예약일시</th>
				<th>전송일시</th>
				<th>상세</th>
			</tr>
			</thead>
			<tfoot>
			<tr>
				<td colspan="8"><strong>검색결과 : <span><%=iTotCnt%></span>건</strong></td>
			</tr>
			</tfoot>
			<tbody>
			<!-- <tr>
				<td>1</td>
				<td>부가서비스</td>
				<td>나상욱<br />010-1234-5678</td>
				<td>나상욱<br />010-1234-5678 외 3명</td>
				<td>4</td>
				<td>-</td>
				<td>3</td>
				<td>1</td>
				<td>201-07-04 12:12:12</td>
				<td><a href="#none" class="btn_type03"><span>상세정보</span></a></td>
			</tr> -->
				<%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
            %>
       
       <tbody> 
        <tr>
        <%if(ds.getString("ReserveCheck").equals("2")){ %>
     	  <td style="color:green;">예약전송</td>
     	  <%}else{ %>
     	  <td>즉시전송</td>
     	  <%} %>
          <%-- <td><%=ds.getString("Seq") %></td> --%>
          
          <td><%=ds.getString("UserName") %></td>
          
          
          <%
   		   String regEx = "(\\d{3})(\\d{3,4})(\\d{4})";
   		   if(!Pattern.matches(regEx, ds.getString("SendNum"))){%>
			<td><%=ds.getString("SendNum") %></td>
   		   <%}else{%>
   		    <td><%=ds.getString("SendNum").replaceAll(regEx, "$1-$2-$3")%></td>
		<%
   	  	 }
		%>
		
		 <%
		 
		   String getCERTKEY;
		   String sendDate = ds.getString("SendStartTime");  
		   String sendDate2 = sendDate.substring(0,4)+"-"+sendDate.substring(4,6)+"-"+sendDate.substring(6,8)+" "+sendDate.substring(8,10)+":"+sendDate.substring(10,12)+":"+sendDate.substring(12,14);
		   
		   SMSMessage[] result;
			BaroService_SMSSoapProxy proxy = new BaroService_SMSSoapProxy();	
			CERTKEY certkey = new CERTKEY();
			
			getCERTKEY = certkey.getCERTKEY();
			
			result = proxy.getMessagesByReceiptNum(getCERTKEY,"1088193762",ds.getString("SendKey"));
			String sendDate3 = result[0].getSendDT().substring(0,4)+"-"+result[0].getSendDT().substring(4,6)+"-"+result[0].getSendDT().substring(6,8)+" "+result[0].getSendDT().substring(8,10)+":"+result[0].getSendDT().substring(10,12)+":"+result[0].getSendDT().substring(12,14);
		 %>
		 
		 <%if(result.length>1){ %>
          <td><%=result[0].getReceiverName()%><br /><%=result[0].getReceiverNum().replaceAll(regEx, "$1-$2-$3")%> 외 <strong><a onclick="javascript:goDetailsView('<%=ds.getString("SendKey")%>','<%=sendDate2%>');" style="color:red;"><%=result.length-1%></a></strong>명</td>
          <%}else{ %>
          <td><%=result[0].getReceiverName()%><br /><%=result[0].getReceiverNum().replaceAll(regEx, "$1-$2-$3")%></td>
          <%} %>
          
          <td title="<%=ds.getString("Message") %>"><span class="ellipsis"><%=ds.getString("Message") %></span></td>
          
          
           <%if(ds.getString("ReserveCheck").equals("2")){ %>
     	  <td><%=sendDate2%></td>
     	  <%}else{ %>
     	  <td>-</td>
     	  <%} %>
          
          <%if(ds.getString("ReserveCheck").equals("2") && result[0].getSendState()==0 ){%>
          		<td>대기중</td>
          	<%}else if(ds.getString("ReserveCheck").equals("2")&& result[0].getSendState()==1){%>
		        <td><%=sendDate3%></td>    
     	  
     	  <%}else{ %>
     	  <td><%=sendDate2%></td>
     	  <%} %>
          
      	  <td><a onclick="javascript:goDetailsView('<%=ds.getString("SendKey")%>','<%=sendDate2%>');" class="btn_type03"><span>상세정보</span></a></td>
      	    
        </tr>
        <!-- :: loop :: -->
        	
        	<%
                i++;
                    }
                } else {
            %>
        
        <tr>
          <td colspan="8">게시물이 없습니다.</td>
        </tr>
        	
        	<%
                }
            %>
          
          </tbody>
          
          
			</tbody>
		</table>
		<!-- //리스트 -->
		<!-- 페이징 -->
		<div class="paging">
			      <%=ld.getPagging("goPage")%>
			    </div>
		<!-- //페이징 -->
	</div>
	<!-- //content -->
</div>
<div id="smsSendView" title="SMS전송내역 상세"></div>
</body>
</html>