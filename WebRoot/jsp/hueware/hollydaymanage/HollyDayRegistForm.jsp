<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ include file="/jsp/hueware/common/base.jsp" %>
<%@page import="java.util.Map"%>
<%@ page import="com.huation.common.user.UserDTO"%>
<%@ page import="com.huation.common.user.UserDAO"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>����� ���</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/default.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/content.css" />
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/huefax.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/hueware.js"></script>
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"/></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<script>

var openWin=0;//�˾���ü
var observer;//ó����
//�ʱ��Լ�
function init() {

	openWaiting( );

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100);  // 0.1�ʸ��� Ȯ��
}
// ���
function goRegist(){
	var frm = document.HollyDayRegist; 
	 	
	frm.submit();

}

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
	 
	    "0130":{type:0, title:"����", year:"2014"},
	    "0131":{type:0, title:"����", year:"2014"},
	    "0908":{type:0, title:"�߼�", year:"2014"},
	    "0909":{type:0, title:"�߼�", year:"2014"},
	    "0910":{type:0, title:"�߼�", year:"2014"},
	    "0517":{type:0, title:"����ź����", year:"2014"}
	};

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
	     });
	});


function DupCheck(){
	
	
		
	var startdates = "";
		
		startdates = $('#datepicket').val();
	
	$.ajax({
        type: "POST",
        dataType : "text",
           url:  "<%=request.getContextPath()%>/H_Holly.do?cmd=HollyDupCheck",
           data : {
        	   "startdates" : startdates,
        	 
   		},
           success: function(data) {
               if(data=="0"){
            	  goRegist();
               }else{
            	   alert(data.substring(0,4)+"-"+data.substring(4,6)+"-"+data.substring(6,8)+" ���� ������ ����Ͻ� �̷��� �ֽ��ϴ�.");
               }
            }
    });
}
</script>
</head>
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
<body onLoad="init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>����� ���</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- ������ ��� ���� -->
		<div class="conTop_area">
			<!-- �ʼ��Է»����ؽ�Ʈ -->
			<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Էº�ǥ" />ǥ�ô� �ʼ� �Է� �׸��Դϴ�.</p>
			<!-- //�ʼ��Է»����ؽ�Ʈ -->
		</div>
		<!-- //������ ��� ���� -->
		<!-- ��� -->
		<div class="userRegistForm">
<form  method="post" name="HollyDayRegist" action="<%= request.getContextPath()%>/H_Holly.do?cmd=HollyDayRegist">
  <fieldset>
	<legend>���� ���</legend>
	<table class="tbl_type" summary="����� ���(�����ID, ����ڸ�, �Ҽ�, ��ȭ��ȣ, ��뿩��, ��й�ȣ, ��й�ȣ���Է�)">
        <caption>���� ���</caption>
        <colgroup>
			<col width="138px" />
			<col width="*" />
		</colgroup>
		<tbody>
		 <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>���ϸ�</label></th>
          <td><input name="Title" type="text" class="text" maxlength="20" size="15" value="" title="���ϸ�" style="width:200px;" tabindex="1"/></td>
        </tr>
        <tr >
			<th><label for="calendarData2">
			<span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="�ʼ��Է�" /></span>�ް���</label></th>
			<td><span class="ico_calendar"><input type="text" readOnly name="startDate2" value="" id="datepicket" class="text" title="������" style="width:200px;" /></span></td>
		</tr>
        <tr>
          <th></span>���ϼ���</label></th>
          <td><textarea id="Description" name="Description" title="���ϼ���" style="width:200px;height:45px;"></textarea></td>
        </tr>
       
        </tbody>
      </table>
      </fieldset>
      </form>
    </div>
	<!-- //��� -->
    <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:DupCheck()" class="btn_type02"><span>Ȯ��</span></a><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>���</span></a></div>
    <!-- //button -->
	</div>
	<!-- //content -->
</div>
</body>
</html>
