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

	//CodeDAO codeDAO = new CodeDAO();
	//CodeDTO codeDto = new CodeDTO();

	//String comp_type="";
  	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>사원 리스트</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--


	function goSearch() {
		var obj=document.searchform;
		var gubun=obj.searchGb.value;

		if(gubun=='A'){
			if(obj.searchtxt.value==''){
				alert('사원아이디를 입력해 주세요');
				return;
			}
		}else if(gubun=='B'){
			if(obj.searchtxt.value==''){
				alert('사원명을 입력해 주세요');
				return;
			}
		}
		openWaiting();
		obj.submit();

    }

	function init() {

		openWaiting( );

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
			obj.searchtxt.disabled=true;
			obj.searchtxt.value='';	
		}else {
			obj.searchtxt.disabled=false;
		}
	}
	function goSelect(id,nm){
		
		
		var userid=eval('opener.document.<%=sForm%>.user_id');
		userid.value=id;
		var usernm=eval('opener.document.<%=sForm%>.user_nm');
		usernm.value=nm;
		
		self.close();
	
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
<body>
  <div id="wrapWp">
   <!-- header -->
	<div id="headerWp">
		<h1>사원 리스트</h1>
	</div>
	<!-- //header -->
	<!-- content -->
    <div id="contentWp">
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
	<!-- 조회 -->
	<form  method="post" name=searchform action = "<%= request.getContextPath()%>/B_Common.do?cmd=searchUser" class="search">
    <input type = "hidden" name="curPage"  value="<%=curPage%>">
    <input type = "hidden" name="sForm"  value="<%=sForm%>">
			
      <fieldset>
        <legend>검색</legend>
		<ul>
        <li><select name="searchGb" class=""  onChange="searchChk()">
          <option checked value="">전체</option>
          <option value="A"  <%=aselect%>>사원아이디</option>
          <option value="B"  <%=bselect%>>사원명</option>
        </select></li>
        <li><input type="text" name="searchtxt" style="ime-mode:active;width:200px" value="<%=searchtxt%>"  class="text" maxlength="100" ></li>
        <li><a href="javascript:goSearch();" class="btn_type01 md0"><span>검색</span></a></li>
        </ul>
      </fieldset>
      </form>
      <!-- //조회 -->
      </div>
      <!-- //컨텐츠 상단 영역 -->
      <!-- 리스트 -->
		<table class="tbl_type tbl_type_list" summary="사원리스트(사원아이디, 사원명)">
			<colgroup>
				<col width="50%" span="2" />
			</colgroup>
			<thead>
			<tr>
              <th>사원아이디</th>
              <th>사원명</th>
            </tr>
          </thead>
          <tbody>
          <!-- :: loop :: -->
          <!--리스트---------------->
          <%			
if(ld.getItemCount() > 0){	
    int i = 0;
	while(ds.next()){
%>
          <tr>
            <td><%=ds.getString("UserID")%></td>
            <td><a href="javascript:goSelect('<%=ds.getString("UserID")%>','<%=ds.getString("UserName")%>')"      ><%=ds.getString("UserName")%></a></td>
          </tr>
          <!-- :: loop :: -->
          <%		
    i++;
    }
}else{
%>
          <tr>
            <td colspan="2">조회된 내역이 없습니다. </td>
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
    <!-- button -->
    <div class="Bbtn_areaC">
      <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a>
    </div>
    <!-- //button -->
	</div>
	<!-- //content -->
</div>
</body>
</html>
<script>
searchChk();
</script>
