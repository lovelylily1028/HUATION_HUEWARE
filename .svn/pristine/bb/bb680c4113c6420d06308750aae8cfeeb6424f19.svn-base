<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%@ page import ="com.huation.common.huebooklist.HueBookListDTO" %>
<%@ page import="com.huation.common.user.UserBroker"%>
<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	HueBookListDTO hlDto = (HueBookListDTO)model.get("hlDto");
	String a="";
	String b="";
	if(hlDto.getUseYN().equals("Y")){
		a = "Selected='Selected'";
	}else if(hlDto.getUseYN().equals("N")){
		b = "Selected='Selected'";
	}	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>HueBook 도서 상세보기</title>
<script language="JavaScript">
<!--

function goSave(){
	var frm = document.hueBookView; 
	
	if(confirm("수정하시겠습니까?")){
		  frm.action='<%=request.getContextPath()%>/B_HueBookList.do?cmd=hueBookListEdit'	
	
	if(frm.bookName.value == ""){
		alert("도서명을 입력하세요.");
		return;
	}
	if(frm.writer.value == ""){
		alert("저자를 입력하세요.");
		return;
	}
	if(frm.branchCode.value == ""){
		alert("분야를 선택하세요.");
		return;
	}
	if(frm.publisher.value == ""){
		alert("출판사를 입력하세요.");
		return;
	}
	frm.requestUser.value = frm.user_id.value;
	frm.submit();
	}
}
   //목록
	function goList(){
		
		var frm = document.hueBookView;
		frm.action='<%= request.getContextPath()%>/B_HueBookList.do?cmd=hueBookPageList';
		frm.submit();
   }
	//삭제
	function goDelete(){
		
		var frm = document.hueBookView;
		if(confirm("삭제 하시겠습니까?")){
			frm.action='<%= request.getContextPath()%>/B_HueBookList.do?cmd=hueBookDelete';
			frm.submit();
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
		<div id="content">
			<div class="content_navi">HUEBook &gt; 휴북목록</div>
			<h3><span>휴</span>북목록상세정보</h3><!-- 타이틀 앞글자는 <span></span>으로 감싸기 -->
			<div class="con" id="excelBody">
				<!-- 컨텐츠 상단 영역 -->
				<div class="conTop_area">
					<!-- 필수입력사항텍스트 -->
					<p class="must_txt"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
					<!-- //필수입력사항텍스트 -->
				</div>
				<!-- //컨텐츠 상단 영역 -->
				<!-- 등록 -->
				<form name="hueBookView" method="post">
				<input type = "hidden" name = "curPage" value="<%=curPage%>">
				<input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>">
				<input type = "hidden" name = "requestUser" value=""><!-- UserID값 담기위해 -->
				<!-- Update시 넘겨줄 히든(pk값) -->
				<input type="hidden" name="hueBookCode" value="<%=hlDto.getHueBookCode()%>"></input>
				<fieldset>
					<legend>휴북목록상세정보</legend>
					<table class="tbl_type" summary="휴북목록상세정보(관리번호, 도서명, 출판사, 저자, 분야, 구매처, 신청자, 신청일자, 결재자, 결재일자, 구매가격, 구매일자)">
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							<th><label for="">관리번호</label></th>
							<td><input type="text" id="" class="text dis" title="관리번호" style="width:200px;" name="" value="<%=hlDto.getHueBookCode()%>" readonly="readonly" /></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>도서명</label></th>
							<td><input type="text" id="" class="text" title="도서명" style="ime-mode:active;width:916px;" name="bookName" value="<%=hlDto.getBookName() %>" maxlength="50" /></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>출판사</label></th>
							<td><input type="text" id="" class="text" title="출판사" style="ime-mode:active;width:300px;" name="publisher" value="<%=hlDto.getPublisher() %>" maxlength="25" /></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>저자</label></th>
							<td><input type="text" id="" class="text" title="저자" style="ime-mode:active;width:300px;" name="writer" value="<%=hlDto.getWriter() %>" maxlength="50" /></td>
						</tr>
						<tr>
							<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>분야</label></th>
							<td><%
								CodeParam codeParam = new CodeParam();
								codeParam.setType("select"); 
								codeParam.setStyleClass("td3");
								//codeParam.setFirst("전체");
								codeParam.setName("branchCode");
								codeParam.setSelected(hlDto.getBranchCode()); 
								//codeParam.setEvent("javascript:poductSet();"); 
								out.print(CommonUtil.getCodeList(codeParam,"A08")); 
							%></td>
						</tr>
						<tr>
							<th><label for="">구매처</label></th>
							<td><input type="text" id="" class="text dis" title="구매처" style="ime-mode:active;width:300px;" name="" value="<%=hlDto.getPurchasingOffice() %>" maxlength="50" readonly="readonly" /></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for="">신청자</label></th>
							<td><input type="text" id="" class="text dis" title="신청자" style="width:200px;" name="" value="<%=hlDto.getRequestName()%>" readOnly /></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for="">신청일자</label></th>
							<td><input type="text" id="" class="text dis" style="width:100px;" name="" value="<%=hlDto.getRequestDate()%>" readonly="readonly" /><input type="hidden" name="" value="<%=hlDto.getRequestDate()%>" /></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for="">결재자</label></th>
							<td><input type="text" id="" class="text dis" title="결재자" style="width:200px;" name="" value="<%=hlDto.getApprovalName()%>" readOnly /></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for="">결재일자</label></th>
							<td><input type="text" id="" class="text dis" style="width:100px;" name="" value="<%=hlDto.getClearDate()%>" readonly="readonly" /><input type="hidden" name="" class="text" value="<%=hlDto.getClearDate()%>" /></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for="">구매가격</label></th>
							<td><input type="hidden" name="" class="text" style="width:80px" value="<%=hlDto.getBuyPrice() %>" maxlength="9"><input type="text" id="" class="text text_r dis" title="구매가격" style="ime-mode:active;width:200px;" name="buyPrice_view" value="<%=NumberUtil.getPriceFormat(hlDto.getBuyPrice()) %>" maxlength="9" readonly="readonly" /> 원</td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for="">구매일자</label></th>
							<td><input type="text" id="" class="text dis" style="width:100px;" name="" value="<%=hlDto.getBuyDate()%>" readonly="readonly" /><input type="hidden" name="" class="text" value="<%=hlDto.getBuyDate()%>" /></td><!-- input 비활성화 class="dis" 추가 -->
						</tr>
						<tr>
							<th><label for="">사용유무</label></th>
							<td>
								<select id="" name = "useYN">
									<option value="Y" <%=a%> >사용</option>
									<option value="N" <%=b%> >폐기</option>
									
								</select>
							</td>
						</tr>
						</tbody>
					</table>
				</fieldset>
				</form>
				<!-- //등록 -->
				<!-- Bottom 버튼영역 -->
				<div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>수정</span></a><a href="javascript:goDelete();" class="btn_type02 btn_type02_gray"><span>삭제</span></a><a href="javascript:goList();" class="btn_type02 btn_type02_gray"><span>목록</span></a></div>
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
<%= comDao.getMenuAuth(menulist,"52")%>