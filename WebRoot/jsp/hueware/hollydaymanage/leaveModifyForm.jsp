<%@page import="com.huation.framework.data.DataSet"%>
<%@ page import="com.huation.framework.data.DataSet" %>
<%@ page import="com.huation.framework.persist.ListDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ް���û</title>
</head>
<%
	Map model = (Map)request.getAttribute("MODEL"); 
	ArrayList<HollyDTO> SignIdlist = (ArrayList)model.get("singIDlist");
	HollyDTO hollyDto2 = (HollyDTO)model.get("hollyDto2");
	String seq = (String)model.get("seq2");
	String a ="";String b ="";String c ="";String d ="";String e ="";String f =""; String g ="";
	
	DecimalFormat df = new DecimalFormat("00");	
		Calendar cal = Calendar.getInstance();	
		String Today = Integer.toString(cal.get(Calendar.YEAR)) +"-"+ df.format(cal.get(Calendar.MONTH)+1) +"-"+ df.format(cal.get(Calendar.DATE));
		
		
		String Month = df.format(cal.get(Calendar.MONTH)+1);
		String DATE =  df.format(cal.get(Calendar.DATE)); 
		
		String StartDT = hollyDto2.getStartDate().substring(0,10);
		String EndDT = hollyDto2.getEndDate().substring(0,10);
		
		if(hollyDto2.getHollyFlag().equals("1")){
			a = "Selected='Selected'";
		}else if(hollyDto2.getHollyFlag().equals("2")){
			b = "Selected='Selected'";
		}else if(hollyDto2.getHollyFlag().equals("3")){
			c = "Selected='Selected'";
		}else if(hollyDto2.getHollyFlag().equals("4")){
			d = "Selected='Selected'";
		}else if(hollyDto2.getHollyFlag().equals("5")){
			e = "Selected='Selected'";
		}else if(hollyDto2.getHollyFlag().equals("6")){
			f = "Selected='Selected'";
		}else if(hollyDto2.getHollyFlag().equals("7")){
			g = "Selected='Selected'";
		}
		
		%>
<script>


var rowNumber=0;
var UseableHollyDay2 ="";
$( function() {
	 /* $('#template2').show();
	 $('#2').hide(); */
	 selectchange();
});

