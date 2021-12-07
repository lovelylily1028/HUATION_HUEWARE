<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.framework.util.DateTimeUtil"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%

	Map model = (Map)request.getAttribute("MODEL"); 
	String curPage = (String)model.get("curPage");
	String searchGb =(String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String aselect="";
	String bselect="";
	String cselect="";
	String atxt="";
	String btxt="";
	String ctxt="";

	if(searchGb.equals("A")){
		searchtxt=(String)model.get("searchtxt");
		atxt=searchtxt;
		aselect="selected";
	}else if(searchGb.equals("B")){
		searchtxt=(String)model.get("searchtxt");
		btxt=searchtxt;
		bselect="selected";
	}else if(searchGb.equals("C")){
		ctxt=searchtxt;
		searchtxt=(String)model.get("searchtxt");
		cselect="selected";
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>채용공고 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript">
<!--


	function goSearch() {
		var obj=document.recruitNotiForm;
		var gubun=obj.searchGb.value;

		if(gubun=='A'){
			obj.searchtxt.value=obj.atxt.value;
			if(obj.searchtxt.value==''){
				alert('모집분야를 입력해 주세요');
				return;
			}
		}else if(gubun=='B'){
			obj.searchtxt.value=obj.btxt.value;
			if(obj.searchtxt.value==''){
				alert('채용유형을 선택해 주세요');
				return;
			}
		}else if(gubun=='C'){
			obj.searchtxt.value=obj.ctxt.value;
			if(obj.searchtxt.value==''){
				alert('대상을 선택 주세요');
				return;
			}
		}

		obj.curPage.value='1';
		obj.submit();

    }

	function goRegist() {

		document.recruitNotiForm.target ='_self';
		document.recruitNotiForm.action = "<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitNotifyRegistForm";		
		document.recruitNotiForm.submit();

	}

	function goDetail(recruit_no){
	
		document.recruitNotiForm.target ='_self';
		document.recruitNotiForm.action = "<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitNotifyView";
		document.recruitNotiForm.recruit_no.value=recruit_no;
		document.recruitNotiForm.submit();

	}

	// 여기서 부터는 처리중 표현하는 function

	function closeWaiting() {

		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'hidden';
		} else {
			if (document.layers) {
				document.loadingbar.visibility = 'hide';
			} else {
				document.all.loadingbar.style.visibility = 'hidden';
			}
		}
	}

	//보이기
	function openWaiting( ) {
		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'visible';
		} else{
			if (document.layers) {
				document.loadingbar.visibility = 'show';
			} else {
				document.all.loadingbar.style.visibility = 'visible';
			}
		}
	}

	var observer;
	
	function init_recruitNotify() {

		openWaiting( );

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	}

	function searchChk(){

		var obj = document.recruitNotiForm;

		if(obj.searchGb[0].selected==true){
			obj.atxt.style.display='block';
			obj.btxt.style.display='none';
			obj.ctxt.style.display='none';
			obj.atxt.disabled=true;
			obj.atxt.value='';	
		}else if(obj.searchGb[1].selected==true){
			obj.atxt.style.display='block';
			obj.btxt.style.display='none';
			obj.ctxt.style.display='none';
			obj.atxt.disabled=false;
		}else if(obj.searchGb[2].selected==true){
			obj.atxt.style.display='none';
			obj.btxt.style.display='block';
			obj.ctxt.style.display='none';
		}else if(obj.searchGb[3].selected==true){
			obj.atxt.style.display='none';
			obj.btxt.style.display='none';
			obj.ctxt.style.display='block';
		}
	}
//-->
</script>
</head>
<form  method="post" name="excelform"></form>
<%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();

%>

<body onLoad="init_recruitNotify()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">HUEHome관리 &gt; 채용공고</div>
			<h3><span>채</span>용공고</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
				
				<!-- 조회 -->
				<%= ld.getPageScript("recruitNotiForm", "curPage", "goPage") %>
				  <form  method="post" name=recruitNotiForm action = "<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitNotifyList" class="search">
				    <input type = "hidden" name="recruit_no"  />
				    <input type = "hidden" name="curPage"  value="<%=curPage%>"/>
    
					<%
					CodeParam codeParam=null;
					%>
					
					<fieldset>
						<legend>검색</legend>
						<ul>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<li><select name="searchGb" onchange="searchChk()" id="" title="검색조건선택">
								<option checked value="">전체</option>
								<option value="A"  <%=aselect%>>모집분야</option>
								<option value="B"  <%=bselect%>>채용유형</option>
								<option value="C"  <%=cselect%>>대상</option>
							</select></li>    
					        <li><%  
								codeParam = new CodeParam();
								codeParam.setType("select"); 
								codeParam.setStyleClass("style2");
								codeParam.setName("btxt");
								codeParam.setSelected(btxt); 
								out.print(CommonUtil.getCodeList(codeParam,"H01")); 
					        %></li>
					        <li><%  
								codeParam = new CodeParam();
								codeParam.setType("select"); 
								codeParam.setStyleClass("style2");
								codeParam.setName("ctxt");
								codeParam.setSelected(ctxt); 
								out.print(CommonUtil.getCodeList(codeParam,"H02")); 
							%></li>
							<li><input type="text" class="text" title="검색어" id="" name="searchtxt" value="<%=searchtxt%>" maxlength="100"/></li>
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
				<table class="tbl_type tbl_type_list" summary="채용공고리스트(No., 채용유형, 모집분야, 대상, 접수시작일, 접수마감일)">
					<colgroup>
						<col width="5%" />
						<col width="8%" />
						<col width="*" />
						<col width="8%" />
						<col width="8%" />
						<col width="8%" />
					</colgroup>
					<thead>
					<tr>
						<th>No.</th>
						<th>채용유형</th>
						<th>모집분야</th>
						<th>대상</th>
						<th>접수시작일</th>
						<th>접수마감일</th>
					</tr>
					</thead>
        
	        <!-- :: loop :: -->
	        <!--리스트---------------->
	        <%			
			if(ld.getItemCount() > 0){	
			    int i = 0;
				long  no=0;
				while(ds.next()){
						no=Long.parseLong(ds.getString("RECRUIT_NO"));
			%>
        <tbody>
	        <tr>
	          <td><%=no%></td>
	          <td><%=CommonUtil.getCodeNm(ds.getString("RECRUIT_TYPE"),"H01")%></td>
	          <td class="text_l" title="<%=ds.getString("SUBJECT")%>"><span class="ellipsis"><a href="javascript:goDetail('<%=ds.getString("RECRUIT_NO")%>')"><%=ds.getString("SUBJECT")%></a></span></td>
	          <td><%=CommonUtil.getCodeNm(ds.getString("CAREER"),"H02")%></td>
	          <td><%=DateTimeUtil.getDateType(1,ds.getString("RECRUIT_START"),"/")%></td>
	          <td><%=DateTimeUtil.getDateType(1,ds.getString("RECRUIT_END"),"/")%></td>
	        </tr>
	        <!-- :: loop :: -->
	        
	        <%		
			    i++;
			    }
			}else{
			%>
        
	        <tr>
	          <td colspan="6">게시물이 없습니다.</td>
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
		</div>
	</div>
	<!-- //container -->    	

<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->

</div>
</body>
</html>
<script>
searchChk();
</script>
<%= comDao.getMenuAuth(menulist,"42") %>