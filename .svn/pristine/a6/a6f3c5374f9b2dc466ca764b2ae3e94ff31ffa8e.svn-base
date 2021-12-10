<%@page import="com.huation.common.user.UserDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>SMS 전송</title>
<%
Map model = (Map)request.getAttribute("MODEL"); 
long todaytime;
SimpleDateFormat day;

String Day;
    
todaytime = System.currentTimeMillis(); 
day = new SimpleDateFormat("yyyy-MM-dd");
Day =  day.format(new Date(todaytime));

UserDTO userDto = (UserDTO)model.get("userDto");

%>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"/></script>
<script language="javascript">
var SelectMenu='smsSend';

$( function() {
	 $('#reserve').hide();	
    
});

var rowNumber=1;

function goSmsAddList(url){

	var top, left,scroll;
	   var width='1014';
	   var height='584';
	   var loc='center';
	   
		scroll='1';
		if(loc != null) {
			top	 = screen.height/2 - height/2 - 50;
			left = screen.width/2 - width/2 ;
		} else {
			top  = 10;
			left = 10;
		}
				
		var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=no,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;

		openWin = open(url, "_goSmsAddList",option);
		openWin.focus();
}

function goSmsAddList2(url){

	var top, left,scroll;
	   var width='1014';
	   var height='584';
	   var loc='center';
	   
		scroll='1';
		if(loc != null) {
			top	 = screen.height/2 - height/2 - 50;
			left = screen.width/2 - width/2 ;
		} else {
			top  = 10;
			left = 10;
		}
				
		var	option = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=no,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;

		openWin = open(url, "_goSmsAddList",option);
		openWin.focus();
}

function addrow(){
	
	var rowString = "";
	rowString +=	"<tr id=\"tr"+rowNumber+"\">";
	rowString +=	"<td><input type=\"text\" numberOnly=\"true\" name=\"phoneno\" id=\"phoneno\" class=\"text\" title=\"전화번호\" style=\"width:207px;\" /></td>";
	rowString +=	"<td><input type=\"text\" name=\"username\" id=\"username\" class=\"text\" title=\"이름\" style=\"width:207px;\" /></td>";
	rowString +=	"<td><a  onclick=\"javascript:removeRow(this);\" class=\"btn_type03\"><span>삭제</span></a></td>";

	rowString +=	"</tr>";
							
									
	$('#template').append(rowString);
	
	rowNumber = rowNumber+1;
	
	
	var addRow_tr_count = $('#template tr').size(); //추가된 행 갯수 가져오기.
	
	$('#row_count').html(addRow_tr_count);
}

function addrow2(phone){
	
	var str = phone.split(",");
	var phoneNo;
	var name;
	
	
	/* alert($('#row_count').html(addRow_tr_count)); */
	
	
	for(var x=0; x<str.length; x++){
		
		var spl = str[x].split("|");
		var phoneNo = spl[0];
		var name = spl[1];
		if(phoneNo != ""){
		var rowString = "";
		
		rowString +=	"<tr id=\""+rowNumber+"\">";
		rowString +=	"<td><input type=\"text\" numberOnly=\"true\" name=\"phoneno\" id=\"phoneno\" value=\""+phoneNo+"\" class=\"text\" title=\"전화번호\" style=\"width:207px;\" /></td>";
		rowString +=	"<td><input type=\"text\" name=\"username\" id=\"username\" value=\""+name+"\" class=\"text\" title=\"이름\" style=\"width:207px;\" /></td>";
		rowString +=	"<td><a onclick=\"javascript:removeRow(this);\" class=\"btn_type03\"><span>삭제</span></a></td>";

		rowString +=	"</tr>";
		
		$('#template').append(rowString);
		
		rowNumber = rowNumber+1;
		}
	}
	
	var addRow_tr_count = $('#template tr').size(); //추가된 행 갯수 가져오기.
	
	$('#row_count').html(addRow_tr_count);
	
}

function blankRemove(){
	
	
	var test1="";
	
	$('#template [id="phoneno"]').each(function (index) {  
		test1 = $(this).val();
		if(test1==""){
			$(this).parent().parent().remove();
		}
	}); 
	
	
	var addRow_tr_count = $('#template tr').size(); //추가된 행 갯수 가져오기.
	
	$('#row_count').html(addRow_tr_count);
	
	
}
function test2(){
	
	var ary="";
	var phoneno;
	var uniqueNames = [];
	
	var test = $("input[name=phoneno]").val();

	$("input[name=phoneno]").each(function (index) {  
		ary += $(this).val()+ ",";
	}); 
	
	phoneno = ary.slice(0,-1);
	var phonenoArr = phoneno.split(",");
	
	var sort_phonenoArr = phonenoArr.sort();

	for(var i =0; i<phonenoArr.length - 1; i++){
		if(sort_phonenoArr[i+1]==sort_phonenoArr[i]){
			uniqueNames.push(sort_phonenoArr[i]);
		}
	}
	
	for(var j =0; j<uniqueNames.length; j++){
	}
		
}


