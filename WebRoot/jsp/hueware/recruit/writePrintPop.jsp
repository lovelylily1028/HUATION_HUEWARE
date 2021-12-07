<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="java.util.*"%> 
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.recruit.DefaultDTO"%> 
<%@ page import ="com.huation.common.recruit.HistoryDTO"%>
<%@ page import ="com.huation.common.recruit.LicenseDTO"%>
<%@ page import ="com.huation.common.recruit.AwardDTO"%>
<%@ page import ="com.huation.common.recruit.LangDTO"%>
<%@ page import ="com.huation.common.recruit.FamilyDTO"%>
<%@ page import ="com.huation.common.recruit.CareerDTO"%>
<%@ page import ="com.huation.common.recruit.EduDTO"%>
<%@ page import ="com.huation.common.recruit.ActiveDTO"%>
<%@ page import ="com.huation.common.recruit.TrainDTO"%>
<%@ page import ="com.huation.common.recruit.ProjectDTO"%>
<%@ page import ="com.huation.common.recruit.IntroDTO"%>

<%
	Map model = (Map)request.getAttribute("MODEL"); 
	CodeParam codeParam=null;
	
	//Step1
	DefaultDTO defaultDto  = (DefaultDTO)model.get("defaultDto");
	//Step2
	ArrayList<HistoryDTO> arrlist = (ArrayList)model.get("historyList");
	//Step3
	ArrayList<LicenseDTO> arrlist2 = (ArrayList)model.get("licenseList");
	//Step4
	ArrayList<AwardDTO> arrlist3 = (ArrayList)model.get("awardList");
	//Step5
	ArrayList<LangDTO> arrlist4 = (ArrayList)model.get("langList");
	//Step6
	ArrayList<FamilyDTO> arrlist5 = (ArrayList)model.get("familyList");
	//Step7
	ArrayList<CareerDTO> arrlist6 = (ArrayList)model.get("careerList");
	//Step8
	ArrayList<EduDTO> arrlist7 = (ArrayList)model.get("eduList");
	//Step9
	ArrayList<ActiveDTO> arrlist8 = (ArrayList)model.get("activeList");
	//Step10
	ArrayList<TrainDTO> arrlist9 = (ArrayList)model.get("trainList");
	//Step11
	ArrayList<ProjectDTO> arrlist10 = (ArrayList)model.get("projectList");
	//Step12
	IntroDTO introDto = (IntroDTO)model.get("introDto");
	
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
	
	String[] r_field = StringUtil.getTokens(defaultDto.getRecruit_field(), "|");
	String career = StringUtil.nvl(defaultDto.getCareer(),"");
	
	String acheckd="";
	String bcheckd="";
	String ccheckd="";
	String dcheckd="";
	String echeckd="";
	String fcheckd="";
	String gcheckd="";
	String hcheckd="";
	String icheckd="";

	for(int i=0;i<r_field.length; i++){

		if(r_field[i].equals("01")){
			acheckd="checked";
		}else if(r_field[i].equals("02")){
			bcheckd="checked";
		}else if(r_field[i].equals("03")){
			ccheckd="checked";
		}else if(r_field[i].equals("04")){
			dcheckd="checked";
		}else if(r_field[i].equals("05")){
			echeckd="checked";
		}else if(r_field[i].equals("06")){
			fcheckd="checked";
		}else if(r_field[i].equals("07")){
			gcheckd="checked";
		}else if(r_field[i].equals("08")){
			hcheckd="checked";
		}else if(r_field[i].equals("09")){
			icheckd="checked";
		}
	}

%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<title>Copyright �� HUATION Corp. All rights reserved.</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script>


document.onkeydown = function() {
	if (event.keyCode == 116) {
		event.keyCode = 505;
	}
	if (event.keyCode == 505) {
		return false;
	}
}
/*
*	���̺� row �߰�(Step2)
*/
function doAddRowData(history_code,school_nm,start_ym,grad_ym,major,credit,grad_gb){

	defaultText.style.display='none';

	
	//�������� Select Option Chk
	var grad_gb_selected = "";
	if(grad_gb == "01"){
		grad_gb_selected = "����";
	}else if(grad_gb == "02"){
		grad_gb_selected = "��������";
	}else if(grad_gb == "03"){
		grad_gb_selected = "����";
	}else if(grad_gb == "04"){
		grad_gb_selected = "����";
	}else if(grad_gb == "05"){
		grad_gb_selected = "����";
	}else if(grad_gb == "06"){
		grad_gb_selected = "����/����";
	}
	
	
	var rowCnt = contentId.rows.length;

	var newRow = contentId.insertRow( rowCnt++ );
	newRow.onmouseover=function(){contentId.clickedRowIndex=this.rowIndex};
	
	var newCell = newRow.insertCell();
	 newCell.innerHTML = '<table class="tbl_type tbl_type_list"><colgroup><col width="*" /><col width="14%" /><col width="14%" /><col width="23%" /><col width="10%" /><col width="10%" /></colgroup><tbody><tr><td><input type="hidden" name="seqs">'+school_nm+'</td><td>'+addYmFormatDefault(start_ym)+'</td><td>'+addYmFormatDefault(grad_ym)+'</td><td>'+major+'</td><td>'+credit+'</td><td>'+grad_gb_selected+'</td></tr></tbody></table>';


}

/*
*	���̺� row �߰�(Step3)
*/
function doAddRowData3(history_code,license_type,grade,get_ymd,issue_org){
	
	defaultText3.style.display='none';

	var rowCnt = contentId3.rows.length;

	var newRow = contentId3.insertRow( rowCnt++ );
	newRow.onmouseover=function(){contentId3.clickedRowIndex=this.rowIndex};
	
	var newCell = newRow.insertCell();
	newCell.innerHTML = '<table class="tbl_type tbl_type_list"><colgroup><col width="*" /><col width="20%" /><col width="14%" /><col width="25%" /></colgroup><tbody><tr><td><input type="hidden" name="seqs">'+license_type+'</td><td>'+grade+'</td><td>'+addDateFormatDefault(get_ymd)+'</td><td>'+issue_org+'</td></tr></tbody></table>';

}