var holidays = {
	    "0101":{type:0, title:"����", year:""},
	    "0301":{type:0, title:"������", year:""},
	    "0505":{type:0, title:"��̳�", year:""},
	    "0606":{type:0, title:"������", year:""},
	    "0815":{type:0, title:"������", year:""},
	    "1003":{type:0, title:"��õ��", year:""},
	    "1009":{type:0, title:"�ѱ۳�", year:""},
	    "1225":{type:0, title:"ũ��������", year:""},
	    "1010":{type:0, title:"�޿��̼� â�������", year:""},
	 
	    "0218":{type:0, title:"����", year:"2015"},
	    "0219":{type:0, title:"����", year:"2015"},
	    "0220":{type:0, title:"����", year:"2015"},
	    "0926":{type:0, title:"�߼�", year:"2015"},
	    "0927":{type:0, title:"�߼�", year:"2015"},
	    "0928":{type:0, title:"�߼�", year:"2015"},
	    "0525":{type:0, title:"����ź����", year:"2015"}
	};
	<%-- var holidays = {
			   
		    <%
					for(j=0;j<arraylist.size() ;j++){
						HollyDTO dto2 = arraylist.get(j);
				%>
						"'"+<%=dto2.getDays()%>+"'"+:{type:0, title:+"'"+<%=dto2.getTitle()%>+"'"+, year:+"'"+<%=dto2.getYear()%>+"'"},
				<%		
					}
			%>
			 "0910":{type:0, title:"�߼�", year:"2014"}
			};
	 --%>
	  
 	 jQuery(function($){
	    $.datepicker.regional['ko'] = {
	   		prevText: "����",
	   		nextText: "����",
	   		dateFormat: "yy-mm-dd",
	   		dayNamesMin:["��","��","ȭ","��","��","��","��"],
	   		monthNames:["1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��"],
	   		monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
	   		changeMonth: true,
	   	    changeYear: true,
	    };
	    $.datepicker.setDefaults($.datepicker.regional['ko']);
	 
	    $('#calendarDatass').datepicker({
	        showOn: 'both',
	        buttonImage:  "<%= request.getContextPath()%>/images/common/ico_calendar.gif",
	        buttonImageOnly: true,
	        buttonText: "�޷�",
	        beforeShowDay: function(day) {
	            var result;
	            // ���˿� ���ؼ� ���� ����(http://docs.jquery.com/UI/Datepicker/formatDate)
	            var holiday = holidays[$.datepicker.formatDate("mmdd",day )];
	            var thisYear = $.datepicker.formatDate("yy", day);
	 
	            // exist holiday?
	            if (holiday) {
	                if(thisYear == holiday.year || holiday.year == "") {
	                    result =  [false, "date-holiday", holiday.title];
	                }
	            }
	 
	            if(!result) {
	                switch (day.getDay()) {
	                    case 0: // is sunday?
	                        result = [false, "date-sunday"];
	                        break;
	                    case 6: // is saturday?
	                        result = [false, "date-saturday"];
	                        break;
	                    default:
	                        result = [true, ""];
	                        break;
	                }
	            }
	 
	            return result;
	        },
	        onClose:function(){
		    	
		    	HollyDayCnt();
		    	
		    }
	    });
	});
 	 
 	 
 		  
 	  jQuery(function($){
 		    $.datepicker.regional['ko'] = {
 		   		prevText: "����",
 		   		nextText: "����",
 		   		dateFormat: "yy-mm-dd",
 		   		dayNamesMin:["��","��","ȭ","��","��","��","��"],
 		   		monthNames:["1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��"],
 		   		monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
 		   		changeMonth: true,
 		   	    changeYear: true,
 		    };
 		    $.datepicker.setDefaults($.datepicker.regional['ko']);
 		 
 		    $('#datepicket').datepicker({
 		        showOn: 'both',
 		        buttonImage:  "<%= request.getContextPath()%>/images/common/ico_calendar.gif",
 		        buttonImageOnly: true,
 		        buttonText: "�޷�",
 		        beforeShowDay: function(day) {
 		            var result;
 		            // ���˿� ���ؼ� ���� ����(http://docs.jquery.com/UI/Datepicker/formatDate)
 		            var holiday = holidays[$.datepicker.formatDate("mmdd",day )];
 		            var thisYear = $.datepicker.formatDate("yy", day);
 		 
 		            // exist holiday?
 		            if (holiday) {
 		                if(thisYear == holiday.year || holiday.year == "") {
 		                    result =  [false, "date-holiday", holiday.title];
 		                }
 		            }
 		 
 		            if(!result) {
 		                switch (day.getDay()) {
 		                    case 0: // is sunday?
 		                        result = [false, "date-sunday"];
 		                        break;
 		                    case 6: // is saturday?
 		                        result = [false, "date-saturday"];
 		                        break;
 		                    default:
 		                        result = [true, ""];
 		                        break;
 		                }
 		            }
 		 
 		            return result;
 		        },
 		        onClose:function(){
 			    	
 			    	HollyDayCnt();
 			    	
 			    }
 		    });
 		});

