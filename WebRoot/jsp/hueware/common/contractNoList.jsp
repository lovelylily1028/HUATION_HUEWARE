<%@page import="com.huation.common.CommonDAO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>

<%

	CommonDAO comDao=new CommonDAO();
	Map model = (Map)request.getAttribute("MODEL"); 
	
	String sForm = (String)model.get("sForm");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");


%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>계약관리 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.8.20.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/popup.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.8.20.custom.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
<script type="text/javascript">
//스트라이프 테이블
$(function(){
	$("tr:nth-child(odd)").addClass("odd");
	$("tr:nth-child(even)").addClass("even");
	
	//마우스오버로 행에 하이라이트효과
	$("tr:not(:first-child)").mouseover(function(){
		$(this).addClass("hover");
	}).mouseout(function(){
		$(this).removeClass("hover");
	});
});

var  formObj;//form 객체선언
//초기세팅
function init() {
	
	formObj=document.contractMgPageListForm; //form객체세팅
	
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
/*
 * 검색
 */
function goSearch() {
	
	var gubun= formObj.searchGb.value;
	
	if(gubun=='1'){
		if( formObj.searchtxt.value==''){
			alert('계약번호를 입력해주세요.');
			return;
		}
	}else if(gubun=='2'){
		if( formObj.searchtxt.value==''){
			alert('견적번호를 입력해주세요.');
			return;
		}
	}else if(gubun=='3'){
		if( formObj.searchtxt.value==''){
			alert('발주사명을 입력해주세요.');
			return;
		}
	}

	openWaiting();
	
	formObj.curPage.value='1';
	formObj.submit();

}
//선택해서 값 넘겨라
function goSelect(no,recv,titl){
	
	var contract_no=eval('opener.document.<%=sForm%>.contract_no');
	var public_no=eval('opener.document.<%=sForm%>.p_public_no');
	var title=eval('opener.document.<%=sForm%>.title');
	

	contract_no.value=no;
	public_no.value=recv;
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








//상세페이지 이동
function goDetail(contractcode){

	 formObj.target ='_self';
	 formObj.action = "<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgView";
	 formObj.ContractCode.value=contractcode;
	 formObj.submit();
}

//Excel Down
function goExcel() {  
	
	 formObj.action = "<%=request.getContextPath()%>/B_ContractManage.do?cmd=contractMgExcel";	
	 formObj.submit();
	 formObj.action = "<%=request.getContextPath()%>/B_ContractManage.do?cmd=contractMgPageList";	
}


//세금계산서 발행번호 리스트
function goInvoiceList(contractcode,contractname){

	var a = window.open("<%= request.getContextPath()%>/B_ContractManage.do?cmd=invoiceDetailList&contractcode="+contractcode+"&contractname="+contractname,"","width=860,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=yes, status=no");

}
//-->
</script>
</head>
<body onload="init();">
<div id="wrap">
<!-- header -->

<!-- //header -->
<!-- container -->
<div id="container">
<div class="clear">
</div>
<!-- lnb -->

<!-- //lnb -->
<!-- contents -->
<div class="contents">
  <%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
  <%=ld.getPageScript("contractMgPageListForm", "curPage", "goPage")%>
  <form method="post" name="contractMgPageListForm" action="<%=request.getContextPath()%>/B_Common.do?cmd=searchContractNoConY_baro">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
    <input type="hidden" name="ContractCode" value=""/>
    <input type = "hidden" name="sForm"  value="<%=sForm%>">
    
    
    <!-- title -->
    <div class="title">
     <h2>계약관리</h2>
    </div>
    <!-- //title -->
    <!-- search -->
    <div class="msearch">
      <fieldset class="">
        <legend>검색</legend>
          <select name="searchGb" onchange="searchChk()" id="" class="">
          <option checked value="">전체</option>
          <option value="1" >계약번호</option>
          <option value="2" >견적번호</option>
          <option value="3" >발주사명</option>
        </select>
        <input type="text" name="searchtxt" style="ime-mode:active;width:200px" class="search" maxlength="100" id="textfield_search2" value="<%=searchtxt %>" />
        <a href="javascript:goSearch();"><img src="<%= request.getContextPath()%>/images/btn_search.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_search_on.gif'" onmousedown="this.src='<%= request.getContextPath()%>/images/btn_search_active.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_search.gif'" width="52" height="20" alt="검색" class="search_btn"/></a>
        <a href="javascript:goExcel();"><img src="<%= request.getContextPath()%>/images/btn_download.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_download_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_download.gif'" width="66" height="20" alt="엑셀다운로드" class="search_btn" style="padding:0 5px"/></a>
      </fieldset>
    </div>
    <!--//search -->
    <!-- con -->
    <div class="con">
      <span class="tbl_line_top"></span>
      <table cellspacing="0" border="1" cellpadding="0" summary="" class="tbl_type" style="table-layout:fixed">
        <caption>계약관리 리스트</caption>
        <tr>
          <th width="8" rowspan="2">계약번호</th>
          <th width="8" rowspan="2">견적번호</th>
          <th width="4" rowspan="2">계약서</th>
          <th width="4" rowspan="2">발주서</th>
          <th width="5" rowspan="2">견적서</th>
          <th width="5" rowspan="2">발주사</th>
          <th width="20" rowspan="2">계약명</th>
          <th width="20" colspan="3">계약금액</th>
          <th width="15" colspan="2">계산서 발행금액</th>
          <th width="15" colspan="2">수금액</th>
          <th width="5" rowspan="2">계약종료 </br>여부 </th>
        </tr>
        <tr>
          <th>공급가</th>
          <th>부가세</th>
          <th>합계</th>
          
          <th>누적 발행금액</th>
          <th>미 발행금액</th>
  
   		  <th>총 수금액</th>
          <th>미 수금액</th>
        </tr>
        <!-- :: loop :: -->
        <!--리스트---------------->
        <%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
               
                String Status = ds.getString("ContractStatus"); //계약종결 여부 플래그 값
                String StatusStr = "";							//계약종결 여부 플래그 뷰잉 값
                String StatusColor = "";						//계약종결 여부 플래그 뷰잉 컬러 값
                if(Status.equals("1")){
                	StatusStr = "-";
                }else if(Status.equals("2")){
                	StatusStr = "조기종료";
                	StatusColor = "#F29661";
                }else if(Status.equals("3")){
                	StatusStr = "계약종결";
                	StatusColor = "#2F9D27";
                }
        %>
        <tr>
          <td><a href="javascript:goSelect('<%=ds.getString("ContractCode")%>','<%=ds.getString("Public_No")%>','<%=ds.getString("ContractName")%>')"><%=ds.getString("ContractCode")%></a>
          	<a href="javascript:goInvoiceList('<%=ds.getString("ContractCode")%>','<%=ds.getString("ContractName")%>');"><img src="<%= request.getContextPath()%>/images/btn_issue_list.gif" width="60" height="18" title="세금계산서발행내역" /></a>
          </td>
       	  <td><font color="<%=StatusColor%>"><%=ds.getString("Public_No")%></font></td>
          <td>
          <!-- 계약서 파일 시작. -->
          <%if(!ds.getString("ContractFile").equals("")){ %>
          <%
                   String ContractFile=ds.getString("ContractFile");
          
//                    String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=ContractFile.lastIndexOf("/");
                  	
                    String contractfilename=ContractFile.substring(c_index+1);
              
                    String contractfilepath=""; //파일경로 읽어오기
                   
                    	
          
                    if(!ContractFile.equals("")){
                    	contractfilepath=ContractFile.substring(0,c_index); //파일경로 읽어오기
          %>
          <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("ContractFileNm")%>&sFileName=<%=contractfilename%>&filePath=<%=contractfilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" width="16" height="16" align="absmiddle" title="계약서"></a>
          <%
                     }
               
          %>
		<!--계약서 없을때.  -->
          <%}else{ %>
          -
          <%} %>
          <!-- 계약서 파일 끝. -->
          </td>
          <td>
          <!-- 발주서 파일 시작. -->
          <%if(!ds.getString("PurchaseOrderFile").equals("")){ %>
          <%
                   String PurchaseOrderFile=ds.getString("PurchaseOrderFile");
          
//                    String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=PurchaseOrderFile.lastIndexOf("/");
                  	
                    String purchasefilename=PurchaseOrderFile.substring(c_index+1);
              
                    String purchasefilepath=""; //파일경로 읽어오기
                   
                    	
          
                    if(!PurchaseOrderFile.equals("")){
                    	purchasefilepath=PurchaseOrderFile.substring(0,c_index); //파일경로 읽어오기
          %>
          <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("PurchaseOrderFileNm")%>&sFileName=<%=purchasefilename%>&filePath=<%=purchasefilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" width="16" height="16" align="absmiddle" title="발주서"></a>
          <%
                     }
               
          %>
		<!--발주서 없을때.  -->
          <%}else{ %>
          -
          <%} %>
          <!-- 계약서 파일 끝. -->
          </td>
          <td>
          <!-- 견적서 파일 시작. -->
         <%if(!ds.getString("Estimate_E_File").equals("") || !ds.getString("Estimate_P_File").equals("")){%>
         <%
	     	//2013_11_26(화)shbyeon.
	     	//견적서 발행에서 엑셀,PDF 파일 첨부 & 수정시 나오게될 LIST
	     	//수정할때마다 새로운 첨부 파일로 UPDATE 된다.
            String Estimate_E_File=ds.getString("Estimate_E_File");
	     	String Estimate_E_FileNm=ds.getString("Estimate_E_FileNm");
	     	String Estimate_P_File = ds.getString("Estimate_P_File");
            String Estimate_P_FileNm = ds.getString("Estimate_P_FileNm");
//             String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
          //serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
			String serverUrl = "" + request.getContextPath();
            int x_index=Estimate_E_File.lastIndexOf("/"); //엑셀파일
            int p_index=Estimate_P_File.lastIndexOf("/"); //PDF파일
                    
            String Esti_xls_filename=Estimate_E_File.substring(x_index+1);
            String Esti_pdf_filename=Estimate_P_File.substring(p_index+1);
                    
            String Esti_xls_path="";
            String Esti_pdf_path="";
             
          if(!Estimate_E_File.equals("")){
        	  
        	  Esti_xls_path=Estimate_E_File.substring(0,x_index); //파일경로 읽어오기 
        	  
            if(Estimate_E_FileNm.equals("")){  	
            %>
            <!-- 엑셀파일명이 존재하지 않을 경우(기존 견적서발행에서의 파일이름없는 데이터 가져올때) -->
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=Esti_xls_filename%>&sFileName=<%=Esti_xls_filename%>&filePath=<%=Esti_xls_path%>" ><img src="<%= request.getContextPath()%>/images/ico_excel.gif" width="16" height="16" align="absmiddle" title="견적서(EXCEL)"></a>
            <%
            }else if(!Estimate_E_FileNm.equals("")){            	
            %>
			<!-- 엑셀파일명이 존재 하는경우(파일이름있는 데이터 가져올때. 기존 견적서에서의 첨부된 파일은 파일이름이 존재하지않고 실제 파일경로로 첨부 되었기 때문.) -->
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("Estimate_E_FileNm")%>&sFileName=<%=Esti_xls_filename%>&filePath=<%=Esti_xls_path%>" ><img src="<%= request.getContextPath()%>/images/ico_excel.gif" width="16" height="16" align="absmiddle" title="견적서(EXCEL)"></a>
            <%
            }
            %>
          <%
          }
          %>
        <%if(!Estimate_P_File.equals("")){ 
        	
        	Esti_pdf_path=Estimate_P_File.substring(0,p_index); //파일경로 읽어오기 
        %> 
            <%
            if(Estimate_P_FileNm.equals("")){
            %>
            <!-- PDF파일명이 존재하지 않을 경우(기존 견적서발행에서의 파일이름없는 데이터 가져올때) -->
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=Esti_pdf_filename%>&sFileName=<%=Esti_pdf_filename%>&filePath=<%=Esti_pdf_path%>" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" align="absmiddle" title="견적서(PDF)"></a>
            <%
            }else if(!Estimate_P_FileNm.equals("")){
            %>
            <!-- PDF파일명이 존재 하는경우(파일이름있는 데이터 가져올때. 기존 견적서에서의 첨부된 파일은 파일이름이 존재하지않고 실제 파일경로로 첨부 되었기 때문.) -->
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("Estimate_P_FileNm")%>&sFileName=<%=Esti_pdf_filename%>&filePath=<%=Esti_pdf_path%>" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" align="absmiddle" title="견적서(PDF)"></a>
         	<%
            }
         	%>
         <%
         }
         %>
     <!-- 견적서 없을때. -->
      <%}else{ %>
      	-
      <%}%>
         
          <!-- 견적서 파일 끝. -->
          </td>
          <td><font color="<%=StatusColor%>"><%=ds.getString("Ordering_Organization") %></font></td>
          <td><font color="<%=StatusColor%>"><%=ds.getString("ContractName") %></font></td>
          <td align="right"><font color="<%=StatusColor%>"><%=NumberUtil.getPriceFormat(ds.getLong("SUPPLY_PRICE"))%></font></td>
          <td align="right"><font color="<%=StatusColor%>"><%=NumberUtil.getPriceFormat(ds.getLong("VAT"))%></font></td>
          <%
				long sprice=ds.getLong("SUPPLY_PRICE");
				long vat=ds.getLong("VAT");
				long total=sprice+vat;
		  %>
          <td align="right"><font color="<%=StatusColor%>"><%=NumberUtil.getPriceFormat(total)%></font></td>
          <td><font color="<%=StatusColor%>">-</font></td>
          <td><font color="<%=StatusColor%>">-</font></td>
          <td><font color="<%=StatusColor%>">-</font></td>
          <td><font color="<%=StatusColor%>">-</font></td>
          <td><font color="<%=StatusColor%>"><%=StatusStr %></font></td>

          
        </tr>
        <!-- :: loop :: -->
        <%
                i++;
                    }
                } else {
            %>
        <tr>
          <td colspan="15">게시물이 없습니다.</td>
        </tr>
        <%
                }
            %>
      </table>
    </div>
    <!-- //con -->
    <!-- paginate -->
    <div class="paginate">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //paginate -->
  </form>
</div>
<!-- //contents -->
</div>
<!-- //container -->

</div>
</body>
</html>