/*
*	���̺� row �߰�(Step4)
*/
function doAddRowData4(history_code,contest_nm,award_nm,award_ymd,host_org,contents){

	defaultText4.style.display='none';

	var rowCnt = contentId4.rows.length;

	var newRow = contentId4.insertRow( rowCnt++ );
	newRow.onmouseover=function(){contentId4.clickedRowIndex=this.rowIndex};
	
	var newCell = newRow.insertCell();
	newCell.innerHTML = '<table class="tbl_type tbl_type_list"><colgroup><col width="*" /><col width="20%" /><col width="14%" /><col width="20%" /><col width="20%" /></colgroup><tbody><tr><td><input type="hidden" name="seqs">'+contest_nm+'</td><td>'+award_nm+'</td><td>'+addDateFormatDefault(award_ymd)+'</td><td>'+host_org+'</td><td>'+contents+'</td></tr></tbody></table>';

}

/*
*	���̺� row �߰�(Step5)
*/
function doAddRowData5(history_code,language,exam_type,grade,take_ymd,issue_org){

	defaultText5.style.display='none';

	var rowCnt = contentId5.rows.length;

	var newRow = contentId5.insertRow( rowCnt++ );
	newRow.onmouseover=function(){contentId5.clickedRowIndex=this.rowIndex};
	
	var newCell = newRow.insertCell();
	newCell.innerHTML = '<table class="tbl_type tbl_type_list"><colgroup><col width="14%" /><col width="*" /><col width="14%" /><col width="14%" /><col width="25%" /></colgroup><tbody><tr><td><input type="hidden" name="seqs">'+language+'</td><td>'+exam_type+'</td><td>'+grade+'</td><td>'+addDateFormatDefault(take_ymd)+'</td><td>'+issue_org+'</td></tr></tbody></table>';

}

/*
*	���̺� row �߰�(Step6)
*/
function doAddRowData6(history_code,name,relation,birth_ymd,workplace,cohabit_yn){
	
	//���ſ��� Select Option Chk
	var cohabit_yn_selected = "";
	if(cohabit_yn == "01"){
		cohabit_yn_selected = "����";
	}else if(cohabit_yn == "02"){
		cohabit_yn_selected = "�񵿰�";
	}
	
	defaultText6.style.display='none';

	var rowCnt = contentId6.rows.length;

	var newRow = contentId6.insertRow( rowCnt++ );
	newRow.onmouseover=function(){contentId6.clickedRowIndex=this.rowIndex};
	
	var newCell = newRow.insertCell();
	newCell.innerHTML = '<table class="tbl_type tbl_type_list"><colgroup><col width="14%" /><col width="14%" /><col width="14%" /><col width="14%" /><col width="*" /></colgroup><tbody><tr><td><input type="hidden" name="seqs">'+name+'</td><td>'+relation+'</td><td>'+addDateFormatDefault(birth_ymd)+'</td><td>'+cohabit_yn_selected+'</td><td>'+workplace+'</td></tr></tbody></table>';

}

/*
*	���̺� row �߰�(Step7)
*/
function doAddRowData7(history_code,start_ym,end_ym,work_org,work_dep,last_position,charge_work,retire_reason,employ_type){
	
	//������� Select Option Chk
	var employ_type_selected = "";

	if(employ_type == "01"){
		employ_type_selected = "������";
	}else if(employ_type == "02"){
		employ_type_selected = "�����";
	}else if(employ_type == "03"){
		employ_type_selected = "��������";
	}else if(employ_type == "04"){
		employ_type_selected = "����";
	}
	
	defaultText7.style.display='none';

	var rowCnt = contentId7.rows.length;

	var newRow = contentId7.insertRow( rowCnt++ );
	newRow.onmouseover=function(){contentId7.clickedRowIndex=this.rowIndex};
	
	var newCell = newRow.insertCell();
	newCell.innerHTML = '<table class="tbl_type tbl_type_list"><colgroup><col width="21%" /><col width="15%" /><col width="15%" /><col width="9%" /><col width="15%" /><col width="9%" /><col width="*" /></colgroup><tbody><tr><td><input type="hidden" name="seqs">'+addDateFormatDefault(start_ym)+' ~ '+addDateFormatDefault(end_ym)+'</td><td>'+work_org+'</td><td>'+work_dep+'</td><td>'+last_position+'</td><td>'+charge_work+'</td><td>'+employ_type_selected+'</td><td>'+retire_reason+'</td></tr></tbody></table>';

}

/*
*	���̺� row �߰�(Step8)
*/
function doAddRowData8(history_code,start_ymd,end_ymd,edu_nm,edu_org,complete_yn,edu_detail){

	defaultText8.style.display='none';

	var rowCnt = contentId8.rows.length;

	var newRow = contentId8.insertRow( rowCnt++ );
	newRow.onmouseover=function(){contentId8.clickedRowIndex=this.rowIndex};
	
	var newCell = newRow.insertCell();
	newCell.innerHTML = '<table class="tbl_type tbl_type_list"><colgroup><col width="21%" /><col width="25%" /><col width="20%" /><col width="10%" /><col width="*" /></colgroup><tbody><tr><td><input type="hidden" name="seqs">'+addDateFormatDefault(start_ymd)+' ~ '+addDateFormatDefault(end_ymd)+'</td><td>'+edu_nm+'</td><td>'+edu_org+'</td><td>'+complete_yn+'</td><td>'+edu_detail+'</td></tr></tbody></table>';

}

