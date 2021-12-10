<%@page import="com.huation.framework.util.StringUtil"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.ComCodeDTO"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.estimate.EstimateDTO"%>
<%@ page import="com.huation.common.currentstatus.CurrentStatusDTO" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%


	Map model = (Map)request.getAttribute("MODEL");

	EstimateDTO estimateDto = (EstimateDTO)model.get("estimateDto");
	
	//2013_04_29(월) shbyeon.
	//htSalesProductCode Table에 있는 상품코드 즉 영업진행현황에 등록된 해당pk의 ProjectPk(code)
	//상품코드와 견적서발행에 매핑ProjectPk(code) 상품코드는 같이 사용하며, 영업진행현황 혹은 견적서발행 같이 Update 되는 매핑 데이터.
	CurrentStatusDTO csDtoPro = (CurrentStatusDTO)model.get("csDtoPro");	//영업진행현황 상품코드ArrDTO
	//별도의 객체 셋팅 및 생성을 해줘야 값 제대로 가져옴.
	
	String curPage = (String)model.get("curPage");
	String public_no = (String)model.get("public_no");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String type = (String)model.get("type");
	String title = "";
	if(type.equals("reg")){
		title = "발행";
	}else{
		title = "발행(전체)";
	}
	
	//상품코드 Arr 모델로 객체로 꺼낸다 codeList로. 2013_04_29(월) shbyeon.
	ArrayList codeList = (ArrayList)model.get("codeList"); //자사 상품코드
	ArrayList codeList2 = (ArrayList)model.get("codeList2"); //비자사(내수)상품코드
	ArrayList codeList3 = (ArrayList)model.get("codeList3"); //비자사(외수)상품코드
	ArrayList productList = (ArrayList)model.get("productList"); //상품코드 Array List 가지고 있는 데이터
	
	//매출구분 |단위 token객체로 잘라서 Arr 형태로 가져오기.(체크박스 체크확인을 위함.)2013-11-20 shbyeon.
	String[] SalesSortList = StringUtil.getTokens(estimateDto.getSalesSort(), "|");

	String acheckd=""; //시스템 매출
	String bcheckd=""; //상품 매출
	String ccheckd=""; //용역 매출

	for(int i=0;i<SalesSortList.length; i++){

		if(SalesSortList[i].equals("S00")){
			acheckd="checked";
		}else if(SalesSortList[i].equals("S01")){
			bcheckd="checked";
		}else if(SalesSortList[i].equals("S02")){
			ccheckd="checked";
		}
	}
	
	
	//견적일 초기 셋팅 값.
		String estimate_dt = "";

		
		if(estimateDto.getEstimate_dt().equals("")){
			estimate_dt = estimateDto.getEstimate_dt();
			estimate_dt = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		}else{
			estimate_dt = estimateDto.getEstimate_dt();
			String strY_Val1;										//년도 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
			String strM_Val1;										//월자 값 자르면서 arr형태로 변환되어 String으로 형변환하여 담기.(벨류데이션체크를 위해)
			String strD_Val1;
			
		    strY_Val1 = estimate_dt.substring(0,4);
		    strM_Val1 = estimate_dt.substring(4,6);
		    strD_Val1 = estimate_dt.substring(6,8);
			
		    estimate_dt = strY_Val1 + '-' + strM_Val1  + '-' + strD_Val1;
		}
	
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>견적서(매출) 상세정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<link href="<%= request.getContextPath()%>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
<script type="text/javascript">

	<!--
	function goSave(){

	var frm = document.estimateVeiw; 
	var dates = frm.estimate_dt.value;
	var estimate_dts = dates.replace(/-/g,'');

	frm.pYear1.value = estimate_dts.substr(0,4);
	frm.pMonth1.value = estimate_dts.substr(4,2);
	frm.pDay1.value = estimate_dts.substr(6,2);
	frm.estimate_dt.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;


	
	//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
	var strFile = frm.estimate_e_file.value;
	var strFile2 = frm.estimate_p_file.value;
	
	var lastIndex = strFile.lastIndexOf('\\');
	var strFileName= strFile.substring(lastIndex+1);

	var lastIndex2 = strFile2.lastIndexOf('\\');
	var strFileName2 = strFile2.substring(lastIndex2+1);
	
	if(fileCheckNm(strFileName)> 200){
		alert('[견적서 파일]의 (Excel파일명)은/는 200자(byte)이상의 글자를 등록 할 수 없습니다.');
		return;
	}
	if(fileCheckNm(strFileName2)> 200){
		alert('[견적서 파일]의 (PDF파일명)은/는 200자(byte)이상의 글자를 등록 할 수 없습니다.');
		return;
	}
		
	
	//파일명 글자수(byte) 체크		
	function fileCheckNm(szValue){
			var tcount=0;
			var tmpStr = new String(szValue);
			var temp = tmpStr.length;
			var onechar;
			for(k=0; k<temp; k++){
				onechar = tmpStr.charAt(k);
				if(escape(onechar).length>4){
					tcount +=2;
					
				}else{
					tcount +=1;
				}
			}
			return tcount;
	}	
	
	if(frm.SalesSort.value == ""){
		alert('매출구분은 최소한 하나이상 선택 하셔야합니다.');
		return;
	}
	
	//상품코드 유무체크를 위해 length 불러오기.
	var ProductCode = $('#ProductCode').length;
	
	if(ProductCode == 0){
		alert("상품코드를 선택해 주세요");
		return;
	}
	
	if(frm.estimate_dt.value.length == 0){
		alert("견적일자를 선택해 주세요");
		return;
	}
	
	//달력input(텍스트창입력시) 벨류데이션체크 2012.12.03(월) bsh.
	var Y = frm.pYear1.value;
	var M = frm.pMonth1.value;
	var D = frm.pDay1.value;
	
	if(Y.length>0){
		if (!isNumber(trim(Y))) {
			alert("년도는 숫자만 입력이 가능합니다.");
				Y=onlyNum(Y);
			frm.pYear1.value ="";
			return;
			
		}else{
				Y=onlyNum(Y)
			} 
		}
	if(Y.length<4){
		alert('년도는 4자리수 미만사용불가능합니다.');
		Y=onlyNum(Y);
		frm.pYear1.value ="";
		return;
	}else{
		Y=onlyNum(Y)
	}
	
	
	if(M.length>0){
		if (!isNumber(trim(M))) {
			alert("월자는 숫자만 입력이 가능합니다.");
				Y=onlyNum(M);
			frm.pMonth1.value ="";
			return;
			
		}else{
				Y=onlyNum(M);
				
			} 
		}
	if(M.length<2){
		alert('월자는 2자리수 미만사용불가능합니다(ex:1월 일시=>01 입력).');
		M=onlyNum(M);
		frm.pMonth1.value ="";
		return;
	}else{
		M=onlyNum(M)
	}
	if(D.length>0){
		if (!isNumber(trim(D))) {
			alert("일자는 숫자만 입력이 가능합니다.");
				Y=onlyNum(D);
			frm.pDay1.value ="";
			return;
		
		}else{
			Y=onlyNum(D);	
			}
		}
	if(D.length<2){
		alert('일자는 2자리수 미만사용불가능합니다(ex:1일 =>01 입력).');
		D=onlyNum(D);
		frm.pDay1.value ="";
		return;
	}else{
		D=onlyNum(D)
	}
	if(Y.length==0){
		alert('년도 입력하세요.');
		return;
	}
	if(M.length==0){
		alert('월자를 입력하세요.');
		return;
	}
	if(M > 12){
		alert('한 해에 12월 이상은 존재하지않습니다. 다시입력하세요!!');

		frm.pMonth1.value ="";
		return;
	}else{
		Y=onlyNum(M);
	}
		
	if(D.length==0){
		alert('일자를 입력하세요.');
		return;
	}
	if(D > 31){
		alert('한달에 31일 이상은 존재하지않습니다. 다시입력하세요!!');
		frm.pDay1.value ="";
		return;
	}else{
		Y=onlyNum(D);
	}

	if(frm.receiver.value.length == 0 ){
		alert("수신인을 입력하세요!");
		return;
	}
		if(frm.title.value.length == 0 ){
		alert("제목을 입력하세요!");
		return;
	}

	if(frm.e_comp_nm.value.length == 0 && frm.comp_code.value.length == 0 && frm.comp_code.value.length == 0){
		alert("업체명을 수동입력 또는 조회 후 선택하세요.");
		return;
	}

	//수동입력이 아닌 업체조회 입력일때. 업체조회 업체명 comp_nm -> e_comp_nm에 넘겨준다.(실 데이터는 e_comp_nm 에 들어가기때문.)
	if(frm.checkyn.checked!=true){	
		if(frm.comp_code.value.length != 0){
			frm.e_comp_nm.value=frm.comp_nm.value
		}
	}	
		

	/*2013_04_01(월) shbyeon. -> 2013_05_07(화)shbyeon. 현재 사용안함.
	    모발행번호 조회 시 초기 값 수동입력  플래그 체크안하고 (업체명)변경없이 바로 사용.
	  Note:모발행번호 조회 후 업체 수동입력 할 시에 중복체크 함.
	    중복확인버튼 display 유무로 체크함.
	if(frm.e_comp_nm_se.style.display == "none"){
		//중복 체크 안하고 넘어감
		
	}else{
		if(frm.checkyn.checked==true){
			if(frm.e_comp_nm.value!=frm.trueflag.value){
				alert("업체명이 중복되는지 확인하세요.");
				return;
			}
		}
	}
	 */
	
	 if(frm.supply_price.value.length == 0 || trim(frm.supply_price.value) == "" || frm.supply_price.value == "0"||frm.vat.value.length == 0 || trim(frm.vat.value) == "" ||frm.vat.value == "0"
		 || frm.supply_price_view.value.length == 0 || trim(frm.supply_price_view.value) == "" || frm.supply_price_view.value == "0"||frm.vat_view.value.length == 0 || trim(frm.vat_view.value) == "" ||frm.vat_view.value == "0" ){
		alert("견적금액을 입력하세요!");
		return;
	}
	
	//초기 등록시에는 DB데이터가 없어 Null체크가 가능하지만 수정 시에는 경유매출 등록으로 인해 0이란 디폴트 숫자값이 들어가므로 숫자로 체크해줘야한다.
	if(frm.IndirectSaleschk.checked == true){
		if(frm.Purchase.value == "" || frm.Sales_profit.value == "" || frm.Profit_percent.value == ""){
			alert("경유매출 체크 시 경유매출금액란 은 필수입력 항목입니다.");
			return;
		}
		if(frm.Purchase.value == 0){
			alert("경유매출 체크 시 경유매출금액란 은 필수입력 항목입니다.");
			return;
		}
	}
	 
	frm.sales_charge.value=frm.user_id.value;

	if(frm.sales_charge.value.length == 0){
		alert("담당 영업사원을 지정해 주세요");
		return;
	}

	if(frm.estimate_e_file.value != "" && !isExcelImageFile(frm.estimate_e_file.value)){
			alert("견적서파일(EXCEL)의  첨부 가능한 파일 유형은 \n xls,xlsx 입니다.");
			return; 				
	}

	if(frm.estimate_p_file.value != "" && !isPDFImageFile(frm.estimate_p_file.value)){
			alert("견적서파일(PDF)의  첨부 가능한 파일 유형은 \n pdf 입니다.");
			return; 				
	}
	//직접발행
	if(frm.dpublicyn.checked==true){
		frm.d_public_yn.value='Y';
	}else{
		frm.d_public_yn.value='N';
	}
	//경유발행
	if(frm.IndirectSaleschk.checked==true){
		frm.IndirectSalesYN.value='Y';
	}else{
		frm.IndirectSalesYN.value='N';
	}
	frm.sales_charge.value=frm.user_id.value;
	frm.estimate_dt.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value; //견적일자

	frm.curPage.value='1';
	frm.searchGb.value='';
	frm.searchtxt.value='';
	if(strFileName!=''){
		
		frm.ESTIMATE_E_FILENM.value = strFileName;
	}
	if(strFileName2!=''){
		
		frm.ESTIMATE_P_FILENM.value = strFileName2;
	}
		frm.submit();
}


	function cancle(){
	
	var frm = document.estimateVeiw;
	frm.action='<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList';
	frm.submit();

	}

	function popPublicNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNo&sForm=estimateVeiw&contractGb=N","","width=850,height=650,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
	}

	
	function popComp(){

		var obj=document.estimateVeiw;
		
		if(obj.checkyn.checked==true){
				alert('수동입력 선택을 해제후 업체조회 하시기 바랍니다.');
				return;
		}else{
			var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp&sForm=estimateVeiw","","width=850,height=652,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
		}
	}

	
	function popSales(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=estimateVeiw","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
	}

	
	function saleCntCal(form,gbun){

	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+"_view");
		var frm=eval("document."+form);
		var costobj=document.estimateVeiw;

		if(frm.length>1){
			v_obj=veiwfrm[index];
			obj=frm[index];
		}else{
			v_obj=veiwfrm;
			obj=frm;
		}

		if (!isNumber(trim(v_obj.value))) {
			if (trim(v_obj.value == "")) {
				v_obj.value = "";
				frm.value = "";
				return;
			}
			
			alert("숫자만 입력해 주세요.");
			v_obj.value = "";
			frm.value = "";
			v_obj.focus();
			return;
		} 

		var num=onlyNum(v_obj.value);
		v_obj.value = addCommaStr(num);
		obj.value = num;

		if(form=='estimateVeiw.supply_price'  && gbun!='1'){	
			var vat=parseInt(onlyNum(costobj.supply_price.value)*0.1,10);
			costobj.vat_view.value=addCommaStr(''+vat);
		    costobj.vat.value=vat;
		    
		    
		}

		var tcost=parseInt(onlyNum(costobj.supply_price.value),10)+parseInt(onlyNum(costobj.vat.value),10);

		costobj.total_amt_view.value=addCommaStr(''+tcost);
		costobj.total_amt.value=tcost;

		//v_obj.focus();

	}
	
	
	function saleCntCalInit(form,gbun){
	
	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+"_view");
		var frm=eval("document."+form);
		var costobj=document.estimateVeiw;
	
		if(frm.length>1){
			v_obj=veiwfrm[index];
			obj=frm[index];
		}else{
			v_obj=veiwfrm;
			obj=frm;
		}
	
		if (!isNumber(trim(v_obj.value))) {
			if (trim(v_obj.value == "")) {
				v_obj.value = "";
				frm.value = "";
				return;
			}
			
			alert("숫자만 입력해 주세요.");
			v_obj.value = "";
			frm.value = "";
			v_obj.focus();
			return;
		} 
	
		var num=onlyNum(v_obj.value);
		v_obj.value = addCommaStr(num);
		obj.value = num;
	
		var tcost=parseInt(onlyNum(costobj.supply_price.value),10)+parseInt(onlyNum(costobj.vat.value),10);
	
		costobj.total_amt_view.value=addCommaStr(''+tcost);
		costobj.total_amt.value=tcost;
	
		v_obj.focus();
	
	}
	
	
	//매입원가 계산 2013-11-19(화) shbyeon.
	function saleCntCal2(){
		
		var frm = document.estimateVeiw;
		var supply_price = frm.supply_price_view.value;		//공급가(견적금액 VAT별도)
		var purchase = frm.purchase_view.value; 				//매입원가
		if(frm.supply_price_view.value == '0' || frm.supply_price_view.value.length < 1){
			alert("견적금액을 바르게 입력하세요.");
			frm.Purchase.value="0";
			frm.purchase_view.value="0";
			frm.Sales_profit.value="0"
			frm.sales_profit_view.value="0"
			frm.supply_price_view.value="";
			frm.supply_price.value="";
			frm.supply_price_view.focus();
			return;
		}else{
			//1.(견적금액[공급가] - 매입원가) = sales_profit(매출이익)
			var sales_profit = parseInt(onlyNum(supply_price))-parseInt(onlyNum(purchase));
			//2. 매출이익 / 견적금액[공급가] * 100 = profit_percent(이익율)
			var profit_percent = sales_profit/parseInt(onlyNum(purchase)) * 100;	
			//3.견적금액[공급가] 변경 시에도 매출이익 계산처리를 위해 추가함.
			if(purchase == 0){
			//4.견적금액 입력 시 매출이익 계산은 하지만 실제로 넘겨줄 Name 값과 View 값에는 넣지않음.	

			}else{
			//5.견적금액[공급가] 변경 시에도 매출이익 계산됨.(toFixed(1) Ex:함수 소수점 이하 1자리로 표현함)
			frm.purchase_view.value=addCommaStr(''+onlyNum(purchase));	 			  //매입원가 뷰잉값.
			frm.Purchase.value=parseInt(onlyNum(purchase));		   		      //매입원가(VAT별도) 실제 DB로 넘겨줄값.(형변환하여 담은 변수가 없으므로 직접형변환해준다.)
			frm.sales_profit_view.value=addCommaStr(''+sales_profit);		  //매출이익 뷰잉값.
			frm.Sales_profit.value=sales_profit;					  	      //매출이익 실제 DB로 넘겨줄값.
			frm.profit_percent_view.value=profit_percent.toFixed(2);		   //이익율 뷰잉값
			frm.Profit_percent.value=profit_percent.toFixed(2);			   	   //이익율 실제 DB로 넘겨줄값.
			
				
			if(frm.Sales_profit.value == "NaN"){
					alert("올바른 값이 입력되지 않았습니다. 공급가 또는 매입원가를 다시한번 확인해주세요.");
					frm.Purchase.value="0";
					frm.purchase_view.value="0";
					frm.Sales_profit.value="0";
					frm.sales_profit_view.value="0";
					frm.supply_price_view.value="";
					frm.supply_price.value="";
					frm.supply_price_view.focus();
					return;
				}
			}
		}
	}

	
	
	/*수동입력체크(기존)
	function directInput(){

	    var obj=document.estimateView;
		if(obj.checkyn.checked==true){
			obj.e_comp_nm.style.display='inline'
			obj.comp_nm.style.display="none";
			obj.comp_nm.value='';
			obj.comp_code.value='';
		}else{
			obj.e_comp_nm.style.display='none'
			obj.comp_nm.style.display="inline";
		}

	}
	*/
	
	
	
	
	/*
	2013_05_07(화)shbyeon.
	수동입력일때 
	*/
	function directInput(){

	    var obj=document.estimateVeiw;
	    if(obj.checkyn.checked==true){
			
			if(confirm("수동입력으로 변경하시겠습니까?")){
				obj.e_comp_nm.style.display='inline'
				//obj.e_comp_nm_se.style.display='inline' //중복체크 사용할때 용도
				obj.comp_nm.style.display="none";
				obj.comp_nm.value='';
				obj.comp_code.value='';
			}else{
				obj.checkyn.checked=false;
			}
		}else{

			if(confirm("선택입력으로 변경하시겠습니까?")){
				obj.e_comp_nm.style.display='none'
				//obj.e_comp_nm_se.style.display='none' //중복체크 사용할때 용도
				obj.comp_nm.style.display="inline";
				obj.comp_code.value=''; //업체코드
				obj.comp_nm.value='';   //업체조회 선택시 업체명
				obj.e_comp_nm.value=''; //수동입력 선택시 업체명
			}else{
				obj.checkyn.checked=true;
			}


		}

	}
	
	<%-- 업체명 수동입력일때 중복체크 시작 하는 스크립트. 2013_05_07(화)shbyeon.(현재사용안함.)
	 /*
	  *	2013_05_07(화)shbyeon.
	  * 중복체크(공통) XML 방식 현재사용안함.
	  */
	 function doCheck(e_comp_nm){
	 	
	 	var requestUrl='<%= request.getContextPath() %>/B_Common.do?cmd=CompNameCheckEs&e_comp_nm='+e_comp_nm;
	 	var result=0;
	 	
	 	var xmlhttp = null;
	 	var xmlObject = null;
	 	var resultText = null;


	 	xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	 	xmlhttp.open("GET", requestUrl, false);
	 	xmlhttp.send(requestUrl);

	 	resultText = xmlhttp.responseText;

	 	xmlObject = new ActiveXObject("Microsoft.XMLDOM");
	 	xmlObject.loadXML(resultText);
	 	
	 	result=xmlObject.documentElement.childNodes.item(0).text;

	 	return result;
	 	
	 }
	
	//업체중복확인 check 2013_05_07(화)shbyeon. 현재사용안함.
	 function fnDuplicateCheck() {
		
	 	var frm = document.estimateVeiw; 
	 	
	 	
	 	if(frm.e_comp_nm.value.length == 0){
	 		alert("업체명을 입력하세요.");
	 		return;
	 	}
	 	
	 	var result= doCheck(frm.e_comp_nm.value);
	 	
	 	if(result==1){
	 		alert("이미 등록된 업체명입니다. 업체조회로 조회 후 해당 업체확인 후 다시 입력해주세요.");
	 		
	 		if(alert){
	 			
	 		frm.e_comp_nm.focus();
	 		}
	 		
	 		return;
	 	}else {
	 		if( confirm("사용 가능한 업체명 입니다. 사용하시겠습니까?") ) {
	 			frm.trueflag.value  =  frm.e_comp_nm.value;
	 			alert(frm.trueflag.value);
	 			frm.comp_code.value='';
	 		} else {
	 			frm.falseflag.value =  frm.e_comp_nm.value;	
	 		}
	 	}
	 }
	 
	 업체명 수동입력일때 중복체크 시작 하는 스크립트. 2013_05_07(화)shbyeon.
	--%>
	
	/**
	 * 엑셀 이미지  파일 확장자명 체크
	 *
	 **/
	function isExcelImageFile( obj ) {
		var strIdx = obj.lastIndexOf( '.' ) + 1;
		if ( strIdx == 0 ) {
			return false;
		} else {
			var ext = obj.substr( strIdx ).toLowerCase();
			if ( ext == "xls" || ext == "xlsx" ) {
				return true;
			} else {
				return false;
			}
		}
	}
	/**
	 * PDF 이미지  파일 확장자명 체크
	 *
	 **/
	function isPDFImageFile( obj ) {
		var strIdx = obj.lastIndexOf( '.' ) + 1;
		if ( strIdx == 0 ) {
			return false;
		} else {
			var ext = obj.substr( strIdx ).toLowerCase();
			if ( ext == "pdf" ) {
				return true;
			} else {
				return false;
			}
		}
	}
	
	/*초기수동입력 값 비교 후 중복확인 버튼 유무.2013_05_07(화)  현재사용안함. 필요없는걸로 판단되면 삭제시키기.
	function chkNmButton(){
		var frm = document.estimateVeiw; 
		if(frm.e_comp_nm.value == frm.e_comp_nm_ori.value){
			frm.e_comp_nm_se.style.display='none';
			//초기 수동입력으로 등록시  초기 업체코드값 셋팅 
			frm.comp_code.value=frm.comp_code_ori.value;
		}else{
			frm.e_comp_nm_se.style.display='inline';
		}
	}
	
	//초기수동입력 값 비교 후 입력 2013_05_07(화)
	function chkNm(){
		var frm = document.estimateVeiw; 
		if(frm.e_comp_nm.value == frm.e_comp_nm_ori.value){
			//초기 수동입력으로 등록시  초기 업체코드값 셋팅 
			frm.comp_code.value=frm.comp_code_ori.value;
		}
	}
	*/

	
	function goList(){
		
		var frm = document.estimateVeiw;
		frm.action='<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList2';
		frm.submit();

	}

	function goDelete(){
		
		var frm = document.estimateDeleteFrm;

		if(confirm("삭제 하시겠습니까?")){
			frm.action='<%= request.getContextPath()%>/B_Estimate.do?cmd=estimateDelete';
			frm.submit();
		}

	}
	
	//JQuery - 상품코드 마우스로 데이터 넘겨주기.
	$(function() {
		
		var cartLen = $('#cart ol li').length; //cart ol li 상품코드가 담겨진 length 변수선언
		/*
		cart ol li 의 map 객체에 상품코드 cart에 들어있는 해당 상품코드를  test변수에 map 형태로담는다.
		*/
		var test = $('#cart ol li').map(function(){ 
			return $(this).attr("id");
		});
		/*
		cartLen 상품코드가 담겨진 길이 데이터 수만큼 x를 증가시켜서 
		좌측 상품코드 목록(products) 해당 map(상품코드) 만큼가져와서 그 상품목록을 hide 숨겨준다.
		*/
		for(var x=0; x<cartLen; x++){
			$('#products #'+test.get(x)).hide();
			//alert(test.get(x));	
		}
		
		$( "#catalog" ).accordion();
		
		  $("#products li").dblclick(function(){
			  $('#NoCode').remove(); //상품코드 추가 시 Cart<li>에 있는  상품코드를 넣어주세요. text 지우기.
		      $(this).hide(); //상품코드 선택시 해당 상품코드 hide 숨기기.
		    $('#cart ol').append("<li id="+$(this).attr("id")+" ondblclick=\"delCode('"+$(this).attr("id")+"')\" style=\"cursor: pointer;\">"+$(this).html()+" <input type='hidden' name='ProductCode' id='ProductCode' value="+$(this).attr("id")+"></li>");
		  
		  
		  });
		  
		  /* $('#cart ol li').on("dblclick", , function() {
			  alert('Success'); 사용안함.
			});
			
		  $("#cart ol li").dblclick(function(){
			    //$(this).remove(); 사용안함.
			    $('#products ol li').append("<li>"+$(this).html()+"</li>");
		  });
		  */
	});	 
	function delCode(chk){
		if( $( "#cart ol li" ).length == 1){
			$("#cart ol").append("<li id='NoCode' class='placeholder' style='color: red;'>상품코드를 넣어주세요.</li>");
		}
		//alert($('#cart ol #'+chk).html()); hidden 데이터읽어 오는지 찍어본 alert
		$('#cart ol #'+chk).remove();
		$('#products #'+chk).show();
	}
	
	
	//발행 구분(경유매출 사용) 2013-11-19(화)shbyeon.
	function indirectSalesChk(){	
		var frm = document.estimateVeiw;
		var chk = frm.IndirectSaleschk.checked;
		
		if(chk == true){
			 $('#Indirect_info').show();
			 
		}else{
			 $('#Indirect_info').hide();
			 $('[name=Purchase]').val('');
			 $('[name=purchase_view]').val('0');
			 $('[name=Sales_profit]').val('');
			 $('[name=sales_profit_view]').val('0');
			 $('[name=Profit_percent]').val('');
			 $('[name=profit_percent_view]').val('0');
		}

	}
	 
	
	//발행구분 경유매출 발행이 아닌 경우  hide시킨다. 2013_11_19(화)shbyeon.
	$(function(){
		var frm = document.estimateVeiw;
		if(frm.IndirectSaleschk.checked == false){			
		$("#Indirect_info").hide(); //경유매출 선택 시 경유매출 입력값 정보.
		}else{
		$("#Indirect_info").show(); //경유매출 선택 시 경유매출 입력값 정보.	
		}
	})
	
	
	//매출구분 체크박스 체크(2013_11_20)shbyeon.
	function insert_SalesSortGb(){
		var frm = document.estimateVeiw;
		var chklen = frm.SalesSortChk.length;
		var sales_sort = '';

			for(i=0; i<chklen; i++){
				if(frm.SalesSortChk[i].checked == true){
					sales_sort+='S0'+i+'|';		//S0 시스템매출, S1 상품 매출, S2 용역 매출
				}
				frm.SalesSort.value = sales_sort;
			}
	}
	
	
	//달력 텍스트 입력창 첫번째.
	  function datepickerInputText1(){
		  var frm = document.estimateVeiw;	//폼생성
		  var inputDate1;									//프로젝트 시작 예정일 입력 값 가져오기
		  var strY1;										//프로젝트 시작 예정일 입력 값 (-)잘라서 년도만 담기
		  var strM1;										//프로젝트 시작 예정일 입력 값 (-)잘라서 월자만 담기
		  var strD1;										//프로젝트 시작 예정일 입력 값 (-)잘라서 일자만 담기
		  
		  inputDate1 = frm.estimate_dt.value; //프로젝트 시작 예정일에 입력되는 년/월/일
		  
		  if(inputDate1.length == 8){
			  inputDate = $('#calendarData1').val();	//프로젝트 시작 예정일 input에 입력된 값 불러오기.

			  strY1 = inputDate1.substr(0,4); //입력 년도만 나눠서 변수에 담기.
			  strM1 = inputDate1.substr(4,2); //입력 월자만 나눠서 변수에 담기.
			  strD1 = inputDate1.substr(6,2); //입력 일자만 나눠서 변수에 담기.
			 
			  frm.estimate_dt.value = strY1+'-'+strM1+'-'+strD1; //데이트 날짜 넘겨 주기위해 포맷 yyyy-mm-dd 맞추기.
		  }else if(event.keyCode == 8){
			  //alert('프로젝트 시작 예정일을 정확히 입력해주세요.(ex1900-01-01)');
			  frm.estimate_dt.value=''; //텍스트 날짜 입력 지울 시 텍스트 입력 창 초기화.
			  //alert(event.keyCode);
			  return;
		  }
	  }
	
	
