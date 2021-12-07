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

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>통장관리 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
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
	
	<!--
		var  formObj;//form 객체선언
	
	//초기세팅
	function init_bank() {
		
		formObj=document.bankmanageform; //form객체세팅
		
		//조회옵션 초기화 searchInit(); 
		
		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting(); //처리중 메세지 비활성화
			return;
		}
		
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	
	}
    
	//등록페이지 이동
	function goRegist() {

	     formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_BankManage.do?cmd=bankRegistForm";		
		 formObj.submit();

	}
   
	//상세페이지 이동
	function goDetail(AccountNumber){
		
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_BankManage.do?cmd=bankView";
		 formObj.AccountNumber.value=AccountNumber;
		 formObj.submit();

	}
	
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_BankManage.do?cmd=bankExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_BankManage.do?cmd=bankPageList";	
	}
	
	//-->
</script>
</head>
<body onload="init_bank()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
   	<!-- title -->
    <div class="content_navi">총무지원 &gt; 법인통장관리</div>
	<h3><span>법</span>인통장관리</h3>
    <!-- //title -->
	<div class="con">
	  <%
		ListDTO ld = (ListDTO)model.get("listInfo");
		DataSet ds = (DataSet)ld.getItemList();	
		
		int iTotCnt = ld.getTotalItemCount();
		int iCurPage = ld.getCurrentPage();
		int iDispLine = ld.getListScale();
		int startNum = ld.getStartPageNum();
		%>
	  
	  <%= ld.getPageScript("bankmanageform", "curPage", "goPage") %>
	  <form  method="post" name="bankmanageform" action = "<%= request.getContextPath()%>/B_BankManage.do?cmd=bankPageList">
	    <input type = "hidden" name = "curPage"  value="<%=curPage%>"/>
	    <input type="hidden" name="AccountNumber" value=""/>
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>내려받기</span></a><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a></div>
		</div>
		<!-- //컨텐츠 상단 영역 -->
		<!-- 리스트 -->
		<table class="tbl_type tbl_type_list" summary="법인통장관리리스트(다운로드, 은행명, 은행코드, 계좌번호, 신규일(개설일), 발행일, 계좌관리점(신규점), 통장발행점, 고객번호, 등록일, 등록자)">
			<colgroup>
				<col width="7%" />
				<col width="*" />
				<col width="7%" />
				<col width="11%" />
				<col width="7%" />
				<col width="7%" />
				<col width="11%" />
				<col width="11%" />
				<col width="11%" />
				<col width="7%" />
				<col width="7%" />
			</colgroup>
			
			<thead>
				<tr>
					<th>다운로드</th>
					<th>은행명</th>
					<th>은행코드</th>
					<th>계좌번호</th>
					<th>신규일(개설일)</th>
					<th>발행일</th>
					<th>계좌관리점(신규점)</th>
					<th>통장발행점</th>
					<th>고객번호</th>
					<th>등록일</th>
					<th>등록자</th>
				</tr>
			</thead>
	        <!-- :: loop :: -->
	        <!--리스트---------------->
	        
	        <%			
	    if(ld.getItemCount() > 0){	
	        int i = 0;
	        while(ds.next()){
	    %>
	    
	    <thead>
	        <tr>
	          <td><%
	                   String bank_file=ds.getString("BankBookFile");
	                   String BankBookFileNm = ds.getString("BankBookFileNm");
	                   //String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
	                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
						String serverUrl = "" + request.getContextPath();
	                    int c_index=bank_file.lastIndexOf("/");
	                    
	                    String bank_filename=bank_file.substring(c_index+1);
	                    
	                    String comppath="";
	                    
	                    String accountpath="";
	                   
	                    if(!bank_file.equals("")){
	                    	comppath=bank_file.substring(0,c_index);
	                 %>
	           			
	            
	            <%
	            if(BankBookFileNm.equals("")){
	            %>
	            	
	            	<!-- 파일명 (COMPANY_FILENM)이 없는 데이터 가져올때(기존데이터들)-->
	             	<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=bank_filename%>&sFileName=<%=bank_filename%>&filePath=<%=comppath%>" ><img src="<%= request.getContextPath()%>/images/ico_company.gif" width="16" height="16" align="absmiddle" title="사업자등록증"></a>
	            	<%
	            	}if(!BankBookFileNm.equals("")){
	            		//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
	                	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
	                	String spStrReplace = "";
	                	if(BankBookFileNm.indexOf("&") != -1){
	                		spStrReplace=  BankBookFileNm.replace("&", "[replaceStr]");
	                	System.out.println("spStrReplace:"+spStrReplace);
	                	}else{
	                		spStrReplace =  BankBookFileNm;	
	                	System.out.println("spStrReplace:"+spStrReplace) ;
	                	}
	            	%>	
	            	 <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=bank_filename%>&filePath=<%=comppath%>" ><img src="<%= request.getContextPath()%>/images/ico_bankbook.gif" width="16" height="16" align="absmiddle" title="법인통장사본"></a>	
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
	          <td><%=ds.getString("BankName")%></td>
	          <td><%=ds.getString("BankCode")%></td>
	          <td><a href="javascript:goDetail('<%=ds.getString("AccountNumber")%>')"><%=ds.getString("AccountNumber")%></a></td>
	          <td><%=ds.getString("NewDate")%></td>
	          <td><%=ds.getString("ReturnDate")%></td>
	          <td title="<%=ds.getString("AccountManage") %>"><span class="ellipsis"><%=ds.getString("AccountManage")%></span></td>
	          <td title="<%=ds.getString("BankBook") %>"><span class="ellipsis"><%=ds.getString("BankBook")%></span></td>
	          <td title="<%=ds.getString("CustomerNum") %>"><span class="ellipsis"><%=ds.getString("CustomerNum")%></span></td>
	          <td><%=ds.getString("CreateDate")%></td>
	          <td><%=ds.getString("RegistrationName")%></td>
	        </tr>
	        <!-- :: loop :: -->
	        <%		
	        i++;
	        }
	    }else{
	    %>
	        <tr>
	          <td colspan="10">게시물이 없습니다.</td>
	        </tr>
	        <% 
	    }
	    %>
	    
	    </thead>
     </table>
     
    <!-- paginate -->
    <div class="paging">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //paginate -->
    
    <!-- Bottom 버튼영역 -->
	<div class="Bbtn_areaR"><a href="javascript:goRegist();" class="btn_type01 md0"><span>등록하기</span></a>	</div>
	<!-- //Bottom 버튼영역 -->
      </form>
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
<%=comDao.getMenuAuth(menulist,"01") %>