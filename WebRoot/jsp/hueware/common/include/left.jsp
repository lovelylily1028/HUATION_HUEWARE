<%@ page contentType="text/html; charset=euc-kr"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>left menu</title>
<script language="JavaScript" type="text/JavaScript">

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
		
		var m_index=menu.substring(0,1);
		var s_index=menu.substring(1,2);

		menuOption(m_index); //메뉴 열고닫기
		selectMenu(m_index,s_index);//선택 서브메뉴 표기
		
		var lm='lnb_menu'+(parseInt(m_index)+1);
		var lm_on='lnb_menu'+(parseInt(m_index)+1)+'_on.gif';
		
		var tm='gnb_menu'+(parseInt(m_index)+2);
		var tm_on='gnb_menu'+(parseInt(m_index)+1)+'_click.gif';

		//MM_nbGroup('down','group1','gnb_menu1','<%= request.getContextPath()%>/images/gnb_menu_home_on.gif',1);
		MM_nbGroup('down','group1',tm,'<%= request.getContextPath()%>/images/'+tm_on,1);
		MM_nbGroup('down','group2',lm,'<%= request.getContextPath()%>/images/'+lm_on,1);		
		
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
		}else if (menu=='12') {//계약관리
			theUrl= '<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgPageList';
		}else if (menu=='13') {//세금계산서발행
			theUrl= '<%= request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList';
		}else if (menu=='14') {//바로빌 세금계산서발행
			theUrl= '<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=baroInvoicePageList';
		}else if (menu=='60') {//계정관리
			theUrl= '<%= request.getContextPath()%>/B_User.do?cmd=userPageList';
		}else if (menu=='61') {//그룹관리
			theUrl= '<%= request.getContextPath()%>/H_Group.do?cmd=groupManage';
		}else if (menu=='62') {//메뉴관리
			theUrl= '<%= request.getContextPath()%>/H_Auth.do?cmd=authManage';
		}else if (menu=='63') {//코드북관리
			theUrl= '<%= request.getContextPath()%>/B_Code.do?cmd=codePageList';
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
		}else if (menu=='50') {//도서신청
			theUrl= '<%= request.getContextPath()%>/B_HueBookManageRe.do?cmd=hueBookRePageList';
		}else if (menu=='51') {//도서결재
			theUrl= '<%= request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookAppPageList';
		}else if (menu=='52') {//휴북목록
			theUrl= '<%= request.getContextPath()%>/B_HueBookList.do?cmd=hueBookPageList';
		}
		
		openWaiting(); //처리중 메세지 활성화

		location.href = theUrl;

	}
	
//-->
</script>
</head>
<!-- 총무지원 -->

<span id="M20000" style="display:none">
<div class="lnb_menu">
  <div class="lnb_teb" id="menu">
    <a href="javascript:;"  onClick="goMenu('00')" onMouseOver="MM_nbGroup('over','lnb_menu1','<%= request.getContextPath()%>/images/lnb_menu1_on.gif','<%= request.getContextPath()%>/images/lnb_menu1_on.gif',1)" onMouseOut="MM_nbGroup('out')"> <img src="<%= request.getContextPath()%>/images/lnb_menu1.gif" alt="총무지원" name="lnb_menu1" width="178" height="35" border="0" id="lnb_menu1" /> </a>
  </div>
  <div class="lnb_sub"  id="menu_s"  style="display:none;">
    <ul>
      <span id="M21000" style="display:none">
      <li  id="subm_0"  style="display:none;"><a href="javascript:goMenu('00');"><font id="M00">업체관리</font></a></li>
      </span> <span id="M22000" style="display:none">
      <li  id="subm_0"  style="display:none;"><a href="javascript:goMenu('01');"><font id="M01">법인통장관리</font></a></li>
      </span>
    </ul>
  </div>
</div>
</span>
<!-- //총무지원 -->
<!-- 영업지원 -->
<span id="M30000" style="display:none">
<div class="lnb_menu" >
  <div class="lnb_teb" id="menu">
    <a href="javascript:;"  onclick="goMenu('10')" onMouseOver="MM_nbGroup('over','lnb_menu2','<%= request.getContextPath()%>/images/lnb_menu2_on.gif','<%= request.getContextPath()%>/images/lnb_menu2_on.gif',1)" onMouseOut="MM_nbGroup('out')"> <img src="<%= request.getContextPath()%>/images/lnb_menu2.gif" alt="영업지원" name="lnb_menu2" width="178" height="35" border="0" id="lnb_menu2" /> </a>
  </div>
  <div class="lnb_sub" id="menu_s" style="display:none;">
    <ul>
      <span id="M31000" style="display:none">
      <li id="subm_1"  style="display:none;"><a href="javascript:goMenu('10');"><font id="M10">영업진행현황</font></a></li>
      </span><span id="M32000" style="display:none">
      <li id="subm_1" style="display:none;"><a href="javascript:goMenu('11');"><font id="M11">견적서 발행</font></a></li>
      </span><span id="M33000" style="display:none">
      <li id="subm_1" style="display:none;"><a href="javascript:goMenu('12');"><font id="M12">계약관리</font></a></li>
      </span><span id="M34000" style="display:none">
      <li id="subm_1" style="display:none;"><a href="javascript:goMenu('13');"><font id="M13">(구)세금계산서 발행</font></a></li>
   	  </span><span id="M35000" style="display:none">
      <li id="subm_1" style="display:none;"><a href="javascript:goMenu('14');"><font id="M14">(신)세금계산서 발행</font></a></li>
      </span>
    </ul>
  </div>