function test(){
jQuery(function($){
	    $.datepicker.regional['ko'] = {
	   		prevText: "����",
	   		nextText: "����",
	   		dateFormat: "yy-mm-dd",
	   		dayNamesMin:["��","��","ȭ","��","��","��","��"],
	   		monthNames:["1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��"],
	   		monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
	   		changeMonth: true,
	   	    changeYear: true,
	    };
	    $.datepicker.setDefaults($.datepicker.regional['ko']);
	 
	    $('#calendarDatas'+rowNumber+'').datepicker({
	        showOn: 'both',
	        buttonImage:  "<%= request.getContextPath()%>/images/common/ico_calendar.gif",
	        buttonImageOnly: true,
	        buttonText: "�޷�",
	        beforeShowDay: function(day) {
	            var result;
	            // ���˿� ���ؼ� ���� ����(http://docs.jquery.com/UI/Datepicker/formatDate)
	            var holiday = holidays[$.datepicker.formatDate("mmdd",day )];
	            var thisYear = $.datepicker.formatDate("yy", day);
	 
	            // exist holiday?
	            if (holiday) {
	                if(thisYear == holiday.year || holiday.year == "") {
	                    result =  [false, "date-holiday", holiday.title];
	                }
	            }
	            if(!result) {
	                switch (day.getDay()) {
	                    case 0: // is sunday?
	                        result = [false, "date-sunday"];
	                        break;
	                    case 6: // is saturday?
	                        result = [false, "date-saturday"];
	                        break;
	                    default:
	                        result = [true, ""];
	                        break;
	                }
	            }
	            return result;
	        },
	        onClose:function(){
		    	
		    	HollyDayCnt();
		    }
	    });
	});
}


function HollyDayCnt(){
	
	blankRemove();
	
	if($('#HollyFlag').val() == 2 || $('#HollyFlag').val() == 3 ){
		$("input[name=Day]").val("0.5");
	}else{
		var ary="";
		var checkid = $('#calendarDatas'+rowNumber+'').val(); //2014-10-13
		
		$("input[name=startDate]").each(function (index) {  
			ary += $(this).val()+ ",";
		}); 
		
		var phoneno = ary.slice(0,-1);
		
		var phonenoArr = phoneno.split(",");

		for(var i =0; i<phonenoArr.length - 1; i++){
			if(phonenoArr[i]==checkid){
				alert("��¥�� �ߺ��˴ϴ� �ٽ� ������ �ּ���.");
				
				$('#calendarDatas'+rowNumber+'').val("");
				return;
			}
		}
		if($('#calendarDatas').val()!=""){
		$("input[name=Day]").val(phonenoArr.length);
		}
	}
	
	
}


function blankRemove(){
	
	
	var test1="";
	if($('#calendarDatas').val()!=""){
	$("input[name=startDate]").each(function (index) {  
		test1 = $(this).val();
		if(test1==""){
			$(this).parent().parent().parent().remove();
		}
	}); 
	}
	
}

function goModify(){
	
	blankRemove();
	
	if( ($('#HollyFlag').val() == 2 || $('#HollyFlag').val() == 3 ) && $('#datepicket').val()==""){
		
		alert("�ް����ڸ� �߰� ���ּ���.");
		return;
		
	}else if(($('#HollyFlag').val() == 1 || $('#HollyFlag').val() == 4 || $('#HollyFlag').val() == 5 || $('#HollyFlag').val() == 6 || $('#HollyFlag').val() == 7 ) && $('#calendarDatas').val() == ""){
		
		alert("�ް����ڸ� �߰� ���ּ���.");
		return;
		
	}
	
	var startdates = "";
	var ary="";
	
	if(($('#HollyFlag').val() == 2 || $('#HollyFlag').val() == 3 )){
	
		startdates = $('#datepicket').val();
	
	}else{
	
		$("input[name=startDate]").each(function (index) {  
			ary += $(this).val()+ " / ";
	
		}); 
	
		var phoneno = ary.slice(0,-3);
		var phonenoArr = phoneno.split(" / ");
		 
		$('#StartDateTime').val(phoneno);
		 
		startdates = $('#StartDateTime').val();
	}
	
	
	
	$("[name=leaveModifyForm]").submit();
		
}

