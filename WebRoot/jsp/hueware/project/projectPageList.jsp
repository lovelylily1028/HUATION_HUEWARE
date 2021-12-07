<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%
	Map model = (Map)request.getAttribute("MODEL");
	
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String CompanyCode = (String)model.get("CompanyCode");
	String FrDate = (String)model.get("FrDate");
	String ToDate = (String)model.get("ToDate");
	String listType = (String)model.get("listType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>정기점검 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
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

	$(document).ready(function(){
		$('#calendarData1, #calendarData2').datepicker({
			prevText: "이전",
			nextText: "다음",
			dateFormat: "yy-mm-dd",
			dayNamesMin:["일","월","화","수","목","금","토"],
			monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"]
		});
	});

	function showCalendar(div){

	   if(div == "1"){
	   	   $('#calendarData1').datepicker("show");
	   } else if(div == "2"){
		   $('#calendarData2').datepicker("show");
	   } 
	}

	var  formObj;//form 객체선언
	//초기세팅
	function inits() {
		
		formObj=document.projectPageListForm; //form객체세팅
		
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
	
		 formObj.CompanyCode.value='<%=CompanyCode%>'	;
		searchChk();
		
	}

	//조회옵션 체크	
	function searchChk(){
	
		if( formObj.CompanyCode[0].selected==true){
			 formObj.CompanyCode.disabled=true;
			 formObj.CompanyCode.value='';	
		}else {
			 formObj.CompanyCode.disabled=false;
		}
		
	}

	/*
	 * 검색
	 */
	function goSearch() {
		
		var gubun= formObj.CompanyCode.value;
		var dch=dateCheck(formObj.FrDate,formObj.ToDate,365);//검색조건 날짜체크 : 시작일,종료일,기간
		
		if (dch==false){
			return;
		}
		openWaiting();
		
		formObj.curPage.value='1';
		formObj.submit();
	
	}



	// 등록 폼으로 이동
	function goRegist(){
		
		
		formObj.target ='_self';							
		formObj.action = "<%= request.getContextPath()%>/B_Project.do?cmd=projectRegistForm";
		formObj.submit();
	}

	//상세페이지 이동
	function goDetail(Seq){
		
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Project.do?cmd=projectView";
		 formObj.Seq.value=Seq;
		 formObj.submit();
	}

	//Excel Export
	function goExcel() {  
		
		
		 formObj.action = "<%=request.getContextPath()%>/B_Project.do?cmd=projectListExcel";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_Project.do?cmd=projectPageList";	
	}
//-->
</script>
</head>
<body onload="inits()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">

<!-- title -->
<div class="content_navi">프로젝트지원 &gt; 정기점검</div>
<h3><span>정</span>기점검</h3>
<!-- //title -->
  
  <%
	ListDTO ld = (ListDTO) model.get("listInfo");
//	UserDTO userDto = (UserDTO) model.get("totalInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
  <%=ld.getPageScript("projectPageListForm", "curPage", "goPage")%>
  <!-- con -->
  <div class="con">
  <div class="conTop_area">
  
  <form method="post" name="projectPageListForm" action="<%=request.getContextPath()%>/B_Project.do?cmd=projectPageList" class="search">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
    <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
     <input type="hidden" name="Seq" value=""/>
    <input type="hidden" id="listType" name="listType" value="<%=listType%>"/>

    
    <!-- search -->
    
      <fieldset>
        <legend>검색</legend>
        <ul>
        		<!-- 달력 시작 -->
        	<li><span class="ico_calendar"><input name="FrDate"  type="text" value="<%=FrDate %>" class="text textdate" id="calendarData1" readonly="readonly" dispName="날짜" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);"/><img src="<%=request.getContextPath() %>/images/common/ico_calendar.gif" alt="달력" onclick="showCalendar('1')" /></span> ~ <span class="ico_calendar"><input name="ToDate"  type="text" value="<%=ToDate %>" class="text textdate" id="calendarData2" readonly="readonly" dispName="날짜" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);" /><img src="<%=request.getContextPath() %>/images/common/ico_calendar.gif" alt="달력" onclick="showCalendar('2')"/></span></li>
        	 <!-- 달력 종료 -->
        	 <li>
				<%
							CodeParam codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("td3");
							codeParam.setFirst("전체");
							codeParam.setName("CompanyCode");
							codeParam.setSelected(CompanyCode); 
							//codeParam.setEvent("javascript:poductSet();"); 
							out.print(CommonUtil.getCodeList(codeParam,"A06")); 
						%>		
      		</li>
        <input type="hidden" name="CompanyCode" maxlength="100" id="textfield_search2" value="<%=CompanyCode%>" onkeydown="if(event.keyCode == 13)  goSearch()" />
   
        <li><input type="text" class="text" title="검색어" id="" /></li>
		<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
			
     	</ul>
      </fieldset>
      </form>
       <!--//search -->   
      <div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>내려받기</span></a><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
    </div>

    
	<table class="tbl_type tbl_type_list" summary="정기점검리스트(고객사, 시작일자, 시작시간, 종료일자, 종료시간, 소요시간(Hour), 대상월, 담당자, 고객사담당자, 수행장소, 수행내용, 특이사항, 작성일시, 정기정검보고서)">
        <colgroup>
			<col width="*" />
			<col width="7%" />
			<col width="5%" />
			<col width="7%" />
			<col width="5%" />
			<col width="5%" />
			<col width="7%" />
			<col width="5%" />
			<col width="6%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
			<col width="7%" />
			<col width="5%" />
		</colgroup>
		<thead>
			<tr>
						<th>고객사</th>
						<th>시작일자</th>
						<th>시작시간</th>
						<th>종료일자</th>
						<th>종료시간</th>
						<th>소요시간(Hour)</th>
						<th>대상월</th>
						<th>담당자</th>
						<th>고객사담당자</th>
						<th>수행장소</th>
						<th>수행내용</th>
						<th>특이사항</th>
						<th>작성일시</th>
						<th>정기정검보고서</th>
					</tr>
					</thead>
					<tbody>
        
        <!-- :: loop :: -->
        <!--리스트---------------->
        <%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
            %>

        <tr>
          <td><a href="javascript:goDetail('<%=ds.getString("Seq")%>')"><%=ds.getString("CompanyName")%></a></td>
          <td><%=ds.getString("StartDate") %></td>
          <td><%=ds.getString("StartTime") %></td>
          <td><%=ds.getString("EndDate") %></td>
          <td><%=ds.getString("EndTime") %></td>  
          <td><%=ds.getString("WorkTime") %></td>
          <td><%=ds.getString("TargetMonth") %></td>
          <td><%=ds.getString("ChargeName") %></td>
          <td><%=ds.getString("CustChargeNm") %></td>
          <td title="<%=ds.getString("WorkSite") %>"><span class="ellipsis"><%=ds.getString("WorkSite") %></span></td>
          <td title="<%=ds.getString("WorkContents") %>"><span class="ellipsis"><%=ds.getString("WorkContents") %></span></td>
          <td title="<%=ds.getString("IssueReport") %>"><span class="ellipsis"><%=ds.getString("IssueReport") %></span></td>
          <td><%=ds.getString("CreateDate") %></td>
          <td><%
                   String ReportFile=ds.getString("ReportFile");
          		   String FileNm=ds.getString("FileNm");
                    