</div>
</span>
<!-- //영업지원 -->
<!-- 프로젝트 지원 -->
<span id="M40000" style="display:none">
<div class="lnb_menu" >
  <div class="lnb_teb" id="menu">
    <a href="javascript:;"  onclick="goMenu('20')" onMouseOver="MM_nbGroup('over','lnb_menu3','<%= request.getContextPath()%>/images/lnb_menu3_on.gif','<%= request.getContextPath()%>/images/lnb_menu3_on.gif',1)" onMouseOut="MM_nbGroup('out')"> <img src="<%= request.getContextPath()%>/images/lnb_menu3.gif" alt="프로젝트 지원" name="lnb_menu3" width="178" height="35" border="0" id="lnb_menu3" /> </a>
  </div>
  <div class="lnb_sub" id="menu_s" style="display:none;">
    <ul>
      <span id="M41000" style="display:none">
      <li id="subm_2"  style="display:none;"><a href="javascript:goMenu('20');"><font id="M20">프로젝트 조회</font></a></li>
      </span> <span id="M42000" style="display:none">
      <li id="subm_2" style="display:none;"><a href="javascript:goMenu('21');"><font id="M21">프로젝트 코드(등록/수정)</font></a></li>
      </span> <span id="M43000" style="display:none">
      <li id="subm_2" style="display:none;"><a href="javascript:goMenu('22');"><font id="M22">프로젝트 진행관리</font></a></li>
      </span> <span id="M44000" style="display:none">
      <li id="subm_2"  style="display:none;"><a href="javascript:goMenu('23');"><font id="M23">정기점검</font></a></li>
      </span> <span id="M45000" style="display:none">
      <li id="subm_2" style="display:none;"><a href="javascript:goMenu('24');"><font id="M24">비정기점검</font></a></li>
      </span> <span id="M46000" style="display:none">
      <li id="subm_2" style="display:none;"><a href="javascript:goMenu('25');"><font id="M25">정기점검(한솔팩스)</font></a></li>
      </span> <span id="M47000" style="display:none">
      <li id="subm_2" style="display:none;"><a href="javascript:goMenu('26');"><font id="M26">비정기점검(한솔팩스)</font></a></li>
      </span>
    </ul>
  </div>
</div>
</span>
<!-- //프로젝트 지원 -->
<!-- 게시판 -->
<span id="M60000" style="display:none">
<div class="lnb_menu">
  <div class="lnb_teb" id="menu">
    <a href="javascript:;" onClick="goMenu('30')" onMouseOver="MM_nbGroup('over','lnb_menu4','<%= request.getContextPath()%>/images/lnb_menu4_on.gif','<%= request.getContextPath()%>/images/lnb_menu4_on.gif',1)" onMouseOut="MM_nbGroup('out')"> <img src="<%= request.getContextPath()%>/images/lnb_menu4.gif" alt="게시판" name="lnb_menu4" width="178" height="35" border="0" id="lnb_menu4" /> </a>
  </div>
  <div class="lnb_sub"  id="menu_s"  style="display:none;"> 
    <ul>
      <span id="M61000" style="display:none">
      <li id="subm_3"  ><a href="javascript:goMenu('30');"><font id="M30">전사공지</font></a></li>
      </span> <span id="M62000" style="display:none">
      <li id="subm_3"  ><a href="javascript:goMenu('31');"><font id="M31">서식파일</font></a></li>
      </span> <span id="M63000" style="display:none">
      <li id="subm_3" ><a href="javascript:goMenu('32');"><font id="M32">경조사</font></a></li>
      </span> <span id="M64000" style="display:none">
      <li id="subm_3" ><a href="javascript:goMenu('33');"><font id="M33">자유게시판</font></a></li>
      </span> <span id="M65000" style="display:none">
      <li id="subm_3" ><a href="javascript:goMenu('34');"><font id="M34">News & Magazine</font></a></li>
      </span> <span id="M66000" style="display:none">
      <li id="subm_3" ><a href="javascript:goMenu('35');"><font id="M35">업무Manual</font></a></li>
      </span> 
    </ul>
  </div>
