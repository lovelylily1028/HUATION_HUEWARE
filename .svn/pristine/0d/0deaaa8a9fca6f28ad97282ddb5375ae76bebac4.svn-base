<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.util.DateParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.util.DateSetter"%>
<%

	Map model = (Map)request.getAttribute("MODEL");

	String curPage = (String)model.get("curPage");
	String strDate = (String)model.get("strDate");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>HueBook 등록</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="<%= request.getContextPath()%>/css/hueware.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%= request.getContextPath() %>/js/common/common.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/js/HueValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--

function goSave(){
	var frm = document.hueBookReRegist; 
	
	
	if(frm.bookName.value == ""){
		alert("도서명을 입력하세요.");
		return;
	}
	if(frm.writer.value == ""){
		alert("저자를 입력하세요.");
		return;
	}
	if(frm.branchCode.value == ""){
		alert("분야를 선택하세요.");
		return;
	}
	if(frm.publisher.value == ""){
		alert("출판사를 입력하세요.");
		return;
	}
	if(frm.requestBookCount.value == ""){
		alert("신청 (권)수를 선택하세요.");
		return;
	}
	if(frm.contents.value == ""){
		alert("내용(목차)를 입력해주세요.");
		return;
	}
	
	
	var dates = frm.requestDate.value;
	var requestDates = dates.replace(/-/g,'');
	frm.pYear7.value = requestDates.substr(0,4);
	frm.pMonth7.value = requestDates.substr(4,2);
	frm.pDay7.value = requestDates.substr(6,2);
	
	frm.requestDate.value = frm.pYear7.value +frm.pMonth7.value +frm.pDay7.value;
	frm.requestDate.value = frm.pYear7.value+'-'+frm.pMonth7.value+'-'+frm.pDay7.value;
	frm.requestUser.value = frm.user_id.value;
	frm.requestName.value = frm.user_name.value;
	frm.submit();
}
/*
 * int 가격 체크 000, 계산하여 끊어준뒤 콤마 표시
 */
 function saleCntCal(form){
	
	    var v_obj;
		var obj;
		var veiwfrm=eval("document."+form+'_view');
		var frm=eval("document."+form);
		var costobj=document.hueBookReRegist;

		if(frm.length>1){
			v_obj=veiwfrm[index];
			obj=frm[index];
		}else{
			v_obj=veiwfrm;
			obj=frm;
	
		}
	
		if (!isNumber(trim(v_obj.value))) {
			alert("0~9 정수(숫자)만 입력해 주세요.");
		} 
		
		
		var num=onlyNum(v_obj.value);
		v_obj.value = addCommaStr(num);
		obj.value = num;
		
		if(form=='hueBookReRegist.price'){	
			var price=parseInt(onlyNum(costobj.price.value)*1,10);
			costobj.price.value=addCommaStr(''+price);
		    costobj.price.value=price;	    
		    
		}
		v_obj.focus();
	}

/*
 *특수문자 불가check
function inputCheckSpecial(){
	var strobj = document.bankmanageRegist.CustomerNum;
	re =/[.,~!@\#$%^&*\()\-=+_{}\|;"":'`/]/;
	if(re.test(strobj.value)){
		alert("고객번호는  영문 대소문자, 숫자를 이용해 주세요.");
		strobj.value=strobj.value.replace(re,"");
	}
	
}
function pricecheck(){
	   
	   var frm=document.hueBookReRegist;
	   var AcNumCheck=frm.AccountNumber;
	   if(AcNumCheck.value.length>0){
			if (!isNumber(trim(AcNumCheck.value))) {
				alert("계좌번호는 (-)제외한 숫자만 입력이 가능합니다.");
				AcNumCheck.value=onlyNum(AcNumCheck.value);
			} 
	   }

	}
 */ 

	function cancle(){
		
		var frm = document.hueBookReRegist;
		frm.action='<%= request.getContextPath()%>/B_HueBookManageRe.do?cmd=hueBookRePageList';
		frm.submit();

	}

