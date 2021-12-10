<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CommonDAO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
    
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt=(String)model.get("searchtxt");
	String sForm = (String)model.get("sForm");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>모 프로젝트 조회 리스트</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<SCRIPT LANGUAGE="JavaScript">
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
function init() {
	
	formObj=document.p_ProjectCodeSearchForm; //form객체세팅
	
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
	//모 프로젝트 선택하기.(증설코드도 생성해옴.)
	function goSelect(projectcode,projectname){

		var project_code=eval('opener.document.<%=sForm%>.P_ProjectCode');
		var project_name=eval('opener.document.<%=sForm%>.P_ProjectName');
		//var project_name;
		
		project_code.value=projectcode;			//모 프로젝트 코드 번호 변수에 값 셋팅 후 openner로 넘겨주기.
		project_name.value=projectname;			//모 프로젝트 명 변수에 값 셋팅 후 openner로 넘겨주기.
		
		<%-- Get 방식 처리 방법.
		document.p_ProjectCodeSearchForm.action = "<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectMoreCodeMgCreate&project_code="+projectcode+"&project_name="+projectname;
		document.p_ProjectCodeSearchForm.submit();
		--%>
		
		//Jquery Ajax..(모 프로젝트 코드 선택으로인한 증설코드 생성 Action 호출 Start.)
		$.ajax({
			   url : "<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectMoreCodeMgCreate",
			   type : "post",		//Post방식.
			   dataType : "text",	//데이타 타입 텍스트.
			   async : false,		//어씽크 false = 비동기, true = 동기
			   
			   //넘겨줄 파라미터 및 벨류 값 셋팅.
			   data : {				
			    "project_code" : project_code.value	//선택한 프로젝트 코드 및 벨류값.
			   },
			   //성공 시 아래 펑션 시작. Action단에서 가져온 Data
			   success : function(data, textStatus, XMLHttpRequest){
				   
				   if(data != "MAX"){					   
				   //모 프로젝트 코드로 인한 증가될 증설코드 등록 폼 페이지로 넘겨주기.
				   var more_code=eval('opener.document.<%=sForm%>.MoreCode');	
				   more_code.value=data;	//Action에서 가져온 데이타.
				   }else{
					   alert("해당 프로젝트에 대하여 증설된 코드 값이 9999를 넘어선 (MAX)입니다.\n해당 프로젝트로 더이상 코드가 생성 불가하므로 관리자에게 문의하세요!");
					   var more_code=eval('opener.document.<%=sForm%>.MoreCode');
					   more_code.value=""; //증설코드 Value 초기화.
					   var project_name=eval('opener.document.<%=sForm%>.P_ProjectName');
					   project_name.value="";	//모 프로젝트 명 Value 초기화.
					   return;
				   }
				
			   },
			   //Error 시 출력되는 경고 메시지.
			   error : function(request, status, error){
			    alert("code :"+request.status + "\r\nmessage :" + request.responseText);
			   }
			  });  
		
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
<%= ld.getPageScript("p_ProjectCodeSearchForm", "curPage", "goPage") %>
<body onload = "init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>프로젝트코드 리스트</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<!-- 조회 -->
<form  method="post" name="p_ProjectCodeSearchForm" action = "<%=request.getContextPath()%>/B_ProjectCodeManage.do?cmd=p_projectCodeSearch"  class="search">
  <input type = "hidden" name="curPage"  value="<%=curPage%>"/>
  <input type = "hidden" name="sForm" value="<%=sForm %>"/>
  <fieldset>
	<legend>검색</legend>
	<ul>
        <li><select name="searchGb" class=""  onchange="searchChk()">
          <option checked value="">전체</option>
          <option value="1" >프로젝트 코드번호</option>
          <option value="2" >프로젝트 명</option>
          <option value="3" >고객사 명</option>
          <option value="4" >담당영업</option>
          <option value="5" >담당PM</option>
        </select></li>
        <li><input type="text" name="searchtxt" title="검색어" value="<%=searchtxt%>"  class="text" maxlength="100" ></input></li>
        <li><a href="javascript:goSearch();" class="btn_type01 md0"><span>검색</span></a></li>
        </ul>
      </fieldset>
      </form>
   	 <!-- //조회 -->
	</div>
	<!-- //컨텐츠 상단 영역 -->
		<!-- 리스트 -->
        <table class="tbl_type tbl_type_list" summary="프로젝트코드리스트(No., 진행, 프로젝트코드, 프로젝트구분, 프로젝트명, 고객사, 발주사, 담당영업, 담당PM, 프로젝트시작일, 프로젝트종료일, 프로젝트진행기간, 등록자)">
          <caption>모 프로젝트 조회 리스트</caption>
          <colgroup>
				<col width="4%" />
				<col width="5%" />
				<col width="7%" />
				<col width="7%" />
				<col width="*" />
				<col width="9%" />
				<col width="9%" />
				<col width="5%" />
				<col width="5%" />
				<col width="7%" />
				<col width="7%" />
				<col width="5%" />
				<col width="5%" />
			</colgroup>
			<thead>
			<tr>
				<th>No.</th>
				<th>진행</th>
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
          <td><a href="javascript:goSelect('<%=ds.getString("ProjectCode")%>','<%=ds.getString("ProjectName") %>')";><%=ds.getString("ProjectCode") %></a></td>
          <td><%=ProjectStr %><%=ProjectStr2 %></td>
          <td class="text_l" title="<%=ds.getString("ProjectName") %>"><span class="ellipsis"><%=ds.getString("ProjectName") %></span></td>
          <td title="<%=ds.getString("CustomerName") %>"><span class="ellipsis"><%=ds.getString("CustomerName") %></span></td>
          <td title="<%=ds.getString("PurchaseName") %>"><span class="ellipsis"><%=ds.getString("PurchaseName") %></span></td>
          <td title="<%=ds.getString("ChargeNm") %>"><span class="ellipsis"><%=ds.getString("ChargeNm") %></span></td>
          <td title="<%=ds.getString("ChargePmNm") %>"><span class="ellipsis"><%=ds.getString("ChargePmNm") %></span></td>
          <td><%=ds.getString("StartDate") %></td>
          <td><%=ds.getString("EndDate") %></td>
          <td><%=ds.getString("ProgressDate") %>일</td>
          <td title="<%=ds.getString("ProjectCreateUserNm") %>"><span class="ellipsis"><%=ds.getString("ProjectCreateUserNm") %></span></td>    
        </tr>
        <!-- :: loop :: -->
        <%
                i++;
                    }
                } else {
            %>
        <tr>
          <td colspan="13">조회된 내역이 없습니다.</td>
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
</form>
</body>
</html>

