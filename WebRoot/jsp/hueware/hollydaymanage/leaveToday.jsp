<%@page import="com.huation.framework.data.DataSet"%>
<%@page import="com.huation.framework.persist.ListDTO"%>
<%@page import="com.huation.common.config.GroupDTO"%>
<%@page import="com.huation.common.config.SmsGroupDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	Map model = (Map)request.getAttribute("MODEL"); 
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" /><!-- EI9로 렌더링 -->
<title>오늘의 휴가자</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/script.js"></script>
<script type="text/javascript">

function setCookie(name, value, expiredays) {
var today = new Date();
    today.setDate(today.getDate() + expiredays);

    document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
}

function closePop() {        
if(document.leaveToday.todayPop.checked){                
setCookie('showblack', 'test', 1);
self.close();
}
}

</script>

</head>
<body>
<!-- 팝업사이즈 : width:505px -->
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>오늘의 휴가자</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<form name ="leaveToday" id="leaveToday">
	<div id="contentWp" class="leaveToday">
		<!-- 리스트 -->
		
		<table class="tbl_type tbl_type_list" summary="오늘의 휴가자(신청자, 휴가구분, 일수, 시작일, 종료일)">
			<colgroup>
				<col width="100px" />
				<col width="100px" />
				<col width="80px" />
				<col width="100px" />
				<col width="*" />
			</colgroup>
			<thead>
			<tr>
				<th>신청자</th>
				<th>휴가구분</th>
				<th>일수</th>
				<th>시작일</th>
				<th>종료일</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td colspan="5" class="tbl_type_scrollY">
					<div class="scrollY">
						<table class="tbl_type tbl_type_list" summary="오늘의 휴가자(신청자, 휴가구분, 일수, 시작일, 종료일)">
							<colgroup>
								<col width="99px" class="scrollY_FF" /><!-- tbody에 추가되는 테이블의 왼쪽 라인 삭제로 인해 width사이즈를 -1px함. -->
								<col width="100px" />
								<col width="80px" />
								<col width="100px" />
								<col width="*" />
							</colgroup>
							<tbody>
							
							<%
					                if (ld.getItemCount() > 0) {
					                    int i = 0;
					                    while (ds.next()) {
					           				 %>
												<tr>
												
													<td><%=ds.getString("UserName") %></td>
													<td><%=ds.getString("HollyFlagName") %></td>
													<td><%=ds.getString("Day") %></td>
													<td><%=ds.getString("StartDateTime").substring(0,10) %></td>
													<td><%=ds.getString("EndDateTime").substring(0,10) %></td>
													
												</tr>
										<%
								                i++;
								                    }
								                } else {
								         %>
								            <tr>
					          <td colspan="5">오늘의 휴가자가 없습니다.</td>
					        </tr>
					        	
					        	<%
					                }
					            %>
							</tbody>
						</table>
					</div>
				</td>
			</tr>
			</tbody>
		</table>
		<!-- //리스트 -->
		<!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaC"><a href="javascript:window.close();" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
		<!-- //Bottom 버튼영역 -->
		<!-- 오늘 하루 그만보기 -->
		<div class="todayClose"><input type="checkbox" name="todayPop" id="todayPop" onClick="closePop()" class="check md0"><label for="todayPop"> 오늘 하루 그만보기</label></div>
		<!-- //오늘 하루 그만보기 -->
	</div>
	</form>
	<!-- //content -->
</div>
</body>
</html>