<%@page import="java.util.Map"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>휴가반려</title>
<%

Map model = (Map)request.getAttribute("MODEL"); 
HollyDTO hollyDto = (HollyDTO)model.get("hollyDto");
String Seq = (String)model.get("Seq");
String State = (String)model.get("State");
String Sign = (String)model.get("Sign");

%>
</head>
<body>
<!-- 팝업사이즈 : width:350px -->
	<!-- content -->
	<div id="contentLp">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<!-- 필수입력사항텍스트 -->
			<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
			<!-- //필수입력사항텍스트 -->
		</div>
		<!-- //컨텐츠 상단 영역 -->
		<!-- 등록 -->
		<div class="leaveReturn">
			<form method="post" name ="LeaveReturnForm" action="">
			<fieldset>
				<legend>휴가반려</legend>
				<table class="tbl_type" summary="휴가반려(사유)">
					<colgroup>
						<col width="25%" />
						<col width="*" />
					</colgroup>
					<tbody>
					<tr>
						<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>사유</label></th>
						<td><textarea id="ReturnReason" name="ReturnReason" title="사유" style="width:219px;height:45px;"><%=hollyDto.getReturnReason()%></textarea></td>
					</tr>
					</tbody>
				</table>
			</fieldset>
			</form>
		</div>
		<!-- //등록 -->
		<!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaC"><a href="javascript:Sign('<%=Seq%>','<%=State%>','<%=Sign%>');" class="btn_type02"><span>반려</span></a><a href="javascript:goClose($('#ReturnForm'));" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
		<!-- //Bottom 버튼영역 -->
	</div>
	<!-- //content -->
</body>
</html>