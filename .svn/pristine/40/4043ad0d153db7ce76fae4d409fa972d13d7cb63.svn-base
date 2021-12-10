<%@page import="com.sun.corba.se.pept.broker.Broker"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="javax.servlet.*"%>
<%@ page import ="com.huation.framework.util.*"%>
<%@ page import ="com.huation.framework.persist.ListDTO"%>
<%@ page import ="com.huation.framework.data.DataSet"%>
<%@ page import ="com.huation.common.CodeParam"%>
<%@ page import ="com.huation.common.util.CommonUtil"%>
<%@ page import ="com.huation.common.config.AuthDTO" %>
<%@ page import ="com.huation.common.config.MenuDTO" %>
<%@ page import ="com.huation.common.user.UserBroker" %>
<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@page import="com.huation.common.hollyday.HollyDAO"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%

	Map model = (Map)request.getAttribute("MODEL");
	
	String curPage = (String)model.get("curPage");
	String searchGb = (String)model.get("searchGb");
	String searchtxt = (String)model.get("searchtxt");
	String userids = "";
	String positions="";
	String StateFlag="";
	
	MenuDTO mtDto = (MenuDTO)model.get("mtDto");
	AuthDTO atDto = (AuthDTO)model.get("atDto");
	String AuthID = (String)model.get("AuthID");

	ArrayList<AuthDTO> arraylist = (ArrayList)model.get("arraylist");
	UserMemDTO dtoUsers = new UserMemDTO();	
	dtoUsers = BaseAction.getSession(request); 
	HollyDAO hollyDayDao = new HollyDAO();
	HollyDTO hollyDayDto = new HollyDTO();
	
	
	

	
	positions = dtoUsers.getPosition();
	userids=dtoUsers.getUserId();
	
	if(positions.equals("")){
		positions = "5";
	}
	
	
	
	if(positions.equals("1")){
		StateFlag="1";
	}else{
		StateFlag="2";
	}
	
	hollyDayDto.setUserID(userids);
	hollyDayDto.setJobGb(StateFlag);
	
	ListDTO lds = hollyDayDao.hollyApproveList(hollyDayDto);
	ListDTO lds2 = hollyDayDao.hollyTodayList(hollyDayDto);	
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>hueware 메인</title>
<link href="<%= request.getContextPath()%>/css/default.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%= request.getContextPath()%>/css/content.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.9.1.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.banner.js"></script>
<script type="text/javascript">


var formObj;
//상세페이지 이동
function goDetailNotify(Seq){
	formObj=document.mainPageForm;
	
	 formObj.target ='_self';
	 formObj.action = "<%= request.getContextPath()%>/B_DispNotify.do?cmd=dispNotifyView";
	 formObj.Seq.value=Seq;
	 formObj.submit();
}
function goDetailFormFile(Seq){
	formObj=document.mainPageForm;
	
	 formObj.target ='_self';
	 formObj.action = "<%= request.getContextPath()%>/B_FormFile.do?cmd=formfileView";
	 formObj.Seq.value=Seq;
	 formObj.submit();
}
function goDetailFamilyEvent(Seq){
	formObj=document.mainPageForm;
	
	 formObj.target ='_self';
	 formObj.action = "<%= request.getContextPath()%>/B_FamilyEvent.do?cmd=familyEventView";
	 formObj.Seq.value=Seq;
	 formObj.submit();
}
function goDetailFreeBoard(Seq){
	formObj=document.mainPageForm;
	
	 formObj.target ='_self';
	 formObj.action = "<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardView";
	 formObj.Seq.value=Seq;
	 formObj.submit();
}
function goDetailNewsMagazine(Seq){
	formObj=document.mainPageForm;
	
	 formObj.target ='_self';
	 formObj.action = "<%= request.getContextPath()%>/B_NewsMagazine.do?cmd=newsMagazineView";
	 formObj.Seq.value=Seq;
	 formObj.submit();
}
function goDetailDocumentFile(Seq){
	formObj=document.mainPageForm;
	
	 formObj.target ='_self';
	 formObj.action = "<%= request.getContextPath()%>/B_DocumentFile.do?cmd=documentfileView";
	 formObj.Seq.value=Seq;
	 formObj.submit();
}


	//Huationist 정신  이미지 롤링
	$(function() {
		$("#visual").jQBanner({	//롤링을 할 영역의 ID 값
			nWidth:1200,					//영역의 width
			nHeight:200,				//영역의 height
			nCount:10,					//돌아갈 이미지 개수
			isActType:"left",				//움직일 방향 (left, right, up, down)
			nOrderNo:1,					//초기 이미지
			nDelay:4000					//롤링 시간 타임 (1000 = 1초)
			/*isBtnType:"li"*/			//라벨(버튼 타입) - 여기는 안쓰임
			});
	});
	
	
