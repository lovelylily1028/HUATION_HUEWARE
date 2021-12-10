<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.huebookmanage.HueBookManageDTO" %>
<%@ page import="com.huation.common.user.UserBroker"%>
<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	HueBookManageDTO hbDto = (HueBookManageDTO)model.get("hbDto");
	String strDate = (String)model.get("strDate");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>HueBook 도서결재 상세보기</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
//결재완료
function goSaveApp(){
	var frm = document.hueBookAppView; 
	
	//결재일자
  	var dates = frm.clearDate.value;
	var clearDates = dates.replace(/-/g,'');
	
	frm.pYear1.value = clearDates.substr(0,4);
	frm.pMonth1.value = clearDates.substr(4,2);
	frm.pDay1.value = clearDates.substr(6,2);
	frm.clearDate.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
	
	var clDate = frm.clearDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;
		if(frm.requestDate.value > clDate){
			alert('결재일자보다 신청일자가 큽니다.');
			return;
		}
		if(frm.approvalAndReturn.value == ""){
			alert("승인/반려사유를 입력하세요.");
			return;
		}
	if(confirm("결재 하시겠습니까?")){
		  frm.action='<%=request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookManageAppEditY'	
				  
	frm.clearDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;
	frm.approvalUser.value = frm.user_id.value;
	frm.submit();
	}
}
//반려
function goReturns(){
	var frm = document.hueBookAppView; 
		if(frm.approvalAndReturn.value == ""){
			alert("승인/반려사유를 입력하세요.");
			return;
		}
	if(confirm("반려 하시겠습니까?")){
		  frm.action='<%=request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookManageAppEditRT'	

	frm.approvalUser.value = frm.user_id.value;
	frm.submit();
	}
}
//구매완료
function goSaveBuy(){
	var frm = document.hueBookAppView; 
	//구매일자
		var dates = frm.buyDate.value;
		var buyDates = dates.replace(/-/g,'');
		
		frm.pYear1.value = buyDates.substr(0,4);
		frm.pMonth1.value = buyDates.substr(4,2);
		frm.pDay1.value = buyDates.substr(6,2);
		frm.buyDate.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
		
	var buyDate = frm.buyDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;	

		if(frm.clearDate.value > buyDate){
			alert('구매일자보다 결재일자가 큽니다.');
			return;
		}
		if(frm.buyPrice.value == ""){
			alert('구매가격은 필수입니다.');
			return;
		}
		//구입처 입력 유효성 검사 추가(21.10.18) START
		if(frm.purchasingOffice.value == ""){
			alert('구입처를 입력해주시기 바랍니다.');
			return false;
		}
		//구입처 입력 유효성 검사 추가 END
	if(confirm("구매완료 하시겠습니까?")){
		  frm.action='<%=request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookManageAppEditBuy'	

	frm.buyDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;

	frm.submit();
	}
}
//구매완료
function goSaveBuy2(){
	var frm = document.hueBookAppView;
	//구매완료(status==3)인 경우 걸러내기(21.10.18) START
	var status = document.getElementById("status4Modify").value; 
	if(status == 3){
		alert("구매완료건은 반려가 불가합니다.");
		return false;
	}
	//구매완료(status==3)인 경우 걸러내기 END
	
	//구매일자
		var dates = frm.buyDate.value;
		var buyDates = dates.replace(/-/g,'');
		
		frm.pYear1.value = buyDates.substr(0,4);
		frm.pMonth1.value = buyDates.substr(4,2);
		frm.pDay1.value = buyDates.substr(6,2);
		frm.buyDate.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
		frm.updateYN.value = "Y";
		
	var buyDate = frm.buyDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;	

		if(frm.clearDate.value > buyDate){
			alert('구매일자보다 결재일자가 큽니다.');
			return;
		}
		if(frm.buyPrice.value == ""){
			alert('구매가격은 필수입니다.');
			return;
		}
	if(confirm("금액수정 하시겠습니까?")){
		  frm.action='<%=request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookManageAppEditBuy'	

	frm.buyDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;

	frm.submit();
	}
}
/*
 * int 가격 체크 천단위로 (1,000)계산하여 끊어준뒤 콤마 표시
 * 현재 int으로 설정됨.
 */
 function saleCntCal(form){
	
	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+'_view');
		var frm=eval("document."+form);
		var costobj=document.hueBookAppView;

		if(frm.length>1){
			v_obj=veiwfrm[index];
			obj=frm[index];
		}else{
			v_obj=veiwfrm;
			obj=frm;
	
		}
	
		if (!isNumber(trim(v_obj.value))) {
			alert("0~9 정수(숫자)만 입력해 주세요.");
		} 
		
		
		var num=onlyNum(v_obj.value);
		v_obj.value = addCommaStr(num);
		obj.value = num;
		
		if(form=='hueBookAppView.buyPrice'){	
			var price=parseInt(onlyNum(costobj.buyPrice.value)*1,10);//<실제 셋팅해줄값
			costobj.buyPrice.value=addCommaStr(''+price); 
		    costobj.buyPrice.value=price;
		    
		}
		v_obj.focus();
	}

   //목록
	function goList(){
		
		var frm = document.hueBookAppView;
		frm.action='<%= request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookAppPageList';
		frm.submit();
   }

	//사원목록조회
	function popSales(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=hueBookAppView","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	}

