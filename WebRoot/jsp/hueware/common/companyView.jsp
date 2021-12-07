<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.company.CompanyDTO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%

	CompanyDTO compDto = (CompanyDTO)model.get("compDto");

	//CompanyMasterDTO dto=(CompanyMasterDTO)request.getAttribute("dto");
	//CodeParam codeParam = null;	// 코드생성

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>공급받는자 상세정보</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/script.js"></script>
</head>

<body onLoad="init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>공급받는자 상세정보</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- 등록 -->
<form  method="post" name=UserRegist action="<%= request.getContextPath()%>/H_User.do?cmd=userRegist">
	<fieldset>
		<legend>공급받는자 상세정보</legend>
		<table class="tbl_type" summary="공급받는자 상세정보(사업자등록번호, 법인등록번호(주민등록번호), 상호(법인명), 대표자명, 업태, 종목, 본점소재지)">
        <caption>공급자 받는자 상세정보</caption>
        	<colgroup>
				<col width="30%" />
				<col width="*" />
			</colgroup>
			<tbody>
			<tr>
				<th><label for="">사업자등록번호</label></th>
				<!-- COMP_CODE = > PERMIT_NO로 변경함. 사업자코드가아닌 사업자번호로 뷰잉 -->
				<td><input type="text" name="permit_no" class="text"  title="사업자등록번호" style="width:200px;" value="<%=compDto.getPermit_no()%>" readOnly></td>
			</tr>
			<tr>
				<th><label for="">법인등록번호(주민등록번호)</label></th>
				<td><input type="text" name="comp_no" class="text"  title="법인등록번호(주민등록번호)" style="width:200px;" value="<%=compDto.getComp_no()%>" readOnly></td>
			</tr>
			<tr>
				<th><label for="">상호(법인명)</label></th>
				<td><input type="text" name="comp_nm" class="text"  title="상호(법인명)" style="width:300px;" value="<%=compDto.getComp_nm()%>" readOnly></td>
			</tr>
			<tr>
				<th><label for="">대표자명</label></th>
				<td><input type="text" name="owner_nm" class="text" title="대표자명" style="width:200px;" value="<%=compDto.getOwner_nm()%>" readOnly></td>
			</tr>
			<tr>
				<th><label for="">업태</label></th>
				<td><input type="text" name="business" class="text" title="업태" style="width:300px;" value="<%=compDto.getBusiness()%>" readOnly></td>
			</tr>
			<tr>
				<th><label for="">종목</label></th>
				<td><input type="text" name="b_item" class="text" title="종목" style="width:300px;" value="<%=compDto.getB_item()%>" readOnly></td>
			</tr>
			<tr>
				<th><label for="">본점소재지</label></th>
				<td>
				<ul class="listD">
				<li class="first"><input type="text" name="post" readOnly class="text" title="우편번호" style="width:80px;" value="<%=compDto.getPost()%>" ></li>
				<li><input type="text" readOnly name="address" class="text" title="기본주소" style="width:300px;" value="<%=compDto.getAddress()%>"></li>
				<li><input type="text" name="addr_detail" class="text" title="상세주소" style="width:300px;" readOnly value="<%=compDto.getAddr_detail()%>"></li>
				</ul>
				</td>
			</tr>
			</tbody>
		</table>
		</fieldset>
		</form>
    <!-- //등록 -->
    <!-- button -->
    <div class="Bbtn_areaC">
      <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>닫기</span></a></div>
    </div>
    <!-- //button -->
    </div>
	<!-- //content -->
  </div>
  </form>
</body>
</html>