function inits(){
	if(<%=lds2.getItemCount()%>>0){
 		if(getCookie('showblack') != 'test') {       
 			goHollyTodayPop(); 
 			}
 	}
 	
 	if((<%=positions%>=='1' && <%=lds.getItemCount()%>>0) || (<%=positions%>=='2' && <%=lds.getItemCount()%>>0) || (<%=positions%>=='3' && <%=lds.getItemCount()%>>0 )){
 		 goHollyApprovePop(); 
	}
}



function getCookie(name){    
	var wcname = name + '=';
	var wcstart, wcend, end;
	var i = 0;    

	  while(i <= document.cookie.length) {            
	   wcstart = i;  
	 wcend   = (i + wcname.length);            
	 if(document.cookie.substring(wcstart, wcend) == wcname) {                    
	  if((end = document.cookie.indexOf(';', wcend)) == -1)                           
	   end = document.cookie.length;                    
	  return document.cookie.substring(wcend, end);            
	   }            

	 i = document.cookie.indexOf('', i) + 1;            
	  
	   if(i == 0)                    
	  break;    
	  }    
	  return '';
	} 
//휴가결재 팝업창
function goHollyApprovePop(){

var top, left,scroll;
   var width='705';
   var height='400';
   var loc='center';
   
	scroll='1';
	if(loc != null) {
		top	 = screen.height/2 - height/2 - 50;
		left = screen.width/2 - width/2 ;
	} else {
		top  = 10;
		left = 10;
	}
			
	var	option = 'width='+width+',height='+height+',top=200,left=630,resizable=no,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;

	var openWin = window.open("<%=request.getContextPath()%>/H_Holly.do?cmd=leaveApplicant", "goHollyApprovePop",option);
	if(openWin != null) {
		openWin.focus();
	}
}
	
//오늘의 휴가자 팝업창
function goHollyTodayPop(){

var top, left,scroll;
   var width='505';
   var height='360';
   var loc='center';
   
	scroll='1';
	if(loc != null) {
		top	 = screen.height/2 - height/2 - 50;
		left = screen.width/2 - width/2 ;
	} else {
		top  = 10;
		left = 10;
	}
			
	var	option = 'width='+width+',height='+height+',top=200,left=100,resizable=no,location=no,status=no,toolbar=no,menubar=no,scrollbars=' + scroll;

	var openWin = window.open("<%=request.getContextPath()%>/H_Holly.do?cmd=leaveToday", "goHollyTodayPop",option);
	if(openWin != null) {
		openWin.focus();
	}
}


</script>