/*
*	���̺� row �߰�(Step9)
*/
function doAddRowData9(history_code,start_ymd,end_ymd,activety_org,major_activety){

	defaultText9.style.display='none';

	var rowCnt = contentId9.rows.length;
	var newRow = contentId9.insertRow( rowCnt++ );
	newRow.onmouseover=function(){contentId9.clickedRowIndex=this.rowIndex};
	
	var newCell = newRow.insertCell();
	newCell.innerHTML = '<table class="tbl_type tbl_type_list"><colgroup><col width="21%" /><col width="21%" /><col width="*" /></colgroup><tbody><tr><td><input type="hidden" name="seqs">'+addDateFormatDefault(start_ymd)+' ~ '+addDateFormatDefault(end_ymd)+'</td><td>'+activety_org+'</td><td>'+major_activety+'</td></tr></tbody></table>';

}

/*
*	���̺� row �߰�(Step10)
*/
function doAddRowData10(history_code,start_ymd,end_ymd,stay_natinal,stay_object,major_activety){

	defaultText10.style.display='none';

	var rowCnt = contentId10.rows.length;

	var newRow = contentId10.insertRow( rowCnt++ );
	newRow.onmouseover=function(){contentId10.clickedRowIndex=this.rowIndex};
	
	var newCell = newRow.insertCell();
	newCell.innerHTML = '<table class="tbl_type tbl_type_list"><colgroup><col width="21%" /><col width="21%" /><col width="21%" /><col width="*" /></colgroup><tbody><tr><td><input type="hidden" name="seqs">'+addDateFormatDefault(start_ymd)+' ~ '+addDateFormatDefault(end_ymd)+'</td><td>'+stay_natinal+'</td><td>'+stay_object+'</td><td>'+major_activety+'</td></tr></tbody></table>';

}

/*
*	���̺� row �߰�(Step11)
*/
function doAddRowData11(history_code,start_ymd,end_ymd,project_nm,order_org,proc_org,role,project_detail){

	defaultText11.style.display='none';
	defaultText12.style.display='none'; //�ι�° Į�� ����Ÿ.

	var rowCnt = contentId11.rows.length;
	var rowCnt2 = contentId12.rows.length;

	var newRow = contentId11.insertRow( rowCnt++ );
	newRow.onmouseover=function(){contentId11.clickedRowIndex=this.rowIndex};
	
	var newRow2 = contentId12.insertRow();
	newRow2.onmouseover=function(){contentId12.clickedRowIndex=this.rowIndex};
	
	var newCell = newRow.insertCell();
	newCell.innerHTML = '<table class="tbl_type tbl_type_list"><colgroup><col width="21%" /><col width="*" /><col width="20%" /><col width="20%" /><col width="20%" /></colgroup><tbody><tr><td><input type="hidden" name="seqs">'+addDateFormatDefault(start_ymd)+' ~ '+addDateFormatDefault(end_ymd)+'</td><td>'+project_nm+'</td><td>'+order_org+'</td><td>'+proc_org+'</td><td>'+role+'</td></tr></tbody></table>';
	var newCell2 = newRow2.insertCell();
	newCell2.innerHTML = '<table class="tbl_type tbl_type_list"><tbody><tr><td class="text_l"><input type="hidden" name="seqs">'+project_detail.split("<br>").join("\r\n")+'</td></tr></tbody></table>';
}

// ������ �ϱ�.
function printWirte(divID){
	window.print(); //6.����Ʈ �Լ� ȣ��.
	self.close(); 	//7.�μ�̸����� �˾� ����.
	} 