//-->
</script>
</head>
<body>
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
	<!-- contents -->
	<div id="content">

		<!-- title -->
		<div class="content_navi">영업지원 &gt; 견적서<%=title%> &gt; 견적서상세정보</div>
		<h3><span>견</span>적서상세정보</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
		<!-- title -->
			
		<div class="con">
			<!-- 견적서정보 -->
			<div class="con_sub">
				<h4>견적서정보</h4>
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- 필수입력사항텍스트 -->
					<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
					<!-- //필수입력사항텍스트 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				
				<!-- calendar -->
				<div id="CalendarLayer" style="display:none; width:172px; height:176px; "><iframe name="CalendarFrame" src="<%= request.getContextPath()%>/html/lib.calendar.js.html" width="172" height="176" border="0" frameborder="0" scrolling="no"></iframe></div>
				<!-- //calendar -->
				
				<!-- 견적서 삭제 시 호출하는 폼 시작. -->
				<form name="estimateDeleteFrm" method="post">
					<input type = "hidden" name = "curPage" value="<%=curPage%>"/>
					<input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
					<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
					<input type = "hidden" name = "public_no" value="<%=estimateDto.getPublic_no()%>"/>
					<!-- 해당 견적서에 대한 영업진행현황 PROJECT_PK_CODE == PreSalesCode -->
					<input type="hidden" name="PROJECT_PK_CODE" value="<%=estimateDto.getPROJECT_PK_CODE() %>"></input>
					<input type="hidden" name="ContractCode" value="<%=estimateDto.getContractCode()%>"/>
					<input type="hidden" name="contract_yn" value="<%=estimateDto.getContract_yn()%>"/>
				</form>
				<!-- 견적서 삭제 시 호출하는 폼 끝. -->
				
				
				<form name="estimateVeiw" method="post" action="<%= request.getContextPath()%>/B_Estimate.do?cmd=estimateEdit" enctype="multipart/form-data">
				
				<input type = "hidden" name = "pYear1" value=""/>
     			 <input type = "hidden" name = "pMonth1" value=""/>
     			 <input type = "hidden" name = "pDay1" value=""/>
				
				
				<input type = "hidden" name = "curPage" value="<%=curPage%>"/>
				<input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
				<input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
				<input type = "hidden" name = "type" value="<%=type%>"/>
				
				<input type = "hidden" name = "public_no" value="<%=estimateDto.getPublic_no()%>"/>
				<input type = "hidden" name = "comp_code_re" value="<%=estimateDto.getComp_code()%>"/>
				<input type = "hidden" name = "comp_code" value="<%=estimateDto.getComp_code()%>"/>
				<input type = "hidden" name = "comp_code1" value="<%=estimateDto.getComp_nm()%>"/>
				<input type = "hidden" name = "owner_nm" value=""/>
				<input type = "hidden" name = "business" value=""/>
				<input type = "hidden" name = "b_item" value=""/>
				<input type = "hidden" name = "post" value=""/>
				<input type = "hidden" name = "address" value=""/>
				<input type = "hidden" name = "addr_detail" value=""/>
				<input type = "hidden" name = "permit_no" value=""/>
				<input type = "hidden" name = "user_id" value="<%=estimateDto.getSales_charge()%>"/>
				<input type = "hidden" name = "sales_charge" value="<%=estimateDto.getSales_charge()%>"/>
				<!-- 모발행번호 조회 수동입력 초기 업체명 값. -->
				<input type = "hidden" name = "e_comp_nm_ori" value=""/>
				<!-- 모발행번호 조회 수동입력 초기 업체코드 값. -->
				<input type = "hidden" name = "comp_code_ori" value=""/>
				<!-- 중복체크 플래그 -->
				<input type="hidden" name="trueflag" value="true"></input>
				<input type="hidden" name="falseflag" value="false"></input>
				
				<!-- 견적서정보 -->
				<fieldset>
					<legend>견적서정보</legend>
					<table class="tbl_type" summary="견적서정보(발행번호, 모발행번호, 영업현황코드, 발행구분, 계약여부, 매출구분, 상품코드(자사/내자), 견적일자, 견적금액, 견적서파일)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th><label for="">발행번호</label></th>
							<!-- 2013_04_29(월) shbyeon. 영업진행현황 메뉴에 대한 프로젝트코드 추가 및 매핑 이슈로 사용안함. 현재 모발행번호 삭제와 조회는 사용 할 이유가 없고. 새로 등록하는(견적발행)요건이 맞다고 판단.
							<input type="text" name="p_public_no" class="in_txt" style="width:100px" readonly value="<%=estimateDto.getP_public_no()%>" onclick="javascript:popPublicNo();">
							<a href="javascript:popPublicNo();" class="btn3"><img src="<%= request.getContextPath()%>/images/btn_srch_num2.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_srch_num2_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_srch_num2.gif'" width="85" height="18" title="모발행번호 조회" /></a>
							<a href="javascript:delPublicNo();" class="btn3"><img src="<%= request.getContextPath()%>/images/btn_del_num2.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_del_num2_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_del_num2.gif'" width="85" height="18" title="모발행번호 삭제" /></a></td>
							-->
							<td><input type="text" name="public_no" id="" class="text dis" title="발행번호" style="width:200px;" readonly value="<%=estimateDto.getPublic_no()%>"/></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for="">모발행번호</label></th>
							 <!-- 2013_04_29(월) shbyeon. 영업진행현황 메뉴에 대한 프로젝트코드 추가 및 매핑 이슈로 사용안함. 현재 모발행번호 삭제와 조회는 사용 할 이유가 없고. 새로 등록하는(견적발행)요건이 맞다고 판단.
							 <input type="text" name="p_public_no" class="in_txt" style="width:100px" readonly value="<%=estimateDto.getP_public_no()%>" onclick="javascript:popPublicNo();">
							 <a href="javascript:popPublicNo();" class="btn3"><img src="<%= request.getContextPath()%>/images/btn_srch_num2.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_srch_num2_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_srch_num2.gif'" width="85" height="18" title="모발행번호 조회" /></a>
							 <a href="javascript:delPublicNo();" class="btn3"><img src="<%= request.getContextPath()%>/images/btn_del_num2.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_del_num2_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_del_num2.gif'" width="85" height="18" title="모발행번호 삭제" /></a></td>
							 -->
							 <td><input type="text" name="p_public_no" id="" class="text dis" title="모발행번호" style="width:200px;" readonly value="<%=estimateDto.getP_public_no()%>"/></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for="">영업현황코드</label></th>
							<td><input type="text" id=""  name="PROJECT_PK_CODE" class="text dis" title="모발행번호" style="width:200px;" value="<%=estimateDto.getPROJECT_PK_CODE() %>" readonly="readonly"/><br /><span class="guide_txt br">* <strong>영업현황 코드</strong> : 영업진행현황에 기등록된 견적서 발행한 건에 대한 코드명을 나타냅니다.<br />(단, 영업진행현황에 기등록된 영업현황 코드로 발행한 견적서가 아닌 건에 대해서는 코드가 존재하지 않습니다.)</span></td>
						</tr>
						<%
							String dpublicyn="chekced";
							String d_public_yn=StringUtil.nvl(estimateDto.getD_public_yn(),"");
							
							if(d_public_yn.equals("Y")){
								dpublicyn="checked";			
							}else{
								dpublicyn="";	
							}
							
							//경유매출 구분 2013-11-19(화)shbyeon.
							
							String IndirectSalescheck = "";
							String IndirectSalesYN = StringUtil.nvl(estimateDto.getIndirectSalesYN());
							
							if(IndirectSalesYN.equals("Y")){
								IndirectSalescheck="checked";
							}else{
								IndirectSalescheck="";
							}
						%>
						<%--
						2013-12-20 shbyeon. 계약관리 코드 연동(x)
						 <tr>
					      	<th>계약관리 코드</th>
					      	<td colspan="6">
					      		<!-- 해당 견적서에 대한 영업진행현황 ProjectPk == PreSalesCode 임. (현재 칼럼명 변경안한상태.) -->
					    			<input type="text" name="ContractCode" class="in_txt_off" style="width:100px" value="<%=estimateDto.getContractCode() %>" readonly="readonly"></input>
					    			</br>
					    		<font color="black">*계약관리 코드:견적서 발행 시 계약으로 견적서 발행한 건에 대한 코드명을 나타냅니다.* 
					    		</br>(단 미계약으로 견적서 발행한 견적서는 계약관리 코드가 존재 하지 않습니다.)</font>
					      	</td>	
					      </tr>	
						--%>
						<tr>
							<th><label for="">발행구분</label></th>
							<td><input type="checkbox" id="" name="dpublicyn"  <%=dpublicyn%> class="check md0" title="직접발행" /><label for="">직접발행</label><input type = "hidden" name = "d_public_yn" value=""/><input type="checkbox" id="" name="IndirectSaleschk" value="<%=estimateDto.getIndirectSalesYN() %>" <%=IndirectSalescheck %> class="check" title="경유매출" onclick="javascript:indirectSalesChk();"/><label for="">경유매출</label><input type="hidden" name="IndirectSalesYN" value=""></input><span class="guide_txt">&nbsp;&nbsp;* 직접발행이란? <strong>End User(최종 사용자)에게 직접 견적서를 전달하고 계약 가능한 건</strong>을 의미합니다.</span></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계약여부</label></th>
							<td>
								<% 
									if ((StringUtil.nvl(estimateDto.getContract_yn(), "")).equals("Y")) { 
								%>
									<input type="radio" id="" name="contract_yn" checked  value="Y" class="radio md0" title="계약" /><label for="">계약</label><input type="radio" id="" name="contract_yn" value="N" class="radio" title="미계약" /><label for="">미계약</label>
								<%
									} else {
								%>
									<input type="radio" id="" name="contract_yn" value="Y" class="radio md0" title="계약" /><label for="">계약</label><input type="radio" id="" name="contract_yn" value="N" checked  class="radio" title="미계약" /><label for="">미계약</label>
								<%
									}
								%>
							</td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>매출구분</label></th>
							<td><input type="hidden" name="SalesSort" value="<%=estimateDto.getSalesSort()%>"></input><input type="checkbox" id="" name="SalesSortChk" class="check md0" <%=acheckd %> onclick="javascript:insert_SalesSortGb();" title="시스템매출" /><label for="">시스템매출</label><input type="checkbox" id="" name="SalesSortChk" class="check" <%=bcheckd %> onclick="javascript:insert_SalesSortGb();" title="상품매출" /><label for="">상품매출</label><input type="checkbox" id="" name="SalesSortChk" class="check" <%=ccheckd %> onclick="javascript:insert_SalesSortGb();" title="용역매출" /><label for="">용역매출</label></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>상품코드(자사/내자)</label></th>
							<td class="prodCode">
								<div id="products" class="codeList">
									<h5>상품코드(자사/내자)</h5>
									<div id="catalog">
										<h6><a href="#">자사(내자)</a></h6>
										<ul>
											<%
												for(int x=0; x<codeList.size(); x++){
													ComCodeDTO codeDto = new ComCodeDTO();
													codeDto = (ComCodeDTO)codeList.get(x);
											%>
												<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a></li>
											<%
												}
											%>
										</ul>
										<h6><a href="#none">비자사(내자)</a></h6>
										<ul>
											<%
												for(int x=0; x<codeList2.size(); x++){
													ComCodeDTO codeDto = new ComCodeDTO();
													codeDto = (ComCodeDTO)codeList2.get(x);
											%>
												<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a></li>
											<%
												}
											%>
										</ul>
										<h6><a href="#none">비자사(외자)</a></h6>
										<ul>
											<%
												for(int x=0; x<codeList3.size(); x++){
													ComCodeDTO codeDto = new ComCodeDTO();
													codeDto = (ComCodeDTO)codeList3.get(x);
											%>
												<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a></li>
											<%
												}
											%>
										</ul>
									</div>
								</div>
								<div id="cart">
									<h5>상품코드</h5>
									<ol>
										<%
											for(int x=0; x<productList.size(); x++){
												csDtoPro = new CurrentStatusDTO();
												csDtoPro = (CurrentStatusDTO)productList.get(x);
										%>
											<li id="<%=csDtoPro.getProductCode() %>" ondblclick="delCode('<%=csDtoPro.getProductCode() %>')" style="cursor: pointer;"><a><%=csDtoPro.getProductName() %></a><input type='hidden' name='ProductCode' id='ProductCode' value="<%=csDtoPro.getProductCode()%>"/></li>
										<%
											}
										%>
									</ol>
								</div>
								<div class="guide">
									<span class="guide_txt"><strong>* 자사상품코드 또는 내자상품코드 둘중 하나는 선택해주세요.</strong><br />
									* 상품코드 등록 방법은 <strong>더블클릭</strong>을 하여 좌측에 해당 상품코드 박스로 추가 등록 및 수정이 가능합니다.</span>
								</div>
							</td>
						</tr>	
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>견적일자</label></th>
							<td><span class="ico_calendar"><input id="calendarData1"name="estimate_dt" class="text" style="width:100px;" value="<%=estimate_dt%>"/></span>
							<input type="hidden"  class="" style="width:100px" value="<%=estimateDto.getEstimate_dt()%>" /></td>
						</tr>

						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>견적금액</label></th>
							<td class="listT">
								<input type="hidden" name="supply_price" class="in_txt"  style="width:80px" value="<%=estimateDto.getSupply_price()%>" />
								<input type="hidden" name="vat" class="in_txt"  style="width:80px" value="<%=estimateDto.getVat()%>" />
								<input type="hidden" name="total_amt" class="in_txt"  style="width:80px" value="" />
								<table class="tbl_type" summary="견적금액(공급가, 부가세, 합계)">
									<colgroup>
										<col width="11%" />
										<col width="22%" />
										<col width="11%" />
										<col width="22%" />
										<col width="11%" />
										<col width="*" />
									</colgroup>
									<tbody>
									<tr class="last">
										<th><label for="">공급가</label></th>
										<%-- <td><input type="text" id="" name="supply_price_view" class="text text_r" title="공급가" style="width:153px;" maxlength="18" value="<%=NumberUtil.getPriceFormat(estimateDto.getSupply_price())%>" onkeyup = "saleCntCal('estimateVeiw.supply_price','2')"/> 원</td> --%>
										<td><input type="text" id="" name="supply_price_view" class="text text_r" title="공급가" style="width:153px;" maxlength="18" value="<%=NumberUtil.getPriceFormat(estimateDto.getSupply_price())%>" onBlur = "saleCntCal('estimateVeiw.supply_price','2')"/> 원</td>
										<th><label for="">부가세</label></th>
										<%-- <td><input type="text" name="vat_view" id="" class="text text_r" title="부가세" style="width:153px;" maxlength="18" value="<%=NumberUtil.getPriceFormat(estimateDto.getVat())%>" onkeyup = "saleCntCal('estimateVeiw.vat','2')"/> 원</td> --%>
										<td><input type="text" name="vat_view" id="" class="text text_r" title="부가세" style="width:153px;" maxlength="18" value="<%=NumberUtil.getPriceFormat(estimateDto.getVat())%>" onBlur = "saleCntCal('estimateVeiw.vat','2')"/> 원</td>
										<th><label for="">합계</label></th>
										<td class="last"><input type="text" name="total_amt_view" id="" class="text text_r" title="합계" style="width:163px;" readonly/> 원</td>
									</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr id="Indirect_info">
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>경유매출금액</label></th>
							<td class="listT">
								<table class="tbl_type" summary="경유매출금액(매입원가(VAT별도), 매출이익, 이익율)">
									<colgroup>
										<col width="11%" />
										<col width="22%" />
										<col width="11%" />
										<col width="22%" />
										<col width="11%" />
										<col width="*" />
									</colgroup>
									<tbody>
									<tr class="last" id="Indirect_info">
										<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
										<th><label for="">매입원가<br />(VAT별도)</label></th>
										<%-- <td><input type="text" id="" name="purchase_view" class="text text_r" title="매입원가(VAT별도)" style="width:153px;" maxlength="18"  onKeyUp = "saleCntCal2()" value="<%=NumberUtil.getPriceFormat(estimateDto.getPurchase())%>" /> 원</td> --%>
										<td><input type="text" id="" name="purchase_view" class="text text_r" title="매입원가(VAT별도)" style="width:153px;" maxlength="18"  onBlur = "saleCntCal2()" value="<%=NumberUtil.getPriceFormat(estimateDto.getPurchase())%>" /> 원</td>
										<th><label for="">매출이익</label></th>
										<td><input type="text" id="" name="sales_profit_view" class="text text_r dis" title="매출이익" style="width:153px;" maxlength="18" readOnly  value="<%=NumberUtil.getPriceFormat(estimateDto.getSales_profit())%>"/> 원</td>
										<th><label for="">이익율</label></th>
										<td class="last"><input type="text" name="profit_percent_view" id="" class="text text_r dis" title="이익율" style="width:161px;" readOnly value="<%=estimateDto.getProfit_percent()%>"/> %<input type="hidden" name="Purchase" class="in_txt"  style="width:80px" value="<%=estimateDto.getPurchase()%>" /><input type="hidden" name="Sales_profit" class="in_txt"  style="width:80px" value="<%=estimateDto.getSales_profit()%>" /><input type="hidden" name="Profit_percent" class="in_txt"  style="width:80px" value="<%=estimateDto.getProfit_percent()%>" /></td>
									</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<th><label for="">견적서파일</label></th>
							<%
