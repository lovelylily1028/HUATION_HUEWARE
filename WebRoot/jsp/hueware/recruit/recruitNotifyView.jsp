<%@page import="com.huation.framework.util.StringUtil"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.recruit.RecruitDTO"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%

	Map model = (Map)request.getAttribute("MODEL"); 
	RecruitDTO recruitDto = (RecruitDTO)model.get("compDto");
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");

	String[] r_field = StringUtil.getTokens(recruitDto.getRecruit_field(), "|");

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
	
	//���������� �ʱ� ���� ��.
		String recruit_start = "";

		
		if(recruitDto.getRecruit_start().equals("")){
			recruit_start = recruitDto.getRecruit_start();
			recruit_start = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		}else{
			recruit_start = recruitDto.getRecruit_start();
			String strY_Val1;										//�⵵ �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
			String strM_Val1;										//���� �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
			String strD_Val1;
			
		    strY_Val1 = recruit_start.substring(0,4);
		    strM_Val1 = recruit_start.substring(4,6);
		    strD_Val1 = recruit_start.substring(6,8);
			
		    recruit_start = strY_Val1 + '-' + strM_Val1  + '-' + strD_Val1;
		}
		
		//���������� �ʱ� ���� ��.
		String recruit_end = "";
		
		if(recruitDto.getRecruit_end().equals("")){
			recruit_end = recruitDto.getRecruit_end();
			recruit_end = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		}else{
			recruit_end = recruitDto.getRecruit_end();
			String strY_Val1;										//�⵵ �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
			String strM_Val1;										//���� �� �ڸ��鼭 arr���·� ��ȯ�Ǿ� String���� ����ȯ�Ͽ� ���.(�������̼�üũ�� ����)
			String strD_Val1;
			
		    strY_Val1 = recruit_end.substring(0,4);
		    strM_Val1 = recruit_end.substring(4,6);
		    strD_Val1 = recruit_end.substring(6,8);
		    
		    recruit_end = strY_Val1 + '-' + strM_Val1  + '-' + strD_Val1;
			
		}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ä����� ����������</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goSave(){
	var frm = document.recruitRegist; 

	if(frm.subject.value.length == 0){
		alert("�����о߸� �Է��ϼ���");
		return;
	}
	if(frm.contents.value.length == 0){
		alert("���������� �Է��ϼ���");
		return;
	}

	var recruit_field='';
	var cnt=9;
	for(i=0;i<cnt;i++){
		if(frm.recruitfield[i].checked==true){
			if(i==cnt-1){
				i++;
				recruit_field+='0'+i;
				i--;
			}else{
				i++;
				recruit_field+='0'+i+'|';
				i--;
			}
		}
	}
	if(recruit_field==''){
		alert('�����о߸� �ϳ��̻� �����ϼ���.');
		return;
	}else{
		frm.recruit_field.value=recruit_field;
	}
	
	
	var dates = frm.recruit_start.value;
	var recruit_starts = dates.replace(/-/g,'');
	frm.pYear1.value = recruit_starts.substr(0,4);
	frm.pMonth1.value = recruit_starts.substr(4,2);
	frm.pDay1.value = recruit_starts.substr(6,2);
	
	frm.recruit_start.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
	
	
	
	var dates = frm.recruit_end.value;
	var recruit_ends = dates.replace(/-/g,'');
	frm.pYear3.value = recruit_ends.substr(0,4);
	frm.pMonth3.value = recruit_ends.substr(4,2);
	frm.pDay3.value = recruit_ends.substr(6,2);
	
	frm.recruit_end.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;

    frm.recruit_start.value = frm.pYear1.value +frm.pMonth1.value +frm.pDay1.value;
	frm.recruit_end.value = frm.pYear3.value +frm.pMonth3.value +frm.pDay3.value;

	if(frm.recruit_start.value.length == 0 || frm.recruit_end.value.length == 0){
		alert("�������� �Է��ϼ���");
		return;
	}
	if(frm.recruit_start.value>frm.recruit_end.value){
		alert("���� �Ⱓ�� �ùٸ��� �Է��� �ּ���");
		return;
	}
   
   if(confirm("���� �Ͻðڽ��ϱ�?")){
		frm.curPage.value='1';
		frm.searchGb.value='';
		frm.searchtxt.value='';
		frm.submit();
   }
}

function goList(){
	
	var frm = document.recruitRegist;
	frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitNotifyList';
	frm.submit();

}
function goDelete(){
	
	var frm = document.recruitRegist;
	if(confirm("���� �Ͻðڽ��ϱ�?")){
		frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitNotifyDelete';
		frm.submit();
	}

}
//-->
</SCRIPT>
</head>
<body>
<div id="wrap">

