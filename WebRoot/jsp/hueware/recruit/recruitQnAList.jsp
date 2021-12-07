<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.framework.util.DateTimeUtil"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%

	Map model = (Map)request.getAttribute("MODEL"); 
	String curPage = (String)model.get("curPage");
	String searchGb =(String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String aselect="";
	String bselect="";
	String cselect="";

	if(searchGb.equals("B")){
		searchtxt=(String)model.get("searchtxt");
		aselect="selected";
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>채용문의 리스트(자주하는 질문)</title>
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
		var obj=document.Qnaform;
		var gubun=obj.searchGb.value;

		if(gubun=='B'){
			if(obj.searchtxt.value==''){
				alert('검색하실 질문을 입력해 주세요');
				return;
			}
		}
		
		obj.curPage.value='1';
		obj.submit();

    }

	function goRegist() {

		document.Qnaform.target ='_self';
		document.Qnaform.action = "<%= request.getContextPath()%>/B_Recruit.do";		
	    document.Qnaform.cmd.value="qnaRegistForm";
		document.Qnaform.submit();

	}

	function goDetail(qna_no){
		
		document.Qnaform.target ='_self';
		document.Qnaform.action = "<%= request.getContextPath()%>/B_Recruit.do";		
	    document.Qnaform.cmd.value="qnaView";
		document.Qnaform.qna_no.value=qna_no;
		document.Qnaform.submit();

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
	
	function init_recuritQna() {

		openWaiting( );

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	}

	function searchChk(){

		var obj = document.Qnaform;

		if(obj.searchGb[0].selected==true){
			obj.searchtxt.disabled=true;
			obj.searchtxt.value='';	
		}else {
			obj.searchtxt.disabled=false;
		}
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

<body onload="init_recuritQna()">
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">HUEHome관리 &gt; 자주묻는질문</div>
			<h3><span>자</span>주묻는질문</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- 조회 -->
					<%= ld.getPageScript("Qnaform", "curPage", "goPage") %>
					  <form  method="post" name="excelform"></form>
					  <form  method="post" name=Qnaform action = "<%= request.getContextPath()%>/B_Recruit.do" class="search">
					    <input type = "hidden" name="cmd"  value="recruitQnAList"/>
					    <input type = "hidden" name="qna_gb"  value="01"/>
					    <input type = "hidden" name="qna_no"  />
					    <input type = "hidden" name="curPage"  value="<%=curPage%>"/>
    
					<fieldset>
						<legend>검색</legend>
						<ul>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<li><select id="" title="검색조건선택" name="searchGb" onchange="searchChk()">
								<option checked value="">전체</option>
								<option value="B"  <%=aselect%>>질문</option>
							</select></li>
							<li><input type="text"  name="searchtxt" class="text" title="검색어" id="" value="<%=searchtxt%>" maxlength="100"/></li>
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
				<table class="tbl_type tbl_type_list" summary="자주묻는질문리스트(No., 제목, 작성자, 등록일)">
					<colgroup>
						<col width="5%" />
						<col width="*" />
						<col width="8%" />
						<col width="8%" />
					</colgroup>
					<thead>
					<tr>
						<th>No.</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일</th>
					</tr>
					</thead>
 
        <!-- :: loop :: -->
        <!--리스트---------------->
        <%			
		if(ld.getItemCount() > 0){	
		    int i = 0;
			long  no=0;
			while(ds.next()){
		
					no=Long.parseLong(ds.getString("QNA_NO"));
		%>
       <tbody> 
        <tr>
          <td><%=no%></td>
          <td class="text_l" title="<%=ds.getString("QUESTION")%>"><span class="ellipsis"><a href="javascript:goDetail('<%=ds.getString("QNA_NO")%>')"><%=ds.getString("QUESTION")%></a></span></td>
          <td><%=ds.getString("REG_ID")%></td>
          <td><%=DateTimeUtil.getDateType(1,ds.getString("REG_DT"),"/")%></td>
        </tr>
        
        <!-- :: loop :: -->
        <%		
		    i++;
		    }
		}else{
		%>
        
        <tr>
          <td colspan="4">게시물이 없습니다.</td>
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
<%= comDao.getMenuAuth(menulist,"44") %>