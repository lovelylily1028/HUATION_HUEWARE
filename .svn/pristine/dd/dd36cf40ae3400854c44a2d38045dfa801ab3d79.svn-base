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

<title>휴가신청</title>
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
	    "0101":{type:0, title:"신정", year:""},
	    "0301":{type:0, title:"삼일절", year:""},
	    "0505":{type:0, title:"어린이날", year:""},
	    "0606":{type:0, title:"현충일", year:""},
	    "0815":{type:0, title:"광복절", year:""},
	    "1003":{type:0, title:"개천절", year:""},
	    "1009":{type:0, title:"한글날", year:""},
	    "1225":{type:0, title:"크리스마스", year:""},
	    "1010":{type:0, title:"휴에이션 창립기념일", year:""},
	 
	    "0218":{type:0, title:"설날", year:"2015"},
	    "0219":{type:0, title:"설날", year:"2015"},
	    "0220":{type:0, title:"설날", year:"2015"},
	    "0926":{type:0, title:"추석", year:"2015"},
	    "0927":{type:0, title:"추석", year:"2015"},
	    "0928":{type:0, title:"추석", year:"2015"},
	    "0525":{type:0, title:"석가탄신일", year:"2015"}
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
			 "0910":{type:0, title:"추석", year:"2014"}
			};
	 --%>
	  
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
	 
	    $('#calendarData').datepicker({
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
	        onClose:function(){
		    	
		    	HollyDayCnt();
		    	
		    }
	    });
	});
 	 
 	 
 		  
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
 		        onClose:function(){
 			    	
 			    	HollyDayCnt();
 			    	
 			    }
 		    });
 		});

