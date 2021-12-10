<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.contractmanage.ContractManageDTO"%>
<%
	String SessionUserID ="";//사용자 ID
	String SessionUserName = "";//사용자명
	String fileName ="";

	Map model = (Map)request.getAttribute("MODEL");

	response.setHeader("Content-Disposition", "attachment; fileName=ProjectCodeManage_Edit.xls");
	response.setHeader("Content-Description", "JSP Generated Data");
	ContractManageDTO cmDTO = (ContractManageDTO)model.get("cmDTO");
	
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
<title>프로젝트 코드(등록/수정) 리스트</title>
</head>
<body>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
	
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div ><strong><font size=6>Huation 프로젝트 코드(등록/수정) 내역 </font></strong><div align="right"></div></div>
		
		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
		 <tr height="25" bgcolor="#F8F9FA" >
	      <th align="center"><strong>No</strong></th>
          <th align="center"><strong>진행</strong></th>
          <th align="center"><strong>프로젝트 </br>코드</strong></th>
          <th align="center"><strong>프로젝트 </br>구분</strong></th>
          <th align="center"><strong>프로젝트 명</strong></th>
          <th align="center"><strong>고객사</strong></th>
          <th align="center"><strong>발주사</strong></th>
          <th align="center"><strong>담당영업</strong></th>
          <th align="center"><strong>담당PM</strong></th>
          <th align="center"><strong>프로젝트 시작일</strong></th>
          <th align="center"><strong>프로젝트 종료일</strong></th>
          <th align="center"><strong>프로젝트 진행기간</strong></th>
          <th align="center"><strong>등록자</strong></th>
          <th align="center"><strong>등록일시</strong></th>
	     </tr>
		<!-- :: loop :: -->
		<!--리스트---------------->
		<%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
                    	
                    	/*프로젝트 구분 A-신규, B-증설, C-유지보수
                      	 */
                        	String ProjectDivision = ds.getString("ProjectDivision"); //프로젝트 구분
                            String ProjectStr = "";
                        	
                            if(ProjectDivision.equals("A")){
                        		ProjectStr = "신규";
                            }else if(ProjectDivision.equals("B")){
                            	ProjectStr = "증설";
                            }else if(ProjectDivision.equals("C")){
                            	ProjectStr = "유지보수";
                            }
                        	
                            String FreeCostYN = ds.getString("FreeCostYN"); //프로젝트 구분
                            String ProjectStr2 = "";
                        	
                            if(FreeCostYN.equals("Y")){
                            	ProjectStr2 = "(유상)";
                            }else if(FreeCostYN.equals("N")){
                            	ProjectStr2 = "(무상)";
                            }
                    	
                    	String ProgressStatus = ds.getString("CheckSuccessYN");
                    	String progressStatus2 = ds.getString("ProjectEndYN");
                    	String ProgressStr = "";
                    	if(ProgressStatus.equals("N")){
                    		ProgressStr = ds.getInt("ProgressPercent")+"%";
                    	}else if(ProgressStatus.equals("Y") && progressStatus2.equals("Y")){
                    		ProgressStr = "완료";
                    	}else if(ProgressStatus.equals("Y") && progressStatus2.equals("N")){
                    		ProgressStr = "검수";
                    	}
        %>
        <tr>
       	  <td><%=i+1 %></td>
       	  <td><%=ProgressStr %></td>
          <td><%=ds.getString("ProjectCode") %></td>
          <td><%=ProjectStr %><%=ProjectStr2 %></td>
          <td><%=ds.getString("ProjectName") %></td>
          <td><%=ds.getString("CustomerName") %></td>
          <td><%=ds.getString("PurchaseName") %></td>
          <td><%=ds.getString("ChargeNm") %></td>
          <td><%=ds.getString("ChargePmNm") %></td>
          <td><%=ds.getString("StartDate") %></td>
          <td><%=ds.getString("EndDate") %></td>
          <td><%=ds.getString("ProgressDate") %>일</td>
          <td><%=ds.getString("ProjectCreateUserNm") %></td>
          <td><%=ds.getString("CreateDate") %></td>       
        </tr>
        <!-- :: loop :: -->
        <%
                i++;
                    }
                } else {
            %>
        <tr>
          <td colspan="14">게시물이 없습니다.</td>
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
