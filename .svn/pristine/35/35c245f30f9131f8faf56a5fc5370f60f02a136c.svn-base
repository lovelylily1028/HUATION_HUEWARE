<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.currentstatus.CurrentStatusDTO"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%
	//사용자    사용x  IDString SessionUserID ="";
	//사용자명 사용x  String SessionUserName = "";
	
	String fileName ="";

	Map model = (Map)request.getAttribute("MODEL");
	String todayDate = new SimpleDateFormat("yyyy년MMMMdd일").format(new java.util.Date());
	response.setHeader("Content-Disposition", "attachment; fileName=currentstatus.xls");
	response.setHeader("Content-Description", "JSP Generated Data");
	CurrentStatusDTO csDTO = (CurrentStatusDTO)model.get("csDTO");
	
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
</head>
<body>
<%
	ListDTO ld = (ListDTO) model.get("listInfo");
	DataSet ds = (DataSet) ld.getItemList();
%>
	
<table width="820" cellspacing="0" cellpadding="0" border="1" style="margin:30 0 0 0;">
	<tr>
		<td width="100%">
		<div><strong><font size=6></font>영업진행현황 내역</strong><div align="right"><%=todayDate %></div></div>
		
		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			 <tr height="25" bgcolor="#F8F9FA">
		       <td align="center" rowspan="2" width="3"><strong>Q</strong></td>
		       <td align="center" rowspan="2" width="3"><strong>No.</strong></td>
		       <td align="center"  width="20"><strong>영업주관사</strong></td>
		       <td align="center"  width="15"><strong>고객사</strong></td>
		       <td align="center" rowspan="2" width="30"><strong>예상 프로젝트명</strong></td>
		       <td align="center" rowspan="2" width="15"><strong>예상수주액 <br>(VAT 별도)</br></strong></td>
		       <td align="center"  width="10"><strong>견적번호</strong></td>
		       <td align="center"  width="30" colspan="4"><strong>수주가능성</strong></td>
		       <td align="center" rowspan="2" width="10"><strong>예상시기</strong></td>
		       <td align="center" rowspan="2" width="3"><strong>수주<br>상태</br></strong></td>
		       <td align="center" rowspan="2"><strong>기술분야 </br>배정인력</strong></td>
		       
      		</tr>

 	  <tr height="25" bgcolor="#F8F9FA">
 	   <td align="center"><strong>상품코드</strong></td>
 	   <td align="center"><strong>영업주관사 담당자</strong></td>
 	   <td align="center"><strong>모발행번호</strong></td>
 	   <td align="center" colspan="4"><strong>담당영업</strong></td>
 	  </tr>
		<!-- :: loop :: -->
		 <!--리스트---------------->
        <!-- :: loop :: -->
        <%
			int rows1 = 2; //분기별 총 갯수로 인해 늘어나는 Rowspan 값.
        	int totalQ = 0; //분기별로 인해 생성되는 1,2,3,4Sub Total 칼럼
        	int totalQN = 0;
        	int totalY = 0; //년도별로 인해 생성되는 마지막 Row 데이터의 4분기(ex:12월일때 생성되는) Annual Total 칼럼
        	int totalYC = 0; //년도별로 인해 생성되는 마지막 Row 데이터의 4분기(ex:12월일때 생성되는) Annual Total 칼럼
        	int nn1 = 1; //Q rowspan
        	int pList=1; //년도별로 생기는 첫번째 칼럼 생성을 위해 쓰는 변수.
        	
	     	
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
                    	
                    	String Q = ds.getString("Quarter"); 
                    	int totalCntQN = ds.getInt("totalCountQ"); //년도+분기별총 카운트 Sub Total 칼럼에 사용.
						int qc = ds.getInt("totalCountQ");
            	        totalQ++;
            	        totalY++;
            	        totalYC++;
            	        totalQN++;
            	        
            	 
            	
            	        
        %>		
        
        <%
        	//수주상태 1,2,3(Y계약,N미계약)
	     	String fColor = "";
	     	String status = ds.getString("OrderStatus");
	     	if(status.equals("Y")){
        		fColor="green";
        		status="계약";
        	}else if(status.equals("N")){
        		status="미계약";
        	}
        %>
        
        
	<!-- 분기별 리스트 1Q 시작-->
	
        <%
        if(Q.equals("1")){      	
        %>
        	<td rowspan="2" bgcolor="#F8F9FA">1Q</td>
        <%
        }if(Q.equals("2")){        	
        %>
        	<td rowspan="2" bgcolor="#F8F9FA">2Q</td> 
        <%
        }if(Q.equals("3")){        	
        %>
			<td rowspan="2" bgcolor="#F8F9FA">3Q</td>
        <%
        }if(Q.equals("4")){        	
        %>
			<td rowspan="2" bgcolor="#F8F9FA">4Q</td>
        <%
        }
        %>
     
       			
	     	<td rowspan="2" align="center"><%=nn1++ %></td>     
	     	<td><font color="<%=fColor%>"><%=ds.getString("EnterpriseNm") %></font></td>
	     	<td><font color="<%=fColor%>"><%=ds.getString("OperatingCompany") %></font></td>
	     	<td rowspan="2" align="left"><font color="<%=fColor%>"><%=ds.getString("ProjectName") %></font></td>
	     	<td rowspan="2" align="right"><font color="<%=fColor%>"><%=NumberUtil.getPriceFormat(ds.getLong("SalesProjections"))%>원</font></td>	
	     	<td><font color="<%=fColor%>"><%=ds.getString("PublicNo") %></font></td> <!-- 견적번호 현재 널값. -->
	     
	     	<td colspan="4" align="center"><font color="<%=fColor%>"><strong><%=ds.getString("OrderbleNm") %></strong></font></td>
	     
	   
	     	<td rowspan="2" align="center"><font color="<%=fColor%>"><%=ds.getString("DateProjections") %></font></td>
	     	<td rowspan="2" align="center"><font color="<%=fColor%>"><strong><%=status%></strong></font></td>
	     	<td rowspan="2"><font color="<%=fColor%>"><%=ds.getString("AssignPerson") %></font></td>
      </tr>
	      <tr>
	     	<td><font color="<%=fColor%>"><%=ds.getString("ProductNm") %></font></td>
	     	<td><font color="<%=fColor%>"><%=ds.getString("SalesMan") %></font></td>
	     
	     	<td><font color="<%=fColor%>"><%=ds.getString("P_PublicNo") %></font></td><!--모발행번호 현재널값. -->
	    
	     	<td><font color="<%=fColor%>">정:</font></td>
	     	<td><font color="<%=fColor%>"><%=ds.getString("ChargeNm") %></font></td>
	     	<td><font color="<%=fColor%>">부:</font></td>
	   
	     	<td><font color="<%=fColor%>"><%=ds.getString("ChargeSeNm") %></font></td>
	     	
	     </tr>

	     <%
			 
	         String Year = ds.getString("DatePjYear"); //년
	         int Mon = ds.getInt("DatePjMon"); //월
	         int Quarter = ds.getInt("Quarter"); //분기
	         int totalCntQ = ds.getInt("totalCountQ"); //년도+분기별총 카운트 Sub Total 칼럼에 사용.
	         int totalCntY = ds.getInt("totalCountY"); //년도별 총카운트  Annual Total 칼럼에 사용.
	         int totalCntYC = ds.getInt("totalCountY"); //년도별 총카운트  Annual Total 칼럼에 사용.
	              
	         //분기별 Row 데이터 와 총 년도+분기별 카운트 비교 시 같을때 시작.
	         if(totalQ == totalCntQ){
	        	 
	       %>
	       
		<!-- 분기별 Sub Total(분기 총매출액) 금액 1,2,3,4 칼럼 생성 시작 -->
	           <tr>
		        <td colspan="5" align="center"><%=Quarter%>Q Sub Total <%=totalQ %></td>
		        <td align="right"><%=NumberUtil.getPriceFormat(ds.getLong("totalPriceQ"))%>원</td>
		        <td colspan="8" align="right"></td>
		       </tr>
	        <%
	        	 nn1= 1; //No. 넘버 초기화
	        	 totalQ = 0; //년도별+분기별 총카운트
	         }
	        %>
		       
			<%
			//년도별 Row 데이터 와 총 년도 카운트 비교 시 같을 때 시작.
				if(totalY == totalCntY){					
			%>
			 <tr>
		<!--해당년도 1,2,3,4 분기 중 마지막 분기 시 Annual Total(년도 총매출액) 칼럼생성 -->		
		       <td colspan="5" align="center">Annual Total <%=totalCntY %></td>
		       <td align="right"><%=NumberUtil.getPriceFormat(ds.getLong("totalPriceY"))%>원</td>
		       <td colspan="8" align="right"><%=Year %>년도 영업진행현황</td>
		       </tr> 
			<%
				  totalY = 0; //년도별 총카운트
				}					
			%>	
	    <!-- Sub Total /  Annual Total 생성 끝. -->  
				     <%
				     //데이터 ++수와 총 년도 카운트와 같으면서 데이터LIST++수와 총 토탈카운트가 틀리면 하위 칼럼생성.
				     	if(totalCntYC == totalYC){
				     		if(pList != ld.getTotalItemCount()){
				     			
				     		
				     %>
				    

      		<tr height="25" bgcolor="#F8F9FA">
		       <td align="center" rowspan="2" width="3"><strong>Q</strong></td>
		       <td align="center" rowspan="2" width="3"><strong>No.</strong></td>
		       <td align="center"  width="15"><strong>원청사</strong></td>
		       <td align="center"  width="15"><strong>영업사</strong></td>
		       <td align="center" rowspan="2" width="30"><strong>프로젝트명</strong></td>
		       <td align="center" rowspan="2" width="15"><strong>예상매출액 <br>(VAT 별도)</br></strong></td>
		       <td align="center"  width="10"><strong>견적번호</strong></td>
		       <td align="center"  width="30" colspan="4"><strong>수주가능성</strong></td>
		       <td align="center"  width="10"><strong>비고</strong></td>
		       <td align="center" rowspan="2" width="10"><strong>예상시기</strong></td>
		       <td align="center" rowspan="2" width="5"><strong>수주<br>상태</br></strong></td>
      		</tr>

		 	  <tr height="25" bgcolor="#F8F9FA">
		 	   <td align="center"><strong>상품코드</strong></td>
		 	   <td align="center"><strong>영업사원</strong></td>
		 	   <td align="center"><strong>모발행번호</strong></td>
		 	   <td align="center" colspan="4"><strong>담당영업</strong></td>
		 	   <td align="center"><strong>배정인력</strong></td>
		 	  </tr>
   	 
 	   <%totalYC=0;
				     		}
				     	}
				     %>
		<!-- :: loop :: -->
        	<%
                i++;
        		pList++;
                    }
                    
                } else {
            %>
			<tr align=center valign=top>
				<td colspan="14" align="center" class="td5">게시물이 없습니다.</td>
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
