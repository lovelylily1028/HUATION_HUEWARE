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
	String dselect="";
	String atxt="";
	String btxt="";
	String ctxt="";

	if(searchGb.equals("A")){
		searchtxt=(String)model.get("searchtxt");
		atxt=searchtxt;
		aselect="selected";
	}else if(searchGb.equals("B")){
		searchtxt=(String)model.get("searchtxt");
		atxt=searchtxt;
		bselect="selected";
	}else if(searchGb.equals("C")){
		searchtxt=(String)model.get("searchtxt");
		btxt=searchtxt;
		cselect="selected";
	}else if(searchGb.equals("D")){
		searchtxt=(String)model.get("searchtxt");
		ctxt=searchtxt;
		dselect="selected";
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>채용관리 리스트</title>
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

		var obj=document.recruitManageForm;
		var gubun=obj.searchGb.value;

		if(gubun=='A'){
			obj.searchtxt.value=obj.atxt.value;
			if(obj.searchtxt.value==''){
				alert('연락처(이메일)를 입력해 주세요');
				return;
			}
		}else if(gubun=='B'){
			obj.searchtxt.value=obj.atxt.value;
			if(obj.searchtxt.value==''){
				alert('지원자 성명을 입력해 주세요');
				return;
			}
		}else if(gubun=='C'){
			obj.searchtxt.value=obj.btxt.value;
		}else if(gubun=='D'){
			obj.searchtxt.value=obj.ctxt.value;
		}
		
		obj.curPage.value='1';
		obj.submit();

    }

	function goDetail(apply_code){

		document.recruitManageForm.target ='_self';
		document.recruitManageForm.action = "<%=request.getContextPath()%>/B_Recruit.do?cmd=manageDefaultView";
		document.recruitManageForm.apply_code.value=apply_code;
		document.recruitManageForm.submit();

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
	
	function init_recruit() {

		openWaiting( );

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	}

	function searchChk(){

		var obj = document.recruitManageForm;

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
			obj.atxt.style.display='block';
			obj.btxt.style.display='none';
			obj.ctxt.style.display='none';
			obj.atxt.disabled=false;
		}else if(obj.searchGb[3].selected==true){
			obj.atxt.style.display='none';
			obj.btxt.style.display='block';
			obj.ctxt.style.display='none';
		}else if(obj.searchGb[4].selected==true){
			obj.atxt.style.display='none';
			obj.btxt.style.display='none';
			obj.ctxt.style.display='block';
		}
	}
	
	//인쇄하기 팝업 창
	 function printPagePop(apply_code) {

		   var pop = window.open("<%= request.getContextPath()%>/B_Recruit.do?cmd=managePrint&apply_code="+apply_code,"","width=823,height=920,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=yes, status=no");
		   
	 }
	
//-->
</script>
</head>

<%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();

%>

