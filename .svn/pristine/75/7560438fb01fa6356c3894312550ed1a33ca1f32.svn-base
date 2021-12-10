<%@page import="com.huation.common.hollyday.HollyDTO"%>
<%@page import="com.huation.common.hollyday.HollyDAO"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.CommonDAO"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%@ page import="com.huation.common.user.UserDAO"%>
<%@ page import="com.huation.common.user.UserDTO"%>
<%@ page import ="com.huation.common.config.AuthDAO"%>
<%@ page import ="com.huation.common.config.MenuDTO"%>
<%@ page import ="com.huation.common.config.AuthDTO"%>
<%@ page import="com.huation.common.util.*"%>
<%@ page import ="com.huation.common.waf.*"%>
<%@ page import ="com.huation.common.BaseAction"%>
<%@ page import ="com.huation.common.user.UserMemDTO"%>
<%@page import ="com.huation.framework.persist.ListDTO"%>
<%@page import ="com.huation.framework.util.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
	<%
	String userid = "";
	String name = "";
	String passwd ="";
	String groupnm ="";
	
	boolean bLogin = BaseAction.isSession(request);	
	UserMemDTO dtoUser = new UserMemDTO();			
	
	if(bLogin == true) {
		dtoUser = BaseAction.getSession(request); 
	}else{
	
	%>

	<script>
	location.href='<%= request.getContextPath()%>/B_Login.do?cmd=loginForm';
	</script>
	
	<%	
	}
	
	userid=dtoUser.getUserId();
	name=dtoUser.getUserNm();
	passwd=dtoUser.getPasswd();
	groupnm=dtoUser.getGroupnm();
	
	AuthDAO authDao = new AuthDAO();
	AuthDTO authDto = new AuthDTO();
	UserDAO userDao = new UserDAO();
	UserDTO userDto = new UserDTO();
	
	authDto.setUserID(userid);
	
	ArrayList<MenuDTO> menulist  =  authDao.userAuthMenuTree(authDto);
	CommonDAO comDao=new CommonDAO();
	
	//userDto.setLogid(logid);
	userDto.setID(userid);

	
	userDto = userDao.userView(userDto);
	
	
	String userGrade = "";

	if(bLogin == true){
		dtoUser = BaseAction.getSession(request); 
		userGrade="M01";

	}
	
	%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="<%= request.getContextPath() %>/css/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
<script src="<%= request.getContextPath()%>/js/hueware.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-1.11.1.min.js"/></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-ui-1.10.2.custom.js"/></script>
<script type="text/javascript">
	/*
   	$(function(){
	    //li에 마우스 오버 되었을 때
	    $('.lnb li').hover(
	        function(){
	            $('ul',this).removeClass("hidden_obj");
	            $('a',this).addClass('on');
	        },
 	        function(){
	            $('ul',this).addClass("hidden_obj");
	            $('a',this).removeClass("on");
	        }) 
	});   
	*/
	//로그아웃
	function logout() {
		location.href = "<%= request.getContextPath()%>/B_Login.do?cmd=loginOff";
	}
	
	//휴웨어 이미지 클릭하면 메인화면으로 이동함
	function reflesh(){
        location.href = "<%= request.getContextPath()%>/B_Common.do?cmd=mainPage";

	}
	
	//비밀번호 변경