<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

	<!-- container -->
	<div id="container">
		<div id="content">
			<div class="content_navi">HUEHome���� &gt; ä�����</div>
			<h3><span>ä</span>����������</h3><!-- Ÿ��Ʋ �ձ��ڴ� <span></span>���� ���α� -->
			<div class="con">
				<!-- ������ ��� ���� -->
				<div class="conTop_area">
					<!-- �ʼ��Է»����ؽ�Ʈ -->
					<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
					<!-- //�ʼ��Է»����ؽ�Ʈ -->
				</div>
				<!-- //������ ��� ���� -->
				<!-- ��� -->
			  
			    <form name="recruitRegist" method="post" action="<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitNotifyEdit">
			      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
			      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
			      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
			      <input type = "hidden" name = "recruit_no" value="<%=recruitDto.getRecruit_no()%>"/>
			      
			     <input type = "hidden" name = "pYear1" value=""/>
			     <input type = "hidden" name = "pMonth1" value=""/>
			     <input type = "hidden" name = "pDay1" value=""/>
			      <input type = "hidden" name = "pYear3" value=""/>
			     <input type = "hidden" name = "pMonth3" value=""/>
			     <input type = "hidden" name = "pDay3" value=""/>
      
				<fieldset>
					<legend>ä����������</legend>
					
					<table class="tbl_type" summary="ä����������(����, ��������)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						
						<tbody>
						<tr>
							<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�����о�</label></th>
							<td><input type="text" id="" name="subject" class="text" title="�����о�" style="width:916px;" maxlength="50"  value="<%=recruitDto.getSubject()%>"/></td>
						</tr>      
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>��������</label></th>
							<td><textarea id="" name="contents" title="��������" style="width:916px;height:248px;"><%=recruitDto.getContents()%></textarea></td>
						</tr>
						
						<%
							CodeParam codeParam=null;
						%>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>ä������</label></th>
			          		<td><%  
								  codeParam = new CodeParam();
								  codeParam.setType("select"); 
								  codeParam.setStyleClass("input1");
								  codeParam.setName("recruit_type");
								  codeParam.setSelected(recruitDto.getRecruit_type()); 
								  out.print(CommonUtil.getCodeList(codeParam,"H01")); 
							  %></td>
						</tr>

						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>ä��о�</label></th>
							<input type="hidden" name="recruit_field">
							<td><input type="checkbox" id="" name="recruitfield" class="check md0" title="R&amp;D" value="01" <%=acheckd%>/><label for="">R&amp;D</label><input type="checkbox" id="" name="recruitfield" class="check" title="�������" value="02" <%=bcheckd%>/><label for="">�������</label><input type="checkbox" id="" name="recruitfield" class="check" title="��������" value="03" <%=ccheckd%>/><label for="">��������</label><input type="checkbox" id="" name="recruitfield" class="check" title="��ȹ" value="04" <%=dcheckd%>/><label for="">��ȹ</label><input type="checkbox" id="" name="recruitfield" class="check" title="������" value="05" <%=echeckd%>/><label for="">������</label><input type="checkbox" id="" name="recruitfield" class="check" title="����" value="06" <%=fcheckd%>/><label for="">����</label><input type="checkbox" id="" name="recruitfield" class="check" title="������" value="07" <%=gcheckd%>/><label for="">������</label><input type="checkbox" id="" name="recruitfield" class="check" title="�繫" value="08" <%=hcheckd%>/><label for="">�繫</label><input type="checkbox" id="" name="recruitfield" class="check" title="������" value="09" <%=icheckd%>/><label for="">������</label></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���</label></th>
          						<td><%  
									codeParam = new CodeParam();
									codeParam.setType("select"); 
									codeParam.setStyleClass("input1");
									codeParam.setName("career");
									codeParam.setSelected(recruitDto.getCareer()); 
									out.print(CommonUtil.getCodeList(codeParam,"H02")); 
								%></td>
						</tr>

						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������</label></th>
							<td><span class="ico_calendar"><input id="calendarData1"  name="recruit_start" value="<%=recruit_start%>" class="text" style="width:100px;"/></span><input type="hidden" class="text"  style="width:100px" value=""/>&nbsp;&nbsp;~&nbsp;&nbsp;<span class="ico_calendar"><input id="calendarData2" name="recruit_end" value="<%=recruit_end%>" class="text" style="width:100px;"/></span><input type="hidden" class="text"  style="width:100px" value=""/></td>
						</tr>
						</tbody>
					</table>
				</fieldset>
				</form>
				<!-- //��� -->
				<!-- Bottom ��ư���� -->
				<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>����</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>����</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
				<!-- //Bottom ��ư���� -->
			</div>
		</div>
	</div>
	<!-- //container -->

<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->
</div>
</body>
</html>
<%= comDao.getMenuAuth(menulist,"42") %>