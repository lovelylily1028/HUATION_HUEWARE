<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import="com.baroservice.ws.BaroService_TISoapProxy"%>
<%@ page import="com.baroservice.ws.TaxInvoiceState"%>
<%@ page import="com.huation.common.invoice.InvoiceDTO"%>
<%
	
	Map model = (Map)request.getAttribute("MODEL");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String IvStartDate = (String)model.get("IvStartDate");
	String IvEndDate = (String)model.get("IvEndDate");
	InvoiceDTO invoiceDto = (InvoiceDTO)model.get("invoiceDto");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	%>	
	
	<%-- <%
	String CERTKEY = "FDB60D89-8AE8-4BBB-A1AA-A708EFCD83D7";				//인증키
	String CorpNum = "1088193762";				//연계사업자 사업자번호 ('-' 제외, 10자리)
	String MgtKey = ds.getString("APPROVE_NO");					//자체문서관리번호
	String ID = "huation";						//연계사업자 아이디
	String PWD = "huation@2100";					//연계사업자 비밀번호
	
	BaroService_TISoapProxy BST = new BaroService_TISoapProxy();
	
	String Result = BST.getTaxInvoicePopUpURL(CERTKEY, CorpNum, MgtKey, ID, PWD);

	int intResult; 
	
	try{
		intResult = Integer.parseInt(Result);
	}catch(NumberFormatException e){
		intResult = 0;
	}
	
	if (intResult < 0){
		out.println("오류코드 : " + Result + "<br><br>" + BST.getErrString(CERTKEY, intResult));	
	}else{		
		out.println("<a href=\"" + Result + "\" target=\"_blank\">" + Result + "</a>");	//URL		
	}	
	%> --%>
	
	
	
<title>세금계산서 발행 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
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
	function init_baroInvoice() {
		
		formObj=document.invoiceform; //form객체세팅
		
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
			
		 formObj.searchtxt.value='<%=searchtxt%>';
		 if(formObj.searchtxt.value!="")
		 formObj.searchGb.value='<%=searchGb%>';
	
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
	//조회
	function goSearch() {
		
		var gubun= formObj.searchGb.value;
		var dch=dateCheck_5Year(formObj.IvStartDate,formObj.IvEndDate,1827);//검색조건 날짜체크 : 시작일,종료일,기간(5년)
		
		if (dch==false){
			return;
		}
		
		/* if(gubun=='A'){
			if( formObj.searchtxt.value==''){
				alert('발행종류를 입력해주세요');
				return;
			} */
		else if(gubun=='B'){
			
			if( formObj.searchtxt.value==''){
				alert('계약명을 입력해 주세요');
				return;
			}
		}else if(gubun=='C'){
			
			if( formObj.searchtxt.value==''){
				alert('사업자등록번호를 입력해 주세요');
				return;
			}
		}else if(gubun=='D'){
			
			if( formObj.searchtxt.value==''){
				alert('상호를 입력해 주세요');
				return;
			}
		}
		 openWaiting();
		 formObj.curPage.value='1';
		 formObj.submit();

    }
    //등록 /B_BaroInvoice.do?cmd=baroInvoicePageList'
	function goRegist() {

		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=baroRegistForm";		
		 formObj.submit();

	}
	function inverseRegist(){
		
		formObj.target ='_self';
		formObj.action =  "<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=inverseRegistForm";
		formObj.submit();
		
	}
   //상세
	function goDetail(gun,ho,manageno,mgtkey){

		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=baroInvoiceView";
		 formObj.gun.value=gun;
		 formObj.ho.value=ho;
		 formObj.manage_no.value=manageno;
		 formObj.mgkey.value=mgtkey;
		 formObj.submit();

	}
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_Invoice.do?cmd=invoiceExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList";	
	}
    //업체상세정보
	function goCompDetail(compcode){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=companyView&comp_code="+compcode,"","width=600,height=445,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}
 
    
	/*세금계산서 달력 검색 기능
    2013_05_28(화)shbyeon.
  	*/
  
  	$(document).ready(function(){
  		$('#calendarData1, #calendarData2, #calendarData3').datepicker({
  			buttonImage: "<%= request.getContextPath()%>/images/common/ico_calendar.gif",
  			//maxDate:0,
  			showOn: 'both',
  			buttonImageOnly: true,
  			prevText: "이전",
  			nextText: "다음",
  			dateFormat: "yy-mm-dd",
  			dayNamesMin:["일","월","화","수","목","금","토"],
  			monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
  			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
  			changeMonth: true,
  		    changeYear: true
  		});
  	});
	function showCalendar(div){

		   if(div == "1"){
		   	   $('#calendarData1').datepicker("show");
		   } else if(div == "2"){
			   $('#calendarData2').datepicker("show");
		   } 
	}
	//세금계산서 상세보기
	function invoiceViewPopup(mgtkey){
		$.ajax({
			url : "<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=invoiceDetailView",
			type : "post",
			dataType : "text",
			async : false,
			data : {
				"mgkey" : mgtkey
			},
			success : function(data, textStatus, XMLHttpRequest){
				
				var a = window.open(data,"","width=900,height=1500,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=1, status=no");
				
			},
			error : function(request, status, error){
				alert("키값 가저오기 오류!");
			}
		});		
		
	}
	
	/**	key down function (엔터키가 입력되면 검색함수 호출)*/
 	function checkKeyASearch(){
		if(event.keyCode == 13){
			goSearch();
		}
	}
