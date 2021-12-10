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
	String searchGb =(String)model.get("searchGb"); //계약여부  contractGb == searchGb
	String searchGb2 = (String)model.get("searchGb2");
	String searchGbYear = (String)model.get("searchGbYear");
	String searchtxt=(String)model.get("searchtxt");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>영업진행현황 리스트</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/hueware.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/jquery-1.9.1.js"></script>
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
	
		 formObj.searchGbYear.value='<%=searchGbYear%>';
		 formObj.searchGb.value='<%=searchGb%>';
		 formObj.searchGb2.value='<%=searchGb2%>';
		 formObj.searchtxt.value='<%=searchtxt%>';
		
		 searchChk();
		
	}
	//조회옵션 체크	
	function searchChk(){
	
		if( formObj.searchGb2[0].selected==true){
			 formObj.searchtxt.disabled=true;
			 formObj.searchtxt.value='';	
		}else {
			 formObj.searchtxt.disabled=false;
		}
		
	}

	//검색
	function goSearch() {
		
		var gubun= formObj.searchGb2.value;
		
		if(gubun=='1'){
			if(formObj.searchtxt.value==''){
				alert('영업주관사 명을 입력해주세요.');
				return;
			}
		}else if(gubun=='2'){
			if(formObj.searchtxt.value==''){
				alert('예상프로젝트 명을 입력해주세요.');
				return;
			}
		}
		openWaiting();
		formObj.submit();
	}

	function goSelect(presalescode,projectname,enterprisecode,enterprisenm,chargeid,chargenm,orderble_Sales,sprice,permitno,publicno){
		
		//유의사항 자식 팝업창에서 부모창으로 값을 넘겨줄때. 받아오는 파라미터값과 
		//var 선언한 변수 이름과 동일시에 값을 제대로 셋팅 및 찾지 못함.
		
		//영업진행현황 코드
		var pre_sc=eval('opener.document.<%=sForm%>.PROJECT_PK_CODE');
		//프로젝트명 == 제목
		var pj_nm=eval('opener.document.<%=sForm%>.title'); 
		//원청사코드 == 업체코드
		var comp_code=eval('opener.document.<%=sForm%>.comp_code');
		//원청사명 == 업체명(수동입력 input text)
		var e_comp_nm=eval('opener.document.<%=sForm%>.e_comp_nm');
		//원청사명 == 업체명(수동입력X input text)
		var comp_nm=eval('opener.document.<%=sForm%>.comp_nm');
		//담당영업ID == 담당영업ID
		var user_id=eval('opener.document.<%=sForm%>.user_id');
		//수주가능성 == 수주가능성
		var orderble=eval('opener.document.<%=sForm%>.orderble');
		//예상매출액(VAT별도) == 공급가 View값 보여질값.
		var supply_price_view=eval('opener.document.<%=sForm%>.supply_price_view');
		//예상매출액(VAT별도) == 공급가 Hidden값
		var supply_price=eval('opener.document.<%=sForm%>.supply_price');
		//원청사(사업자등록번호) == 업체사업자등록번호 수동입력 체크박스 구분을 위해 넘겨준다.
		var permit_no=eval('opener.document.<%=sForm%>.permit_no');
		//영업진행현황 매핑견적번호(사업자등록번호) == 견적서발행 등록폼에 값을 넘겨줘서 영업진행현황 초기발행인지 재발행인지 체크하기위함.
		var public_no_retry=eval('opener.document.<%=sForm%>.public_no_retry');
		
		//넘겨줄 ID, NAME ChargeID ChargeName 으로 넘겨서 담아줄 input text
		var user_nm=eval('opener.document.<%=sForm%>.user_nm');
		var user_id=eval('opener.document.<%=sForm%>.user_id');
		//담당영업
		var sales_charge=eval('opener.document.<%=sForm%>.sales_charge');

		pre_sc.value=presalescode;		//영업진행현황 코드 값 PK(영업진행현황 PK)
		pj_nm.value=projectname;	    //프로젝트 명
		comp_code.value=enterprisecode; //업체코드 PK값 == 원청사 코드값
		comp_nm.value=enterprisenm;	    //업체조회 셋팅 input text 값
		e_comp_nm.value=enterprisenm;   //수동입력 셋팅 input text 값
		user_nm.value=chargenm;		    //사원조회에 셋팅 해줄 ChargeName	 
		user_id.value=chargeid;		    //사원조회에 셋팅해줄 ChargeID
		sales_charge.value=chargeid;    //최종적으로 DB넣을 담당영업 ChargeID 셋팅값. UserID에 셋팅되있는 값을 Submit시 sales_charge에 담아서 넘겨준다.
		supply_price_view.value=addCommaStr(sprice);
		supply_price.value=sprice;		//예상매출액 ==공급가
		orderble.value=orderble_Sales;		//수주가능성 orderble		
		permit_no.value=permitno;		//업체==원청사(사업자등록번호) 수동입력 업체시 Null 등록된 업체일시 사업자등록번호 DB 저장.
										//permit_no 수동입력 체크 여부 판단용도 및 해당업체가 미등록업체인지(수동입력업체) 등록업체(수동입력X업체)인지 판단가능.
		 
		public_no_retry.value=publicno; //영업진행현황 조회 최초 견적발행인지 재발행인지 체크하기 위해 넘겨준다.

		 
		//공급가를 계산하여 부가세 및 합계 금액 부모 창으로 넘겨준다. 2013_04_23(화)shbyeon.
		var priceVat = parseInt(onlyNum(supply_price.value) * 0.1,10); //부가세 히든값. 실제 Insert될 DB데이터값
		//부가세 View 값 javascript로 넘기기
		//hidden 실제 DB 값
		var priceVat_hidden = eval('opener.document.<%=sForm%>.vat'); 
		//View 계산된 금액 text 박스에 보여질 값.
		var priceVat_View = eval('opener.document.<%=sForm%>.vat_view'); 
		/*2013_04_23(화) shbyeon.
		부가세 Hidden 값 jQuery로 넘기기.
		아래 제이쿼리로 간단하게 팝업창에서 부모창으로 넘겨주는 방법도있다.
		opener.$('[name=vat]').val(priceVat);
		*/
		
		//input text view 에 보여질 데이터값 금액 계산해서 콤마. addCommaStr js사용.
		priceVat_hidden.value=priceVat; //hidden DB값 셋팅
		priceVat_View.value=addCommaStr(''+priceVat);
		
		//(현재 공급가(예상매출액)은 String 객체로 받고있기 때문에 Int형변환을 해준다.)
		var sup_priceInt = parseInt(onlyNum(supply_price.value),10); 
		//공급가(예상매출액)+부가세 = 합계액
		var priceTotal = sup_priceInt + priceVat;
		//합계액 hidden 실제 DB값
		var priceTotal_hidden = eval('opener.document.<%=sForm%>.total_amt');
		//합계액 View	 text 박스 보여질 값.
		var priceTotal_View = eval('opener.document.<%=sForm%>.total_amt_view');
		//input text view 에 보여질 데이터값 금액 계산해서 콤마. addCommaStr js사용.
		priceTotal_hidden.value=priceTotal; //hidden DB값 셋팅
		priceTotal_View.value=addCommaStr(''+priceTotal);
		
		//넘겨주는 부분.
		var obj=eval('opener.document.<%=sForm%>.checkyn');

		if(obj!=undefined){

			if(permitno==''){
				obj.checked=true; //체크박스 넘겨주기
				e_comp_nm.style.display='inline';  //style조건을 자바스크립트로 넘겨줄때. 선언 및 style 지정한 input name 동일하게 지정 해줘야한다.
				comp_nm.style.display="none";
				
			}else{
				obj.checked=false; //체크박스넘겨주기
				e_comp_nm.style.display='none';
				comp_nm.style.display="inline";
			}
		}
		$.ajax({
			   url : "<%= request.getContextPath()%>/B_Estimate.do?cmd=currentProductSelect",
			   type : "post",
			   dataType : "text",
			   async : false,
			   data : {
			    "PROJECT_PK_CODE" : pre_sc.value,  //영업진행현황 코드
			    "Public_No" : publicno	   //견적서 발행번호
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
		<h1>영업진행현황 리스트</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp" class="projectCodeList">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<!-- 조회 -->
<form  method="post" name=searchform action = "<%= request.getContextPath()%>/B_Common.do?cmd=searchPreSalesCode" class="search">
  <input type = "hidden" name="curPage"  value="<%=curPage%>">
  <input type = "hidden" name="sForm"  value="<%=sForm%>">
	<fieldset>
        <legend>검색</legend>
        <ul>
        <li>
 		<script>
         document.write("<select name='searchGbYear' id='' title='년도 선택'>");
         document.write("<option checked value=''>전체</option>");
         var now = new Date();  
          var now_year = now.getFullYear() +5; //+1은 올해년도에서 +1년 한것. 
          for (var i=now_year;i>=2010;i--) 
          {     
         document.write("<option value='"+i+"'>"+i+"</option>"); 
         }  
          document.write(" </select>"); 
         </script></li>
          
          <!-- 
          <input type="hidden" name="DateProjections" value="2013"></input>
           -->
         <li> 
        <select name="searchGb">
          <option checked value="" >전체</option>
          <option value="Y"  >계약</option>
          <option value="N"  >미계약</option>
        </select></li>

		<li>
        <select name="searchGb2" onchange="searchChk()" id="" class="">
          <option checked value="">전체</option>
          <option value="1">영업주관사 명</option>
          <option value="2">예상 프로젝트명</option>
        </select></li>
        <li><input type="text" name="searchtxt" title="검색어" class="text" maxlength="100" id="textfield_search2" value="<%=searchtxt %>" /></li>
        <li><a href="javascript:goSearch();" class="btn_type01"><span>검색</span></a></li>
        </ul>
      </fieldset>
      </form>
	  <!-- //조회 -->
    </div>
    <!--//search -->
    <!-- //컨텐츠 상단 영역 -->
	<!-- 리스트 -->
	 <table class="tbl_type tbl_type_list" summary="영업진행현황리스트(영업현황코드, 예상프로젝트명(제목), 영업주관사(업체명), 영업주관사담당자, 예상수주액(공급가), 담당영업(정), 예상시기, 기술분야배정인력)">
          <caption>영업진행현황 리스트</caption>
          <colgroup>
				<col width="90px" />
				<col width="280px" />
				<col width="120px" />
				<col width="110px" />
				<col width="120px" />
				<col width="85px" />
				<col width="65px" />
				<col width="*" />
			</colgroup>
			<thead>
			<tr>
				<th>영업현황코드</th>
				<th>예상프로젝트명(제목)</th>
				<th>영업주관사(업체명)</th>
				<th>영업주관사담당자</th>
				<th>예상수주액(공급가)</th>
				<th>담당영업(정)</th>
				<th>예상시기</th>
				<th>기술분야배정인력</th>
			</tr>
			</thead>
			<tbody>
			<tr>
			<td colspan="8" class="tbl_type_scrollY">
				<div class="scrollY">
					<table class="tbl_type tbl_type_list">
					<colgroup>
						<col width="89px" class="scrollY_FF" /><!-- tbody에 추가되는 테이블의 왼쪽 라인 삭제로 인해 width사이즈를 -1px함. -->
						<col width="280px" />
						<col width="120px" />
						<col width="110px" />
						<col width="120px" />
						<col width="85px" />
						<col width="65px" />
						<col width="*" />
					</colgroup>
					<tbody>
          <!-- :: loop :: -->
          <!--리스트---------------->
          <%			
if(ld.getItemCount() > 0){	
    int i = 0;
	String sprice="";
	//long vat=0;
	//long total=0;

	while(ds.next()){
			sprice=ds.getString("SalesProjections");
			
			//vat=ds.getLong("VAT");
			//total=sprice+vat;
%>
            <tr>
              <td><a href="javascript:goSelect('<%=ds.getString("PreSalesCode")%>','<%=ds.getString("ProjectName")%>','<%=ds.getString("EnterpriseCode")%>','<%=ds.getString("EnterpriseNm") %>','<%=ds.getString("ChargeID")%>','<%=ds.getString("ChargeNm")%>','<%=ds.getString("Orderble") %>','<%=sprice %>','<%=ds.getString("PermitNo")%>','<%=ds.getString("PublicNo")%>')"><%=ds.getString("PreSalesCode")%></a></td>
              <td class="text_l"><%=ds.getString("ProjectName")%></td>
              <td><%=ds.getString("EnterpriseNm")%></td>
              <td><%=ds.getString("SalesMan")%></td>
              <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getLong("SalesProjections"))%>원</td>
              <td><%=ds.getString("ChargeNm")%></td>
              <td><%=ds.getString("DateProjections")%></td>
              <td><%=ds.getString("AssignPerson")%></td>
            </tr>
            <!-- :: loop :: -->
            <%		
    i++;
    }
}else{
%>
            <tr>
              <td colspan="8">조회된 내역이 없습니다. </td>
            </tr>
            <% 
}
%>
</tbody>
</table>
</div>
	</td>
		</tr>
          </tbody>
        </table>
    <!-- 
  <p class="noti2" align="left">계약된 견적서만 선택하실 수 있으며, 목록에 없는 경우 견적서발행 화면에서 해당 견적서의 계약 상태를 '계약'으로 수정하십시오.</p>
     -->
     
    <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
    <!-- //button -->
    </div>
	<!-- //content -->
  </div>
</body>
</html>