</script>
</head>
<body> 
<!-- �˾������� : width:804px -->
<div id="wrapWp" class="printWrap">
	<!-- header -->
	<div id="headerWp">
		<h1>Huation ä������</h1>
	</div>
	<!-- //header -->

	<!-- content -->
	<div id="contentWp" class="recruitManage">
		<!-- ������ ��� ���� -->
		<div class="conTop_area">
			<!-- Top ��ư���� -->
			<div class="Tbtn_areaR"><a href="javascript:printWirte();" class="btn_type01 md0"><span>�μ��ϱ�</span></a></div>
			<!-- //Top ��ư���� -->
		</div>
		<!-- //������ ��� ���� -->
		
		<!-- Huation ä������ �μ� �̸����� -->
		<div class="info">
			<!-- STEP1. �Ϲ���������/�⺻�������� -->
			<table class="tbl_type" summary="STEP1. �Ϲ���������/�⺻��������">
				<colgroup>
					<col width="20%" />
					<col width="*" />
					<col width="17%" />
				</colgroup>
				<tbody>
				<tr>
					<th colspan="3" class="title first">STEP1. �Ϲ���������/�⺻��������</th>
				</tr>
				<tr>
					<th colspan="3" class="title subtitle">�Ϲ���������</th>
				</tr>
				<tr>
					<th>�����ڼ���</th>
					<td colspan="2"><%= StringUtil.nvl(defaultDto.getUser_nm(),"")%></td>
				</tr>
				<tr>
					<th>��±���<br />(�ش�о�1���̻�)</th>
						<td colspan="2"><%
								codeParam = new CodeParam();
								codeParam.setType("select"); 
								codeParam.setStyleClass("vm");
								//codeParam.setFirst("��ü");
								codeParam.setName("careeryn");
								codeParam.setSelected(career); 
								//codeParam.setEvent("javascript:careerYN();"); 
								out.print(CommonUtil.getCodeList(codeParam,"H02"));
																					%>
								<script>
									document.defaultPrintForm.careeryn.disabled=true;
								</script> (<%=StringUtil.nvl(defaultDto.getC_year(),"")%> ��)</td>
				</tr>
				<tr>
					<th>�������</th>
					<td colspan="2"><%=NumberUtil.getPriceFormat(defaultDto.getWish_sal())%> ����</td>
				</tr>
				<tr>
					<th>����(����)����<br />(��¸��ش�)</th>
					<td colspan="2"><%=NumberUtil.getPriceFormat(defaultDto.getCurrent_sal())%> ����</td>
				</tr>
				<tr>
					<th>�������</th>
					<td colspan="2">						
					<%
							codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("vm");
							codeParam.setFirst("����");
							codeParam.setName("position");
							codeParam.setSelected(StringUtil.nvl(defaultDto.getPosition(),"")); 
							//codeParam.setEvent(""); 
							out.print(CommonUtil.getCodeList(codeParam,"H04")); 
						%>
						<script>
							document.defaultPrintForm.position.disabled=true;
						</script>
					</td>
				</tr>
			
				<tr>
					<th>�����о�<br />(���߼��ð���)</th>
					<td colspan="2"><input name="recruitfield" type="checkbox" <%=acheckd%> value="01" checked="checked" disabled id="recruitfield01" class="check md0" /><label for="recruitfield01">R&amp;D</label><input type="checkbox" name="recruitfield" <%=bcheckd%> value="02" disabled id="recruitfield02" class="check" /><label for="recruitfield02">�������</label><input type="checkbox" name="recruitfield" <%=ccheckd%> value="03" disabled id="recruitfield03" class="check"  /><label for="recruitfield03">��������</label><input type="checkbox" name="recruitfield" <%=dcheckd%> value="04" disabled id="recruitfield04" class="check" /><label for="recruitfield04">��ȹ</label><input type="checkbox" name="recruitfield" <%=echeckd%> value="05" disabled id="recruitfield05" class="check" /><label for="recruitfield05">������</label><input type="checkbox" name="recruitfield" <%=fcheckd%> value="06" disabled id="recruitfield06" class="check" /><label for="recruitfield06">����</label><input type="checkbox" name="recruitfield" <%=gcheckd%> value="07" disabled id="recruitfield07" class="check" /><label for="recruitfield07">������</label><input type="checkbox" name="recruitfield" <%=hcheckd%> value="08" disabled id="recruitfield08" class="check" /><label for="recruitfield08">�繫</label><input type="checkbox" name="recruitfield" <%=icheckd%> value="09" disabled id="recruitfield09" class="check" /><label for="recruitfield09">������</label></td>
				</tr>
				<tr>
					<th>���νų�׽���</th>
					<td colspan="2"><%=StringUtil.nvl(defaultDto.getCreed(),"")%></td>
				</tr>
				</tbody>
				<tbody>
				<tr>
					<th colspan="3" class="title subtitle">�⺻��������</th>
				</tr>
				<tr>
					<th>�����ڼ���</th>
					<td class="listT">
						<table class="tbl_type" summary="�����ڼ���(�ѱ�, ����, ����(����ǥ��), �����̸�)">
							<colgroup>
								<col width="19%" />
								<col width="31%" />
								<col width="19%" />
								<col width="31%" />
							</colgroup>
							
							<tbody>
							<tr>
								<th>�ѱ�</th>
								<td><%= StringUtil.nvl(defaultDto.getUser_nm(),"")%></td>
								<th>����<br />(����ǥ��)</th>
								<td class="last"><%=StringUtil.nvl(defaultDto.getE_user_nm(),"")%></td>
							</tr>							
							
							<tr class="last">
								<th>����</th>
								<td><%=StringUtil.nvl(defaultDto.getH_user_nm(),"")%></td>
								<th>�����̸�</th>
								<td class="last"><%=StringUtil.nvl(defaultDto.getEnglish_nm(),"")%></td>
							</tr>
							</tbody>
						</table>
					</td>
					<td rowspan="3" class="pic"><iframe class="pic_area" src="<%= request.getContextPath()%>/B_Recruit.do?cmd=photoForm&photo=<%= StringUtil.nvl(defaultDto.getPhoto(),"")%>"  frameborder="0" height="120" width="110" name="photoFrame" marginwidth="0" marginheight="0" hspace="0" vspace="0" scrolling="no" frameborder="0" align="left"></iframe></td>
				</tr>

				<tr>
					<th>�ֹε�Ϲ�ȣ<br />(�ܱ��ε�Ϲ�ȣ)</th>
						<td>								
							<%
								String jumin_no= StringUtil.nvl(defaultDto.getJumin_no(),"");
								int index=jumin_no.indexOf("-");
								String jumin1=jumin_no.substring(0,index);
								String jumin2=jumin_no.substring(index+1);
																						%>
								<input type = "hidden" name = "jumin_no"   maxlength="14"  value="<%=jumin_no%>"/>
								<%=jumin1%> - <%=jumin2%>
						</td>
				</tr>
				<tr>
					<th>����</th>
					<td><input type = "hidden" name = "national_gb"  maxlength="40"   value="<%= StringUtil.nvl(defaultDto.getNational_gb(),"")%>"/><%= StringUtil.nvl(defaultDto.getNationality(),"")%></td>
				</tr>
				
				<tr>
					<th>����ó</th>
					<td colspan="2" class="listT">
						<table class="tbl_type" summary="����ó(�ڵ���, ����ȭ, �̸���, ��Ÿ)">
							<colgroup>
								<col width="15%" />
								<col width="35%" />
								<col width="15%" />
								<col width="35%" />
							</colgroup>
							<tbody>
							<tr>
								<th>�ڵ���</th>
								<td><input type = "hidden" name = "hand_phone" value="<%=StringUtil.nvl(defaultDto.getHand_phone(),"")%>"  maxlength="20"  value=""/>			
								<%
									String handphone=StringUtil.nvl(defaultDto.getHand_phone(),"");
									int index2=handphone.indexOf("-");
									String hand1=handphone.substring(0,index2);
									String temphand=handphone.substring(index2+1);
									int index3=temphand.indexOf("-");
									String hand2=temphand.substring(0,index3);
									String hand3=temphand.substring(index3+1);
									
									codeParam = new CodeParam();
									codeParam.setType("select"); 
									codeParam.setStyleClass("vm");
									codeParam.setFirst("����");
									codeParam.setName("hand1");
									codeParam.setSelected(hand1); 
									//codeParam.setEvent(""); 
									out.print(CommonUtil.getCodeList(codeParam,"H05")); 
								%>&nbsp;&nbsp;-&nbsp;&nbsp;<%=hand2%>&nbsp;&nbsp;-&nbsp;&nbsp;<%=hand3%>
								<script>
									document.defaultPrintForm.hand1.disabled=true;
								</script></td>
								
								<th>����ȭ</th>
								<td class="last"><input type = "hidden" name = "home_phone" value="<%=StringUtil.nvl(defaultDto.getHome_phone(),"")%>"  maxlength="20"  value=""/>
									<%
									String homephone=StringUtil.nvl(defaultDto.getHome_phone(),"");
									int index5=homephone.indexOf("-");
									String home1=homephone.substring(0,index5);
									String temphome=homephone.substring(index5+1);
									int index6=temphome.indexOf("-");
									String home2=temphome.substring(0,index6);
									String home3=temphome.substring(index6+1);
									
									codeParam = new CodeParam();
									codeParam.setType("select"); 
									codeParam.setStyleClass("vm");
									codeParam.setFirst("����");
									codeParam.setName("home1");
									codeParam.setSelected(home1); 
									//codeParam.setEvent(""); 
									out.print(CommonUtil.getCodeList(codeParam,"H06")); 
								%>&nbsp;&nbsp;-&nbsp;&nbsp;<%=home2%>&nbsp;&nbsp;-&nbsp;&nbsp;<%=home3%>
								<script>
									document.defaultPrintForm.home1.disabled=true;
								</script>
								</td>
							</tr>	

							<tr class="last">
								<th>�̸���</th>
								<td><%= StringUtil.nvl(defaultDto.getEmail(),"")%></td>
								<th>��Ÿ</th>
								<td class="last"><%
									String etcphone=StringUtil.nvl(defaultDto.getEtc_phone(),"");
									int index7= etcphone.indexOf("-");
									String  etc1= etcphone.substring(0,index7);
									String tempetc= etcphone.substring(index7+1);
									int index8=tempetc.indexOf("-");
									String etc2=tempetc.substring(0,index8);
									String etc3=tempetc.substring(index8+1);
								%>
								<input name="etc_phone" type="hidden" class="style2" tabindex="11" height="20"  maxlength="20" value="<%=StringUtil.nvl(defaultDto.getEtc_phone(),"")%>"/>
								 <%=etc1%>&nbsp;&nbsp;-&nbsp;&nbsp;<%=etc2%>&nbsp;&nbsp;-&nbsp;&nbsp;<%=etc3%>
							</td>
							</tr>
							</tbody>
						</table>
					</td>
				</tr>							

				<tr>
					<th>��ȥ����</th>
					<td colspan="2">
						<select name="rriage_yn" disabled class="vm" id="select3">
							<option value="01">��ȥ</option>
							<option value="02">��ȥ</option>
						</select>
						<script>
							document.defaultPrintForm.rriage_yn.value='<%=StringUtil.nvl(defaultDto.getRriage_yn(),"")%>';
						</script>
					</td>
				</tr>
				<tr>
					<th>�������</th>
					<td colspan="2"><%=DateTimeUtil.getDateType(1,defaultDto.getBirth_day(),"/")%></td>
				</tr>				
				
				<tr>
					<th>��������</th>
					<td colspan="2">						<%
							codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("vm");
							//codeParam.setFirst("����");
							codeParam.setName("military");
							codeParam.setSelected(StringUtil.nvl(defaultDto.getMilitary(),"")); 
							codeParam.setEvent("javascript:militaryYN();"); 
							out.print(CommonUtil.getCodeList(codeParam,"H08")); 
						%>
						<script>
							document.defaultPrintForm.military.disabled=true;
						</script> (�������� : <%= StringUtil.nvl(defaultDto.getExemption(),"")%>)
					</td>
				</tr>
				
				<tr>
					<th>�ֹε�ϻ��ּ�</th>
					<td colspan="2">(<%= StringUtil.nvl(defaultDto.getJ_post(),"")%>) <%= StringUtil.nvl(defaultDto.getJ_address(),"")%> <%= StringUtil.nvl(defaultDto.getJ_addr_detail(),"")%></td>
				</tr>
				
				<tr>
					<th>�������ּ�</th>
					<td colspan="2">(<%= StringUtil.nvl(defaultDto.getC_post(),"")%>) <%= StringUtil.nvl(defaultDto.getC_address(),"")%> <%= StringUtil.nvl(defaultDto.getC_addr_detail(),"")%></td>
				</tr>
				<tr>
					<th>���ƴ��</th>
					<td colspan="2">						
					<%
							codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("vm");
							//codeParam.setFirst("����");
							codeParam.setName("veterans_yn");
							codeParam.setSelected(StringUtil.nvl(defaultDto.getVeterans_yn(),"")); 
							codeParam.setEvent("javascript:veteransYN();"); 
							out.print(CommonUtil.getCodeList(codeParam,"H09")); 
						%>
						<script>
							document.defaultPrintForm.veterans_yn.disabled=true;
						</script> (���ƹ�ȣ : <%= StringUtil.nvl(defaultDto.getVeterans_no(),"")%>)
					</td>
				</tr>

			<tr>
					<th>����ε�Ͽ���</th>
					<td colspan="2">						
					<%
							codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("vm");
							//codeParam.setFirst("����");
							codeParam.setName("disabled_yn");
							codeParam.setSelected(StringUtil.nvl(defaultDto.getDisabled_yn(),"")); 
							codeParam.setEvent("javascript:disabledYN();"); 
							out.print(CommonUtil.getCodeList(codeParam,"H10")); 
						%>
						<script>
							document.defaultPrintForm.disabled_yn.disabled=true;
						</script> (��ֵ�� : <%= StringUtil.nvl(defaultDto.getDisabled_grade(),"")%>)
					</td>
				</tr>
				</tbody>
			</table>
			<!-- //STEP1. �Ϲ���������/�⺻�������� -->

			<!-- STEP2. �з»��� -->
			<table class="tbl_type tbl_type_list" summary="STEP2. �з»���">
				<colgroup>
					<col width="*" />
					<col width="14%" />
					<col width="14%" />
					<col width="23%" />
					<col width="10%" />
					<col width="10%" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="6" class="title">STEP2. �з»���</th>
				</tr>
				<tr>
					<th>�б���</th>
					<th>���г��</th>
					<th>����(����)���</th>
					<th>����(��������)</th>
					<th>����</th>
					<th>��������</th>
				</tr>
				</thead>
			</table>
			<!-- content:none -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="defaultText">
			</table>
			<!-- //content:none -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="contentId">
			</table>
			<!-- //�߰�ROW -->
			<!-- //STEP2. �з»��� -->
			
			<!-- STEP3. �ڰ�/������� -->
			<table class="tbl_type tbl_type_list" summary="STEP3. �ڰ�/�������">
				<colgroup>
					<col width="*" />
					<col width="20%" />
					<col width="14%" />
					<col width="25%" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="4" class="title">STEP3. �ڰ�/�������</th>
				</tr>
				<tr>
					<th>�ڰ�/��������</th>
					<th>���</th>
					<th>�������</th>
					<th>�߱ޱ��</th>
				</tr>
				</thead>
			</table>
			<!-- content:none -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="defaultText3">
			</table>
			<!-- //content:none -->
			<!-- �߰�ROW -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="contentId3">
			</table>
			<!-- //�߰�ROW -->
			<!-- //STEP3. �ڰ�/������� -->
	
			<!-- STEP4. ������� -->
			<table class="tbl_type tbl_type_list" summary="STEP4. �������">
				<colgroup>
					<col width="*" />
					<col width="20%" />
					<col width="14%" />
					<col width="20%" />
					<col width="20%" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="5" class="title">STEP4. �������</th>
				</tr>
				<tr>
					<th>��ȸ��</th>
					<th>�����</th>
					<th>��������</th>
					<th>���ֱ��</th>
					<th>����</th>
				</tr>
				</thead>
			</table>
			<!-- content:none -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="defaultText4">
			</table>
			<!-- //content:none -->
			<!-- �߰�ROW -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="contentId4">
			</table>
			<!-- //�߰�ROW -->
			<!-- //STEP4. ������� -->
	
			<!-- STEP5. ���л��� -->
			<table class="tbl_type tbl_type_list" summary="STEP5. ���л���">
				<colgroup>
					<col width="14%" />
					<col width="*" />
					<col width="14%" />
					<col width="14%" />
					<col width="25%" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="5" class="title">STEP5. ���л���</th>
				</tr>
				<tr>
					<th>���</th>
					<th>��������</th>
					<th>���(����)</th>
					<th>���ó����</th>
					<th>�߱ޱ��</th>
				</tr>
				</thead>
			</table>
			<!-- content:none -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="defaultText5">
			</table>
			<!-- //content:none -->
			<!-- �߰�ROW -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="contentId5">
			</table>
			<!-- //�߰�ROW -->
			<!-- //STEP5. ���л��� -->
	
			<!-- STEP6. �������� -->
			<table class="tbl_type tbl_type_list" summary="STEP6. ��������">
				<colgroup>
					<col width="14%" />
					<col width="14%" />
					<col width="14%" />
					<col width="14%" />
					<col width="*" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="5" class="title">STEP6. ��������</th>
				</tr>
				<tr>
					<th>����</th>
					<th>����</th>
					<th>�������</th>
					<th>���ſ���</th>
					<th>�ٹ�ó������</th>
				</tr>
				</thead>
			</table>
			<!-- content:none -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="defaultText6">
			</table>
			<!-- //content:none -->
			<!-- �߰�ROW -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="contentId6">
			</table>
			<!-- //�߰�ROW -->
			<!-- //STEP6. �������� -->
	
			<!-- STEP7. ��»��� -->
			<table class="tbl_type tbl_type_list" summary="STEP7. ��»���">
				<colgroup>
					<col width="21%" />
					<col width="15%" />
					<col width="15%" />
					<col width="9%" />
					<col width="15%" />
					<col width="9%" />
					<col width="*" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="7" class="title">STEP7. ��»���</th>
				</tr>
				<tr>
					<th>�ٹ��Ⱓ(��/��)</th>
					<th>�ٹ������</th>
					<th>�ٹ��μ�</th>
					<th>��������</th>
					<th>������</th>
					<th>�������</th>
					<th>��������</th>
				</tr>
				</thead>
			</table>
			<!-- content:none -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="defaultText7">
			</table>
			<!-- //content:none -->
			<!-- �߰�ROW -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="contentId7">
			</table>
			<!-- //�߰�ROW -->
			<!-- //STEP7. ��»��� -->
	
			<!-- STEP8. �������� -->
			<table class="tbl_type tbl_type_list" summary="STEP8. ��������">
				<colgroup>
					<col width="21%" />
					<col width="25%" />
					<col width="20%" />
					<col width="10%" />
					<col width="*" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="5" class="title">STEP8. ��������</th>
				</tr>
				<tr>
					<th>�����Ⱓ(��/��/��)</th>
					<th>������</th>
					<th>���������</th>
					<th>���Ῡ��</th>
					<th>�󼼱�������</th>
				</tr>
				</thead>
			</table>
			<!-- content:none -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="defaultText8">
			</table>
			<!-- //content:none -->
			<!-- �߰�ROW -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="contentId8">
			</table>
			<!-- //�߰�ROW -->
			<!-- //STEP8. �������� -->
	
			<!-- STEP9. ��ȸ����ױ⿩ -->
			<table class="tbl_type tbl_type_list" summary="STEP9. ��ȸ����ױ⿩">
				<colgroup>
					<col width="21%" />
					<col width="21%" />
					<col width="*" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="3" class="title">STEP9. ��ȸ����ױ⿩</th>
				</tr>
				<tr>
					<th>Ȱ���Ⱓ(��/��/��)</th>
					<th>Ȱ�������</th>
					<th>�ֿ�Ȱ��</th>
				</tr>
				</thead>
			</table>
			<!-- content:none -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="defaultText9">
			</table>
			<!-- //content:none -->
			<!-- �߰�ROW -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="contentId9">
			</table>
			<!-- //�߰�ROW -->
			<!-- //STEP9. ��ȸ����ױ⿩ -->
	
			<!-- STEP10. �ؿܿ���׿� -->
			<table class="tbl_type tbl_type_list" summary="STEP10. �ؿܿ���׿���">
				<colgroup>
					<col width="21%" />
					<col width="21%" />
					<col width="21%" />
					<col width="*" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="4" class="title">STEP10. �ؿܿ���׿���</th>
				</tr>
				<tr>
					<th>ü���Ⱓ(��/��/��)</th>
					<th>ü������</th>
					<th>ü������</th>
					<th>�ֿ�Ȱ������</th>
				</tr>
				</thead>
			</table>
			<!-- content:none -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="defaultText10">
			</table>
			<!-- //content:none -->
			<!-- �߰�ROW -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="contentId10">
			</table>
			<!-- //�߰�ROW -->
			<!-- //STEP10. �ؿܿ���׿� -->
	
			<!-- STEP11. ������Ʈ������ -->
			<table class="tbl_type tbl_type_list" summary="STEP11. ������Ʈ������">
				<colgroup>
					<col width="21%" />
					<col width="*" />
					<col width="20%" />
					<col width="20%" />
					<col width="20%" />
				</colgroup>
				<tbody>
				<tr>
					<th colspan="5" class="title">STEP11. ������Ʈ������</th>
				</tr>
				</tbody>				
				<tbody>
				<tr>
					<th>������Ʈ�Ⱓ(�����)</th>
					<th>������Ʈ��</th>
					<th>����ó</th>
					<th>����üҼӱ����</th>
					<th>����</th>
				</tr>
				</tbody>
			</table>
			<!-- content:none -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="defaultText11">
			</table>
			<!-- //content:none -->
			<!-- �߰�ROW -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="contentId11">
			</table>
			<!-- //�߰�ROW -->
			<table class="tbl_type tbl_type_list" summary="STEP11. ������Ʈ������">
				<tbody>
				<tr>
					<th>������Ʈ����󼼳���</th>
				</tr>
				</tbody>	
			</table>
			<!-- content:none -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="defaultText12">
			</table>
			<!-- //content:none -->
			<!-- �߰�ROW -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="contentId12">
			</table>
			<!-- //�߰�ROW -->
			<!-- //STEP11. ������Ʈ������ -->	
	
			<!-- STEP12. �ڱ�Ұ� -->
			<table class="tbl_type tbl_type_list" summary="STEP12. �ڱ�Ұ�">
				<thead>
				<tr>
					<th class="title">STEP12. �ڱ�Ұ�</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<th>�λ��� Role Model�� �ִٸ� ���������� ������ �����ϼ���.(���ٸ� �ۼ����� �ʾƵ� �˴ϴ�.)</th>
				</tr>
				<tr>
					<td class="text_l"><%=StringUtil.nvl(introDto.getIntroduce1(),"")%></td>
				</tr>
				<tr>
					<th>���� �ֱٿ� ����å �̸��� ���� �׸��� ���� �� �ڽ��� �������� �������.</th>
				</tr>
				<tr>
					<td class="text_l"><%=StringUtil.nvl(introDto.getIntroduce2(),"")%></td>
				</tr>
				<tr>
					<th>����� � ����Դϱ�?(�ڱ��ڽ��� �м��� ������.)</th>
				</tr>
				<tr>
					<td class="text_l"><%=StringUtil.nvl(introDto.getIntroduce3(),"")%></td>
				</tr>
				</tbody>
			</table>
			<!-- //STEP12. �ڱ�Ұ� -->	
		</div>
		<!-- //Huation ä������ �μ� �̸����� -->
		<!-- Bottom ��ư���� -->
		<div class="Bbtn_areaC"><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>�ݱ�</span></a></div>
		<!-- //Bottom ��ư���� -->
	</div>
	<!-- //content -->