</script>
</head>
<body onLoad = "init_baroInvoice()">
<div id="wrap">
<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->
	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">영업지원 &gt; (신)세금계산서발행</div>
			<h3><span>(신)</span>세금계산서발행</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con baroInvoicePageList">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- 조회 -->
				 <%
					
					int iTotCnt = ld.getTotalItemCount();
					int iCurPage = ld.getCurrentPage();
					int iDispLine = ld.getListScale();
					int startNum = ld.getStartPageNum();
					
				
														%>
  
				  <%= ld.getPageScript("invoiceform", "curPage", "goPage") %>
				  <form  method="post" name=invoiceform action = "<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=baroInvoicePageList" class="search">
				    <input type = "hidden" name = "objExcel"/>
				    <input type = "hidden" name = "filename" value="companyList.xls"/>
				    <input type = "hidden" name = "gun" value=""/>
				    <input type = "hidden" name = "ho" value=""/>
				    <input type = "hidden" name = "manage_no" value=""/>
				    <input type = "hidden" name = "curPage"  value="<%=curPage%>"/>
				    <input type = "hidden" name ="mgkey" value =""></input>

					<fieldset>
						<legend>검색</legend>
						<ul>
							<!-- 달력 시작 //2013_05_28(화)shbyeon. 달력 검색 기능 추가. -->
							<li><span class="ico_calendar"><input type="text" class="text textdate" title="검색시작일" id="calendarData1" name="IvStartDate" value="<%=IvStartDate %>" readonly="readonly" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);" onclick="showCalendar('1')"/></span> ~ <span class="ico_calendar"><input type="text" name="IvEndDate" class="text textdate" title="검색종료일" id="calendarData2" value="<%=IvEndDate %>" readonly="readonly" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);" onclick="showCalendar('2')"/></span></li>  
							<li><select id="" title="검색조건선택" name="searchGb" onChange="searchChk()">
								<option value="">전체</option>
								<!-- <option value="A" >발행종류</option> -->
								<option value="B">계약명</option>
								<option value="C">사업자등록번호</option>
								<option value="D" selected="selected">상호</option>
								<!--  <option value="E" >대표자</option> -->
							</select></li>
							<li><input type="text" class="text" title="검색어" id="" name="searchtxt" onkeydown="checkKeyASearch();" value="<%=searchtxt%>" maxlength="100"/></li>
							<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
						</ul>
					</fieldset>
					</form>
					<!-- //조회 -->
					<!-- Top 버튼영역 -->
					<div class="Tbtn_areaR" id="excelBody"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>내려받기</span></a><a href="javascript:inverseRegist();" class="btn_type01 backPb"><span>역발행</span></a><a href="javascript:goRegist();" class="btn_type01 md0 normalPb"><span>정발행</span></a></div>
					<!-- //Top 버튼영역 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				<!-- 리스트 -->

  <!-- 매출액 영역 시작 -->
        <br/>
    	<div class="currentStaPageList">
		<table class="tbl_type tbl_type_list" summary="매출액 집계">
			<caption>매출액 집계</caption>
			<colgroup>
				<col width="4%" />
				<col width="3%" />
				<col width="*" />
				<col width="7%" />
				<col width="8%" />
				<col width="11%" />
				<col width="7%" />
				<col width="7%" />
				<col width="7%" />
				<col width="7%" />
				<col width="7%" />
				<col width="7%" />
				<col width="3%" />
				<col width="5%" />
			</colgroup>
			<tbody>
				<tr class="aTotal">
					<th class="text_r aTotalYear" colspan="11"><strong><label for="">누적 매출액</label></strong></th>
					<th colspan="3" class="aTotalYear"><strong><%=invoiceDto.getSupply_price()%></strong></th>
				</tr>
			</tbody>
		</table>
		</div>
	<!-- 매출액 영역 끝 --> 

				<table class="tbl_type tbl_type_list" summary="(신)세금계산서발행리스트(발행종류, 상태, 계약명, 발행일자, 공급받는자(사업자등록번호, 상호), 공급액(공급가, 부가세, 합계), 입금예상일자, 입금액, 입금일자, 개봉, 보기)">
					<colgroup>
						<col width="4%" />
						<col width="3%" />
						<col width="*" />
						<col width="7%" />
						<col width="8%" />
						<col width="11%" />
						<col width="7%" />
						<col width="7%" />
						<col width="7%" />
						<col width="7%" />
						<col width="7%" />
						<col width="7%" />
						<col width="3%" />
						<col width="5%" />
					</colgroup>
					<thead>
					<tr>
						<th rowspan="2">발행종류</th>
						<th rowspan="2">상태</th>
						<th rowspan="2">품명</th>
						<th rowspan="2">발행일자</th>
						<th colspan="2">공급받는자</th>
						<th colspan="3">공급액</th>
						<th rowspan="2">입금예상일자</th>
						<th rowspan="2">입금액</th>
						<th rowspan="2">입금일자</th>
						<th rowspan="2">개봉</th>
						<th rowspan="2">보기</th>
					</tr>
					<tr>
						<th>사업자등록번호</th>
						<th>상호</th>
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
				String state="";
				String tcl="";
				String dipositYN="";
				String issuetype="";
				String issuetypeNo="";
				
				while(ds.next()){
			
					    state=ds.getString("STATE");
					    
						issuetype = ds.getString("ISSUETYPE");
						
						
						if(state.equals("03")){
							tcl="";
							dipositYN="입금<br>완료";
						}else if(state.equals("02")){
							tcl="txtColor_invoiceCancel";
							dipositYN="발행<br>취소";
							
						}else{
							tcl="txtColor_depositWait";
							dipositYN="입금<br>대기"; 
						}
						
						
						   if(issuetype.equals("01")){
							
							issuetypeNo ="정발행";
						  }else if(issuetype.equals("02")){
							 
							issuetypeNo="수정<br>발행";
							} else if(issuetype.equals("03")){
								 
								issuetypeNo="역발행";
								} else if(issuetype.equals("")){
									 
									issuetypeNo="정발행";
									} 
						 
			
																	%>
      <tbody>  
        <tr class="<%=tcl%>">
          <td> <%=issuetypeNo%></td> 
          <td><%=dipositYN%></td>
        <%--
         2013_10_30(수) 현재 권,호,관리번호 화면에서만 사용안함. 단 DB UPDATE 에선 사용함.
          <td class="<%=tcl%>"><%=ds.getString("GUN")%></td>
          <td class="<%=tcl%>"><%=ds.getString("HO")%></td>
         
          <%	if(!state.equals("02")){ %>
          <td class="<%=tcl%>"><a href="javascript:goDetail('<%=ds.getString("GUN")%>','<%=ds.getString("HO")%>','<%=ds.getString("MANAGE_NO")%>')"><%=ds.getString("MANAGE_NO")%></a></td>
          <%}else{%>
          <td class="<%=tcl%>"><%=ds.getString("MANAGE_NO")%></td>
          <%}%>
         --%>
        <%--   <td class="<%=tcl%>"><%=ds.getString("APPROVE_NO")%></td>
          <td class="<%=tcl%>"><%=ds.getString("RECEIVER")%></td> --%>
          <%	if(!state.equals("02")){ %>
          <td class="text_l" title="<%=ds.getString("TITLE") %>"><span ><a href="javascript:goDetail('<%=ds.getString("GUN")%>','<%=ds.getString("HO")%>','<%=ds.getString("MANAGE_NO")%>','<%=ds.getString("MGTKEY")%>')"><%=ds.getString("ITEM_NAME")%></a></span></td>
          <%}else{%>
          <td class="text_l" title="<%=ds.getString("TITLE") %>"><span ><%=ds.getString("ITEM_NAME")%></span></td>
          <%}%>
         
          
          <td><%=DateTimeUtil.getDateType(1,ds.getString("PUBLIC_DT"),"/")%></td>
          <%-- <td class="<%=tcl%>"><%=ds.getString("PUBLIC_ORG")%></td> --%>
          <%	if(!state.equals("02")){ %>
          <!-- COMP_CODE - > PERMIT_NO 리스트상에서는 사업자등록번호로 보여야된다.2013_03_20(수)shbyeon. -->
          <td><a href="javascript:goCompDetail('<%=ds.getString("COMP_CODE")%>')"><%=ds.getString("PERMIT_NO")%></a></td>
          <%}else{%>
          <!-- 발행취소된 건의 사업자등록번호 -->
          <td><%=ds.getString("PERMIT_NO")%></td>
          <%}%>
          <td><%=ds.getString("COMP_NM")%></td>
          <%-- <td class="<%=tcl%>"><%=ds.getString("OWNER_NM")%></td> --%>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("I_SUPPLY_PRICE"))%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("I_VAT"))%></td>
          <%
				long sprice=ds.getLong("I_SUPPLY_PRICE");
				long vat=ds.getLong("I_VAT");
				long total=sprice+vat;
			%>
          <td class="text_r"><%=NumberUtil.getPriceFormat(total)%></td>
          <td><%=DateTimeUtil.getDateType(1,ds.getString("PRE_DEPOSIT_DT"),"/")%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getString("DEPOSIT_AMT"))%></td>
          <td><%=DateTimeUtil.getDateType(1,ds.getString("DEPOSIT_DT"),"/")%></td>
          <td>
          
          <%
          
            //String CERTKEY = "FDB60D89-8AE8-4BBB-A1AA-A708EFCD83D7";				//테스트베드인증키
			String CERTKEY = "ED59C6A5-C0C8-4A6C-9C65-0B8E254D3640";				//실서비스 인증키
			String CorpNum = "1088193762";				//연계사업자 사업자번호 ('-' 제외, 10자리)	
			String MgtKey = ds.getString("MGTKEY");					//자체문서관리번호	
			BaroService_TISoapProxy BST = new BaroService_TISoapProxy();
			TaxInvoiceState Result = BST.getTaxInvoiceState(CERTKEY, CorpNum, MgtKey);
			
			int Open1 = Result.getIsOpened();
	
          if(issuetype.equals("03")||(issuetype.equals("02"))){
        	  out.println("O");
          }else if(issuetype.equals("01")||issuetype.equals("02") ){
			
			
			
			if (Result.getBarobillState() < 0){	
				out.println("오류코드 : " + Result.getBarobillState() + "<br><br>" + BST.getErrString(CERTKEY, Result.getBarobillState()));
			}else if(Open1 ==1){	
				out.println("O");
			}else if(Open1 ==0){
				out.println("X");
			}
			
			
          }
			
          
		%>	
          
          </td>
          <td>
          
          <%if(issuetype.equals("01")  /* ||(issuetype.equals("02")||state.equals("01")) */ ){%>
            <a href="javascript:invoiceViewPopup('<%=ds.getString("MGTKEY")%>');" class="btn_type03"><span>보기</span></a>
        	<%}else if(issuetype.equals("03")||issuetype.equals("")){
        		String invoice_file=ds.getString("INVOICE_FILE");
        		
//         		 String serverUrl = "//" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                 //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
                String serverUrl = "" + request.getContextPath();
        		 int c_index=invoice_file.lastIndexOf("/");
               	
                 String contractfilename=invoice_file.substring(c_index+1);
                   
                 String invoicefilepath=""; //파일경로 읽어오기
                 
                 if(!invoice_file.equals("")){
                	 invoicefilepath=invoice_file.substring(0,c_index); //파일경로 읽어오기
               
                %>
                 <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=ds.getString("INVOICE_FILENM")%>&sFileName=<%=contractfilename%>&filePath=<%=invoicefilepath%>"  class="btn_type03"><span>다운</span></a>
        <%}%>
        <%}else{ %>
        -
        <%}%>
        
        </td>
        
        </tr>
        <!-- :: loop :: -->
        <%		
		    i++;
		    }
		}else{
		%>
        <tr>
          <td colspan="14">조회된 데이타가 없습니다.</td>
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
				<div class="Bbtn_areaR"><a href="javascript:inverseRegist();" class="btn_type01 backPb"><span>역발행</span></a><a href="javascript:goRegist();" class="btn_type01 md0 normalPb"><span>정발행</span></a></div>
				<!-- //Bottom 버튼영역 -->
			</div>
		</div>
	</div>
	<!-- //container -->

<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->

</div>
</body>
</html>
<%= comDao.getMenuAuth(menulist,"17") %>