</head>
<body onload="inits();">
<div id="wrap">
<!-- header -->
<%@ include file="/jsp/hueware/common/include/top.jsp" %>
<!-- //header -->

    <!-- Huationist 정신 -->
    <div id="visual">
    	<div class="visual_area">
	    	<!-- 휴에이션정신 순서대로 이미지 전환 -->    	
	    	<div class="clsBannerScreen">
		       	<div><img src="<%= request.getContextPath()%>/images/main/visual_img_01.jpg" alt="Huationist정신 : 창의적으로 생각하고 주도적으로 행동한다.(휴에이션인이 가져야 할 정신적인 키워드는 신뢰, 공유, 가치, 창조입니다.)" /></div>
				<div><img src="<%= request.getContextPath()%>/images/main/visual_img_02.jpg" alt="Huationist정신 : 철저하게 준비하여 뛰어넘는 습관을 체화한다.(휴에이션인이 가져야 할 정신적인 키워드는 신뢰, 공유, 가치, 창조입니다.)" /></div>
				<div><img src="<%= request.getContextPath()%>/images/main/visual_img_03.jpg" alt="Huationist정신 : 지식을 공유하여 동반 성장을 도모한다.(휴에이션인이 가져야 할 정신적인 키워드는 신뢰, 공유, 가치, 창조입니다.)" /></div>
				<div><img src="<%= request.getContextPath()%>/images/main/visual_img_04.jpg" alt="Huationist정신 : 실수와 실패를 인정하고 이를 통해 성장한다.(휴에이션인이 가져야 할 정신적인 키워드는 신뢰, 공유, 가치, 창조입니다.)" /></div>
				<div><img src="<%= request.getContextPath()%>/images/main/visual_img_05.jpg" alt="Huationist정신 : 완전한 책임감으로 끝까지 결과를 도출한다.(휴에이션인이 가져야 할 정신적인 키워드는 신뢰, 공유, 가치, 창조입니다.)" /></div>
				<div><img src="<%= request.getContextPath()%>/images/main/visual_img_06.jpg" alt="Huationist정신 : 위험을 감수하고 크게 생각하여 행동한다.(휴에이션인이 가져야 할 정신적인 키워드는 신뢰, 공유, 가치, 창조입니다.)" /></div>
				<div><img src="<%= request.getContextPath()%>/images/main/visual_img_07.jpg" alt="Huationist정신 : 구성원간 신뢰를 구축하고 나보다 우리를 먼저 생각한다.(휴에이션인이 가져야 할 정신적인 키워드는 신뢰, 공유, 가치, 창조입니다.)" /></div>
				<div><img src="<%= request.getContextPath()%>/images/main/visual_img_08.jpg" alt="Huationist정신 : 끊임없이 학습하고 의식적으로 쇄신한다.(휴에이션인이 가져야 할 정신적인 키워드는 신뢰, 공유, 가치, 창조입니다.)" /></div>
				<div><img src="<%= request.getContextPath()%>/images/main/visual_img_09.jpg" alt="Huationist정신 : 고객의 가치에서 생각하고 사용자 입장에서 구현한다.(휴에이션인이 가져야 할 정신적인 키워드는 신뢰, 공유, 가치, 창조입니다.)" /></div>
				<div><img src="<%= request.getContextPath()%>/images/main/visual_img_10.jpg" alt="Huationist정신 : 감정이입과 공감을 통해 감성으로 리드한다.(휴에이션인이 가져야 할 정신적인 키워드는 신뢰, 공유, 가치, 창조입니다.)" /></div>
			</div>
			<!-- //휴에이션정신 순서대로 이미지 전환 -->
		</div>    
    </div>
	
	<!-- 게시판 -->
	<form method="post"	name="mainPageForm">
	<input type="hidden" name="Seq" value=""></input>
		
	<!-- 키값 Seq 넘겨주기 -->
	
	 <!-- :: loop :: -->
      <!--리스트---------------->
	  <%
		ListDTO ld = (ListDTO) model.get("listInfo");
		DataSet ds = (DataSet) ld.getItemList();
		
		int iTotCnt = ld.getTotalItemCount();
		int iCurPage = ld.getCurrentPage();
		int iDispLine = ld.getListScale();
		int startNum = ld.getStartPageNum();
	%>

		<%
		//사용자별 메뉴권한 체크후 메인 페이지 6개의 프레임 보여지기 여부.2012_10_24(수)bsh
		//현재 어레이 형태로받는중
		for(int j=0; j < menulist.size(); j++){
			atDto = arraylist.get(j);
				
			if(atDto.getMenuID().equals("M61000")){
		%>
		
<!-- container -->
	<div id="container" class="main_board" >
		<div id=M61000 >
			<h3>전사공지</h3>
			<ul>
        <%
                if (ld.getItemCount() > 0) {
                    int i = 0;
                    while (ds.next()) {
                    	if(i==0){
            %>  
							<li class="first"><a href="javascript:goDetailNotify('<%=ds.getString("Seq")%>')"><span class="ellipsis"><%=ds.getString("Title") %></span><span class="date"> <%=ds.getString("CreateDate") %> <%=ds.getString("CreateTime") %></span></a></li>
				
            
            <%
                    		i++;
                    	}else {
             %>
             				<li><a href="javascript:goDetailNotify('<%=ds.getString("Seq")%>')"><span class="ellipsis"><%=ds.getString("Title") %></span><span class="date"> <%=ds.getString("CreateDate") %> <%=ds.getString("CreateTime") %></span></a></li>
             <%
                    		i++;
                    	}
            	
                    }
                }else{
                	
            %>
            <%
            
                }
            %>
			</ul>
			<p class="more"><a href="<%=request.getContextPath()%>/B_DispNotify.do?cmd=dispNotifyPageList"><img src="<%= request.getContextPath()%>/images/main/btn_more.gif" alt="전사공지 더보기" /></a></p>
		</div>
			<%
			
			}else{
			%>
			
			<%
			}
			%>
			<%
			}
			%>
	
		<%
			ListDTO ld2 = (ListDTO) model.get("listInfo2");
			DataSet ds2 = (DataSet) ld2.getItemList();
			
			int iTotCnt2 = ld2.getTotalItemCount();
			int iCurPage2 = ld2.getCurrentPage();
			int iDispLine2 = ld2.getListScale();
			int startNum2= ld2.getStartPageNum();
		%>
	
			<%
			//사용자별 메뉴권한 체크후 메인 페이지 6개의 프레임 보여지기 여부.2012_10_24(수)bsh
			for(int j=0; j < menulist.size(); j++){
			 atDto = arraylist.get(j);
				
				if(atDto.getMenuID().equals("M62000")){
			%>
		<div id=M62000 class="pd_no">
			<h3>서식파일</h3>
			<ul>
			<%
		    if (ld2.getItemCount() > 0) {
                int i2 = 0;
                while (ds2.next()) {
                	if(i2==0){
			%>
				<li class="first"><a href="javascript:goDetailFormFile('<%=ds2.getString("Seq")%>')"><span class="ellipsis"><%=ds2.getString("Title") %></span><span class="date"> <%=ds2.getString("CreateDate") %> <%=ds2.getString("CreateTime") %></span></a></li>
			 <%
			 			i2++;
                	}else {
              %>
               <li><a href="javascript:goDetailFormFile('<%=ds2.getString("Seq")%>')"><span class="ellipsis"><%=ds2.getString("Title") %></span><span class="date"> <%=ds2.getString("CreateDate") %> <%=ds2.getString("CreateTime") %></span></a></li>
            <%
                		
	                	
	            	i2++;
	                }
                }
             }else{
                	
            %>
            <%
            
                }
            %>
			</ul>
			<p class="more"><a href="<%=request.getContextPath()%>/B_FormFile.do?cmd=formFilePageList"><img src="<%= request.getContextPath()%>/images/main/btn_more.gif" alt="서식파일 더보기" /></a></p>
		</div>
			<%
			}else{
			%>
			
			<%
			}
			%>
			<%
			}
			%>
		<%
			ListDTO ld3 = (ListDTO) model.get("listInfo3");
			DataSet ds3 = (DataSet) ld3.getItemList();
			
			int iTotCnt3 = ld3.getTotalItemCount();
			int iCurPage3 = ld3.getCurrentPage();
			int iDispLine3 = ld3.getListScale();
			int startNum3= ld3.getStartPageNum();
		%>
	
			<%
			//사용자별 메뉴권한 체크후 메인 페이지 6개의 프레임 보여지기 여부.2012_10_24(수)bsh
			for(int j=0; j < menulist.size(); j++){
			 atDto = arraylist.get(j);
				
				if(atDto.getMenuID().equals("M63000")){
			%>
		<div id="M63000">
			<h3>경조사</h3>
			<ul>
			<%
		    if (ld3.getItemCount() > 0) {
                int i3 = 0;
                while (ds3.next()) {
                	if(i3==0){
			%>
						<li class="first"><a href="javascript:goDetailFamilyEvent('<%=ds3.getString("Seq")%>')"><span class="ellipsis"><%=ds3.getString("Title") %></span><span class="date"> <%=ds3.getString("CreateDate") %> <%=ds3.getString("CreateTime") %></span></a></li>
 			<%
                		i3++;
                	}else {
             %>
             			<li><a href="javascript:goDetailFamilyEvent('<%=ds3.getString("Seq")%>')"><span class="ellipsis"><%=ds3.getString("Title") %></span><span class="date"> <%=ds3.getString("CreateDate") %> <%=ds3.getString("CreateTime") %></span></a></li>
             <%
             			i3++;
		            }
                }
             }else{
                	
            %>
            <%
            
                }
            %>
			</ul>
			<p class="more"><a href="<%=request.getContextPath()%>/B_FamilyEvent.do?cmd=familyEventPageList"><img src="<%= request.getContextPath()%>/images/main/btn_more.gif" alt="경조사 더보기" /></a></p>
		</div>
			<%
			}else{
			%>
			
			<%
			}
			%>
			<%
			}
			%>
			
			
			<%
			ListDTO ld4 = (ListDTO) model.get("listInfo4");
			DataSet ds4 = (DataSet) ld4.getItemList();
			
			int iTotCnt4 = ld4.getTotalItemCount();
			int iCurPage4 = ld4.getCurrentPage();
			int iDispLine4 = ld4.getListScale();
			int startNum4= ld4.getStartPageNum();
			%>
		
			
			<%
				
			//사용자별 메뉴권한 체크후 메인 페이지 6개의 프레임 보여지기 여부.2012_10_24(수)bsh
			for(int j=0; j < menulist.size(); j++){
			 atDto = arraylist.get(j);
				
				if(atDto.getMenuID().equals("M64000")){
			%>
		<div id="M64000" class="pd_no">
			<h3>자유게시판</h3>
			<ul>
			<%
		    if (ld4.getItemCount() > 0) {
                int i4 = 0;
                while (ds4.next()) {
                	if(i4==0){
			%>
						<li class="first"><a href="javascript:goDetailFreeBoard('<%=ds4.getString("Seq")%>')"><span class="ellipsis"><%=ds4.getString("Title") %></span><span class="date"> <%=ds4.getString("CreateDate") %> <%=ds4.getString("CreateTime") %></span></a></li>
			<% 
						i4++;
                	}else {
            %>
            			<li><a href="javascript:goDetailFreeBoard('<%=ds4.getString("Seq")%>')"><span class="ellipsis"><%=ds4.getString("Title") %></span><span class="date"> <%=ds4.getString("CreateDate") %> <%=ds4.getString("CreateTime") %></span></a></li>
            <%
                		i4++;
                	}
            	
                }
             }else{
                	
            %>
            <%
            
                }
            %>
			</ul>
			<p class="more"><a href="<%=request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardPageList"><img src="<%= request.getContextPath()%>/images/main/btn_more.gif" alt="자유게시판 더보기" /></a></p>
		</div>
		<%
			}else{
			%>
			
			<%
			}
			%>
			<%
			}
			%>
		<%
			ListDTO ld5 = (ListDTO) model.get("listInfo5");
			DataSet ds5 = (DataSet) ld5.getItemList();
			
			int iTotCnt5 = ld5.getTotalItemCount();
			int iCurPage5 = ld5.getCurrentPage();
			int iDispLine5 = ld5.getListScale();
			int startNum5= ld5.getStartPageNum();
			%>
			
			<%
			//사용자별 메뉴권한 체크후 메인 페이지 6개의 프레임 보여지기 여부.2012_10_24(수)bsh
			for(int j=0; j < menulist.size(); j++){
			 atDto = arraylist.get(j);
				
				if(atDto.getMenuID().equals("M65000")){
			%>
				
		<div id="M65000">
			<h3>News & Magazine</h3>
			<ul>
			<%
		    if (ld5.getItemCount() > 0) {
                int i5 = 0;
                while (ds5.next()) {
                	if(i5==0){
			%>
					<li class="first"><a href="javascript:goDetailNewsMagazine('<%=ds5.getString("Seq")%>')"><span class="ellipsis"><%=ds5.getString("Title") %></span><span class="date"> <%=ds5.getString("CreateDate") %> <%=ds5.getString("CreateTime") %></span></a></li>
			<%
						i5++;
                	}else {
             %>
             			<li><a href="javascript:goDetailNewsMagazine('<%=ds5.getString("Seq")%>')"><span class="ellipsis"><%=ds5.getString("Title") %></span><span class="date"> <%=ds5.getString("CreateDate") %> <%=ds5.getString("CreateTime") %></span></a></li>
             <%
                		i5++;
                	}
            	
                }
             }else{
                	
            %>
            <%
            
                }
            %>
			</ul>
			<p class="more"><a href="<%=request.getContextPath()%>/B_NewsMagazine.do?cmd=newsMagazinePageList"><img src="<%= request.getContextPath()%>/images/main/btn_more.gif" alt="News&Magazine 더보기" /></a></p>
		</div>

			<%
			
			}else{
			%>
		
			<%
			}
			%>
			<%
			}
			%>
		<%
			ListDTO ld6 = (ListDTO) model.get("listInfo6");
			DataSet ds6 = (DataSet) ld6.getItemList();
			
			int iTotCnt6 = ld6.getTotalItemCount();
			int iCurPage6 = ld6.getCurrentPage();
			int iDispLine6 = ld6.getListScale();
			int startNum6 = ld6.getStartPageNum();
			%>
			<%
				
			//사용자별 메뉴권한 체크후 메인 페이지 6개의 프레임 보여지기 여부.2012_10_24(수)bsh
			for(int j=0; j < menulist.size(); j++){
			 atDto = arraylist.get(j);
				
				if(atDto.getMenuID().equals("M66000")){
			%>
		<div id="M66000"  class="pd_no">
			<h3>업무Manual</h3>
			<ul>
			<%
		    if (ld6.getItemCount() > 0) {
                int i6 = 0;
                while (ds6.next()) {
                	if(i6==0){
			%>
						<li class="first"><a href="javascript:goDetailDocumentFile('<%=ds6.getString("Seq")%>')"><span class="ellipsis"><%=ds6.getString("Title") %></span><span class="date"><%=ds6.getString("CreateDate") %> <%=ds6.getString("CreateTime") %></span></a></li>
			<%
						i6++;
                	}else{
             %>
             			<li><a href="javascript:goDetailDocumentFile('<%=ds6.getString("Seq")%>')"><span class="ellipsis"><%=ds6.getString("Title") %></span><span class="date"><%=ds6.getString("CreateDate") %> <%=ds6.getString("CreateTime") %></span></a></li>
             <%
                		i6++;
                	}
            	
                   }
             }else{
                	
            %>
            <%
            
                }
            %>
			</ul>
			<p class="more"><a href="<%=request.getContextPath()%>/B_DocumentFile.do?cmd=documentFilePageList"><img src="<%= request.getContextPath()%>/images/main/btn_more.gif" alt="업무Menual 더보기" /></a></p>
		</div>
			<%
			
			}else{
			%>
		
			<%
			}
			%>
			<%
			}
			%>
    
		</div>
	</form>
<!-- //contents -->
<!-- footer -->
<%@ include file="/jsp/hueware/common/include/footer.jsp" %>
<!-- //footer -->
</div>
</body>
</html>
<%= comDao.getMenuAuth(menulist,"HOME") %>
