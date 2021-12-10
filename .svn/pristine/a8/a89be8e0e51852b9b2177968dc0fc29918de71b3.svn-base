<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String contractGb = (String)model.get("contractGb");
	String searchtxt = (String)model.get("searchtxt");
	String EsStartDate = (String)model.get("EsStartDate");
	String EsEndDate = (String)model.get("EsEndDate");
	String type = (String)model.get("type");
	String title = "";
	if(type.equals("reg")){
		title = "발행";
	}else{
		title = "발행(전체)";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>견적서(매출) 발행 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
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


	<!--
	var  formObj;//form 객체선언
	
	//초기세팅
	function init_estimate() {
		
		formObj=document.estimateform; //form객체세팅
		
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
		 formObj.contractGb.value='<%=contractGb%>';
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
	//조회
	function goSearch() {
		
		var gubun= formObj.searchGb.value;
		var dch=dateCheck_5Year(formObj.EsStartDate,formObj.EsEndDate,1827);//검색조건 날짜체크 : 시작일,종료일,기간(5년)
		
		if (dch==false){
			return;
		}
		
		if(gubun=='A'){

			if( formObj.searchtxt.value==''){
				alert('수신자를 입력해 주세요');
				return;
			}
		}else if(gubun=='B'){
			if( formObj.searchtxt.value==''){
				alert('제목을 입력해 주세요');
				return;
			}
		}else if(gubun=='C'){
			if( formObj.searchtxt.value==''){
				alert('모발행 번호를 입력해 주세요');
				return;
			}
		}else if(gubun=='D'){
			if( formObj.searchtxt.value==''){
				alert('발행 번호를 입력해 주세요');
				return;
			}
		}else if(gubun=='E'){
			if( formObj.searchtxt.value==''){
				alert('업체명을 입력해 주세요');
				return;
			}
		}
		 openWaiting();
		 formObj.curPage.value='1';
		 formObj.submit();

    }
    //등록
	function goRegist() {

		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Estimate.do?cmd=estimateRegistForm";		
		 formObj.submit();

	}
    //상세
	function goDetail(public_no,ProjectPk){
		
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Estimate.do?cmd=estimateView";
		 formObj.public_no.value=public_no;
		 formObj.ProjectPk.value=ProjectPk;
		 formObj.submit();

	}
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_Estimate.do?cmd=estimateExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList";	
	}
    //발행번호 리스트
	function goInvoiceList(publicno,title){
		var a = window.open("<%= request.getContextPath()%>/B_Estimate.do?cmd=invoiceDetailList&publicno="+publicno+"&title="+title,"","width=1200,height=593,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=yes, status=no");

	}
    
    /*견적서 달력 검색 기능
      2013_05_28(화)shbyeon.
    */
    
	$(document).ready(function(){
		$('#calendarData1, #calendarData2').datepicker({
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
	
	/**	key down function (엔터키가 입력되면 검색함수 호출)*/
 	function checkKeyASearch(){
		if(event.keyCode == 13){
			goSearch();
		}
	} 	
    
//-->
</script>
</head>
<body onload="init_estimate();">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">

	<!-- title -->
	<div class="content_navi">영업지원 &gt; 견적서<%=title%></div>
	<h3><span>견</span>적서<%=title%></h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
	<div class="con estimatePageList">
	<!-- title -->				
	
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
					
  
  <%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();

	%>
  
  <%= ld.getPageScript("estimateform", "curPage", "goPage") %>
  <form  method="post" name="excelform"></form>
  <form  method="post" name=estimateform action = "<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList" class="search">
    <input type = "hidden" name = "objExcel"/>
    <input type = "hidden" name = "filename" value="companyList.xls"/>
    <!-- 영업진행현황 PK값 상세보기 항목으로 넘겨줄 값. -->
    <input type = "hidden" name = "ProjectPk" value=""/>
    <input type = "hidden" name = "public_no" value=""/>
    <input type = "hidden" name = "p_public_no" value=""/>
    <input type = "hidden" name = "estimate_dt" value=""/>
    <input type = "hidden" name = "title" value=""/>
    <input type = "hidden" name = "curPage"  value="<%=curPage%>"/>
    <input type = "hidden" name = "type"  value="<%=type%>"/>
    
    <!-- search -->
      <fieldset>
        <legend>검색</legend>
        
        	<ul>
				<li><span class="ico_calendar"><input type="text" name="EsStartDate" id="calendarData1" class="text textdate" value="<%=EsStartDate %>"  title="검색시작일"  readonly="readonly" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);"/><img src="<%= request.getContextPath()%>/images/common/ico_calendar.gif" alt="달력" onclick="showCalendar('1')"/></span> ~ <span class="ico_calendar"><input type="text" class="text textdate" title="검색종료일" value="<%=EsEndDate %>" name="EsEndDate" id="calendarData2" readonly="readonly" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);"/><img src="<%= request.getContextPath()%>/images/common/ico_calendar.gif" alt="달력" onclick="showCalendar('2')"/></span></li>
								
				<li><select id="" name="contractGb" title="계약여부선택">
          				<option checked value="ALL" >전체</option>
				        <option value="Y"  >계약</option>
				        <option value="N"  >미계약</option>
        		</select></li>
        
				<li><select name="searchGb" onChange="searchChk()" id="" title="검색조건선택">
				        <option checked value="">전체</option>
				        <option value="A"  >수신자</option>
				        <option value="B"  >제목</option>
				        <option value="C"  >모발행번호</option>
				        <option value="D"  >발행번호</option>
				        <option value="E"  >업체명</option>
				</select></li>
  
 				<li><input type="text" name="searchtxt" class="text" title="검색어" id="" onkeydown="checkKeyASearch();" value="<%=searchtxt%>" maxlength="100"  /></li>
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
	<table class="tbl_type tbl_type_list" summary="견적서발행리스트(No., 발행번호, 모발행번호, 견적서다운로드, 견적일자, 고객정보(수신, 업체명, 제목), 견적금액(공급가, 부가세, 합계), 작성자, 담당영업, 계약여부)">
		<colgroup>
			<col width="3%" />
			<col width="8%" />
			<col width="8%" />
			<col width="5%" />
			<col width="7%" />
			<col width="7%" />
			<col width="9%" />
			<col width="*" />
			<col width="8%" />
			<col width="8%" />
			<col width="8%" />
			<col width="50px" />
			<col width="50px" />
			<col width="50px" />
		</colgroup>
					
		<thead>
			<tr>
				<th colspan="3">구분</th>
				<th rowspan="2">견적서다운로드</th>
				<th rowspan="2">견적일자</th>
				<th colspan="3">고객정보</th>
				<th colspan="3">견적금액</th>
				<th rowspan="2">작성자</th>
				<th rowspan="2">담당영업</th>
				<th rowspan="2">계약여부</th>
			</tr>
					
			<tr>
				<th>No.</th>
				<th>발행번호</th>
				<th>모발행번호</th>
				<th>수신</th>
				<th>업체명</th>
				<th>제목</th>
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
				String contractYN="";
				
				while(ds.next()){
					
					  state=ds.getString("CONTRACT_YN");
			
						if(state.equals("Y")){
							tcl="";
							contractYN="계약";
						}else{
							tcl="txtColor_contractNo";
							contractYN="미계약";
						}
		%>
  	<tbody>      
        <tr class="<%=tcl%>">
          <td><%=i+1%></td>
          <td><a href="javascript:goDetail('<%=ds.getString("PUBLIC_NO")%>','<%=ds.getString("PROJECT_PK_CODE")%>')"><%=ds.getString("PUBLIC_NO")%></a><a href="javascript:goInvoiceList('<%=ds.getString("PUBLIC_NO")%>','<%=ds.getString("TITLE")%>');" class="btn_type03"><span>발행내역</span></a></td>
          <td><%=ds.getString("P_PUBLIC_NO")%></td>
          <td><%
			   //파일경로+실파일명
          	   String estimate_e_file=ds.getString("ESTIMATE_E_FILE");
			   String estimate_p_file=ds.getString("ESTIMATE_P_FILE");
			   //파일명
			   String ESTIMATE_E_FILENM=ds.getString("ESTIMATE_E_FILENM");
			   String ESTIMATE_P_FILENM=ds.getString("ESTIMATE_P_FILENM");
System.out.println("ESTIMATE_E_FILENM : " + ESTIMATE_E_FILENM);			   
System.out.println("ESTIMATE_P_FILENM : " + ESTIMATE_E_FILENM);			   



// 			   String serverUrl = "//" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
				//String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
				String serverUrl = "" + request.getContextPath();
				
				int e_index=estimate_e_file.lastIndexOf("/");
				int p_index=estimate_p_file.lastIndexOf("/");
				
				String estimate_e_filename=estimate_e_file.substring(e_index+1);
				String estimate_p_filename=estimate_p_file.substring(p_index+1);
System.out.println("estimate_e_filename : " + estimate_e_filename);			   
System.out.println("estimate_p_filename : " + estimate_p_filename);				
				  String estimate_e_path="";               
                  String estimate_p_path="";
				
				if(!estimate_e_file.equals("")){
					
					estimate_e_path=estimate_e_file.substring(0,e_index);
	         %>
	         		<%
	         		if(ESTIMATE_E_FILENM.equals("")){	
	         		%>
	         		<!-- 엑셀파일명 없을때 (기존데이터 가져오기) -->
	         		<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=estimate_e_filename%>&sFileName=<%=estimate_e_filename%>&filePath=<%=estimate_e_path%>" ><img src="<%= request.getContextPath()%>/images/ico_excel.gif" width="16" height="16" title="견적서(EXCEL)"></a>
	         		
	         		<%
	         		}if(!ESTIMATE_E_FILENM.equals("")){
	         			//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                    	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                    	String spStrReplace = "";
                    	if(ESTIMATE_E_FILENM.indexOf("&") != -1){
                    		spStrReplace=  ESTIMATE_E_FILENM.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  ESTIMATE_E_FILENM;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
                    	System.out.println("spStrReplace : " + spStrReplace +"<>\nestimate_e_filename : " + estimate_e_filename +"<>\nestimate_e_path : " +estimate_e_path);
	         		%>
	         		<!-- 엑셀파일명 있을때 (파일명으로 데이터가져오기) -->
            		<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=estimate_e_filename%>&filePath=<%=estimate_e_path%>" ><img src="<%= request.getContextPath()%>/images/ico_excel.gif" width="16" height="16" title="견적서(EXCEL)"></a>
            		<%
					}
            		%>
            			<%
						}else{
						%>
						<!-- 파일추가안했을시 -->
            			<%
				 		}
				 if(!estimate_p_file.equals("")){
					 
					 estimate_p_path=estimate_p_file.substring(0,p_index);
					%>
					
					<%
					if(ESTIMATE_P_FILENM.equals("")){
					%>
					<!-- 파일명 (ESTIMATE_P_FILENM)이 없는 데이터 가져올때(기존데이터들)-->
					<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=estimate_p_filename%>&sFileName=<%=estimate_p_filename%>&filePath=<%=estimate_p_path%>" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" title="견적서(PDF)"></a>
					<%
					}if(!ESTIMATE_P_FILENM.equals("")){
						//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                    	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                    	String spStrReplace = "";
                    	if(ESTIMATE_P_FILENM.indexOf("&") != -1){
                    		spStrReplace=  ESTIMATE_P_FILENM.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  ESTIMATE_P_FILENM;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
					%>	
					<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=estimate_p_filename%>&filePath=<%=estimate_p_path%>" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" title="견적서(PDF)"></a>
					<%
					}
					%>	
            	
            			<%
						}else{
						%>
						<!-- 파일추가안했을시 -->
            			<%
					 	}
						%>
			</td>
          <td><%=DateTimeUtil.getDateType(1,ds.getString("ESTIMATE_DT"),"/")%></td>
          <td><%=ds.getString("RECEIVER")%></td>
          <td><%=ds.getString("E_COMP_NM")%></td>
          <td class="text_l"><%=ds.getString("TITLE")%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("SUPPLY_PRICE"))%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("VAT"))%></td>
          <%
				long sprice=ds.getLong("SUPPLY_PRICE");
				long vat=ds.getLong("VAT");
				long total=sprice+vat;
			%>
          <td class="text_r"><%=NumberUtil.getPriceFormat(total)%></td>
          <td><%=comDao.getUserNm(ds.getString("REG_ID"))%></td>
          <td><%=comDao.getUserNm(ds.getString("SALES_CHARGE"))%></td>
          <td><%=contractYN%></td>
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
    
    <!-- Bottom 버튼영역 -->
	<div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
	<!-- //Bottom 버튼영역 -->

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
<%
if(type.equals("reg")){
%>
<%=comDao.getMenuAuth(menulist,"11")%>
<% 	
}else{
%>	
<%=comDao.getMenuAuth(menulist,"19")%>
<% 
}	
%>