<!--�Է�ROW :: START(Step2)-->
<%	

	if(arrlist.size() > 0){	
	int i = 0;

		for(int j=0; j < arrlist.size(); j++ ){	
			HistoryDTO dto = arrlist.get(j);

%>
 <script>
	doAddRowData('<%=dto.getHistory_code().trim()%>','<%=dto.getSchool_nm().trim()%>','<%=dto.getStart_ym().trim()%>','<%=dto.getGrad_ym().trim()%>','<%=dto.getMajor().trim()%>','<%=dto.getCredit().trim()%>','<%=dto.getGrad_gb().trim()%>');
</script>

<%
					i++;
		}
	}
%>
<!--�Է�ROW :: END(Step2)-->

<!--�Է�ROW :: START(Step3-->
<%	

	if(arrlist2.size() > 0){	
	int i = 0;

		for(int j=0; j < arrlist2.size(); j++ ){	
			LicenseDTO dto = arrlist2.get(j);

%>
 <script>
	doAddRowData3('<%=dto.getHistory_code().trim()%>','<%=dto.getLicense_type().trim()%>','<%=dto.getGrade().trim()%>','<%=dto.getGet_ymd().trim()%>','<%=dto.getIssue_org().trim()%>');
</script>

<%
					i++;
		}
	}
%>
<!--�Է�ROW :: END(Step3)-->

<!--�Է�ROW :: START(Step4)-->
<%	

	if(arrlist3.size() > 0){	

	int i = 0;

		for(int j=0; j < arrlist3.size(); j++ ){	
			AwardDTO dto = arrlist3.get(j);

%>
<script>
	doAddRowData4('<%=dto.getHistory_code().trim()%>','<%=dto.getContest_nm().trim()%>','<%=dto.getAward_nm().trim()%>','<%=dto.getAward_ymd().trim()%>','<%=dto.getHost_org().trim()%>','<%=dto.getContents().trim()%>');
</script>

<%
					i++;
		}
	}
%>
<!--�Է�ROW :: END(Step4)-->

<!--�Է�ROW :: START(Step5)-->
<%	

	if(arrlist4.size() > 0){	
	int i = 0;

		for(int j=0; j < arrlist4.size(); j++ ){	
			LangDTO dto = arrlist4.get(j);

%>
 <script>
	doAddRowData5('<%=dto.getHistory_code().trim()%>','<%=dto.getLanguage().trim()%>','<%=dto.getExam_type().trim()%>','<%=dto.getGrade().trim()%>','<%=dto.getTake_ymd().trim()%>','<%=dto.getIssue_org().trim()%>');
</script>

<%
					i++;
		}
	}
%>
<!--�Է�ROW :: END(Step5)-->

<!--�Է�ROW :: START(Step6)-->
<%	

	if(arrlist5.size() > 0){	
	int i = 0;

		for(int j=0; j < arrlist5.size(); j++ ){	
			FamilyDTO dto = arrlist5.get(j);

%>
 <script>
	doAddRowData6('<%=dto.getHistory_code().trim()%>','<%=dto.getName().trim()%>','<%=dto.getRelation().trim()%>','<%=dto.getBirth_ymd().trim()%>','<%=dto.getWorkplace().trim()%>','<%=dto.getCohabit_yn().trim()%>');
</script>

<%
					i++;
		}
	}
%>
<!--�Է�ROW :: END(Step6)-->

<!--�Է�ROW :: START(Step7)-->
<%	

	if(arrlist6.size() > 0){	
	int i = 0;

		for(int j=0; j < arrlist6.size(); j++ ){	
			CareerDTO dto = arrlist6.get(j);

%>
 <script>
	doAddRowData7('<%=dto.getHistory_code().trim()%>','<%=dto.getStart_ym().trim()%>','<%=dto.getEnd_ym().trim()%>','<%=dto.getWork_org().trim()%>','<%=dto.getWork_dep().trim()%>','<%=dto.getLast_position().trim()%>','<%=dto.getCharge_work().trim()%>','<%=dto.getRetire_reason().trim()%>','<%=dto.getEmploy_type().trim()%>');
</script>

<%
					i++;
		}
	}
%>
<!--�Է�ROW :: END(Step7)-->

<!--�Է�ROW :: START(Step8)-->
<%	

	if(arrlist7.size() > 0){	
	int i = 0;

		for(int j=0; j < arrlist7.size(); j++ ){	
			EduDTO dto = arrlist7.get(j);

%>
 <script>
	doAddRowData8('<%=dto.getHistory_code().trim()%>','<%=dto.getStart_ymd().trim()%>','<%=dto.getEnd_ymd().trim()%>','<%=dto.getEdu_nm().trim()%>','<%=dto.getEdu_org().trim()%>','<%=dto.getComplete_yn().trim()%>','<%=dto.getEdu_detail().trim()%>');
</script>

<%
					i++;
		}
	}
%>
<!--�Է�ROW :: END(Step8)-->

<!--�Է�ROW :: START(Step9)-->
<%	

	if(arrlist8.size() > 0){	
	int i = 0;

		for(int j=0; j < arrlist8.size(); j++ ){	
			ActiveDTO dto = arrlist8.get(j);

%>
 <script>
	doAddRowData9('<%=dto.getHistory_code().trim()%>','<%=dto.getStart_ymd().trim()%>','<%=dto.getEnd_ymd().trim()%>','<%=dto.getActivety_org().trim()%>','<%=dto.getMajor_activety().trim()%>');
</script>

<%
					i++;
		}
	}
%>
<!--�Է�ROW :: END(Step9)-->

<!--�Է�ROW :: START(Step10)-->
<%	

	if(arrlist9.size() > 0){	
	int i = 0;

		for(int j=0; j < arrlist9.size(); j++ ){	
			TrainDTO dto = arrlist9.get(j);

%>
 <script>
	doAddRowData10('<%=dto.getHistory_code().trim()%>','<%=dto.getStart_ymd().trim()%>','<%=dto.getEnd_ymd().trim()%>','<%=dto.getStay_natinal().trim()%>','<%=dto.getStay_object().trim()%>','<%=dto.getMajor_activety().trim()%>');
</script>

<%
					i++;
		}
	}
%>
<!--�Է�ROW :: END(Step10)-->

<!--�Է�ROW :: START(Step11)-->
<%	

	if(arrlist10.size() > 0){	
	int i = 0;

		for(int j=0; j < arrlist10.size(); j++ ){	
			ProjectDTO dto = arrlist10.get(j);

%>
<script>
	doAddRowData11('<%=dto.getHistory_code().trim()%>','<%=dto.getStart_ymd().trim()%>','<%=dto.getEnd_ymd().trim()%>','<%=dto.getProject_nm().trim()%>','<%=dto.getOrder_org().trim()%>','<%=dto.getProc_org().trim()%>','<%=dto.getRole().trim()%>','<%=dto.getProject_detail().replace("\r\n","<br>")%>');
</script>

<%
					i++;
		}
	}
%>
<!--�Է�ROW :: END(Step11)-->
