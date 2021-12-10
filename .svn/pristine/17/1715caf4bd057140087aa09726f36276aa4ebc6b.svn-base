<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CommonDAO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
    
	CommonDAO comDao=new CommonDAO();
	 
	String sForm = (String)model.get("sForm");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt=(String)model.get("searchtxt");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>발행번호 리스트</title>
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
	var  formObj;//form 객체선언
	
	//초기세팅
	function init() {
		
		formObj=document.searchform; //form객체세팅
		
		searchInit(); //조회옵션 초기화
		
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
	//조회옵션 체크	
	function searchChk(){
	
		if( formObj.searchGb[0].selected==true){
			 formObj.searchtxt.disabled=true;
			 formObj.searchtxt.value='';	
		}else {
			 formObj.searchtxt.disabled=false;
		}
		
	}

	function goSearch() {
		
		var gubun=formObj.searchGb.value;

		if(gubun=='D'){
			if(formObj.searchtxt.value==''){
				alert('발행번호를 입력해 주세요');
				return;
			}
		}else if(gubun=='B'){
			if(formObj.searchtxt.value==''){
				alert('제목을 입력해 주세요');
				return;
			}
		}else if(gubun=='A'){
			if(formObj.searchtxt.value==''){
				alert('수신자를 입력해 주세요');
				return;
			}
		}
		openWaiting();
		formObj.submit();

    }

	function goSelect(no,recv,titl){
		
		var p_public_no=eval('opener.document.<%=sForm%>.p_public_no');
		var receiver=eval('opener.document.<%=sForm%>.InvoiceeContactName1');
		var title=eval('opener.document.<%=sForm%>.title');
		

		p_public_no.value=no;
		receiver.value=recv;
		title.value=titl;
		

		var obj=eval('opener.document.<%=sForm%>.checkyn');
		var obj2=eval('opener.document.<%=sForm%>.dpublicyn');

		if(obj!=undefined){

			if(compcode==''){
				obj.checked=true;
				e_comp_nm.style.display='block'
				comp_nm.style.display="none";
			}else{
				obj.checked=false;
				e_comp_nm.style.display='none'
				comp_nm.style.display="block";
			}
		}

		if(obj2!=undefined){

			if(dpublicyn=='Y'){
				obj2.checked=true;
			}else{
				obj2.checked=false;
			}
		}

		self.close();

	}
//-->
</SCRIPT>
</head>
<%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();

%>
<%= ld.getPageScript("searchform", "curPage", "goPage") %>
<body onLoad = "init()">
<form  method="post" name=searchform action = "<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNoConY_baro">
  <input type = "hidden" name="curPage"  value="<%=curPage%>">
  <input type = "hidden" name="sForm"  value="<%=sForm%>">
  <div id="wrap">
    <!-- title -->
    <div class="title">
      <h1 class="title_lft"><span class="title_rgt">발행번호 리스트</span></h1>
    </div>
    <!-- //title -->
    <!-- search -->
    <div class="msearch">
      <fieldset class="">
        <legend></legend>
 	<!-- 
        <select name="contractGb">
          <option value="ALL" >전체</option>
          <option checked value="Y"  >계약</option>
          <option value="N"  >미계약</option>
        </select>
 	 -->

        <select name="searchGb" class=""  onChange="searchChk()">
          <option checked value="">전체</option>
          <option value="D" >발행번호</option>
          <option value="B" >제목</option>
          <option value="A" >수신자</option>
        </select>
        <input type="text" name="searchtxt" style="ime-mode:active;width:200px" value="<%=searchtxt%>"  class="search" maxlength="100" >
        <a href="javascript:goSearch();"><img src="<%= request.getContextPath()%>/images/btn_search.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_search_on.gif'" onmousedown="this.src='<%= request.getContextPath()%>/images/btn_search_active.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_search.gif'" width="52" height="20" alt="검색" class="search_btn"//></a>
      </fieldset>
    </div>
    <!--//search -->
    <!-- contents -->
    <div id="contents">
      <div id="excelBody" class="con">
        <span class="tbl_line_top">&nbsp;</span>
        <table cellspacing="0" border="1" summary="발행번호 리스트" class="tbl_type">
          <caption>발행번호 리스트</caption>
          <colgroup>
          <col width="10%">
          <col width="">
          <col width="10%">
          <col width="18%">
          <col width="11%" span="3">
          </colgroup>
          <thead>
            <tr>
              <th rowspan="2">발행번호</th>
              <th rowspan="2">제목</th>
              <th colspan="2">고객정보</th>
              <th colspan="3">견적금액</th>
            </tr>
            <tr>
              <th>수신자</th>
              <th>업체명</th>
              <th>공급가</th>
              <th>부가세</th>
              <th>합계</th>
            </tr>
          </thead>
          <!-- :: loop :: -->
          <!--리스트---------------->
          <%			
if(ld.getItemCount() > 0){	
    int i = 0;
	long sprice=0;
	long vat=0;
	long total=0;

	while(ds.next()){
			sprice=ds.getLong("SUPPLY_PRICE");
			vat=ds.getLong("VAT");
			total=sprice+vat;
%>
          <tbody>
            <tr>
              <td><a href="javascript:goSelect('<%=ds.getString("PUBLIC_NO")%>','<%=ds.getString("RECEIVER")%>','<%=ds.getString("TITLE")%>')"><%=ds.getString("PUBLIC_NO")%></a></td>
              <td><%=ds.getString("TITLE")%></td>
              <td><%=ds.getString("RECEIVER")%></td>
              <td><%=ds.getString("E_COMP_NM")%></td>
              <td align="right"><%=NumberUtil.getPriceFormat(ds.getLong("SUPPLY_PRICE"))%></td>
              <td align="right"><%=NumberUtil.getPriceFormat(ds.getLong("VAT"))%></td>
              <td align="right"><%=NumberUtil.getPriceFormat(total)%></td>
            </tr>
            <!-- :: loop :: -->
            <%		
    i++;
    }
}else{
%>
            <tr>
              <td colspan="660" align="center">조회된 내역이 없습니다. </td>
            </tr>
            <% 
}
%>
          </tbody>
        </table>
        
      </div>
      <!-- //con -->
      <div>
     
      </div>
    
  <p class="noti2" align="left">계약된 견적서만 선택하실 수 있으며, 목록에 없는 경우 견적서발행 화면에서 해당 견적서의 계약 상태를 '계약'으로 수정하십시오.</p>
    </div>
    <!-- //contents -->
      
      <!-- paginate -->
      <div class="paginate">
        <%=ld.getPagging("goPage")%>
      </div>
      <!-- //paginate -->
    
    <!-- //button -->
    
    <div id="button">
      <a href="javascript:window.close()"><img src="<%= request.getContextPath()%>/images/btn_close.gif" width="40" height="23" title="닫기"/></a>
    </div>
    <!-- //button -->
  </div>
</div> 
</form>
</body>
</html>

