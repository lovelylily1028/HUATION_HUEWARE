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
	if(searchGb.equals("")&&searchtxt.equals(""))searchGb = "3";


%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>계약관리 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
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

	
	formObj.curPage.value='1';
	formObj.submit();

}
//선택해서 값 넘겨라
function goSelect(no,recv,titl,supplyprice,vat1,reciver1){
	
	var contract_no=eval('opener.document.<%=sForm%>.contract_no');
	var public_no=eval('opener.document.<%=sForm%>.p_public_no');
	var title=eval('opener.document.<%=sForm%>.title');
	var supply_price=eval('opener.document.<%=sForm%>.supply_price_view');
	var vat=eval('opener.document.<%=sForm%>.vat_view');
	var receiver=eval('opener.document.<%=sForm%>.receiver');
	var total1=eval('opener.document.<%=sForm%>.total_amt_view');
	
	
	var total = parseInt(vat1)+parseInt(supplyprice);
	
	/*alert(contract_no);
	alert(public_no);
	alert(title);
	alert(supply_price);
	alert(vat);
	alert(receiver); */
	contract_no.value = no;
	public_no.value = recv;
	title.value = titl;
	supply_price.value = supplyprice;
	vat.value = vat1;
	receiver.value = reciver1;
	total1.value = total;
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
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>계약관리 리스트</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<!-- 조회 -->
  <%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
  <%=ld.getPageScript("contractMgPageListForm", "curPage", "goPage")%>
  <form method="post" name="contractMgPageListForm" action="<%=request.getContextPath()%>/B_Common.do?cmd=searchContractNoConY_baro" class="search">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
    <input type="hidden" name="ContractCode" value=""/>
    <input type = "hidden" name="sForm"  value="<%=sForm%>" />
    <fieldset>
   <legend>검색</legend>
		<ul>
          <li><select name="searchGb" onchange="searchChk()" id="" class="">
          <option value="">전체</option>
          <option value="1" >계약번호</option>
          <option value="2" >견적번호</option>
          <option selected="selected" value="3" >발주사명</option>
        </select></li>
        <li><input type="text" name="searchtxt" title="검색어" class="text" maxlength="100" id="textfield_search2" value="<%=searchtxt %>" /></li>
        <li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
       </ul>
      </fieldset>
    </form>
    <!-- //조회 -->
	<!-- Top 버튼영역 -->
     <div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray md0"><span>내려받기</span></a></div>
    <!-- //Top 버튼영역 -->
	</div>
	<!-- //컨텐츠 상단 영역 -->
	<!-- 리스트 -->
      <table class="tbl_type tbl_type_list" summary="계약관리리스트(계약번호, 견적번호, 계약서, 발주서, 견적서, 발주사, 계약명, 계약금액(공급가, 부가세, 합계), 계산서발행금액(누적발행금액, 미발행금액), 수금액(총수금액, 미수금액), 계약종료여부)">
        <caption>계약관리 리스트</caption>
        <colgroup>
				<col width="7%" />
				<col width="7%" />
				<col width="3%" />
				<col width="3%" />
				<col width="4%" />
				<col width="8%" />
				<col width="*" />
				<col width="7%" />
				<col width="7%" />
				<col width="7%" />
				<col width="7%" />
				<col width="7%" />
				<col width="7%" />
				<col width="7%" />
				<col width="4.5%" />
			</colgroup>
			<thead>
			<tr>
				<th rowspan="2">계약번호</th>
				<th rowspan="2">견적번호</th>
				<th rowspan="2">계약서</th>
				<th rowspan="2">발주서</th>
				<th rowspan="2">견적서</th>
				<th rowspan="2">발주사</th>
				<th rowspan="2">계약명</th>
				<th colspan="3">계약금액</th>
				<th colspan="2">계산서발행금액</th>
				<th colspan="2">수금액</th>
				<th rowspan="2">계약종료여부</th>
			</tr>
			<tr>
				<th>공급가</th>
				<th>부가세</th>
				<th>합계</th>
				<th>누적발행금액</th>
				<th>미발행금액</th>
				<th>총수금액</th>
				<th>미수금액</th>
			</tr>
			</thead>
			<tbody>
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
                	StatusColor = "txtColor_contractEarly";
                }else if(Status.equals("3")){
                	StatusStr = "계약종결";
                	StatusColor = "txtColor_contractEnd";
                }
        %>
        <tr class="<%=StatusColor%>">
          <td><a href="javascript:goSelect('<%=ds.getString("ContractCode")%>','<%=ds.getString("Public_No")%>','<%=ds.getString("ContractName")%>','<%=ds.getString("SUPPLY_PRICE")%>','<%=ds.getString("VAT")%>','<%=ds.getString("RECEIVER")%>')"><%=ds.getString("ContractCode")%></a>
          	
          </td>
       	  <td><%=ds.getString("Public_No")%></td>
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
         <%if(!ds.getString("ESTIMATE_E_FILE").equals("") || !ds.getString("ESTIMATE_P_FILE").equals("")){%>
         <%
	     	//2013_11_26(화)shbyeon.
	     	//견적서 발행에서 엑셀,PDF 파일 첨부 & 수정시 나오게될 LIST
	     	//수정할때마다 새로운 첨부 파일로 UPDATE 된다.
            String Estimate_E_File=ds.getString("ESTIMATE_E_FILE");
	     	String Estimate_E_FileNm=ds.getString("ESTIMATE_E_FILENM");
	     	String Estimate_P_File = ds.getString("ESTIMATE_P_FILE");
            String Estimate_P_FileNm = ds.getString("ESTIMATE_P_FILENM");
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
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("ESTIMATE_E_FILENM")%>&sFileName=<%=Esti_xls_filename%>&filePath=<%=Esti_xls_path%>" ><img src="<%= request.getContextPath()%>/images/ico_excel.gif" width="16" height="16" align="absmiddle" title="견적서(EXCEL)"></a>
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
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("ESTIMATE_P_FILENM")%>&sFileName=<%=Esti_pdf_filename%>&filePath=<%=Esti_pdf_path%>" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" align="absmiddle" title="견적서(PDF)"></a>
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
          <td title="<%=ds.getString("Ordering_Organization") %>"><span class="ellipsis"><%=ds.getString("Ordering_Organization") %></span></td>
          <td class="text_l" title="<%=ds.getString("ContractName") %>"><span class="ellipsis"><%=ds.getString("ContractName") %></span></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("SUPPLY_PRICE"))%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("VAT"))%></td>
          <%
				long sprice=ds.getLong("SUPPLY_PRICE");
				long vat=ds.getLong("VAT");
				long total=sprice+vat;
		  %>
          <td class="text_r"><%=NumberUtil.getPriceFormat(total)%></td>
          <%if(!ds.getString("sum_price_total").equals("")){%>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("sum_price_total"))%></td>
          <%}else{%>
          <td>-</td>
          <%}%>
          <%if(!ds.getString("min_price_total").equals("")){ %>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("min_price_total"))%></td>
          <%}else{%>
          <td>-</td>
          <%} %>
         <%if(!ds.getString("deposit_amt_total").equals("")){ %>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("deposit_amt_total"))%></td>
         <%}else{ %>
          <td>-</td>
         <%} %>
         <%if(!ds.getString("no_collect_total").equals("")){ %>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("no_collect_total"))%></td>
         <%}else{ %>
          <td>-</td>
         <%} %>
         <td><%=StatusStr%></td>

          
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
         </tbody>
      </table>
      <!-- paginate -->
    <div class="paging">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //paginate -->
    <!-- Bottom 버튼영역 -->
	<div class="Bbtn_areaC"><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
	<!-- //Bottom 버튼영역 -->
</div>
<!-- //contents -->
</div>
</body>
</html>
