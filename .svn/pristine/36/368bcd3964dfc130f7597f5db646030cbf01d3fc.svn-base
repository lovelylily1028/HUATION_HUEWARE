<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import="java.lang.String.*" %>
<%

	Map model = (Map)request.getAttribute("MODEL"); 
	
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchGb2 = (String)model.get("searchGb2");
	String searchGb3 = (String)model.get("searchGb3");
	String searchtxt = (String)model.get("searchtxt");


%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>계약관리 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
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
	function init_contractMg() {
		
		formObj=document.contractMgPageListForm; //form객체세팅
		
		searchInit(); //조회옵션 초기화
		searchInit2(); //조회옵션 초기화
		searchInit3(); //매출구분 초기화
		
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
	
	//조회옵션 초기값	
	function searchInit2(){
	
		formObj.searchGb2.value='<%=searchGb2%>';
		searchChk();
		
	}
	//매출구분 초기값
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

	//등록페이지 이동
	function goRegist() {
	
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgRegistForm";		
		 formObj.submit();
	
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
	
	var a = window.open("<%= request.getContextPath()%>/B_ContractManage.do?cmd=invoiceDetailList&contractcode="+contractcode+"&contractname="+contractname,"","width=1200,height=593,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=yes, status=no");
	
	}

	//-->
</script>
</head>
<body onload="init_contractMg();">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
	
	<!-- title -->		
	<div class="content_navi">영업지원 &gt; 계약관리</div>
	<h3><span>계</span>약관리</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
	<!-- title -->
	
	<div class="con">
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
  <form method="post" name="contractMgPageListForm" action="<%=request.getContextPath()%>/B_ContractManage.do?cmd=contractMgPageList" class="search">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
    <input type="hidden" name="ContractCode" value=""/>

    
    <!-- search -->
      <fieldset>
        <legend>검색</legend>
        <ul>
        	<li><select name="searchGb2" id="" class=""  title="검색조건선택">
	          <option checked value="">전체</option>
	          <option value="1" >진행중</option>
	          <option value="2" >조기종료</option>
	          <option value="3" >계약종결</option>
        	</select></li>
        	<li>
        		<select name="searchGb3" id="searchGb3" class=""  title="매출구분선택">
	          		<option checked value="">전체</option>
	          		<option value="S00" >시스템매출</option>
	          		<option value="S01" >상품매출</option>
	          		<option value="S02" >용역매출</option>
        		</select>
        	</li>        	
         	 <li><select name="searchGb" onchange="searchChk()" id="" class=""  title="검색조건선택">
	          <option checked value="">전체</option>
	          <option value="1" >계약번호</option>
	          <option value="2" >견적번호</option>
	          <option value="3" >발주사명</option>
	          <option value="4" >계약명</option>
        	</select></li>

			<li><input type="text" name="searchtxt"  class="text" title="검색어" id="textfield_search2" value="<%=searchtxt %>" /></li>
			<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
		</ul>
	</fieldset>
	</form>
    <!--//search -->
    
	<!-- Top 버튼영역 -->
	<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>내려받기</span></a><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
	<!-- //Top 버튼영역 -->
	</div>
	<!-- //컨텐츠 상단 영역 -->
	
	<!-- 리스트 -->
	<table class="tbl_type tbl_type_list" summary="계약관리리스트(계약번호, 견적번호, 계약서, 발주서, 견적서, 발주사, 계약명, 계약금액(공급가, 부가세, 합계), 계산서발행금액(누적발행금액, 미발행금액), 수금액(총수금액, 미수금액), 계약종료여부, 매출구분)">
		<colgroup>
			<col width="8%" />
			<col width="8%" />
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
			<col width="3%" />
		</colgroup>
					
		<thead>
			<tr>
				<th rowspan="2">계약번호<br/>견적번호</th>
				<th rowspan="2">매출구분</th>
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
                	StatusStr = "진행중";
                }else if(Status.equals("2")){
                	StatusStr = "조기종료";
                	StatusColor = "txtColor_contractEarly";
                }else if(Status.equals("3")){
                	StatusStr = "계약종결";
                	StatusColor = "txtColor_contractEnd";
                }
                
                String salesSortValue = "";
                String salesSort = ds.getString("SalesSort");
                String[] sArray1 = salesSort.split(",");
                
				for( int s = 0; s < sArray1.length; s++ ){
					if (s > 0) {
						salesSortValue += "<br/>";
					}
                  	if ("S00".equals(sArray1[s])) {
                  		salesSortValue += "시스템매출";
                  	} else if ("S01".equals(sArray1[s])) {
                  		salesSortValue += "상품매출";
                  	} else if ("S02".equals(sArray1[s])) {
                  		salesSortValue += "용역매출";
                  	}
                }

        %>
    <tbody>    
        <tr class="<%=StatusColor%>">
        
          <td><a href="javascript:goDetail('<%=ds.getString("ContractCode")%>');"><%=ds.getString("ContractCode")%></a><a href="javascript:goInvoiceList('<%=ds.getString("ContractCode")%>','<%=ds.getString("ContractName")%>');" class="btn_type03"><span>발행내역</span></a><br/><%=ds.getString("Public_No")%></td>
       	 
       	  <td><%=salesSortValue%></td>
          <td>
          
          <!-- 계약서 파일 시작. -->
          <%if(!ds.getString("ContractFile").equals("")){ %>
          <%
                   String ContractFile=ds.getString("ContractFile");
          		   String ContractFileNm=ds.getString("ContractFileNm");
          
                   //String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=ContractFile.lastIndexOf("/");
                  	
                    String contractfilename=ContractFile.substring(c_index+1);
              
                    String contractfilepath=""; //파일경로 읽어오기
                   
                    if(!ContractFile.equals("")){
                    	contractfilepath=ContractFile.substring(0,c_index); //파일경로 읽어오기
                    
                    	//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                    	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                    	String spStrReplace = "";
                    	if(ContractFileNm.indexOf("&") != -1){
                    		spStrReplace=  ContractFileNm.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  ContractFileNm;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
                    	
          %>
          <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=contractfilename%>&filePath=<%=contractfilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" width="16" height="16" align="absmiddle" title="계약서"></a>
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
          		   String PurchaseOrderFileNm=ds.getString("PurchaseOrderFileNm");
          
                   //String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=PurchaseOrderFile.lastIndexOf("/");
                  	
                    String purchasefilename=PurchaseOrderFile.substring(c_index+1);
              
                    String purchasefilepath=""; //파일경로 읽어오기
                   
                    	
          
                    if(!PurchaseOrderFile.equals("")){
                    	purchasefilepath=PurchaseOrderFile.substring(0,c_index); //파일경로 읽어오기
                    	
                    	//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                    	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                    	String spStrReplace = "";
                    	if(PurchaseOrderFileNm.indexOf("&") != -1){
                    		spStrReplace=  PurchaseOrderFileNm.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  PurchaseOrderFileNm;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
          %>
          <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=purchasefilename%>&filePath=<%=purchasefilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" width="16" height="16" align="absmiddle" title="발주서"></a>
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
            //String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
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
            	//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
            	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
            	String spStrReplace = "";
            	if(Estimate_E_FileNm.indexOf("&") != -1){
            		spStrReplace=  Estimate_E_FileNm.replace("&", "[replaceStr]");
            	System.out.println("spStrReplace:"+spStrReplace);
            	}else{
            		spStrReplace =  Estimate_E_FileNm;	
            	System.out.println("spStrReplace:"+spStrReplace) ;
            	}
            %>
			<!-- 엑셀파일명이 존재 하는경우(파일이름있는 데이터 가져올때. 기존 견적서에서의 첨부된 파일은 파일이름이 존재하지않고 실제 파일경로로 첨부 되었기 때문.) -->
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=Esti_xls_filename%>&filePath=<%=Esti_xls_path%>" ><img src="<%= request.getContextPath()%>/images/ico_excel.gif" width="16" height="16" align="absmiddle" title="견적서(EXCEL)"></a>
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
            	//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
            	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
            	String spStrReplace = "";
            	if(Estimate_P_FileNm.indexOf("&") != -1){
            		spStrReplace=  Estimate_P_FileNm.replace("&", "[replaceStr]");
            	System.out.println("spStrReplace:"+spStrReplace);
            	}else{
            		spStrReplace =  Estimate_P_FileNm;	
            	System.out.println("spStrReplace:"+spStrReplace) ;
            	}
            %>
            <!-- PDF파일명이 존재 하는경우(파일이름있는 데이터 가져올때. 기존 견적서에서의 첨부된 파일은 파일이름이 존재하지않고 실제 파일경로로 첨부 되었기 때문.) -->
             <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=Esti_pdf_filename%>&filePath=<%=Esti_pdf_path%>" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" align="absmiddle" title="견적서(PDF)"></a>
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
          <td><%=ds.getString("Ordering_Organization") %></td>
          <td class="text_l"><%=ds.getString("ContractName") %></td>
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
    </div>
    <!-- //con -->
    
    <!-- paginate -->
    <div class="paging">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //paginate -->

	<!-- Bottom 버튼영역 -->
	<div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
	<!-- //Bottom 버튼영역 --> 
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
<%= comDao.getMenuAuth(menulist,"14") %>