function selectchange(){

	if($('#HollyFlag').val() == 2 || $('#HollyFlag').val() == 3 ){
		 $('#template2').hide();
		 $('#2').show();
		 HollyDayCnt();
	}else if($('#HollyFlag').val() == 1){
		 $('#calendarDatas').val("");
		 for(i=0; i<30; i++){
	     $('#calendarDatas'+i+'').parent().parent().parent().remove();
		 }
		 $('#template2').show();
		 $('#2').hide();
		 $("input[name=Day]").val("");
		 HollyDayCnt();
	}else{
		 $('#calendarDatas').val("");
		 for(i=0; i<30; i++){
	     $('#calendarDatas'+i+'').parent().parent().parent().remove();
		 }
		 $('#template2').show();
		 $('#2').hide();
		 $("input[name=Day]").val("");
		 HollyDayCnt();
		 
	}
}
function addrow(){
	var ary ="";
	
	$("input[name=startDate]").each(function (index) {  
		ary += $(this).val()+ ",";
	}); 
	var phoneno = ary.slice(0,-1);
	var phonenoArr = phoneno.split(",");
	if($('#HollyFlag').val() == 1){
			
	}else{					
			if(phonenoArr.length+1 > 20){
				alert("�ް� ��� �����ϼ��� �ʰ��˴ϴ�.");
				return;	
			}
	}
	
	if(rowNumber == 0 && $('#calendarDatas').val() == ""){
		
		alert("�ް����ڸ� �߰��ϼ���");
		
	}else if($('#calendarDatas'+rowNumber+'').val()!="" ){
		
	rowNumber = rowNumber+1;
	
	
	var addRow_tr_count = $('#template2 tr').size(); //�߰��� �� ���� ��������.
	
	$('#row_count').html(addRow_tr_count);
	
	var rowString = "";
	rowString +=	"<tr id=\"tr"+rowNumber+"\">";
	rowString +=	"<th><label for=\"calendarDatas2\">";
	rowString +=	"<span class=\"must_ico\"><img src=\"<%= request.getContextPath()%>/images/common/must_icon_01.gif\" alt=\"�ʼ��Է�\" /></span></label></th>";
	rowString +=	"<td><span class=\"ico_calendar\"><input type=\"text\" readOnly name=\"startDate\" value=\"\" id=\"calendarDatas"+rowNumber+"\" class=\"text\" title=\"������\" style=\"width:100px;\" /></span><a  onclick=\"javascript:removeRow(this);\" class=\"btn_type03\"><span>����</span></a></td>";
	rowString +=	"</tr>";
	
	
	$('#template2').append(rowString);
	
	window.onload(test());
	}else{
		alert("�ް����ڸ� �߰��ϼ���");
	}
}
function removeRow(obj){
	
	 $(obj).parent().parent().remove();
	 HollyDayCnt();
	
}
</script>
<body>
<%
					ListDTO ld = (ListDTO) model.get("ld");
				//	UserDTO userDto = (UserDTO) model.get("totalInfo");
					DataSet ds = (DataSet) ld.getItemList();
					
					System.out.println(hollyDto2.getState1()+hollyDto2.getState2());
					
				%>
