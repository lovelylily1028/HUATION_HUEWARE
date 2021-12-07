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
<%@ page import="com.huation.common.currentstatus.CurrentStatusDTO" %>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%@ page import="com.huation.common.user.UserBroker"%>
<%@ page import="java.util.*" %>
<%@ page import ="java.text.SimpleDateFormat" %>

<%

	Map model = (Map)request.getAttribute("MODEL");
	String curPage = (String)model.get("curPage");
	CurrentStatusDTO csDto = (CurrentStatusDTO)model.get("csDto");			//영업진행현황 상세보기DTO 
	CurrentStatusDTO csDtoPro = (CurrentStatusDTO)model.get("csDtoPro");	//영업진행현황 상품코드ArrDTO
																			//별도의 객체 셋팅 및 생성을 해줘야 값 제대로 가져옴.
	//상품코드 Arr 모델로 객체로 꺼낸다 codeList로.
	ArrayList codeList = (ArrayList)model.get("codeList"); //자사 상품코드
	ArrayList codeList2 = (ArrayList)model.get("codeList2"); //비자사(내수)상품코드
	ArrayList codeList3 = (ArrayList)model.get("codeList3"); //비자사(외수)상품코드
	ArrayList productList = (ArrayList)model.get("productList"); //상품코드 Array List 가지고 있는 데이터
	
	
	//금일 년/월/일 가져오기.
	String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>영업진행현황 상세정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css"></link>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script language="javascript">
<!--

//전화번호 숫자 입력시 체크 후 - 생성 2013_05_03(금)shbyeon.
function MaskPhon( obj ) { 

	 obj.value =  PhonNumStr( obj.value ); //벨류값 있을시 PhonNumStr function 실행.

} 



