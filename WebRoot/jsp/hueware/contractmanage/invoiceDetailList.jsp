<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.StringUtil"%>
<%@ page import ="com.huation.framework.util.NumberUtil"%>
<%@ page import ="com.huation.framework.util.DateTimeUtil"%>
<%@ page import ="com.huation.common.invoice.InvoiceDTO"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
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
		ListDTO ld = (ListDTO) model.get("listInfo");
		DataSet ds = (DataSet) ld.getItemList();
		
		int iTotCnt = ld.getTotalItemCount();
		int iCurPage = ld.getCurrentPage();
		int iDispLine = ld.getListScale();
		int startNum = ld.getStartPageNum();

%>
<body onLoad="init()">
<div id="wrapWp">
 <!-- title -->
    <div id="headerWp">
      <h1>���ݰ�꼭 ���೻�� <span>���ݰ�꼭 ���೻�� (����ȣ : <%= (String)model.get("ContractCode")%>)&nbsp;&nbsp;[����:<%= (String)model.get("ContractName")%>]</span></h1>
    </div>
    <!-- //title -->
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
<form  method="post" name=invoiceform action = "">
  <input type = "hidden" name = "objExcel">
  <input type = "hidden" name = "filename" value="">
  <input type = "hidden" name = "invoice_code" value="">

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
    	long esti_amt=0;				//�Ѱ����ݾ�(���ް�+�ΰ���) ����������ݾ�.
      	long sup=0;						//���ް� = ����ݾ�
      	long vat=0;						//�ΰ���
        long supply_sum_vat=0; 			//����ݾ�(���ް�+�ΰ���) ���ݰ�꼭����ݾ�.
      	long sum_price_total=0; 		//��������ݾ�
      	long min_price_total=0; 		//�̹���ݾ�
      	long deposit_amt=0;				//�Աݾ�
      	long deposit_amt_total=0;		//���� �Աݾ�
      	long no_collect_total=0;		//��ȸ���ݾ�
      	long exceed_total=0;			//�ʰ��ݾ�
      	
      	String tcl="";			//status�� ���� Į������
		String dipositYN="";	//status�� ���� �Աݿ���(�̼�/�Ϸ�)
		int no = 1;				//���� �ѹ���.
        if (ld.getItemCount() > 0) {
            int i = 0;
            while (ds.next()) {
            	
            	if(ds.getString("STATE").equals("01")){
    				tcl="txt_green"; //���� ����ȹٲ�...
    				dipositYN="�̼�";
    			}else{
    				tcl="td3";
    				dipositYN="�Ϸ�";
    			}
       			
            	//����
            	sup = Long.parseLong(ds.getString("I_SUPPLY_PRICE")); //���ݰ�꼭 ����ݾ�
            	vat = Long.parseLong(ds.getString("I_VAT"));			//���ݰ�꼭 ���� �ΰ���
            	esti_amt = Long.parseLong(ds.getString("Esti_AMT")); 	//������ ���� �Ѱ����ݾ�
            	supply_sum_vat = sup+vat; 		   			 //����ݾ�(���ް�+�ΰ���)
            	sum_price_total += sup+vat; 	   			 //��������ݾ�(����ݾ�++)
            	min_price_total = esti_amt - sum_price_total; //�̹���ݾ�(�Ѱ����ݾ�-��������ݾ�)
            	
            	//������Ȳ
            	deposit_amt = Long.parseLong(ds.getString("DEPOSIT_AMT"));			//�Աݾ�
            	deposit_amt_total += deposit_amt; 									//���� �Աݾ�(�Աݾ�++)
            	no_collect_total = esti_amt-deposit_amt_total;						//��ȸ���ݾ�(�Ѱ����ݾ�-�����Աݾ�)
            	
            	
            	
            	
            	
            
    %>
<tr>
  <td><%=no++ %></td>
  <td class="<%=tcl%>"><%=dipositYN %></td>
  <td><%=DateTimeUtil.getDateType(1,ds.getString("PUBLIC_DT"),"/")%></td>
  <td class="text_r"><%=NumberUtil.getPriceFormat(supply_sum_vat) %></td>
  <td class="text_r"><%=NumberUtil.getPriceFormat(sum_price_total) %></td>
  <td class="text_r"><%=NumberUtil.getPriceFormat(min_price_total) %></td>  
  <td class="text_r"><%=NumberUtil.getPriceFormat(ds.getString("DEPOSIT_AMT")) %></td>
  <td><%=DateTimeUtil.getDateType(1,ds.getString("PRE_DEPOSIT_DT"),"/") %></td>
  <td class="text_r"><%=NumberUtil.getPriceFormat(esti_amt) %></td>
  <td class="text_r"><%=NumberUtil.getPriceFormat(deposit_amt_total) %></td>
  <td class="text_r"><%=NumberUtil.getPriceFormat(no_collect_total) %></td>
  <%
  		exceed_total =esti_amt-deposit_amt_total;	//�ʰ��ݾ�(�Ѱ����ݾ�-�Աݾ�)
  		long plus=0;
		long minus=0;
		
  		if(exceed_total > 0){
  			plus=0;
  %>
  <td class="text_r"><%=NumberUtil.getPriceFormat(plus) %></td>
  <%
  		}else{
  			minus=exceed_total;
  %>
  <td class="text_r"><%=NumberUtil.getPriceFormat(minus) %></td>
  <%
  		}
  %> 	
</tr>
<!-- :: loop :: -->
<%
        i++;
            
            }
        } else {
    %>
<tr>
  <td colspan="12">�Խù��� �����ϴ�.</td>
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
    </tbody>
        </table>
      <!-- //con -->
    <!-- Bottom ��ư���� -->
		<div class="Bbtn_areaC">
      <a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>�ݱ�</span></a></div>
    <!-- //button -->
  </div>
</form>
</div>
</body>
</html>
