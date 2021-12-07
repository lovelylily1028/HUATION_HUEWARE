<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>SMS 예약 내역</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
</head>
<body>
<!-- 팝업사이즈 : width:834px / height:574px; -->
<div id="wrapWp" class="smsSendPageList">
	<!-- header -->
	<div id="headerWp">
	<%@ include file="/jsp/hueware/common/include/smsTop.jsp" %>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp" class="smsSendPageList_area">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<!-- 조회 -->
			<form method="post" action="" class="search">
			<fieldset>
				<legend>검색</legend>
				<ul>
					<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
					<li><span class="ico_calendar"><input type="text" class="text textdate" title="검색시작일" id="" /></span> ~ <span class="ico_calendar"><input type="text" class="text textdate" title="검색종료일" id="" /></span></li>
					<li><a href="#none" class="btn_type01 md0"><span>검색</span></a></li>
				</ul>
			</fieldset>
			</form>
			<!-- //조회 -->
		</div>
		<!-- //컨텐츠 상단 영역 -->
		<!-- 리스트 -->
		<table class="tbl_type tbl_type_list" summary="SMS예약내역(선택, 구분, 발신자, 수신자, 전송일시, 상세)">
			<colgroup>
				<col width="35px" />
				<col width="15%" />
				<col width="20%" />
				<col width="*" />
				<col width="17%" />
				<col width="9%" />
			</colgroup>
			<thead>
			<tr>
				<th><input type="checkbox" id="" class="check md0" title="전체선택" /></th>
				<th>구분</th>
				<th>발신자</th>
				<th>수신자</th>
				<th>전송일시</th>
				<th>상세</th>
			</tr>
			</thead>
			<tfoot>
			<tr>
				<td colspan="6"><strong>검색결과 : <span>52</span>건</strong></td>
			</tr>
			</tfoot>
			<tbody>
			<tr>
				<td><input type="checkbox" id="" class="check md0" title="선택" /></td>
				<td>부가서비스</td>
				<td>나상욱<br />010-1234-5678</td>
				<td>나상욱<br />010-1234-5678 외 3명</td>
				<td>201-07-04 12:12:12</td>
				<td><a href="#none" class="btn_type03"><span>상세정보</span></a></td>
			</tr>
			<tr>
				<td><input type="checkbox" id="" class="check md0" title="선택" /></td>
				<td>부가서비스</td>
				<td>나상욱<br />010-1234-5678</td>
				<td>나상욱<br />010-1234-5678 외 3명</td>
				<td>201-07-04 12:12:12</td>
				<td><a href="#none" class="btn_type03"><span>상세정보</span></a></td>
			</tr>
			<tr>
				<td><input type="checkbox" id="" class="check md0" title="선택" /></td>
				<td>부가서비스</td>
				<td>나상욱<br />010-1234-5678</td>
				<td>나상욱<br />010-1234-5678 외 3명</td>
				<td>201-07-04 12:12:12</td>
				<td><a href="#none" class="btn_type03"><span>상세정보</span></a></td>
			</tr>
			<tr>
				<td><input type="checkbox" id="" class="check md0" title="선택" /></td>
				<td>부가서비스</td>
				<td>나상욱<br />010-1234-5678</td>
				<td>나상욱<br />010-1234-5678 외 3명</td>
				<td>201-07-04 12:12:12</td>
				<td><a href="#none" class="btn_type03"><span>상세정보</span></a></td>
			</tr>
			<tr>
				<td><input type="checkbox" id="" class="check md0" title="선택" /></td>
				<td>부가서비스</td>
				<td>나상욱<br />010-1234-5678</td>
				<td>나상욱<br />010-1234-5678 외 3명</td>
				<td>201-07-04 12:12:12</td>
				<td><a href="#none" class="btn_type03"><span>상세정보</span></a></td>
			</tr>
			</tbody>
		</table>
		<!-- //리스트 -->
		<!-- 페이징 -->
		<div class="paging">
			<a href="#none" class="btn btn_first"><span class="hidden_obj">처음페이지</span></a><a href="#none" class="btn btn_prev"><span class="hidden_obj">이전페이지</span></a>
			<strong>1</strong>
			<a href="#none">2</a>
			<a href="#none">3</a>
			<a href="#none">4</a>
			<a href="#none">5</a>
			<a href="#none">6</a>
			<a href="#none">7</a>
			<a href="#none">8</a>
			<a href="#none">9</a>
			<a href="#none">10</a>
			<a href="#none" class="btn btn_next"><span class="hidden_obj">다음페이지</span></a><a href="#none" class="btn btn_last"><span class="hidden_obj">마지막페이지</span></a>
		</div>
		<!-- //페이징 -->
		<!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaR"><a href="companyRegistForm.html" class="btn_type01 md0"><span>예약취소</span></a></div>
		<!-- //Bottom 버튼영역 -->
	</div>
	<!-- //content -->
</div>
</body>
</html>