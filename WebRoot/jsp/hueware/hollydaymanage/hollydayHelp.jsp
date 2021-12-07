<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>휴가구분안내</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
</head>
<body>
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>휴가구분 안내</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp" class="leaveGuide">
		<!-- 내용 -->
		<dl>
			<dt><span>1</span>병가란?</dt>
			<dd>질병, 부상 등의 사유 발생 시 신청할 수 있는 무급휴가</dd>
			<dt><span>2</span>공가란?</dt>
			<dd>다음의 사유 발생 시 신청할 수 있는 유급휴가
				<ul>
					<li>- 공무로 법원 등에 소환된 경우</li>
					<li>- 법률에 의한 선거권을 사용하는 경우</li>
					<li>- 병역검사, 근로동원기간, 예비군훈련, 민방위 훈련에 소집된 경우</li>
					<li>- 천재지변, 화재, 수재, 교통차단 등 기타 재해의 사유로 출근이 불가한 경우</li>
				</ul>
			</dd>
			<dt><span>3</span>복리휴가란?</dt>
			<dd>다음의 사유 발생시 신청할 수 있는 유급휴가
				<table class="tbl_type tbl_type_info" summary="복리휴가 상세 내용">
					<colgroup>
						<col width="24%" />
						<col width="*" />
						<col width="24%" />
					</colgroup>
					<thead>
					<tr>
						<th colspan="2">구분</th>
						<th>휴가일수</th>
					</tr>
					</thead>
					<tbody>
						<tr>
							<th>장기근속</th>
							<td>4년 주기</td>
							<td class="text_c">5일</td>
						</tr>
					</tbody>
				</table>
			</dd>
			<dt><span>4</span>무급휴가란?</dt>
			<dd>개인적인 사정으로 급여를 받지 않는 조건으로 신청할 수 있는 휴가</dd>
		</dl>
		<!-- //내용 -->
		<!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaC"><a href="javascript:window.close();" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
		<!-- //Bottom 버튼영역 -->
	</div>
	<!-- contents -->
</div>
</body>
</html>