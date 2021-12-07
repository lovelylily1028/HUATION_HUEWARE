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
<title>����������� ���</title>
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
	 * �ߺ�üũ
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

	//���¹�ȣ check 
	function fnDuplicateCheck() {
		var frm = document.bankmanageRegist; 
		
		if(frm.AccountNumber.value.length == 0){
			alert("���¹�ȣ�� �Է��ϼ���");
			return;
		}
		
		var result=doCheck(frm.AccountNumber.value);
		
		if(result==1){
			alert("�̹� ��ϵ� ���¹�ȣ�Դϴ�. �ٸ� ���¹�ȣ�� ������ּ���.");
			
			if(alert){
				
			frm.AccountNumber.focus();
			}
			
			return;
			
				
		}else if(result==2){
			alert("���� �̷��� �ִ� ���¹�ȣ �Դϴ�");
			return;
		}else {
			if( confirm("��� ������ ���¹�ȣ �Դϴ�. ����Ͻðڽ��ϱ�?") ) {
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
		
		
		
		
		
		
		//�������ϸ� \\���������߶� ���������ڿ�����+1�� �ٿ�strFileName�ֱ�
		var strFile = frm.BankBookFile.value;
		
		var lastIndex = strFile.lastIndexOf('\\');
		var strFileName= strFile.substring(lastIndex+1);
		
		if(fileCheckNm(strFileName)> 200){
			alert('200��(byte)�̻��� ����(���ϸ�)��/�� ��� �� �� �����ϴ�.');
			return;
		}

		
	//���ϸ� ���ڼ�(byte) üũ		
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
			alert("��������� �����ϼ���");
			return;
		}
		if(!frm.AccountNumber.readOnly){
			alert("���¹�ȣ�� �ߺ��Ǵ��� Ȯ���ϼ���");
			return;
		}
		if(frm.AccountNumber.value == ""){
			alert("���¹�ȣ�� �Է��ϼ���");
			return;
		}
		if(frm.BankBook.value == ""){
			alert("����(��)������ �� �Է��ϼ���");
			return;
		}
		if(frm.AccountManage.value == ""){
			alert("���°�����(�ű���) �Է��ϼ���.");
			return;
		}
		
		if(frm.BankBookFile.value == ""){
			alert("����纻�� ÷���ϼ���.");
			return;
		}
		if(frm.BankBookFile.value != "" && !isImageFile(frm.BankBookFile.value)){
				alert("����纻��  ÷�� ������ ���� ������ \n PDF, GIF, JPG, TIF, BMP �̻� 5�� �Դϴ�.");
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
	 *Ư������ �Ұ�check
	 */ 
	function inputCheckSpecial(){
		var strobj = document.bankmanageRegist.CustomerNum;
		re =/[.,~!@\#$%^&*\()\-=+_{}\|;"":'`/]/;
		if(re.test(strobj.value)){
			alert("����ȣ��  ���� ��ҹ���, ���ڸ� �̿��� �ּ���.");
			strobj.value=strobj.value.replace(re,"");
		}
		
	}


	function compNocheck(){
		   
		   var frm=document.bankmanageRegist;
		   var AcNumCheck=frm.AccountNumber;
		   if(AcNumCheck.value.length>0){
				if (!isNumber(trim(AcNumCheck.value))) {
					alert("���¹�ȣ�� (-)������ ���ڸ� �Է��� �����մϴ�.");
					AcNumCheck.value=onlyNum(AcNumCheck.value);
				} 
		   }
	
		}

	/**
	 * �̹���  ���� Ȯ���ڸ� üũ
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
		<div class="content_navi">�ѹ����� &gt; �����������</div>
		<h3><span>��</span>��������</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
		<!-- title -->
		
		<div class="con">
			<!-- ������ ��� ���� -->
			<div class="conTop_area">
				
			<!-- �ʼ��Է»����ؽ�Ʈ -->
				<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
			<!-- //�ʼ��Է»����ؽ�Ʈ -->
			
			</div>
			<!-- //������ ��� ���� --> 
	
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
					<legend>����������</legend>
					<table class="tbl_type" summary="����������(�������, ���¹�ȣ, �ű���(������), (��)������, ����(��)������, ���°�����(�ű���), ����ȣ, �����, �����, ����纻, ����Ư�̻���)">
						
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
					
					         <tr>
					         		<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�������</label></th>
									<td title="�����������">
										
										<%
												CodeParam codeParam = new CodeParam();
												codeParam.setType("select"); 
												codeParam.setStyleClass("td3");
												codeParam.setFirst("��ü");
												codeParam.setName("BankCode");
												codeParam.setSelected(""); 
												codeParam.setEvent("javascript:codeMapping(this.value);"); 
												out.print(CommonUtil.getCodeListHanSeq(codeParam,"P01")); 
											%>
								
								<input type="text" name="codebookId" class="text dis" id="codebookId" value="" readonly="readonly" style="width:30px;"></input><span class="guide_txt">&nbsp;&nbsp;* ���� ���� ���� ��������� �ڵ� ���Ĺ�ȣ�� ��Ÿ���ϴ�.</span></td>
					
					         </tr>
					 						
					 		<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���¹�ȣ</label></th>
									<td><input type="text" name="AccountNumber" id="" class="text" title="���¹�ȣ" style="width:200px;"  maxlength="30" onKeyUp ="compNocheck()"/><a href="javascript:fnDuplicateCheck();" class="btn_type03"><span>�ߺ�Ȯ��</span></a><span class="guide_txt">&nbsp;&nbsp;* ( - )���� ���ڸ� �Է��ϼ���.</span></td>
							</tr>      
					  					
					  		<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ű���(������)</label></th>
								<td>
								<span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;" name="NewDate" value="<%=strDate%>"/></span>
								<input type="hidden" class="in_txt" value=""></input></td>
							</tr>
											
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>(��)������</label></th>
								<td><span class="ico_calendar"><input id="calendarData2" class="text" style="width:100px;" name="ReturnDate" value="<%=strDate%>"/></span>
								<input type="hidden" value=""></input></td>
							</tr>     
					
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����(��)������</label></th>
								<td><input type="text" name="BankBook" id="" class="text" maxlength="50"  title="����(��)������" style="width:300px;" /></td>
							</tr>
							<tr>
								<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���°�����(�ű���)</label></th>
								<td><input type="text" name="AccountManage" id="" class="text" title="���°�����(�ű���)" style="width:300px;" maxlength="50"/></td>
							</tr>
					
							<tr>
								<th><label for="">����ȣ</label></th>
								<td><input type="text" name="CustomerNum" id="" class="text" title="����ȣ" style="width:200px;" maxlength="50" onKeyUp = "inputCheckSpecial()"/></td>
							</tr>
							
							<tr>
								<th><label for="">�����</label></th>
								<td><span class="ico_calendar"><input id="calendarData3" class="text" style="width:100px;" readOnly name="RegistrationDate" value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" /></span>
								<input type="hidden" value=""></input> </td>
							</tr>
					
							<tr>
								<th><label for="">�����</label></th>
								<td><input type="text" id="" class="text dis" title="����ȣ" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>"/></td>
							</tr>
								
							<tr>
								<th><input type="hidden" name="BankBookFileNm" value=""></input>
								<label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����纻</label></th>
								<td><div class="fileUp"><input type="text" class="text" id="file1" title="����纻" style="width:465px;" /><a href="#link" class="btn_type03" value="ã�ƺ���"><span>ã�ƺ���</span></a><input type="file" name="BankBookFile" id="upload1" /></div><span class="guide_txt">&nbsp;&nbsp;* ÷�ΰ��� �������� : PDF, GIF, JPG, TIF, BMP, PNG / ÷�ΰ��� �뷮 : �ִ� 10M</span></td>
							</tr>
											
							<tr>
								<th><label for="">����Ư�̻���</label></th>
								<td><textarea id="" name="AccountIssue" title="����Ư�̻���" style="width:916px;height:41px;" onKeyUp="js_Str_ChkSub('600', this)"></textarea></td>
							</tr>
								
						</tbody>
					</table>
				</fieldset>
				</form>
				<!-- //��� -->
		   
				<!-- button -->
			   	<div class="Bbtn_areaC">
			   		<a href="javascript:goSave();" class="btn_type02"><span>���</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>���</span></a>
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