//-->
</SCRIPT>
</head>
<body >
<div id="wrap">
<!-- header -->
<div id="header">
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
</div>
<!-- //header -->
<!-- container -->
<div id="container">
<!-- content -->
<div id="content">
  <!-- title -->
   <div class="content_navi">HUEBook &gt; 도서신청</div>
	<h3><span>도</span>서신청</h3>
  <!-- //title -->
  <!-- con -->
  <div class="con">
	<div class="conTop_area">
	<p class="must_txt"><img src="<%= request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력별표" />표시는 필수 입력 항목입니다.</p>
	</div>
	
    <form name="hueBookReRegist" method="post" action="<%= request.getContextPath()%>/B_HueBookManageRe.do?cmd=hueBookReRegist">
     <input type = "hidden" name = "curPage" value="<%=curPage%>">
	  <input type = "hidden" name = "user_id" value="<%=dtoUser.getUserId()%>">
	  	  <!-- 사원조회해서 가져온 USER+NAME 담아서 넘겨줄값 -->
	  	  <input type = "hidden" name = "requestUser" value="">
	  	  <input type = "hidden" name = "requestName" value="">
	  	  <input type="hidden" name="status" value="1"></input>
	  	  
	  	  <input type = "hidden" name = "pYear7" value=""/>
		 <input type = "hidden" name = "pMonth7" value=""/>
		  <input type = "hidden" name = "pDay7" value=""/>
	  	  
	  	  <fieldset>
	  	  
      <legend>도서신청</legend>
		<table class="tbl_type" summary="도서신청(신청자, 분야, 도서명, 출판사, 저자, 역자, 가격, 신청(권)수, 신청일자, 내용(목차))">
        <caption>도서신청 상세정보</caption>
        <colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
		<tbody>
		<tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청자</label></th>
          <td><input type="text" name="user_name" class="text dis" title="신청자" style="width:200px;" readOnly value="<%=dtoUser.getUserNm()%>"></input></td>	
		</tr>
		<tr>	
			<th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>분야</label></th>
				<td><%
							CodeParam codeParam = new CodeParam();
							codeParam.setType("select"); 
							codeParam.setStyleClass("td3");
							codeParam.setFirst("전체");
							codeParam.setName("branchCode");
							codeParam.setSelected(""); 
							//codeParam.setEvent("javascript:poductSet();"); 
							out.print(CommonUtil.getCodeList(codeParam,"A08")); 
						%>
				</td>
         
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>도서명</label></th>
          <td><input type="text" name="bookName" value="" class="text" title="도서명" style="width:916px;" maxlength="50"  ></input></td>
	     </tr>
	     <tr>    
	          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>출판사</label></th>
	          <td><input type="text" name="publisher" value="" class="text" title="출판사" style="width:300px;" maxlength="25"  ></input></td>
      
        </tr>
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>저자</label></th>
          <td><input type="text" name="writer" value="" class="text" style="width:300px;" maxlength="50"  ></td>
		</tr>
		<tr>
	          <th><label for="">역자</label></th>
	          <td><input type="text" name="translator" value="" class="text" title="역자" style="width:300px;" maxlength="25"  ></td>
        </tr>
         <tr>
          <th><label for="">가격</label></th>
          <input type="hidden" name="price" class="in_txt"  style="width:80px" value=""   maxlength="9" />
          <td><input type="text" name="price_view" value="" class="text text_r" title="가격" style="width:200px;" maxlength="9"  onKeyUp = "saleCntCal('hueBookReRegist.price')"> 원<span class="guide_txt">&nbsp;&nbsp;* 원화가 아닌경우 환율로 계산해서 입력해주세요.</span></td>
         </tr>
         <tr> 
          	  <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>신청(권)수</label></th>
	          <td>
				<select name="requestBookCount">
								<option value="1권" selected="selected">1권</option>
								<option value="2권">2권</option>
								<option value="3권">3권</option>
								<option value="4권">4권</option>
								<option value="5권">5권</option>
								<option value="6권">6권</option>
								<option value="7권">7권</option>
								<option value="8권">8권</option>
								<option value="9권">9권</option>
								<option value="10권">10권</option>
								<option value="11권">11권</option>
								<option value="12권">12권</option>
								<option value="13권">13권</option>
								<option value="14권">14권</option>
								<option value="15권">15권</option>
								<option value="16권">16권</option>
								<option value="17권">17권</option>
								<option value="18권">18권</option>
								<option value="19권">19권</option>
								<option value="20권">20권</option>
						</select>      
	          </td>
			</tr>
        <tr>
         <th><label for="">신청일자</label></th>
          <td><span class="ico_calendar"><input id="calendarData1" class="text" style="width:100px;" name="requestDate" value="<%=strDate%>"/></span>
				<input type="hidden" value=""></input>
				</td>
        </tr>   
         <tr>
          <th><label for=""><span class="must_ico"><img src="<%=request.getContextPath()%>/images/common/must_icon_01.gif" alt="필수입력" /></span>내용(목차)</label></th>
          <td><textarea name="contents" value="" class="text" title="내용(목차)" style="width:916px;height:192px;" dispName="내용 " onKeyUp="js_Str_ChkSub('1000', this)"></textarea></td>
        </tr>
        </tbody>
      </table>
      </fieldset>
    </form>
   <!-- button -->
    <div class="Bbtn_areaC"><a href="javascript:goSave();" class="btn_type02"><span>신청</span></a><a href="javascript:cancle();"class="btn_type02 btn_type02_gray"><span>취소</span></a></div>
   <!-- //button -->
  </div>
  <!-- //con -->
</div>
<!-- //contents -->
</div>
<!-- //container -->
<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->
</div>
</body>
</html>

<%= comDao.getMenuAuth(menulist,"50")%>