//-->
</SCRIPT>
</head>
<body >
<div id="wrap">
<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->
<!-- container -->
<div id="container">
<!-- content -->
<div id="content">
  <div class="content_navi">HUEBook &gt; 도서결재</div>
  <h3><span>도</span>서결재상세정보</h3>
  <!-- con -->
  <div class="con">
  <!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
		<!-- 필수입력사항텍스트 -->
		<p class="must_txt"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
		<!-- //필수입력사항텍스트 -->
	</div>
  
  
    <form name="hueBookAppView" method="post">
     <input type = "hidden" name = "pYear1" value=""/>
     <input type = "hidden" name = "pMonth1" value=""/>
     <input type = "hidden" name = "pDay1" value=""/>
     <input type = "hidden" name = "updateYN" value="N"/>
     <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
  	 <input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>"/>
  	 <!-- status가 구매완료인 경우 내용수정 불가처리용 -->
  	 <input type = "hidden" name = "status4Modify" id="status4Modify" value="<%=hbDto.getStatus()%>"/>
  	 
	  	<!-- Update시 넘겨줄 히든(pk값) -->
	   <input type="hidden" name="SeqPk" value="<%=hbDto.getSeqPk()%>"></input>	
	   <!-- 진행상태값 Action Null값으로넘김(2.결재완료)Setting -->
	   <input type="hidden" name="status" value=""></input>
	   
   <table class="tbl_type" summary="도서결재상세정보(신청자, 분야, 도서명, 출판사, 저자, 역자, 가격, 신청(권)수, 신청일자, 결재일자, 구매일자, 구매가격, 결재자, 구매처, 내용(목차), 승인/반려사유)">
     <% //달력객체 전역으로 선언 
     DateParam dateParam = new DateParam(); 
     %>
     
     <fieldset>
        <caption>도서신청 상세정보</caption>
        <colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
		<tbody>
		<tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청자</label></th>
          <td><input type="text" name="" class="text dis" title="신청자" style="width:200px;" readOnly value="<%=hbDto.getRequestName()%>"></input></td>	
    	</tr>
    	<tr>
    		<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>분야</label></th>	
          	<td>
          		<!-- 분야코드NAME명 꺼내올값 현재PARAM넘기진않음. -->
          		<input type="text" name="branchCodeNm" value="<%=hbDto.getBranchCodeNm() %>" class="text dis" title="분야" style="width:200px;" readonly="readonly"></input>
          	</td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>도서명</label></th>
          <td><input type="text" name="bookName" value="<%=hbDto.getBookName() %>" title="도서명" style="width:916px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
	    </tr>
	    <tr>     
	          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>출판사</label></th>
	          <td><input type="text" name="publisher" value="<%=hbDto.getPublisher() %>"  title="출판사" style="width:300px;" maxlength="25"  class="text dis" readonly="readonly"></input></td>
      
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>저자</label></th>
          <td><input type="text" name="writer" value="<%=hbDto.getWriter() %>"  title="저자" style="width:300px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
		</tr>
		<tr>
	          <th><label for="">역자</label></th>
	          <td><input type="text" name="translator" value="<%=hbDto.getTranslator() %>"  title="역자" style="width:300px;" maxlength="25" class="text dis" readonly="readonly" ></input></td>
        </tr>
         <tr>
          <th><label for="">가격</label></th>
          <input type="hidden" name="price" class="text text_r dis"  title="가격" style="width:200px;"" value="<%=hbDto.getPrice() %>"   maxlength="9" />
          <td><input type="text" name="price_view" value="<%=NumberUtil.getPriceFormat(hbDto.getPrice()) %>"  title="가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookReRegist.price')" class="text text_r dis" readonly="readonly" /> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td>
		</tr>
		<tr>
          	  <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청(권)수</label></th>
	          <td>
				<input type="text" name="requestBookCount" value="<%=hbDto.getRequestBookCount() %>"  title="신청(권)수" style="width:50px;" class="text dis" readonly="readonly"></input>
	          </td>
			</tr>
        <tr>
      
		
		<%
			String statusChk1 ="1"; //(신청중)
			String statusChk2 ="2"; //(결재완료)
			String statusChk3 ="3"; //(구매완료)
			String statusChk4 ="4"; //(반려)
			
			//구매완료
				if(statusChk3.equals(hbDto.getStatus())){			
		%>
		   <th><label for="">신청일자</label></th>
			<td>
			<span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getRequestDate()%>"></input>
       	 	<!-- 결재자 ID넘겨줄값 휴북목록에 값 넘겨주기위해사용. -->
       	 	<input type="hidden" name="approvalUser" value="<%=hbDto.getApprovalUser() %>" ></input>
       	 	<!-- 분야 코드ID 넘겨줄값 휴북목록에 값 넘겨주기위해사용. -->
       	 	<input type="hidden" name="branchCode" value="<%=hbDto.getBranchCode() %>"></input>
       	 	<!-- 신청자 ID넘겨줄값 휴북목록에 값 넘겨주기위해사용. -->
       	 	<input type="hidden" name="requestUser" value="<%=hbDto.getRequestUser() %>"></input>
			</td><!-- input 비활성화 class="dis" 추가 -->
		</tr>
		<tr>
		   <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재일자</label></th>
		  <td><span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="clearDate" value="<%=hbDto.getClearDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getClearDate()%>"></input></td><!-- input 비활성화 class="dis" 추가 -->	
        </tr>
        <tr>
         <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>구매일자</label></th>
		  <td><span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="buyDate" value="<%=hbDto.getBuyDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getBuyDate()%>"></input></td><!-- input 비활성화 class="dis" 추가 -->		
		</tr>
		<tr>
           <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>구매가격</label></th>
          <input type="hidden" name="buyPrice" class="text text_r dis"  title="구매가격" style="width:200px;" value="<%=hbDto.getBuyPrice() %>"   maxlength="9" />
<%--           <td><input type="text" name="buyPrice_view" value="<%=NumberUtil.getPriceFormat(hbDto.getBuyPrice()) %>" title="구매가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookAppView.buyPrice')" class="text text_r dis" readonly="readonly"/> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td><!-- input 비활성화 class="dis" 추가 --> --%>
          <td><input type="text" name="buyPrice_view" value="<%=NumberUtil.getPriceFormat(hbDto.getBuyPrice()) %>" title="구매가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookAppView.buyPrice')" class="text text_r" /> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td><!-- input 비활성화 class="dis" 추가 -->
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재자</label></th>
          <td>
          <!-- 결재자 NAME명 꺼내기. 현재 param넘기진않음. -->
           <input type="text" name="approvalUserNm" value="<%=hbDto.getApprovalName() %>" class="text dis" title="결재자" style="width:200px;" readonly="readonly"></input>
       	 	<!-- 결재자 ID값 넘겨줄값 or 휴북목록에 Insert됨.(approvalUser) -->
       	 	<input type="hidden" name="approvalUser" title="결재자" style="width:200px;" value="<%=hbDto.getApprovalUser() %>" ></input>
       	 </td>
   	  </tr>
   	  <tr>
        <th><label for="">구매처</label></th>
	          <td><input type="text" name="purchasingOffice" value="<%=hbDto.getPurchasingOffice() %>"  title="구매처" style="width:300px;" class="text" ></input></td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" value="" title="내용(목차)" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>승인/반려사유</label></th>
          <td><textarea name="approvalAndReturn" value="" title="승인/반려사유" style="width:916px;height:96px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getApprovalAndReturn() %></textarea></td>
       </tr>	
		 
				<%
				//반려
				}else if(statusChk4.equals(hbDto.getStatus())){
					
				%>
		<tr>
		   <th><label for="">신청일자</label></th>
          <td><span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getRequestDate()%>"></input></td><!-- input 비활성화 class="dis" 추가 -->
		</tr>		
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" value="" title="내용(목차)" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
       </tr>
       <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>승인/반려사유</label></th>
          <td><textarea name="approvalAndReturn" value="" title="승인/반려사유" style="width:916px;height:96px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getApprovalAndReturn() %></textarea></td>
       </tr>	
				<%
				//결재완료
				}else if(statusChk2.equals(hbDto.getStatus())){
					
				%>
		<tr>		
		  <th><label for="">신청일자</label></th>
			<td><span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getRequestDate()%>"></input></td><!-- input 비활성화 class="dis" 추가 -->
		</tr>
		<tr>
		   <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재일자</label></th>
		  <td><span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="clearDate" value="<%=hbDto.getClearDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getClearDate()%>"></input></td><!-- input 비활성화 class="dis" 추가 -->	
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>구매일자</label></th>
          <td><span class="ico_calendar"><input id="calendarData3" class="text" style="width:100px;" name="buyDate" value="<%=strDate%>"/></span><input type="hidden" value="<%=strDate%>"></input></td>
				<!-- 휴북목록에 Insert됨.(buyDate)동일 한 네임으로 -->
		</tr>
		<tr>
           <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>구매가격</label></th>
          <input type="hidden" name="buyPrice" class="text text_r"  title="구매가격" style="width:200px;" value=""   maxlength="9" />
                   <!-- 휴북목록에 Insert됨. (buyPrice) 동일한 네임으로 -->
          <td><input type="text" name="buyPrice_view" value=""  title="구매가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookAppView.buyPrice')" class="text text_r" /> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td><!-- input 비활성화 class="dis" 추가 -->
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재자</label></th>
          <td>
            <input type="text" name="approvalUserName" value="<%=hbDto.getApprovalName() %>" class="text dis" readonly="readonly"></input>
       	 	<!-- 결재자 ID넘겨줄값 휴북목록에 값 넘겨주기위해사용. -->
       	 	<input type="hidden" name="approvalUser" value="<%=hbDto.getApprovalUser() %>" ></input>
       	 	<!-- 분야 코드ID 넘겨줄값 휴북목록에 값 넘겨주기위해사용. -->
       	 	<input type="hidden" name="branchCode" value="<%=hbDto.getBranchCode() %>"></input>
       	 	<!-- 신청자 ID넘겨줄값 휴북목록에 값 넘겨주기위해사용. -->
       	 	<input type="hidden" name="requestUser" value="<%=hbDto.getRequestUser() %>"></input>
       	 </td>
       	 </tr>
       	 <tr>
        	<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>구매처</label></th>
	          <td><input type="text" name="purchasingOffice" value="<%=hbDto.getPurchasingOffice() %>"  title="구매처" style="width:300px;" class="text"></input></td>   
        		<!-- 휴북목록에 Insert됨. (purchasingOffice) 동일한 네임으로 -->
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" value="" title="내용(목차)" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
       </tr>
       <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>승인/반려사유</label></th>
          <td><textarea name="approvalAndReturn" value="" title="승인/반려사유" style="width:916px;height:96px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="text"><%=hbDto.getApprovalAndReturn() %></textarea></td>
       </tr>
				<%
				//신청중
				}else if(statusChk1.equals(hbDto.getStatus())){
					
				%>
		<tr>
			<th><label for="">신청일자</label></th>
			<td><span class="ico_calendar"><input id="calendarData" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readOnly/></span><input type="hidden" value="<%=hbDto.getRequestDate()%>"></input></td><!-- input 비활성화 class="dis" 추가 -->
		</tr>
		<tr>
		  <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재일자</label></th>
          <td><span class="ico_calendar"><input id="calendarData2" class="text" style="width:100px;" name="clearDate" value="<%=strDate%>"/></span><input type="hidden" value="<%=strDate%>"></input></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재자</label></th>
          <td><input type="text" name="user_nm" class="text" title="결재자" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales();"><a href="javascript:popSales();" class="btn_type03"><span>사원조회</span></a></td>
        </tr>
           <input type="hidden" name="approvalUser" value=""></input>
       	 	<!-- 사용자 넘겨줄값 -->
       	 </td>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" value="" title="내용(목차)" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
       </tr>
        <tr>
         <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>승인/반려사유</label></th>
          <td><textarea name="approvalAndReturn" value="" title="승인/반려사유" style="width:916px;height:96px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="text"></textarea></td>
       </tr>
				<%
				}
				%>
		</tbody>
      </table>
     </fieldset>
    </form>
   <!-- button -->
    <div class="Bbtn_areaC">
      <%
      	//로그인값체크후 버튼유무+진행상태값 체크후 버튼유뮤 비교2012.11.27(화)bsh.
    	statusChk1 = "1"; //(신청중)
        statusChk2 = "2"; //(결재완료)
        statusChk3 = "3"; //(구매완료)
      	statusChk4 = "4"; //(반려)
    	   if(statusChk3.equals(hbDto.getStatus()) || statusChk4.equals(hbDto.getStatus())){
      %>      
<!-- 	  <a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a> -->
	  <!-- button 이름 변경(재등록 -> 반려) 및 안내문구 추가(21.10.18) START -->
	  <a href="javascript:goSaveBuy2();" class="btn_type02"><span>반려</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a>
	  <br>
	  <br>
	  <h2>※구매완료건에 대한 상세정보 수정은 <strong><a href="<%= request.getContextPath()%>/B_HueBookList.do?cmd=hueBookPageList">휴북목록</a></strong>에서 가능합니다.</h2>
	  <!-- button 이름 변경(재등록 -> 반려) 및 안내문구 추가 END -->
      <% 
          }else if(statusChk2.equals(hbDto.getStatus())){
	  %>
      <a href="javascript:goSaveBuy();" class="btn_type02"><span>구매완료</span></a><a href="javascript:goReturns();" class="btn_type02 btn_type02_gray"><span>반려</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a>
	 <%    		    
     }else{
	 %>
      <a href="javascript:goSaveApp();" class="btn_type02"><span>승인</span></a><a href="javascript:goReturns();" class="btn_type02 btn_type02_gray"><span>반려</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a>
	 <%    	  
     }
     %>	   
    </div>
   <!-- //button -->
  </div>
  <!-- //con -->
</div>
<!-- //contents -->
</div>
<!-- //container -->
<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->
</div>
</body>
</html>
<script>

//select option값 Dto값체크후 동일한 목록 선택(상세보기사용)
document.hueBookAppView.requestBookCount.value='<%=hbDto.getRequestBookCount()%>';
</script>
<%= comDao.getMenuAuth(menulist,"51")%>
