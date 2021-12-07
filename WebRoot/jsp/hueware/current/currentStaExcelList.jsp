<%@ page contentType="application/vnd.ms-excel; charset=euc_kr"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huation.framework.util.*"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.currentstatus.CurrentStatusDTO"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%
	//�����    ���x  IDString SessionUserID ="";
	//����ڸ� ���x  String SessionUserName = "";
	
	String fileName ="";

	Map model = (Map)request.getAttribute("MODEL");
	String todayDate = new SimpleDateFormat("yyyy��MMMMdd��").format(new java.util.Date());
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
		<div><strong><font size=6></font>����������Ȳ ����</strong><div align="right"><%=todayDate %></div></div>
		
		<table width="100%" cellpadding=0 cellspacing=0 border="1" style="border-collapse:collapse;">
			 <tr height="25" bgcolor="#F8F9FA">
		       <td align="center" rowspan="2" width="3"><strong>Q</strong></td>
		       <td align="center" rowspan="2" width="3"><strong>No.</strong></td>
		       <td align="center"  width="20"><strong>�����ְ���</strong></td>
		       <td align="center"  width="15"><strong>����</strong></td>
		       <td align="center" rowspan="2" width="30"><strong>���� ������Ʈ��</strong></td>
		       <td align="center" rowspan="2" width="15"><strong>������־� <br>(VAT ����)</br></strong></td>
		       <td align="center"  width="10"><strong>������ȣ</strong></td>
		       <td align="center"  width="30" colspan="4"><strong>���ְ��ɼ�</strong></td>
		       <td align="center" rowspan="2" width="10"><strong>����ñ�</strong></td>
		       <td align="center" rowspan="2" width="3"><strong>����<br>����</br></strong></td>
		       <td align="center" rowspan="2"><strong>����о� </br>�����η�</strong></td>
		       
      		</tr>

 	  <tr height="25" bgcolor="#F8F9FA">
 	   <td align="center"><strong>��ǰ�ڵ�</strong></td>
 	   <td align="center"><strong>�����ְ��� �����</strong></td>
 	   <td align="center"><strong>������ȣ</strong></td>
 	   <td align="center" colspan="4"><strong>��翵��</strong></td>
 	  </tr>
		<!-- :: loop :: -->
		 <!--����Ʈ---------------->
        <!-- :: loop :: -->
        <%
			int rows1 = 2; //�б⺰ �� ������ ���� �þ�� Rowspan ��.
        	int totalQ = 0; //�б⺰�� ���� �����Ǵ� 1,2,3,4Sub Total Į��
        	int totalQN = 0;
        	int totalY = 0; //�⵵���� ���� �����Ǵ� ������ Row �������� 4�б�(ex:12���϶� �����Ǵ�) Annual Total Į��
        	int totalYC = 0; //�⵵���� ���� �����Ǵ� ������ Row �������� 4�б�(ex:12���϶� �����Ǵ�) Annual Total Į��
        	int nn1 = 1; //Q rowspan
        	int pList=1; //�⵵���� ����� ù��° Į�� ������ ���� ���� ����.
        	
	     	
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
                    	
                    	String Q = ds.getString("Quarter"); 
                    	int totalCntQN = ds.getInt("totalCountQ"); //�⵵+�б⺰�� ī��Ʈ Sub Total Į���� ���.
						int qc = ds.getInt("totalCountQ");
            	        totalQ++;
            	        totalY++;
            	        totalYC++;
            	        totalQN++;
            	        
            	 
            	
            	        
        %>		
        
        <%
        	//���ֻ��� 1,2,3(Y���,N�̰��)
	     	String fColor = "";
	     	String status = ds.getString("OrderStatus");
	     	if(status.equals("Y")){
        		fColor="green";
        		status="���";
        	}else if(status.equals("N")){
        		status="�̰��";
        	}
        %>
        
        
	<!-- �б⺰ ����Ʈ 1Q ����-->
	
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
	     	<td rowspan="2" align="right"><font color="<%=fColor%>"><%=NumberUtil.getPriceFormat(ds.getLong("SalesProjections"))%>��</font></td>	
	     	<td><font color="<%=fColor%>"><%=ds.getString("PublicNo") %></font></td> <!-- ������ȣ ���� �ΰ�. -->
	     
	     	<td colspan="4" align="center"><font color="<%=fColor%>"><strong><%=ds.getString("OrderbleNm") %></strong></font></td>
	     
	   
	     	<td rowspan="2" align="center"><font color="<%=fColor%>"><%=ds.getString("DateProjections") %></font></td>
	     	<td rowspan="2" align="center"><font color="<%=fColor%>"><strong><%=status%></strong></font></td>
	     	<td rowspan="2"><font color="<%=fColor%>"><%=ds.getString("AssignPerson") %></font></td>
      </tr>
	      <tr>
	     	<td><font color="<%=fColor%>"><%=ds.getString("ProductNm") %></font></td>
	     	<td><font color="<%=fColor%>"><%=ds.getString("SalesMan") %></font></td>
	     
	     	<td><font color="<%=fColor%>"><%=ds.getString("P_PublicNo") %></font></td><!--������ȣ ����ΰ�. -->
	    
	     	<td><font color="<%=fColor%>">��:</font></td>
	     	<td><font color="<%=fColor%>"><%=ds.getString("ChargeNm") %></font></td>
	     	<td><font color="<%=fColor%>">��:</font></td>
	   
	     	<td><font color="<%=fColor%>"><%=ds.getString("ChargeSeNm") %></font></td>
	     	
	     </tr>

	     <%
			 
	         String Year = ds.getString("DatePjYear"); //��
	         int Mon = ds.getInt("DatePjMon"); //��
	         int Quarter = ds.getInt("Quarter"); //�б�
	         int totalCntQ = ds.getInt("totalCountQ"); //�⵵+�б⺰�� ī��Ʈ Sub Total Į���� ���.
	         int totalCntY = ds.getInt("totalCountY"); //�⵵�� ��ī��Ʈ  Annual Total Į���� ���.
	         int totalCntYC = ds.getInt("totalCountY"); //�⵵�� ��ī��Ʈ  Annual Total Į���� ���.
	              
	         //�б⺰ Row ������ �� �� �⵵+�б⺰ ī��Ʈ �� �� ������ ����.
	         if(totalQ == totalCntQ){
	        	 
	       %>
	       
		<!-- �б⺰ Sub Total(�б� �Ѹ����) �ݾ� 1,2,3,4 Į�� ���� ���� -->
	           <tr>
		        <td colspan="5" align="center"><%=Quarter%>Q Sub Total <%=totalQ %></td>
		        <td align="right"><%=NumberUtil.getPriceFormat(ds.getLong("totalPriceQ"))%>��</td>
		        <td colspan="8" align="right"></td>
		       </tr>
	        <%
	        	 nn1= 1; //No. �ѹ� �ʱ�ȭ
	        	 totalQ = 0; //�⵵��+�б⺰ ��ī��Ʈ
	         }
	        %>
		       
			<%
			//�⵵�� Row ������ �� �� �⵵ ī��Ʈ �� �� ���� �� ����.
				if(totalY == totalCntY){					
			%>
			 <tr>
		<!--�ش�⵵ 1,2,3,4 �б� �� ������ �б� �� Annual Total(�⵵ �Ѹ����) Į������ -->		
		       <td colspan="5" align="center">Annual Total <%=totalCntY %></td>
		       <td align="right"><%=NumberUtil.getPriceFormat(ds.getLong("totalPriceY"))%>��</td>
		       <td colspan="8" align="right"><%=Year %>�⵵ ����������Ȳ</td>
		       </tr> 
			<%
				  totalY = 0; //�⵵�� ��ī��Ʈ
				}					
			%>	
	    <!-- Sub Total /  Annual Total ���� ��. -->  
				     <%
				     //������ ++���� �� �⵵ ī��Ʈ�� �����鼭 ������LIST++���� �� ��Żī��Ʈ�� Ʋ���� ���� Į������.
				     	if(totalCntYC == totalYC){
				     		if(pList != ld.getTotalItemCount()){
				     			
				     		
				     %>
				    

      		<tr height="25" bgcolor="#F8F9FA">
		       <td align="center" rowspan="2" width="3"><strong>Q</strong></td>
		       <td align="center" rowspan="2" width="3"><strong>No.</strong></td>
		       <td align="center"  width="15"><strong>��û��</strong></td>
		       <td align="center"  width="15"><strong>������</strong></td>
		       <td align="center" rowspan="2" width="30"><strong>������Ʈ��</strong></td>
		       <td align="center" rowspan="2" width="15"><strong>�������� <br>(VAT ����)</br></strong></td>
		       <td align="center"  width="10"><strong>������ȣ</strong></td>
		       <td align="center"  width="30" colspan="4"><strong>���ְ��ɼ�</strong></td>
		       <td align="center"  width="10"><strong>���</strong></td>
		       <td align="center" rowspan="2" width="10"><strong>����ñ�</strong></td>
		       <td align="center" rowspan="2" width="5"><strong>����<br>����</br></strong></td>
      		</tr>

		 	  <tr height="25" bgcolor="#F8F9FA">
		 	   <td align="center"><strong>��ǰ�ڵ�</strong></td>
		 	   <td align="center"><strong>�������</strong></td>
		 	   <td align="center"><strong>������ȣ</strong></td>
		 	   <td align="center" colspan="4"><strong>��翵��</strong></td>
		 	   <td align="center"><strong>�����η�</strong></td>
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
				<td colspan="14" align="center" class="td5">�Խù��� �����ϴ�.</td>
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
