<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.bankmanage.BankManageDTO" %>

<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	BankManageDTO bmDto = (BankManageDTO)model.get("bmDto");
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>법인통장관리 상세정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript">
<!--

	function goSave(){
		var frm = document.bankmanageView; 
		alert(bmDto.getBankName());
		
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

	  if(confirm("수정하시겠습니까?")){
		  frm.action='<%=request.getContextPath()%>/B_BankManage.do?cmd=bankManageEdit'
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
	
		
		if(frm.BankBookFile.value != "" && !isImageFile(frm.BankBookFile.value)){
				alert("통장사본의  첨부 가능한 파일 유형은 \n PDF, GIF, JPG, TIF, BMP 이상 5종 입니다.");
				return; 				
		}
		
		frm.Registration.value = frm.user_id.value;
		
		if(strFileName!=''){
			
		frm.BankBookFileNm.value = strFileName;
		}
		
		frm.submit();
	  }	
	}

	/*
	 *특수문자 불가check
	 */ 
	function inputCheckSpecial(){
		var strobj = document.bankmanageView.CustomerNum;
		re =/[.,~!@\#$%^&*\()\-=+_{}\|;"":'`/]/;
		if(re.test(strobj.value)){
			alert("고객번호는  영문 대소문자, 숫자를 이용해 주세요.");
			strobj.value=strobj.value.replace(re,"");
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

	//목록
	function goList(){
		
		var frm = document.bankmanageView;
		frm.action='<%= request.getContextPath()%>/B_BankManage.do?cmd=bankPageList2';
		frm.submit();
	}
	
	//삭제
	function goDelete(){
		
		var frm = document.bankmanageView;
		if(confirm("삭제 하시겠습니까?")){
			frm.action='<%= request.getContextPath()%>/B_BankManage.do?cmd=bankManageDelete';
			frm.submit();
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
  
	<div class="content_navi">총무지원 &gt; 법인통장관리</div>
	<h3><span>법</span>인통장상세정보</h3>
	
	<div class="con">
	<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
					
	<!-- 필수입력사항텍스트 -->
		<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
	<!-- //필수입력사항텍스트 -->
				
		</div>
	<!-- //컨텐츠 상단 영역 --
  
  <!-- con -->
  <div id="excelBody" class="con">
    <form name="bankmanageView" method="post" action="<%= request.getContextPath()%>/B_BankManage.do?cmd=bankManageEdit" enctype="multipart/form-data">
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
		<legend>법인통장상세정보</legend>
	 <table class="tbl_type" summary="법인통장상세정보(금융기관, 계좌번호, 신규일(개설일), (재)발행일, 통장(재)발행점, 계좌관리점(신규점), 고객번호, 등록일, 등록자, 통장사본, 계좌특이사항)">
			
			<colgroup>
				<col width="20%" />
				<col width="*" />
			</colgroup> 	  
     
     <tbody> 
     	<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>금융기관</label></th>
			<td><input type="text" id="" name="BankName" class="text dis" title="금융기간" style="width:200px;" maxlength="30" value="<%=bmDto.getBankName() %>" readonly="readonly"/><input type="hidden" name="BankCode" value="<%=bmDto.getBankCode()%>"></input><span class="guide_txt">&nbsp;&nbsp;* 현재 금융기관 공식 코드번호 <strong>(<%=bmDto.getBankCode()%>)</strong></span></td><!-- input 비활성화 class="dis" 추가 -->
		</tr>
						
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계좌번호</label></th>
			<td><input type="text" name="AccountNumber" id="" class="text dis" title="계좌번호" style="width:200px;"  maxlength="30" value="<%=bmDto.getAccountNumber() %>" readonly="readonly"/></td><!-- input 비활성화 class="dis" 추가 -->
		</tr>
        
     	<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신규일(개설일)</label></th>
			<td><span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;" name="NewDate" value="<%=bmDto.getNewDate()%>"/></span><input type="hidden" value="<%=bmDto.getNewDate()%>"></input></td>
		</tr>
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>(재)발행일</label></th>
			<td><span class="ico_calendar"><input id="calendarData2" class="text" style="width:100px;" name="ReturnDate" value="<%=bmDto.getReturnDate()%>"/></span><input type="hidden" value="<%=bmDto.getReturnDate()%>"></input></td>
		</tr>  
	
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>통장(재)발행점</label></th>
			<td><input type="text" name="BankBook" value="<%=bmDto.getBankBook()%>" id="" class="text" title="통장(재)발행점" style="width:300px;"maxlength="50" /></td>
		</tr>
						
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>계좌관리점(신규점)</label></th>
			<td><input type="text" name="AccountManage" value="<%=bmDto.getAccountManage()%>" id="" class="text" title="계좌관리점(신규점)" style="width:300px;" maxlength="50"/></td>
		</tr>

		<tr>
			<th><label for="">고객번호</label></th>
			<td><input type="text" name="CustomerNum" value="<%=bmDto.getCustomerNum()%>" id="" class="text" title="고객번호" style="width:200px;" maxlength="50" onKeyUp = "inputCheckSpecial()"/></td>
		</tr>
						
		<tr>
			<th><label for="">등록일</label></th>
			<td><span class="ico_calendar"><input id="calendarData3" class="text" style="width:100px;" name="RegistrationDate" value="<%=bmDto.getRegistrationDate()%>" readOnly/></span><input type="hidden" value="<%=bmDto.getRegistrationDate()%>"></input></td><!-- input 비활성화 class="dis" 추가 -->
		</tr>
 
		<tr>
			<th><label for="">등록자</label></th>
			<td><input type="text" id="" class="text dis" title="고객번호" style="width:200px;" readOnly value="<%=bmDto.getRegistrationName()%>"/></td><!-- input 비활성화 class="dis" 추가 -->
		</tr>
						
		<tr>
			<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>통장사본</label></th>
			<td><div class="fileUp"><input type="text" class="text" id="file1" title="통장사본" style="width:465px;" value="<%=bmDto.getBankBookFile() %>" /><a href="#link" class="btn_type03" value="찾아보기"><span>찾아보기</span></a><input type="file" name="BankBookFile" id="upload1" /></div><input type="hidden" name="BankBookFileNm" value="<%=bmDto.getBankBookFileNm()%>"></input><span class="guide_txt">&nbsp;&nbsp;* 첨부가능 파일유형 : PDF, GIF, JPG, TIF, BMP, PNG / 첨부가능 용량 : 최대 10M</span></td>
		</tr>
        
		<tr>
			<th><label for="">계좌특이사항</label></th>
			<td><textarea name="AccountIssue" id="" title="계좌특이사항" style="width:916px;height:41px;"onKeyUp="js_Str_ChkSub('600', this)"><%=bmDto.getAccountIssue()%></textarea></td>
		</tr>
				
				</tbody>
			</table>
		</fieldset>
    </form>
   
   <!-- button -->
    <div class="Bbtn_areaC">
    	<a href="javascript:goSave();" class="btn_type02"><span>수정</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>삭제</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a>
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