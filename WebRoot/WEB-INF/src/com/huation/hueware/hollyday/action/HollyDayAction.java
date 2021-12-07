package com.huation.hueware.hollyday.action;

import java.io.*;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.*;

import org.apache.struts.action.*;

import com.baroservice.ws.BaroService_SMSSoapProxy;
import com.baroservice.ws.CERTKEY;
import com.baroservice.ws.XMSMessage;
import com.huation.common.code.CodeDAO;
import com.huation.common.code.CodeDTO;
import com.huation.common.config.AuthDTO;
import com.huation.common.config.SmsGroupDAO;
import com.huation.common.config.SmsGroupDTO;
import com.huation.common.estimate.*;
import com.huation.common.hollyday.*;
import com.huation.common.user.*;
import com.huation.common.util.DateUtil;
import com.huation.framework.data.DataSet;
import com.huation.framework.persist.*;
import com.huation.framework.struts.*;
import com.huation.framework.util.*;
public class HollyDayAction extends StrutsDispatchAction{
	
	
	/**
	 * ���� ����Ʈ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward HollyDayMgPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		  //log action execute time start
				String logid=log.logid();
				long t1 = System.currentTimeMillis();
				log.trace(logid, "HollyDayMgPageList action start");
			
				
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		
		DecimalFormat df = new DecimalFormat("00");	
		Calendar cal = Calendar.getInstance();	
		String StartDate = Integer.toString(cal.get(Calendar.YEAR))+"-"+"01-01";
		String EndDate = Integer.toString(cal.get(Calendar.YEAR))+"-"+"12-31";
		
		String IvStartDate = StringUtil.nvl(request.getParameter("IvStartDate"),StartDate);
		String IvEndDate = StringUtil.nvl(request.getParameter("IvEndDate"),EndDate);
		
		
		HollyDAO hollyDao = new HollyDAO();
		HollyDTO hollyDto = new HollyDTO();
		
		hollyDto.setSearchGb(searchGb);
		hollyDto.setSearchtxt(searchtxt);
		hollyDto.setnRow(10);
		hollyDto.setJobGb("PAGE");
		hollyDto.setnPage(curPageCnt);
		hollyDto.setStartDT(IvStartDate);
		hollyDto.setEndDT(IvEndDate);
		
		ListDTO ld = hollyDao.hollyPageList(hollyDto);

		model.put("listInfo",ld);	
		model.put("IvStartDate", IvStartDate);
		model.put("IvEndDate", IvEndDate);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);
		
		//log action execute time end
				long t2 = System.currentTimeMillis();
				log.trace(logid, "HollyDayMgPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("HollyDayMgPageList");
	}
	
	/**
	 * ���� ������ �����Ѵ�.(�ٰ�)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward HollyDayDeletes(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "HollyDayDeletes action start");

		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.

		int retVal=0;
		String msg="";
		
		String[] seq = request.getParameterValues("seqs");

		HollyDAO hollyDao = new HollyDAO();

		retVal = hollyDao.HollyDayDeletes(logid,seq, USERID);
		
		if(retVal==-1){
			msg="��������!";
		}else if(retVal==0){
			msg="��������!";
		}else{
			msg="�����Ϸ�!";
		}
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "HollyDayDeletes action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Holly.do?cmd=HollyDayMgPageList","");	
		
	}
	/**
	 * ���� ��� �� (���۾���-���� ȣ��)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userRegistForm
	 * @throws Exception
	 */
	public ActionForward HollyDayRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "HollyDayRegistForm action start");
 
	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "HollyDayRegistForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		

	  return actionMapping.findForward("HollyDayRegistForm");
	 }

	  /**
		 * �ް���û
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return userPageList
		 * @throws Exception
		 */
	public ActionForward HollyDayRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		    //log action execute time start
			String logid=log.logid();
			long t1 = System.currentTimeMillis();
			log.trace(logid, "HollyDayRegist action start");
		
			//�α��� ó�� 
			String USERID = UserBroker.getUserId(request);
			int retval =0;
			int retval2 =0;
			String msg	="";
			if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			//�α��� ó�� ��.
			
			String Title = StringUtil.nvl(request.getParameter("Title"),"");
			String startDate = StringUtil.nvl(request.getParameter("startDate2"),"");
			String Description = StringUtil.nvl(request.getParameter("Description"),"");
			
			
			HollyDAO hollyDao = new HollyDAO();
			HollyDTO hollyDto = new HollyDTO();
			
			hollyDto.setLogID(logid);
			hollyDto.setUserID(USERID);
			hollyDto.setTitle(Title);
			hollyDto.setStartDate(startDate);
			hollyDto.setDescription(Description);
			
			retval=hollyDao.mgHollyDayRegist(hollyDto);
			/////////////////////////////////////////////
			
			System.out.println("=============================================="+retval);
			msg = "����� �Ϸ�Ǿ����ϴ�.";
			
			if(retval == -1){
				msg = "����� �Ϸ�Ǿ����ϴ�.";
			}else{
				msg = "��Ͽ� �����Ͽ����ϴ�.";
			}
			
			
			
			//log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "HollyDayRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
			return closePopupReload(model, msg,"","", request.getContextPath()+"/H_Holly.do?cmd=HollyDayMgPageList");
		}
	/**
	 * �ް���û ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
   public ActionForward leaveApplyPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "leaveApplyPageList action start");
	
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		
		Calendar cal = Calendar.getInstance ( );//���� ��¥�� ��������..
		cal.add ( cal.MONTH, -12 ); //1��....
		String StartDate = Integer.toString(cal.get ( cal.YEAR ))+"-"+String.format("%02d", cal.get ( cal.MONTH ) + 1)+"-"+String.format("%02d",cal.get ( cal.DATE ));
		Calendar cals = Calendar.getInstance ( );//���� ��¥�� ��������..
		cals.add ( cals.MONTH, +1 ); //1���� ��....
		String EndDate = Integer.toString(cals.get ( cals.YEAR ))+"-"+String.format("%02d",cals.get ( cals.MONTH ) + 1)+"-"+String.format("%02d",cals.get ( cals.DATE ));
		
		String StartDT =  StringUtil.nvl(request.getParameter("StartDT"), StartDate);
		String EndDT =  StringUtil.nvl(request.getParameter("EndDT"), EndDate);
		
		HollyDAO hollyDao = new HollyDAO();
		HollyDTO hollyDto = new HollyDTO();
		
		hollyDto.setUserID(USERID);
		hollyDto.setSearchGb(searchGb);
		hollyDto.setSearchtxt(searchtxt);
		hollyDto.setnRow(10);
		hollyDto.setnPage(curPageCnt);
		hollyDto.setStartDT(StartDT);
		hollyDto.setEndDT(EndDT);
		hollyDto.setJobGb("PAGE");
		
		ListDTO ld = hollyDao.hollyDayRequestList(hollyDto);
		hollyDto = hollyDao.myHollyDayView(hollyDto);
		

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("hollyDto", hollyDto);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "leaveApplyPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("leaveApplyPageList");
   	}
   /**
    * �ް���û�ڵ� ������ 
    * @param actionMapping
    * @param actionForm
    * @param request
    * @param response
    * @param model
    * @return userPageList
    * @throws Exception
    * 20200602 ����������� ����Ʈ�� ����. 
    */
