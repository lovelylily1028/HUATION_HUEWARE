<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	String strDate = (String)model.get("strDate");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>법인통장관리 등록</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript">

	<!--
	/*
	 * 중복체크
	 */
	function doCheck(AccountNumber){
		
		var requestUrl='<%= request.getContextPath() %>/B_BankManage.do?cmd=AcNumCheck&AccountNumber='+AccountNumber;
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

	//계좌번호 check 
	function fnDuplicateCheck() {
		var frm = document.bankmanageRegist; 
		
		if(frm.AccountNumber.value.length == 0){
			alert("계좌번호를 입력하세요");
			return;
		}
		
		var result=doCheck(frm.AccountNumber.value);
		
		if(result==1){
			alert("이미 등록된 계좌번호입니다. 다른 계좌번호를 사용해주세요.");
			
			if(alert){
				
			frm.AccountNumber.focus();
			}
			
			return;
			
				
		}else if(result==2){
			alert("삭제 이력이 있는 계좌번호 입니다");
			return;
		}else {
			if( confirm("사용 가능한 계좌번호 입니다. 사용하시겠습니까?") ) {
				frm.AccountNumber.readOnly = true;	
			} else {
				frm.AccountNumber.readOnly = false;	
			}
		}
	}

	function goSave(){
		var frm = document.bankmanageRegist; 
		
		
		var dates = frm.NewDate.value;
		var NewDates = dates.replace(/-/g,'');
		frm.pYear1.value = NewDates.substr(0,4);
		frm.pMonth1.value = NewDates.substr(4,2);
		frm.pDay1.value = NewDates.substr(6,2);
		
		frm.NewDate.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;

		
		var dates = frm.ReturnDate.value;
		var ReturnDates = dates.replace(/-/g,'');
		frm.pYear5.value =ReturnDates.substr(0,4);
		frm.pMonth5.value = ReturnDates.substr(4,2);
		frm.pDay5.value = ReturnDates.substr(6,2);

		
		frm.ReturnDate.value = frm.pYear5.value +frm.pMonth5.value +frm.pDay5.value;
		
		var dates = frm.RegistrationDate.value;
		var RegistrationDates = dates.replace(/-/g,'');
		frm.pYear7.value = RegistrationDates.substr(0,4);
		frm.pMonth7.value = RegistrationDates.substr(4,2);
		frm.pDay7.value = RegistrationDates.substr(6,2);
		
		frm.RegistrationDate.value = frm.pYear7.value +frm.pMonth7.value +frm.pDay7.value;
		
		
		
		
		
		
		//실제파일명 \\기준으로잘라서 마지막문자열부터+1씩 붙여strFileName넣기
		var strFile = frm.BankBookFile.value;
		
		var lastIndex = strFile.lastIndexOf('\\');
		var strFileName= strFile.substring(lastIndex+1);
		
		if(fileCheckNm(strFileName)> 200){
			alert('200자(byte)이상의 글자(파일명)는/은 등록 할 수 없습니다.');
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
		
		if(frm.BankCode.value == ""){
			alert("금융기관을 선택하세요");
			return;
		}
		if(!frm.AccountNumber.readOnly){
			alert("계좌번호가 중복되는지 확인하세요");
			return;
		}
		if(frm.AccountNumber.value == ""){
			alert("계좌번호를 입력하세요");
			return;
		}
		if(frm.BankBook.value == ""){
			alert("통장(재)발행점 을 입력하세요");
			return;
		}
		if(frm.AccountManage.value == ""){
			alert("계좌관리점(신규점) 입력하세요.");
			return;
		}
		
		if(frm.BankBookFile.value == ""){
			alert("통장사본을 첨부하세요.");
			return;
		}
		if(frm.BankBookFile.value != "" && !isImageFile(frm.BankBookFile.value)){
				alert("통장사본의  첨부 가능한 파일 유형은 \n PDF, GIF, JPG, TIF, BMP 이상 5종 입니다.");
				return; 				
		}
		frm.NewDate.value = frm.pYear1.value+'-'+frm.pMonth1.value+'-'+frm.pDay1.value;
		frm.ReturnDate.value = frm.pYear5.value+'-'+frm.pMonth5.value+'-'+frm.pDay5.value;
		frm.RegistrationDate.value = frm.pYear7.value+'-'+frm.pMonth7.value+'-'+frm.pDay7.value;
		
		frm.Registration.value = frm.user_id.value;
		frm.BankBookFileNm.value = strFileName;
		frm.submit();
	}


	/*
	 *특수문자 불가check
	 */ 
	function inputCheckSpecial(){
		var strobj = document.bankmanageRegist.CustomerNum;
		re =/[.,~!@\#$%^&*\()\-=+_{}\|;"":'`/]/;
		if(re.test(strobj.value)){
			alert("고객번호는  영문 대소문자, 숫자를 이용해 주세요.");
			strobj.value=strobj.value.replace(re,"");
		}
		
	}


	function compNocheck(){
		   
		   var frm=document.bankmanageRegist;
		   var AcNumCheck=frm.AccountNumber;
		   if(AcNumCheck.value.length>0){
				if (!isNumber(trim(AcNumCheck.value))) {
					alert("계좌번호는 (-)제외한 숫자만 입력이 가능합니다.");
					AcNumCheck.value=onlyNum(AcNumCheck.value);
				} 
		   }
	
		}

	/**
	 * 이미지  파일 확장자명 체크
	 *
	 **/
	function isImageFile( obj ) {
		var strIdx = obj.lastIndexOf( '.' ) + 1;
		if ( strIdx == 0 ) {
			return false;
		} else {
			var ext = obj.substr( strIdx ).toLowerCase();
			if ( ext == "pdf" || ext == "gif" || ext == "jpg" || ext == "tif"|| ext == "bmp") {
				return true;
			} else {
				return false;
			}
		}
	}


	function cancle(){
		
		var frm = document.bankmanageRegist;
		frm.action='<%= request.getContextPath()%>/B_BankManage.do?cmd=bankPageList';
		frm.submit();

	}
	
	
	function codeMapping(val){
		
		document.getElementById("codebookId").value=val;
		(val != "")? document.frm : location.href = "<%= request.getContextPath()%>/B_BankManage.do?cmd=bankRegistForm";
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
		<div class="content_navi">총무지원 &gt; 법인통장관리</div>
		<h3><span>법</span>인통장등록</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
		<!-- title -->
		
		<div class="con">
			<!-- 컨텐츠 상단 영역 -->
			<div class="conTop_area">
				
			<!-- 필수입력사항텍스트 -->
				<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
			<!-- //필수입력사항텍스트 -->
			
			</div>
			<!-- //컨텐츠 상단 영역 --> 
	
			<div id="excelBody">
				<form name="bankmanageRegist" method="post" action="<%= request.getContextPath()%>/B_BankManage.do?cmd=bankManageRegist" enctype="multipart/form-data">
			     <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
				 <input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>"/>
				 <input type = "hidden" name = "Registration" value=""/>
				
				  <input type = "hidden" name = "pYear1" value=""/>
    			 <input type = "hidden" name = "pMonth1" value=""/>
  				   <input type = "hidden" name = "pDay1" value=""/>

 			     <input type = "hidden" name = "pYear5" value=""/>
 	   			 <input type = "hidden" name = "pMonth5" value=""/>
   				  <input type = "hidden" name = "pDay5" value=""/>

    			  <input type = "hidden" name = "pYear7" value=""/>
    			 <input type = "hidden" name = "pMonth7" value=""/>
   				  <input type = "hidden" name = "pDay7" value=""/>
				 
				 
				 
				 
				 
			
				<fieldset>
					<legend>법인통장등록</legend>
					<table class="tbl_type" summary="법인통장등록(금융기관, 계좌번호, 신규일(개설일), (재)발행일, 통장(재)발행점, 계좌관리점(신규점), 고객번호, 등록일, 등록자, 통장사본, 계좌특이사항)">
						
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
					
					         <tr>
					         		<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>금융기관</label></th>
									<td title="금융기관선택">
										
										<%
												CodeParam codeParam = new CodeParam();
												codeParam.setType("select"); 
												codeParam.setStyleClass("td3");
												codeParam.setFirst("전체");
												codeParam.setName("BankCode");
												codeParam.setSelected(""); 
												codeParam.setEvent("javascript:codeMapping(this.value);"); 
												out.print(CommonUtil.getCodeListHanSeq(codeParam,"P01")); 
											%>
								
								<input type="text" name="codebookId" class="text dis" id="codebookId" value="" readonly="readonly" style="width:30px;"></input><span class="guide_txt">&nbsp;&nbsp;* 왼쪽 공백 란은 금융기관의 코드 공식번호를 나타냅니다.</span></td>
					
					         </tr>
					 						
					 		<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계좌번호</label></th>
									<td><input type="text" name="AccountNumber" id="" class="text" title="계좌번호" style="width:200px;"  maxlength="30" onKeyUp ="compNocheck()"/><a href="javascript:fnDuplicateCheck();" class="btn_type03"><span>중복확인</span></a><span class="guide_txt">&nbsp;&nbsp;* ( - )없이 숫자만 입력하세요.</span></td>
							</tr>      
					  					
					  		<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신규일(개설일)</label></th>
								<td>
								<span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;" name="NewDate" value="<%=strDate%>"/></span>
								<input type="hidden" class="in_txt" value=""></input></td>
							</tr>
											
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>(재)발행일</label></th>
								<td><span class="ico_calendar"><input id="calendarData2" class="text" style="width:100px;" name="ReturnDate" value="<%=strDate%>"/></span>
								<input type="hidden" value=""></input></td>
							</tr>     
					
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>통장(재)발행점</label></th>
								<td><input type="text" name="BankBook" id="" class="text" maxlength="50"  title="통장(재)발행점" style="width:300px;" /></td>
							</tr>
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계좌관리점(신규점)</label></th>
								<td><input type="text" name="AccountManage" id="" class="text" title="계좌관리점(신규점)" style="width:300px;" maxlength="50"/></td>
							</tr>
					
							<tr>
								<th><label for="">고객번호</label></th>
								<td><input type="text" name="CustomerNum" id="" class="text" title="고객번호" style="width:200px;" maxlength="50" onKeyUp = "inputCheckSpecial()"/></td>
							</tr>
							
							<tr>
								<th><label for="">등록일</label></th>
								<td><span class="ico_calendar"><input id="calendarData3" class="text" style="width:100px;" readOnly name="RegistrationDate" value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" /></span>
								<input type="hidden" value=""></input> </td>
							</tr>
					
							<tr>
								<th><label for="">등록자</label></th>
								<td><input type="text" id="" class="text dis" title="고객번호" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>"/></td>
							</tr>
								
							<tr>
								<th><input type="hidden" name="BankBookFileNm" value=""></input>
								<label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>통장사본</label></th>
								<td><div class="fileUp"><input type="text" class="text" id="file1" title="통장사본" style="width:465px;" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="BankBookFile" id="upload1" /></div><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : PDF, GIF, JPG, TIF, BMP, PNG / 첨부가능 용량 : 최대 10M</span></td>
							</tr>
											
							<tr>
								<th><label for="">계좌특이사항</label></th>
								<td><textarea id="" name="AccountIssue" title="계좌특이사항" style="width:916px;height:41px;" onKeyUp="js_Str_ChkSub('600', this)"></textarea></td>
							</tr>
								
						</tbody>
					</table>
				</fieldset>
				</form>
				<!-- //등록 -->
		   
				<!-- button -->
			   	<div class="Bbtn_areaC">
			   		<a href="javascript:goSave();" class="btn_type02"><span>등록</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>취소</span></a>
			   	</div>
				<!-- //button -->
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
</html>

<%= comDao.getMenuAuth(menulist,"01")%>
<script type="text/javascript">fn_fileUpload();</script>