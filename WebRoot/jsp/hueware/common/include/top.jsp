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
	    //li�� ���콺 ���� �Ǿ��� ��
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
	//�α׾ƿ�
	function logout() {
		location.href = "<%= request.getContextPath()%>/B_Login.do?cmd=loginOff";
	}
	
	//�޿��� �̹��� Ŭ���ϸ� ����ȭ������ �̵���
	function reflesh(){
        location.href = "<%= request.getContextPath()%>/B_Common.do?cmd=mainPage";

	}
	
	//��й�ȣ ����
<%-- 	function passwdEdit() {

		var userid=document.topfrm.userid.value;
		var passwd=document.topfrm.passwd.value;
		var pop = window.open("<%= request.getContextPath()%>/B_User.do?cmd=passwdEdit&user_id="+userid+"&passwd="+passwd+"&page=E","passwdEdit","width=300,height=250,left=20,top=20,toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=no, status=no");

	} --%>

	
	var Menu ="";	
	
	//��й�ȣ ���� ���̾ƿ� �˾�
	function passwdEdit() {
		var login_UserID = '<%=userid%>';
		var login_PassWord = '<%=passwd%>';
		$('#password_pop').dialog({
			resizable : false, //������ ���� �Ұ���
			draggable : false, //�巡�� �Ұ���
			closeOnEscape : true, //ESC ��ư �������� ����
			
			height : 249,
			width : 320,
			modal : true,
			position : [1295,50],
			open:function(){
				
				//�˾� ������ url
				$(this).load('<%= request.getContextPath() %>/B_User.do?cmd=passwdEdit',
						{"user_id" : login_UserID , "passwd" : login_PassWord}); 
				//���̾ƿ� �ٱ��� Ŭ�� �� �˾� �������� ����
				/*
				$('.ui-widget-overlay').bind('click',function(){
	                $('#JobRegistPop').dialog('close');
	            });
				*/
				
			}
		});
		
	}
	
	//���ø޴� ����ݱ�
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
	
	//���ø޴� ǥ��
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
	
	//�޴�����	
	function menuSetting(menu){
		
		$(".snb").addClass("display_none");
	 	switch (menu){
			
			case "00" :		//�ѹ����� - ��ü���� �޴�Ȱ��ȭ
				$("#M21000 a").addClass("on");
				$(".lnb_01 a").eq(0).addClass("on");
				$(".lnb_01 div").removeClass("display_none");
				break;
			
			case "01" :		//�ѹ����� - ����������� �޴�Ȱ��ȭ
				$("#M22000 a").addClass("on");
				$(".lnb_01 a").eq(0).addClass("on");
				$(".lnb_01 div").removeClass("display_none");
				break;
			
			case "10" :		//�������� -  ����������Ȳ
				$("#M31000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
			
			case "11" :		//�������� - ���������� �޴�Ȱ��ȭ
				$("#M32000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
			case "19" :		//�������� - ����������(��ü) �޴�Ȱ��ȭ
				$("#M32100 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
				
			case "12" :		//�������� - ����ڵ� �̹��� ��Ȳ
				$("#M33000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
			
			case "13" :		//�������� - �����
				$("#M34000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
				
			case "14" :		//�������� - ������ �޴�Ȱ��ȭ
				$("#M35000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
			
			case "15" :		//�������� - ��꼭 �̹��� ��Ȳ
				$("#M36000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
				
			case "16" :		//�������� - (��)���ݰ�꼭���� �޴�Ȱ��ȭ
				$("#M37000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
				
 			case "17" :		//�������� - (��)���ݰ�꼭���� �޴�Ȱ��ȭ
 				$("#M38000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
				
 			case "18" :	//�������� - �̼�ä����Ȳ	
 				$("#M39000 a").addClass("on");
				$(".lnb_02 a").eq(0).addClass("on");
				$(".lnb_02 div").removeClass("display_none");
				break;
				
			case "20" :		//������Ʈ���� - ������Ʈ��ȸ �޴�Ȱ��ȭ
				$("#M41000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
			
			case "21" :		//������Ʈ���� - ������Ʈ�ڵ�(���/����) �޴�Ȱ��ȭ
				$("#M42000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
			
			case "22" :		//������Ʈ���� - ������Ʈ������� �޴�Ȱ��ȭ
				$("#M43000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
				
			case "23" :		//������Ʈ���� - �������� �޴�Ȱ��ȭ
				$("#M44000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
			case "24" :		//������Ʈ���� - ���������� �޴�Ȱ��ȭ
				$("#M45000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
			
			case "25" :		//������Ʈ���� - ��������(�Ѽ��ѽ�) �޴�Ȱ��ȭ
				$("#M46000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
			
			case "26" :		//������Ʈ���� - ����������(�Ѽ��ѽ�) �޴�Ȱ��ȭ
				$("#M47000 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
				
			case "27" :		//������Ʈ���� - ��������(����) �޴�Ȱ��ȭ
				$("#M44500 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
				
			case "28" :		//������Ʈ���� - ����������(����) �޴�Ȱ��ȭ
				$("#M45500 a").addClass("on");
				$(".lnb_03 a").eq(0).addClass("on");
				$(".lnb_03 div").removeClass("display_none");
				break;
				
			case "30" :		//�Խ��� - ������� �޴�Ȱ��ȭ
				$("#M61000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
			
			case "31" :		//�Խ��� - �������� �޴�Ȱ��ȭ
				$("#M62000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
			
			case "32" :		//�Խ��� - ������ �޴�Ȱ��ȭ
				$("#M63000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
				
			case "33" :		//�Խ��� - �����Խ��� �޴�Ȱ��ȭ
				$("#M64000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
			
			case "34" :		//�Խ��� - NewsMagazine �޴�Ȱ��ȭ
				$("#M65000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
			
			case "35" :		//�Խ��� - ����Manual �޴�Ȱ��ȭ
				$("#M66000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
				
			case "36" :		//�߰��Խ���
				$("#M67000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
//=======================================================================================			
			case "37" :		//����� ----------------------------- ���� ������
				$("#M68000 a").addClass("on");
				$(".lnb_04 a").eq(0).addClass("on");
				$(".lnb_04 div").removeClass("display_none");
				break;
//=======================================================================================			
			case "40" :		//HUEHome���� - �������� �޴�Ȱ��ȭ
				$("#M51000 a").addClass("on");
				$(".lnb_05 a").eq(0).addClass("on");
				$(".lnb_05 div").removeClass("display_none");
				break;
			
			case "41" :		//HUEHome���� - Lastest News �޴�Ȱ��ȭ
				$("#M52000 a").addClass("on");
				$(".lnb_05 a").eq(0).addClass("on");
				$(".lnb_05 div").removeClass("display_none");
				break;
			
			case "42" :		//HUEHome���� - ä����� �޴�Ȱ��ȭ
				$("#M53000 a").addClass("on");
				$(".lnb_05 a").eq(0).addClass("on");
				$(".lnb_05 div").removeClass("display_none");
				break;			
				
			case "43" :		//HUEHome���� - ä����� �޴�Ȱ��ȭ
				$("#M54000 a").addClass("on");
				$(".lnb_05 a").eq(0).addClass("on");
				$(".lnb_05 div").removeClass("display_none");
				break;
				
			case "44" :		//HUEHome���� - �����ϴ����� �޴�Ȱ��ȭ
				$("#M55000 a").addClass("on");
				$(".lnb_05 a").eq(0).addClass("on");
				$(".lnb_05 div").removeClass("display_none");
				break;
				
			case "45" :		//HUEHome���� - 1:1���� �޴�Ȱ��ȭ
				$("#M56000 a").addClass("on");
				$(".lnb_05 a").eq(0).addClass("on");
				$(".lnb_05 div").removeClass("display_none");
				break;
				
			
			case "50" :		//HUEBook - ������û �޴�Ȱ��ȭ
				$("#M71000 a").addClass("on");
				$(".lnb_06 a").eq(0).addClass("on");
				$(".lnb_06 div").removeClass("display_none");
				break;
				
			case "51" :		//HUEBook - �������� �޴�Ȱ��ȭ
				$("#M72000 a").addClass("on");
				$(".lnb_06 a").eq(0).addClass("on");
				$(".lnb_06 div").removeClass("display_none");
				break;
				
			case "52" :		//HUEBook - �޺ϸ�� �޴�Ȱ��ȭ
				$("#M73000 a").addClass("on");
				$(".lnb_06 a").eq(0).addClass("on");
				$(".lnb_06 div").removeClass("display_none");
				break;
				
			
			case "60" :		//���� - �������� �޴�Ȱ��ȭ
				$("#M11000 a").addClass("on");
				$(".lnb_07 a").eq(0).addClass("on");
				$(".lnb_07 div").removeClass("display_none");
				break;
				
			case "61" :		//���� - �׷���� �޴�Ȱ��ȭ
				$("#M12000 a").addClass("on");
				$(".lnb_07 a").eq(0).addClass("on");
				$(".lnb_07 div").removeClass("display_none");
				break;
				
			case "62" :		//���� - �޴����Ѱ��� �޴�Ȱ��ȭ
				$("#M13000 a").addClass("on");
				$(".lnb_07 a").eq(0).addClass("on");
				$(".lnb_07 div").removeClass("display_none");
				break;
				
			case "63" :		//���� - �ڵ�ϰ��� �޴�Ȱ��ȭ
				$("#M14000 a").addClass("on");
				$(".lnb_07 a").eq(0).addClass("on");
				$(".lnb_07 div").removeClass("display_none");
				break;
			
			case "64" :		//���� - �ڵ�ϰ��� �޴�Ȱ��ȭ
				$("#M15000 a").addClass("on");
				$(".lnb_07 a").eq(0).addClass("on");
				$(".lnb_07 div").removeClass("display_none");
				break;
	
				
			case "80" :		//�ް�����
				$("#M81000 a").addClass("on");
				$(".lnb_08 a").eq(0).addClass("on");
				$(".lnb_08 div").removeClass("display_none");
				break;
			case "81" :		//�ް�����
				$("#M82000 a").addClass("on");
				$(".lnb_08 a").eq(0).addClass("on");
				$(".lnb_08 div").removeClass("display_none");
				break;
			case "82" :		//�ް��̷�
				$("#M83000 a").addClass("on");
				$(".lnb_08 a").eq(0).addClass("on");
				$(".lnb_08 div").removeClass("display_none");
				break;
			case "83" :		//���� - �ް�
				$("#M84000 a").addClass("on");
				$(".lnb_08 a").eq(0).addClass("on");
				$(".lnb_08 div").removeClass("display_none");
				break;	
		
		} 

	}

	
	
	//�޴���ũ
	function goMenu(menu){
		
		
		var theUrl = '';
		
		if (menu=='HOME') {//HOME
			theUrl= '<%= request.getContextPath()%>/B_Common.do?cmd=mainPage';
		}else if (menu=='00') {//��ü����
			theUrl= '<%= request.getContextPath()%>/B_Company.do?cmd=companyPageList';
		}else if (menu=='01') {//�����������
			theUrl= '<%= request.getContextPath()%>/B_BankManage.do?cmd=bankPageList';
		}else if (menu=='10') {//����������Ȳ
			theUrl= '<%= request.getContextPath()%>/B_CurrentStatus.do?cmd=currentStaPageList';
		}else if (menu=='11') {//����������
			theUrl= '<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList';
		}else if (menu=='19') {//����������(��ü) (2018-12-04 �߰�, 20190207 �޴�����)
			theUrl= '<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList&type=search';
		}else if (menu=='12') {//����ڵ� �̹��� ��Ȳ
			theUrl= '<%= request.getContextPath()%>/B_Estimate.do?cmd=contractCodeUnissued';
		}else if (menu=='13') {//�����
			theUrl= '<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgRegistList';
		}else if (menu=='14') {//������
			theUrl= '<%= request.getContextPath()%>/B_ContractManage.do?cmd=contractMgPageList';
		}else if (menu=='15') {//��꼭�̹�����Ȳ
			theUrl= '<%= request.getContextPath()%>/B_Invoice.do?cmd=invoiceUnissuedList';
		}else if (menu=='16') {//���ݰ�꼭����
			theUrl= '<%= request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList';
		}else if (menu=='17') {//�ٷκ� ���ݰ�꼭����
			theUrl= '<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=baroInvoicePageList';
		}else if (menu=='18') {//�̼�ä����Ȳ
			theUrl= '<%= request.getContextPath()%>/B_BaroInvoice.do?cmd=outstandingBondList';
		}else if (menu=='60') {//��������
			theUrl= '<%= request.getContextPath()%>/B_User.do?cmd=userPageList';
		}else if (menu=='61') {//�׷����
			theUrl= '<%= request.getContextPath()%>/H_Group.do?cmd=groupManage';
		}else if (menu=='62') {//�޴�����
			theUrl= '<%= request.getContextPath()%>/H_Auth.do?cmd=authManage';
		}else if (menu=='63') {//�ڵ�ϰ���
			theUrl= '<%= request.getContextPath()%>/B_Code.do?cmd=codePageList';
		}else if (menu=='64') {//���ϰ���
			theUrl= '<%= request.getContextPath()%>/H_Holly.do?cmd=HollyDayMgPageList';
		}else if (menu=='20') {//������Ʈ �ڵ���� ��ȸ
			theUrl= '<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Search';
		}else if (menu=='21') {//������Ʈ �ڵ���� ���/����
			theUrl= '<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Edit';
		}else if (menu=='22') {//������Ʈ �ڵ���� �������
			theUrl= '<%= request.getContextPath()%>/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Progress';
		}else if (menu=='23') {//��������
			theUrl= '<%= request.getContextPath()%>/B_Project.do?cmd=projectPageList';
		}else if (menu=='24') {//����������
			theUrl= '<%= request.getContextPath()%>/N_Project.do?cmd=projectPageList_Non';
		}else if (menu=='25') {//��������(�Ѽ�)
			theUrl= '<%= request.getContextPath()%>/B_Project_H.do?cmd=projectPageList_H';
		}else if (menu=='26') {//����������(�Ѽ�)
			theUrl= '<%= request.getContextPath()%>/N_Project_H.do?cmd=projectPageList_Non_H';
		}else if (menu=='27') {//��������(����)
			theUrl= '<%= request.getContextPath()%>/B_Project.do?cmd=projectPageListAll';
		}else if (menu=='28') {//����������(����)
			theUrl= '<%= request.getContextPath()%>/N_Project.do?cmd=projectPageListNonAll';
		}else if (menu=='40') {//��������
			theUrl= '<%= request.getContextPath()%>/B_About.do?cmd=notifyPageList';
		}else if (menu=='41') {//Lastest News
			theUrl= '<%= request.getContextPath()%>/B_About.do?cmd=newsPageList';
		}else if (menu=='42') {//ä�����
			theUrl= '<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitNotifyList';
		}else if (menu=='43') {//ä�����
			theUrl= '<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitManageList';
		}else if (menu=='44') {//�����ϴ�����
			theUrl= '<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitQnAList&qna_gb=01';
		}else if (menu=='45') {//1:1����
			theUrl= '<%= request.getContextPath()%>/B_Recruit.do?cmd=recruitQnAList&qna_gb=02';
		}else if (menu=='30') {//�������
			theUrl= '<%= request.getContextPath()%>/B_DispNotify.do?cmd=dispNotifyPageList';
		}else if (menu=='31') {//��������
			theUrl= '<%= request.getContextPath()%>/B_FormFile.do?cmd=formFilePageList';
		}else if (menu=='32') {//������
			theUrl= '<%= request.getContextPath()%>/B_FamilyEvent.do?cmd=familyEventPageList';
		}else if (menu=='33') {//�����Խ���
			theUrl= '<%= request.getContextPath()%>/B_FreeBoard.do?cmd=freeBoardPageList';
		}else if (menu=='34') {//News & Magazine
			theUrl= '<%= request.getContextPath()%>/B_NewsMagazine.do?cmd=newsMagazinePageList';
		}else if (menu=='35') {//����Menual
			theUrl= '<%= request.getContextPath()%>/B_DocumentFile.do?cmd=documentFilePageList';
		}else if (menu=='36'){//�߰��Խ���(2021.08.02)
			theUrl= '<%= request.getContextPath()%>/B_AddBoard.do?cmd=addBoardList';
//==================================================================================================================			
		}else if (menu=='37'){//�����(2021.12.07)
			theUrl= '<%= request.getContextPath()%>/B_ClosureMg.do?cmd=closureMgList';
//==================================================================================================================			
		}else if (menu=='50') {//������û
			theUrl= '<%= request.getContextPath()%>/B_HueBookManageRe.do?cmd=hueBookRePageList';
		}else if (menu=='51') {//��������
			theUrl= '<%= request.getContextPath()%>/B_HueBookManageApp.do?cmd=hueBookAppPageList';
		}else if (menu=='52') {//�޺ϸ��
			theUrl= '<%= request.getContextPath()%>/B_HueBookList.do?cmd=hueBookPageList';
		}else if (menu=='80') {//�ް�����
			theUrl= '<%= request.getContextPath()%>/H_Holly.do?cmd=leaveApplyPageList';
		}else if (menu=='80') {//�ް���û
			theUrl= '<%= request.getContextPath()%>/H_Holly.do?cmd=leaveApplyPageList';
		}else if (menu=='81') {//�ް�����
			theUrl= '<%= request.getContextPath()%>/H_Holly.do?cmd=leaveAppPageList';
		}else if (menu=='82') {//�ް��̷�
			theUrl= '<%= request.getContextPath()%>/H_Holly.do?cmd=leavePageList';
		}else if (menu=='83') {//�ް�����
			theUrl= '<%= request.getContextPath()%>/H_Holly.do?cmd=adminLeaveApplyPageList';
		}
		
		openWaiting(); //ó���� �޼��� Ȱ��ȭ
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

		menuOption(m_index); //�޴� ����ݱ�
		selectMenu(m_index,s_index);//���� ����޴� ǥ��

		if(m_index=='0'){  // �ѹ�����
			if (menu=='00') {
				theUrl= '<%= request.getContextPath()%>/B_Company.do?cmd=companyPageList';
			}
		}else if (m_index=='1'){  //��������
			if (menu=='10') {
				theUrl= '<%= request.getContextPath()%>/B_Estimate.do?cmd=estimatePageList';
			}else if (menu=='11') {
				theUrl= '<%= request.getContextPath()%>/B_Invoice.do?cmd=invoicePageList';
			}  
		}else if (m_index=='2'){  //��Ÿ����
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
	
	
	
	//2013-03-13 �����޷¿��� jQuery �޷����� ����
	$(document).ready(function(){
		$('#calendarData1, #calendarData2, #calendarData3').datepicker({
			buttonImage: "<%= request.getContextPath()%>/images/common/ico_calendar.gif",
			//maxDate:0,
			showOn: 'both',
			buttonImageOnly: true,
			prevText: "����",
			nextText: "����",
			dateFormat: "yy-mm-dd",
			dayNamesMin:["��","��","ȭ","��","��","��","��"],
			monthNames:["1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��"],
			monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
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
					<li><span class="user_name"><%= name %></span> ��(��� : <%= userDto.getEmployeeNum() %>)</li>
					<li class="pic"><iframe src="<%= request.getContextPath()%>/B_Recruit.do?cmd=photo&photo=<%= StringUtil.nvl(userDto.getPhoto(),"")%>&Flag=M"  frameborder="0" height="88" width="72" name="photoFrame" marginwidth="0" marginheight="0" hspace="0" vspace="0" scrolling="no" frameborder="0" align="left"></iframe></li>
					<li class="pwmodify"><a href="javascript:passwdEdit();">��й�ȣ����</a></li>
					<li class="last"><a href="javascript:logout();">�α׾ƿ�</a></li>
				</ul>
			</div>
			</form>
		
			<h2 class="hidden_obj">�ָ޴�</h2>
			<ul class="lnb">
			
				<!-- �ѹ����� -->
				<li id="TM20000" style="display:none;" class="lnb_01"><a href="javascript:;" onclick="goMenu('00')" >�ѹ�����</a><!-- �޴� Ȱ��ȭ : class="on" �߰� -->
					<div class="snb">
						<ul>
							<li id="M21000" style="display:none"><a href="javascript:goMenu('00');" >��ü����</a></li><!-- �޴� Ȱ��ȭ : class="on" �߰� -->
							<li id="M22000" style="display:none"><a href="javascript:goMenu('01');">�����������</a></li>
						</ul>
					</div>
				</li>
				<!-- //�ѹ����� -->
				
				<!-- �������� -->
				<li id="TM30000" style="display:none" class="lnb_02"><a href="javascript:;" onclick="goMenu('10')" >��������</a>
					<div class="snb display_none">
						<ul>
							<li id="M31000" style="display:none"><a href="javascript:goMenu('10');" >����������Ȳ</a></li>
							<li id="M32000" style="display:none"><a href="javascript:goMenu('11');">����������</a></li>
							<li id="M32100" style="display:none"><a href="javascript:goMenu('19');">����������(��ü)</a></li>
							<li id="M33000" style="display:none"><a href="javascript:goMenu('12');">����ڵ�̹�����Ȳ</a></li>
							<li id="M34000" style="display:none"><a href="javascript:goMenu('13');">�����</a></li>
							<li id="M35000" style="display:none"><a href="javascript:goMenu('14');">������</a></li>
							<li id="M36000" style="display:none"><a href="javascript:goMenu('15');">��꼭�̹�����Ȳ</a></li>
							<li id="M37000" style="display:none"><a href="javascript:goMenu('16');">(��)���ݰ�꼭����</a></li>
							<li id="M38000" style="display:none"><a href="javascript:goMenu('17');">(��)���ݰ�꼭����</a></li>
							<li id="M39000" style="display:none"><a href="javascript:goMenu('18');">�̼�ä����Ȳ</a></li>
						</ul>
					</div>
				</li>
				<!-- //�������� -->
				
				<!-- ������Ʈ ���� -->
				<li id="TM40000" style="display:none" class="lnb_03"><a href="javascript:;" onclick="goMenu('20')">������Ʈ����</a>
					<div class="snb display_none">
						<ul>
							<li id="M41000" style="display:none"><a href="javascript:goMenu('20');" >������Ʈ��ȸ</a></li>
							<li id="M42000" style="display:none"><a href="javascript:goMenu('21');">������Ʈ�ڵ�(���/����)</a></li>
							<li id="M43000" style="display:none"><a href="javascript:goMenu('22');">������Ʈ�������</a></li>
							<li id="M44000" style="display:none"><a href="javascript:goMenu('23');">��������</a></li>
							<li id="M44500" style="display:none"><a href="javascript:goMenu('27');">��������(����)</a></li>
							<li id="M45000" style="display:none"><a href="javascript:goMenu('24');">����������</a></li>
							<li id="M45500" style="display:none"><a href="javascript:goMenu('28');">����������(����)</a></li>
							<li id="M46000" style="display:none"><a href="javascript:goMenu('25');">��������(�Ѽ��ѽ�)</a></li>
							<li id="M47000" style="display:none"><a href="javascript:goMenu('26');">����������(�Ѽ��ѽ�)</a></li>
						</ul>
					</div>
				</li>
				<!-- //������Ʈ ���� -->
				
				<!-- �Խ��� -->
				<li id="TM60000" style="display:none" class="lnb_04"><a href="javascript:;" onClick="goMenu('30')">�Խ���</a>
					<div class="snb display_none">
						<ul>
							<li id="M61000" style="display:none"><a href="javascript:goMenu('30');">�������</a></li>
							<li id="M62000" style="display:none"><a href="javascript:goMenu('31');">��������</a></li>
							<li id="M63000" style="display:none"><a href="javascript:goMenu('32');">������</a></li>
							<li id="M64000" style="display:none"><a href="javascript:goMenu('33');">�����Խ���</a></li>
							<li id="M65000" style="display:none"><a href="javascript:goMenu('34');">News &amp; Magazine</a></li>
							<li id="M66000" style="display:none"><a href="javascript:goMenu('35');">����Manual</a></li>
							<li id="M67000"><a href="javascript:goMenu('36');">�߰��Խ���</a></li>
			<!-- ================================================================================================================== -->
							<li id="M68000"><a href="javascript:goMenu('37');">�����</a></li>
							<!-- display=none�ε� ��� ���°��� -->
							<!-- <li id="M66000" style="display:none"><a href="javascript:goMenu('37');">�����</a></li> -->
			<!-- ================================================================================================================== -->
						</ul>
					</div>	
				</li>
				<!-- �Խ��� -->
				
				<!-- HUEHome ���� -->
				<li id="TM50000" style="display:none" class="lnb_05"><a href="javascript:;" onClick="goMenu('40')">HUEHome����</a>
					<div class="snb display_none">
						<ul>
							<li id="M51000" style="display:none"><a href="javascript:goMenu('40');" >��������</a></li>
							<li id="M52000" style="display:none"><a href="javascript:goMenu('41');">Lastest News</a></li>
							<li id="M53000" style="display:none"><a href="javascript:goMenu('42');">ä�����</a></li>
							<li id="M54000" style="display:none"><a href="javascript:goMenu('43');">ä�����</a></li>
							<li id="M55000" style="display:none"><a href="javascript:goMenu('44');">���ֹ�������</a></li>
							<li id="M56000" style="display:none"><a href="javascript:goMenu('45');">1:1����</a></li>
						</ul>
					</div>
				</li>
				<!-- //HUEHome ���� -->
				
				<!-- HUEBook -->
				<li id="TM70000" style="display:none" class="lnb_06"><a href="javascript:;" onClick="goMenu('50')">HUEBook</a>
					<div class="snb display_none">
						<ul>
							<li id="M71000" style="display:none"><a href="javascript:goMenu('50');" >������û</a></li>
							<li id="M72000" style="display:none"><a href="javascript:goMenu('51');">��������</a></li>
							<li id="M73000" style="display:none"><a href="javascript:goMenu('52');">�޺ϸ��</a></li>
						</ul>
					</div>
				</li>
				<!-- //HUEBook -->
				
				<!-- �ް����� -->
				<li id="TM80000" style="display:none" class="lnb_08"><a href="javascript:;" onClick="goMenu('80')">�ް�����</a>
					<div class="snb display_none">
						<ul>
							<li id="M81000" style="display:none"><a href="javascript:goMenu('80');" >�ް���û</a></li>
							<li id="M82000" style="display:none"><a href="javascript:goMenu('81');">�ް�����</a></li>
							<li id="M83000" style="display:none"><a href="javascript:goMenu('82');">�ް��̷�</a></li>
							<li id="M84000" style="display:none"><a href="javascript:goMenu('83');">�ް���ȸ</a></li>
						</ul>
					</div>
				</li>
				<!-- //�ް����� -->
								
				<!-- ���� -->
				<li id="TM10000" style="display:none" class="lnb_07"><a href="javascript:;" onClick="goMenu('60')">����</a>
					<div class="snb display_none">
						<ul>
							<li id="M11000" style="display:none"><a href="javascript:goMenu('60');" >��������</a></li>
							<li id="M12000" style="display:none"><a href="javascript:goMenu('61');">�׷����</a></li>
							<li id="M13000" style="display:none"><a href="javascript:goMenu('62');">�޴����Ѱ���</a></li>
							<li id="M14000" style="display:none"><a href="javascript:goMenu('63');">�ڵ�ϰ���</a></li>
							
							<!-- <li id="M15000" ><a href="javascript:goMenu('64');">���ϰ���</a></li> -->
						</ul>
					</div>
				</li>
				<!-- //���� -->
				
				<li class="sms"><a href="#none" onclick="javascript:goSmsPage('<%= request.getContextPath() %>/S_Sms.do?cmd=smsSend');">SMS����</a></li>
			</ul>
		</div>
<!-- loading -->
<div id="password_pop" title="��й�ȣ����"> </div>
<!-- //loading -->
</body>
<%-- <%= comDao.getMenuAuth(menulist,"HOME") %> --%>
</html>