//                    String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
//                    String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();

                    int c_index=ReportFile.lastIndexOf("/");
                  	
                    //String FileName = "가 나 다";
                    //String Tmp_FileName = FileName.replace(" ","11");
                  	
                    //int d_index=ReportFile.lastIndexOf("");
                   
                    String reportfilename=ReportFile.substring(c_index+1);
                    	
                    //String reportfileextention="";
                    if(!ReportFile.equals("")){
                    	
                    	//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                    	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                    	String spStrReplace = "";
                    	if(FileNm.indexOf("&") != -1){
                    		spStrReplace=  FileNm.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  FileNm;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
                 %>
           
            <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=reportfilename%>&filePath=files\upload" ><img src="<%= request.getContextPath()%>/images/ico_pdf.gif" width="16" height="16" align="absmiddle" title="정기점검 보고서"></a>
           		 <%
            		}
            	 %>
       </td>
        </tr>
        <!-- :: loop :: -->
        <%
                i++;
                    }
                } else {
            %>
        <tr>
          <td colspan="14">게시물이 없습니다.</td>
        </tr>
        <%
                }
            %>
		</tbody>
      </table>
      
      
    <!-- 페이징  -->
    <div class="paging">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //페이징  -->
   
      <div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
      
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
<%= comDao.getMenuAuth(menulist,"23") %>