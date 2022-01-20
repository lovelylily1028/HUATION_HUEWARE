<%@page import="java.text.DecimalFormat"%>
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
<%@ page import ="java.text.SimpleDateFormat" %>
<%
    
	Map model = (Map)request.getAttribute("MODEL");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
	String type = (String)model.get("type");
	String title = "";
	if(type.equals("reg")){
		title = "발행";
	}else{
		title = "발행(전체)";
	}
	
	//상품코드 Arr 모델로 객체로 꺼낸다 codeList로.
	ArrayList codeList = (ArrayList)model.get("codeList"); //자사 상품코드
	ArrayList codeList2 = (ArrayList)model.get("codeList2"); //비자사(내수)상품코드
	ArrayList codeList3 = (ArrayList)model.get("codeList3"); //비자사(외수)상품코드
	
	DecimalFormat df = new DecimalFormat("00");	
	Calendar cal = Calendar.getInstance();	
	String Today = Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE));
	
	
	String Month = df.format(cal.get(Calendar.MONTH)+1);
	String DATE =  df.format(cal.get(Calendar.DATE)); 
	
	//Date 포맷(2013-12-27) 오늘 날짜로 type 마춰주기.
	String estimate_dt = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>견적서(매출) 발행</title>
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

	var frm = document.estimateRegist; 
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
	
	if(frm.SalesSort.value == ''){
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
		

	/*
	  2013_04_01(월) shbyeon. -> 2013_05_07(화)shbyeon. 현재 사용안함.
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

	if(frm.IndirectSaleschk.checked == true){
		if(frm.Purchase.value == "" || frm.Sales_profit.value == "" || frm.Profit_percent.value == ""){
			alert("경유매출 체크 시 경유매출금액란 은 필수입력 항목입니다.");
			return;
		}
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

	
	//견적서 즉시발행으로 인한 영업진행현황 정보 관련 벨류데이션체크.
	var chk_Now = $("td#SalesChk input:checked").val();
	if(chk_Now == "3"){
		
		if(frm.OperatingCompany.value == ""){
			alert("고객사를 입력하세요."); 
			return;
		}
		
		if(frm.AssignPerson.value == ""){
			alert("기술분야 배정인력을 입력하세요."); 
			return;
		}
		
		//예상시기 분기 체크후 분기별 데이터 셋팅
	    if(frm.target_month.value == "01" || frm.target_month.value == "02" || frm.target_month.value == "03"){
	    	frm.Quarter.value = "1";
	    }
	    if(frm.target_month.value == "04" || frm.target_month.value == "05" || frm.target_month.value == "06"){
	    	frm.Quarter.value = "2";
	    }
	    if(frm.target_month.value == "07" || frm.target_month.value == "08" || frm.target_month.value == "09"){
	    	frm.Quarter.value = "3";
	    }
	    if(frm.target_month.value == "10" || frm.target_month.value == "11" || frm.target_month.value == "12"){
	    	frm.Quarter.value = "4";
	    }
	    
	    frm.DateProjections.value=frm.target_year.value+'.'+frm.target_month.value;
	}
    
	
	frm.sales_charge.value=frm.user_id.value;
	frm.ChargeSecondID.value=frm.user_id2.value;

	frm.curPage.value='1';
	frm.searchGb.value='';
	frm.searchtxt.value='';
	frm.ESTIMATE_E_FILENM.value = strFileName;
	frm.ESTIMATE_P_FILENM.value = strFileName2;
	
	if(frm.checkyn.checked==true){
		frm.checkyn.value='Y'; //수동입력했을때.
		//alert(frm.checkyn.value);
	}else{
		frm.checkyn.value=''   //수동입력 사용 안했을때
		//alert(frm.checkyn.value);
	}
	frm.submit();
}

function cancle(){
	
	var frm = document.test;
	frm.action='<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList';
	frm.submit();

}

//팝업 가져온 데이터 코드 세팅 2013_05_07(화)shbyeon.
function settingCode(data){
	
	var pcname = data.split("+"); //상품코드 데이터 (+)구분자로 찾아서  Ajax로 받은 data를 잘라준다
	//alert("1"+pcname); //구분자(+) 즉 상품코드 갯수 만큼  (ex:PC00HUEFAX|HUEFAX) arr단위로 잘라서 증가시킨다.
	//영업진행현황 상품코드 재 조회 후 사용 시 상품코드 초기화.
	$('#cart ol li').remove();
	$('#products li').show();
	$('#NoCode').remove(); //(상품코드 cart) 삭제
	
	for(var x=0; x < pcname.length; x++){ /*구분자(+) 즉 상품코드 갯수 만큼  (ex:PC00HUEFAX|HUEFAX)
											arr단위로 잘라서 증가시킨다.
										   */
		//alert(pcname[x]); //ex:PC00HUEFAX|HUEFAX) 상품코드 갯수 찍어보는 alert
											
		var pcCode = pcname[x].split("|"); /*위에서 (+)잘라서 (ex:PC00HUEFAX|HUEFAX) 증가시킨 데이터를  (|)구분자
											 기준으로 한번 더 잘라준다. 첫번째 [x]의 pcCode[0]두번째 pcCode[x]는 [1]로.
											 상품코드 (ex:PC00HUEFAX|HUEFAX) DAO에서 합쳐진 Ajax로 넘겨받은 Data를
										   	(|)구분자로 찾아서 잘라서 pcCode <<실제 DB에 들어갈 Value 데이터값을 변수에 넣어준다.
										   	 잘라줄때 [x] 상품코드 데이터 갯수 pcname[x]만큼 잘라진 데이터를 (|)구분자로 
										   	 [0]일때는 코드명 [1]일때는 이름명으로 셋팅해준다.
											*/
											
		//alert("2"+pcCode[0]+"...."+pcCode[1]);   //pcCode[0]배열(코드명), pcname[1]배열(이름명)
		
		//팝업에서 데이터 가져왔을때 셋팅 시작..
		$('#products #'+pcCode[0]).hide(); //왼쪽(상품코드 정보) 우측 상품코드 목록Append되 있는  해당 데이터 숨김
		
		//오른쪽(상품코드 박스)에 코드에 추가
		$('#cart ol').append("<li id="+pcCode[0]+" ondblclick=\"delCode('"+pcCode[0]+"')\" style=\"cursor: pointer;\">"+"<a>"+pcCode[1]+"</a>"+" <input type='hidden' name='ProductCode' id='ProductCode' value="+pcCode[0]+"></li>");
	}
	
}