//   public ActionForward leaveApplyPageAllList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
   public ActionForward adminLeaveApplyPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
	   
	   //log action execute time start
	   String logid=log.logid();
	   long t1 = System.currentTimeMillis();
	   log.trace(logid, "adminLeaveApplyPageList action start");
	   
	   //�α��� ó�� 
	   String USERID = UserBroker.getUserId(request);
	   
	   if(USERID.equals("")){
		   String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		   return goSessionOut(model, rtnUrl,"huation-sessionOut");
	   }
	   //�α��� ó�� ��.
	   
	   String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
	   String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
	   int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
	   
	   Calendar cal = Calendar.getInstance ( );//���� ��¥�� ��������..
	   cal.add ( cal.MONTH, -12 ); //1��....
	   String StartDate = Integer.toString(cal.get ( cal.YEAR ))+"-"+String.format("%02d", cal.get ( cal.MONTH ) + 1)+"-"+String.format("%02d",cal.get ( cal.DATE ));
	   Calendar cals = Calendar.getInstance ( );//���� ��¥�� ��������..
	   cals.add ( cals.MONTH, +1 ); //1���� ��....
	   String EndDate = Integer.toString(cals.get ( cals.YEAR ))+"-"+String.format("%02d",cals.get ( cals.MONTH ) + 1)+"-"+String.format("%02d",cals.get ( cals.DATE ));
	   
	   String StartDT =  StringUtil.nvl(request.getParameter("StartDT"), StartDate);
	   String EndDT =  StringUtil.nvl(request.getParameter("EndDT"), EndDate);
	   //�� �� ��¥�� �� ���� ���� ���� 
	   
	   HollyDAO hollyDao = new HollyDAO();
	   HollyDTO hollyDto = new HollyDTO();
	   
	   hollyDto.setUserID(USERID);
	   hollyDto.setSearchGb(searchGb);
	   hollyDto.setSearchtxt(searchtxt);
	   hollyDto.setnRow(10);
	   hollyDto.setnPage(curPageCnt);
	   hollyDto.setStartDT(StartDT);
	   hollyDto.setEndDT(EndDT);
	   hollyDto.setJobGb("PAGE");
	   
//	   ListDTO ld = hollyDao.hollyDayRequestList(hollyDto);
//	   hollyDto = hollyDao.myHollyDayView(hollyDto);
	   ArrayList<HollyDTO> arraylist= hollyDao.hollyDayRequestAllList(hollyDto);
	   
//	   model.put("listInfo", ld);
	   model.put("arraylist", arraylist);
	   model.put("curPage", String.valueOf(curPageCnt));
	   model.put("searchGb", searchGb);
	   model.put("searchtxt", searchtxt);
//	   model.put("hollyDto", hollyDto);
	   
	   //log action execute time end
	   long t2 = System.currentTimeMillis();
	   log.trace(logid, "leaveApplyPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	   
	   return actionMapping.findForward("adminLeaveApplyPageList");
   }
   /**
    * �ް���û�ڵ� ������ ���˾� 
    * @param actionMapping
    * @param actionForm
    * @param request
    * @param response
    * @param model
    * @return userPageList
    * @throws Exception
    * 20200602 ����������� ����Ʈ�� ����. ���� ����Ʈ Ŭ���� 
    */
