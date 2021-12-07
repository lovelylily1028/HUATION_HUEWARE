<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%

	Map model = (Map)request.getAttribute("MODEL"); 
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt =  (String)model.get("searchtxt");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>채용공고 등록페이지</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery.banner.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goSave(){
	var frm = document.recruitRegist; 

	if(frm.subject.value.length == 0){
		alert("모집분야를 입력하세요");
		return;
	}
	if(frm.contents.value.length == 0){
		alert("모집내용을 입력하세요");
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
		alert('지원분야를 하나이상 선택하세요.');
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
		alert("접수일을 입력하세요");
		return;
	}
	if(frm.recruit_start.value>frm.recruit_end.value){
		alert("접수 기간을 올바르게 입력해 주세요");
		return;
	}

	frm.curPage.value='1';
	frm.searchGb.value='';
	frm.searchtxt.value='';
	frm.submit();
}

function cancle(){
	
	var frm = document.recruitRegist;
	frm.action='<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitNotifyList';
	frm.submit();

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
			<div class="content_navi">HUEHome관리 &gt; 채용공고</div>
			<h3><span>채</span>용공고등록</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- 필수입력사항텍스트 -->
					<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
					<!-- //필수입력사항텍스트 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				<!-- 등록 -->
			    <form name="recruitRegist" method="post" action="<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitNotifyRegist">
			      <input type = "hidden" name = "curPage" value="<%=curPage%>"/>
			      <input type = "hidden" name = "searchGb" value="<%=searchGb%>"/>
			      <input type = "hidden" name = "searchtxt" value="<%=searchtxt%>"/>
			      <input type = "hidden" name = "recruit_no" value="01"/>
			      
			      <input type = "hidden" name = "pYear1" value=""/>
			     <input type = "hidden" name = "pMonth1" value=""/>
			     <input type = "hidden" name = "pDay1" value=""/>
			      <input type = "hidden" name = "pYear3" value=""/>
			     <input type = "hidden" name = "pMonth3" value=""/>
			     <input type = "hidden" name = "pDay3" value=""/>
     
 				<fieldset>
					<legend>채용공고등록</legend>
					<table class="tbl_type" summary="채용공고등록(제목, 뉴스내용)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>모집분야</label></th>
							<td><input type="text" id="" name="subject" class="text" title="모집분야" style="width:916px;" maxlength="100"/></td>
						</tr>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>모집내용</label></th>
							<td><textarea id="" name="contents" title="모집내용" style="width:916px;height:248px;"></textarea></td>
						</tr>
						
						<%
							CodeParam codeParam=null;
						%>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>채용유형</label></th>
					          	<td><%  
									codeParam = new CodeParam();
									codeParam.setType("select"); 
									codeParam.setStyleClass("input1");
									codeParam.setName("recruit_type");
									//codeParam.setSelected(btxt); 
									out.print(CommonUtil.getCodeList(codeParam,"H01")); 
								%></td>
						</tr>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>채용분야</label></th>
							<input type="hidden" name="recruit_field">
							<td><input type="checkbox" id="" name="recruitfield" class="check md0" title="R&amp;D" value="01"/><label for="">R&amp;D</label><input type="checkbox" id="" name="recruitfield" class="check" title="기술지원" value="02"/><label for="">기술지원</label><input type="checkbox" id="" name="recruitfield" class="check" title="조직관리" value="03"/><label for="">조직관리</label><input type="checkbox" id="" name="recruitfield" class="check" title="기획" value="04"/><label for="">기획</label><input type="checkbox" id="" name="recruitfield" class="check" title="디자인" value="05"/><label for="">디자인</label><input type="checkbox" id="" name="recruitfield" class="check" title="영업" value="06"/><label for="">영업</label><input type="checkbox" id="" name="recruitfield" class="check" title="마케팅" value="07"/><label for="">마케팅</label><input type="checkbox" id="" name="recruitfield" class="check" title="재무" value="08"/><label for="">재무</label><input type="checkbox" id="" name="recruitfield" class="check" title="고객지원" value="09"/><label for="">고객지원</label></td>
						</tr>
						
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>대상</label></th>
					          <td><%  
									codeParam = new CodeParam();
									codeParam.setType("select"); 
									codeParam.setStyleClass("input1");
									codeParam.setName("career");
									//codeParam.setSelected(btxt); 
									out.print(CommonUtil.getCodeList(codeParam,"H02")); 
							  %></td>
						</tr>
        
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>접수일</label></th>
							<td><span class="ico_calendar"><input id="calendarData1" name="recruit_start" class="text" style="width:100px;"/></span><input type="hidden"  class="in_txt"  style="width:80px" value=""/>&nbsp;&nbsp;~&nbsp;&nbsp;<span class="ico_calendar"><input id="calendarData2" name="recruit_end" class="text" style="width:100px;"/></span><input type="hidden"  class="in_txt"  style="width:80px" value=""/></td>
						</tr>
						</tbody>
					</table>
				</fieldset>
				</form>
				<!-- //등록 -->
				<!-- Bottom 버튼영역 -->
				<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>등록</span></a><a href="javascript:cancle();" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
				<!-- //Bottom 버튼영역 -->
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