<!-- �˾������� : width:441px -->
<div id="wrapLp">
	<!-- content -->
	<div id="contentLp">
		<!-- ������ ��� ���� -->
		<div class="conTop_area">
			<!-- �ʼ��Է»����ؽ�Ʈ -->
			<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
			<!-- //�ʼ��Է»����ؽ�Ʈ -->
		</div>
		<!-- //������ ��� ���� -->
		<!-- ��� -->
		<div class="leaveRegistForm">
			<form method="post" name="leaveModifyForm" action="<%= request.getContextPath()%>/H_Holly.do?cmd=leaveModify">
				<input type="hidden" name ="Seqs" id="Seqs" value="<%=seq%>"/>
				<input type="hidden" name ="StartDateTime" id="StartDateTime"/>
				<input type="hidden" name = "MgtKey" id="MgtKey" value="<%=hollyDto2.getMgtKey()%>"/>
				
			<fieldset>
				<legend>����� ��û</legend>
				<table class="tbl_type" summary="�ް���û(�ް�����, ������, ������, �ϼ�, ������1, ������2, ����)">
			
					<colgroup>
						<col width="30%" />
						<col width="*" />
					</colgroup>
					<tbody>
					<tr>
						<!-- label�� for���� input�� id���� �Ȱ��� ������ּ���. -->
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ް�����</label></th>
						<td><select onchange="javascript:selectchange();"  name="HollyFlag" id="HollyFlag" title="�ް�����">
							<option value="1" <%=a%> >����</option>
							<option value="2" <%=b%> >��������</option>
							<option value="3" <%=c%> >���Ĺ���</option>
							<option value="4" <%=d%> >����</option>
							<option value="5" <%=e%> >����</option>
							<option value="6" <%=f%> >�����ް�</option>
							<option value="7" <%=g%> >�����ް�</option>
						</select></td>
					</tr>
					<tbody id="template2">
					<%
					int j=1;
					while(ds.next()){ 
						System.out.println("j : "+j); 
								
					if(ds.isFirst()){
					%>
					<tr id="1">
						<th><label for="calendarDatas1">
						<span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ް���</label></th>
						<td><span class="ico_calendar"><input type="text" readOnly name="startDate" value="<%=ds.getString("HollyDate").substring(0, 10)%>" id="calendarDatass" class="text" title="������" style="width:100px;" /></span>
						<a onclick="javascript:addrow();" class="btn_type03"><span>�߰�</span></a></td>
					</tr>
					<%}else{ %>
					<tr id="1">
						<th><label for="calendarDatas1">
						<span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ް���</label></th>
						<td><span class="ico_calendar"><input type="text" readOnly name="startDate" value="<%=ds.getString("HollyDate").substring(0, 10)%>" id="calendarDatass" class="text" title="������" style="width:100px;" /></span>
						<a  onclick="javascript:removeRow(this);" class="btn_type03"><span>����</span></a>
					</tr>
					<% }
					j++;
					}
					%>
					
					</tbody>
					<tr id="2">
						<th><label for="calendarDatas2">
						<span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ް���</label></th>
						<td><span class="ico_calendar"><input type="text" readOnly name="startDate2" value="<%=ds.getString("HollyDate").substring(0, 10)%>" id="datepicket" class="text" title="������" style="width:100px;" /></span></td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ϼ�</label></th>
						<td><input type="text" id="Day" readonly name="Day" class="text" title="�ϼ�" style="width:50px;" /> ��</td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������1</label></th>
						<td><select id="SignID1" name="SignID1" title="������1">
						<option value="noSign">�����ھ���</option>
							<%
									int i;
											for(i=0;i<SignIdlist.size() ;i++){
												HollyDTO dto = SignIdlist.get(i);
										%>
										<option value="<%=dto.getSignID1()%>" <%if(hollyDto2.getSignID1().equals(dto.getSignID1())){%>selected="selected"<%} %> >
										<%=dto.getSignName1()%></option>
										<%		
											}
								%>
								
						</select> TL (�������)
						<select id="State1" name="State1" title="������2">
							<option value="S" <%if(hollyDto2.getState1().equals("S")){%>selected="selected"<%} %>>���</option>
							<option value="Y" <%if(hollyDto2.getState1().equals("Y")){%>selected="selected"<%} %>>����</option>
							<option value="N" <%if(hollyDto2.getState1().equals("N")){%>selected="selected"<%} %>>�ݷ�</option>
						</select></td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������2</label></th>
						<td><select id="SignID2" name="SignID2" title="������2">
							<option value="jmkim">���ع� </option>
						</select> CEO (��ǥ�̻����)
						<select id="State2" name="State2" title="������2">
							<option value="S" <%if(hollyDto2.getState2().equals("S")){%>selected="selected"<%} %>>���</option>
							<option value="Y" <%if(hollyDto2.getState2().equals("Y")){%>selected="selected"<%} %>>����</option>
							<option value="N" <%if(hollyDto2.getState2().equals("N")){%>selected="selected"<%} %>>�ݷ�</option>
						</select></td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
						<td><textarea id="Reason" name="Reason" title="����" style="width:265px;height:45px;"><%=hollyDto2.getReason() %></textarea></td>
					</tr>
					</tbody>
				</table>
			</fieldset>
			</form>
		</div>
		<!-- //��� -->
		<!-- Bottom ��ư���� -->
		<div class="Bbtn_areaC"><a href="javascript:goModify();" class="btn_type02"><span>��û</span></a><a href="javascript:goClose($('#ModifyForm'));" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
		<!-- //Bottom ��ư���� -->
	</div>
	<!-- //content -->
</div>
</body>
</html>