//   public ActionForward leaveApplyPageAllList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
   public ActionForward adminLeaveApplyPageListPopup(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
	   
	   //log action execute time start
	   String logid=log.logid();
	   long t1 = System.currentTimeMillis();
	   log.trace(logid, "adminLeaveApplyPageListPopup action start");
	   
	   //�α��� ó�� 
	   String USERID = UserBroker.getUserId(request);
	   
	   if(USERID.equals("")){
		   String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		   return goSessionOut(model, rtnUrl,"huation-sessionOut");
	   }
	   //�α��� ó�� ��.
	   // L_USERID ���� ȭ�鿡�� Ŭ���� �̸��� �����´�..
	   USERID = StringUtil.nvl(request.getParameter("pUserid"), ""); //�α��� üũ�� ������ ȭ�鿡�� �޾ƿ� �α��� ���̵� �����´�.
	   String carrer = StringUtil.nvl(request.getParameter("pCarrer"), ""); //Ŭ���� ����� ���
//	   String pName = StringUtil.nvl(request.getParameter("pName"), ""); //Ŭ���� ����� �̸�.
	   String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");//�ϴ� ȭ�鿡 ����
	   String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");//�ϴ� ȭ�鿡 ����
	   int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
	   
	   Calendar cal = Calendar.getInstance ( );//���� ��¥�� ��������..
	   cal.add ( cal.MONTH, -12 ); //1��....
	   String StartDate = Integer.toString(cal.get ( cal.YEAR ))+"-"+String.format("%02d", cal.get ( cal.MONTH ) + 1)+"-"+String.format("%02d",cal.get ( cal.DATE ));
	   Calendar cals = Calendar.getInstance ( );//���� ��¥�� ��������..
	   cals.add ( cals.MONTH, +1 ); //1���� ��....
	   String EndDate = Integer.toString(cals.get ( cals.YEAR ))+"-"+String.format("%02d",cals.get ( cals.MONTH ) + 1)+"-"+String.format("%02d",cals.get ( cals.DATE ));
	   
	   String StartDT =  StringUtil.nvl(request.getParameter("StartDT"), StartDate);
	   String EndDT =  StringUtil.nvl(request.getParameter("EndDT"), EndDate);
	   
	   //�� �� ��¥�� �� ���� ���� ���� 
	   
	   HollyDAO hollyDao = new HollyDAO();
	   HollyDTO hollyDto = new HollyDTO();
	   
	   hollyDto.setUserID(USERID);
	   hollyDto.setSearchGb(searchGb);
	   hollyDto.setSearchtxt(searchtxt);
//	   hollyDto.setnRow(10);
	   hollyDto.setnRow(100);//�ظ��ϸ� �ѹ��� ������ �Ѵ�
	   hollyDto.setnPage(curPageCnt);
	   hollyDto.setStartDT(StartDT);
	   hollyDto.setEndDT(EndDT);
	   hollyDto.setJobGb("PAGE");
	   
	   ListDTO ld = new ListDTO();
	   ArrayList<HollyDTO> arraylist = new ArrayList<HollyDTO>();
	   //������ ���� ������ �������� STARTDT
	   if(carrer.equals("0") ) { //������ 1�� �̸��϶�
		   arraylist = hollyDao.hollyDayRequestNewbieList(hollyDto);
	   }else { //�Ի簡 1�� �̻��϶�.
		   arraylist = hollyDao.hollyDayRequestElderList(hollyDto);
	   }
//	   model.put("listInfo", ld);
	   model.put("arraylist", arraylist);
	   model.put("curPage", String.valueOf(curPageCnt));
	   model.put("searchGb", searchGb);
	   model.put("searchtxt", searchtxt);
	   model.put("pUserid", USERID); //����ȸ�ø� ���� �ش�ȭ�鿡���� ���̵� �ǵ����ش�.
	   model.put("pCarrer", carrer); //����ȸ�ø� ���� �ش�ȭ�鿡���� ����� �ǵ����ش�.
//	   model.put("pName", pName); //����ȸ�ø� ���� �ش�ȭ�鿡���� �̸��� �ǵ����ش�.(�̸��� �޾ƿ� �״�� ����.) //�ѱ۱����Ƿ� ��
	   
	   //log action execute time end
	   long t2 = System.currentTimeMillis();
	   log.trace(logid, "adminLeaveApplyPageListPopup action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	   
	   return actionMapping.findForward("adminLeaveApplyPageListPopup");
   }
   /**
	 * �ް����� ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
  public ActionForward leaveAppPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "leaveAppPageList action start");
	
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.
		
		String State = "";
		
		HollyDAO hollyDao = new HollyDAO();
		HollyDTO hollyDto = new HollyDTO();
		UserDAO userDao =new UserDAO();
		UserDTO userDto =new UserDTO();
		
		userDto.setLogid(logid);
		userDto.setID(USERID);
		
		userDto = userDao.userView(userDto);
	
		if(userDto.getPosition().equals("A")){
			State="1";
		}else{
			State="2";
		}
		
		System.out.println("State : "+State);
		
		hollyDto.setUserID(USERID);
		hollyDto.setJobGb(State);
		
		ListDTO ld = hollyDao.hollyApproveList(hollyDto);

		model.put("listInfo", ld);
		model.put("State", State);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "leaveAppPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("leaveAppPageList");
  	}
  
  /**
	 * �ް��̷� ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
public ActionForward leavePageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "leavePageList action start");
	
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchGb2 = StringUtil.nvl(request.getParameter("searchGb2"), "");
		String searchGb3 = StringUtil.nvl(request.getParameter("searchGb3"), "");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		
		Calendar cal = Calendar.getInstance ( );//���� ��¥�� ��������..
		cal.add ( cal.MONTH, -12 ); //1��....
		String StartDate = Integer.toString(cal.get ( cal.YEAR ))+"-"+String.format("%02d", cal.get ( cal.MONTH ) + 1)+"-"+String.format("%02d",cal.get ( cal.DATE ));
		Calendar cals = Calendar.getInstance ( );//���� ��¥�� ��������..
		cals.add ( cals.MONTH, +1 ); //1���� ��....
		String EndDate = Integer.toString(cals.get ( cals.YEAR ))+"-"+String.format("%02d",cals.get ( cals.MONTH ) + 1)+"-"+String.format("%02d",cals.get ( cals.DATE ));
		
		String StartDT =  StringUtil.nvl(request.getParameter("StartDT"), StartDate);
		String EndDT =  StringUtil.nvl(request.getParameter("EndDT"), EndDate);
		
		HollyDAO hollyDao = new HollyDAO();
		HollyDTO hollyDto = new HollyDTO();
		
		hollyDto.setUserID(USERID);
		hollyDto.setSearchGb(searchGb);
		hollyDto.setSearchGb2(searchGb2);
		hollyDto.setSearchGb3(searchGb3);
		hollyDto.setSearchtxt(searchtxt);
		hollyDto.setnRow(10);
		hollyDto.setnPage(curPageCnt);
		hollyDto.setStartDT(StartDT);
		hollyDto.setEndDT(EndDT);
		hollyDto.setJobGb("PAGE2");
		
		ListDTO ld = hollyDao.hollyDayRequestList(hollyDto);
		

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchGb2", searchGb2);
		model.put("searchGb3", searchGb3);
		model.put("searchtxt", searchtxt);
		model.put("hollyDto", hollyDto);
		model.put("StartDT", StartDT);
		model.put("EndDT", EndDT);
		
		
	
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "leavePageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("leavePageList");
	}

/**
	 * �ް��̷� ExcelList
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
public ActionForward leavePageExcelList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "leavePageList action start");
	
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchGb2 = StringUtil.nvl(request.getParameter("searchGb2"), "");
		String searchGb3 = StringUtil.nvl(request.getParameter("searchGb3"), "");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		
		Calendar cal = Calendar.getInstance ( );//���� ��¥�� ��������..
		cal.add ( cal.MONTH, -12 ); //1��....
		String StartDate = Integer.toString(cal.get ( cal.YEAR ))+"-"+String.format("%02d", cal.get ( cal.MONTH ) + 1)+"-"+String.format("%02d",cal.get ( cal.DATE ));
		Calendar cals = Calendar.getInstance ( );//���� ��¥�� ��������..
		cals.add ( cals.MONTH, +1 ); //1���� ��....
		String EndDate = Integer.toString(cals.get ( cals.YEAR ))+"-"+String.format("%02d",cals.get ( cals.MONTH ) + 1)+"-"+String.format("%02d",cals.get ( cals.DATE ));
		
		String StartDT =  StringUtil.nvl(request.getParameter("StartDT"), StartDate);
		String EndDT =  StringUtil.nvl(request.getParameter("EndDT"), EndDate);
		
		HollyDAO hollyDao = new HollyDAO();
		HollyDTO hollyDto = new HollyDTO();
		
		hollyDto.setUserID(USERID);
		hollyDto.setSearchGb(searchGb);
		hollyDto.setSearchGb2(searchGb2);
		hollyDto.setSearchGb3(searchGb3);
		hollyDto.setSearchtxt(searchtxt);
		/*		hollyDto.setnRow(10);
		hollyDto.setnPage(curPageCnt);*/
		hollyDto.setStartDT(StartDT);
		hollyDto.setEndDT(EndDT);
		hollyDto.setJobGb("PAGE2");
		
		ListDTO ld = hollyDao.hollyDayRequestExcelList(hollyDto);
		

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchGb2", searchGb2);
		model.put("searchGb3", searchGb3);
		model.put("searchtxt", searchtxt);
		model.put("hollyDto", hollyDto);
		model.put("StartDT", StartDT);
		model.put("EndDT", EndDT);
		
		
	
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "leavePageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("leavePageExcelList");
	}





   /**
	 * �ް���û ���̾ƿ� ��
	 
	 * 2017-09-21 �輺ȯ -> �ް� ��û�� ���� �ް� ���� ��ȸ �߰�
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
  public ActionForward leaveRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "leaveRegistForm action start");
	
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.
		
		HollyDAO hollyDao = new HollyDAO();
		HollyDTO hollyDto = new HollyDTO();
		hollyDto.setLogID(logid);
		hollyDto.setUserID(USERID);
		
		ArrayList<HollyDTO> singIDlist = hollyDao.HollyUserList(hollyDto);
		
		ArrayList<HollyDTO> arraylist = hollyDao.HollyDay();
		
		//2017-09-21 shkim : �ް���û�� ���� ���� üũ�� ���� ������� �ް� ���� ��ȸ
		HollyDTO myHollyDayInfo = new HollyDTO();
		myHollyDayInfo = hollyDao.myHollyDayView(hollyDto);
		
		model.put("singIDlist",singIDlist);
		model.put("arraylist",arraylist);
		model.put("UserID", USERID);
		model.put("hollyDayInfo", myHollyDayInfo);	//2017-09-21 shkim : �ް���û�� ���� ���� üũ�� ���� ������� �ް� ���� ��ȸ
		/*model.put("GroupStep",GroupStep);
		model.put("SelectType",SelectType);*/
		
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "leaveRegistForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("leaveRegistForm");
  	}
  
  /**
	 * �ް����� ���̾ƿ� ��
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
public ActionForward leaveModifyForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "leaveModifyForm action start");
	
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.
		
		String seq2 = StringUtil.nvl(request.getParameter("seq"),"");
		
		int seq = Integer.parseInt(seq2);
		System.out.println("[][] :"+seq);
		
		HollyDAO hollyDao = new HollyDAO();
		HollyDTO hollyDto = new HollyDTO();
		HollyDTO hollyDto2 = new HollyDTO();
		
		hollyDto.setLogID(logid);
		hollyDto.setUserID(USERID);
		hollyDto.setSeq(seq);
		
		
		hollyDto2 = hollyDao.goModifyForm(hollyDto);
		System.out.println("MGtKey : "+hollyDto2.getMgtKey());
		
		
		ListDTO ld = hollyDao.HollyList(hollyDto2.getMgtKey());
		ArrayList<HollyDTO> singIDlist = hollyDao.HollyUserList(hollyDto);
		
		model.put("singIDlist",singIDlist);
		model.put("hollyDto2", hollyDto2);
		model.put("ld", ld);
		model.put("seq2", seq2);
		/*model.put("GroupStep",GroupStep);
		model.put("SelectType",SelectType);*/
		
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "leaveModifyForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("leaveModifyForm");
	}
  

