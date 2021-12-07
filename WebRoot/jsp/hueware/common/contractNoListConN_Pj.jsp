<%@page import="com.huation.common.CommonDAO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>

<%

	CommonDAO comDao=new CommonDAO();
	Map model = (Map)request.getAttribute("MODEL"); 
	
	String sForm = (String)model.get("sForm");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	
	String CtCd_tr_Cnt = (String)model.get("CtCd_tr_Cnt");
	String PjNm_tr_Cnt = (String)model.get("PjNm_tr_Cnt");


%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>계약관리 리스트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script src="<%= request.getContextPath()%>/js/hueware.js" type="text/javascript"></script>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.8.20.custom.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.2.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.8.20.custom.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
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
function init() {
	
	formObj=document.contractMgPageListForm; //form객체세팅
	
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
			alert('계약번호를 입력해주세요.');
			return;
		}
	}else if(gubun=='2'){
		if( formObj.searchtxt.value==''){
			alert('견적번호를 입력해주세요.');
			return;
		}
	}else if(gubun=='3'){
		if( formObj.searchtxt.value==''){
			alert('발주사명을 입력해주세요.');
			return;
		}
	}

	openWaiting();
	
	formObj.curPage.value='1';
	formObj.submit();

}

function goSelect(contractcode,contractname,Ordering_Organization){

	//var contOpenerForm = "opener.document." + "<%=sForm%>" + "<%=CtCd_tr_Cnt%>";
	//var contPjtNm = "opener.document." + "<%=sForm%>" + "<%=PjNm_tr_Cnt%>";
	//1.여기서부터 처리하면됨. 네임값으로 넘겨줬던 프로젝트명 과 계약코드를 ID값으로 넘겨주고 셋팅 해준다.(완료)
	//2.그 이후 처리해야 될 것. 12345 순으로 계약코드로 선택된 프로젝트명 마지막으로 셋팅 해주기.	(완료)
	//3.DB 배치 테이블 만들때. Sort 칼럼 줘야됨. 상세보기시 꺼내올때 DB에 넣은 순서대로 가져오기 위해서.
	//4.계약코드 행 삭제 시 해당 html 코드 id Cnt 값들 다 제거 시켜줘야함.
	//5.증설코드 부분 최초 증설건의 경우 조합한 프로젝트코드 값 넣어줘야함.
	//6.삭제 시 html코드와 계약코드 프로젝트명 다 삭제 리브무 시켜줘야함.

	var contract_code=eval('opener.document.<%=sForm%>.<%=CtCd_tr_Cnt%>');
	var contract_name=eval('opener.document.<%=sForm%>.ProjectName');
	var con_project_name=eval('opener.document.<%=sForm%>.<%=PjNm_tr_Cnt%>');
	var con_purchase_name=eval('opener.document.<%=sForm%>.PurchaseName');
	
	contract_code.value=contractcode;		//계약코드번호 변수에 값 셋팅 후 opener로 넘겨주기.
	contract_name.value=contractname;		//계약명(프로젝트명) 변수에 값 셋팅 후 opener로 넘겨주기.
	con_project_name.value=contractname;	//계약명 변수에 값 셋팅 후 opener로 넘겨주기.
	con_purchase_name.value=Ordering_Organization;
	
	//체크박스 checked 넘겨주는 부분.
	var checkyn=eval('opener.document.<%=sForm%>.readOnly');
	checkyn.checked=true;							//checkbox 체크여부 넘겨주기.
	$(contract_name).attr('readOnly',true);			//프로젝트명 input box readOnly 셋팅.
	$(contract_name).css('background','#edf5ef');	//프로젝트명 input box background 컬러 셋팅.
	checkyn.value='Y';	//readOnly value = "Y" Setting.
	self.close();
}

//-->
</script>
</head>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
	
	int iTotCnt = ld.getTotalItemCount();
	int iCurPage = ld.getCurrentPage();
	int iDispLine = ld.getListScale();
	int startNum = ld.getStartPageNum();
