<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import = "com.huation.framework.persist.ListDTO"%>
<%@ page import = "com.huation.framework.data.DataSet"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
	String sForm = (String)model.get("sForm");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = "";
	String aselect="";
	String bselect="";

	if(searchGb.equals("A")){
		searchtxt=(String)model.get("searchtxt");
		aselect="selected";
	}else if(searchGb.equals("B")){
		searchtxt=(String)model.get("searchtxt");
		bselect="selected";
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>업체 리스트</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/script.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--


	function goSearch() {
	
		var obj=document.searchform;
		var gubun=obj.searchGb.value;

		if(gubun=='A'){
			if(obj.searchtxt.value==''){
				alert('업체명을 입력해 주세요');
				return;
			}
		}else if(gubun=='B'){
			if(obj.searchtxt.value==''){
				alert('사업자 번호를 입력해 주세요');
				return;
			}
		}
		openWaiting();
		obj.submit();

    }

	function init() {

		openWaiting( );
		
		var frm = document.searchform;
		
		frm.searchtxt.focus();

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
	}

	function searchChk(){

		var obj = document.searchform;

		if(obj.searchGb[0].selected==true){
		/* 	obj.searchtxt.disabled=true; */
			obj.searchtxt.value='';	
		}else {
			obj.searchtxt.disabled=false;
		}
	}
	function goSelect(code,permit,nm,owner,busi,bite,pos,adres,adrtl){
		//기존 (업체코드)COMP_CODE=> (업체번호)PERMIT_NO 변경 2013_03_18(월)shbyeon.
		
		var compcode=eval('opener.document.<%=sForm%>.comp_code'); 
		var permitno=eval('opener.document.<%=sForm%>.permit_no');
		var comopnm=eval('opener.document.<%=sForm%>.comp_nm');
		var ownernm=eval('opener.document.<%=sForm%>.owner_nm');
		var business=eval('opener.document.<%=sForm%>.business');
		var bitem=eval('opener.document.<%=sForm%>.b_item');
		var post=eval('opener.document.<%=sForm%>.post');
		var adress=eval('opener.document.<%=sForm%>.address');
		var addrdtl=eval('opener.document.<%=sForm%>.addr_detail');

		compcode.value=code;
		permitno.value=permit;
		comopnm.value=nm;
		ownernm.value=owner;
		business.value=busi;
		bitem.value=bite;
		post.value=pos;
		adress.value=adres;
		addrdtl.value=adrtl;

		self.close();

	}
	function goRegist() {

		document.searchform.target ='_self';
		document.searchform.action = "<%= request.getContextPath()%>/B_Company.do?cmd=companyRegistForm";		
		document.searchform.submit();

	}
//-->
</SCRIPT>
</head>
<%
	ListDTO ld = (ListDTO)model.get("listInfo");
	DataSet ds = (DataSet)ld.getItemList();	
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();

%>
<%= ld.getPageScript("searchform", "curPage", "goPage") %>
<body onLoad = "init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>업체 리스트</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
	<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
	<!-- 조회 -->
<form  method="post" name=searchform action = "<%= request.getContextPath()%>/B_Common.do?cmd=searchComp_lC" class="search">
  <input type = "hidden" name = "comp_nm" value="">
  <input type = "hidden" name = "comp_no" value="">
  <input type = "hidden" name = "comp_code" value="">
  <input type = "hidden" name="curPage"  value="<%=curPage%>">
  <input type = "hidden" name="sForm"  value="<%=sForm%>">
	<fieldset>
        <legend>검색</legend>
		<ul>
        <li><select name="searchGb" class="" onchange="searchChk()" >
          <option checked value="A"  <%=aselect%>>업체명</option>
          <option value="B"  <%=bselect%>>사업자 번호</option>
          <option value="">전체</option>
        </select></li>
        <li><input type="text" name="searchtxt" title="검색어" value="<%=searchtxt%>"  class="text" maxlength="100" /></li>
        <li><a href="javascript:goSearch();" class="btn_type01 md0"><span>검색</span></a></li>
        </ul>
       
      </fieldset>
      </form>
    <!-- //조회 -->
    </div>
    <!-- contents -->
      <table class="tbl_type tbl_type_list" summary="업체리스트(사업자등록번호, 업체명, 법인등록번호(주민등록번호), 대표자명(고객명))">
          <caption>업체 리스트</caption>
         <colgroup>
         	<col width="6%" />
			<col width="20%" />
			<col width="*" />
			<col width="20%" />
			<col width="20%" />
		</colgroup>
		<thead>
		<tr>
			<th>부적격업체</th>
			<th>사업자등록번호</th>
			<th>업체명</th>
			<th>법인등록번호(주민등록번호)</th>
			<th>대표자명(고객명)</th>
		</tr>
		</thead>
		<tbody>
          <%			
if(ld.getItemCount() > 0){	
    int i = 0;
    String UNFIT_ID = "";
	while(ds.next()){
%>
          <tr>
        <%
        UNFIT_ID = ds.getString("UNFIT_ID");
        	if(!UNFIT_ID.isEmpty()){
        %>
           <td><img src="<%= request.getContextPath()%>/images/common/ico_unfit.gif" title="부적격업체지정"></td>
        <%
        	}else{
        %>
        <td></td>
        <%
        	} 
        %>   
            <td><%=ds.getString("PERMIT_NO")%></td>
            <!-- COMP_CODE = 업체코드값 2013_03_22 shbyeon. -->
            <td title="<%=ds.getString("COMP_NM")%>"><span class="ellipsis"><a href="javascript:goSelect('<%=ds.getString("COMP_CODE")%>','<%=ds.getString("PERMIT_NO")%>','<%=ds.getString("COMP_NM")%>','<%=ds.getString("OWNER_NM")%>','<%=ds.getString("BUSINESS")%>','<%=ds.getString("B_ITEM")%>','<%=ds.getString("POST")%>','<%=ds.getString("ADDRESS")%>','<%=ds.getString("ADDR_DETAIL")%>')"><%=ds.getString("COMP_NM")%></a></span></td>
            <td><%=ds.getString("COMP_NO")%></td>
            <td title="<%=ds.getString("OWNER_NM")%>"><span class="ellipsis"><%=ds.getString("OWNER_NM")%></span></td>
          </tr>
          <!-- :: loop :: -->
          <%		
    i++;
    }
}else{
%>
          <tr>
            <td colspan="4">조회된 내역이 없습니다. </td>
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
		<div class="Bbtn_areaC">
      <!-- a href="javascript:goRegist();"><img src="<%= request.getContextPath()%>/images/btn_reg3.gif" width="40" height="23" title="등록"/></a -->
      <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
    <!-- //button -->
    </div>
    <!-- //contents -->
</div>
</body>
</html>
<script>
searchChk();
</script>
