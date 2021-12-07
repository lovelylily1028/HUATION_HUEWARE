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
<title>사용자 등록</title>
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

var openWin=0;//팝업객체
var observer;//처리중
//초기함수
function init() {

	openWaiting( );

	if (document.readyState == "complete") {
		window.clearTimeout(observer);
		closeWaiting();
		return;
	}
	observer = window.setTimeout("init()", 100);  // 0.1초마다 확인
}
// 등록
function goRegist(){
	var frm = document.HollyDayRegist; 
	 	
	frm.submit();

}

var holidays = {
	    "0101":{type:0, title:"신정", year:""},
	    "0301":{type:0, title:"삼일절", year:""},
	    "0505":{type:0, title:"어린이날", year:""},
	    "0606":{type:0, title:"현충일", year:""},
	    "0815":{type:0, title:"광복절", year:""},
	    "1003":{type:0, title:"개천절", year:""},
	    "1009":{type:0, title:"한글날", year:""},
	    "1225":{type:0, title:"크리스마스", year:""},
	    "1010":{type:0, title:"휴에이션 창립기념일", year:""},
	 
	    "0130":{type:0, title:"설날", year:"2014"},
	    "0131":{type:0, title:"설날", year:"2014"},
	    "0908":{type:0, title:"추석", year:"2014"},
	    "0909":{type:0, title:"추석", year:"2014"},
	    "0910":{type:0, title:"추석", year:"2014"},
	    "0517":{type:0, title:"석가탄신일", year:"2014"}
	};

jQuery(function($){
	    $.datepicker.regional['ko'] = {
	   		prevText: "이전",
	   		nextText: "다음",
	   		dateFormat: "yy-mm-dd",
	   		dayNamesMin:["일","월","화","수","목","금","토"],
	   		monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
	   		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	   		changeMonth: true,
	   	    changeYear: true,
	    };
	    $.datepicker.setDefaults($.datepicker.regional['ko']);
	 
	    $('#datepicket').datepicker({
	        showOn: 'both',
	        buttonImage:  "<%= request.getContextPath()%>/images/common/ico_calendar.gif",
	        buttonImageOnly: true,
	        buttonText: "달력",
	        beforeShowDay: function(day) {
	            var result;
	            // 포맷에 대해선 다음 참조(http://docs.jquery.com/UI/Datepicker/formatDate)
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
            	   alert(data.substring(0,4)+"-"+data.substring(4,6)+"-"+data.substring(6,8)+" 일은 이전에 사용하신 이력이 있습니다.");
               }
            }
    });
}
</script>
</head>
<!-- 처리중 시작 -->
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
<!-- 처리중 종료 -->
<body onLoad="init()">
<div id="wrapWp">
	<!-- header -->
	<div id="headerWp">
		<h1>사용자 등록</h1>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<!-- 필수입력사항텍스트 -->
			<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
			<!-- //필수입력사항텍스트 -->
		</div>
		<!-- //컨텐츠 상단 영역 -->
		<!-- 등록 -->
		<div class="userRegistForm">
<form  method="post" name="HollyDayRegist" action="<%= request.getContextPath()%>/H_Holly.do?cmd=HollyDayRegist">
  <fieldset>
	<legend>휴일 등록</legend>
	<table class="tbl_type" summary="사용자 등록(사용자ID, 사용자명, 소속, 전화번호, 사용여부, 비밀번호, 비밀번호재입력)">
        <caption>휴일 등록</caption>
        <colgroup>
			<col width="138px" />
			<col width="*" />
		</colgroup>
		<tbody>
		 <tr>
          <th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>휴일명</label></th>
          <td><input name="Title" type="text" class="text" maxlength="20" size="15" value="" title="휴일명" style="width:200px;" tabindex="1"/></td>
        </tr>
        <tr >
			<th><label for="calendarData2">
			<span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>휴가일</label></th>
			<td><span class="ico_calendar"><input type="text" readOnly name="startDate2" value="" id="datepicket" class="text" title="시작일" style="width:200px;" /></span></td>
		</tr>
        <tr>
          <th></span>휴일설명</label></th>
          <td><textarea id="Description" name="Description" title="휴일설명" style="width:200px;height:45px;"></textarea></td>
        </tr>
       
        </tbody>
      </table>
      </fieldset>
      </form>
    </div>
	<!-- //등록 -->
    <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:DupCheck()" class="btn_type02"><span>확인</span></a><a href="javascript:window.close()" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
    <!-- //button -->
	</div>
	<!-- //content -->
</div>
</body>
</html>
