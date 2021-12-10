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
<title>휴가신청</title>
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
	 
	    $('#calendarDatass').datepicker({
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
	 
	    $('#calendarDatas'+rowNumber+'').datepicker({
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
		var checkid = $('#calendarDatas'+rowNumber+'').val(); //2014-10-13
		
		$("input[name=startDate]").each(function (index) {  
			ary += $(this).val()+ ",";
		}); 
		
		var phoneno = ary.slice(0,-1);
		
		var phonenoArr = phoneno.split(",");

		for(var i =0; i<phonenoArr.length - 1; i++){
			if(phonenoArr[i]==checkid){
				alert("날짜가 중복됩니다 다시 선택해 주세요.");
				
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
		
		alert("휴가일자를 추가 해주세요.");
		return;
		
	}else if(($('#HollyFlag').val() == 1 || $('#HollyFlag').val() == 4 || $('#HollyFlag').val() == 5 || $('#HollyFlag').val() == 6 || $('#HollyFlag').val() == 7 ) && $('#calendarDatas').val() == ""){
		
		alert("휴가일자를 추가 해주세요.");
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
				alert("휴가 사용 가능일수가 초과됩니다.");
				return;	
			}
	}
	
	if(rowNumber == 0 && $('#calendarDatas').val() == ""){
		
		alert("휴가일자를 추가하세요");
		
	}else if($('#calendarDatas'+rowNumber+'').val()!="" ){
		
	rowNumber = rowNumber+1;
	
	
	var addRow_tr_count = $('#template2 tr').size(); //추가된 행 갯수 가져오기.
	
	$('#row_count').html(addRow_tr_count);
	
	var rowString = "";
	rowString +=	"<tr id=\"tr"+rowNumber+"\">";
	rowString +=	"<th><label for=\"calendarDatas2\">";
	rowString +=	"<span class=\"must_ico\"><img src=\"<%= request.getContextPath()%>/images/common/must_icon_01.gif\" alt=\"필수입력\" /></span></label></th>";
	rowString +=	"<td><span class=\"ico_calendar\"><input type=\"text\" readOnly name=\"startDate\" value=\"\" id=\"calendarDatas"+rowNumber+"\" class=\"text\" title=\"시작일\" style=\"width:100px;\" /></span><a  onclick=\"javascript:removeRow(this);\" class=\"btn_type03\"><span>삭제</span></a></td>";
	rowString +=	"</tr>";
	
	
	$('#template2').append(rowString);
	
	window.onload(test());
	}else{
		alert("휴가일자를 추가하세요");
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
<!-- 팝업사이즈 : width:441px -->
<div id="wrapLp">
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
			<form method="post" name="leaveModifyForm" action="<%= request.getContextPath()%>/H_Holly.do?cmd=leaveModify">
				<input type="hidden" name ="Seqs" id="Seqs" value="<%=seq%>"/>
				<input type="hidden" name ="StartDateTime" id="StartDateTime"/>
				<input type="hidden" name = "MgtKey" id="MgtKey" value="<%=hollyDto2.getMgtKey()%>"/>
				
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
							<option value="1" <%=a%> >연차</option>
							<option value="2" <%=b%> >오전반차</option>
							<option value="3" <%=c%> >오후반차</option>
							<option value="4" <%=d%> >병가</option>
							<option value="5" <%=e%> >공가</option>
							<option value="6" <%=f%> >무급휴가</option>
							<option value="7" <%=g%> >복리휴가</option>
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
						<span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>휴가일</label></th>
						<td><span class="ico_calendar"><input type="text" readOnly name="startDate" value="<%=ds.getString("HollyDate").substring(0, 10)%>" id="calendarDatass" class="text" title="시작일" style="width:100px;" /></span>
						<a onclick="javascript:addrow();" class="btn_type03"><span>추가</span></a></td>
					</tr>
					<%}else{ %>
					<tr id="1">
						<th><label for="calendarDatas1">
						<span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>휴가일</label></th>
						<td><span class="ico_calendar"><input type="text" readOnly name="startDate" value="<%=ds.getString("HollyDate").substring(0, 10)%>" id="calendarDatass" class="text" title="시작일" style="width:100px;" /></span>
						<a  onclick="javascript:removeRow(this);" class="btn_type03"><span>삭제</span></a>
					</tr>
					<% }
					j++;
					}
					%>
					
					</tbody>
					<tr id="2">
						<th><label for="calendarDatas2">
						<span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>휴가일</label></th>
						<td><span class="ico_calendar"><input type="text" readOnly name="startDate2" value="<%=ds.getString("HollyDate").substring(0, 10)%>" id="datepicket" class="text" title="시작일" style="width:100px;" /></span></td>
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
										<option value="<%=dto.getSignID1()%>" <%if(hollyDto2.getSignID1().equals(dto.getSignID1())){%>selected="selected"<%} %> >
										<%=dto.getSignName1()%></option>
										<%		
											}
								%>
								
						</select> TL (팀장결재)
						<select id="State1" name="State1" title="결재자2">
							<option value="S" <%if(hollyDto2.getState1().equals("S")){%>selected="selected"<%} %>>대기</option>
							<option value="Y" <%if(hollyDto2.getState1().equals("Y")){%>selected="selected"<%} %>>승인</option>
							<option value="N" <%if(hollyDto2.getState1().equals("N")){%>selected="selected"<%} %>>반려</option>
						</select></td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>결재자2</label></th>
						<td><select id="SignID2" name="SignID2" title="결재자2">
							<option value="jmkim">김준민 </option>
						</select> CEO (대표이사결재)
						<select id="State2" name="State2" title="결재자2">
							<option value="S" <%if(hollyDto2.getState2().equals("S")){%>selected="selected"<%} %>>대기</option>
							<option value="Y" <%if(hollyDto2.getState2().equals("Y")){%>selected="selected"<%} %>>승인</option>
							<option value="N" <%if(hollyDto2.getState2().equals("N")){%>selected="selected"<%} %>>반려</option>
						</select></td>
					</tr>
					<tr>
						<th><label for=""><span class="must_ico"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>사유</label></th>
						<td><textarea id="Reason" name="Reason" title="사유" style="width:265px;height:45px;"><%=hollyDto2.getReason() %></textarea></td>
					</tr>
					</tbody>
				</table>
			</fieldset>
			</form>
		</div>
		<!-- //등록 -->
		<!-- Bottom 버튼영역 -->
		<div class="Bbtn_areaC"><a href="javascript:goModify();" class="btn_type02"><span>신청</span></a><a href="javascript:goClose($('#ModifyForm'));" class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
		<!-- //Bottom 버튼영역 -->
	</div>
	<!-- //content -->
</div>
</body>
</html>