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
	ArrayList<HollyDTO> arraylist = (ArrayList)model.get("arraylist");
	HollyDTO myHollyDayInfo = (HollyDTO) model.get("hollyDayInfo");
	
	String UserID = (String)model.get("UserID");

	DecimalFormat df = new DecimalFormat("00");	
	Calendar cal = Calendar.getInstance();	
	String Today = Integer.toString(cal.get(Calendar.YEAR)) +"-"+ df.format(cal.get(Calendar.MONTH)+1) +"-"+ df.format(cal.get(Calendar.DATE));
	
	
	String Month = df.format(cal.get(Calendar.MONTH)+1);
	String DATE =  df.format(cal.get(Calendar.DATE)); 
	int j;
%>



<script>

var myHollyDayInfo = '<%= myHollyDayInfo.getUsedHollyDay() %>';

var rowNumber=0;
var UseableHollyDay2 ="";
$( function() {
	 $('#template').show();
	 $('#2').hide();
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
	 
	    $('#calendarData').datepicker({
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
	 
	    $('#calendarData'+rowNumber+'').datepicker({
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
		var checkid = $('#calendarData'+rowNumber+'').val(); //2014-10-13
		
		$("input[name=startDate]").each(function (index) {  
			ary += $(this).val()+ ",";
		}); 
		
		var phoneno = ary.slice(0,-1);
		
		var phonenoArr = phoneno.split(",");

		for(var i =0; i<phonenoArr.length - 1; i++){
			if(phonenoArr[i]==checkid){
				alert("��¥�� �ߺ��˴ϴ� �ٽ� ������ �ּ���.");
				
				$('#calendarData'+rowNumber+'').val("");
				return;
			}
		}
		if($('#calendarData').val()!=""){
		$("input[name=Day]").val(phonenoArr.length);
		}
	}
	
	
}


function blankRemove(){
	
	
	var test1="";
	if($('#calendarData').val()!=""){
	$("input[name=startDate]").each(function (index) {  
		test1 = $(this).val();
		if(test1==""){
			$(this).parent().parent().parent().remove();
		}
	}); 
	}
	
}

function goRegist(){
	
	$("[name=leaveRegistForm]").submit();
		
}


function DupCheck(){
	
	blankRemove();
	
	if( ($('#HollyFlag').val() == 2 || $('#HollyFlag').val() == 3 ) && $('#datepicket').val()==""){
		
		alert("�ް����ڸ� �߰� ���ּ���.");
		return;
		
	}else if(($('#HollyFlag').val() == 1 || $('#HollyFlag').val() == 4 || $('#HollyFlag').val() == 5 || $('#HollyFlag').val() == 6 ) && $('#calendarData').val() == ""){
		
		alert("�ް����ڸ� �߰� ���ּ���.");
		return;
		
	}
	
	if( $('#Reason').val() == ""){
		alert("������ �Է��� �ּ���");
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
	
	$.ajax({
        type: "POST",
        dataType : "text",
           url:  "<%=request.getContextPath()%>/H_Holly.do?cmd=DupCheck",
           data : {
        	   "startdates" : startdates,
        	 
   		},
           success: function(data) {
               if(data=="0"){
				   var hollySelectedValue = $('#HollyFlag').val();
				   if( UseableHollyDay <= 0 && 
						   (hollySelectedValue == 1 || hollySelectedValue == 2 || hollySelectedValue == 3)) {
					   alert("��� ������ �ް� �ϼ��� ��� ���� �Ͽ����ϴ�.");
					   return;
				   }
				   if(!confirm("�ް��� ��û �Ͻðڽ��ϱ�?")) return;
				   
				   //�ް�  ��û
				   goRegist();
	
               }else{
            	   alert(data.substring(0,4)+"-"+data.substring(4,6)+"-"+data.substring(6,8)+" ���� ������ ����Ͻ� �̷��� �ֽ��ϴ�.");
               }
            }
    });
}



function selectchange(){

	if($('#HollyFlag').val() == 2 || $('#HollyFlag').val() == 3 ){
		 $('#template').hide();
		 $('#2').show();
		 HollyDayCnt();
	}else if($('#HollyFlag').val() == 1){
		 $('#calendarData').val("");
		 for(i=0; i<30; i++){
	     $('#calendarData'+i+'').parent().parent().parent().remove();
		 }
		 $('#template').show();
		 $('#2').hide();
		 $("input[name=Day]").val("");
		 HollyDayCnt();
	}else{
		 $('#calendarData').val("");
		 for(i=0; i<30; i++){
	     $('#calendarData'+i+'').parent().parent().parent().remove();
		 }
		 $('#template').show();
		 $('#2').hide();
		 $("input[name=Day]").val("");
		 
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
			if(phonenoArr.length+1 > UseableHollyDay){
				alert("�ް� ��� �����ϼ��� �ʰ��˴ϴ�.");
				return;
			}
	}
	
	if(rowNumber == 0 && $('#calendarData').val() == ""){
		
		alert("�ް����ڸ� �߰��ϼ���");
		
	}else if($('#calendarData'+rowNumber+'').val()!="" ){
		
	rowNumber = rowNumber+1;
	
	
	var addRow_tr_count = $('#template tr').size(); //�߰��� �� ���� ��������.
	
	$('#row_count').html(addRow_tr_count);
	
	var rowString = "";
	rowString +=	"<tr id=\"tr"+rowNumber+"\">";
	rowString +=	"<th><label for=\"calendarData2\">";
	rowString +=	"<span class=\"must_ico\"><img src=\"<%= request.getContextPath()%>/images/common/must_icon_01.gif\" alt=\"�ʼ��Է�\" /></span></label></th>";
	rowString +=	"<td><span class=\"ico_calendar\"><input type=\"text\" readOnly name=\"startDate\" value=\"\" id=\"calendarData"+rowNumber+"\" class=\"text\" title=\"������\" style=\"width:100px;\" /></span><a  onclick=\"javascript:removeRow(this);\" class=\"btn_type03\"><span>����</span></a></td>";
	rowString +=	"</tr>";
	
	
	$('#template').append(rowString);
	
	window.onload(test());
	}else{
		alert("�ް����ڸ� �߰��ϼ���");
	}
	
	
}
function removeRow(obj){
	
	 $(obj).parent().parent().remove();
	 HollyDayCnt();
	
}

function showhide() {
	
	var flag = $('#HollyFlag').val();
	switch(flag){
	case '4':
		$('#4').removeClass("display_none");
		$('#help').removeClass("display_none");
		$('#5').addClass("display_none");
		$('#6').addClass("display_none");
		$('#7').addClass("display_none");
		break;
	case '5':
		$('#5').removeClass("display_none");
		$('#help').removeClass("display_none");
		$('#4').addClass("display_none");
		$('#6').addClass("display_none");
		$('#7').addClass("display_none");
		break;
	case '6':
		$('#6').removeClass("display_none");
		$('#help').removeClass("display_none");
		$('#4').addClass("display_none");
		$('#5').addClass("display_none");
		$('#7').addClass("display_none");
		break;
	case '7':
		$('#7').removeClass("display_none");
		$('#help').removeClass("display_none");
		$('#4').addClass("display_none");
		$('#5').addClass("display_none");
		$('#6').addClass("display_none");
		break;
	default:
		$('#4').addClass("display_none");
		$('#5').addClass("display_none");
		$('#6').addClass("display_none");
		$('#7').addClass("display_none");
		$('#help').addClass("display_none");
		
	}
	
}



</script>
<body>
<!-- �˾������� : width:441px -->
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
			<form method="post" name="leaveRegistForm" action="<%= request.getContextPath()%>/H_Holly.do?cmd=leaveRegist">
			<input type="hidden" name ="StartDateTime" id="StartDateTime"/>
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
							<option onclick="showhide();" value="1">����</option>
							<option onclick="showhide();" value="2">��������</option>
							<option onclick="showhide();" value="3">���Ĺ���</option>
							<option onclick="showhide();" value="4">����</option>
							<option onclick="showhide();" value="5">����</option>
							<option onclick="showhide();" value="6">�����ް�</option>
							<option onclick="showhide();" value="7">�����ް�</option>
						</select>
							<!-- �ް����� ���ý� �ش� ���� ����(�ش� ���� �ܿ��� class="display_none" �߰�  -->
							<ul id="help" class="guide_txt display_none">
								<li id="4" value="4" class="display_none">* ������?<br />����, �λ� ���� ���� �߻� �� ��û�� �� �ִ� �����ް� </li>
								<li id="5" value="5" class="display_none">* ������?<br />����, ����, �����Ʒ�, õ������ ���� ���� �߻� �� ��û�� �� �ִ� �����ް�</li>
								<li id="7" value="7" class="display_none">* �����ް���?<br />��ȥ, ���, ���, ���ټ� ���� ���� �߻��� ��û�� �� �ִ� �����ް� </li>
								<li id="6" value="6" class="display_none">* �����ް���?<br />�������� �Ǵ� ������ �������� ���� ��Ÿ ���� �߻� �� ��û�� �� �ִ� �ް�</li>
							</ul>
							<!-- //�ް����� ���ý� �ش� ���� ����(�ش� ���� �ܿ��� class="display_none" �߰�  -->
						</td>
						</div>
					</tr>
					
					<tbody id="template">
					<tr id="1">
						<th><label for="calendarData1">
						<span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ް���</label></th>
						<td><span class="ico_calendar"><input type="text" readOnly name="startDate" value="" id="calendarData" class="text" title="������" style="width:100px;" /></span><a onclick="javascript:addrow();" class="btn_type03"><span>�߰�</span></a></td>
					</tr>
					</tbody>
					<tr id="2">
						<th><label for="calendarData2">
						<span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ް���</label></th>
						<td><span class="ico_calendar"><input type="text" readOnly name="startDate2" value="" id="datepicket" class="text" title="������" style="width:100px;" /></span></td>
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
										<option value="<%=dto.getSignID1()%>">
										<%=dto.getSignName1()%></option>
										<%		
											}
								%>
								
						</select> TL (�������)</td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>������2</label></th>
						<td><select id="SignID2" name="SignID2" title="������2">
							<option value="jmkim">���ع� </option>
						</select> CEO (��ǥ�̻����)</td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>����</label></th>
						<td><textarea id="Reason" name="Reason" title="����" style="width:250px;height:45px;"></textarea></td>
					</tr>
					</tbody>
				</table>
			</fieldset>
			</form>
		</div>
		<!-- //��� -->
		<!-- Bottom ��ư���� -->
		<div class="Bbtn_areaC"><a href="javascript:DupCheck();" class="btn_type02"><span>��û</span></a><a href="javascript:goClose($('#RegistForm'));" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
		<!-- //Bottom ��ư���� -->
	</div>
	<!-- //content -->
</body>
</html>