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
	String searchtxt = (String)model.get("searchtxt");


%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>업무 문서파일 리스트</title>
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
	
	var  formObj;//form 객체선언
	//초기세팅
	function init_document() {
		
		formObj=document.documentPageListForm; //form객체세팅
		
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
				alert('제목을 입력해주세요.');
				return;
			}
		}
	
		openWaiting();
		
		formObj.curPage.value='1';
		formObj.submit();
	
	}
	
	
	// 등록 폼으로 이동
	function goRegist(){
		
		
		formObj.target ='_self';							
		formObj.action = "<%= request.getContextPath()%>/B_DocumentFile.do?cmd=documentFileRegistForm";
		formObj.submit();
	}
	
	//상세페이지 이동
	function goDetail(Seq){
		
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_DocumentFile.do?cmd=documentfileView";
		 formObj.Seq.value=Seq;
		 formObj.submit();
	}

//-->
</script>
</head>
<body onload="init_document()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">게시판 &gt; 업무Manual</div>
			<h3><span>업</span>무Manual</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
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
  
			  <%=ld.getPageScript("documentPageListForm", "curPage", "goPage")%>
			  <form method="post" name="documentPageListForm" action="<%=request.getContextPath()%>/B_DocumentFile.do?cmd=documentFilePageList" class="search">
			    <input type="hidden" name="curPage" value="<%=curPage%>"/>
			    <input type="hidden" name="Seq" value=""/>

					<fieldset>
						<legend>검색</legend>
		         			<!-- 달력 시작 -->
		                 	<!--  >input name="FrDate" type="text" value="" class="textField" id="calendarData1" size="10" value="" readonly="readonly" dispName="날짜" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);"/> <img src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif" width="13" height="12" align="absmiddle"  onclick="new CalendarFrame.Calendar(document.getElementById('calendarData1'),'','','','','','','','810px','200px')" />
		                    ~ 
		                    <div id="CalendarLayer" style="display:none; width:172px; height:176px">
		                    <iframe name="CalendarFrame" id="CalendarFrame" src="/html/lib.calendar2.js.html" width="172" height="250" border="0" frameborder="0" scrolling="no"></iframe>
		                    </div> 
		                   	<input name="ToDate" type="text" value="" class="textField" id="calendarData2" size="10" value="" readonly="readonly" dispName="날짜" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);" /> <img src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif" width="13" height="12" align="absmiddle" onclick="new CalendarFrame.Calendar(document.getElementById('calendarData2'),'','','','','','','','910px','200px')"-->
		                    <!-- 달력 종료 -->
		        			<!-- 달력 시작 -->
		        			<!-- 
		                 	<input name="FrDate"  type="text" value="" class="textField" id="calendarData1" size="10" readonly="readonly" dispName="날짜" maxlength="8" onKeyUp="if(this.value.length==8) addDateFormat(this);"/> <img src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif" width="13" height="12" align="absmiddle"  onclick="showCalendar('1')" />
		                    ~ 
		                 	<input name="ToDate"  type="text" value="" class="textField" id="calendarData2" size="10" readonly="readonly" dispName="날짜" maxlength="8"  onKeyUp="if(this.value.length==8) addDateFormat(this);" /> <img src="<%=request.getContextPath()%>/images/sub/icon_calendar.gif" width="13" height="12" align="absmiddle" onclick="showCalendar('2')">
		                    <!-- 달력 종료 -->						
						<ul>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<li><select id="" title="검색조건선택" name="searchGb" onchange="searchChk()">
								<option checked value="">전체</option>
								<option value="1">문서명</option>
							</select></li>
							<li><input type="text" class="text" title="검색어" id="textfield_search2" name="searchtxt" maxlength="100" value="<%=searchtxt %>"/></li>
							<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
						</ul>
					</fieldset>
					</form>
					<!-- //조회 -->
					<!-- Top 버튼영역 -->
					<div class="Tbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
					<!-- //Top 버튼영역 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->    

				<!-- 리스트 -->
				<table class="tbl_type tbl_type_list" summary="업무Manual리스트(첨부파일, 분류, 등록자, 문서작성자, 등록일, 등록시간, 문서명, 조회수)">
					
					<colgroup>
						<col width="5%" />
						<col width="12%" />
						<col width="8%" />
						<col width="8%" />
						<col width="8%" />
						<col width="8%" />
						<col width="*" />
						<col width="5%" />
					</colgroup>
					
					<thead>
					<tr>
						<th>첨부파일</th>
						<th>분류</th>
						<th>등록자</th>
						<th>문서작성자</th>
						<th>등록일</th>
						<th>등록시간</th>
						<th>문서명</th>
						<th>조회수</th>
					</tr>
					</thead>   

        <!-- :: loop :: -->
        <!--리스트---------------->
        	<%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
                  
            %>
        
       <tbody> 
        <tr>
          <td><%
                   String DocumentFile=ds.getString("DocumentFile");
          		   String DocumentFileNm=ds.getString("DocumentFileNm");
          
                    
                  // String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=DocumentFile.lastIndexOf("/");
                  	
                    String documentfilename=DocumentFile.substring(c_index+1);
              
                    String documentFilepath=""; //파일경로 읽어오기
                   
                    	
          
                    if(!DocumentFile.equals("")){
                    	documentFilepath=DocumentFile.substring(0,c_index); //파일경로 읽어오기
                    	
                    	//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                    	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                    	String spStrReplace = "";
                    	if(DocumentFileNm.indexOf("&") != -1){
                    		spStrReplace=  DocumentFileNm.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  DocumentFileNm;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
                 %>
           
            <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=documentfilename%>&filePath=<%=documentFilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down01.gif" width="16" height="16" align="absmiddle" title="첨부파일"></a>
            <%
                     }
               
                %>
       </td>

       	  <td><%=ds.getString("FormGroupNm")%></td>
          <td><%=ds.getString("WriteUserName") %></td>
          <td><%=ds.getString("WriteFormUserNm") %></td>
          <td><%=ds.getString("CreateDate") %></td>
          <td><%=ds.getString("CreateTime") %></td>
          <td class="text_l" title="<%=ds.getString("Title") %>"><span class="ellipsis"><a href="javascript:goDetail('<%=ds.getString("Seq")%>')"><%=ds.getString("Title") %></a></span></td>  
          <td><%=ds.getString("ReadCount") %></td>
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
      </table>

			    <!-- paginate -->
			    <div class=paging>
			      <%=ld.getPagging("goPage")%>
			    </div>
			    <!-- //paginate -->
      
				<!-- Bottom 버튼영역 -->
				<div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
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
<%= comDao.getMenuAuth(menulist,"35") %>