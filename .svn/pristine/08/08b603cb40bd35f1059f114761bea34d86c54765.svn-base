<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%

	Map model = (Map)request.getAttribute("MODEL");
/* 	CompanyDTO compDto = (CompanyDTO)model.get(compDto); */

	String curPage = (String)model.get("curPage");
	//String search = (String)model.get("search"); 미등록 업체 조회 추가 2013_03_18(월)shbyeon.(현재사용안함.)
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>업체관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<!-- Tooltip -->
<style>
	.ui-tooltip, .arrow:after {background:#3ba90d !important;}
	.ui-tooltip {padding:5px 10px !important;background:#fff !important;color:#666 !important;border:1px solid #3ba90d !important;border-radius:5px;}
	.arrow {width:70px;height:16px;overflow:hidden;position: absolute;left:50%;margin-left:-33px;bottom:-16px;}
	.arrow.top {top:-16px;bottom:auto;}
	.arrow.left {left:20%;}
	.arrow:after {content: "";position:absolute;left:20px;top:-24px;width:25px;height:25px;-webkit-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg);}
	.arrow.top:after {bottom:-20px;top:auto;}
</style>
<!-- Tooltip -->


<script type="text/javascript">
/* Tooltip */

 $(function() {

    $( document ).tooltip({

      position: {

        my: "center bottom-20",

        at: "center top",

        using: function( position, feedback ) {

          $( this ).css( position );

          $( "<div>" )

            .addClass( "arrow" )

            .addClass( feedback.vertical )

            .addClass( feedback.horizontal )

            .appendTo( this );

        }

      }

    });

  });

/* Tooltip */

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
	function init_companyPageList() {
		
		formObj=document.companyform; //form객체세팅
		
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
	
		//search 미등록업체 search에 추가 되있는 구분값에 추가되있는 상태이지만. JSP화면에서 요청으로 인해 주석처리함.(사용안함.)
		<%-- formObj.search.value='<%=search%>'; --%>
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
    
	//검색
	function goSearch() {
		var gubun= formObj.searchGb.value;

		if(gubun=='A'){
			if( formObj.searchtxt.value==''){
				alert('상호(법인명)을 입력해 주세요');
				return;
			}
		}else if(gubun=='B'){
			if( formObj.searchtxt.value==''){
				alert('사업자등록번호 입력해 주세요');
				return;
			}
		}else if(gubun=='C'){
			if( formObj.searchtxt.value==''){
				alert('대표자명을 입력해 주세요');
				return;
			}
		}
		
		openWaiting();
		
		formObj.curPage.value='1';
		formObj.submit();

    }
    
	//등록페이지로 이동
	function goRegist() {

	     formObj.target ='_self';	//(default)현재창에 표시
		 formObj.action = "<%= request.getContextPath()%>/B_Company.do?cmd=companyRegistForm";		
		 formObj.submit();

	}
    
	//상세페이지 이동
	function goDetail(comp_code){
		 
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_Company.do?cmd=companyView";
		 formObj.comp_code.value=comp_code;
		 formObj.submit();

	}
	
	//Excel Export
	function goExcel() {
	
		 formObj.action = "<%=request.getContextPath()%>/B_Company.do?cmd=companyExcelList";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_Company.do?cmd=companyPageList";	
	}

	//-->
</script>
</head>
<body onload="init_companyPageList()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">

<!-- title -->
 	<div class="content_navi">총무지원 &gt; 업체관리</div>
	<h3><span>업</span>체관리</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
<!-- //title -->

	<div class="con">
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
		<!-- 조회 -->
		<%
					
				ListDTO ld = (ListDTO)model.get("listInfo");
				DataSet ds = (DataSet)ld.getItemList();	
					
				int iTotCnt = ld.getTotalItemCount();
				int iCurPage = ld.getCurrentPage();
				int iDispLine = ld.getListScale();
				int startNum = ld.getStartPageNum();
					
														%>
 
  <%= ld.getPageScript("companyform", "curPage", "goPage") %>
<!--   <form  method="post"  name="excelform"> </form> -->
  <form  method="post" class="search" name=companyform action = "<%= request.getContextPath()%>/B_Company.do?cmd=companyPageList">
    <input type = "hidden" name = "objExcel" />
    <!-- <input type = "hidden" name = "filename" value="companyList.xls"> -->
    <input type = "hidden" name = "comp_nm" value="" />
    <input type = "hidden" name = "comp_no" value="" />
    <input type = "hidden" name = "comp_code" value="" />
    <input type = "hidden" name = "curPage"  value="<%=curPage%>" />
	
	<fieldset>
			<legend>검색</legend>

			          <!-- 
			          2013_05_13(월)shbyeon. 영업진행현황,견적서발행서 수동입력으로인한 새로운 Comp_Code 생성시 사용함.
			        <select name="search" id="" class="" >
			          <option checked value="">전체</option>
			          <option value="S">미등록업체</option>
			        </select>
			           -->
						<ul>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->

							<li><select name="searchGb" onchange="searchChk()" id="" class="">
								<option checked value="">전체</option>
								<option value="A" >상호(법인명)</option>
								<option value="B" >사업자 등록번호</option>
								<option value="C" >대표자명</option>
							</select></li>
							<li><input type="text" class="text" title="검색어" id="" name="searchtxt" value="<%=searchtxt%>" maxlength="100"/></li>
							<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
						</ul>
					</fieldset>
					</form>
					<!-- //조회 -->
					
					<!-- Top 버튼영역 -->
					<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>내려받기</span></a><a href="#" class="btn_type01 md0" onclick="javascript:goRegist();"><span>등록하기</span></a></div>
					<!-- //Bottom 버튼영역 -->
					</div>
					<!-- //컨텐츠 상단 영역 -->
    
    <!-- con -->
			<table class="tbl_type tbl_type_list" id="excelBody" summary="업체관리리스트(부적격업체지정, 다운로드, 사업자등록번호, 상호(법인명), 법인등록번호(주민등록번호), 대표자명, 개업일, 업태, 종목, 등록일)">
					
					<colgroup>
						<col width="4%" />
						<col width="7%" />
						<col width="10%" />
						<col width="15%" />
						<col width="10%" />
						<col width="10%" />
						<col width="7%" />
						<col width="10%" />
						<col width="*" />
						<col width="7%" />
					</colgroup>
					
					<thead>
					<tr>
						<th>부적격업체</th>
						<th>다운로드</th>
						<th>사업자등록번호</th>
						<th>상호(법인명)</th>
						<th>법인등록번호(주민등록번호)</th>
						<th>대표자명</th>
						<th>개업일</th>
						<th>업태</th>
						<th>종목</th>
						<th>등록일</th>
					</tr>
					</thead>
        
        <!-- :: loop :: -->
        <!--리스트---------------->
        <%			
	    if(ld.getItemCount() > 0){	
	        int i = 0;
	        while(ds.next()){
	    %>
       <tbody>
        <tr>
        <%
        	String UNFIT_ID = ds.getString("UNFIT_ID");
        	if(!UNFIT_ID.isEmpty()){
        %>
        <!-- 부적격 업체일 때 -->
        <%
        	/* 부적격 지정자, 부적격 사유 Tooltip */
        	String unfit_id = ds.getString("UNFIT_ID");
        	String unfit_reason = ds.getString("UNFIT_REASON");
        %>
        <td><img src="<%= request.getContextPath()%>/images/common/ico_unfit.gif" title="<%=unfit_id %> / <%=unfit_reason%>" alt="부적격업체"></td>
        <%
        	}else{
        %>
        <!-- 부적격업체가 아닐 때 -->
        <td></td>
        <%
        	} 
        %>
          <td><%
                   String comp_file=ds.getString("COMP_FILE");
                   String account_file=ds.getString("ACCOUNT_COPY1");
                   String COMPANY_FILENM = ds.getString("COMPANY_FILENM");
                   String ACCOUNT_COPYNM1 = ds.getString("ACCOUNT_COPYNM1");
//                    String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=comp_file.lastIndexOf("/");
                    int a_index=account_file.lastIndexOf("/");
                    
                    String compfilename=comp_file.substring(c_index+1);
               
                    String accountfilename=account_file.substring(a_index+1);
                    
                    String comppath="";
                    
                    String accountpath="";
                   
                    if(!comp_file.equals("")){
                    	comppath=comp_file.substring(0,c_index);
                 %>
           			
            <%
            if(COMPANY_FILENM.equals("")){
            %>
            	<!-- 파일명 (COMPANY_FILENM)이 없는 데이터 가져올때(기존데이터들)-->
             	<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=compfilename%>&sFileName=<%=compfilename%>&filePath=<%=comppath%>" ><img src="<%= request.getContextPath()%>/images/ico_company.gif" width="16" height="16" align="absmiddle" title="사업자등록증"></a>
            	<%
            	}if(!COMPANY_FILENM.equals("")){
            		//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                	String spStrReplace = "";
                	if(COMPANY_FILENM.indexOf("&") != -1){
                		spStrReplace=  COMPANY_FILENM.replace("&", "[replaceStr]");
                	System.out.println("spStrReplace:"+spStrReplace);
                	}else{
                		spStrReplace =  COMPANY_FILENM;	
                	System.out.println("spStrReplace:"+spStrReplace) ;
                	}
            	%>	
            	 <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=compfilename%>&filePath=<%=comppath%>" ><img src="<%= request.getContextPath()%>/images/ico_company.gif" width="16" height="16" align="absmiddle" title="사업자등록증2"></a>	
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
            	<%
                if(!account_file.equals("")){
                	
                	accountpath=account_file.substring(0,a_index);
                %>
                	<!-- 파일명 (ACCOUNT_COPYNM1)이 없는 데이터 가져올때(기존데이터들)-->
                	<%
                	if(ACCOUNT_COPYNM1.equals("")){	 
                	%>
                	<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=accountfilename%>&sFileName=<%=accountfilename%>&filePath=<%=accountpath%>" ><img src="<%= request.getContextPath()%>/images/ico_bankbook.gif" width="16" height="16" align="absmiddle" title="통장사본"></a>
                	<%
                 	}if(!ACCOUNT_COPYNM1.equals("")){
                 		//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                    	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                    	String spStrReplace = "";
                    	if(ACCOUNT_COPYNM1.indexOf("&") != -1){
                    		spStrReplace=  ACCOUNT_COPYNM1.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  ACCOUNT_COPYNM1;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
                	%>	 
            		<a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=accountfilename%>&filePath=<%=accountpath%>" ><img src="<%= request.getContextPath()%>/images/ico_bankbook.gif" width="16" height="16" align="absmiddle" title="통장사본"></a>
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
        
          <td><%=ds.getString("PERMIT_NO")%></td>
          <td><a href="javascript:goDetail('<%=ds.getString("COMP_CODE")%>')"><%=ds.getString("COMP_NM")%></a></td>
          <td><%=ds.getString("COMP_NO")%></td>
          <td><%=ds.getString("OWNER_NM")%></td>
          <!--td><%=ds.getString("CHARGE_NM")%></td-->
          <td><%=DateTimeUtil.getDateType(1,ds.getString("OPENYMD"),"/")%></td>
          <td><%=ds.getString("BUSINESS")%></td>
          <td class="text_l"><%=ds.getString("B_ITEM")%></td>
          <td><%=DateTimeUtil.getDateType(1,ds.getString("REG_DT"),"/")%></td>
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
	   </tbody>
      </table>
      
    </div>
    <!-- //con -->
    
    <!-- 페이징  -->
    <div class="paging">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //페이징  -->
    
    <!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaR"><a href="#" class="btn_type01 md0" onclick="javascript:goRegist();"><span>등록하기</span></a></div>
	<!-- //Bottom 버튼영역 -->
  
</div>
<!-- //contents -->
</div>
</div>
<!-- //container -->
<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->
</div>
</body>
</html>
<%=comDao.getMenuAuth(menulist,"00") %>