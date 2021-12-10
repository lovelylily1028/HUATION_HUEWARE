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
<title>프로젝트 (등록/수정) 리스트</title>
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
	function inits() {
		formObj=document.projectMgPageListSearchForm; //form객체세팅
		
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
				alert('프로젝트 코드번호를 입력해주세요.');
				return;
			}
		}else if(gubun=='2'){
			if( formObj.searchtxt.value==''){
				alert('프로젝트 명을 입력해주세요.');
				return;
			}
		}else if(gubun=='3'){
			if( formObj.searchtxt.value==''){
				alert('고객사 명을 입력해주세요.');
				return;
			}
		}else if(gubun=='4'){
			if( formObj.searchtxt.value==''){
			alert('담당영업을 입력해주세요.');
			return;
			}
		}else if(gubun=='5'){
			if( formObj.searchtxt.value==''){
			alert('담당PM을 입력해주세요.');
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
		 
		 formObj.action = "<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgRegistForm";		
		 formObj.submit();
	
	}

	//상세페이지 이동
	function goDetail(pjseq){
		 formObj.target ='_self';
		 formObj.action = "<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgView";
		 formObj.PjSeq.value=pjseq;
		 formObj.submit();
	}

	//Excel Down
	function goExcel() {  
		 formObj.action = "<%=request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Edit_Excel";	
		 formObj.submit();
		 formObj.action = "<%=request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Edit";	
	}


	//세금계산서 발행번호 리스트
	function goInvoiceList(contractcode,contractname){
	
		var a = window.open("<%= request.getContextPath()%>/B_ContractManage.do?cmd=invoiceDetailList&contractcode="+contractcode+"&contractname="+contractname,"","width=860,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=yes, status=no");
	
	}
//-->
</script>
</head>
<body onload="inits();">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
<!-- title -->
<div class="content_navi">프로젝트지원 &gt; 프로젝트 코드(등록/수정)</div>
<h3><span>프</span>로젝트코드(등록/수정)</h3>
<!-- //title --> 
<!-- con -->
<div class="con">
<div class="conTop_area">

  <%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
  
  <%=ld.getPageScript("projectMgPageListSearchForm", "curPage", "goPage")%>
  <form method="post" name="projectMgPageListSearchForm" action="<%=request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Edit" class="search">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
    <input type="hidden" name="PjSeq" value=""/>
    

    
    <!-- search -->
      <fieldset>
		<legend>검색</legend>
			<ul>
				<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
				<li><select id="" title="검색조건선택" name="searchGb" onchange="searchChk()">
					<option checked value="">전체</option>
					<option value="1">프로젝트코드번호</option>
					<option value="2">프로젝트명</option>
					<option value="3">고객사명</option>
					<option value="4">담당영업</option>
					<option value="5">담당PM</option>
				</select></li>
				<li><input type="text" class="text" title="검색어" id="textfield_search2" name="searchtxt" maxlength="100" value="<%=searchtxt %>"/></li>
				<li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
			</ul>
		</fieldset>
	</form>
    <!--//search -->
    <!-- Top 버튼영역 -->
	<div class="Tbtn_areaR"><a href="javascript:goExcel();" class="btn_type01 btn_type01_gray"><span>내려받기</span></a><a class="btn_type01 md0" onclick="javascript:goRegist();"><span>등록하기</span></a></div>
	<!-- //Top 버튼영역 -->
    </div>

      <table  class="tbl_type tbl_type_list" summary="프로젝트조회리스트(No., 진행, 프로젝트진행요청서, 검수증빙문서, 최종산출물, 프로젝트코드, 프로젝트구분, 프로젝트명, 고객사, 발주사, 담당영업, 담당PM, 프로젝트시작일, 프로젝트종료일, 프로젝트진행기간, 등록자, 등록일시)">
        <caption>프로젝트 (등록/수정) 리스트</caption>
		
		<colgroup>
						<col width="3%" />
						<col width="4%" />
						<col width="4%" />
						<col width="4%" />
						<col width="4%" />
						<col width="5%" />
						<col width="5%" />
						<col width="*" />
						<col width="7%" />
						<col width="7%" />
						<col width="5%" />
						<col width="5%" />
						<col width="5%" />
						<col width="5%" />
						<col width="5%" />
						<col width="5%" />
						<col width="5%" />
        </colgroup>
  
 		 <thead>
        <tr>
						<th>No.</th>
						<th>진행</th>
						<th>프로젝트진행요청서</th>
						<th>검수증빙문서</th>
						<th>최종산출물</th>
						<th>프로젝트코드</th>
						<th>프로젝트구분</th>
						<th>프로젝트명</th>
						<th>고객사</th>
						<th>발주사</th>
						<th>담당영업</th>
						<th>담당PM</th>
						<th>프로젝트시작일</th>
						<th>프로젝트종료일</th>
						<th>프로젝트진행기간</th>
						<th>등록자</th>
						<th>등록일시</th>
        </tr>
        </thead>
        <tbody>
  
        <!-- :: loop :: -->
        <!--리스트---------------->
        <%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
                    	
                    	/*프로젝트 구분 A-신규, B-증설, C-유지보수
                      	 */
                        	String ProjectDivision = ds.getString("ProjectDivision"); //프로젝트 구분
                            String ProjectStr = "";
                        	
                            if(ProjectDivision.equals("A")){
                        		ProjectStr = "신규";
                            }else if(ProjectDivision.equals("B")){
                            	ProjectStr = "증설";
                            }else if(ProjectDivision.equals("C")){
                            	ProjectStr = "유지보수";
                            }
                        	
                            String FreeCostYN = ds.getString("FreeCostYN"); //프로젝트 구분
                            String ProjectStr2 = "";
                        	
                            if(FreeCostYN.equals("Y")){
                            	ProjectStr2 = "(유상)";
                            }else if(FreeCostYN.equals("N")){
                            	ProjectStr2 = "(무상)";
                            }
                    	
                    	String ProgressStatus = ds.getString("CheckSuccessYN");
                    	String progressStatus2 = ds.getString("ProjectEndYN");
                    	String ProgressStr = "";
                    	if(ProgressStatus.equals("N")){
                    		ProgressStr = ds.getInt("ProgressPercent")+"%";
                    	}else if(ProgressStatus.equals("Y") && progressStatus2.equals("Y")){
                    		ProgressStr = "완료";
                    	}else if(ProgressStatus.equals("Y") && progressStatus2.equals("N")){
                    		ProgressStr = "검수";
                    	}
        %>
        
        <tr>
       	  <td><%=i+1 %></td>
       	  <td><%=ProgressStr %></td>
       	  <td>
          <!-- 프로젝트 진행문서 파일 시작. -->
          <%if(!ds.getString("ProjectProgressFile").equals("")){ %>
          <%
                   String ProjectProgressFile=ds.getString("ProjectProgressFile");
          		   String ProjectProgressFileNm=ds.getString("ProjectProgressFileNm");
          
//                    String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=ProjectProgressFile.lastIndexOf("/");
                  	
                    String projectfilename=ProjectProgressFile.substring(c_index+1);
              
                    String projectfilepath=""; //파일경로 읽어오기
                   
                    	
          
                    if(!ProjectProgressFile.equals("")){
                    	projectfilepath=ProjectProgressFile.substring(0,c_index); //파일경로 읽어오기
                    	
                    	//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                    	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                    	String spStrReplace = "";
                    	if(ProjectProgressFileNm.indexOf("&") != -1){
                    		spStrReplace=  ProjectProgressFileNm.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  ProjectProgressFileNm;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
          %>
          <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=projectfilename%>&filePath=<%=projectfilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" width="16" height="16" align="absmiddle" title="프로젝트 진행문서"></a>
          <%
                     }
               
          %>
		  
		  <!--프로젝트 진행문서 없을때.  -->
          <%}else{ %>
          -
          <%} %>
          
          <!-- 프로젝트 진행문서 파일 끝. -->
          </td>
          <td>
          
          <!-- 검수증빙문서 파일 시작. -->
          <%if(!ds.getString("CheckDocumentFile").equals("")){ %>
          <%
                   String CheckDocumentFile=ds.getString("CheckDocumentFile");
          		   String CheckDocumentFileNm=ds.getString("CheckDocumentFileNm");
          
//                    String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
                    int c_index=CheckDocumentFile.lastIndexOf("/");
                  	
                    String checkfilename=CheckDocumentFile.substring(c_index+1);
              
                    String checkfilepath=""; //파일경로 읽어오기
                   
                    	
          
                    if(!CheckDocumentFile.equals("")){
                    	checkfilepath=CheckDocumentFile.substring(0,c_index); //파일경로 읽어오기
                    	
                    	//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                    	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                    	String spStrReplace = "";
                    	if(CheckDocumentFileNm.indexOf("&") != -1){
                    		spStrReplace=  CheckDocumentFileNm.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  CheckDocumentFileNm;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
          %>
          <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=checkfilename%>&filePath=<%=checkfilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" width="16" height="16" align="absmiddle" title="검수증빙문서"></a>
          <%
                     }
               
          %>
		  <!--검수증빙문서 없을때.  -->
          <%}else{ %>
          -
          <%} %>
          <!-- 검수증빙문서 파일 끝. -->
          </td>
          <td>
          <!-- 최종산출물 파일 시작. -->
          <%if(!ds.getString("ProjectEndDocumentFile").equals("")){ %>
          <%
                   String ProjectEndDocumentFile=ds.getString("ProjectEndDocumentFile");
         		   String ProjectEndDocumentFileNm=ds.getString("ProjectEndDocumentFileNm");
          
//                    String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
                   //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
					String serverUrl = "" + request.getContextPath();
					
                    int c_index=ProjectEndDocumentFile.lastIndexOf("/");
                  	
                    String projectfilename=ProjectEndDocumentFile.substring(c_index+1);
              
                    String projectfilepath=""; //파일경로 읽어오기
                   
          
                    if(!ProjectEndDocumentFile.equals("")){
                    	projectfilepath=ProjectEndDocumentFile.substring(0,c_index); //파일경로 읽어오기
                    	
                    	//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                    	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                    	String spStrReplace = "";
                    	if(ProjectEndDocumentFileNm.indexOf("&") != -1){
                    		spStrReplace=  ProjectEndDocumentFileNm.replace("&", "[replaceStr]");
                    	System.out.println("spStrReplace:"+spStrReplace);
                    	}else{
                    		spStrReplace =  ProjectEndDocumentFileNm;	
                    	System.out.println("spStrReplace:"+spStrReplace) ;
                    	}
          %>
          <a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=projectfilename%>&filePath=<%=projectfilepath%>" ><img src="<%= request.getContextPath()%>/images/ico_down.gif" width="16" height="16" align="absmiddle" title="프로젝트 최종산출물"></a>
          <%
                     }
               
          %>
		<!--최종산출물 없을때.  -->
          <%}else{ %>
          -
          <%} %>
          <!-- 최종산출물 파일 끝. -->
          </td>
          <td><%=ds.getString("ProjectCode") %></td>
          <td><%=ProjectStr %><%=ProjectStr2 %></td>
          <td class="text_l"><a href="javascript:goDetail('<%=ds.getString("PjSeq")%>');"><%=ds.getString("ProjectName") %></a></td>
          <td><%=ds.getString("CustomerName") %></td>
          <td><%=ds.getString("PurchaseName") %></td>
          <td><%=ds.getString("ChargeNm") %></td>
          <td><%=ds.getString("ChargePmNm") %></td>
          <td><%=ds.getString("StartDate") %></td>
          <td><%=ds.getString("EndDate") %></td>
          <td><%=ds.getString("ProgressDate") %>일</td>
          <td><%=ds.getString("ProjectCreateUserNm") %></td>
          <td><%=ds.getString("CreateDate") %></td>       
        </tr>
        <!-- :: loop :: -->
        <%
                i++;
                    }
                } else {
            %>
        <tr>
          <td colspan="17">게시물이 없습니다.</td>
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
    
    <div class="Bbtn_areaR"><a class="btn_type01 md0" onclick="javascript:goRegist();"><span>등록하기</span></a></div>
    
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
<%= comDao.getMenuAuth(menulist,"21") %>