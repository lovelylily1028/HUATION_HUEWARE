<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.framework.util.NumberUtil"%>
<%@ page import ="com.huation.framework.util.DateTimeUtil"%>
<%@ page import ="com.huation.common.invoice.InvoiceDTO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%

	//CodeDAO codeDAO = new CodeDAO();
	//CodeDTO codeDto = new CodeDTO();

	//String comp_type="";
  	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>���ݰ�꼭 ���೻��</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript">

//��Ʈ������ ���̺�
$(function(){
	$("tr:nth-child(odd)").addClass("odd");
	$("tr:nth-child(even)").addClass("even");

	//���콺������ �࿡ ���̶���Ʈȿ��
	$("tr:not(:first-child)").mouseover(function(){
		$(this).addClass("hover");
	}).mouseout(function(){
		$(this).removeClass("hover");
	});
});

<!--


	// ���⼭ ���ʹ� ó���� ǥ���ϴ� function

	function closeWaiting() {

		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'hidden';
		} else {
			if (document.layers) {
				document.loadingbar.visibility = 'hide';
			} else {
				document.all.loadingbar.style.visibility = 'hidden';
			}
		}
	}

	//���̱�
	function openWaiting( ) {
		if (document.getElementById) {
			document.getElementById('waitwindow').style.visibility = 'visible';
		} else{
			if (document.layers) {
				document.loadingbar.visibility = 'show';
			} else {
				document.all.loadingbar.style.visibility = 'visible';
			}
		}
	}

	var observer;
	
	function init() {

		openWaiting( );

		if (document.readyState == "complete") {
			window.clearTimeout(observer);
			closeWaiting();
			return;
		}
		observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
	}
//-->
</SCRIPT>
</head>
<form  method="post" name="excelform">
</form>
<!-- ó���� ���� -->
<div id="waitwindow" style="position:absolute;left:0px;top:0px;background-color:transparent;layer-background-color: transparent;height:100%;width:100%;visibility:hidden;z-index:10;">
  <table width="100%" height="100%"  border='0' cellspacing='0' cellpadding='0' style="layer-background-color: transparent;">
    <tr>
      <td align=center height=middle style="margin-top: 10px;"><table width=280 height=120 border='0' cellspacing='0' cellpadding='0'  class="bigbox" BACKGROUND = "<%= request.getContextPath()%>/image/back/ing.gif">
          <tr>
            <td align=center height=middle><img src="<%= request.getContextPath()%>/image/back/wait2.gif" width="202" height="5"></td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<!-- ó���� ���� -->
<%
	ArrayList<InvoiceDTO> arrlist= (ArrayList)model.get("arrlist");

%>
<body onLoad="init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
	<!-- title -->
    <div class="title">
      <h1>���ݰ�꼭 ���೻�� <span>(�����ȣ : <%= (String)model.get("publicno")%>) [���� : <%= (String)model.get("title")%>]</span></h1>
    </div>
    <!-- //title -->