//전화번호 숫자 입력시 체크 후 - 생성 2013_05_03(금)shbyeon.
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


	//이슈코멘트 등록하기
	function goSaveRep(){
	
	var frm=document.currentCommentIframe;
	

	if(frm.SalesMan_co.value == ""){
		alert("이슈코멘트 입력시 이슈 재기자 및 내용은 반드시 입력하셔야 합니다.");
		return;
	}
	if(frm.Contents.value == ""){
		alert("이슈코멘트 입력시 이슈 재기자 및 내용은 반드시 입력하셔야 합니다."); 
		return;
	}
	
	if(confirm("이슈 코멘트를 등록하시겠습니까?")){
		
	//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
	var strFile = frm.SalesFile.value;
	//alert(strFile);
		
	var lastIndex = strFile.lastIndexOf('\\');
	//alert(lastIndex);
	var strFileName= strFile.substring(lastIndex+1);
	//alert(strFileName);
	if(fileCheckNm(strFileName)> 200){
		alert('200자(byte)이상의 글자(파일명)는/은 등록 할 수 없습니다.');
			return;
	}
	
	
	frm.action='<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaComment&ProjectPkCo=<%=csDto.getPreSalesCode()%>';
	frm.target='hiddenframe';
	frm.submit();
	document.getElementByTagName('frm')[0].reset();
	
	}
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
	var preview = "";
	
	
	//이슈코멘드 등록 성공 후 currentCommentResult.jsp 받은  AddView 값으로 
	//새로운 iframe jsp페이지 즉  등록 폼 생성 시켜주면서 디폴트값 초기화.
	function AddView(makeview) {
		//alert(makeview);
		
		document.all("MakeView").innerHTML = "";
		makeview = makeview + preview;
		preview = makeview;
		
	   //이슈코멘드 등록 성공 후에 currentCommentResult.jsp iframe 페이지의 값 Add 시 초기화 시키기.
	   document.all("MakeView").insertAdjacentHTML("beforeEnd",makeview);
	   document.currentCommentIframe.SalesMan_co.value='';
	   document.currentCommentIframe.Contents.value='';
	   document.currentCommentIframe.SalesFileNm.value='';
	   //input file <<파일 객체는 value 초기화를 할수 없다. html상 readonly값으로 되있기 때문.
	   //초기화 방법은 select();객체를 사용하여 해당 selection.clear()로 초기화가능.
	   document.currentCommentIframe.SalesFile.select();
	   document.selection.clear();  
		
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
		
	
	//이슈 코멘트 삭제
	function goDeleteRep(ComentPk){
		var frm = eval('document.currentCommentIframe_'+ComentPk);
		
		if(confirm("삭제 하시겠습니까?")){
			
			var requestUrl='<%= request.getContextPath() %>/B_CurrentStatus.do?cmd=comentDeleteResult&ComentPk='+ComentPk;
			var msg='';
			var ComentPk ='';
			
			var xmlhttp = null;
			var xmlObject = null;
			var resultText = null;
	
	
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
			xmlhttp.open("GET", requestUrl, false);
			xmlhttp.send(requestUrl);
	
			resultText = xmlhttp.responseText;
	
			xmlObject = new ActiveXObject("Microsoft.XMLDOM");
			xmlObject.loadXML(resultText);
			ComentPk=xmlObject.documentElement.childNodes.item(0).text;
			msg=xmlObject.documentElement.childNodes.item(1).text;
			alert(msg);
			if(msg == '삭제에  성공하였습니다'){
				
				//$('#displayDiv').hide();
				
			}
	
		}
	
	}

	//이슈 코멘트 수정
	function goUpdateRep(ComentPk){
		var frm = eval('document.currentCommentIframe_'+ComentPk);
		//$('[name=SalesMan_co_updel'+ComentPk+']').val();
		//alert($('[name=SalesMan_co_updel'+ComentPk+']').val());
		
		if(frm.SalesMan_co.value == ""){
			alert("고객사를 입력하세요.");
			return;
		}
		if(frm.Contents.value == ""){
			alert("내용을 입력하세요."); 
			return;
		}
		if(confirm("수정 하시겠습니까?")){
			
			//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
			var strFile = frm.SalesFile.value;
			
			var lastIndex = strFile.lastIndexOf('\\');
			//alert(lastIndex);
			var strFileName= strFile.substring(lastIndex+1);
			//alert(strFileName);
			if(fileCheckNm(strFileName)> 200){
				alert('200자(byte)이상의 글자(파일명)는/은 등록 할 수 없습니다.');
				return;
			}
			
			frm.action='<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaCommentUp&ProjectPkCo=<%=csDto.getPreSalesCode()%>';
			frm.target = 'hiddenframe';
			frm.SalesFileNm.value = strFileName;
			frm.ComentPk.value = ComentPk;
			frm.submit(); 
		}
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

	function goSave(){
		
		var frm = document.currentStaEdit;
		
		//상품코드 체크
		var NoCode = $('#NoCode').length;
		
		if(confirm("수정 하시겠습니까?")){
			frm.action='<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaEdit';
		if(frm.checkyn.checked!=true){
			if(frm.comp_code.value.length == 0){
				alert("영업주관사(업체명)을/를 선택하세요!");
				return;
			}
		}else{
			if(frm.e_comp_nm.value.length == 0){
				alert("영업주관사(업체명)을/를 입력하세요!");
				return;
			}
		}	

	/*
	2013_05_06(월)shbyeon. 중복체크 사용안하므로 현재 사용안함.
	if(frm.checkyn.checked==true){
		if(frm.e_comp_nm.value!=frm.trueflag.value){
			alert("영업주관사가(업체명) 중복되는지 확인하세요.");
			return;
		}
	}
	*/
	
	/*
	기존 상품코드 체크박스 사용했을때 벨류데이션 체크.
	if(document.getElementById("pcbox01").checked == false && document.getElementById("pcbox02").checked == false
	   && document.getElementById("pcbox03").checked == false && document.getElementById("pcbox04").checked == false
	   && document.getElementById("pcbox05").checked == false && document.getElementById("pcbox06").checked == false
	   && document.getElementById("pcbox07").checked == false && document.getElementById("pcbox08").checked == false
	   && document.getElementById("pcbox11").checked == false && document.getElementById("pcbox12").checked == false
	   && document.getElementById("pcbox13").checked == false && document.getElementById("pcbox14").checked == false
	   && document.getElementById("pcbox15").checked == false && document.getElementById("pcbox16").checked == false
	   && document.getElementById("pcbox17").checked == false && document.getElementById("pcbox18").checked == false){
		alert("자사 또는 내수 상품코드를 선택해주세요."); 
		return;
	}
	*/
	
	//NoCode < jQuery 함수
	//alert(NoCode);
	if(NoCode == 1){
		alert("상품코드를 넣어주세요.")	;
		return;
	}
	
	if(frm.OperatingCompany.value == ""){
		alert("고객사를 입력하세요."); 
		return;
	}
	if(frm.ProjectName.value == ""){
		alert("예상 프로젝트명을 입력하세요."); 
		return;
	}
	if(frm.Orderble.value == ""){
		alert("수주가능성을 선택하세요."); 
		return;
	}
	if(frm.ChargeID.value == ""){
		alert("담당영업(정)을 선택하세요."); 
		return;
	}
	if(frm.AssignPerson.value == ""){
		alert("기술분야 배정인력을 입력하세요."); 
		return;
	}
	//분기 체크후 분기별 데이터 셋팅
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
    
    //업체코드가  있다면 업체코드명을 셋팅.
    if(frm.permit_no.value.length != 0){
		frm.e_comp_nm.value=frm.comp_nm.value
	}
	frm.DateProjections.value=frm.target_year.value+'.'+frm.target_month.value;
	frm.ChargeID.value=frm.user_id.value;
	frm.ChargeSecondID.value=frm.user_id2.value;

	frm.submit();
	}
}
		

	/*
	 * int 가격 체크 000, 계산하여 끊어준뒤 콤마 표시
	 */
	 function saleCntCal(form){
		
		    var v_obj;
			var obj;
			var veiwfrm=eval("document."+form+'_view');
			var frm=eval("document."+form);
			var costobj=document.currentStaEdit;
	
			if(frm.length>1){
				v_obj=veiwfrm[index];
				obj=frm[index];
			}else{
				v_obj=veiwfrm;
				obj=frm;
		
			}
		
			if (!isNumber(trim(v_obj.value))) {
				alert("0~9 정수(숫자)만 입력해 주세요.");
			} 
			
			
			var num=onlyNum(v_obj.value);
			v_obj.value = addCommaStr(num);
			obj.value = num;
			
			if(form=='currentStaEdit.SalesProjections'){	
				var price=parseInt(onlyNum(costobj.SalesProjections.value)*1,10);
				costobj.SalesProjections.value=addCommaStr(''+SalesProjections);
			    costobj.SalesProjections.value=SalesProjections;	    
			    
			}
			v_obj.focus();
		}
 
	
	function popComp(){

		var obj=document.currentStaEdit;
		
		if(obj.checkyn.checked==true){
				alert('수동입력 선택을 해제후 업체조회 하시기 바랍니다.');
				return;
		}else{
			var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchComp&sForm=currentStaEdit","","width=850,height=652,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
		}
	}
	
	
	//수동입력 체크 판단 후 입력창 활성화여부.
	 function directInput(){

		    var obj=document.currentStaEdit;
		    if(obj.checkyn.checked==true){
				
				if(confirm("수동입력으로 변경하시겠습니까?")){
					obj.e_comp_nm.style.display='inline'
					//obj.e_comp_nm_se.style.display='inline' 2013_05_02(목) shbyeon. 중복체크 사용안함.
					obj.comp_nm.style.display="none";
					obj.comp_nm.value='';
					obj.comp_code.value='';
					obj.permit_no.value='';
				}else{
					obj.checkyn.checked=false;
				}
			}else{

				if(confirm("선택입력으로 변경하시겠습니까?")){
					obj.e_comp_nm.style.display='none'
					//obj.e_comp_nm_se.style.display='none' 2013_05_02(목) shbyeon. 중복체크 사용안함.
					obj.comp_nm.style.display="inline";
					obj.e_comp_nm.value=''; //수동입력 업체명 초기화
					obj.comp_nm.value='';  //업체조회 업체명 초기화
				}else{
					obj.checkyn.checked=true;
				}


			}

		}
	
	 <%--
	   중복체크(공통)
	  2013_05_02(목) shbyeon 현재사용안함.
	 function doCheck(e_comp_nm){
	 	
	 	var requestUrl='<%= request.getContextPath() %>/B_Common.do?cmd=CompNameCheck&e_comp_nm='+e_comp_nm;
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
	
	//업체중복확인 check 2013_03_26(화)shbyeon.
	 function fnDuplicateCheck() {
		
	 	var frm = document.currentStaEdit; 
	 	
	 	
	 	if(frm.e_comp_nm.value.length == 0){
	 		alert("원청사를 입력하세요.");
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
	 			frm.trueflag.value  =  frm.e_comp_nm.value ;	
	 		} else {
	 			frm.falseflag.value =  frm.e_comp_nm.value;	
	 		}
	 	}
	 }
	 --%>
	
	//JQuery - 상품코드 마우스로 데이터 넘겨주기.
	$(function() {
		//alert($('#cart ol li').length);
		var cartLen = $('#cart ol li').length;
		var test = $('#cart ol li').map(function(){
			return $(this).attr("id");
		});
		
		for(var x=0; x<cartLen; x++){
			$('#products #'+test.get(x)).hide();
			//alert(test.get(x));	
		}
		
		$( "#catalog" ).accordion();
		
		  $("#products li").dblclick(function(){
			  
			  $('#NoCode').remove(); //상품코드 추가 시 Cart<li>에 있는  상품코드를 넣어주세요. text 지우기.
			  $(this).hide(); //상품코드 선택시 해당 상품코드 hide 숨기기.
		    
		    $('#cart ol').append("<li id="+$(this).attr("id")+" ondblclick=\"delCode('"+$(this).attr("id")+"')\" style=\"cursor: pointer;\">"+"<a>"+$(this).html()+"</a>"+"<input type='hidden' name='ProductCode' id='ProductCode' value="+$(this).attr("id")+"></li>");
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
		var frm = document.currentStaEdit; 

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
	
	<%--
	현재 사용안함.
	2013_05_02(목)shbyeon.
	function openComment(){
		var str = "";
		str += "<tr>";
		str += "<th>날짜</th>";
		str += "<td>2012-03-03</td>";
		str += "<td rowspan=\"3\"><textarea rows=\"4\" style=\"ime-mode:active;width:600px; height:65px;padding:5px\" dispName=\"영업진행현황 코멘트\"></textarea> </td>";
		str += "<td rowspan=\"3\"><img src=\"<%= request.getContextPath()%>/images/ico_down.gif\" width=\"16\" height=\"16\" align=\"absmiddle\" title=\"첨부파일\"></td>";
		str += "</tr>";
		str += "<tr>";
		str += "<th>작성자</th>";
		str += "<td>변수현</td>";
		str += "</tr>";
		str += "<tr>";
		str += "<th>고객사</th>";
		str += "<td><input type=\"text\" name=\"SalesMan\"></td>";
		str += "</tr>";
	
		
   		$('#CommentTb').append(str);
	}
	--%>

	
		//영업진행현황 목록으로.
		function goList(){
			var frm = document.currentStaEdit;
			location.href='<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaPageList';
		}
	
		//영입진행현황 목록삭제.
		function goDelete(){
			
			var frm = document.currentStaEdit;
			if(confirm("삭제 하시겠습니까?")){
				frm.action='<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaDelete';
				frm.submit();
			}

		}
		
		//사원조회 첫 번째	
		function popSales(){
				var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser&sForm=currentStaEdit","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
		}
		//사원조회 두 번째
		function popSales_Second(){
			var a = window.open("<%= request.getContextPath()%>/B_Common.do?cmd=searchUser2&sForm=currentStaEdit","","width=600,height=619,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");
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
	<div class="content_navi">영업지원 &gt; 영업진행현황</div>
	<h3><span>영</span>업진행현황상세정보</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 --v>
  <!-- //title -->

	<div class="con currentStaRegistForm">
	<!-- 영업진행현황상세정보 -->
	<div>
	<h4 class="hidden_obj">영업진행현황상세정보</h4>
		
	<!-- 컨텐츠 상단 영역 -->
	<div class="conTop_area">
	
	<!-- 필수입력사항텍스트 -->
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
	<!-- //필수입력사항텍스트 -->
	
	</div>
	<!-- //컨텐츠 상단 영역 -->
	

	<!-- 등록 -->
  <div id="excelBody">
    <form name="currentStaEdit" method="post" action="<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaEdit">
     <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
	  <!-- 업체조회팝업 창에서 넘겨서 받아올 값. 업체코드만 DB에 저장되있으므로 가져오면된다. -->
	  <input type = "hidden" name = "comp_code" value="<%=csDto.getEnterpriseCode()%>"/>
	  <!-- 업체조회팝업 창에서 넘어오는 값 name설정. -->
      <input type = "hidden" name = "owner_nm" value=""/>
      <input type = "hidden" name = "business" value=""/>
      <input type = "hidden" name = "b_item" value=""/>
      <input type = "hidden" name = "post" value=""/>
      <input type = "hidden" name = "address" value=""/>
      <input type = "hidden" name = "addr_detail" value=""/>
      <input type = "hidden" name = "EnterpriseCode" value="<%=csDto.getEnterpriseCode()%>"/>
      <input type = "hidden" name = "permit_no" value="<%=csDto.getPermitNo()%>"/>
      <input type = "hidden" name = "PreSalesCode" value="<%=csDto.getPreSalesCode()%>"/>
      <input type = "hidden" name="OrderStatus" value="<%=csDto.getOrderStatus() %>"></input>
      <input type = "hidden" name="PublicNo" value="<%=csDto.getPublicNo() %>"></input>
      <input type = "hidden" name="P_PublicNo" value="<%=csDto.getP_PublicNo() %>"></input>
      <input type = "hidden" name="SalesFile_Xls" value="<%=csDto.getSalesFile_Xls() %>"></input>
      <input type = "hidden" name="SalesFileNm_Xls" value="<%=csDto.getSalesFileNm_Xls() %>"></input>
      <input type = "hidden" name="SalesFile_Pdf" value="<%=csDto.getSalesFile_Pdf() %>"></input>
      <input type = "hidden" name="SalesFileNm_pdf" value="<%=csDto.getSalesFileNm_Pdf() %>"></input>
      <input type = "hidden" name = "user_id" value="<%=csDto.getChargeID()%>"></input>
      <input type = "hidden" name = "user_id2" value="<%=csDto.getChargeSecondID()%>"></input>
      <!-- 담당영업 (정) -->
      <input type = "hidden" name = "ChargeID" value = "<%=csDto.getChargeID()%>"></input>
      <!-- 담당영업 (부) -->
      <input type = "hidden" name = "ChargeSecondID" value = "<%=csDto.getChargeSecondID()%>"></input>
      
      
      <!-- 중복체크 플래그 -->
      <input type="hidden" name="trueflag" value="true"></input>
      <input type="hidden" name="falseflag" value="false"></input>
      
	<fieldset>
	<legend>영업진행현황상세정보</legend>
	<table class="tbl_type" summary="영업진행현황상세정보(영업주관사, 영업주관사담당자, 영업주관사담당자연락처, 상품코드(자사/내자), 고객사, 예상프로젝트명, 예상수주액(VAT별도), 수주가능성, 담당영업, 기술분야배정인력, 예상시기)">
		
		<colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
        
        <%
        String OrderStatus  = csDto.getOrderStatus();
        if(OrderStatus.equals("N")){        	
        %>
   
            <%
            
            	//수동입력 체크 부분 2013_05_09(목)shbyeon.
				String permit=StringUtil.nvl(csDto.getPermitNo(),"");
            	System.out.println("PERMIT:"+permit);
				String checkedyn="";
				String acomp="inline";
				String bcomp="none";

				if(permit != ""){
					checkedyn="";
                    acomp="inline";
					bcomp="none";
				}else{
					checkedyn="checked";
                    acomp="none";
					bcomp="inline";
				}
			%>
          
      <tbody>
        <tr>
        	<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>영업주관사</label></th>
			<td><input type="checkbox" name="checkyn" <%=checkedyn %> onClick="javascript:directInput();" id="" class="check md0" title="수동입력" /><label for="">수동입력</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" maxlength="100" name="comp_nm" title="영업주관사" class="text" style="display:<%=acomp %>;width:300px;" value="<%=csDto.getEnterpriseNm() %>" readOnly><input type="text" name="e_comp_nm" title="영업주관사" class="text" style="display:<%=bcomp %>;ime-mode:active;width:300px;" value="<%=csDto.getEnterpriseNm() %>"><!-- 2013_05_02(목)shbyeon. 현재사용안함.<a href="javascript:fnDuplicateCheck();" class="btn3"><img src="<%=request.getContextPath()%>/images/btn_dupli_confirm.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm.gif'" style="display:none;" name="e_comp_nm_se" title="중복확인" width="52" height="18" /></a> --><a href="javascript:popComp();" class="btn_type03"><span>업체조회</span></a></td>
		</tr>
							
		<tr>
			<th><label for="">영업주관사담당자</label></th>
			<td><input type="text" name="SalesMan" value="<%=csDto.getSalesMan() %>"  id="" class="text" title="영업주관사담당자" style="width:200px;" maxlength="7"/></td>
		</tr>
							
		<tr>
			<th><label for="">영업주관사담당자연락처</label></th>
			<td><input type="text" id="" name="SalesManTel" value="<%=csDto.getSalesManTel() %>"   maxlength="13" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);" class="text" title="영업주관사담당자연락처" style="width:200px;" /></td>
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
		       							<li id="<%=codeDto.getCode() %>" style="cursor: pointer;"><a><%=codeDto.getName() %></a>
		       							</li>
		       					<%
		       						}
		       					%>
						</ul>

						<h6><a href="#none">비자사(내자)</a></h6>
							<ul><!-- 코드 비활성화 class="display_none" 추가 -->
								
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
							<ul><!-- 코드 비활성화 class="display_none" 추가 -->
								<li><a href="#none">Avaya PBX</a></li>
								
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
								<%
									
		       						for(int x=0; x<productList.size(); x++){
		       							csDtoPro = new CurrentStatusDTO();
		       							csDtoPro = (CurrentStatusDTO)productList.get(x);
		       					%>
		       							<li id="<%=csDtoPro.getProductCode() %>" ondblclick="delCode('<%=csDtoPro.getProductCode() %>')" style="cursor: pointer;"><a><%=csDtoPro.getProductName() %></a>
		       							<input type='hidden' name='ProductCode' id='ProductCode' value="<%=csDtoPro.getProductCode()%>">
		       							
		       							</li>
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
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>고객사</label></th>
			<td><input type="text" id="" name="OperatingCompany" value="<%=csDto.getOperatingCompany() %>" class="text" title="고객사" style="width:300px;" maxlength="25"/><input type="checkbox" id="" name="chktest" value="N" class="check" onclick="javascript:chkSaOperatingAdd();" title="영업주관사명 동일선택 " /><label for="">영업주관사명 동일선택 </label></td>
		</tr>
							
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>예상프로젝트명</label></th>
			<td><input type="text" id="" name="ProjectName" value="<%=csDto.getProjectName() %>" class="text" title="예상프로젝트명" style="width:300px;" maxlength="50" /></td>
		</tr>         
         
		<tr>
			<th><label for="">예상수주액(VAT별도)</label></th>
			<td><input type="hidden" name="SalesProjections"  style="width:80px" value="<%=csDto.getSalesProjections()%>" maxlength="13" /><input type="text" id="" name="SalesProjections_view" value="<%=NumberUtil.getPriceFormat(csDto.getSalesProjections())%>" maxlength="13" class="text text_r" title="예상수주액(VAT별도)" style="width:200px;" onKeyUp = "saleCntCal('currentStaEdit.SalesProjections')"/> 원</td>
		</tr>
        
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>수주가능성</label></th>
          		<td title="수주가능성선택"><%  
					  CodeParam codeParam = new CodeParam();
          			  codeParam.setType("select"); 
          			  codeParam.setStyleClass("td3");
					  codeParam.setFirst("전체");
					  codeParam.setName("Orderble");
					  codeParam.setSelected(csDto.getOrderble()); 
					  //codeParam.setEvent("javascript:poductSet();"); 
					  out.print(CommonUtil.getCodeList(codeParam,"A03")); 
			  																%></td>
	  </tr>
		
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>담당영업</label></th>
			<td>정&nbsp;&nbsp;<input type="text" name="user_nm" id="" class="text" title="담당영업 정" style="width:100px;" readOnly value="<%=csDto.getChargeNm()%>" onClick="javascript:popSales();"/><a href="javascript:popSales();" class="btn_type03"><span>사원조회</span></a>&nbsp;&nbsp;/&nbsp;&nbsp;부&nbsp;&nbsp;<input type="text" name="user_nm2" id="" class="text" title="담당영업 부" style="width:100px;" readOnly value="<%=csDto.getChargeSeNm()%>" onClick="javascript:popSales_Second();"/><a href="javascript:popSales_Second();" class="btn_type03"><span>사원조회</span></a>
			<%--
			 <%
			 	String ChargeID = csDto.getChargeID();
			 	String ChargeSecondID = csDto.getChargeSecondID();
			 %>
			  --%> 
			  </td>
		</tr>
							
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>기술분야배정인력</label></th>
			<td><input type="text" id="" name="AssignPerson" value="<%=csDto.getAssignPerson() %>" class="text" title="기술분야배정인력" style="width:300px;" maxlength="25" /></td>
		</tr>

        <tr>
          	<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>예상시기</label></th>
          	<input type="hidden" name="DateProjections" value=""></input>
          	<input type="hidden" name="Quarter" value=""></input>
         
        	<td>
		         <%
		         		//예상시기DTO Substring 으로 2013.03 2013/03 나눠서 Select Option으로 가져오기.
		         			String TargetMonth=StringUtil.nvl(csDto.getDateProjections(),"2013.04");
							int indexxs=TargetMonth.indexOf("2013.04");
							String target_year = TargetMonth.substring(0,4); //subString ("자를글자수","보여질 글자수")
							String target_month = TargetMonth.substring(5,7);
		         %>
         
		         <script>
		         document.write("<select name='target_year' id='target_year' title='년도 선택' style='width:70px'>");
		          var now = new Date();  
		          var now_year = now.getFullYear() +5; //+1은 올해년도에서 +1년 한것.
		          for (var i=now_year;i>=2010;i--) 
		          {   
		         document.write("<option value='"+i+"'>"+i+"</option>"); 
		         }  
		          document.write(" </select>"); 
		         </script> 년&nbsp;&nbsp;<select name="target_month" id="target_month" title="월 선택" style="width:60px">
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
								
<!-- script 실행. -->	
<script>
//select option값 Dto값체크후 동일한 목록 선택(상세보기사용)
document.currentStaEdit.target_year.value='<%=target_year%>';
document.currentStaEdit.target_month.value='<%=target_month%>';
</script>
<!-- script 실행 끝. -->
  
  <%
   }else{	   
  %>
     <!-- comp_nm == EnterpriseNm 
          comp_comd == EnterpriseCode
     -->
            <%
				String comp_code=StringUtil.nvl(csDto.getEnterpriseCode(),"");
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
			%>
        	<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>영업주관사</label></th>
			<td><%-- <input type="checkbox" name="checkyn" <%=checkedyn %> onClick="javascript:directInput();" id="" class="check md0" title="수동입력" /><label for="">수동입력</label>&nbsp;&nbsp;&nbsp;&nbsp; --%><input type="text" maxlength="100" name="comp_nm" class="text" style="display:<%=acomp %>;width:300px;" value="<%=csDto.getEnterpriseNm() %>" readonly="readonly"/><input type="text" name="e_comp_nm" class="text" style="display:<%=bcomp %>;ime-mode:active;width:300px;" value="<%=csDto.getEnterpriseNm() %>" readonly="readonly"/><!-- 2013_05_02(목)shbyeon. 현재사용안함. <a href="javascript:fnDuplicateCheck();" class="btn3"><img src="<%=request.getContextPath()%>/images/btn_dupli_confirm.gif" onmouseover="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm_on.gif'" onmouseout="this.src='<%= request.getContextPath()%>/images/btn_dupli_confirm.gif'" style="display:none;" name="e_comp_nm_se" title="중복확인" width="52" height="18" /></a> --><!-- <input type="text" id="" class="text" title="영업주관사" style="width:300px;" /><a href="javascript:popComp();" class="btn_type03"><span>업체조회</span></a> --></td>
		</tr>
							
		<tr>
			<th><label for="">영업주관사담당자</label></th>
			<td><input type="text" name="SalesMan" value="<%=csDto.getSalesMan() %>"  id="" class="text" title="영업주관사담당자" style="width:200px;" maxlength="7" readonly="readonly"/></td>
		</tr>
							
		<tr>
			<th><label for="">영업주관사담당자연락처</label></th>
			<td><input type="text" id="" name="SalesManTel" value="<%=csDto.getSalesManTel() %>"   maxlength="13" onkeydown="MaskPhon(this);" onkeyup="MaskPhon(this);" class="text" title="영업주관사담당자연락처" style="width:200px;" readonly="readonly"/></td>
		</tr>
 
		<tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>상품코드(자사/내자)</label></th>
       <td class="prodCode">
			<div id="cart">
				<h5>상품코드</h5>

					<ol>
								<%
									
		       						for(int x=0; x<productList.size(); x++){
		       							csDtoPro = new CurrentStatusDTO();
		       							csDtoPro = (CurrentStatusDTO)productList.get(x);
		       					%>
		       							<li id="NoCode" ><%=csDtoPro.getProductName() %>
		       							<input type='hidden' name='ProductCode' id='ProductCode' value="<%=csDtoPro.getProductCode()%>" readonly="readonly">
		       							<!-- 
		       							<a href="javascript:delCode('<%=csDtoPro.getProductCode() %>');" name='del' title='Delete' class='ui-icon ui-icon-refresh'></a>
		       							 -->
		       							</li>
		       					<%
		       						}
		       					%>

					</ol>
				</div>
				
				<div class="guide">
					<span class="guide_txt"><strong>* 자사상품코드 또는 내자상품코드 둘중 하나는 선택해주세요.</strong><br />
					 <strong>* 계약이 완료된 영업진행현황입니다.</strong><br />* 계약이 완료된 영업진행현황 모든 입력창은 수정 및 삭제가 불가능합니다.</span>
				</div>
			</td>
		</tr>
			
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>고객사</label></th>
			<td><input type="text" id="" name="OperatingCompany" value="<%=csDto.getOperatingCompany() %>" class="text" title="고객사" style="width:300px;" maxlength="25" readonly="readonly"/><input type="checkbox" id="" name="chktest" value="N" class="check" onclick="javascript:chkSaOperatingAdd();" title="영업주관사명 동일선택 " /><label for="">영업주관사명 동일선택 </label></td>
		</tr>
							
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" readonly="readonly"/></span>예상프로젝트명</label></th>
			<td><input type="text" id="" name="ProjectName" value="<%=csDto.getProjectName() %>" class="text" title="예상프로젝트명" style="width:300px;" maxlength="50" /></td>
		</tr>  			
        
		<tr>
			<th><label for="">예상수주액(VAT별도)</label></th>
			<td><input type="hidden" name="SalesProjections"  style="width:80px" value="<%=csDto.getSalesProjections()%>" maxlength="13"  readonly="readonly"/><input type="text" id="" name="SalesProjections_view" value="<%=NumberUtil.getPriceFormat(csDto.getSalesProjections())%>" maxlength="13" class="text text_r" title="예상수주액(VAT별도)" style="width:200px;" onKeyUp = "saleCntCal('currentStaEdit.SalesProjections')"readonly="readonly" /> 원</td>
		</tr>

		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>수주가능성</label></th>
          		<td><input type="hidden" name="Orderble" class="text" value="<%=csDto.getOrderble() %>"></input>
          		<input type="text" name="OrderbleNm" class="text" value="<%=csDto.getOrderbleNm() %>" style="ime-mode:active;width:200px" readonly="readonly"></input></td>
        </tr>
          
        <tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>담당영업</label></th>
			<td>정&nbsp;&nbsp;<input type="hidden" name="ChargeID" class="in_txt_off" value="<%=csDto.getChargeID() %>" readonly="readonly"></input><input type="text" name="ChargeNm" id="" class="text" title="담당영업 정" style="width:100px;" value="<%=csDto.getChargeNm() %>" readonly="readonly"/>&nbsp;&nbsp;/&nbsp;&nbsp;부&nbsp;&nbsp;<input type="hidden" name="ChargeSecondID" class="in_txt_off" value="<%=csDto.getChargeSecondID() %>" readonly="readonly"></input><input type="text" name="ChargeSecondNm" id="" class="text" title="담당영업 부" style="width:100px;" value="<%=csDto.getChargeSeNm() %>" readonly="readonly"/></td>
		</tr>
          
		  
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>기술분야배정인력</label></th>
			<td><input type="text" id="" name="AssignPerson" value="<%=csDto.getAssignPerson() %>" class="text" title="기술분야배정인력" style="width:300px;" maxlength="25" readonly="readonly"/></td>
		</tr>

        <tr>
          	<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>예상시기</label></th>
          	<!-- 미계약일때 Substring 했을때 사용함.
          	<input type="hidden" name="DateProjections"  value=""></input> -->
          	<input type="hidden" name="Quarter" value=""></input>
         <td >
         <!-- 
        	<input type="hidden" name="DateProjections" value="<%=csDto.getDateProjections() %>"></input>
          -->
        	<input type="text" name="DateProjections" class="text" value="<%=csDto.getDateProjections() %>" style="width:200px;" readonly="readonly"></input></td>
        </tr>
        
  <%
   }
  %>
  				</tbody>
        	</table>
        </fieldset>
    </form>
    
    <%if(OrderStatus.equals("N")){ %>
    <!-- Bottom 버튼영역 -->
	<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>수정</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>삭제</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a></div>
	<!-- //Bottom 버튼영역 -->
    <%
    }else{    	
    %>
    <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a></div>
   <!-- //button -->
    <%
    }
    %>
</div>
</div>
<div class="issueComm">
	<h4>Issue Comment</h4>
	<form name="currentCommentIframe" method="post" action="<%= request.getContextPath() %>/B_CurrentStatus.do?cmd=currentCommentIframe" enctype="multipart/form-data">
		
		<fieldset>
		<legend>Issue Comment</legend>
		
		<%
		String ID = UserBroker.getUserId(request); //로그인 한 세션 ID
		String NAME = UserBroker.getUserNm(request); //로그인 한 세션 이름
		%>
		
		<!-- 해당 이슈 코멘트 없을때 아래 초기 등록 폼 시작-->
		<!-- 이슈 코멘트 등록 후 해당 이슈 코멘트 페이지로 가기위한 Hidden 값  Action 으로 넘겨주기. -->
		<input type="hidden" name="PreSalesCode" value="<%=csDto.getPreSalesCode() %>"></input>
	
	<!-- 이슈등록폼 -->
	<div class="issueCon_area">	
		
		<ul class="info">			
			<li><label for="">이슈 재기자 :</label> <input type="text" id="" name="SalesMan_co" class="text" title="이슈 재기자" style="width:100px;" maxlength="10"/></li>
			<!-- 로그인 세션 ID 담당영업 파라미터 넘겨줘서 등록시 데이터 도 DB등록. -->
			<li><span>담당영업 : <%=NAME %></span></li>
			<li><span>등록일 : <%=todayDate %></span></li>			
		</ul>

		<ul class="issueCon">
			<li><textarea id="" name="Contents" title="이슈내용" style="width:1078px;height:50px;" onKeyUp="js_Str_ChkSub('500', this)"></textarea></li>
			<li><div class="fileUp"><input type="text" class="text" id="file1" title="첨부파일" style="width:1015px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="SalesFile" id="upload1" /></div></li>
			<input type="hidden" name="SalesFileNm" value=""></input>
			<li class="btn_regist"><a href="javascript:goSaveRep();">등록</a></li>
			
			<!-- 수정/삭제 버튼
			<p class="btn_editComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_edit_curr.gif" onclick="javascript:goSaveRep();" title="수정버튼" /></a></p>
			<p class="btn_deleteComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_delete_curr.gif" onclick="javascript:goSaveRep();" title="삭제버튼" /></a></p>
			 -->
			
			<li><span class="guide_txt">* 첨부가능 파일유형 : 모든 파일 / 첨부가능 용량 : 최대 200M</span></li>
		</ul>
	</div>
		

		</fieldset>
</form> 
	
	<div id="MakeView"  ></div>  	
		<%
		//리스트 가져오기 시작.
		ListDTO ld = (ListDTO) model.get("listInfo");
		DataSet ds = (DataSet) ld.getItemList();
		
		int iTotCnt = ld.getTotalItemCount(); //총데이터수
		int iCurPage = ld.getCurrentPage();	//현재페이지수
		int iDispLine = ld.getListScale();
		int startNum = ld.getStartPageNum();
		%>
		
		 <!-- :: loop :: -->
        <!--리스트---------------->
     
     <%
     	//영업진행현황에 등록된 pk 와 Issue Comment Pk 가 같으면서 데이터 있을시 아래 List실행.
     	
     	String pjc = csDto.getProjectPkCo();	 //코멘트 매핑(영업진행현황==코멘트) pk
     	String pj  = csDto.getPreSalesCode();	 //영업진행현황 pk
     	
     	if(pjc.equals("") == pj.equals("")){		
     %>
        <%
                if (ld.getItemCount() > 0) {
                    
                	int i = 0;
                	
                    while (ds.next()) {
                    	//System.out.println("TEST:"+ds.getString("CreateDate"));
            %>
	            <%
	             //코멘트 글쓴이 세션 체크 후 수정/삭제 여부 활성화 및 비활성화
	             if(UserBroker.getUserId(request).equals(ds.getString("ChargeID_co"))){
	            	 
	            %>
		
		<!-- 코멘트 수정 폼. -->
		<form name="currentCommentIframe_<%=ds.getString("ComentPk") %>"  method="post" action="<%= request.getContextPath() %>/B_CurrentStatus.do?cmd=currentCommentIframe" enctype="multipart/form-data">
		<input type="hidden" name="ComentPk" value=""></input>
		
		
		<div id="displayDiv" name="displayDiv"  class="issueCon_area">
		<fieldset>
		<ul class="info">
			<li><label for="">이슈 재기자 :</label> <input type="text" name="SalesMan_co" value="<%=ds.getString("SalesMan_co") %>" id="" class="text" title="이슈 재기자" style="width:100px;" maxlength="10" readonly="readonly"/></li>
			<!-- 로그인 세션 ID 담당영업 파라미터 넘겨줘서 수정/삭제시 DB 데이터 이력 ID 남김. -->
			<input type="hidden" name="ChargeID_co" value="<%=ID %>"></input>
			<li><span>담당영업 :  <%=ds.getString("ChargeNm") %></span></li>
			<li><span>등록일 : <%=ds.getString("CreateDate") %></span></li>
			
			<%
				
             String SalesFile=ds.getString("SalesFile"); //실제파일경로
             String SalesFileNm=ds.getString("SalesFileNm");
              
//              String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
             //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
			String serverUrl = "" + request.getContextPath();				
              int c_index=SalesFile.lastIndexOf("/"); // /기준으로 경로자르기.
            	
              String salesfilename=SalesFile.substring(c_index+1); // /기준으로 자른 문자열1개씩 합치기
        
              String salespath=""; //파일경로 읽어오기
             
              	
    
              if(!SalesFile.equals("")){
            	  salespath=SalesFile.substring(0,c_index); //파일경로 읽어오기
            	
            	//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
              	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
              	String spStrReplace = "";
              	if(SalesFileNm.indexOf("&") != -1){
              		spStrReplace=  SalesFileNm.replace("&", "[replaceStr]");
              	System.out.println("spStrReplace:"+spStrReplace);
              	}else{
              		spStrReplace =  SalesFileNm;	
              	System.out.println("spStrReplace:"+spStrReplace) ;
              	}
				%>
				<li class="btn"><a id="SfilePath_<%=ds.getString("ComentPk") %>" href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=salesfilename%>&filePath=<%=salespath%>" class="btn_type03" ><span>첨부파일다운로드</span></a></li>
            	<%
                     }
               
                %>
		</ul>

		<ul class="issueCon">
			<li><textarea id="" name="Contents" title="이슈내용" style="width:1078px;height:50px;" onKeyUp="js_Str_ChkSub('3000', this)" readonly="readonly" ><%=ds.getString("Contents") %></textarea></li>
		</ul>
				
			
			<!-- 
			<p class="btn_saveComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_reg_save_curr.gif" onclick="javascript:goSaveRep();" title="등록버튼" /></a></p>
			 -->
			<!-- 수정/삭제 버튼
			<p class="btn_editComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_edit_curr.gif" onclick="javascript:goUpdateRep('<%=ds.getString("ComentPk") %>');" title="수정버튼" /></a></p>
			<p class="btn_deleteComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_delete_curr.gif" onclick="javascript:goDeleteRep('<%=ds.getString("ComentPk") %>');" title="삭제버튼" /></a></p>
			 -->
		</fieldset>
		</div>
		</form>
		<%
	             }else{	            	 
        %>
        
        <!-- 코멘트 수정 폼. -->
		<form name="currentCommentIframe_<%=ds.getString("ComentPk") %>"  method="post" action="<%= request.getContextPath() %>/B_CurrentStatus.do?cmd=currentCommentIframe" enctype="multipart/form-data">
		<input type="hidden" name="ComentPk" value=""></input>
		<div id="displayDiv" name="displayDiv" class="issueCon_area">
		<legend>Issue Comment</legend>
		<fieldset>
		<ul class="info">
			<!-- 다른 로그인사용자 일때 -->
			<li><label for="">이슈 재기자 :</label> <input type="text" name="SalesMan_co" value="<%=ds.getString("SalesMan_co") %>" id="" class="text" title="이슈 재기자" style="width:100px;" maxlength="10" readonly="readonly"/></li>
			<!-- 로그인 세션 ID 담당영업 파라미터 넘겨줘서 수정/삭제시 DB 데이터 이력 ID 남김. -->
			<input type="hidden" name="ChargeID_co" value="<%=ID %>"></input>
			<li><span>담당영업 : <%=ds.getString("ChargeNm") %></span></li>
			<li><span>등록일 : <%=ds.getString("CreateDate") %></span></li>
			
			<%
				
             String SalesFile=ds.getString("SalesFile"); //실제파일경로
             String SalesFileNm=ds.getString("SalesFileNm");
              
//              String serverUrl = "https://" + request.getServerName() + ":" + request.getServerPort()+request.getContextPath();
             //String serverUrl = "http://" + request.getServerName() + ":8088" +request.getContextPath();
			String serverUrl = "" + request.getContextPath();
              int c_index=SalesFile.lastIndexOf("/"); // /기준으로 경로자르기.
            	
              String salesfilename=SalesFile.substring(c_index+1); // /기준으로 자른 문자열1개씩 합치기
        
              String salespath=""; //파일경로 읽어오기
             
              	
    
              if(!SalesFile.equals("")){
            	  salespath=SalesFile.substring(0,c_index); //파일경로 읽어오기	
            	  
            		//파일명에 (&) 값이 있을 시 해당 문자열 전부 ([replaceStr]) 치환
                	//Descript: get방식으로 파일 서블릿을 통해 파라미터 전달 시 rFileName 명에 & 가 들어가 면 파라미터를 넘기는 걸로 인식하여 한글 파일명 값을 제대로 가져오지 못함.
                	String spStrReplace = "";
                	if(SalesFileNm.indexOf("&") != -1){
                		spStrReplace=  SalesFileNm.replace("&", "[replaceStr]");
                	System.out.println("spStrReplace:"+spStrReplace);
                	}else{
                		spStrReplace =  SalesFileNm;	
                	System.out.println("spStrReplace:"+spStrReplace) ;
                	}
				%>
				<li class="btn"><a id="SfilePath_<%=ds.getString("ComentPk") %>" href="<%=serverUrl %>/fileDownServlet?rFileName=<%=spStrReplace%>&sFileName=<%=salesfilename%>&filePath=<%=salespath%>" class="btn_type03"><span>첨부파일다운로드</span></a></li>
            	<%
                     }
               
                %>
		</ul>

		<ul class="issueCon">
			<li><textarea name="Contents" style="ime-mode:active;width:1078px;height:50px;"  title="코멘트 입력" dispName="내용" onKeyUp="js_Str_ChkSub('3000', this)" readonly="readonly"><%=ds.getString("Contents") %></textarea></li>
        </ul>
			<!-- 
			<p class="btn_saveComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_reg_save_curr.gif" onclick="javascript:goSaveRep();" title="등록버튼" /></a></p>
			 -->
			<!-- 수정/삭제 버튼
			<p class="btn_editComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_edit_curr.gif" onclick="javascript:goUpdateRep('<%=ds.getString("ComentPk") %>');" title="수정버튼" /></a></p>
			<p class="btn_deleteComm"><a href="#"><img src="<%= request.getContextPath()%>/images/btn_delete_curr.gif" onclick="javascript:goDeleteRep('<%=ds.getString("ComentPk") %>');" title="삭제버튼" /></a></p>
			 -->
		
		</fieldset>
		</div>
		</form>
	          <%
	             }
	          %>

		  <!-- :: loop :: -->
		        <%   
		        i++;
		        %>   
        <%
              }
           }	
     	}
        %>
        
        
 
</div>
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
	<iframe name="hiddenframe" frameBorder=0 width="0" height="0" ></iframe> 
</html>
<%= comDao.getMenuAuth(menulist,"10") %>
<script type="text/javascript">fn_fileUpload();</script>