</div>
</span>
<!-- 게시판 -->
<!-- HUEHome 관리 -->
<span id="M50000" style="display:none">
<div class="lnb_menu">
  <div class="lnb_teb" id="menu">
    <a href="javascript:;" onClick="goMenu('40')" onMouseOver="MM_nbGroup('over','lnb_menu5','<%= request.getContextPath()%>/images/lnb_menu5_on.gif','<%= request.getContextPath()%>/images/lnb_menu5_on.gif',1)" onMouseOut="MM_nbGroup('out')"> <img src="<%= request.getContextPath()%>/images/lnb_menu5.gif" alt="HUEHome 관리" name="lnb_menu5" width="178" height="35" border="0" id="lnb_menu5" /> </a>
  </div>
  <div class="lnb_sub"  id="menu_s"  style="display:none;">
    <ul >
      <span id="M51000" style="display:none;">
      <li id="subm_4" style="display:none;" ><a href="javascript:goMenu('40');"><font id="M40">공지사항</font></a></li>
      </span> <span id="M52000" style="display:none">
      <li id="subm_4" style="display:none;" ><a href="javascript:goMenu('41');"><font id="M41">Lastest News</font></a></li>
      </span> <span id="M53000" style="display:none">
      <li id="subm_4" style="display:none;" ><a href="javascript:goMenu('42');"><font id="M42">채용공고</font></a></li>
      </span> <span id="M54000" style="display:none">
      <li id="subm_4" style="display:none;" ><a href="javascript:goMenu('43');"><font id="M43">채용관리</font></a></li>
      </span> <span id="M55000" style="display:none">
      <li id="subm_4" style="display:none;" ><a href="javascript:goMenu('44');"><font id="M44">자주하는질문</font></a></li>
      </span> <span id="M56000" style="display:none">
      <li id="subm_4" style="display:none;" ><a href="javascript:goMenu('45');"><font id="M45">1:1질문</font></a></li>
      </span>
    </ul>
  </div>
</div>
</span>
<!-- //HUEHome 관리 -->
<!-- HUEBook -->
<span id="M70000" style="display:none">
<div class="lnb_menu">
  <div class="lnb_teb" id="menu">
    <a href="javascript:;" onClick="goMenu('50')" onMouseOver="MM_nbGroup('over','lnb_menu6','<%= request.getContextPath()%>/images/lnb_menu6_on.gif','<%= request.getContextPath()%>/images/lnb_menu6_on.gif',1)" onMouseOut="MM_nbGroup('out')"> <img src="<%= request.getContextPath()%>/images/lnb_menu6.gif" alt="관리" name="lnb_menu6" width="178" height="35" border="0" id="lnb_menu6" /> </a>
  </div>
  <div class="lnb_sub"  id="menu_s"  style="display:none;">
    <ul >
      <span id="M71000" style="display:none;">
      <li id="subm_5" style="display:none;" ><a href="javascript:goMenu('50');"><font id="M50">도서신청</font></a></li>
      </span> <span id="M72000" style="display:none">
      <li id="subm_5" style="display:none;" ><a href="javascript:goMenu('51');"><font id="M51">도서결재</font></a></li>
      </span> <span id="M73000" style="display:none">
      <li id="subm_5" style="display:none;" ><a href="javascript:goMenu('52');"><font id="M52">휴북목록</font></a></li>
      </span>
    </ul>
  </div>
</div>
</span>
<!-- //HUEBook -->
<!-- 관리 -->
<span id="M10000" style="display:none">
<div class="lnb_menu">
  <div class="lnb_teb" id="menu">
    <a href="javascript:;" onClick="goMenu('60')" onMouseOver="MM_nbGroup('over','lnb_menu7','<%= request.getContextPath()%>/images/lnb_menu7_on.gif','<%= request.getContextPath()%>/images/lnb_menu7_on.gif',1)" onMouseOut="MM_nbGroup('out')"> <img src="<%= request.getContextPath()%>/images/lnb_menu7.gif" alt="관리" name="lnb_menu7" width="178" height="35" border="0" id="lnb_menu7" /> </a>
  </div>
  <div class="lnb_sub"  id="menu_s"  style="display:none;">
    <ul >
      <span id="M11000" style="display:none;">
      <li id="subm_6" style="display:none;" ><a href="javascript:goMenu('60');"><font id="M60">계정관리</font></a></li>
      </span> <span id="M12000" style="display:none">
      <li id="subm_6" style="display:none;" ><a href="javascript:goMenu('61');"><font id="M61">그룹관리</font></a></li>
      </span> <span id="M13000" style="display:none">
      <li id="subm_6" style="display:none;" ><a href="javascript:goMenu('62');"><font id="M62">메뉴권한관리</font></a></li>
      </span> <span id="M14000" style="display:none">
      <li id="subm_6" style="display:none;" ><a href="javascript:goMenu('63');"><font id="M63">코드북관리</font></a></li>
      </span>
    </ul>
  </div>
</div>
</span>
<!-- //관리 -->
</html>