<form  method="post" name=invoiceform action = "">
  <input type = "hidden" name = "objExcel">
  <input type = "hidden" name = "filename" value="">
  <input type = "hidden" name = "invoice_code" value="">
	<!-- //header -->
	<!-- content -->
	<div id="contentWp" class="invoiceDetailList">
	<!-- ������ ��� ���� -->
	<div class="conTop_area">
		<!-- ���̵��ؽ�Ʈ -->
		<p class="Tguide_txt">��� �ݾ��� �ΰ����� ���ԵǾ��ֽ��ϴ�.</p>
		<!-- //���̵��ؽ�Ʈ -->
	</div>
	<!-- //������ ��� ���� -->
		<!-- ����Ʈ -->
        <table class="tbl_type tbl_type_list" summary="���ݰ�꼭 ���೻��(No., �Աݿ���, ����(��������, ����ݾ�, ��������ݾ�, �̹���ݾ�), ������Ȳ(�Աݾ�, �Աݿ�������, �Ѱ����ݾ�, �����Աݾ�, ��ȸ���ݾ�, �ʰ��ݾ�))">
          <caption>���ݰ�꼭 ���೻��</caption>
          <colgroup>
				<col width="40px" />
				<col width="70px" />
				<col width="84px" />
				<col width="111px" />
				<col width="111px" />
				<col width="111px" />
				<col width="111px" />
				<col width="84px" />
				<col width="111px" />
				<col width="111px" />
				<col width="111px" />
				<col width="*" />
			</colgroup>
			<thead>
			<tr>
				<th rowspan="2">No.</th>
				<th rowspan="2">�Աݿ���</th>
				<th colspan="4">����</th>
				<th colspan="6">������Ȳ</th>
			</tr>
			<tr>
				<th>��������</th>
				<th>����ݾ�</th>
				<th>��������ݾ�</th>
				<th>�̹���ݾ�</th>
				<th>�Աݾ�</th>
				<th>�Աݿ�������</th>
				<th>�Ѱ����ݾ�</th>
				<th>�����Աݾ�</th>
				<th>��ȸ���ݾ�</th>
				<th>�ʰ��ݾ�</th>
			</tr>
			</thead>
			<tbody>
			<td colspan="12" class="tbl_type_scrollY">
				<div class="scrollY">
					<table class="tbl_type tbl_type_list">
					<colgroup>
						<col width="39px" class="scrollY_FF" /><!-- tbody�� �߰��Ǵ� ���̺��� ���� ���� ������ ���� width����� -1px��. -->
						<col width="70px" />
						<col width="84px" />
						<col width="111px" />
						<col width="111px" />
						<col width="111px" />
						<col width="111px" />
						<col width="84px" />
						<col width="111px" />
						<col width="111px" />
						<col width="111px" />
						<col width="*" />
					</colgroup>
					<tbody>
          
          <!-- :: loop :: -->
          <!--����Ʈ---------------->
          <%	
          
        long sum=0;
      	long sup=0;
      	long vat=0;
      	long sum_price=0;
      	long deposit_amt=0;
      	long deposit_amt_1=0;
      	
       
		if(arrlist.size() > 0){	
		int i = 0;
		int no = 1;
		String tcl="";
		String dipositYN="";
		
	
		for(int j=0; j < arrlist.size(); j++ ){	
			InvoiceDTO dto = arrlist.get(j);
			
			long estmate=Long.parseLong(dto.getT_estiamt());
			/*����_2013_01_17_shbyeon
			if(DateTimeUtil.getDateType(1,dto.getDeposit_dt(),"/").equals("")){
				tcl="";
				dipositYN="";
			}else{
				tcl="td3";
				dipositYN="�Ϸ�";
			}
			*/
			/*�߰� 2013_01_17_shbyeon
			  --�Աݴ��&�ԱݿϷ�� ���೻�� �����ֱ�����.
			*/
			if(dto.getState().equals("01")){
				tcl="txt_green"; //���� ����ȹٲ�...
				dipositYN="�̼�";
			}else{
				tcl="td3";
				dipositYN="�Ϸ�";
			}

		 sup = dto.getSupply_price_i();
		 vat = dto.getVat_i();
		
		 sum_price = sup+vat; 
		 deposit_amt_1 = Long.parseLong(dto.getDeposit_amt());
		
		 deposit_amt +=deposit_amt_1;
		/* long sumpriceUp = sum_price; */
		
		
		/* for(int k=1; k<=arrlist.size(); k++){ */
			
		/* } */
		
		sum += sum_price;
		
		String sums = String.valueOf(NumberUtil.getPriceFormat(sum));
        estmate -=sum;
		
		
		%>
          <tr>
            <td><%=no++ %></td><!-- �ѹ� -->
            <td class="<%=tcl%>"><%=dipositYN%></td><!-- �Աݿ��� -->
            
            
            
            <td class="<%=tcl%>"><%=DateTimeUtil.getDateType(1,dto.getPublic_dt(),"/")%></td><!-- �������� -->
            <td align="right" class="<%=tcl%>"><%=NumberUtil.getPriceFormat(sum_price)%></td><!-- ����ݾ� --> <!-- ���ݰ�꼭 ������ ���ް�+�ΰ��� 2013_01_17 shbyeon -->
            <td><%=NumberUtil.getPriceFormat(sum)%></td><!-- ��������ݾ� -->
            <td><%=NumberUtil.getPriceFormat(estmate)%></td><!-- �̹���ݾ� -->
            <td align="right" class="<%=tcl%>"><%=NumberUtil.getPriceFormat(dto.getDeposit_amt())%></td><!-- �Աݾ� -->
            <%
				/* long testiamt=Long.parseLong(sum_price); */
				long sumprice=sum_price;
				long t_estiamte=Long.parseLong(dto.getT_estiamt());
				long calval1=t_estiamte-deposit_amt;

				long plus1=0;
				long minus1=0;
                
				if(calval1>0){
					plus1=calval1;
				}else{
					minus1=calval1;
				}
				
				
			%>
			
            <td class="<%=tcl%>"><%=DateTimeUtil.getDateType(1,dto.getPre_deposit_dt(),"/")%></td><!-- �Աݿ������� --> <!-- �Ա����ڿ��� �Աݿ������ڷ� ����2013_01_17 shbyeon -->
            <td align="right" class="<%=tcl%>"><%=NumberUtil.getPriceFormat(dto.getT_estiamt())%></td><!-- �Ѱ����ݾ� -->
            <td align="right" class="<%=tcl%>"><%=NumberUtil.getPriceFormat(deposit_amt)%> </td><!-- �����Աݾ� -->
            
            <td align="right" class="<%=tcl%>"><%=NumberUtil.getPriceFormat(calval1)%></td><!-- ��ȸ���ݾ� -->
            <%
				long testiamt=Long.parseLong(dto.getT_estiamt());
				long tdeposiamt=Long.parseLong(dto.getT_deposiamt());
				long calval=testiamt-tdeposiamt;

				long plus=0;
				long minus=0;
                
				if(calval>0){
					plus=calval;
				}else{
					minus=calval;
				}
					
			%>
            
            <td align="right" class="<%=tcl%>"><span class="txt_red"><%=NumberUtil.getPriceFormat(minus)%></span></td><!-- �ʰ��ݾ� -->
          </tr>
          <!-- :: loop :: -->
          <%		
    i++;
    
}
}else{
%>
          <tr>
            <td colspan="12">��ȸ�� ����Ÿ�� �����ϴ�.</td>
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
    <!-- //button -->
    <div class="Bbtn_areaC">
      <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>�ݱ�</span></a>
    </div>
    <!-- //button -->
	</div>
	<!-- //content -->
	</div>
</div>
</form>
</body>
</html>