/**
 * �ް���¥ �ߺ�üũ
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward DupCheck(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "DupCheck action start");
	
	//�α��� ó�� 
	String USERID = UserBroker.getUserId(request);
	String msg	="";
	String result ="0";
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//�α��� ó�� ��.

	HollyDAO hollyDao = new HollyDAO();
	HollyDTO hollyDto = new HollyDTO();
	
	String startdates = StringUtil.nvl(request.getParameter("startdates"),"");
	String test = startdates.replaceAll("-", "");
	String[] str = test.split(" / ");//��Ʈ�� �迭�� �ް�..
	int[] exampleNo = new int[str.length];
	
	//for������ Ǯ� ��ȯ �۾��� �ؾ� �Ѵ�.
	for(int i = 0; i<str.length; i++){
		
	     exampleNo[i] = Integer.parseInt(str[i]);
	     hollyDto=hollyDao.DupCheck(USERID,String.valueOf(exampleNo[i]));
	     	if(hollyDto.getResult() == 1){
	     		result = hollyDto.getHollyDate();
	     	}
	}
	
	response.setContentType("text/html; charset=euc-kr");
	response.getWriter().print(result);
	
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "DupCheck action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return null;
	}

/**
 * �ް���¥ �ߺ�üũ
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward HollyDupCheck(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "HollyDupCheck action start");
	
	//�α��� ó�� 
	String USERID = UserBroker.getUserId(request);
	String msg	="";
	String result ="0";
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//�α��� ó�� ��.

	HollyDAO hollyDao = new HollyDAO();
	HollyDTO hollyDto = new HollyDTO();
	
	String startdates = StringUtil.nvl(request.getParameter("startdates"),"");
	startdates = startdates.replaceAll("-", "");
	
	     hollyDto=hollyDao.HollyDupCheck(startdates);
	     	if(hollyDto.getResult() == 1){
	     		result = hollyDto.getHollyDate();
	     	}
	     	
	response.setContentType("text/html; charset=euc-kr");
	response.getWriter().print(result);
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "HollyDupCheck action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return null;
	}

  /**
	 * �ް���û
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
public ActionForward leaveRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "leaveRegist action start");
	
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		int retval =0;
		int retval2 =0;
		String msg	="";
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.
		
		DecimalFormat df = new DecimalFormat("00");	
		Calendar cal = Calendar.getInstance();	
		String MgtNum = Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE))+df.format(cal.getTimeInMillis());
		
		String HollyFlag = StringUtil.nvl(request.getParameter("HollyFlag"),"");
		
		String startDate = StringUtil.nvl(request.getParameter("StartDateTime"),"");
		String startDate2 = StringUtil.nvl(request.getParameter("startDate2"),"");
		String startDate3 = StringUtil.nvl(request.getParameter("startDate3"),"");
		
		String endDate = StringUtil.nvl(request.getParameter("endDate"),"");
		String Days = StringUtil.nvl(request.getParameter("Day"),"");
		String SignID1 = StringUtil.nvl(request.getParameter("SignID1"),"");
		String SignID2 = StringUtil.nvl(request.getParameter("SignID2"),"");
		String Reason = StringUtil.nvl(request.getParameter("Reason"),"");
		String HollyUsed ="Y";
		String State1 ="S";
		String State2 ="S";
		String HollyDate="";
		int[] exampleNo = null;
		int[] startdates2 =null;
		if(HollyFlag.equals("2") || HollyFlag.equals("3")){
			
			startDate = startDate2;
			endDate = startDate2;
			HollyDate = startDate2;
				}else{
					HollyDate = startDate;
					String test = startDate.replaceAll("-", "");
					String[] str = test.split(" / ");//��Ʈ�� �迭�� �ް�..
					exampleNo = new int[str.length];
					 
					//for������ Ǯ� ��ȯ �۾��� �ؾ� �Ѵ�.
					for(int i = 0; i<str.length; i++){
					     exampleNo[i] = Integer.parseInt(str[i]);
					}
					Arrays.sort(exampleNo);
					startDate= String.valueOf(exampleNo[0]);
					endDate = String.valueOf(exampleNo[exampleNo.length-1]);
					
						}
		
		
		Float Day = Float.parseFloat(Days);
		if(HollyFlag.equals("4") || HollyFlag.equals("5") || HollyFlag.equals("6")|| HollyFlag.equals("7")){
			HollyUsed = "N";
		}else{
			HollyUsed = "Y";
		}
		
		if(USERID.equals(SignID1)){//������� ����
			State1="Y";
		}else{
			State1="S";
		}
		
		if(USERID.equals(SignID2)){//��ǥ���� ����
			State1="Y";
			State2="Y";
			
		}else if(SignID1.equals(SignID2)){//������ �ߺ�
			State1="Y";
			State2="S";
		}
		
		if(SignID1.equals("noSign") && !USERID.equals(SignID2)){//�����ھ���
			State1="Y";
			State2="S";
		}
		HollyDAO hollyDao = new HollyDAO();
		HollyDTO hollyDto = new HollyDTO();
		HollyDTO hollyDto1 = new HollyDTO();
		HollyDTO hollyDto2 = new HollyDTO();
		HollyDTO hollyDto3 = new HollyDTO();
		hollyDto.setLogID(logid);
		hollyDto.setUserID(USERID);
		hollyDto.setHollyFlag(HollyFlag);
		hollyDto.setStartDate(startDate);
		hollyDto.setEndDate(endDate);
		hollyDto.setDay(Day);
		hollyDto.setSignID1(SignID1);
		hollyDto.setSignID2(SignID2);
		hollyDto.setReason(Reason);
		hollyDto.setHollyUsed(HollyUsed);
		hollyDto.setState1(State1);
		hollyDto.setState2(State2);
		hollyDto.setHollyDate(HollyDate);
		hollyDto.setMgtKey(MgtNum);
		
		retval=hollyDao.HollyDayRegist(hollyDto);
		
		
		
		if(HollyFlag.equals("2") || HollyFlag.equals("3")){
			int test = Integer.parseInt(startDate2.replaceAll("-", ""));
			retval2=hollyDao.HollyDayDuple2(MgtNum,USERID,test);
			
		}else{
			retval2=hollyDao.HollyDayDuple(MgtNum,USERID,exampleNo);	
			
		}
		
		
		hollyDto1 = hollyDao.SignUserSelect(USERID);
		hollyDto2 = hollyDao.SignUserSelect(SignID1);
		hollyDto3 = hollyDao.SignUserSelect(SignID2);
		
		String Contents = "<�޿��̼�> "+hollyDto1.getUserName()+" ���� �ް��� ��û�Ͽ����ϴ�. �޿���� ���� ���ּ���";
		/////////////API ���� ���۹�������////////////////
		String result,getCERTKEY;

		BaroService_SMSSoapProxy proxy = new BaroService_SMSSoapProxy();	
		CERTKEY certkey = new CERTKEY();
		
		getCERTKEY = certkey.getCERTKEY();
		
		if(USERID.equals(SignID1) && !USERID.equals(SignID2)){//������� ����		
					result = proxy.sendMessage(getCERTKEY, "1088193762","huation", "02-2081-6713", hollyDto3.getUserName(),hollyDto3.getPhoneNo(),Contents, "", "");
				}else if(USERID.equals(SignID2)){
			}else{
					result = proxy.sendMessage(getCERTKEY, "1088193762","huation", "02-2081-6713", hollyDto2.getUserName(),hollyDto2.getPhoneNo(),Contents, "", "");
		}
		/////////////////////////////////////////////
		
		System.out.println("=============================================="+retval);
		msg = "������ �Ϸ�Ǿ����ϴ�.";
		
		if(retval == -1){
			msg = "������ �Ϸ�Ǿ����ϴ�.";
		if(USERID.equals(SignID2)){//��ǥ���� ����
//			TotalSMSSend(hollyDto1.getUserName() , startDate.substring(0,4)+"-"+startDate.substring(4,6)+"-"+startDate.substring(6,8) ,endDate.substring(0,4)+"-"+endDate.substring(4,6)+"-"+endDate.substring(6,8),HollyFlag,hollyDto1.getPhoneNo());
			}	
		}else{
			msg = "������ �����Ͽ����ϴ�.";
		}
		
		
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "leaveRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Holly.do?cmd=leaveApplyPageList","back");
	}
/**
 * �ް�����
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward leaveModify(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "leaveModify action start");

	//�α��� ó�� 
	String USERID = UserBroker.getUserId(request);
	int retval =0;
	int retval2 =0;
	String msg	="";
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//�α��� ó�� ��.
	
	DecimalFormat df = new DecimalFormat("00");	
	Calendar cal = Calendar.getInstance();	
	String MgtNum = StringUtil.nvl(request.getParameter("MgtKey"),"");
	String HollyFlag = StringUtil.nvl(request.getParameter("HollyFlag"),"");
	String startDate = StringUtil.nvl(request.getParameter("StartDateTime"),"");
	String startDate2 = StringUtil.nvl(request.getParameter("startDate2"),"");
	String endDate = StringUtil.nvl(request.getParameter("endDate"),"");
	String Days = StringUtil.nvl(request.getParameter("Day"),"");
	String SignID1 = StringUtil.nvl(request.getParameter("SignID1"),"");
	String SignID2 = StringUtil.nvl(request.getParameter("SignID2"),"");
	String Reason = StringUtil.nvl(request.getParameter("Reason"),"");
	String Seq = StringUtil.nvl(request.getParameter("Seqs"),"");
	String HollyUsed ="Y";
	String State1 =StringUtil.nvl(request.getParameter("State1"),"");
	String State2 =StringUtil.nvl(request.getParameter("State2"),"");
	String HollyDate="";
	
	
	int seq = Integer.parseInt(Seq);
	
	
	int[] exampleNo = null;
	int[] startdates2 =null;
	if(HollyFlag.equals("2") || HollyFlag.equals("3")){
		
		startDate = startDate2;
		endDate = startDate2;
		HollyDate = startDate2;
			}else{
				HollyDate = startDate;
				System.out.println("HollyDate : "+HollyDate);
				String test = startDate.replaceAll("-", "");
				String[] str = test.split(" / ");//��Ʈ�� �迭�� �ް�..
				exampleNo = new int[str.length];
				 
				//for������ Ǯ� ��ȯ �۾��� �ؾ� �Ѵ�.
				for(int i = 0; i<str.length; i++){
				     exampleNo[i] = Integer.parseInt(str[i]);
				}
				Arrays.sort(exampleNo);
				startDate= String.valueOf(exampleNo[0]);
				endDate = String.valueOf(exampleNo[exampleNo.length-1]);
				
					}
	Float Day = Float.parseFloat(Days);
	if(HollyFlag.equals("4") || HollyFlag.equals("5") || HollyFlag.equals("6")|| HollyFlag.equals("7")){
		HollyUsed = "N";
	}else{
		HollyUsed = "Y";
	}
	
	HollyDAO hollyDao = new HollyDAO();
	HollyDTO hollyDto = new HollyDTO();
	
	hollyDto.setLogID(logid);
	hollyDto.setUserID(USERID);
	hollyDto.setHollyFlag(HollyFlag);
	hollyDto.setStartDate(startDate);
	hollyDto.setEndDate(endDate);
	hollyDto.setDay(Day);
	hollyDto.setSignID1(SignID1);
	hollyDto.setSignID2(SignID2);
	hollyDto.setReason(Reason);
	hollyDto.setHollyUsed(HollyUsed);
	hollyDto.setState1(State1);
	hollyDto.setState2(State2);
	hollyDto.setHollyDate(HollyDate);
	hollyDto.setMgtKey(MgtNum);
	hollyDto.setSeq(seq);
	
	retval=hollyDao.HollyDayModify(hollyDto);
	
	
	
	if(HollyFlag.equals("2") || HollyFlag.equals("3")){
		int test = Integer.parseInt(startDate2.replaceAll("-", ""));
		retval2=hollyDao.HollyDayMapModify2(MgtNum,USERID,test);
		
	}else{
		retval2=hollyDao.HollyMapDelete(MgtNum,USERID);
		retval2=hollyDao.HollyDayDuple(MgtNum,USERID,exampleNo);
		
		
	}
	
	if(retval == -1){
		msg = "������ �Ϸ�Ǿ����ϴ�.";
	}else{
		msg = "������ �����Ͽ����ϴ�.";
	}
	
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "leaveModify action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return alertAndExit(model,msg,request.getContextPath()+"/H_Holly.do?cmd=leavePageList","back");
}



/**
 * �ް����� �׼�
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward HollyDaySign(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "HollyDaySign action start");

	//�α��� ó�� 
	String USERID = UserBroker.getUserId(request);
	String msg = "";
	int retVal =0;
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//�α��� ó�� ��.
	
	String State = StringUtil.nvl(request.getParameter("State"),"");
	String Sign = StringUtil.nvl(request.getParameter("Sign"),"");
	String Seq = StringUtil.nvl(request.getParameter("Seq"),"");
	int	Seqs = Integer.parseInt(Seq);
	
	
	/*String ReturnReason = StringUtil.nvl(URLDecoder.decode(request.getParameter("ReturnReason"),"UTF-8"),"");*/
	String ReturnReason = request.getParameter("ReturnReason"); 
	System.out.println(ReturnReason);
	
	if(ReturnReason.equals("undefined")){
		ReturnReason="";
	}
	
	
	HollyDAO hollyDao = new HollyDAO();
	HollyDTO hollyDto = new HollyDTO();
	HollyDTO hollyDto1 = new HollyDTO();
	HollyDTO hollyDto3 = new HollyDTO();
	
	hollyDto.setJobGb(State);
	hollyDto.setSign(Sign);
	hollyDto.setReturnReason(ReturnReason);
	hollyDto.setSeq(Seqs);
	
	retVal=hollyDao.updateSign(hollyDto);
	hollyDto = hollyDao.updateSign2(hollyDto);
	
	System.out.println("retVal : "+retVal);
	System.out.println(hollyDto.getState1()+","+hollyDto.getState2());
	
	if(retVal == 1){
		msg = "���簡 �Ϸ�Ǿ����ϴ�.";
		if(hollyDto.getState1().equals("Y") && hollyDto.getState2().equals("S")){
			
			
			hollyDto1 = hollyDao.SignUserSelect(hollyDto.getUserID());
			hollyDto3 = hollyDao.SignUserSelect(hollyDto.getSignID2());
			
			String Contents = "<�޿��̼�> "+hollyDto1.getUserName()+" ���� �ް��� ��û�Ͽ����ϴ�. �޿���� ���� ���ּ���";
			/////////////API ���� ���۹�������////////////////
			String result,getCERTKEY;

			BaroService_SMSSoapProxy proxy = new BaroService_SMSSoapProxy();	
			CERTKEY certkey = new CERTKEY();
			
			getCERTKEY = certkey.getCERTKEY();
	
			result = proxy.sendMessage(getCERTKEY, "1088193762","huation", "02-2081-6713", hollyDto3.getUserName(),hollyDto3.getPhoneNo(),Contents, "", "");
		}
		if(hollyDto.getState1().equals("Y") && hollyDto.getState2().equals("Y")){
			//20200608 ������ ��ü�޼��� ���� �ּ�ó��.
//						TotalSMSSend(hollyDto.getUserName() , hollyDto.getStartDate() , hollyDto.getEndDate() , hollyDto.getHollyFlag(),hollyDto.getPhoneNo() );
		}
	
	}else{
		msg ="�������, �����ڿ��� �����ϼ���";
	}
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "HollyDaySign action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return alertAndExit(model,msg,request.getContextPath()+"/H_Holly.do?cmd=leaveAppPageList","back");
	}