//영업진행현황 조회
function popProjectCode(){
	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPreSalesCode&sForm=estimateRegist&contractGb=N","","width=1000,height=573,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
	
}

//모발행번호 조회.
function popPublicNo(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchPublicNo&sForm=estimateRegist&contractGb=N&type=<%=type%>","","width=850,height=655,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars=no, status=no");
}

//업체 조회 팝업창 
function popComp(){

		var obj=document.estimateRegist;
		if(obj.checkyn.checked==true){
				alert('수동입력 선택을 해제후 업체조회 하시기 바랍니다.');
				return;
		}else{
			var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp&sForm=estimateRegist","","width=850,height=652,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
		}
}

function popSales(){
		var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=estimateRegist","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}
function popSales_Second(){
	var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser2&sForm=estimateRegist","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
}
function saleCntCal(form){

	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+"_view");
		var frm=eval("document."+form);
		var costobj=document.estimateRegist;

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

		if(form=='estimateRegist.supply_price'){	
			var vat=parseInt(onlyNum(costobj.supply_price.value)*0.1,10);
			costobj.vat_view.value=addCommaStr(''+vat);
		    costobj.vat.value=vat;
		    
		    
		}

		var tcost=parseInt(onlyNum(costobj.supply_price.value),10)+parseInt(onlyNum(costobj.vat.value),10);

		costobj.total_amt_view.value=addCommaStr(''+tcost);
		costobj.total_amt.value=tcost;

		//v_obj.focus();

	}
		
