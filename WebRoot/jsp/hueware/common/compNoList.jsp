<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.company.CompanyDTO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
	
	String sForm = (String)model.get("sForm");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =StringUtil.nvl((String)model.get("searchtxt"),"--");
	int index1=searchtxt.indexOf("-");
	String searchtxt1=searchtxt.substring(0,index1);
	String t_searchtxt2=searchtxt.substring(index1+1);
	int index2=t_searchtxt2.indexOf("-");
	String searchtxt2=t_searchtxt2.substring(0,index2);
	String searchtxt3=t_searchtxt2.substring(index2+1);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>사업자 등록번호 조회</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/script.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--


	function goSearch() {
		var obj=document.searchform;
		var gubun=obj.searchGb.value;

		obj.searchtxt.value=obj.searchtxt1.value+'-'+obj.searchtxt2.value+'-'+obj.searchtxt3.value;

		if(obj.searchtxt1.value=='' || obj.searchtxt2.value=='' || obj.searchtxt3.value==''){
			alert('사업자 등록번호를 입력해 주세요');
			return;
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

	function deleteCompany(){
		if(confirm("삭제 하시겠습니까? 복구 불가능한 삭제입니다.")){
			var frm=document.searchform;
		    document.searchform.deleteYn.value = "Y";
			goSearch();
		}
	}
	function goUseNo(){
		//기존 comp_code = > permit_no 로 변경. 업체코드 관리를 위해서.2013_05_13(월)shbyeon.
		//하지만 현재 comp_code는 업체관리 코드 PK로만 사용중이며, 사업자등록번호가 comp_code 에서 permit_no로 변경된 것 뿐.
		var comp_no=eval('opener.document.<%=sForm%>.permit_no');
					
		comp_no.value=document.searchform.selectNo.value;
		
		self.close();

	}
	function compCodecheck1(form){
	   
	   var frm=document.searchform;
	   var obj=eval("document."+form);
	   var search1=frm.searchtxt1;
	   var search2=frm.searchtxt2;

	   if(obj.value.length>0){
			if (!isNumber(trim(obj.value))) {
				alert("숫자만 입력해 주세요.");
				obj.value=onlyNum(obj.value);
			} 
	   }
        
		if(search1.value.length==3){
			search2.focus();
		}

	}
	function compCodecheck2(form){
	   
	   var frm=document.searchform;
	   var obj=eval("document."+form);
	   var search2=frm.searchtxt2;
	   var search3=frm.searchtxt3;

	   if(obj.value.length>0){
			if (!isNumber(trim(obj.value))) {
				alert("숫자만 입력해 주세요.");
				obj.value=onlyNum(obj.value);
			} 
	   }
        
		if(search2.value.length==2){
			search3.focus();
		}

	}
//-->
</SCRIPT>
</head>
<%
// 	ListDTO ld = (ListDTO)model.get("listInfo");
	CompanyDTO compDto = (CompanyDTO)model.get("compDto");
%>
<body>
<div id="wrapWp">
<!-- header -->
	<div id="headerWp">
		<h1>사업자등록번호 조회</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
	<!-- 사업자등록번호조회 -->
	<form  method="post" name=searchform action = "<%= request.getContextPath()%>/B_Common.do?cmd=searchCompNo">
    <input type = "hidden" name="sForm"  value="<%=sForm%>">
    <input type = "hidden" name="deleteYn" id ="deleteYn"  value="">
    <input type = "hidden" name="searchGb"  value="B">
	<fieldset>
	<legend>사업자등록번호 조회</legend>
	<dl class="search_area">
	
	<dt><label for="">사업자등록번호</label>&nbsp;&nbsp;
    <input type="text" name="searchtxt1" class="text" title="앞번호" style="width:30px;" maxlength="3" value="<%=searchtxt1%>" onKeyUp = "compCodecheck1('searchform.searchtxt1')">&nbsp;&nbsp;-&nbsp;&nbsp;<input type="text" name="searchtxt2" class="text" title="중간번호" style="width:25px;" maxlength="2" value="<%=searchtxt2%>" onKeyUp = "compCodecheck2('searchform.searchtxt2')">&nbsp;&nbsp;-&nbsp;&nbsp;<input type="text" name="searchtxt3" class="text" title="뒷번호" style="width:50px;" maxlength="5" value="<%=searchtxt3%>" ><input type="hidden" name="searchtxt" value="<%=searchtxt%>"><a href="javascript:goSearch();" class="btn_type03"><span>조회</span></a></dt>
    
          <%			
if(searchtxt.equals("")){	
%>
           <dd> 사업자 등록번호를 조회하세요</dd>
           </dl>
		</fieldset>
		</form>
    <!-- //button -->
    <div class="Bbtn_areaC">
      <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a>
    </div>
    <!-- //button -->
    <%		
	}else if(compDto != null){ 
	%>
	<input type = "hidden" name="searchGb"  value="<%=compDto.getDeleted_yn()%>">
    <dd><strong>[<%=searchtxt%>]</strong>는 이미 등록 하셨던 사업자 등록번호 입니다. 
    	회사명:<strong>[<%=compDto.getComp_nm()%>]</strong>
    <%
    	if(compDto.getDeleted_yn().equals("Y") ){ //삭제된것.
    %>
    	<strong>[삭제처리됨]</strong>
    <%
    	}
    %>
    </dd> 
    </dl>
	</fieldset>
	</form>
  <!-- //button -->
  <div class="Bbtn_areaC">
    <a href="javascript:deleteCompany()" class="btn_type02 btn_type02_gray"><span>조회번호 완전 삭제</span></a>
    <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a>
  </div>
  <!-- //button -->
  <% 
}else if(searchtxt.equals("--")){
%>
  <dd>사업자 등록번호를 조회하세요.</dd>
	</dl>
	</fieldset>
	</form>
  <!-- //button -->
  <div class="Bbtn_areaC">
    <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a>
  </div>
  <!-- //button -->
  <%
}else{
%>
  <dd><strong>[<%=searchtxt%>]</strong>는 사용가능한 사업자 등록번호 입니다.</dd>
    <input type = "hidden" name="selectNo"  value="<%=searchtxt%>">
  </dl>
  </fieldset>
  </form>
  <!-- //button -->
  <div class="Bbtn_areaC"><a href="javascript:goUseNo();" class="btn_type02"><span>확인</span></a><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
  <!-- //button -->
  <%
}
%>
</div>
<!-- //content -->
</div>
</body>
</html>