function test(){
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
	 
	    $('#calendarData'+rowNumber+'').datepicker({
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
				alert("날짜가 중복됩니다 다시 선택해 주세요.");
				
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
		
		alert("휴가일자를 추가 해주세요.");
		return;
		
	}else if(($('#HollyFlag').val() == 1 || $('#HollyFlag').val() == 4 || $('#HollyFlag').val() == 5 || $('#HollyFlag').val() == 6 ) && $('#calendarData').val() == ""){
		
		alert("휴가일자를 추가 해주세요.");
		return;
		
	}
	
	if( $('#Reason').val() == ""){
		alert("사유를 입력해 주세요");
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
					   alert("사용 가능한 휴가 일수를 모두 소진 하였습니다.");
					   return;
				   }
				   if(!confirm("휴가를 신청 하시겠습니까?")) return;
				   
				   //휴가  요청
				   goRegist();
	
               }else{
            	   alert(data.substring(0,4)+"-"+data.substring(4,6)+"-"+data.substring(6,8)+" 일은 이전에 사용하신 이력이 있습니다.");
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
				alert("휴가 사용 가능일수가 초과됩니다.");
				return;
			}
	}
	
	if(rowNumber == 0 && $('#calendarData').val() == ""){
		
		alert("휴가일자를 추가하세요");
		
	}else if($('#calendarData'+rowNumber+'').val()!="" ){
		
	rowNumber = rowNumber+1;
	
	
	var addRow_tr_count = $('#template tr').size(); //추가된 행 갯수 가져오기.
	
	$('#row_count').html(addRow_tr_count);
	
	var rowString = "";
	rowString +=	"<tr id=\"tr"+rowNumber+"\">";
	rowString +=	"<th><label for=\"calendarData2\">";
	rowString +=	"<span class=\"must_ico\"><img src=\"<%= request.getContextPath()%>/images/common/must_icon_01.gif\" alt=\"필수입력\" /></span></label></th>";
	rowString +=	"<td><span class=\"ico_calendar\"><input type=\"text\" readOnly name=\"startDate\" value=\"\" id=\"calendarData"+rowNumber+"\" class=\"text\" title=\"시작일\" style=\"width:100px;\" /></span><a  onclick=\"javascript:removeRow(this);\" class=\"btn_type03\"><span>삭제</span></a></td>";
	rowString +=	"</tr>";
	
	
	$('#template').append(rowString);
	
	window.onload(test());
	}else{
		alert("휴가일자를 추가하세요");
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
<!-- 팝업사이즈 : width:441px -->
	<!-- content -->
	<div id="contentLp">
		<!-- 컨텐츠 상단 영역 -->
		<div class="conTop_area">
			<!-- 필수입력사항텍스트 -->
			<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
			<!-- //필수입력사항텍스트 -->
		</div>
		<!-- //컨텐츠 상단 영역 -->
		<!-- 등록 -->
		<div class="leaveRegistForm">
			<form method="post" name="leaveRegistForm" action="<%= request.getContextPath()%>/H_Holly.do?cmd=leaveRegist">
			<input type="hidden" name ="StartDateTime" id="StartDateTime"/>
			<fieldset>
				<legend>사용자 신청</legend>
				<table class="tbl_type" summary="휴가신청(휴가구분, 시작일, 종료일, 일수, 결재자1, 결재자2, 사유)">
					<colgroup>
						<col width="30%" />
						<col width="*" />
					</colgroup>
					<tbody>
					<tr>
						<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>휴가구분</label></th>
						<td><select onchange="javascript:selectchange();"  name="HollyFlag" id="HollyFlag" title="휴가구분">
							<option onclick="showhide();" value="1">연차</option>
							<option onclick="showhide();" value="2">오전반차</option>
							<option onclick="showhide();" value="3">오후반차</option>
							<option onclick="showhide();" value="4">병가</option>
							<option onclick="showhide();" value="5">공가</option>
							<option onclick="showhide();" value="6">무급휴가</option>
							<option onclick="showhide();" value="7">복리휴가</option>
						</select>
							<!-- 휴가구분 선택시 해당 설명 노출(해당 구분 외에는 class="display_none" 추가  -->
							<ul id="help" class="guide_txt display_none">
								<li id="4" value="4" class="display_none">* 병가란?<br />질병, 부상 등의 사유 발생 시 신청할 수 있는 무급휴가 </li>
								<li id="5" value="5" class="display_none">* 공가란?<br />공무, 볍률, 예비군훈련, 천재지변 등의 사유 발생 시 신청할 수 있는 유급휴가</li>
								<li id="7" value="7" class="display_none">* 복리휴가란?<br />결혼, 출산, 사망, 장기근속 등의 사유 발생시 신청할 수 있는 유급휴가 </li>
								<li id="6" value="6" class="display_none">* 무급휴가란?<br />육아휴직 또는 위에서 열거하지 않은 기타 사유 발생 시 신청할 수 있는 휴가</li>
							</ul>
							<!-- //휴가구분 선택시 해당 설명 노출(해당 구분 외에는 class="display_none" 추가  -->
						</td>
						</div>
					</tr>
					
					<tbody id="template">
					<tr id="1">
						<th><label for="calendarData1">
						<span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>휴가일</label></th>
						<td><span class="ico_calendar"><input type="text" readOnly name="startDate" value="" id="calendarData" class="text" title="시작일" style="width:100px;" /></span><a onclick="javascript:addrow();" class="btn_type03"><span>추가</span></a></td>
					</tr>
					</tbody>
					<tr id="2">
						<th><label for="calendarData2">
						<span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>휴가일</label></th>
						<td><span class="ico_calendar"><input type="text" readOnly name="startDate2" value="" id="datepicket" class="text" title="시작일" style="width:100px;" /></span></td>
					</tr>
					
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>일수</label></th>
						<td><input type="text" id="Day" readonly name="Day" class="text" title="일수" style="width:50px;" /> 일</td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재자1</label></th>
						<td><select id="SignID1" name="SignID1" title="결재자1">
								<option value="noSign">결재자없음</option>
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
								
						</select> TL (팀장결재)</td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재자2</label></th>
						<td><select id="SignID2" name="SignID2" title="결재자2">
							<option value="jmkim">김준민 </option>
						</select> CEO (대표이사결재)</td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>사유</label></th>
						<td><textarea id="Reason" name="Reason" title="사유" style="width:250px;height:45px;"></textarea></td>
					</tr>
					</tbody>
				</table>
			</fieldset>
			</form>
		</div>
		<!-- //등록 -->
		<!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaC"><a href="javascript:DupCheck();" class="btn_type02"><span>신청</span></a><a href="javascript:goClose($('#RegistForm'));" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
		<!-- //Bottom 버튼영역 -->
	</div>
	<!-- //content -->
</body>
</html>