/**
 * �ް����� ��ü SMS�߼�
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return 
 * @return userPageList
 * @throws Exception
 */
public Object TotalSMSSend(String UserName , String StartDate , String EndDate , String HollyFlag , String SendPhoneno) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "TotalSMSSend action start");
	
	
	String sendNum = SendPhoneno;
	System.out.println("====== : "+sendNum);
	String StartDateTime = StartDate.substring(0,10);
	String EndDateTIme = EndDate.substring(0,10);
	int EndDateTime2 = Integer.parseInt(EndDateTIme.replaceAll("-",""));
	String HollyName ="";
	
	DecimalFormat df = new DecimalFormat("00");	
	Calendar cal = Calendar.getInstance();	
	String DateTime = Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE));
	int DateTime2 = Integer.parseInt(DateTime);
	////���� ����////
	System.out.println(DateTime2);
	System.out.println(EndDateTime2);
	if(DateTime2<=EndDateTime2){
			if(HollyFlag.equals("1")){
				HollyName = "����";
			}else if(HollyFlag.equals("2")){
				HollyName = "��������";
			}else if(HollyFlag.equals("3")){
				HollyName = "���Ĺ���";
			}else if(HollyFlag.equals("4")){
				HollyName = "����";
			}else if(HollyFlag.equals("5")){
				HollyName = "����";
			}else if(HollyFlag.equals("6")){
				HollyName = "�����ް�";
			}else if(HollyFlag.equals("7")){
				HollyName = "�����ް�";
			}
			
			
			String message = "<�޿��̼�> "+StartDateTime+" ~ "+EndDateTIme+" ���� "+UserName+" ���� "+HollyName+" �Դϴ�.";
			System.out.println("message : "+message);
			String PhoneSplit ="";
			String UserNameSplit ="";
			
			
			HollyDAO hollyDao = new HollyDAO();
			
			ArrayList<HollyDTO> arraylist = hollyDao.TotalUserPhoneNo();
			
				if(arraylist.size() > 0){
					for(int j=0; j < arraylist.size(); j++ ){	
						HollyDTO hollyDto = arraylist.get(j);
						PhoneSplit += hollyDto.getPhoneNo()+",";
						UserNameSplit += hollyDto.getUserName()+",";
					}
				}
				System.out.println(PhoneSplit);
				System.out.println(UserNameSplit);
				PhoneSplit = PhoneSplit.substring(0,PhoneSplit.length()-1);
				UserNameSplit = UserNameSplit.substring(0,UserNameSplit.length()-1);
				
				String[] phoneno= PhoneSplit.split(",");
				String[] username= UserNameSplit.split(",");
				
				/////////////API ���� ����////////////////
				
				String result,getCERTKEY;
			
				BaroService_SMSSoapProxy proxy = new BaroService_SMSSoapProxy();	
				CERTKEY certkey = new CERTKEY();
				
				getCERTKEY = certkey.getCERTKEY();
				
				//������ �޼��� �����	
				XMSMessage[] arrxms = new XMSMessage[phoneno.length];
					
				for(int i=0;i<arrxms.length;i++)
				{
					XMSMessage xms = new XMSMessage();
					xms.setSenderNum(sendNum);
					xms.setReceiverName(username[i]);
					xms.setReceiverNum(phoneno[i]);
					xms.setMessage(message);
					xms.setRefKey("");
					
					arrxms[i] = xms;		
				}
				result = proxy.sendMessages(getCERTKEY,"1088193762","huation",arrxms.length,false,arrxms,"");
				//////////////////////////////////////////////////////////////	
				System.out.println(result);
	}
		//log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "TotalSMSSend action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
			return null;
		}