function smsSend(){
	var frm = document.smsSendForm;
	var phoneno = $('#phoneno').val();
	var sendNum = $('#sendNum').val();
	var message = $('#message').val();
	
	if($('#template tr').size()==0){
		alert("수신자를 추가해주세요.");
		return;
	}
	if(phoneno.replace(/ /g, '')==""){
		alert("수신 번호를 입력하세요.");
		return;
	}
	if(sendNum.replace(/ /g, '')==""){
		alert("발신 번호를 입력하세요.");
		return;
	}
	if(message.replace(/ /g, '')==""){
		alert("문자 내용을 입력하세요.");
		return;
	}
	if(!confirm("문자를 전송 하시겠습니까?"))
		return;
	
	frm.action = "<%=request.getContextPath()%>/S_Sms.do?cmd=smsSendSubmit";
	
	frm.submit();
	
	
}
function reWrite(){
	$('#message').val("");
	$('#byteLength').html("0 / 80");
	
}

function radioCheck(){		
	var frm = document.smsSendForm;
	var chk = $("#cmStChk input:checked").val();
	if(chk == "1"){
		$('#reserve').hide();	
		$('#reserve2').show();
		return;
	}else if(chk == "2"){
		$('#reserve').show();	
		$('#reserve2').hide();
		return;
	}
}

function removeRow(obj){
	
	 $(obj).parent().parent().remove();
	
	
	var addRow_tr_count = $('#template tr').size(); //추가된 행 갯수 가져오기.
	
	$('#row_count').html(addRow_tr_count);
	
}