%>
<%=ld.getPageScript("contractMgPageListForm", "curPage", "goPage")%>
<body onload="init();">
  <div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>계약관리 리스트</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<!-- 조회 -->
  <form method="post" name="contractMgPageListForm" action="<%=request.getContextPath()%>/B_Common.do?cmd=searchContractNoConN_Pj" class="search">
    <input type="hidden" name="curPage" value="<%=curPage%>"/>
    <input type="hidden" name="ContractCode" value=""/>
    <input type = "hidden" name="sForm"  value="<%=sForm%>"/>
	<input type="hidden" name="CtCd_tr_Cnt" value="<%=CtCd_tr_Cnt%>"/>
	<input type="hidden" name="PjNm_tr_Cnt" value="<%=PjNm_tr_Cnt%>"/>
      <fieldset>
        <legend>검색</legend>
		<ul>
          <li><select name="searchGb" onchange="searchChk()" id="" class="">
          <option checked value="">전체</option>
          <option value="1" >계약번호</option>
          <option value="2" >견적번호</option>
          <option value="3" >발주사명</option>
        </select></li>
        <li><input type="text" name="searchtxt"title="검색어" class="text" maxlength="100" id="textfield_search2" value="<%=searchtxt %>" /></li>
        <li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
        </ul>
      </fieldset>
      </form>
      <!-- //조회 -->
    </div>
    <!--//search -->
   </div>
		<!-- //컨텐츠 상단 영역 -->
		<!-- 리스트 -->
      <table class="tbl_type tbl_type_list" summary="계약관리리스트(계약번호, 견적번호, 발주사, 계약명, 계약금액(공급가, 부가세, 합계), 계산서발행금액(누적발행금액, 미발행금액), 수금액(총수금액, 미수금액), 계약종료여부)">
        <caption>계약관리 리스트</caption>
       <colgroup>
			<col width="7%" />
			<col width="7%" />
			<col width="8%" />
			<col width="*" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="7%" />
			<col width="4.5%" />
		</colgroup>
		<thead>
		<tr>
			<th rowspan="2">계약번호</th>
			<th rowspan="2">견적번호</th>
			<th rowspan="2">발주사</th>
			<th rowspan="2">계약명</th>
			<th colspan="3">계약금액</th>
			<th colspan="2">계산서발행금액</th>
			<th colspan="2">수금액</th>
			<th rowspan="2">계약종료여부</th>
		</tr>
		<tr>
			<th>공급가</th>
			<th>부가세</th>
			<th>합계</th>
			<th>누적발행금액</th>
			<th>미발행금액</th>
			<th>총수금액</th>
			<th>미수금액</th>
		</tr>
		</thead>
		<tbody>
        <!-- :: loop :: -->
        <!--리스트---------------->
        <%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
               
                String Status = ds.getString("ContractStatus"); //계약종결 여부 플래그 값
                String StatusStr = "";							//계약종결 여부 플래그 뷰잉 값
                String StatusColor = "";						//계약종결 여부 플래그 뷰잉 컬러 값
                if(Status.equals("1")){
                	StatusStr = "-";
                }else if(Status.equals("2")){
                	StatusStr = "조기종료";
                	StatusColor = "txtColor_contractEarly";
                }else if(Status.equals("3")){
                	StatusStr = "계약종결";
                	StatusColor = "txtColor_contractEnd";
                }
        %>
        <tr class="<%=StatusColor%>">
          <td><a href="javascript:goSelect('<%=ds.getString("ContractCode")%>','<%=ds.getString("ContractName")%>','<%=ds.getString("Ordering_Organization") %>')"><%=ds.getString("ContractCode")%></a></td>
       	  <td><%=ds.getString("Public_No")%></td>
          <td title="<%=ds.getString("Ordering_Organization") %>"><span class="ellipsis"><%=ds.getString("Ordering_Organization") %></span></td>
          <td class="text_l" title="<%=ds.getString("ContractName") %>"><span class="ellipsis"><%=ds.getString("ContractName") %></span></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("SUPPLY_PRICE"))%></td>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("VAT"))%></td>
          <%
				long sprice=ds.getLong("SUPPLY_PRICE");
				long vat=ds.getLong("VAT");
				long total=sprice+vat;
		  %>
          <td class="text_r"><%=NumberUtil.getPriceFormat(total)%></td>
          <%if(!ds.getString("sum_price_total").equals("")){%>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("sum_price_total"))%></td>
          <%}else{%>
          <td>-</td>
          <%}%>
          <%if(!ds.getString("min_price_total").equals("")){ %>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("min_price_total"))%></td>
          <%}else{%>
          <td>-</td>
          <%} %>
         <%if(!ds.getString("deposit_amt_total").equals("")){ %>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("deposit_amt_total"))%></td>
         <%}else{ %>
          <td>-</td>
         <%} %>
         <%if(!ds.getString("no_collect_total").equals("")){ %>
          <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("no_collect_total"))%></td>
         <%}else{ %>
          <td>-</td>
         <%} %>
         <td><%=StatusStr%></td>

          
        </tr>
        <!-- :: loop :: -->
        <%
                i++;
                    }
                } else {
            %>
        <tr>
          <td colspan="12">게시물이 없습니다.</td>
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
    <!-- 가이드텍스트 -->
	<p class="guide_txt"> 계약관리에서 진행중 건만 선택하실 수 있으며, 목록에 없는 경우 계약관리 화면에서 해당 계약번호 상태가 '진행중'인지 확인십시오.</p>
	<!-- //가이드텍스트 -->
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
