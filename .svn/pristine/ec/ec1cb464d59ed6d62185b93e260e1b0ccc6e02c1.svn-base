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

function goSave(){
	var frm = document.hueBookReView; 
	
	if(confirm("수정하시겠습니까?")){
		  frm.action='<%=request.getContextPath()%>/B_HueBookManageRe.do?cmd=hueBookManageEdit'	
	
	if(frm.bookName.value == ""){
		alert("도서명을 입력하세요.");
		return;
	}
	if(frm.writer.value == ""){
		alert("저자를 입력하세요.");
		return;
	}
	if(frm.branchCode.value == ""){
		alert("분야를 선택하세요.");
		return;
	}
	if(frm.publisher.value == ""){
		alert("출판사를 입력하세요.");
		return;
	}
	if(frm.requestBookCount.value == ""){
		alert("신청 (권)수를 선택하세요.");
		return;
	}
	if(frm.contents.value == ""){
		alert("내용(목차)를 입력하세요.");
		return;
	}
	frm.requestUser.value = frm.user_id.value;
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
		var costobj=document.hueBookReView;

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
		
		if(form=='hueBookReView.price_view'){	
			var price2=parseInt(onlyNum(costobj.price.value)*1,10);
			costobj.price.value=addCommaStr(''+price2);
		    costobj.price.value=price;	    
		    
		}
		v_obj.focus();
	}

   //목록
	function goList(){
		var frm = document.hueBookReView;
		frm.action='<%= request.getContextPath()%>/B_HueBookManageRe.do?cmd=hueBookRePageList';
		frm.submit();
   }
	//삭제
	function goDelete(){
		
		var frm = document.hueBookReView;
		if(confirm("삭제 하시겠습니까?")){
			frm.action='<%= request.getContextPath()%>/B_HueBookManageRe.do?cmd=hueBookReDelete';
			frm.submit();
		}

	}

//-->
</SCRIPT>
</head>
<body >
<div id="wrap">
<!-- header -->
<div id="header">
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
</div>
<!-- //header -->
<!-- container -->
<div id="container">
<!-- content -->
<div id="content">
  <!-- title -->
  <div class="content_navi">HUEBook &gt; 도서신청</div>
<h3><span>도</span>서신청상세정보</h3>
  <!-- //title -->
  <!-- con -->
  <div class="con">
<!-- 컨텐츠 상단 영역 -->
<div class="conTop_area">
	<!-- 필수입력사항텍스트 -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
	<!-- //필수입력사항텍스트 -->
</div>
<!-- //컨텐츠 상단 영역 -->
  
    <form name="hueBookReView" method="post">
     <input type = "hidden" name = "curPage" value="<%=curPage%>">
	  <input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>">
	    <!-- 사원조회해서 가져온 USER+NAME 담아서 넘겨줄값 -->
	  	 <input type = "hidden" name = "requestUser" value="">
	  	 <input type = "hidden" name = "requestName" value="<%=hbDto.getRequestName()%>">
	  	<!-- Update시 넘겨줄 히든(pk값) -->
	   <input type="hidden" name="SeqPk" value="<%=hbDto.getSeqPk()%>"></input>	 
	  	  <!-- 최종Update 넘겨줄 히든(status값)--> 
	  	  <input type="hidden" name="status" value="<%=hbDto.getStatus()%>"></input>
	  	  
	  	  <fieldset>
			<legend>도서신청상세정보</legend>
	  	  
      <table class="tbl_type" summary="도서신청상세정보(신청자, 분야, 도서명, 출판사, 저자, 역자, 가격, 신청(권)수, 신청일자, 결재일자, 구매일자, 구매가격, 결재자, 구매처, 내용(목차), 승인/반려사유)">
        <caption>도서신청 상세정보</caption>
        <colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
		<tbody>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청자</label></th>
          <td><input type="text" name="" class="text dis" title="신청자" style="width:200px;" readOnly value="<%=hbDto.getRequestName()%>"></input></td>	
       </tr>
       <%
    		
	    	//로그인값체크후 ReadOnly값+진행상태값 체크후 버튼유뮤 비교2012.11.22(목)bsh.
	   		String statusChk2 = "2"; //(결재완료)
	    	String statusChk3 = "3"; //(구매완료)
	   		String statusChk4 = "4"; //(반려)
	   		
	   		//세션로그인값 == 신청자값 체크
	      if(UserBroker.getUserId(request).equals(hbDto.getRequestUser())){
	   	   
	    	  //결재완료(2) 일때
	    	  if(statusChk2.equals(hbDto.getStatus())){
 			
    	%>
    	
    	<tr>
    		<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>분야</label></th>	
          	<td>
          		<input type="text" name="branchCode" value="<%=hbDto.getBranchCodeNm() %>" class="text dis" readonly="readonly" title="분야" style="width:200px;"></input>
          	</td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>도서명</label></th>
          <td><input type="text" name="bookName" value="<%=hbDto.getBookName() %>" title="도서명" style="width:916px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
	    </tr>
	    <tr>      
	          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>출판사</label></th>
	          <td><input type="text" name="publisher" value="<%=hbDto.getPublisher() %>"  title="출판사" style="width:300px;" maxlength="25"  class="text dis" readonly="readonly"></input></td>
      
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>저자</label></th>
          <td><input type="text" name="writer" value="<%=hbDto.getWriter() %>"  title="저자" style="width:300px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
		</tr>
		<tr>
	          <th><label for="">역자</label></th>
	          <td><input type="text" name="translator" value="<%=hbDto.getTranslator() %>"  title="역자" style="width:300px;" maxlength="25" class="text dis" readonly="readonly" ></input></td>
        </tr>
         <tr>
          <th><label for="">가격</label></th>
          <input type="hidden" name="price" class="text text_r dis"  style="width:80px" value="<%=hbDto.getPrice() %>"   maxlength="9" />
          <td><input type="text" name="price_view" value="<%=NumberUtil.getPriceFormat(hbDto.getPrice()) %>"  title="가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookReRegist.price')" class="text text_r dis" readonly="readonly" /> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td>
         </tr>
         <tr> 
          	  <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청(권)수</label></th>
	          <td>
				<input type="text" name="requestBookCount" value="<%=hbDto.getRequestBookCount() %>"  title="신청(권)수" style="width:50px;" class="text dis" readonly="readonly"></input>
	          </td>
			</tr>
        <tr>
         <th><label for="">신청일자</label></th>
          <td><input type="text" id="" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readonly="readonly"/></span>
			<input type="hidden" name="requestDate" value="<%=hbDto.getRequestDate()%>"></input>
				</td>
		</tr>
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재일자</label></th>
          <td>
          		<input type="text" id="" class="text dis" style="width:100px;" name="clearDate" value="<%=hbDto.getClearDate()%>" readonly="readonly"/>
				<input type="hidden" name="clearDate" class="in_txt" value="<%=hbDto.getClearDate()%>"></input>
          </td>
        </tr>				
		<tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재자</label></th>
          <td>
           <input type="text" name="approvalUserName" value="<%=hbDto.getApprovalName() %>" class="text dis" readonly="readonly"></input>	          
          </td>	
        </tr>   
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" title="내용(목차)" class="dis" value="" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>승인/반려사유</label></th>
          <td><textarea name="approvalAndReturn" value="" style="width:916px;height:96px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getApprovalAndReturn() %></textarea></td>
          </tr>
          
          <!-- 구매완료(3) 일때 -->
        <%}else if(statusChk3.equals(hbDto.getStatus())){ %>
        <tr>
				<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>분야</label></th>	
          	<td>
          		<!-- 분야코드NAME명 꺼내올값 현재PARAM넘기진않음. -->
          		<input type="text" name="branchCodeNm" value="<%=hbDto.getBranchCodeNm() %>" class="text dis" title="분야" style="width:200px;" readonly="readonly"></input>
          	</td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>도서명</label></th>
          <td><input type="text" name="bookName" value="<%=hbDto.getBookName() %>" title="도서명" style="width:916px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
	     </tr>
	     <tr>     
	          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>출판사</label></th>
	          <td><input type="text" name="publisher" value="<%=hbDto.getPublisher() %>"  title="출판사" style="width:300px;" maxlength="25"  class="text dis" readonly="readonly"></input></td>
      
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>저자</label></th>
          <td><input type="text" name="writer" value="<%=hbDto.getWriter() %>"  title="저자" style="width:300px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
		</tr>
		<tr>
	          <th><label for="">역자</label></th>
	          <td><input type="text" name="translator" value="<%=hbDto.getTranslator() %>"  title="역자" style="width:300px;" maxlength="25" class="text dis" readonly="readonly" ></input></td>
        </tr>
         <tr>
          <th><label for="">가격</label></th>
          <input type="hidden" name="price" class="text text_r dis"  style="width:80px" value="<%=hbDto.getPrice() %>"   maxlength="9" />
          <td><input type="text" name="price_view" value="<%=NumberUtil.getPriceFormat(hbDto.getPrice()) %>"  title="가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookReRegist.price')" class="text text_r dis" readonly="readonly" /> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td>
        </tr>
        <tr>
          	  <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청(권)수</label></th>
	          <td>
				<input type="text" name="requestBookCount" value="<%=hbDto.getRequestBookCount() %>"  title="신청(권)수" style="width:50px;" class="text dis" readonly="readonly"></input>
	          </td>
		</tr>
        <tr>
         <th><label for="">신청일자</label></th>
        	<td><input type="text" id="" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readonly="readonly"/>
			<input type="hidden" name="requestDate" value="<%=hbDto.getRequestDate()%>"></input>
				</td>
		</tr>
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재일자</label></th>
          <td>	
          	<input type="text" id="" class="text dis" style="width:100px;" name="clearDate" value="<%=hbDto.getClearDate()%>" readonly="readonly"/>
				<input type="hidden" name="clearDate" class="in_txt" value="<%=hbDto.getClearDate()%>"></input>
          </td>
        </tr>
        <tr>
         <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>구매일자</label></th>
          <td>
          	<input type="text" id="" class="text dis" style="width:100px;" name="buyDate" value="<%=hbDto.getBuyDate()%>" readonly="readonly"/>
				<input type="hidden" name="buyDate" class="text dis" value="<%=hbDto.getBuyDate()%>"></input>
				
          </td>
        </tr>
        <tr>
           <th><label for="">구매가격</label></th>
          <input type="hidden" name="buyPrice" class="text text_r dis" style="width:80px" value="<%=hbDto.getBuyPrice() %>"   maxlength="9" />
          <td><input type="text" name="buyPrice_view" value="<%=NumberUtil.getPriceFormat(hbDto.getBuyPrice()) %>"  style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookAppView.buyPrice')" class="text text_r dis" readonly="readonly" /> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재자</label></th>
          <td>
          <!-- 결재자 NAME명 꺼내기. 현재 param넘기진않음. -->
           <input type="text" name="approvalUserNm" value="<%=hbDto.getApprovalName() %>" class="text dis" readonly="readonly"></input>
       	 </td>
       	</tr>
       	<tr>
        	<th><label for="">구매처</label></th>
	        <td><input type="text" name="purchasingOffice" value="<%=hbDto.getPurchasingOffice() %>" style="width:300px;" maxlength="50" class="text dis" readonly="readonly"></input></td>
	         
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" value="" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>승인/반려사유</label></th>
          <td><textarea name="approvalAndReturn" value="" style="width:916px;height:96px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getApprovalAndReturn() %></textarea></td>
       </tr>
       
       <!-- 반려(4)일때 -->	
        <%}else if(statusChk4.equals(hbDto.getStatus())){%>
        <tr>
        	<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>분야</label></th>	
          	<td>
          		<input type="text" name="branchCodeNm" value="<%=hbDto.getBranchCodeNm() %>" class="text dis" title="분야" style="width:200px;" readonly="readonly"></input>
          	</td>
         </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>도서명</label></th>
          <td><input type="text" name="bookName" value="<%=hbDto.getBookName() %>" title="도서명" style="width:916px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
	     </tr>
	     <tr>     
	          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>출판사</label></th>
	          <td><input type="text" name="publisher" value="<%=hbDto.getPublisher() %>"  title="출판사" style="width:300px;" maxlength="25"  class="text dis" readonly="readonly"></input></td>
      
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>저자</label></th>
          <td><input type="text" name="writer" value="<%=hbDto.getWriter() %>"  title="저자" style="width:300px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
        </tr>
        <tr>

	          <th><label for="">역자</label></th>
	          <td><input type="text" name="translator" value="<%=hbDto.getTranslator() %>"  title="역자" style="width:300px;" maxlength="25" class="text dis" readonly="readonly" ></input></td>
        </tr>
         <tr>
          <th><label for="">가격</label></th>
          <input type="hidden" name="price" class="text text_r dis"  style="width:80px" value="<%=hbDto.getPrice() %>"   maxlength="9" />
          <td><input type="text" name="price_view" value="<%=NumberUtil.getPriceFormat(hbDto.getPrice()) %>"  title="가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookReRegist.price')" class="text text_r dis" readonly="readonly" /> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td>
        </tr>
        <tr>
          	  <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청(권)수</label></th>
	          <td>
				<input type="text" name="requestBookCount" value="<%=hbDto.getRequestBookCount() %>"  title="신청(권)수" style="width:50px;" class="text dis" readonly="readonly"></input>
	          </td>
			</tr>
        <tr>
         <th><label for="">신청일자</label></th>
        	<td><input type="text" id="" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readonly="readonly"/>
			<input type="hidden" name="requestDate" value="<%=hbDto.getRequestDate()%>"></input>
		</td>
        </tr>   
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" value=""vtitle="내용(목차)" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>승인/반려사유</label></th>
          <td><textarea name="approvalAndReturn" title="승인/반려사유" value="" style="width:916px;height:96px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getApprovalAndReturn() %></textarea></td>
       </tr>
       
       <!-- 신청중(1)일때 -->
       
        <%}else{ %>
        <tr>
         	<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>분야</label></th>	
				<td><%
							CodeParam codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("td3");
							codeParam.setFirst("전체");
							codeParam.setName("branchCode");
							codeParam.setSelected(hbDto.getBranchCode()); 
							//codeParam.setEvent("javascript:poductSet();"); 
							out.print(CommonUtil.getCodeList(codeParam,"A08")); 
						%>
				</td>
         
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>도서명</label></th>
          <td><input type="text" name="bookName" value="<%=hbDto.getBookName() %>" title="도서명" style="width:916px;" maxlength="50"  class="text"></input></td>
	     </tr>
	     <tr> 
	          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>출판사</label></th>
	          <td><input type="text" name="publisher" value="<%=hbDto.getPublisher() %>"  title="출판사" style="width:300px;" maxlength="25"  class="text"></input></td>
      
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>저자</label></th>
          <td><input type="text" name="writer" value="<%=hbDto.getWriter() %>"  title="저자" style="width:300px;" maxlength="50"  class="text"></input></td>
		</tr>
		<tr>
	          <th><label for="">역자</label></th>
	          <td><input type="text" name="translator" value="<%=hbDto.getTranslator() %>"  title="역자" style="width:300px;" maxlength="25" class="text"></input></td>
        </tr>
         <tr>
          <th><label for="">가격</label></th>
          <input type="hidden" name="price" class="text text_r dis"  style="width:80px" value="<%=hbDto.getPrice()%>"   maxlength="9" />
          <td><input type="text" name="price_view" value="<%=NumberUtil.getPriceFormat(hbDto.getPrice()) %>"  title="가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookReView.price')" class="text text_r"/> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td>
         </tr>
         <tr>
          	 <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청(권)수</label></th>
	          <td>
				<select name="requestBookCount">
					<option value="1권">1권</option>
					<option value="2권">2권</option>
					<option value="3권">3권</option>
					<option value="4권">4권</option>
					<option value="5권">5권</option>
					<option value="6권">6권</option>
					<option value="7권">7권</option>
					<option value="8권">8권</option>
					<option value="9권">9권</option>
					<option value="10권">10권</option>
					<option value="11권">11권</option>
					<option value="12권">12권</option>
					<option value="13권">13권</option>
					<option value="14권">14권</option>
					<option value="15권">15권</option>
					<option value="16권">16권</option>
					<option value="17권">17권</option>
					<option value="18권">18권</option>
					<option value="19권">19권</option>
					<option value="20권">20권</option>
				</select>
	          </td>
			</tr>
        <tr>
         <th><label for="">신청일자</label></th>
          	<td><input type="text" id="" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readonly="readonly"/></span>
			<input type="hidden" value="<%=hbDto.getRequestDate()%>"></input>
		 </td>
        </tr>   
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" title="내용(목차)" value="" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)"><%=hbDto.getContents() %></textarea></td>
        </tr>
         <%} %>
         <!-- 결재완료(2)일때 세션x -->
         <%}else if(statusChk2.equals(hbDto.getStatus())){ %>
         <tr>
         	<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>분야</label></th>	
          	<td>
          		<input type="text" name="branchCode" value="<%=hbDto.getBranchCodeNm() %>" title="분야" style="width:200px;" class="text dis" readonly="readonly"></input>
          	</td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>도서명</label></th>
          <td><input type="text" name="bookName" value="<%=hbDto.getBookName() %>" title="도서명" style="width:916px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
	     </tr>
	     <tr>     
	          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>출판사</label></th>
	          <td><input type="text" name="publisher" value="<%=hbDto.getPublisher() %>"  title="출판사" style="width:300px;" maxlength="25"  class="text dis" readonly="readonly"></input></td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>저자</label></th>
          <td><input type="text" name="writer" value="<%=hbDto.getWriter() %>"  title="저자" style="width:300px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
		</tr>
		<tr>
	          <th><label for="">역자</label></th>
	          <td><input type="text" name="translator" value="<%=hbDto.getTranslator() %>"  title="역자" style="width:300px;" maxlength="25" class="text dis" readonly="readonly" ></input></td>
        </tr>
         <tr>
          <th><label for="">가격</label></th>
          <input type="hidden" name="price" class="text text_r dis"  style="width:80px" value="<%=hbDto.getPrice() %>"   maxlength="9" />
          <td><input type="text" name="price_view" value="<%=NumberUtil.getPriceFormat(hbDto.getPrice()) %>"  title="가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookReRegist.price')" class="text text_r dis" readonly="readonly" /> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td>
         </tr>
         <tr>
          	  <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청(권)수</label></th>
	          <td>
				<input type="text" name="requestBookCount" value="<%=hbDto.getRequestBookCount() %>"  title="신청(권)수" style="width:50px;" class="text dis" readonly="readonly"></input>
	          </td>
			</tr>
        <tr>
         <th><label for="">신청일자</label></th>
          <td><input type="text" id="" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readonly="readonly"/>
          	<input type="hidden" name="requestDate" value="<%=hbDto.getRequestDate()%>"></input>
		  </td>
		</tr>
		<tr>		
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재일자</label></th>
          <td>		
          <input type="text" id="" class="text dis" style="width:100px;" name="clearDate" value="<%=hbDto.getClearDate()%>" readonly="readonly"/>
				<input type="hidden" name="clearDate" class="text dis" value="<%=hbDto.getClearDate()%>"></input>
          </td>
        </tr>				
		<tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재자</label></th>
          <td>
           <input type="text" name="approvalUserName" title="결재자" style="width:200px;" value="<%=hbDto.getApprovalName() %>" class="text dis" readonly="readonly"></input>	          
          </td>	
        </tr>   
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" value="" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>승인/반려사유</label></th>
          <td><textarea name="approvalAndReturn" value="" style="width:916px;height:96px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getApprovalAndReturn() %></textarea></td>
        </tr>
		<!-- 구매완료(3)일때 세션x -->
         <%}else if(statusChk3.equals(hbDto.getStatus())){ %>
         <tr>
            <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>분야</label></th>	
          	<td>
          		<!-- 분야코드NAME명 꺼내올값 현재PARAM넘기진않음. -->
          		<input type="text" name="branchCode" value="<%=hbDto.getBranchCodeNm() %>" title="분야" style="width:200px;" class="text dis" readonly="readonly"></input>
          	</td>
        </tr>
         <tr>
         <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>도서명</label></th>
          <td><input type="text" name="bookName" value="<%=hbDto.getBookName() %>" title="도서명" style="width:916px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
	     </tr>
	     <tr>     
	          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>출판사</label></th>
	          <td><input type="text" name="publisher" value="<%=hbDto.getPublisher() %>"  title="출판사" style="width:300px;" maxlength="25"  class="text dis" readonly="readonly"></input></td>
      
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>저자</label></th>
          <td><input type="text" name="writer" value="<%=hbDto.getWriter() %>"  title="저자" style="width:300px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
		</tr>
		<tr>
	          <th><label for="">역자</label></th>
	          <td><input type="text" name="translator" value="<%=hbDto.getTranslator() %>"  title="역자" style="width:300px;" maxlength="25" class="text dis" readonly="readonly" ></input></td>
        </tr>
         <tr>
          <th><label for="">가격</label></th>
          <input type="hidden" name="price" class="text text_r dis"  style="width:80px" value="<%=hbDto.getPrice() %>"   maxlength="9" />
          <td><input type="text" name="price_view" value="<%=NumberUtil.getPriceFormat(hbDto.getPrice()) %>"  title="가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookReRegist.price')" class="text text_r dis" readonly="readonly" /> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td>
         </tr>
         <tr>
          	  <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청(권)수</label></th>
	          <td>
				<input type="text" name="requestBookCount" value="<%=hbDto.getRequestBookCount() %>"  title="신청(권)수" style="width:50px;" class="text dis" readonly="readonly"></input>
	          </td>
			</tr>
        <tr>
         <th><label for="">신청일자</label></th>
          <td><input type="text" id="" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readonly="readonly"/>
				<input type="hidden" name="requestDate" value="<%=hbDto.getRequestDate()%>"></input>
				</td>
 		</tr>
 		<tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재일자</label></th>
          <td>
          <input type="text" id="" class="text dis" style="width:100px;" name="clearDate" value="<%=hbDto.getClearDate()%>" readonly="readonly"/>
				<input type="hidden" name="clearDate" class="text dis" value="<%=hbDto.getClearDate()%>"></input>
				
          </td>
        </tr>
        <tr>
         <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>구매일자</label></th>
          <td>
          <input type="text" id="" class="text dis" style="width:100px;" name="buyDate" value="<%=hbDto.getBuyDate()%>" readonly="readonly"/>
				<input type="hidden" name="buyDate" class="text dis" value="<%=hbDto.getBuyDate()%>"></input>
				
          </td>
         </tr>
         <tr>
           <th><label for="">구매가격</label></th>
          <input type="hidden" name="buyPrice" class="text text_r dis"  style="width:80px" value="<%=hbDto.getBuyPrice() %>"   maxlength="9" />
          <td><input type="text" name="buyPrice_view" value="<%=NumberUtil.getPriceFormat(hbDto.getBuyPrice()) %>"  style="width:80px" maxlength="9"  onKeyUp = "saleCntCal('hueBookAppView.buyPrice')" class="text text_r dis" readonly="readonly" /> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재자</label></th>
          <td>
          <!-- 결재자 NAME명 꺼내기. 현재 param넘기진않음. -->
           <input type="text" name="approvalUserName" title="결재자" style="width:200px;" value="<%=hbDto.getApprovalName() %>" class="text dis" readonly="readonly"></input>
       	 </td>
       </tr>
       <tr>
        <th><label for="">구매처</label></th>
	          <td><input type="text" name="purchasingOffice" value="<%=hbDto.getPurchasingOffice() %>" title="구매처" style="width:300px;" maxlength="50" class="text dis" readonly="readonly"></input></td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" value="" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
        </tr>
        <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>승인/반려사유</label></th>
          <td><textarea name="approvalAndReturn" value="" style="width:916px;height:96px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getApprovalAndReturn() %></textarea></td>
       </tr>
       <!-- 반려(4)일때 세션x -->
         <%}else if(statusChk4.equals(hbDto.getStatus())){ %>
         <tr>
         	<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>분야</label></th>
          	<td>
          		<input type="text" name="branchCode" value="<%=hbDto.getBranchCodeNm() %>" title="분야" style="width:200px;" class="text dis" readonly="readonly"></input>
          	</td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>도서명</label></th>
          <td><input type="text" name="bookName" value="<%=hbDto.getBookName() %>" title="도서명" style="width:916px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
	     </tr>
	     <tr>     
	          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>출판사</label></th>
	          <td><input type="text" name="publisher" value="<%=hbDto.getPublisher() %>"  title="출판사" style="width:300px;" maxlength="25"  class="text dis" readonly="readonly"></input></td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>저자</label></th>
          <td><input type="text" name="writer" value="<%=hbDto.getWriter() %>"  title="저자" style="width:300px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
		</tr>
		<tr>
	          <th><label for="">역자</label></th>
	         <td><input type="text" name="translator" value="<%=hbDto.getTranslator() %>"  title="역자" style="width:300px;" maxlength="25" class="text dis" readonly="readonly" ></input></td>
        </tr>
         <tr>
          <th><label for="">가격</label></th>
          <input type="hidden" name="price" class="text text_r dis"  style="width:80px" value="<%=hbDto.getPrice() %>"   maxlength="9" />
          <td><input type="text" name="price_view" value="<%=NumberUtil.getPriceFormat(hbDto.getPrice()) %>"  title="가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookReRegist.price')" class="text text_r dis" readonly="readonly" /> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td>
          </tr>
          <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청(권)수</label></th>
	          <td>
				<input type="text" name="requestBookCount" value="<%=hbDto.getRequestBookCount() %>"  title="신청(권)수" style="width:50px;" class="text dis" readonly="readonly"></input>
	          </td>
			</tr>
        <tr>
         <th><label for="">신청일자</label></th>
          <td><input type="text" id="" class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readonly="readonly"/>
          	<input type="hidden" name="requestDate" value="<%=hbDto.getRequestDate()%>"></input>
		  </td>
        </tr>   
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" value="" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>승인/반려사유</label></th>
          <td><textarea name="approvalAndReturn" value="" style="width:916px;height:96px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getApprovalAndReturn() %></textarea></td>
          </tr>
         <!-- 신청중(1)일때 세션x -->
         <%}else{%>
         <tr>
         	<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>분야</label></th>
          	<td>
          		<!-- 분야코드NAME명 꺼내올값 현재PARAM넘기진않음. -->
          		<input type="text" name="branchCode" value="<%=hbDto.getBranchCodeNm() %>" title="분야" style="width:200px;" class="text dis" readonly="readonly"></input>
          	</td>
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>도서명</label></th>
          <td><input type="text" name="bookName" value="<%=hbDto.getBookName() %>" title="도서명" style="width:916px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
	     </tr>
	     <tr>    
	          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>출판사</label></th>
	          <td><input type="text" name="publisher" value="<%=hbDto.getPublisher() %>"  title="출판사" style="width:300px;" maxlength="25"  class="text dis" readonly="readonly"></input></td>
      
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>저자</label></th>
          <td><input type="text" name="writer" value="<%=hbDto.getWriter() %>"  title="저자" style="width:300px;" maxlength="50"  class="text dis" readonly="readonly"></input></td>
		</tr>
		<tr>
	          <th><label for="">역자</label></th>
	          <td><input type="text" name="translator" value="<%=hbDto.getTranslator() %>"  title="역자" style="width:300px;" maxlength="25" class="text dis" readonly="readonly" ></input></td>
        </tr>
         <tr>
          <th><label for="">가격</label></th>
          <input type="hidden" name="price" class="text text_r dis"  style="width:80px" value="<%=hbDto.getPrice() %>"   maxlength="9" />
          <td><input type="text" name="price_view" value="<%=NumberUtil.getPriceFormat(hbDto.getPrice()) %>"  title="가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookReRegist.price')" class="text text_r dis" readOnly /> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td>
          </tr>
          <tr>
          	  <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청(권)수</label></th>
	          <td>
				<input type="text" name="requestBookCount" value="<%=hbDto.getRequestBookCount() %>"  title="신청(권)수" style="width:50px;" class="text dis" readonly="readonly"></input>
	          </td>
			</tr>
        <tr>
         <th><label for="">신청일자</label></th>
           <td><input type="text" id=""readonly="readonly"  class="text dis" style="width:100px;" name="requestDate" value="<%=hbDto.getRequestDate()%>" readonly="readonly"/>
				<input type="hidden" name="requestDate" value="<%=hbDto.getRequestDate()%>"></input>
		</td>
		</tr>		
		<tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath() %>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" value="" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)" class="dis" readonly="readonly"><%=hbDto.getContents() %></textarea></td>
        </tr>
         <%} %>
		</tbody>
      </table>
      </fieldset>
    </form>
   <!-- button -->
    <div class="Bbtn_areaC">
      <%
      	//로그인값체크후 버튼유무+진행상태값 체크후 버튼유뮤 비교2012.11.22(목)bsh.
    	statusChk2 = "2"; //(결재완료)
      	statusChk3 = "3"; //(구매완료)
        statusChk4 = "4"; //(반려)
       if(UserBroker.getUserId(request).equals(hbDto.getRequestUser())){
    	   //구매완료이거나 반려일때 는 목록버튼만.
    	   if(statusChk3.equals(hbDto.getStatus()) || statusChk4.equals(hbDto.getStatus())){
      %>      
	  <a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a>
      <% 
      	  //결재완료일때는 삭제 목록버튼만.
          }else if(statusChk2.equals(hbDto.getStatus())){
	  %>
      <a href="javascript:goDelete()" class="btn_type02 btn_type02_gray"><span>삭제</span></a><a href="javascript:goList()" class="btn_type02 btn_type02_gray"><span>목록</span></a> 	   
   	     <%
   	     //신청중일때는 수정 삭제 목록 버튼만.
   	     }else{
   	    	 
   	     %>
   	     <a href="javascript:goSave()" class="btn_type02"><span>수정</span></a><a href="javascript:goDelete()" class="btn_type02 btn_type02_gray"><span>삭제</span></a><a href="javascript:goList()" class="btn_type02 btn_type02_gray"><span>목록</span></a> 
   	     <%
   	     }
   	     %>
	 <%
	 //로그인 세션값이 틀릴때는 목록버튼만.
     }else{
	 %>
      <a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a>
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
document.hueBookReView.requestBookCount.value='<%=hbDto.getRequestBookCount()%>';
</script>
<%= comDao.getMenuAuth(menulist,"50")%>