<%-- 	function passwdEdit() {

		var userid=document.topfrm.userid.value;
		var passwd=document.topfrm.passwd.value;
		var pop = window.open("<%= request.getContextPath()%>/B_User.do?cmd=passwdEdit&user_id="+userid+"&passwd="+passwd+"&page=E","passwdEdit","width=300,height=250,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");

	} --%>

	
	var Menu ="";	
	
	//비밀번호 변경 레이아웃 팝업
	function passwdEdit() {
		var login_UserID = '<%=userid%>';
		var login_PassWord = '<%=passwd%>';
		$('#password_pop').dialog({
			resizable : false, //사이즈 변경 불가능
			draggable : false, //드래그 불가능
			closeOnEscape : true, //ESC 버튼 눌렀을때 종료
			
			height : 249,
			width : 320,
			modal : true,
			position : [1295,50],
			open:function(){
				
				//팝업 가져올 url
				$(this).load('<%= request.getContextPath() %>/B_User.do?cmd=passwdEdit',
						{"user_id" : login_UserID , "passwd" : login_PassWord}); 
				//레이아웃 바깥쪽 클릭 시 팝업 닫히도록 세팅
				/*
				$('.ui-widget-overlay').bind('click',function(){
	                $('#JobRegistPop').dialog('close');
	            });
				*/
				
			}
		});
		
	}
	
	//선택메뉴 열고닫기
	function menuOption(index){
		var menu=document.all.menu;
		var menu_s=document.all.menu_s;
		var subm=null;
		
		for(i=0;i<menu.length;i++){
	
			subm=eval("document.all.subm_"+i);
			
			
			if(i==index){
				if(subm.length>1){
					for(j=0;j<subm.length;j++){
							subm[j].style.display='block';
					}
				}else{
							subm.style.display='block';
				}
				
				menu_s[i].style.display='block';
				
			}else{
				if(subm.length>1){
					for(j=0;j<subm.length;j++){
							subm[j].style.display='none';
					}
				}else {
							subm.style.display='none';
				}
				
				menu_s[i].style.display='none';
			}
		}
	}
	
	//선택메뉴 표기
	function selectMenu(m_index,s_index){
	
		var menu=document.all.menu;
		var subm=null;
		var subtext=null;
		
		for(i=0;i<menu.length;i++){
	
			subm=eval("document.all.subm_"+i);
			
			if(i==m_index){
				if(subm.length>1){
					for(j=0;j<subm.length;j++){
						subtext=eval("document.all.M"+i+j);
						if(j==s_index){
							subtext.style.color='#43BA0B';
							subtext.style.fontWeight ="bold";
						}else{
							subtext.style.color='';
							subtext.style.fontWeight ='';
						}
					}
				}else{
					subtext=eval("document.all.M"+i+"0");
					subtext.style.color='#43BA0B';
					subtext.style.fontWeight ='bold';
	
				}
			}else{
				for(j=0;j<subm.length;j++){
						subtext=eval("document.all.M"+i+j);
						subtext.style.color='';
						subtext.style.fontWeight ='';
				}
			}
		}
		
	}
	
	//메뉴세팅	
	function menuSetting(menu){
		
		$(".snb").addClass("display_none");
	 	switch (menu){
			
			case "00" :		//총무지원 - 업체관리 메뉴활성화
				$("#M21000 a").addClass("on");
				$(".lnb_01 a").eq(0).addClass("on");
				$(".lnb_01 div").removeClass("display_none");
				break;
			
			case "01" :		//총무지원 - 법인통장관리 메뉴활성화
				$("#M22000 a").addClass("on");
				$(".lnb_01 a").eq(0).addClass("on");
				$(".lnb_01 div").removeClass("display_none");
				break;
			
			case "10" :		//영업지원 -  영업진행현황
				$("#M31000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
			
			case "11" :		//영업지원 - 견적서발행 메뉴활성화
				$("#M32000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
			case "19" :		//영업지원 - 견적서발행(전체) 메뉴활성화
				$("#M32100 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
				
			case "12" :		//영업지원 - 계약코드 미발행 현황
				$("#M33000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
			
			case "13" :		//영업지원 - 계약등록
				$("#M34000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
				
			case "14" :		//영업지원 - 계약관리 메뉴활성화
				$("#M35000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
			
			case "15" :		//영업지원 - 계산서 미발행 현황
				$("#M36000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
				
			case "16" :		//영업지원 - (구)세금계산서발행 메뉴활성화
				$("#M37000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
				
 			case "17" :		//영업지원 - (신)세금계산서발행 메뉴활성화
 				$("#M38000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
				
 			case "18" :	//영업지원 - 미수채권현황	
 				$("#M39000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
				
			case "20" :		//프로젝트지원 - 프로젝트조회 메뉴활성화
				$("#M41000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
			
			case "21" :		//프로젝트지원 - 프로젝트코드(등록/수정) 메뉴활성화
				$("#M42000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
			
			case "22" :		//프로젝트지원 - 프로젝트진행관리 메뉴활성화
				$("#M43000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
				
			case "23" :		//프로젝트지원 - 정기점검 메뉴활성화
				$("#M44000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
			case "24" :		//프로젝트지원 - 비정기점검 메뉴활성화
				$("#M45000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
			
			case "25" :		//프로젝트지원 - 정기점검(한솔팩스) 메뉴활성화
				$("#M46000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
			
			case "26" :		//프로젝트지원 - 비정기점검(한솔팩스) 메뉴활성화
				$("#M47000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
				
			case "27" :		//프로젝트지원 - 정기점검(종합) 메뉴활성화
				$("#M44500 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
				
			case "28" :		//프로젝트지원 - 비정기점검(종합) 메뉴활성화
				$("#M45500 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
				
			case "30" :		//게시판 - 전사공지 메뉴활성화
				$("#M61000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
			
			case "31" :		//게시판 - 서식파일 메뉴활성화
				$("#M62000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
			
			case "32" :		//게시판 - 경조사 메뉴활성화
				$("#M63000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
				
			case "33" :		//게시판 - 자유게시판 메뉴활성화
				$("#M64000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
			
			case "34" :		//게시판 - NewsMagazine 메뉴활성화
				$("#M65000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
			
			case "35" :		//게시판 - 업무Manual 메뉴활성화
				$("#M66000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
				
			case "36" :		//추가게시판
				$("#M67000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
//=======================================================================================			
			case "37" :		//휴폐업 ----------------------------- 개발 진행중
				$("#M68000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
//=======================================================================================			
			case "40" :		//HUEHome관리 - 공지사항 메뉴활성화
				$("#M51000 a").addClass("on");
				$(".lnb_05 a").eq(0).addClass("on");
				$(".lnb_05 div").removeClass("display_none");
				break;
			
			case "41" :		//HUEHome관리 - Lastest News 메뉴활성화
				$("#M52000 a").addClass("on");
				$(".lnb_05 a").eq(0).addClass("on");
				$(".lnb_05 div").removeClass("display_none");
				break;
			
			case "42" :		//HUEHome관리 - 채용공고 메뉴활성화
				$("#M53000 a").addClass("on");
				$(".lnb_05 a").eq(0).addClass("on");
				$(".lnb_05 div").removeClass("display_none");
				break;			
				
			case "43" :		//HUEHome관리 - 채용관리 메뉴활성화
				$("#M54000 a").addClass("on");
				$(".lnb_05 a").eq(0).addClass("on");
				$(".lnb_05 div").removeClass("display_none");
				break;
				
			case "44" :		//HUEHome관리 - 자주하는질문 메뉴활성화
				$("#M55000 a").addClass("on");
				$(".lnb_05 a").eq(0).addClass("on");
				$(".lnb_05 div").removeClass("display_none");
				break;
				
			case "45" :		//HUEHome관리 - 1:1질문 메뉴활성화
				$("#M56000 a").addClass("on");
				$(".lnb_05 a").eq(0).addClass("on");
				$(".lnb_05 div").removeClass("display_none");
				break;
				
			
			case "50" :		//HUEBook - 도서신청 메뉴활성화
				$("#M71000 a").addClass("on");
				$(".lnb_06 a").eq(0).addClass("on");
				$(".lnb_06 div").removeClass("display_none");
				break;
				
			case "51" :		//HUEBook - 도서결재 메뉴활성화
				$("#M72000 a").addClass("on");
				$(".lnb_06 a").eq(0).addClass("on");
				$(".lnb_06 div").removeClass("display_none");
				break;
				
			case "52" :		//HUEBook - 휴북목록 메뉴활성화
				$("#M73000 a").addClass("on");
				$(".lnb_06 a").eq(0).addClass("on");
				$(".lnb_06 div").removeClass("display_none");
				break;
				
			
			case "60" :		//관리 - 계정관리 메뉴활성화
				$("#M11000 a").addClass("on");
				$(".lnb_07 a").eq(0).addClass("on");
				$(".lnb_07 div").removeClass("display_none");
				break;
				
			case "61" :		//관리 - 그룹관리 메뉴활성화
				$("#M12000 a").addClass("on");
				$(".lnb_07 a").eq(0).addClass("on");
				$(".lnb_07 div").removeClass("display_none");
				break;
				
			case "62" :		//관리 - 메뉴권한관리 메뉴활성화
				$("#M13000 a").addClass("on");
				$(".lnb_07 a").eq(0).addClass("on");
				$(".lnb_07 div").removeClass("display_none");
				break;
				
			case "63" :		//관리 - 코드북관리 메뉴활성화
				$("#M14000 a").addClass("on");
				$(".lnb_07 a").eq(0).addClass("on");
				$(".lnb_07 div").removeClass("display_none");
				break;
			
			case "64" :		//관리 - 코드북관리 메뉴활성화
				$("#M15000 a").addClass("on");
				$(".lnb_07 a").eq(0).addClass("on");
				$(".lnb_07 div").removeClass("display_none");
				break;
	
				
			case "80" :		//휴가관리
				$("#M81000 a").addClass("on");
				$(".lnb_08 a").eq(0).addClass("on");
				$(".lnb_08 div").removeClass("display_none");
				break;
			case "81" :		//휴가결재
				$("#M82000 a").addClass("on");
				$(".lnb_08 a").eq(0).addClass("on");
				$(".lnb_08 div").removeClass("display_none");
				break;
			case "82" :		//휴가이력
				$("#M83000 a").addClass("on");
				$(".lnb_08 a").eq(0).addClass("on");
				$(".lnb_08 div").removeClass("display_none");
				break;
			case "83" :		//관리 - 휴공
				$("#M84000 a").addClass("on");
				$(".lnb_08 a").eq(0).addClass("on");
				$(".lnb_08 div").removeClass("display_none");
				break;	
		
		} 

	}

	
	
	//메뉴링크
	function goMenu(menu){
		
		
		var theUrl = '';
		
		if (menu=='HOME') {//HOME
			theUrl= '<%= request.getContextPath()%>/B_Common.do?cmd=mainPage';
		}else if (menu=='00') {//업체관리
			theUrl= '<%= request.getContextPath()%>/B_Company.do?cmd=companyPageList';
		}else if (menu=='01') {//법인통장관리
			theUrl= '<%= request.getContextPath()%>/B_BankManage.do?cmd=bankPageList';
		}else if (menu=='10') {//영업진행현황
			theUrl= '<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaPageList';
		}else if (menu=='11') {//견적서발행
			theUrl= '<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList';
		}else if (menu=='19') {//견적서발행(전체) (2018-12-04 추가, 20190207 메뉴명변경)
			theUrl= '<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList&type=search';
		}else if (menu=='12') {//계약코드 미발행 현황
			theUrl= '<%= request.getContextPath()%>/B_Estimate.do?cmd=contractCodeUnissued';
		}else if (menu=='13') {//계약등록
			theUrl= '<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgRegistList';
		}else if (menu=='14') {//계약관리
			theUrl= '<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgPageList';
		}else if (menu=='15') {//계산서미발행현황
			theUrl= '<%= request.getContextPath()%>/B_Invoice.do?cmd=invoiceUnissuedList';
		}else if (menu=='16') {//세금계산서발행
			theUrl= '<%= request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList';
		}else if (menu=='17') {//바로빌 세금계산서발행
			theUrl= '<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=baroInvoicePageList';
		}else if (menu=='18') {//미수채권현황
			theUrl= '<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=outstandingBondList';
		}else if (menu=='60') {//계정관리
			theUrl= '<%= request.getContextPath()%>/B_User.do?cmd=userPageList';
		}else if (menu=='61') {//그룹관리
			theUrl= '<%= request.getContextPath()%>/H_Group.do?cmd=groupManage';
		}else if (menu=='62') {//메뉴관리
			theUrl= '<%= request.getContextPath()%>/H_Auth.do?cmd=authManage';
		}else if (menu=='63') {//코드북관리
			theUrl= '<%= request.getContextPath()%>/B_Code.do?cmd=codePageList';
		}else if (menu=='64') {//휴일관리
			theUrl= '<%= request.getContextPath()%>/H_Holly.do?cmd=HollyDayMgPageList';
		}else if (menu=='20') {//프로젝트 코드관리 조회
			theUrl= '<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Search';
		}else if (menu=='21') {//프로젝트 코드관리 등록/수정
			theUrl= '<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Edit';
		}else if (menu=='22') {//프로젝트 코드관리 진행관리
			theUrl= '<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Progress';
		}else if (menu=='23') {//정기점검
			theUrl= '<%= request.getContextPath()%>/B_Project.do?cmd=projectPageList';
		}else if (menu=='24') {//비정기점검
			theUrl= '<%= request.getContextPath()%>/N_Project.do?cmd=projectPageList_Non';
		}else if (menu=='25') {//정기점검(한솔)
			theUrl= '<%= request.getContextPath()%>/B_Project_H.do?cmd=projectPageList_H';
		}else if (menu=='26') {//비정기점검(한솔)
			theUrl= '<%= request.getContextPath()%>/N_Project_H.do?cmd=projectPageList_Non_H';
		}else if (menu=='27') {//정기점검(종합)
			theUrl= '<%= request.getContextPath()%>/B_Project.do?cmd=projectPageListAll';
		}else if (menu=='28') {//비정기점검(종합)
			theUrl= '<%= request.getContextPath()%>/N_Project.do?cmd=projectPageListNonAll';
		}else if (menu=='40') {//공지사항
			theUrl= '<%= request.getContextPath()%>/B_About.do?cmd=notifyPageList';
		}else if (menu=='41') {//Lastest News
			theUrl= '<%= request.getContextPath()%>/B_About.do?cmd=newsPageList';
		}else if (menu=='42') {//채용공고
			theUrl= '<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitNotifyList';
		}else if (menu=='43') {//채용관리
			theUrl= '<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitManageList';
		}else if (menu=='44') {//자주하는질문
			theUrl= '<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitQnAList&qna_gb=01';
		}else if (menu=='45') {//1:1질문
			theUrl= '<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitQnAList&qna_gb=02';
		}else if (menu=='30') {//전사공지
			theUrl= '<%= request.getContextPath()%>/B_DispNotify.do?cmd=dispNotifyPageList';
		}else if (menu=='31') {//서식파일
			theUrl= '<%= request.getContextPath()%>/B_FormFile.do?cmd=formFilePageList';
		}else if (menu=='32') {//경조사
			theUrl= '<%= request.getContextPath()%>/B_FamilyEvent.do?cmd=familyEventPageList';
		}else if (menu=='33') {//자유게시판
			theUrl= '<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardPageList';
		}else if (menu=='34') {//News & Magazine
			theUrl= '<%= request.getContextPath()%>/B_NewsMagazine.do?cmd=newsMagazinePageList';
		}else if (menu=='35') {//업무Menual
			theUrl= '<%= request.getContextPath()%>/B_DocumentFile.do?cmd=documentFilePageList';
		}else if (menu=='36'){//추가게시판(2021.08.02)
			theUrl= '<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardList';
//==================================================================================================================			
		}else if (menu=='37'){//휴폐업(2021.12.07)
			theUrl= '<%= request.getContextPath()%>/B_ClosureMg.do?cmd=closureMgList';
//==================================================================================================================			
		}else if (menu=='50') {//도서신청
			theUrl= '<%= request.getContextPath()%>/B_HueBookManageRe.do?cmd=hueBookRePageList';
		}else if (menu=='51') {//도서결재
			theUrl= '<%= request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookAppPageList';
		}else if (menu=='52') {//휴북목록
			theUrl= '<%= request.getContextPath()%>/B_HueBookList.do?cmd=hueBookPageList';
		}else if (menu=='80') {//휴가관리
			theUrl= '<%= request.getContextPath()%>/H_Holly.do?cmd=leaveApplyPageList';
		}else if (menu=='80') {//휴가신청
			theUrl= '<%= request.getContextPath()%>/H_Holly.do?cmd=leaveApplyPageList';
		}else if (menu=='81') {//휴가결재
			theUrl= '<%= request.getContextPath()%>/H_Holly.do?cmd=leaveAppPageList';
		}else if (menu=='82') {//휴가이력
			theUrl= '<%= request.getContextPath()%>/H_Holly.do?cmd=leavePageList';
		}else if (menu=='83') {//휴가관리
			theUrl= '<%= request.getContextPath()%>/H_Holly.do?cmd=adminLeaveApplyPageList';
		}
		
		openWaiting(); //처리중 메세지 활성화
		location.href = theUrl;

	}
	
	function init(){
 		<%-- var objs=document.all.menu;

		if('<%=userGrade%>'=='M01'){

			goPage('00');

		}else if('<%=userGrade%>'=='M03'){

			goPage('10');
			objs[0].style.display='none';
			objs[2].style.display='none';

		}else if('<%=userGrade%>'=='M04'){

			goPage('00');
			objs[1].style.display='none';
			objs[2].style.display='none';

		}else{

			objs[0].style.display='none';
			objs[1].style.display='none';
			objs[2].style.display='none';
		} --%>
	<%--  <%
		String TmenuID = "";
		String menuID = "";
		
		 for(int j=3; j < menulist.size(); j++ ){	
				MenuDTO dto = menulist.get(j);
				
				TmenuID="T"+dto.getMenuID();
				menuID=dto.getMenuID();
				
				System.out.println(j+" "+TmenuID+"  |  "+menuID);
				%>
				
				var menuid = document.getElementById(<%=menuID%>);
				if(tmenuid!="undefined"){tmenuid.style.display='inline';}						
				if(menuid!="undefined"){ menuid.style.display='inline';}
			<%}%> --%>
			
	}
	
	function goPage(menu){

		var theUrl = '';
		var m_index=menu.substring(0,1);
		var s_index=menu.substring(1,2);

		menuOption(m_index); //메뉴 열고닫기
		selectMenu(m_index,s_index);//선택 서브메뉴 표기

		if(m_index=='0'){  // 총무지원
			if (menu=='00') {
				theUrl= '<%= request.getContextPath()%>/B_Company.do?cmd=companyPageList';
			}
		}else if (m_index=='1'){  //영업지원
			if (menu=='10') {
				theUrl= '<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList';
			}else if (menu=='11') {
				theUrl= '<%= request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList';
			}  
		}else if (m_index=='2'){  //기타관리
			if (menu=='20') {
				theUrl= '<%= request.getContextPath()%>/B_User.do?cmd=userPageList';
			}else if (menu=='21') {
				theUrl= '<%= request.getContextPath()%>/H_Group.do?cmd=groupManage';
			}else if (menu=='22') {
				theUrl= '<%= request.getContextPath()%>/H_Auth.do?cmd=authManage';
			}else if (menu=='23') {
				theUrl= '<%= request.getContextPath()%>/B_Code.do?cmd=codePageList';
			}
		}
		try {
			parent.mainFrame.openWaiting();
		} catch (e) {}

		parent.mainFrame.location.href = theUrl;

	}
	
	
	
	//2013-03-13 기존달력에서 jQuery 달력으로 변경
	$(document).ready(function(){
		$('#calendarData1, #calendarData2, #calendarData3').datepicker({
			buttonImage: "<%= request.getContextPath()%>/images/common/ico_calendar.gif",
			//maxDate:0,
			showOn: 'both',
			buttonImageOnly: true,
			prevText: "이전",
			nextText: "다음",
			dateFormat: "yy-mm-dd",
			dayNamesMin:["일","월","화","수","목","금","토"],
			monthNames:["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			changeMonth: true,
		    changeYear: true
		});
	});
	
	
	
	function goSmsPage(url){

		   var top, left,scroll;
		   var width='834';
		   var height='568';
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

			openWin = open(url, "_Sms",option);
			openWin.focus();
	}
	
	
	


		
	
</script>
</head>
<body onload="javascript:init();">
		<!-- header -->
		<div id="header">
			<h1><a href="javascript:reflesh()"><img src="<%= request.getContextPath()%>/images/layout/header_logo.gif" alt="Hueware" /></a></h1>
			<form name="topfrm">
			<input type="hidden" name="userid" value="<%= userid %>" />
			<input type="hidden" name="passwd" value="<%= passwd %>" />
			<div class="gnb">
				<ul>
					<li><%=groupnm %></li>
					<li><span class="user_name"><%= name %></span> 님(사번 : <%= userDto.getEmployeeNum() %>)</li>
					<li class="pic"><iframe src="<%= request.getContextPath()%>/B_Recruit.do?cmd=photo&photo=<%= StringUtil.nvl(userDto.getPhoto(),"")%>&Flag=M"  frameborder="0" height="88" width="72" name="photoFrame" marginwidth="0" marginheight="0" hspace="0" vspace="0" scrolling="no" frameborder="0" align="left"></iframe></li>
					<li class="pwmodify"><a href="javascript:passwdEdit();">비밀번호변경</a></li>
					<li class="last"><a href="javascript:logout();">로그아웃</a></li>
				</ul>
			</div>
			</form>
		
			<h2 class="hidden_obj">주메뉴</h2>
			<ul class="lnb">
			
				<!-- 총무지원 -->
				<li id="TM20000" style="display:none;" class="lnb_01"><a href="javascript:;" onclick="goMenu('00')" >총무지원</a><!-- 메뉴 활성화 : class="on" 추가 -->
					<div class="snb">
						<ul>
							<li id="M21000" style="display:none"><a href="javascript:goMenu('00');" >업체관리</a></li><!-- 메뉴 활성화 : class="on" 추가 -->
							<li id="M22000" style="display:none"><a href="javascript:goMenu('01');">법인통장관리</a></li>
						</ul>
					</div>
				</li>
				<!-- //총무지원 -->
				
				<!-- 영업지원 -->
				<li id="TM30000" style="display:none" class="lnb_02"><a href="javascript:;" onclick="goMenu('10')" >영업지원</a>
					<div class="snb display_none">
						<ul>
							<li id="M31000" style="display:none"><a href="javascript:goMenu('10');" >영업진행현황</a></li>
							<li id="M32000" style="display:none"><a href="javascript:goMenu('11');">견적서발행</a></li>
							<li id="M32100" style="display:none"><a href="javascript:goMenu('19');">견적서발행(전체)</a></li>
							<li id="M33000" style="display:none"><a href="javascript:goMenu('12');">계약코드미발행현황</a></li>
							<li id="M34000" style="display:none"><a href="javascript:goMenu('13');">계약등록</a></li>
							<li id="M35000" style="display:none"><a href="javascript:goMenu('14');">계약관리</a></li>
							<li id="M36000" style="display:none"><a href="javascript:goMenu('15');">계산서미발행현황</a></li>
							<li id="M37000" style="display:none"><a href="javascript:goMenu('16');">(구)세금계산서발행</a></li>
							<li id="M38000" style="display:none"><a href="javascript:goMenu('17');">(신)세금계산서발행</a></li>
							<li id="M39000" style="display:none"><a href="javascript:goMenu('18');">미수채권현황</a></li>
						</ul>
					</div>
				</li>
				<!-- //영업지원 -->
				
				<!-- 프로젝트 지원 -->
				<li id="TM40000" style="display:none" class="lnb_03"><a href="javascript:;" onclick="goMenu('20')">프로젝트지원</a>
					<div class="snb display_none">
						<ul>
							<li id="M41000" style="display:none"><a href="javascript:goMenu('20');" >프로젝트조회</a></li>
							<li id="M42000" style="display:none"><a href="javascript:goMenu('21');">프로젝트코드(등록/수정)</a></li>
							<li id="M43000" style="display:none"><a href="javascript:goMenu('22');">프로젝트진행관리</a></li>
							<li id="M44000" style="display:none"><a href="javascript:goMenu('23');">정기점검</a></li>
							<li id="M44500" style="display:none"><a href="javascript:goMenu('27');">정기점검(종합)</a></li>
							<li id="M45000" style="display:none"><a href="javascript:goMenu('24');">비정기점검</a></li>
							<li id="M45500" style="display:none"><a href="javascript:goMenu('28');">비정기점검(종합)</a></li>
							<li id="M46000" style="display:none"><a href="javascript:goMenu('25');">정기점검(한솔팩스)</a></li>
							<li id="M47000" style="display:none"><a href="javascript:goMenu('26');">비정기점검(한솔팩스)</a></li>
						</ul>
					</div>
				</li>
				<!-- //프로젝트 지원 -->
				
				<!-- 게시판 -->
				<li id="TM60000" style="display:none" class="lnb_04"><a href="javascript:;" onClick="goMenu('30')">게시판</a>
					<div class="snb display_none">
						<ul>
							<li id="M61000" style="display:none"><a href="javascript:goMenu('30');">전사공지</a></li>
							<li id="M62000" style="display:none"><a href="javascript:goMenu('31');">서식파일</a></li>
							<li id="M63000" style="display:none"><a href="javascript:goMenu('32');">경조사</a></li>
							<li id="M64000" style="display:none"><a href="javascript:goMenu('33');">자유게시판</a></li>
							<li id="M65000" style="display:none"><a href="javascript:goMenu('34');">News &amp; Magazine</a></li>
							<li id="M66000" style="display:none"><a href="javascript:goMenu('35');">업무Manual</a></li>
							<li id="M67000"><a href="javascript:goMenu('36');">추가게시판</a></li>
			<!-- ================================================================================================================== -->
							<li id="M68000"><a href="javascript:goMenu('37');">휴폐업</a></li>
							<!-- display=none인데 어떻게 나온거지 -->
							<!-- <li id="M66000" style="display:none"><a href="javascript:goMenu('37');">휴폐업</a></li> -->
			<!-- ================================================================================================================== -->
						</ul>
					</div>	
				</li>
				<!-- 게시판 -->
				
				<!-- HUEHome 관리 -->
				<li id="TM50000" style="display:none" class="lnb_05"><a href="javascript:;" onClick="goMenu('40')">HUEHome관리</a>
					<div class="snb display_none">
						<ul>
							<li id="M51000" style="display:none"><a href="javascript:goMenu('40');" >공지사항</a></li>
							<li id="M52000" style="display:none"><a href="javascript:goMenu('41');">Lastest News</a></li>
							<li id="M53000" style="display:none"><a href="javascript:goMenu('42');">채용공고</a></li>
							<li id="M54000" style="display:none"><a href="javascript:goMenu('43');">채용관리</a></li>
							<li id="M55000" style="display:none"><a href="javascript:goMenu('44');">자주묻는질문</a></li>
							<li id="M56000" style="display:none"><a href="javascript:goMenu('45');">1:1질문</a></li>
						</ul>
					</div>
				</li>
				<!-- //HUEHome 관리 -->
				
				<!-- HUEBook -->
				<li id="TM70000" style="display:none" class="lnb_06"><a href="javascript:;" onClick="goMenu('50')">HUEBook</a>
					<div class="snb display_none">
						<ul>
							<li id="M71000" style="display:none"><a href="javascript:goMenu('50');" >도서신청</a></li>
							<li id="M72000" style="display:none"><a href="javascript:goMenu('51');">도서결재</a></li>
							<li id="M73000" style="display:none"><a href="javascript:goMenu('52');">휴북목록</a></li>
						</ul>
					</div>
				</li>
				<!-- //HUEBook -->
				
				<!-- 휴가관리 -->
				<li id="TM80000" style="display:none" class="lnb_08"><a href="javascript:;" onClick="goMenu('80')">휴가관리</a>
					<div class="snb display_none">
						<ul>
							<li id="M81000" style="display:none"><a href="javascript:goMenu('80');" >휴가신청</a></li>
							<li id="M82000" style="display:none"><a href="javascript:goMenu('81');">휴가결재</a></li>
							<li id="M83000" style="display:none"><a href="javascript:goMenu('82');">휴가이력</a></li>
							<li id="M84000" style="display:none"><a href="javascript:goMenu('83');">휴가조회</a></li>
						</ul>
					</div>
				</li>
				<!-- //휴가관리 -->
								
				<!-- 관리 -->
				<li id="TM10000" style="display:none" class="lnb_07"><a href="javascript:;" onClick="goMenu('60')">관리</a>
					<div class="snb display_none">
						<ul>
							<li id="M11000" style="display:none"><a href="javascript:goMenu('60');" >계정관리</a></li>
							<li id="M12000" style="display:none"><a href="javascript:goMenu('61');">그룹관리</a></li>
							<li id="M13000" style="display:none"><a href="javascript:goMenu('62');">메뉴권한관리</a></li>
							<li id="M14000" style="display:none"><a href="javascript:goMenu('63');">코드북관리</a></li>
							
							<!-- <li id="M15000" ><a href="javascript:goMenu('64');">휴일관리</a></li> -->
						</ul>
					</div>
				</li>
				<!-- //관리 -->
				
				<li class="sms"><a href="#none" onclick="javascript:goSmsPage('<%= request.getContextPath() %>/S_Sms.do?cmd=smsSend');">SMS전송</a></li>
			</ul>
		</div>
<!-- loading -->
<div id="password_pop" title="비밀번호변경"> </div>
<!-- //loading -->
</body>
<%-- <%= comDao.getMenuAuth(menulist,"HOME") %> --%>
</html>