<body onload="init_recruit()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">HUEHome관리 &gt; 채용관리</div>
			<h3><span>채</span>용관리</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con recruitManageList" id="excelBody">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- 조회 -->
					<%= ld.getPageScript("recruitManageForm", "curPage", "goPage") %>
					<form  method="post" name="excelform"> </form>
				  	<form  method="post" name=recruitManageForm action = "<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitManageList" class="search">
				    	<input type = "hidden" name="apply_code"  />
				    	<input type = "hidden" name="curPage"  value="<%=curPage%>"/>
   
 					<%
					CodeParam codeParam=null;
					%>
 					<fieldset>
						<legend>검색</legend>
						<ul>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<li><select id="" title="검색조건선택" name="searchGb" onchange="searchChk()">
								<option checked value="">전체</option>
								<option value="A"  <%=aselect%>>연락처(이메일)</option>
								<option value="B"  <%=bselect%>>지원자성명</option>
								<option value="C"  <%=cselect%>>지원상태</option>
								<option value="D"  <%=dselect%>>결과상태</option>
							</select></li>
							<li><%  
								codeParam = new CodeParam();
								codeParam.setType("select"); 
								codeParam.setStyleClass("style2");
								codeParam.setName("btxt");
								codeParam.setSelected(btxt); 
								out.print(CommonUtil.getCodeList(codeParam,"H11")); 
							%></li>
							<li><%  
								codeParam = new CodeParam();
								codeParam.setType("select"); 
								codeParam.setStyleClass("style2");
								codeParam.setName("ctxt");
								codeParam.setSelected(ctxt); 
								out.print(CommonUtil.getCodeList(codeParam,"H12")); 
							%></li>							
							<li><input type="text" class="text" title="검색어" id="" name="searchtxt" value="<%=searchtxt%>" maxlength="100"/></li>
							<input type="hidden" name="searchtxt" class="text"  value="<%=searchtxt%>"/>
							<li><a href="javascript:goSearch();" class="btn_type01 md0"><span>검색</span></a></li>
						</ul>
					</fieldset>
					</form>
					<!-- //조회 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->																					
       
				<!-- 리스트 -->
				<table class="tbl_type tbl_type_list" summary="채용관리리스트(지원코드, 지원상태, 지원결과, 연락처(이메일), 지원자성명, 모집분야, 경력구분, 인쇄미리보기)">
					<colgroup>
						<col width="8%" />
						<col width="8%" />
						<col width="8%" />
						<col width="17%" />
						<col width="8%" />
						<col width="*" />
						<col width="8%" />
						<col width="8%" />
					</colgroup>
					<thead>
					<tr>
						<th>지원코드</th>
						<th>지원상태</th>
						<th>지원결과</th>
						<th>연락처(이메일)</th>
						<th>지원자성명</th>
						<th>모집분야</th>
						<th>경력구분</th>
						<th>인쇄미리보기</th>
					</tr>
					</thead>   
 
			      <!-- :: loop :: -->
			      <!--리스트---------------->
			  <%			
				if(ld.getItemCount() > 0){	
			    int i = 0;
				String apply_state="";
				String result_state="";
				String clr1="";
				String clr2="";
				while(ds.next()){
			
						apply_state=ds.getString("APPLY_STATE");
						result_state=ds.getString("RESULT_STATE");
			
						if(apply_state.equals("S")){
							clr1="recruitIng";
						}else{
							clr1="recruitOk";
						}
						if(result_state.equals("W")){
							clr2="recruitIng";
						}else if(result_state.equals("F")){ 
							clr2="recruitNo";
						}else{
							clr2="recruitOk";
						}
			
			%>
	<tbody>
      <tr>
        <td><%=ds.getString("APPLY_CODE")%></td>
        <td class="<%=clr1%>"><%=CommonUtil.getCodeNm(ds.getString("APPLY_STATE"),"H11")%></td>
        <td class="<%=clr2%>"><%=CommonUtil.getCodeNm(ds.getString("RESULT_STATE"),"H12")%></td>
        
        <%
			if(apply_state.equals("S")){
		%>
        
        <td><%=ds.getString("EMAIL")%></td>
        
        <%
			}else{
		
		%>
        <td><a href="javascript:goDetail('<%=ds.getString("APPLY_CODE")%>')"><%=ds.getString("EMAIL")%></a></td>
        
        <%
			}
		%>
        
        <td><%=ds.getString("USER_NM")%></td>
        <td class="text_l" title="<%=ds.getString("RECRUIT_NM")%>"><span class="ellipsis"><%=ds.getString("RECRUIT_NM")%></span></td>
        <td><%=CommonUtil.getCodeNm(ds.getString("CAREER"),"H02")%></td>
        <td><a href="javascript:printPagePop('<%=ds.getString("APPLY_CODE")%>')"><img src="<%= request.getContextPath() %>/images/icon_print.gif" border="0" title="인쇄 미리보기"/></a></td>
      </tr>
      <!-- :: loop :: -->
      <%		
	    i++;
	    }
	}else{
	%>
      <tr>
        <td colspan="660">게시물이 없습니다.</td>
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
<%= comDao.getMenuAuth(menulist,"43") %>