/**
 * �ް����� �׼�(�˾�)
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward HollyDaySignPop(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "HollyDaySignPop action start");

	//�α��� ó�� 
	String USERID = UserBroker.getUserId(request);
	String msg = "";
	int retVal =0;
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//�α��� ó�� ��.
	
	String State = StringUtil.nvl(request.getParameter("State"),"");
	String Sign = StringUtil.nvl(request.getParameter("Sign"),"");
	String Seq = StringUtil.nvl(request.getParameter("Seq"),"");
	int	Seqs = Integer.parseInt(Seq);
	
	
	/*String ReturnReason = StringUtil.nvl(URLDecoder.decode(request.getParameter("ReturnReason"),"UTF-8"),"");*/
	String ReturnReason = new String(request.getParameter("ReturnReason").getBytes("8859_1"),"EUC-KR"); 
	System.out.println(ReturnReason);
	
	if(ReturnReason.equals("undefined")){
		ReturnReason="";
	}
	
	HollyDAO hollyDao = new HollyDAO();
	HollyDTO hollyDto = new HollyDTO();
	HollyDTO hollyDto1 = new HollyDTO();
	HollyDTO hollyDto3 = new HollyDTO();
	
	hollyDto.setJobGb(State);
	hollyDto.setSign(Sign);
	hollyDto.setReturnReason(ReturnReason);
	hollyDto.setSeq(Seqs);
	
	retVal=hollyDao.updateSign(hollyDto);
	hollyDto = hollyDao.updateSign2(hollyDto);
	
	
	System.out.println("retVal : "+retVal);
	System.out.println(hollyDto.getState1()+","+hollyDto.getState2());
	
	if(retVal == 1){
		msg = "���簡 �Ϸ�Ǿ����ϴ�.";
		if(hollyDto.getState1().equals("Y") && hollyDto.getState2().equals("S")){
			
			
			hollyDto1 = hollyDao.SignUserSelect(hollyDto.getUserID());
			hollyDto3 = hollyDao.SignUserSelect(hollyDto.getSignID2());
			
			String Contents = "<�޿��̼�> "+hollyDto1.getUserName()+" ���� �ް��� ��û�Ͽ����ϴ�. �޿���� ���� ���ּ���";
			/////////////API ���� ���۹�������////////////////
			String result,getCERTKEY;

			BaroService_SMSSoapProxy proxy = new BaroService_SMSSoapProxy();	
			CERTKEY certkey = new CERTKEY();
			
			getCERTKEY = certkey.getCERTKEY();
	
			result = proxy.sendMessage(getCERTKEY, "1088193762","huation", "02-2081-6713", hollyDto3.getUserName(),hollyDto3.getPhoneNo(),Contents, "", "");
			
		}

		if(hollyDto.getState1().equals("Y") && hollyDto.getState2().equals("Y")){
//			TotalSMSSend(hollyDto.getUserName() , hollyDto.getStartDate() , hollyDto.getEndDate() , hollyDto.getHollyFlag(),hollyDto.getPhoneNo() );
		}
		
	
	}else{
		msg ="�������, �����ڿ��� �����ϼ���";
	}
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "HollyDaySignPop action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return alertAndExit(model,msg,request.getContextPath()+"/H_Holly.do?cmd=leaveApplicant","back");
	}