// 								String serverUrl = "//" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
								//String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
								String serverUrl = "" + request.getContextPath();
							  	String estimate_e_file=estimateDto.getEstimate_e_file();
							  	String estimate_p_file=estimateDto.getEstimate_p_file();
								
								int e_index=estimate_e_file.lastIndexOf("/");
								int p_index=estimate_p_file.lastIndexOf("/");
								
								String estimate_e_filename=estimate_e_file.substring(e_index+1);
								String estimate_p_filename=estimate_p_file.substring(p_index+1);
								
								String estimate_e_path="";               
								            String estimate_p_path="";
								            
								            if(!estimate_e_file.equals("")){
								            	estimate_e_path=estimate_e_file.substring(0,e_index);
								            }
								            
								            if(!estimate_p_file.equals("")){
								            	estimate_p_path=estimate_p_file.substring(0,p_index);
								            }
							%>
							<input type="hidden" name="ESTIMATE_E_FILENM" value="<%=estimateDto.getESTIMATE_E_FILENM()%>"></input>
							<input type="hidden" name="ESTIMATE_P_FILENM" value="<%=estimateDto.getESTIMATE_P_FILENM()%>"></input>
							<td>
								<ul class="listD">
									<li class="first"><div class="fileUp">EXCEL&nbsp;&nbsp;<input type="text" class="text" id="file1" title="EXCEL" style="width:715px;" value="<%=estimateDto.getEstimate_e_file() %>" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="estimate_e_file" id="upload1" /></div><% if(!estimateDto.getEstimate_e_file().equals("")){ %><a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=estimate_e_filename%>&sFileName=<%=estimate_e_filename%>&filePath=<%=estimate_e_path%>" class="btn_type03"><span id="p_estimate_e_file_t">견적서다운로드</span></a><!-- 2013_05_15(수)shbyeon. 현재사용하지않음. &nbsp;|&nbsp;<a href="javascript:fileDel('p_estimate_e_file');"><span id="p_estimate_e_file_d">삭제</span></a> --><% } %><input type="hidden" name="p_estimate_e_file" value="<%=estimateDto.getEstimate_e_file()%>"/></li>
									<li><div class="fileUp">PDF&nbsp;&nbsp;<input type="text" class="text" id="file2" title="PDF" style="margin-left:14px;width:715px;" value="<%=estimateDto.getEstimate_p_file() %>" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="estimate_p_file" id="upload2" /></div><% if(!estimateDto.getEstimate_p_file().equals("")){ %><a href="<%=serverUrl %>/fileDownServlet?rFileName=<%=estimate_p_filename%>&sFileName=<%=estimate_p_filename%>&filePath=<%=estimate_p_path%>" class="btn_type03"><span id="p_estimate_p_file_t">견적서다운로드</span></a><!-- 2013_05_15(수)shbyeon. 현재사용하지않음. &nbsp;|&nbsp;<a href="javascript:fileDel('p_estimate_p_file');"><span id="p_estimate_p_file_d">삭제</span></a> --><% } %><input type="hidden" name="p_estimate_p_file" value="<%=estimateDto.getEstimate_p_file()%>" /></li>
								</ul>
							</td>
						</tr>
						</tbody>
					</table>
				</fieldset>
			</div>
			<!-- //견적서정보 -->
			<!-- 고객정보 -->
			<div class="con_sub">
				<h4>고객정보</h4>
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- 필수입력사항텍스트 -->
					<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
					<!-- //필수입력사항텍스트 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				<!-- 등록 -->
				<fieldset>
					<legend>고객정보</legend>
					<table class="tbl_type" summary="고객정보(수신인, 제목, 업체명)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<%
							/* 기존 comp_code 없는 수동입력시에 사용했던 check 로직 현재는 사용안함. 
							       		2013_03_29(금) shbyeon.
							       		
							String comp_code=StringUtil.nvl(estimateDto.getComp_code(),"");
							String checkedyn="";
							String acomp="inline";
							String bcomp="none";
							
							if(!comp_code.equals("")){
								checkedyn="";
							                acomp="inline";
								bcomp="none";
							}else{
								checkedyn="checked";
							                acomp="none";
								bcomp="inline";
							}
							       */
						%>
							
						<%
							//수동입력 체크 부분 2013_05_09(목)shbyeon.
							
							String comp_code=StringUtil.nvl(estimateDto.getComp_code(),"");
							        	System.out.println("comp_code:"+comp_code);
							String checkedyn="";
							String acomp="inline";
							String bcomp="none";
							
							if(comp_code != ""){
								checkedyn="";
							                acomp="inline";
								bcomp="none";
							}else{
								checkedyn="checked";
							                acomp="none";
								bcomp="inline";
							}
						%>
						<tr>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>수신인</label></th>
							<td><input type="text" name="receiver" id="" class="text" title="수신인" style="width:200px;" maxlength="50" value="<%=estimateDto.getReceiver()%>"/></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>제목</label></th>
							<td><input type="text" name="title" id="" class="text" title="제목" style="width:917px;" maxlength="250" value="<%=estimateDto.getTitle()%>"/></td>
						</tr>
						<tr>
							<th><label for="">업체명</label></th>
							<td><input type="checkbox" id="" name="checkyn" <%=checkedyn%> class="check md0" title="수동입력" onclick="javascript:directInput();" /><label for="">수동입력</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="" name="comp_nm" class="text" title="업체명" style="display:<%=acomp %>;width:300px;" readonly value="<%=estimateDto.getE_comp_nm()%>"/><input type="text" id="" name="e_comp_nm" class="text" title="업체명" style="display:<%=bcomp %>;width:300px;" value="<%=estimateDto.getE_comp_nm()%>" /><!-- 2013_05_07(화)shbyeon. 현재 중복체크 사용안함. <a href="javascript:fnDuplicateCheck();" class="btn3"><img src="<%=request.getContextPath()%>/images/btn_dupli_confirm.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm.gif'" style="display:none;" name="e_comp_nm_se" title="중복확인" width="52" height="18" /></a>	--><a href="javascript:popComp();" class="btn_type03"><span>업체조회</span></a></td>
						</tr>
						</tbody>
					</table>
				</fieldset>
			</div>
			<!-- //고객정보 -->
			<!-- 담당자정보 -->
			<div class="con_sub last">
				<h4>담당자정보</h4>
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- 필수입력사항텍스트 -->
					<p class="must_txt"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
					<!-- //필수입력사항텍스트 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				<!-- 등록 -->
				<fieldset>
					<legend>담당자정보</legend>
					<table class="tbl_type" summary="담당자정보(작성자, 담당영업, 수주가능성, 특이사항)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>작성자</label></th>
							<td><input type="text" id="" class="text" title="작성자" style="width:200px;" readonly value="<%=estimateDto.getReg_nm()%>"/></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>담당영업</label></th>
							<td><input type="text" name="user_nm" id="" class="text" title="담당영업" style="width:200px;" readonly value="<%=estimateDto.getSales_charge_nm()%>"/><a href="javascript:popSales();" class="btn_type03"><span>사원조회</span></a></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>수주가능성</label></th>
							<td><%
								CodeParam codeParam = new CodeParam();
								codeParam.setType("select"); 
								codeParam.setStyleClass("td3");
								//codeParam.setFirst("전체");
								codeParam.setName("orderble");
								codeParam.setSelected(estimateDto.getOrderble()); 
								//codeParam.setEvent("javascript:poductSet();"); 
								out.print(CommonUtil.getCodeList(codeParam,"A03")); 
							%></td>
						</tr>
						<tr>
							<th><label for="">특이사항</label></th>
							<td><textarea id="" name="etc" title="특이사항" style="width:917px;height:41px;" onkeyup="js_Str_ChkSub('500', this)" ><%=estimateDto.getEtc()%></textarea></td>
						</tr>
						</tbody>
					</table>
				</fieldset>
				</form>
			</div>
			<!-- //담당자정보 -->
			<!-- Bottom 버튼영역 -->
			<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>수정</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>삭제</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a></div>
			<!-- //Bottom 버튼영역 -->
		</div>
		<!-- //con -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->

<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->

</div>
</body>
</html>
<script>
saleCntCalInit('estimateVeiw.supply_price','1');
</script>
<%
if(type.equals("reg")){
%>
<%=comDao.getMenuAuth(menulist,"11")%>
<% 	
}else{
%>	
<%=comDao.getMenuAuth(menulist,"19")%>
<% 
}	
%>
<script type="text/javascript">fn_fileUpload();</script>