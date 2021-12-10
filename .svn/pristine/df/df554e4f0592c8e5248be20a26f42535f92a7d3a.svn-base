<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CommonDAO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%
    
	CommonDAO comDao=new CommonDAO();
	 
	String sForm = (String)model.get("sForm");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt=(String)model.get("searchtxt");
	String contractGb =(String)model.get("contractGb");
	String type = (String)model.get("type");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>발행번호 리스트</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/script.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
	var  formObj;//form 객체선언
	
	//초기세팅
	function init() {
		
		formObj=document.searchform; //form객체세팅
		
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
		 formObj.contractGb.value='<%=contractGb%>';	
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

	function goSearch() {
		
		var gubun=formObj.searchGb.value;

		if(gubun=='D'){
			if(formObj.searchtxt.value==''){
				alert('발행번호를 입력해 주세요');
				return;
			}
		}else if(gubun=='B'){
			if(formObj.searchtxt.value==''){
				alert('제목을 입력해 주세요');
				return;
			}
		}else if(gubun=='A'){
			if(formObj.searchtxt.value==''){
				alert('수신자를 입력해 주세요');
				return;
			}
		}
		openWaiting();
		formObj.submit();

    }

	function goSelect(no,recv,titl,compcode,compnm,ownernm,buse,bitem,pos,addr,addr_dtl,suamt,vatamt,sumamt,charid,charnm,e_compnm,permitno,productno,dpublicyn,projectpk,indirectsalesyn,purchase,sales_profit,profit_percent,salessort,orderble){
		
		var p_public_no=eval('opener.document.<%=sForm%>.p_public_no');
		var receiver=eval('opener.document.<%=sForm%>.receiver');
		var title=eval('opener.document.<%=sForm%>.title');
		var comp_code=eval('opener.document.<%=sForm%>.comp_code');
		var comp_nm=eval('opener.document.<%=sForm%>.comp_nm');
		var owner_nm=eval('opener.document.<%=sForm%>.owner_nm');
		var business=eval('opener.document.<%=sForm%>.business');
		var b_item=eval('opener.document.<%=sForm%>.b_item');
		var post=eval('opener.document.<%=sForm%>.post');
		var address=eval('opener.document.<%=sForm%>.address');
		var address_detail=eval('opener.document.<%=sForm%>.addr_detail');
		var supply_price_view=eval('opener.document.<%=sForm%>.supply_price_view');
		var supply_price=eval('opener.document.<%=sForm%>.supply_price');
		var vat_view=eval('opener.document.<%=sForm%>.vat_view');
		var vat=eval('opener.document.<%=sForm%>.vat');
		var total_amt_view=eval('opener.document.<%=sForm%>.total_amt_view');
		var user_nm=eval('opener.document.<%=sForm%>.user_nm');
		var user_id=eval('opener.document.<%=sForm%>.user_id');
		var sales_charge=eval('opener.document.<%=sForm%>.sales_charge');
		var e_comp_nm=eval('opener.document.<%=sForm%>.e_comp_nm');
		var permit_no=eval('opener.document.<%=sForm%>.permit_no');
		var product_no=eval('opener.document.<%=sForm%>.productno');
		
		//영업진행현황 코드 2013_04_29(월) shbyeon. 추가 
		//모발행번호 조회시 기존에는 발행번호==모발행번호 로 만 조회해 가지고왔지만.
		//영업진행현황 추가및 상품코드 매핑 테이블 및 ProjectPk(CODE) 사용으로 넘겨줘야한다.
		var pj_pk=eval('opener.document.<%=sForm%>.PROJECT_PK_CODE');

		//경유매출,매출구분,수주가능성 추가.
		var indirectsales_yn = eval('opener.document.<%=sForm%>.IndirectSalesYN');
		var Purchase_view = eval('opener.document.<%=sForm%>.purchase_view');
		var Sales_Profit_view = eval('opener.document.<%=sForm%>.sales_profit_view');
		var Profit_Percent_view = eval('opener.document.<%=sForm%>.profit_percent_view');
		var Purchase = eval('opener.document.<%=sForm%>.Purchase');
		var Sales_Profit = eval('opener.document.<%=sForm%>.Sales_profit');
		var Profit_Percent = eval('opener.document.<%=sForm%>.Profit_percent');
		var orderble_sel = eval('opener.document.<%=sForm%>.orderble');
		
		//매출구분 Loop 시작.
		var sales_sort = eval('opener.document.<%=sForm%>.SalesSort');
		var sp = salessort.split("|"); //매출구분 (Ex:S00|S01 DB데이터 어레이형태로 나누기)
		
		//매출구분(체크박스)
		var sales_sort1 = eval('opener.document.<%=sForm%>.sa1');	
		var sales_sort2 = eval('opener.document.<%=sForm%>.sa2');
		var sales_sort3 = eval('opener.document.<%=sForm%>.sa3');
		
		sales_sort1.checked=false; //매출구분 체크박스 초기화
		sales_sort2.checked=false; //매출구분 체크박스 초기화
		sales_sort3.checked=false; //매출구분 체크박스 초기화
		
		//어레이 형태 매출구분 체크박스 값 넘겨주기.
		for(var i=0; i<sp.length; i++){

			if(sp[i] == "S00"){
				sales_sort1.checked=true;
			}
			if(sp[i] == "S01"){
				sales_sort2.checked=true;
			}
			if(sp[i] == "S02"){
				sales_sort3.checked=true;
			}
		}
		//loop 끝.
		
		p_public_no.value=no;
		receiver.value=recv;
		title.value=titl;
		comp_code.value=compcode;
		comp_nm.value=compnm;
		owner_nm.value=ownernm;
		business.value=buse;
		b_item.value=bitem;
		post.value=pos;
		address.value=addr;
		address_detail.value=addr_dtl;
		supply_price_view.value=addCommaStr(suamt);
		supply_price.value=suamt;
		vat_view.value=addCommaStr(vatamt);
		vat.value=vatamt;
		total_amt_view.value=addCommaStr(sumamt);
		user_nm.value=charnm;
		user_id.value=charid;
		sales_charge.value=charid;
		e_comp_nm.value=e_compnm;
		permit_no.value=permitno;
		//product_no.value=productno; //제품명 사용했을때. 현재 사용안함.2013_04_29(월)shbyeon.
		pj_pk.value=projectpk;		    					//프로젝트 코드 값 PK(영업진행현황 PK)
		indirectsales_yn.value=indirectsalesyn;				//경유매출 구분
		Purchase_view.value=addCommaStr(purchase);			//매입원가 View
		Purchase.value=purchase;							//매입원가 hidden Param
		Sales_Profit_view.value=addCommaStr(sales_profit); 	//매출이익 View
		Sales_Profit.value=sales_profit; 					//매출이익 hidden Param
		Profit_Percent_view.value=profit_percent; 			//이익율 View
		Profit_Percent.value=profit_percent; 				//이익율 hidden Param
		orderble_sel.value=orderble;						//수주가능성
		sales_sort.value=salessort;							//매출구분(시스템 매출|상품매출|용역매출)
		
	
		//넘겨주는 부분.
		var obj=eval('opener.document.<%=sForm%>.checkyn');
		var obj2=eval('opener.document.<%=sForm%>.dpublicyn');
		//수동입력 초기 값.
		var obj3=eval('opener.document.<%=sForm%>.e_comp_nm_ori');
		var obj4=eval('opener.document.<%=sForm%>.comp_code_ori');
		//경유매출 구분 값.
		var obj5=eval('opener.document.<%=sForm%>.IndirectSaleschk');
		
		if(obj!=undefined){

			if(permitno==''){
				obj.checked=true; //체크박스 넘겨주기
				obj3.value=e_comp_nm.value; //초기업체명
				obj4.value=comp_code.value; //초기업체코드
				e_comp_nm.style.display='inline';
				comp_nm.style.display="none";
				
			}else{
				obj.checked=false; //체크박스넘겨주기
				e_comp_nm.style.display='none';
				comp_nm.style.display="inline";
			}
		}

		if(obj2!=undefined){

			if(dpublicyn=='Y'){
				obj2.checked=true;
			}else{
				obj2.checked=false;
			}
		}
		
		if(obj5!=undefined){
			if(indirectsalesyn=='Y'){
				obj5.checked=true;
				window.opener.indirectSalesChk(); //타 jsp function 호출.
			}else{
				obj5.checked=false;
				window.opener.indirectSalesChk(); //타 jsp function 호출.
			}
		}
		
		$.ajax({
			   url : "<%= request.getContextPath()%>/B_Estimate.do?cmd=currentProductSelect2",
			   type : "post",
			   dataType : "text",
			   async : false,
			   data : {
			    "public_no" : p_public_no.value
			    
			    //"StartPosition" : startPosition,
			    //"EndPosition" : endPosition,
			    //"Memo" : Memo
			   },
			   success : function(data, textStatus, XMLHttpRequest){
				   
				   
				   //var arrayCode = data.split("|");
				   
				   /* if(arrayCode.length > 0){
					   for(var x=0; x < arrayCode.length; x++){ */
					window.opener.settingCode(data);
						   //alert(arrayCode[x]);
					   /*    }
				   }else{
					   alert("코드값이 없습니다.");
				   } */
				  /*  var selected = $('#hiddenField').val().split(",");
				   ...
				   if (selected.indexOf(id) > 0) {
				      ... set value ...
				   } */
			   },
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
<%= ld.getPageScript("searchform", "curPage", "goPage") %>
<body onLoad = "init()">
<div id="wrapWp">
<!-- header -->
  <div id="headerWp">
   <h1>발행번호 리스트</h1>
 </div>
 <!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<!-- 조회 -->
<form  method="post" name="searchform" action = "<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNo"  class="search">
  <input type = "hidden" name="curPage"  value="<%=curPage%>">
  <input type = "hidden" name="sForm"  value="<%=sForm%>">
  <input type = "hidden" name="type"  value="<%=type%>">
      <fieldset>
        <legend>검색</legend>
 		<ul>
        <li><select name="contractGb">
          <option checked value="ALL" >전체</option>
          <option value="Y"  >계약</option>
          <option value="N"  >미계약</option>
        </select></li>

       <li> <select name="searchGb" class=""  onChange="searchChk()">
          <option checked value="">전체</option>
          <option value="D" >발행번호</option>
          <option value="B" >제목</option>
          <option value="A" >수신자</option>
        </select></li>
        <li><input type="text" name="searchtxt" title="검색어" value="<%=searchtxt%>"  class="text" maxlength="100" /></li>
        <li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
      </ul>
      </fieldset>
      </form>
    </div>
	<!-- //컨텐츠 상단 영역 -->
	<!-- 리스트 -->
    <table class="tbl_type tbl_type_list" summary="모 발행번호 리스트(발행번호, 제목, 고객정보(수신자, 업체명), 견적금액(공급가, 부가세, 합계))">
          <caption>발행번호 리스트</caption>
         <colgroup>
			<col width="11%" />
			<col width="*" />
			<col width="10%" />
			<col width="15%" />
			<col width="12%" />
			<col width="12%" />
			<col width="12%" />
		</colgroup>
		<thead>
		<tr>
			<th rowspan="2">발행번호</th>
			<th rowspan="2">제목</th>
			<th colspan="2">고객정보</th>
			<th colspan="3">견적금액</th>
		</tr>
		<tr>
			<th>수신자</th>
			<th>업체명</th>
			<th>공급가</th>
			<th>부가세</th>
			<th>합계</th>
		</tr>
		</thead>
		<tbody>
          <!-- :: loop :: -->
          <!--리스트---------------->
          <%			
if(ld.getItemCount() > 0){	
    int i = 0;
	long sprice=0;
	long vat=0;
	long total=0;

	while(ds.next()){
			sprice=ds.getLong("SUPPLY_PRICE");
			vat=ds.getLong("VAT");
			total=sprice+vat;
%>
            <tr>
              <td><a href="javascript:goSelect('<%=ds.getString("PUBLIC_NO")%>','<%=ds.getString("RECEIVER")%>','<%=ds.getString("TITLE")%>','<%=ds.getString("COMP_CODE")%>','<%=ds.getString("COMP_NM")%>','<%=ds.getString("OWNER_NM")%>','<%=ds.getString("BUSINESS")%>','<%=ds.getString("B_ITEM")%>','<%=ds.getString("POST")%>','<%=ds.getString("ADDRESS")%>','<%=ds.getString("ADDR_DETAIL")%>','<%=sprice%>','<%=vat%>','<%=total%>','<%=ds.getString("SALES_CHARGE")%>','<%=comDao.getUserNm(ds.getString("SALES_CHARGE"))%>','<%=ds.getString("E_COMP_NM")%>','<%=ds.getString("PERMIT_NO")%>','<%=ds.getString("PRODUCTNO")%>','<%=ds.getString("D_PUBLIC_YN")%>','<%=ds.getString("PROJECT_PK_CODE")%>','<%=ds.getString("IndirectSalesYN")%>','<%=ds.getString("Purchase")%>','<%=ds.getString("Sales_profit")%>','<%=ds.getString("Profit_percent")%>','<%=ds.getString("SalesSort")%>','<%=ds.getString("Orderble")%>')"><%=ds.getString("PUBLIC_NO")%></a></td>
              <td class="text_l" title="<%=ds.getString("TITLE")%>"><span class="ellipsis"><%=ds.getString("TITLE")%></span></td>
              <td title="<%=ds.getString("RECEIVER")%>"><span class="ellipsis"><%=ds.getString("RECEIVER")%></span></td>
              <td title="<%=ds.getString("E_COMP_NM")%>"><span class="ellipsis"><%=ds.getString("E_COMP_NM")%></span></td>
              <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("SUPPLY_PRICE"))%></td>
              <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("VAT"))%></td>
              <td class="text_r"><%=NumberUtil.getPriceFormat(total)%></td>
            </tr>
            <!-- :: loop :: -->
            <%		
    i++;
    }
}else{
%>
            <tr>
              <td colspan="7">조회된 내역이 없습니다. </td>
            </tr>
            <% 
}
%>
          </tbody>
        </table>
        
    <!-- 
  <p class="noti2" align="left">계약된 견적서만 선택하실 수 있으며, 목록에 없는 경우 견적서발행 화면에서 해당 견적서의 계약 상태를 '계약'으로 수정하십시오.</p>
     -->
      
      <!-- paginate -->
    <div class="paging">
      <%=ld.getPagging("goPage")%>
    </div>
    <!-- //paginate -->
    
    <!-- button -->
    
    <div class="Bbtn_areaC"><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
    <!-- //button -->
    </div>
	<!-- //content -->
  </div>
</form>
</body>
</html>

