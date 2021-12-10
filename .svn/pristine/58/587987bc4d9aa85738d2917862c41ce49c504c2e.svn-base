<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import ="com.huation.common.PostCodeDTO" %>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%

	String vSearchType=(String)model.get("vSearchType");
	String vSearch = (String)model.get("vSearch");

    String pForm = (String)model.get("pForm");
    String pZip =(String)model.get("pZip");
    String pAddr =(String)model.get("pAddr");
    String pDong = (String)model.get("pDong");
    String LineBgColor = "#40B389";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>우편번호검색</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/script.js"></script>
<script language="javascript">
<!--

var formObj;

	function ClickZipCode(zip, addr)
	{
		var f = opener.document.<%=pForm%>;
		f.<%=pZip%>.value = zip;
		f.<%=pAddr%>.value = addr;
		f.<%=pAddr%>.focus();
		self.close();
	}


//초기세팅
function init() {
	
	 formObj=document.ZipSearch; //form객체세팅
	
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

	 formObj.searchGb.value='<%=vSearchType%>';
	 formObj.searchtxt.value='<%=vSearch%>';
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
	
	if(gubun=='0'){
		alert('검색조건을 선택하세요.');
		formObj.searchtxt.value='';
		return;
	}
	
	if(gubun=='1'){
		if( formObj.searchtxt.value==''){
			alert('(시/군/구)를 입력해주세요.');
			return;
		}
	}else if(gubun=='2'){
		if( formObj.searchtxt.value==''){
			alert('도로 명을 입력해주세요.');
			return;
		}
	}else if(gubun=='3'){
		if( formObj.searchtxt.value==''){
			alert('건물 명을 입력해주세요.');
			return;
		}
	}
	
	formObj.submit();
}
	
//-->
</script>
<body onload="init();">
<div id="wrapWp">
<!-- header -->
<div id="headerWp">
	<h1>우편번호 조회</h1>
</div>
<!-- //header -->
<!-- content -->
	<div id="contentWp">
<form name="ZipSearch" method="post" action="<%= request.getContextPath()%>/B_Common.do?cmd=searchPost">
<fieldset>
	<legend>우편번호 조회</legend>
      <!-- search -->
      <dl class="search_area">
        <input type=hidden name=pForm value="<%=pForm%>">
        <input type=hidden name=pZip value="<%=pZip%>">
        <input type=hidden name=pAddr value="<%=pAddr%>">
        <dt><span class="guide_txt">아래 입력 란에 찾으실 주소를 입력하세요!<br />(도로명 또는 건물명으로 검색이 용이함.)</span><br /><select name="searchGb" onchange="searchChk();">
          <option value="0" selected="selected">선택</option>
          <option value="1" >시/군/구</option>
          <option value="2" >도로명</option>
          <option value="3" >건물명</option>
        </select>&nbsp;<input type="text" name="searchtxt" title="검색주소" style="width:200px;" value="<%=vSearch%>"  class="text" maxlength="100" ></input><a href="javascript:goSearch();" class="btn_type03"><span>조회</span></a></dt>
      <!-- //search -->
      <dd class="listPost">
       <ul class="listPost_area">
      
			<%
				ListDTO ld = (ListDTO)model.get("listInfo");
				DataSet ds = (DataSet)ld.getItemList();	
				
				int iTotCnt = ld.getTotalItemCount();
				int iCurPage = ld.getCurrentPage();
				int iDispLine = ld.getListScale();
				int startNum = ld.getStartPageNum();
				
				
			%>
			<!-- :: loop :: -->
	        <!--리스트---------------->
			<%
	         if (ld.getItemCount() > 0) {
	                 int i = 0;
	                 while (ds.next()) {
	                	 
	                	//주소 중 리는 필수값이 아니므로 문법 맞춤을 위해 띄어쓰기를 위해 셋팅 해준다.
	                	String riSetting = "";
	     				if(!ds.getString("Ri").equals("")){
	     					riSetting = " "+ds.getString("Ri")+" ";
	     				}else{
	     					riSetting = " ";
	     				}
	     	%>
            <li><a href="javascript:ClickZipCode('<%=ds.getString("ZipCode")%>','<%=ds.getString("SiDo")%> <%=ds.getString("SiGunGu")%> <%=ds.getString("YubMyunDong")%><%=riSetting%><%=ds.getString("RoadName")%>')" ><strong>[<%=ds.getString("ZipCode")%>]</strong> <%=ds.getString("SiDo")%> <%=ds.getString("SiGunGu")%> <%=ds.getString("YubMyunDong")%> <%=ds.getString("Ri")%> <%=ds.getString("RoadName")%> <%=ds.getString("BuildingName")%></a></li>
          <%
          		i++;
	              	}
          %>
		  <%
		  }else{
		  %>
            <li class="none">검색된 우편번호가 없습니다.</li>
          <%
	      }
		  %>
		   </ul>   
		  </dd>
		  </dl>
		  </fieldset>
		  </form>


    <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>   
    <!-- //button -->
        </div>
    <!-- contents -->
 </div>

</body>
</html>
