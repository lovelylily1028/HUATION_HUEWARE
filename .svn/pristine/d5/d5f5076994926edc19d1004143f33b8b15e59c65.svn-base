<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.CommonDAO"%>
<%@ page import ="com.huation.common.invoice.InvoiceDTO"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%@ page import="com.baroservice.ws.BaroService_TISoapProxy"%>
<%@ page import="com.baroservice.ws.TaxInvoiceState"%>
<%

	CommonDAO comDao=new CommonDAO();

	Map model = (Map)request.getAttribute("MODEL");
    ArrayList<InvoiceDTO> arrlist = (ArrayList) model.get("listInfo");

	response.setHeader("Content-Disposition", "attachment; filename=invoiceExcel.xls");
	response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
.xl65
	{mso-style-parent:style0;
	mso-number-format:"\@";}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>세금계산서 리스트</title>
</head>

<body>
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div align=center><strong><font size=6>세금계산서 리스트</font></strong></div>
		

		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			  <tr height="25" bgcolor="#F8F9FA">
				<td rowspan="2" align="center"><strong>발행종류</strong></td>
				<td rowspan="2" align="center"><strong>상태</strong></td>
				<td rowspan="2" align="center"><strong>품명</strong></td>
				<td rowspan="2" align="center"><strong>발행일자</strong></td>   
				<td colspan="2" align="center"><strong>공급받는자</strong></td>
				<td colspan="3" align="center"><strong>공급액</strong></td>
				<td rowspan="2" align="center"><strong>입금예상일자</strong></td>
				<td rowspan="2" align="center"><strong>입금액</strong></td>
				<td rowspan="2" align="center"><strong>입금일자</strong></td>
				<td rowspan="2" align="center"><strong>개봉</strong></td>
						  
			  </tr>
			   <tr height="25" bgcolor="#F8F9FA">
			   
				<td align="center"><strong>사업자등록번호</strong></td>
				<td align="center"><strong>상호</strong></td>
				<td align="center"><strong>공급가</strong></td>
				<td align="center"><strong>부가세</strong></td>
				<td align="center"><strong>합계</strong></td>
			</tr>		 
		<!-- :: loop :: -->
		<!--리스트---------------->
		<%
		if(arrlist.size() > 0){	
			int i = 0;
			String state="";
			String dipositYN="";
			String issuetype="";
			String issuetypeNo="";
			
				for(int j=0; j < arrlist.size(); j++ ){	
					InvoiceDTO dto = arrlist.get(j);
					
					  state=dto.getState();
					  issuetype=dto.getIssuetype();
					  System.out.println("-------------"+issuetype);
					  
						if(state.equals("03")){
							dipositYN="입금완료";
						}else if(state.equals("02")){
							dipositYN="발행취소";
						}else{
							dipositYN="입금대기";
						}
						
						
						  if(issuetype.equals("01")){
								
							issuetypeNo ="정발행";
						}else if(issuetype.equals("02")){
								 
						issuetypeNo="수정발행";
						} else if(issuetype.equals("03")){
									 
							issuetypeNo="역발행";
							} 
						 
		%>

			<tr bgcolor="#FFFFFF" height="23">
			
			<td align="center" class=xl65><%=issuetypeNo%></td>
			
			<td align="center"><%=dipositYN%></td>
			
			
			<%--
			<td align="center"><%=dto.getTITLE() %></td>
			 --%>
			<td align="center"><%=dto.getITEM_NAME() %></td>
			<td align="center"><%=DateTimeUtil.getDateType(1,dto.getPublic_dt(),"/")%></td>
			
			<td align="center"><%=dto.getPermit_no()%></td>
			<td align="center"><%=dto.getComp_nm()%></td>
			
			<td align="center"><%=NumberUtil.getPriceFormat(dto.getSupply_price())%></td>
			<td align="center"><%=NumberUtil.getPriceFormat(dto.getVat())%></td>
			
			<%
					long supval=Long.parseLong(dto.getSupply_price());
					long vatval=Long.parseLong(dto.getVat());
					long total=supval+vatval;
			%>  
			<td align="center"><%=NumberUtil.getPriceFormat(total)%></td>
			<td align="center"><%=DateTimeUtil.getDateType(1,dto.getPre_deposit_dt(),"/")%></td>
			<td align="center"><%=NumberUtil.getPriceFormat(dto.getDeposit_amt())%></td>
			<td align="center"><%=DateTimeUtil.getDateType(1,dto.getDeposit_dt(),"/")%></td>
		    <td align="center">
          
          <%
          if(issuetype.equals("03")){
        	  out.println("O");
          }else if(issuetype.equals("01")||issuetype.equals("02")){
        	  
        	  //String CERTKEY = "FDB60D89-8AE8-4BBB-A1AA-A708EFCD83D7";				//테스트베드인증키
  			String CERTKEY = "ED59C6A5-C0C8-4A6C-9C65-0B8E254D3640";				//실서비스 인증키
			String CorpNum = "1088193762";				//연계사업자 사업자번호 ('-' 제외, 10자리)	
			String MgtKey = dto.getMGTKEY();					//자체문서관리번호	
			
			BaroService_TISoapProxy BST = new BaroService_TISoapProxy();
			
			TaxInvoiceState Result = BST.getTaxInvoiceState(CERTKEY, CorpNum, MgtKey);
			
			int Open1 = Result.getIsOpened();
			
			if (Result.getBarobillState() < 0){	
				out.println("오류");
			}else if(Open1 ==1){	
				out.println("O");
			}else if(Open1 ==0){
				out.println("X");
			}
			
			
          }
			
          
		%>	
          
          </td>
			
				
			</tr>
		<!-- :: loop :: -->
		<%
			i++;
				}
			} else {
		%>
			<tr align=center valign=top>
				<td colspan="13" align="center" class="td5">게시물이 없습니다.</td>
			</tr>
		<%
			}
		%>
		</table>
		</td>
	</tr>
</table>									
</body>
</html>