/**
 * �ݷ����� ���̾ƿ� �˾�
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward ReturnForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "ReturnForm action start");

	//�α��� ó�� 
	String USERID = UserBroker.getUserId(request);
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//�α��� ó�� ��.
	
	String State = StringUtil.nvl(request.getParameter("State"),"");
	String Sign = StringUtil.nvl(request.getParameter("Sign"),"");
	String Seq = StringUtil.nvl(request.getParameter("Seq"),"");
	
	int Seq2 = Integer.parseInt(Seq);
	HollyDAO hollyDao = new HollyDAO();
	HollyDTO hollyDto = new HollyDTO();
	
	hollyDto.setLogID(logid);
	hollyDto.setUserID(USERID);
	hollyDto.setSeq(Seq2);
	
	
	hollyDto = hollyDao.goModifyForm(hollyDto);
	
	
	
	model.put("State", State);
	model.put("Sign", Sign);
	model.put("Seq", Seq);
	model.put("hollyDto", hollyDto);
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "ReturnForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
  return actionMapping.findForward("ReturnForm");
	}

/**
 * �ް����� �˾�
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward leaveApplicant(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "leaveApplicant action start");

	//�α��� ó�� 
	String USERID = UserBroker.getUserId(request);
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//�α��� ó�� ��.
	
	String State = "";
	
	HollyDAO hollyDao = new HollyDAO();
	HollyDTO hollyDto = new HollyDTO();
	UserDAO userDao =new UserDAO();
	UserDTO userDto =new UserDTO();
	
	userDto.setLogid(logid);
	userDto.setID(USERID);
	
	userDto = userDao.userView(userDto);
	
	if(userDto.getPosition().equals("A")){
		State="1";
	}else{
		State="2";
	}
	
	System.out.println("State : "+State);
	
	hollyDto.setUserID(USERID);
	hollyDto.setJobGb(State);
	
	ListDTO ld = hollyDao.hollyApproveList(hollyDto);

	model.put("listInfo", ld);
	model.put("State", State);
	
			
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "leaveApplicant action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
  return actionMapping.findForward("leaveApplicant");
	}

/**
 * ������ �ް��� �˾�
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward leaveToday(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "leaveToday action start");

	//�α��� ó�� 
	String USERID = UserBroker.getUserId(request);
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//�α��� ó�� ��.
	
String State = "";
	
	HollyDAO hollyDao = new HollyDAO();
	HollyDTO hollyDto = new HollyDTO();
	
	ListDTO ld = hollyDao.hollyTodayList(hollyDto);

	model.put("listInfo", ld);
			
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "leaveToday action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
  return actionMapping.findForward("leaveToday");
	}


/* �ް���û ����
* @param actionMapping
* @param actionForm
* @param request
* @param httpServletResponse
* @param model
* @return
* @throws Exception
*/
public ActionForward hollydayHelp(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
	
	 
   return actionMapping.findForward("hollydayHelp"); 
}



 }