function bytes(){

	var msg = $('#message').val();
	var stringByteLength = 0;
	
	 var nbytes = 0;
	 for (i=0; i<msg.length; i++) {
	  var ch = msg.charAt(i);
	  if(escape(ch).length > 4) {
	   nbytes += 2;
	  } else if (ch == '\n') {
	   if (msg.charAt(i-1) != '\r') {
	    nbytes += 1;
	   }
	  } else if (ch == '<' || ch == '>') {
	   nbytes += 4;
	  } else {
	   nbytes += 1;
	  }
	 }
	if(nbytes>80){
	$('#byteLength').html("MMS(장문)문자로 전송됩니다. "+nbytes+" / 80");	
	
	}else{
	$('#byteLength').html(nbytes+" / 80");
	}
	
	
}
$(function()
		{
		 $(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
		 $(document).on("keyup", "input:text[datetimeOnly]", function() {$(this).val( $(this).val().replace(/[^0-9:\-]/gi,"") );});
		});

</script>
</head>
<body>
<!-- 팝업사이즈 : width:834px / height:574px; -->
<div id="wrapWp" class="smsSend">
	<!-- //header -->
	<!-- header -->
	<div id="headerWp">
	<%@ include file="/jsp/hueware/common/include/smsTop.jsp" %>
	</div>
	<!-- //header -->
	<!-- content -->
	<div id="contentWp">
		<!-- SMS전송컨텐츠 -->
		<div class="smsSend_area">
			<form method="post" name="smsSendForm" id="smsSendForm" action="">
			<!-- 받는사람리스트 -->
			<fieldset class="receiveList">
				<legend>받는사람리스트</legend>
				<table class="tbl_type tbl_type_list" summary="받는사람리스트(전화번호, 이름)">
					<colgroup>
						<col width="230px" />
						<col width="230px" />
						<col width="*" />
					</colgroup>
					<thead>
					<tr>
						<th class="title" colspan="3"><strong>받는사람</strong>&nbsp;&nbsp;
						<a onclick="javascript:goSmsAddList2('<%= request.getContextPath()%>/S_Sms.do?cmd=smsAddList2');" class="btn_type03">
						<span>휴에이션주소록</span></a>
						<a onclick="javascript:goSmsAddList('<%= request.getContextPath()%>/S_Sms.do?cmd=smsAddList');" class="btn_type03">
						<span>업체주소록</span></a>
						</th>
					</tr>
					<tr>
						<th>전화번호</th>
						<th>이름</th>
						<th>삭제</th>
					</tr>
					</thead>
					<tfoot>
					<tr>
						<td class="title" colspan="3"><strong>총 인원 : <span id="row_count">0</span>명</strong>
						<span class="addPlus"><!-- <a href="javascript:test2();" class="btn_type03"><span>중복제거</span></a> -->
						<a href="javascript:blankRemove();" class="btn_type03"><span>공백제거</span></a>
						<a href="javascript:addrow();" class="btn_type03"><span>인원추가</span></a></span></td>

					</tr>
					</tfoot>
					<tbody>
					<tr>
						<td colspan="3" class="tbl_type_scrollY">
							<div class="scrollY">
								<table class="tbl_type tbl_type_list">
									<colgroup>
										<col width="229px" class="scrollY_FF" />
										<col width="230px" />
										<col width="*" />
									</colgroup>
									<tbody id="template">
									<!-- label의 for값과 input의 id값을 똑같이 사용해주세요. -->
							   <!--  <tr id="1">
										<td>1</td>
										<td><input type="text" id="phoneno" value="전화번호" name="phoneno" class="text" title="전화번호" style="width:227px;" /></td>
										<td><input type="text" id="username" value="이름" name="username" class="text" title="이름" style="width:206px;" /></td>
								 		<td><a onclick="javascript:removeRow(this);" class="btn_type03"><span>삭제</span></a></td>
								 </tr>  -->
									
									</tbody>
								</table>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
			</fieldset>
			<!-- //받는사람리스트 -->
			
			
			
			
			
			<!-- 문자보내기 -->
			<fieldset class="messagesSend">
				<legend>문자보내기</legend>
				<div class="messageCont_area">
					<div class="messageCont"><textarea id="message" onkeyup="javacript:bytes();" name="message" title="내용입력" style="width:217px;height:171px"></textarea></div>
					<p id="byteLength" class="num">0 / 80</p>
					<p class="rewrite"><a href="javascript:reWrite();">다시쓰기</a></p>
				</div>
				<dl class="sendList">
					<dt>보내는사람</dt>
					<dd><input type="text" readOnly value="<%=userDto.getOfficeTellNoFormat()%>" name="sendNum" id="sendNum" class="text" title="보내는사람" style="width:227px;height:28px;line-height:28px;" /></dd>
				</dl>
				<ul class="sendType">
				
					<li id="cmStChk"><input type="radio" id="" name="cmChk" value="1" class="radio md0" onclick="javascirpt:radioCheck();" checked="checked" title="즉시전송" /><label for="">즉시전송</label><input type="radio" id="" name="cmChk" value="2"class="radio" onclick="javascirpt:radioCheck();" title="예약전송" /><label for="">예약전송</label></li>
					
					<li id="reserve"><span class="ico_calendar"><input type="text" name="reserveDT" value="<%=Day%>" readOnly id="calendarData1" class="text" title="예약일" style="width:100px;" /></span> <select class="select" title="시" id="stTime" name="stTime" value="" style="width:50px;">
							<option>00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option>
							<option>07</option><option>08</option><option>09</option><option selected="selected">10</option><option>11</option><option>12</option>
							<option>13</option><option>14</option><option>15</option><option>16</option><option>17</option><option>18</option><option>19</option>
							<option>20</option><option>21</option><option>22</option><option>23</option></select> <select class="select" title="분" id="stMinute" name="stMinute" value="" style="width:50px;">
							<option>00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option>
							<option>07</option><option>08</option><option>09</option><option>10</option><option>11</option><option>12</option><option>13</option>
							<option>14</option><option>15</option><option>16</option><option>17</option><option>18</option><option>19</option><option>20</option>
							<option>21</option><option>22</option><option>23</option><option>24</option><option>25</option><option>26</option><option>27</option>
							<option>28</option><option>29</option><option>30</option><option>31</option><option>32</option><option>33</option><option>34</option>
							<option>35</option><option>36</option><option>37</option><option>38</option><option>39</option><option>40</option><option>41</option>
							<option>42</option><option>43</option><option>44</option><option>45</option><option>46</option><option>47</option><option>48</option>
							<option>49</option><option>50</option><option>51</option><option>52</option><option>53</option><option>54</option><option>55</option>
							<option>56</option><option>57</option><option>58</option><option>59</option>
						</select></li>
						
				<li id="reserve2">
					<span class="ico_calendar"><input type="text" name="reserveDT2" value = "<%=Day%>" readOnly  class="text dis" title="예약일" style="width:100px;" /></span> <select class="select dis" title="시" id="stTime2" readOnly name="stTime2" value="" style="width:50px;">
							<option>10</option>
						
						</select> <select class="select dis" title="분" id="stMinute2" readOnly name="stMinute2" value="" style="width:50px;">
							<option>00</option>
							
							
						</select></li>
				</ul>
				<p class="smsSendBbtn"><a href="javascript:smsSend();">문자보내기</a></p>
			</fieldset>
			<!-- //문자보내기 -->
			</form>
		</div>
		<!-- //SMS전송컨텐츠 -->
	</div>
	<!-- //content -->
</div>
</body>
</html>