//매입원가 계산 2013-11-19(화) shbyeon.
function saleCntCal2(){
	
	var frm = document.estimateRegist;
	var supply_price = frm.supply_price_view.value;		//공급가(견적금액 VAT별도)
	var purchase = frm.purchase_view.value; 				//매입원가
	if(frm.supply_price_view.value == '0'){
		alert("견적금액을 바르게 입력하세요.");
		frm.Purchase.value="0";
		frm.purchase_view.value="0";
		frm.Sales_profit.value="0";
		frm.sales_profit_view.value="0";
		frm.supply_price_view.value = "";
		frm.supply_price.value = "";
		frm.supply_price_view.focus();
		return;
	}else{
		//1.(견적금액[공급가] - 매입원가) = sales_profit(매출이익)
		var sales_profit = parseInt(onlyNum(supply_price))-parseInt(onlyNum(purchase));
		//2. 매출이익 / 견적금액[매입원가] * 100 = profit_percent(이익율)
		var profit_percent = sales_profit/parseInt(onlyNum(purchase)) * 100;	
		//3.견적금액[공급가] 변경 시에도 매출이익 계산처리를 위해 추가함.
		if(purchase == 0){
		//4.견적금액 입력 시 매출이익 계산은 하지만 실제로 넘겨줄 Name 값과 View 값에는 넣지않음.	

		}else{
		//5.견적금액[공급가] 변경 시에도 매출이익 계산됨.(toFixed(1) Ex:함수 소수점 이하 1자리로 표현함)
		frm.purchase_view.value=addCommaStr(''+onlyNum(purchase));	 	  //매입원가 뷰잉값.
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
				frm.supply_price.value = "";
				frm.supply_price_view.value = "";
				frm.supply_price_view.focus();
				return;
			}
		}
	}
}
	
	/*수동입력체크(기존)
	*/
	function directInput(){

	    var obj=document.estimateRegist;
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
	
	/*수동입력체크(기존)
	*/
	function directInput(){

	    var obj=document.estimateRegist;
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
	
	/*수동입력 플래그 넘겨주기.(영업진행현황에서는 permit_no(사업자등록번호로)수동입력 업체인지 체크판단이가능하지만.)
	  견적서 발행에서는 Permit_no 값이 없으므로 별도의 플래그로 판단한다. (DB Colum 추가 COMP_FLAG)
	  2013_05_07(화)shbyeon.
	*/
	
	
	
	<%-- 업체명 수동입력일때 중복체크 시작 하는 스크립트. 2013_05_07(화)shbyeon.(현재사용안함)
	/*
	수동입력체크 (수동입력 일때의 업체명 중복체크 사용했을때 사용하는 function)
	2013_05_07(화)shbyeon. 수동입력 체크 현재사용안함.
	function directInput(){

	    var obj=document.estimateRegist;
	    if(obj.checkyn.checked==true){
			
			if(confirm("수동입력으로 변경하시겠습니까?")){
				obj.e_comp_nm.style.display='inline'
				obj.e_comp_nm_se.style.display='inline'
				obj.comp_nm.style.display="none";
				obj.comp_nm.value='';
				obj.comp_code.value='';
			}else{
				obj.checkyn.checked=false;
			}
		}else{
			if(confirm("선택입력으로 변경하시겠습니까?")){
				obj.e_comp_nm.style.display='none'
				obj.e_comp_nm_se.style.display='none'
				obj.comp_nm.style.display="inline";
				obj.comp_code.value=''; //업체코드
				obj.comp_nm.value='';   //업체조회 선택시 업체명
				obj.e_comp_nm.value=''; //수동입력 선택시 업체명
			}else{
				obj.checkyn.checked=true;
			}
		}
	}
	*/
	
	 /*
	  * 중복체크(공통) XML 방식 
	    2013_05_07(화)shbyeon. 현재 업체 중복체크 사용안함.
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
	
	/*업체중복확인 check 2013_03_26(화)shbyeon.
	   2013_05_07(화)shbyeon. 현재 업체중복체크 사용안함.(단 중복체크 DB SP는 192.168.2.214 에 그대로있음.)
	 function fnDuplicateCheck() {
		
	 	var frm = document.estimateRegist; 
	 	
	 	
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
	 			//alert(frm.trueflag.value);
	 			frm.comp_code.value='';
	 		} else {
	 			frm.falseflag.value =  frm.e_comp_nm.value;	
	 		}
	 	}
	 }
	*/
	
	업체명 수동입력일때 중복체크 시작 하는 스크립트.
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
	
	/*2013_05_07(화)shbyeon. 현재사용안함.
	초기수동입력 값 비교 후 중복확인 버튼 유무.
	function chkNmButton(){
		var frm = document.estimateRegist; 
		if(frm.e_comp_nm.value == frm.e_comp_nm_ori.value){
			frm.e_comp_nm_se.style.display='none';
			//초기 수동입력으로 등록시  초기 업체코드값 셋팅 
			frm.comp_code.value=frm.comp_code_ori.value;
		}else{
			frm.e_comp_nm_se.style.display='inline';
		}
	}
	*/
	
	/*2013_05_07(화)shbyeon.
	    초기수동입력 값 비교 후 입력.
	*/
	function chkNm(){
		var frm = document.estimateRegist; 
		if(frm.e_comp_nm.value == frm.e_comp_nm_ori.value){
			//frm.e_comp_nm_se.style.display='none';
			//초기 수동입력으로 등록시  초기 업체코드값 셋팅 
			frm.comp_code.value=frm.comp_code_ori.value;
		}else{
			//frm.e_comp_nm_se.style.display='inline';
		}
	}

	/*
	2013_11_27(수) shbyeon.
	즉시발행/영업진행현황/모발행 
	선택으로 인한 칼럼 hide&show
	*/
	function noneProjectColum(){		
		var chk = $("td#SalesChk input:checked").val();
		
		if(chk == "1"){
			$('#hide_tr_now').hide();
			$('#hide_tr_code').show();
			$('#hide_tr_pub').hide();
			$('[name=p_public_no]').val(''); //value 값 지우기 (모발행번호 조회)
			$('[name=nowPubRegist]').val(''); //value 값 지우기 (즉시발행)
			$('#sales_info').hide();
			return;
		}else if(chk == "2"){
			$('#hide_tr_now').hide();
			$('#hide_tr_code').hide();
			$('#hide_tr_pub').show();
			$('[name=PROJECT_PK_CODE]').val(''); //value 값 지우기 (영업진행현황 조회)
			$('[name=nowPubRegist]').val(''); //value 값 지우기 (즉시발행)
			$('#sales_info').hide();
			return;
		}else if(chk == "3"){
			$('#hide_tr_now').hide();
			$('#hide_tr_code').hide();
			$('#hide_tr_pub').hide();
			$('[name=p_public_no]').val(''); //value 값 지우기 (모발행번호 조회)
			$('[name=PROJECT_PK_CODE]').val(''); //value 값 지우기 (영업진행현황 조회)
			$('[name=nowPubRegist]').val('3'); //value 값 지우기 (즉시발행 조회)
			$('#sales_info').show();
			return;
		}	

	}
	//발행 구분(경유매출 사용)
	function indirectSalesChk(){	
		var frm = document.estimateRegist;
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
	
	
	//초기 디폴트 화면은 모발행번호 이기때문에 
	//영업진행현황 코드 조회는 hide시킨다. 2013_05_13(월)shbyeon.
	$(function(){
		$("#hide_tr_code").hide();	//영업진행현황 칼럼 초기 페이지 호출 시 hide
		$("#hide_tr_now").hide();	//즉시발행 칼럼 초기 페이지 호출 시 hide
		$("#sales_info").hide();	//영업진행현황 칼럼 입력값 정보.
		$("#Indirect_info").hide(); //경유매출 선택 시 경유매출 입력값 정보.
	})
	
	
	//JQuery - 상품코드 마우스로 데이터 넘겨주기.
	$(function() {
		$( "#catalog" ).accordion();
		
		  $("#products li").dblclick(function(){
			  $('#NoCode').remove(); //상품코드 추가 시 Cart<li>에 있는  상품코드를 넣어주세요. text 지우기.
		      $(this).hide(); //상품코드 선택시 해당 상품코드 hide 숨기기.
		    $('#cart ol').append("<li id="+$(this).attr("id")+" ondblclick=\"delCode('"+$(this).attr("id")+"')\" style=\"cursor: pointer;\">"+"<a>"+$(this).html()+"</a>"+" <input type='hidden' name='ProductCode' id='ProductCode' value="+$(this).attr("id")+"></li>");
		  
		  
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
	
	//영업주관사 == 고객사 동일선택 버튼 2013_05_06(월)shbyeon.
	function chkSaOperatingAdd(){
		var frm = document.estimateRegist; 

		if(frm.comp_nm.value=='' && frm.e_comp_nm.value==''){
			alert('영업주관사를 입력하셔야 사용 가능합니다.');
			return ;
		}else{
			//수동입력 일때.
			if(frm.checkyn.checked==true){
				if(frm.chktest.checked==true){
		   		frm.OperatingCompany.value = frm.e_comp_nm.value;		
				}else{
					frm.chktest.checked==false;
					frm.OperatingCompany.value = '';
				}
			}
			//업체조회 일때.
			if(frm.checkyn.checked==false){
				if(frm.chktest.checked==true){
				frm.OperatingCompany.value = frm.comp_nm.value;	
				}else{
					frm.chktest.checked==false;
					frm.OperatingCompany.value = '';
				}
			}
		}
}
	
	//전화번호 숫자 입력시 체크 후 - 생성
	 function MaskPhon( obj ) { 

	 	 obj.value =  PhonNumStr( obj.value ); //벨류값 있을시 PhonNumStr function 실행.

	 } 



	//전화번호 숫자 입력시 체크 후 - 생성
	 function PhonNumStr( str ){ 

	 	 var RegNotNum  = /[^0-9]/g; 

	 	 var RegPhonNum = ""; 

	 	 var DataForm   = ""; 

	 	 // return blank     

	 	 if( str == "" || str == null ) return ""; 

	 	 // delete not number

	 	 str = str.replace(RegNotNum,'');    

	 	 if( str.length < 4 ) return str; 


	 	 if( str.length > 3 && str.length < 7 ) { 

	 	   	DataForm = "$1-$2"; 

	 		 RegPhonNum = /([0-9]{3})([0-9]+)/; 

	 	 } else if(str.length == 7 ) {

	 		 DataForm = "$1-$2"; 

	 		 RegPhonNum = /([0-9]{3})([0-9]{4})/; 

	 	 } else if(str.length == 9 ) {

	 		 DataForm = "$1-$2-$3"; 

	 		 RegPhonNum = /([0-9]{2})([0-9]{3})([0-9]+)/; 

	 	 } else if(str.length == 10){ 

	 		 if(str.substring(0,2)=="02"){

	 			 DataForm = "$1-$2-$3"; 

	 			 RegPhonNum = /([0-9]{2})([0-9]{4})([0-9]+)/; 

	 		 }else{

	 			 DataForm = "$1-$2-$3"; 

	 			 RegPhonNum = /([0-9]{3})([0-9]{3})([0-9]+)/;

	 		 }

	 	 } else if(str.length > 10){ 

	 		 DataForm = "$1-$2-$3"; 

	 		 RegPhonNum = /([0-9]{3})([0-9]{4})([0-9]+)/; 

	 	 } 


	 	 while( RegPhonNum.test(str) ) {  

	 		 str = str.replace(RegPhonNum, DataForm);  

	 	 } 

	 	 return str; 

	 } 

	
	//대상월 금년/금월 대상으로 자동선택.
	 window.onload = function(){
	     var today = new Date();
	     var year = today.getFullYear();
	     var month = today.getMonth()+1;
	     if(month<10) month = "0" + month;

	     var target_year = document.getElementById('target_year');
	     var target_month = document.getElementById("target_month");
	     
	     for(var i=0; i<target_year.options.length; i++){
	         if(target_year.options[i].value==year){
	             target_year.options[i].selected = true;
	             break;
	         }
	     }
	     
	     for(var j=0; j<target_month.options.length; j++){
	         if(target_month.options[j].value==month){
	             target_month.options[j].selected = true;
	             break;
	         }
	     }
	 }
	 
	//매출구분 체크박스 체크(2013_11_20)
	function insert_SalesSortGb(){
		var frm = document.estimateRegist;
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
		  var frm = document.estimateRegist;	//폼생성
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
<body >
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

<!-- container -->
<div id="container">
<!-- contents -->
<div id="content">
  
  <!-- title -->
	<div class="content_navi">영업지원 &gt; 견적서<%=title%> &gt; 견적서등록</div>
	<h3><span>견</span>적서등록</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
  <!-- //title -->
  
  <!-- calendar -->
 
  <!-- //calendar -->
  
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
  	<form name="test" method="post">
  		<input type = "hidden" name = "curPage" value="<%=curPage%>"/>
	      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
	      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
	      <input type = "hidden" name = "type" value="<%=type%>"/>
  	</form>
    <form name="estimateRegist" method="post" action="<%= request.getContextPath()%>/B_Estimate.do?cmd=estimateRegist" enctype="multipart/form-data">
      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
      <input type = "hidden" name = "type" value="<%=type%>"/>
      
      <input type = "hidden" name = "pYear1" value=""/>
      <input type = "hidden" name = "pMonth1" value=""/>
      <input type = "hidden" name = "pDay1" value=""/>
      
      <input type = "hidden" name = "comp_code" value=""/>
      <input type = "hidden" name = "permit_no" value=""/>
      <input type = "hidden" name = "owner_nm" value=""/>
      <input type = "hidden" name = "business" value=""/>
      <input type = "hidden" name = "b_item" value=""/>
      <input type = "hidden" name = "post" value=""/>
      <input type = "hidden" name = "address" value=""/>
      <input type = "hidden" name = "addr_detail" value=""/>
      <input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>"/>
      <input type = "hidden" name = "user_id2" value="<%=dtoUser.getUserId()%>"/>
      <input type = "hidden" name = "sales_charge" value=""/>
      <!-- 담당영업(부) -->
      <input type = "hidden" name = "ChargeSecondID" value=""></input>
      <!-- 모발행번호 조회 수동입력 초기 업체명 값. -->
      <input type = "hidden" name = "e_comp_nm_ori" value=""/>
      <!-- 모발행번호 조회 수동입력 초기 업체코드 값. -->
      <input type = "hidden" name = "comp_code_ori" value=""/>
       <!-- 중복체크 플래그 -->
      <input type="hidden" name="trueflag" value="true"></input>
      <input type="hidden" name="falseflag" value="false"></input>
      <!-- 영업진행현황 동일 코드로 재 견적 발행 했을 경우 값 -->
      <input type="hidden" name="public_no_retry" value=""></input>
      <!-- span class="tbl_line_top">&nbsp;</span -->
      <!-- 견적서정보 -->
		
	<fieldset>
		<legend>견적서정보</legend>
	<table class="tbl_type" summary="견적서정보(발행옵션선택, 영업현황코드번호, 모발행번호, 발행구분, 계약여부, 매출구분, 상품코드(자사/내자), 견적일자, 견적금액, 경유매출금액, 견적서파일)">
		
		<colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
      
      <tbody>
      	<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>발행옵션선택</label></th>
			<td id="SalesChk"><input type="radio" name="SalesChk" id="" class="radio md0" title="즉시발행" value="3" onclick="javascirpt:noneProjectColum();"/><label for="">즉시발행</label><input type="radio" name="SalesChk" id="" class="radio" title="영업진행현황" value="1" onclick="javascirpt:noneProjectColum();"/><label for="">영업진행현황</label><input type="radio" name="SalesChk" id="" class="radio" checked="checked" title="모 발행" value="2" onclick="javascirpt:noneProjectColum();"/><label for="">모 발행</label><br /><span class="guide_txt br">* <strong>즉시발행</strong> : 즉시발행 시 <strong>영업진행현황 등록 및 최초 견적서 발행</strong>이 가능합니다.<br />*	<strong>영업진행현황</strong>: 영업진행현황 코드를 선택하여 최초 견적서 발행이 가능합니다.<br />* <strong>모 발행</strong> : 모 발행번호를 선택하여 서브견적서 발행 및 최초 견적서 발행이 가능합니다.<br />(영업진행현황에 포함된 서브견적서를 발행 시 영업진행현황에 해당되는 모 발행번호를 선택하여 발행합니다.)</span></td>
		</tr>
		
		<tr id="hide_tr_now"><!-- 발행옵션에서 즉시발행 선택 시 노출 -->
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>즉시발행</label></th>
			<td><input type="text" id="nowPubRegist"  name="nowPubRegist"  class="text"  style="width:200px;" /><!-- value="3" =>즉시발행 플래그값임. --><a href="searchPreSalesCode.html" class="btn_type03"><span>영업진행현황조회</span></a><span class="guide_txt">&nbsp;&nbsp;* 영업진행현황 옵션 선택 시 기등록된 영업진행현황 코드를 선택 후 발행해야합니다.</span></td>
		</tr> 
        
		<tr id="hide_tr_code"><!-- 발행옵션에서 영업진행현황 선택 시 노출 -->
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>영업현황코드번호</label></th>
			<td><input type="text" id="PROJECT_PK_CODE"  name="PROJECT_PK_CODE" class="text" title="영업현황코드번호" style="width:200px;" readOnly onClick="javascript:popProjectCode();"/><a href="javascript:popProjectCode();" class="btn_type03"><span>영업진행현황조회</span></a><span class="guide_txt">&nbsp;&nbsp;* 영업진행현황 옵션 선택 시 기등록된 영업진행현황 코드를 선택 후 발행해야합니다.</span></td>
		</tr>
		
		<tr id="hide_tr_pub"><!-- 발행옵션에서 모발행 선택 시 노출 -->
			<th><label for="">모발행번호</label></th>
			<td><input type="text" id="" name="p_public_no" class="text" title="모발행번호" style="width:200px;" readOnly onClick="javascript:popPublicNo();"/><a href="javascript:popPublicNo();" class="btn_type03"><span>모발행번호조회</span></a><span class="guide_txt">&nbsp;&nbsp;* 모 발행번호를 선택하지 않을 시 <strong>최초 발행번호</strong>가 생성됩니다.</span></td>
		</tr>
		
		<tr>
			<th><label for="">발행구분</label></th>
			<td><input type="checkbox" id="" name="dpublicyn"  checked="checked" class="check md0" title="직접발행" /><label for="">직접발행</label><input type = "hidden" name = "d_public_yn" value=""/><input type="checkbox" id="" name="IndirectSaleschk" class="check" title="경유매출" onclick="javascript:indirectSalesChk();"/><label for="">경유매출</label><input type="hidden" name="IndirectSalesYN" value=""/><span class="guide_txt">&nbsp;&nbsp;* 직접발행이란? <strong>End User(최종 사용자)에게 직접 견적서를 전달하고 계약 가능한 건</strong>을 의미합니다.</span></td>
		</tr>
       
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계약여부</label></th>
			<td><input type="radio" id="" class="radio md0" title="계약" name="contract_yn"  value="Y"/><label for="">계약</label><input type="radio" id="" class="radio" checked="checked" title="미계약" name="contract_yn"  checked="checked"  value="N"/><label for="">미계약</label></td>
		</tr>

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>매출구분</label></th>
			<td><input type="checkbox" id="sa1" name="SalesSortChk" class="check md0" title="시스템매출"  onclick="javascript:insert_SalesSortGb();"/><label for="">시스템매출</label><input type="checkbox" id="sa2" name="SalesSortChk" class="check" title="상품매출"  onclick="javascript:insert_SalesSortGb();"/><label for="">상품매출</label><input type="checkbox" id="sa3" name="SalesSortChk" class="check" title="용역매출"  onclick="javascript:insert_SalesSortGb();"/><label for="">용역매출</label><!-- 실제 넘겨줄 Param 값 --><input type="hidden" name="SalesSort" value=""></input></td>
		</tr>

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>상품코드(자사/내자)</label></th>
			<td class="prodCode">
					<div id="products" class="codeList">
						<h5>상품코드(자사/내자)</h5>
						<div id="catalog">
							<h6><a href="#none">자사(내자)</a></h6><!-- 코드 활성화 : class="on" 추가 -->
							<ul>
										<%
				       						for(int x=0; x<codeList.size(); x++){
				       							ComCodeDTO codeDto = new ComCodeDTO();
				       							codeDto = (ComCodeDTO)codeList.get(x);
				       					%>
				       							<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a>
				       							</li>
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
		       							<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a>
		       							</li>
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
		       							<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a>
		       							</li>
		       					<%
		       						}
		       					%>
						</ul>
					</div>
			</div>
			
			<div id="cart">
				<h5>상품코드</h5>
					<ol>
						<li class="placeholder" id="NoCode"><span>상품코드를 넣어주세요.</span></li>
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
							<td><span class="ico_calendar"><input id="calendarData1"value="<%=estimate_dt%>" class="text" name="estimate_dt" style="width:100px;"/></span><input type="hidden" class="in_txt"  style="width:80px" value=""/>
							</td>
		</tr>

       	<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>견적금액</label></th>
				<td class="listT">
					<input type="hidden" name="supply_price" class="in_txt"  style="width:80px" value="" />
		          	<input type="hidden" name="vat" class="in_txt"  style="width:80px" value="" />
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
						<!-- <td><input type="text" id="" name="supply_price_view" class="text text_r" title="공급가" style="width:153px;" maxlength="18"  onKeyUp = "saleCntCal('estimateRegist.supply_price'),saleCntCal2()" value="0"/> 원</td> -->
						<td><input type="text" id="" name="supply_price_view" class="text text_r" title="공급가" style="width:153px;" maxlength="18"  onBlur = "saleCntCal('estimateRegist.supply_price'),saleCntCal2()" value="0" z-index=1/> 원</td>
						<th><label for="">부가세</label></th>
						<!-- <td><input type="text" id="" name="vat_view" class="text text_r" title="부가세" style="width:153px;" maxlength="18" onKeyUp = "saleCntCal('estimateRegist.vat')" value="0" z-index=2/> 원</td>  -->
						<td><input type="text" id="" name="vat_view" class="text text_r" title="부가세" style="width:153px;" maxlength="18" onBlur = "saleCntCal('estimateRegist.vat')" value="0" z-index=2/> 원</td>
						<th><label for="">합계</label></th>
						<td class="last"><input type="text" id="" name="total_amt_view" class="text text_r" title="합계" style="width:163px;" readOnly value="0"/> 원</td>
					</tr>
				
				</tbody>
					</table>
						</td>
							</tr>
			
			<input type="hidden" name="ESTIMATE_E_FILENM" value=""></input>
        	<input type="hidden" name="ESTIMATE_P_FILENM" value=""></input> 

				<tr id="Indirect_info"><!-- 발행구분에서 경유매출 선택 시 노출 -->
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
								<!-- <td><input type="text" id="" name="purchase_view" class="text text_r" title="매입원가(VAT별도)" style="width:153px;" maxlength="18"  onKeyUp = "saleCntCal2()" value="0" /> 원</td>  -->
								<td><input type="text" id="" name="purchase_view" class="text text_r" title="매입원가(VAT별도)" style="width:153px;" maxlength="18"  onBlur = "saleCntCal2()" value="0" /> 원</td>
								<th><label for="">매출이익</label></th>
								<td><input type="text" id="" name="sales_profit_view" class="text text_r dis" title="매출이익" style="width:153px;" maxlength="18"   value="0"/> 원</td>
								<th><label for="">이익율</label></th>
								<td class="last"><input type="text" name="profit_percent_view" id="" class="text text_r dis" title="이익율" style="width:161px;" value="0"/> %<input type="hidden" name="Purchase" class="in_txt"  style="width:80px" value="" /><input type="hidden" name="Sales_profit" class="in_txt"  style="width:80px" value="" /><input type="hidden" name="Profit_percent" class="in_txt"  style="width:80px" value="" /></td>
							</tr>
								
								</tbody>
							</table>
						</td>
					</tr>

			<tr>
				<th><label for="">견적서파일</label></th>
					<td>
						<ul class="listD">
							<li class="first"><div class="fileUp">EXCEL&nbsp;&nbsp;<input type="text" class="text" id="file1" title="EXCEL" style="width:810px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="estimate_e_file" id="upload1" /></div></li>
							<li><div class="fileUp">PDF&nbsp;&nbsp;<input type="text" class="text" id="file2" title="PDF" style="margin-left:14px;width:810px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="estimate_p_file" id="upload2" /></div></li>
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
			
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>수신인</label></th>
				<td><input type="text" name="receiver" id="" class="text" title="수신인" style="width:200px;" maxlength="50"/></td>
			</tr>
							
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>제목</label></th>
				<td><input type="text" name="title" id="" class="text" title="제목" style="width:917px;" maxlength="250"/></td>
			</tr>
        
			<tr>
				<th><label for="">업체명</label></th>
				
					<td><input type="checkbox" name="checkyn" id="" class="check md0" title="수동입력" onClick="javascript:directInput();"/><label for="">수동입력</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="comp_nm" id="" class="text" title="업체명" style="display:inline;width:300px;" readOnly/><input type="text" name="e_comp_nm" id="" class="text" title="업체명" style="display:none;width:300px;" onkeyup="chkNm()"/><!-- 2013_05_07(화)shbyeon. 현재 업체중복체크 사용안함.(중복된 수동입력 업체도 DB에 들어감 단 동일업체명이지만 업체코드(Comp_Code)pk 는 다름.<a href="javascript:fnDuplicateCheck();"  class="btn3"><img src="<%=request.getContextPath()%>/images/btn_dupli_confirm.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm.gif'" style="display:none;" name="e_comp_nm_se" title="중복확인" width="52" height="18" /></a> --><a href="javascript:popComp();" class="btn_type03"><span>업체조회</span></a></td>
			</tr>
          
          
						</tbody>
					</table>
				</fieldset>
      <!-- //고객정보 -->
      </div>

	<!-- 담당자정보 -->
	<div class="con_sub last">
		<h4>담당자정보</h4>
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
	
	<!-- 필수입력사항텍스트 -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
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
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>작성자</label></th>
					<td><input type="text" id="" class="text" title="작성자" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>"/></td>
			</tr>
			
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>담당영업</label></th>
					<td><input type="text" id="" name="user_nm" class="text" title="담당영업" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales();"/><a href="javascript:popSales();" class="btn_type03"><span>사원조회</span></a></td>
			</tr>     
     
 			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>수주가능성</label></th>
					<td>
				         	 <%  
				          			  CodeParam codeParam = new CodeParam();
									  codeParam = new CodeParam();
									  codeParam.setType("select"); 
									  codeParam.setStyleClass("td3");
									  //codeParam.setFirst("전체");
									  codeParam.setName("orderble");
									  codeParam.setSelected(""); 
									  //codeParam.setEvent("javascript:poductSet();"); 
									  out.print(CommonUtil.getCodeList(codeParam,"A03")); 
							  %>
					</td>
			</tr>
							
			<tr>
				<th><label for="">특이사항</label></th>
					<td><textarea id="" name="etc" title="특이사항" style="width:917px;height:41px;" onKeyUp="js_Str_ChkSub('500', this)"></textarea></td>
			</tr>
        
        
			</tbody>
		</table>
	</fieldset>
    </div>
    <!-- //담당자정보 -->
     
	<!-- 영업주관사정보 - 발행옵션에서 즉시발행 선택 시 노출 -->
	<div class="con_sub last last_display" id="sales_info">
		<h4>영업주관사정보</h4>
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
						
	<!-- 필수입력사항텍스트 -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
	<!-- //필수입력사항텍스트 -->
	
	</div>
	<!-- //컨텐츠 상단 영역 -->
	<!-- 등록 -->
	
	<fieldset>
		<legend>영업주관사정보</legend>
			<table class="tbl_type" summary="영업주관사정보(영업주관사담당자, 영업주관사담당자연락처, 고객사, 기술분야배정인력, 예상시기, 담당영업(부))">
				
				<colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>
     
		<tbody>
			
			<tr>
				<th><label for="">영업주관사담당자</label></th>
				<td><input type="text" name="SalesMan" id="" class="text" title="영업주관사담당자" style="width:200px;" maxlength="7"/></td>
			</tr>
							
			<tr>
				<th><label for="">영업주관사담당자연락처</label></th>
				<td><input type="text" id="" name="SalesManTel" maxlength="13" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);" class="text" title="영업주관사담당자연락처" style="width:200px;" /></td>
			</tr>
        
 			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>고객사</label></th>
				<td><input type="text" id="" name="OperatingCompany" class="text" title="고객사" style="width:300px;" maxlength="100"/><input type="checkbox" id="" name="chktest" value="N" class="check" title="업체명(영업주관사)명 동일선택" onclick="javascript:chkSaOperatingAdd();"/><label for="">업체명(영업주관사)명 동일선택</label></td>
			</tr>
							
			<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>기술분야배정인력</label></th>
				<td><input type="text" id="" name="AssignPerson" class="text" title="기술분야배정인력" style="width:300px;" /></td>
			</tr>      
        
       		<tr>
       			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>예상시기</label></th>
       			<input type="hidden" name="DateProjections" value=""></input>
          		<input type="hidden" name="Quarter" value=""></input>
          		
          		<td>
         			<script>
				         document.write("<select name='target_year' id='target_year' title='년도 선택' style='width:70px'>");
				          var now = new Date();  
				          var now_year = now.getFullYear() +5; //+1은 올해년도에서 +1년 한것. 
				          for (var i=now_year;i>=2010;i--) 
				          {   
				         document.write("<option value='"+i+"'>"+i+"</option>"); 
				         }  
				          document.write(" </select>"); 
			         </script> 년&nbsp;&nbsp;<select name="target_month" id="target_month" title="월 선택">
				    <option value='01'>1</option>
				    <option value='02'>2</option>
				    <option value='03'>3</option>
				    <option value='04'>4</option>
				    <option value='05'>5</option>
				    <option value='06'>6</option>
				    <option value='07'>7</option>
				    <option value='08'>8</option>
				    <option value='09'>9</option>
				    <option value='10'>10</option>
				    <option value='11'>11</option>
				    <option value='12'>12</option>
					</select> 월</td>
       	</tr>
       
	 		<tr>
				<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>담당영업(부)</label></th>
					<td>
						<input type="text" id="" name="user_nm2" class="text" title="담당영업(부)" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>" onClick="javascript:popSales();"/><a href="javascript:popSales_Second();" class="btn_type03"><span>사원조회</span></a></td>
			</tr>         
							
			</tbody>
				</table>
					</fieldset>
      </div>
      <!-- //영업진행현황 정보 -->
   	</form>
    <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>등록</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
    <!-- //button -->
 
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