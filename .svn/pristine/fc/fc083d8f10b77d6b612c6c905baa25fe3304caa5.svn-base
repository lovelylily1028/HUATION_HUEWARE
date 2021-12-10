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
	 * 휴일 리스트
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
	 * 휴일 정보를 삭제한다.(다건)
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

		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝.

		int retVal=0;
		String msg="";
		
		String[] seq = request.getParameterValues("seqs");

		HollyDAO hollyDao = new HollyDAO();

		retVal = hollyDao.HollyDayDeletes(logid,seq, USERID);
		
		if(retVal==-1){
			msg="삭제오류!";
		}else if(retVal==0){
			msg="삭제실패!";
		}else{
			msg="삭제완료!";
		}
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "HollyDayDeletes action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Holly.do?cmd=HollyDayMgPageList","");	
		
	}
	/**
	 * 휴일 등록 폼 (동작없음-폼만 호출)
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
		 * 휴가신청
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
		
			//로그인 처리 
			String USERID = UserBroker.getUserId(request);
			int retval =0;
			int retval2 =0;
			String msg	="";
			if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			//로그인 처리 끝.
			
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
			msg = "등록이 완료되었습니다.";
			
			if(retval == -1){
				msg = "등록이 완료되었습니다.";
			}else{
				msg = "등록에 실패하였습니다.";
			}
			
			
			
			//log action execute time end
			long t2 = System.currentTimeMillis();
			log.trace(logid, "HollyDayRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
			
			return closePopupReload(model, msg,"","", request.getContextPath()+"/H_Holly.do?cmd=HollyDayMgPageList");
		}
	/**
	 * 휴가신청 페이지
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
	
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝.
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		
		Calendar cal = Calendar.getInstance ( );//오늘 날짜를 기준으루..
		cal.add ( cal.MONTH, -12 ); //1년....
		String StartDate = Integer.toString(cal.get ( cal.YEAR ))+"-"+String.format("%02d", cal.get ( cal.MONTH ) + 1)+"-"+String.format("%02d",cal.get ( cal.DATE ));
		Calendar cals = Calendar.getInstance ( );//오늘 날짜를 기준으루..
		cals.add ( cals.MONTH, +1 ); //1개월 후....
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
    * 휴가신청자들 페이지 
    * @param actionMapping
    * @param actionForm
    * @param request
    * @param response
    * @param model
    * @return userPageList
    * @throws Exception
    * 20200602 김진동전사원 리스트로 변경. 
    */
//   public ActionForward leaveApplyPageAllList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
   public ActionForward adminLeaveApplyPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
	   
	   //log action execute time start
	   String logid=log.logid();
	   long t1 = System.currentTimeMillis();
	   log.trace(logid, "adminLeaveApplyPageList action start");
	   
	   //로그인 처리 
	   String USERID = UserBroker.getUserId(request);
	   
	   if(USERID.equals("")){
		   String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		   return goSessionOut(model, rtnUrl,"huation-sessionOut");
	   }
	   //로그인 처리 끝.
	   
	   String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
	   String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
	   int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
	   
	   Calendar cal = Calendar.getInstance ( );//오늘 날짜를 기준으루..
	   cal.add ( cal.MONTH, -12 ); //1년....
	   String StartDate = Integer.toString(cal.get ( cal.YEAR ))+"-"+String.format("%02d", cal.get ( cal.MONTH ) + 1)+"-"+String.format("%02d",cal.get ( cal.DATE ));
	   Calendar cals = Calendar.getInstance ( );//오늘 날짜를 기준으루..
	   cals.add ( cals.MONTH, +1 ); //1개월 후....
	   String EndDate = Integer.toString(cals.get ( cals.YEAR ))+"-"+String.format("%02d",cals.get ( cals.MONTH ) + 1)+"-"+String.format("%02d",cals.get ( cals.DATE ));
	   
	   String StartDT =  StringUtil.nvl(request.getParameter("StartDT"), StartDate);
	   String EndDT =  StringUtil.nvl(request.getParameter("EndDT"), EndDate);
	   //이 위 날짜는 는 현재 쓰지 않음 
	   
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
    * 휴가신청자들 페이지 상세팝업 
    * @param actionMapping
    * @param actionForm
    * @param request
    * @param response
    * @param model
    * @return userPageList
    * @throws Exception
    * 20200602 김진동전사원 리스트로 변경. 에서 리스트 클릭시 
    */
//   public ActionForward leaveApplyPageAllList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
   public ActionForward adminLeaveApplyPageListPopup(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
	   
	   //log action execute time start
	   String logid=log.logid();
	   long t1 = System.currentTimeMillis();
	   log.trace(logid, "adminLeaveApplyPageListPopup action start");
	   
	   //로그인 처리 
	   String USERID = UserBroker.getUserId(request);
	   
	   if(USERID.equals("")){
		   String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		   return goSessionOut(model, rtnUrl,"huation-sessionOut");
	   }
	   //로그인 처리 끝.
	   // L_USERID 이전 화면에서 클릭한 이름을 가져온다..
	   USERID = StringUtil.nvl(request.getParameter("pUserid"), ""); //로그인 체크가 끝나면 화면에서 받아온 로그인 아이디를 가져온다.
	   String carrer = StringUtil.nvl(request.getParameter("pCarrer"), ""); //클릭한 사람의 경력
//	   String pName = StringUtil.nvl(request.getParameter("pName"), ""); //클릭한 사람의 이름.
	   String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");//일단 화면에 없다
	   String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");//일단 화면에 없다
	   int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
	   
	   Calendar cal = Calendar.getInstance ( );//오늘 날짜를 기준으루..
	   cal.add ( cal.MONTH, -12 ); //1년....
	   String StartDate = Integer.toString(cal.get ( cal.YEAR ))+"-"+String.format("%02d", cal.get ( cal.MONTH ) + 1)+"-"+String.format("%02d",cal.get ( cal.DATE ));
	   Calendar cals = Calendar.getInstance ( );//오늘 날짜를 기준으루..
	   cals.add ( cals.MONTH, +1 ); //1개월 후....
	   String EndDate = Integer.toString(cals.get ( cals.YEAR ))+"-"+String.format("%02d",cals.get ( cals.MONTH ) + 1)+"-"+String.format("%02d",cals.get ( cals.DATE ));
	   
	   String StartDT =  StringUtil.nvl(request.getParameter("StartDT"), StartDate);
	   String EndDT =  StringUtil.nvl(request.getParameter("EndDT"), EndDate);
	   
	   //이 위 날짜는 는 현재 쓰지 않음 
	   
	   HollyDAO hollyDao = new HollyDAO();
	   HollyDTO hollyDto = new HollyDTO();
	   
	   hollyDto.setUserID(USERID);
	   hollyDto.setSearchGb(searchGb);
	   hollyDto.setSearchtxt(searchtxt);
//	   hollyDto.setnRow(10);
	   hollyDto.setnRow(100);//왠만하면 한번에 나오게 한다
	   hollyDto.setnPage(curPageCnt);
	   hollyDto.setStartDT(StartDT);
	   hollyDto.setEndDT(EndDT);
	   hollyDto.setJobGb("PAGE");
	   
	   ListDTO ld = new ListDTO();
	   ArrayList<HollyDTO> arraylist = new ArrayList<HollyDTO>();
	   //기존의 것을 쓰려고 하지말고 STARTDT
	   if(carrer.equals("0") ) { //연차가 1년 미만일때
		   arraylist = hollyDao.hollyDayRequestNewbieList(hollyDto);
	   }else { //입사가 1년 이상일때.
		   arraylist = hollyDao.hollyDayRequestElderList(hollyDto);
	   }
//	   model.put("listInfo", ld);
	   model.put("arraylist", arraylist);
	   model.put("curPage", String.valueOf(curPageCnt));
	   model.put("searchGb", searchGb);
	   model.put("searchtxt", searchtxt);
	   model.put("pUserid", USERID); //재조회시를 위해 해당화면에대한 아이디를 되돌려준다.
	   model.put("pCarrer", carrer); //재조회시를 위해 해당화면에대한 경력을 되돌려준다.
//	   model.put("pName", pName); //재조회시를 위해 해당화면에대한 이름을 되돌려준다.(이름은 받아온 그대로 쓴다.) //한글깨지므로 뺌
	   
	   //log action execute time end
	   long t2 = System.currentTimeMillis();
	   log.trace(logid, "adminLeaveApplyPageListPopup action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	   
	   return actionMapping.findForward("adminLeaveApplyPageListPopup");
   }
   /**
	 * 휴가결재 페이지
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
	
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝.
		
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
	 * 휴가이력 페이지
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
	
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝.
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchGb2 = StringUtil.nvl(request.getParameter("searchGb2"), "");
		String searchGb3 = StringUtil.nvl(request.getParameter("searchGb3"), "");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		
		Calendar cal = Calendar.getInstance ( );//오늘 날짜를 기준으루..
		cal.add ( cal.MONTH, -12 ); //1년....
		String StartDate = Integer.toString(cal.get ( cal.YEAR ))+"-"+String.format("%02d", cal.get ( cal.MONTH ) + 1)+"-"+String.format("%02d",cal.get ( cal.DATE ));
		Calendar cals = Calendar.getInstance ( );//오늘 날짜를 기준으루..
		cals.add ( cals.MONTH, +1 ); //1개월 후....
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
	 * 휴가이력 ExcelList
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
	
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝.
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchGb2 = StringUtil.nvl(request.getParameter("searchGb2"), "");
		String searchGb3 = StringUtil.nvl(request.getParameter("searchGb3"), "");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		
		Calendar cal = Calendar.getInstance ( );//오늘 날짜를 기준으루..
		cal.add ( cal.MONTH, -12 ); //1년....
		String StartDate = Integer.toString(cal.get ( cal.YEAR ))+"-"+String.format("%02d", cal.get ( cal.MONTH ) + 1)+"-"+String.format("%02d",cal.get ( cal.DATE ));
		Calendar cals = Calendar.getInstance ( );//오늘 날짜를 기준으루..
		cals.add ( cals.MONTH, +1 ); //1개월 후....
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
	 * 휴가신청 레이아웃 폼
	 
	 * 2017-09-21 김성환 -> 휴가 신청시 개인 휴가 정보 조회 추가
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
	
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝.
		
		HollyDAO hollyDao = new HollyDAO();
		HollyDTO hollyDto = new HollyDTO();
		hollyDto.setLogID(logid);
		hollyDto.setUserID(USERID);
		
		ArrayList<HollyDTO> singIDlist = hollyDao.HollyUserList(hollyDto);
		
		ArrayList<HollyDTO> arraylist = hollyDao.HollyDay();
		
		//2017-09-21 shkim : 휴가신청시 남은 연차 체크를 위한 사용자의 휴가 정보 조회
		HollyDTO myHollyDayInfo = new HollyDTO();
		myHollyDayInfo = hollyDao.myHollyDayView(hollyDto);
		
		model.put("singIDlist",singIDlist);
		model.put("arraylist",arraylist);
		model.put("UserID", USERID);
		model.put("hollyDayInfo", myHollyDayInfo);	//2017-09-21 shkim : 휴가신청시 남은 연차 체크를 위한 사용자의 휴가 정보 조회
		/*model.put("GroupStep",GroupStep);
		model.put("SelectType",SelectType);*/
		
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "leaveRegistForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("leaveRegistForm");
  	}
  
  /**
	 * 휴가수정 레이아웃 폼
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
	
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝.
		
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
 * 휴가날짜 중복체크
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
	
	//로그인 처리 
	String USERID = UserBroker.getUserId(request);
	String msg	="";
	String result ="0";
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//로그인 처리 끝.

	HollyDAO hollyDao = new HollyDAO();
	HollyDTO hollyDto = new HollyDTO();
	
	String startdates = StringUtil.nvl(request.getParameter("startdates"),"");
	String test = startdates.replaceAll("-", "");
	String[] str = test.split(" / ");//스트링 배열을 받고..
	int[] exampleNo = new int[str.length];
	
	//for문으로 풀어서 변환 작업을 해야 한다.
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
 * 휴가날짜 중복체크
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
	
	//로그인 처리 
	String USERID = UserBroker.getUserId(request);
	String msg	="";
	String result ="0";
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//로그인 처리 끝.

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
	 * 휴가신청
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
	
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		int retval =0;
		int retval2 =0;
		String msg	="";
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝.
		
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
					String[] str = test.split(" / ");//스트링 배열을 받고..
					exampleNo = new int[str.length];
					 
					//for문으로 풀어서 변환 작업을 해야 한다.
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
		
		if(USERID.equals(SignID1)){//팀장권한 결재
			State1="Y";
		}else{
			State1="S";
		}
		
		if(USERID.equals(SignID2)){//대표권한 결재
			State1="Y";
			State2="Y";
			
		}else if(SignID1.equals(SignID2)){//결재자 중복
			State1="Y";
			State2="S";
		}
		
		if(SignID1.equals("noSign") && !USERID.equals(SignID2)){//결재자없음
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
		
		String Contents = "<휴에이션> "+hollyDto1.getUserName()+" 님이 휴가를 신청하였습니다. 휴웨어에서 결재 해주세요";
		/////////////API 연동 전송문자전송////////////////
		String result,getCERTKEY;

		BaroService_SMSSoapProxy proxy = new BaroService_SMSSoapProxy();	
		CERTKEY certkey = new CERTKEY();
		
		getCERTKEY = certkey.getCERTKEY();
		
		if(USERID.equals(SignID1) && !USERID.equals(SignID2)){//팀장권한 결재		
					result = proxy.sendMessage(getCERTKEY, "1088193762","huation", "02-2081-6713", hollyDto3.getUserName(),hollyDto3.getPhoneNo(),Contents, "", "");
				}else if(USERID.equals(SignID2)){
			}else{
					result = proxy.sendMessage(getCERTKEY, "1088193762","huation", "02-2081-6713", hollyDto2.getUserName(),hollyDto2.getPhoneNo(),Contents, "", "");
		}
		/////////////////////////////////////////////
		
		System.out.println("=============================================="+retval);
		msg = "접수가 완료되었습니다.";
		
		if(retval == -1){
			msg = "접수가 완료되었습니다.";
		if(USERID.equals(SignID2)){//대표권한 결재
//			TotalSMSSend(hollyDto1.getUserName() , startDate.substring(0,4)+"-"+startDate.substring(4,6)+"-"+startDate.substring(6,8) ,endDate.substring(0,4)+"-"+endDate.substring(4,6)+"-"+endDate.substring(6,8),HollyFlag,hollyDto1.getPhoneNo());
			}	
		}else{
			msg = "접수에 실패하였습니다.";
		}
		
		
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "leaveRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Holly.do?cmd=leaveApplyPageList","back");
	}
/**
 * 휴가수정
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

	//로그인 처리 
	String USERID = UserBroker.getUserId(request);
	int retval =0;
	int retval2 =0;
	String msg	="";
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//로그인 처리 끝.
	
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
				String[] str = test.split(" / ");//스트링 배열을 받고..
				exampleNo = new int[str.length];
				 
				//for문으로 풀어서 변환 작업을 해야 한다.
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
		msg = "수정이 완료되었습니다.";
	}else{
		msg = "수정에 실패하였습니다.";
	}
	
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "leaveModify action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return alertAndExit(model,msg,request.getContextPath()+"/H_Holly.do?cmd=leavePageList","back");
}



/**
 * 휴가결재 액션
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

	//로그인 처리 
	String USERID = UserBroker.getUserId(request);
	String msg = "";
	int retVal =0;
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//로그인 처리 끝.
	
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
		msg = "결재가 완료되었습니다.";
		if(hollyDto.getState1().equals("Y") && hollyDto.getState2().equals("S")){
			
			
			hollyDto1 = hollyDao.SignUserSelect(hollyDto.getUserID());
			hollyDto3 = hollyDao.SignUserSelect(hollyDto.getSignID2());
			
			String Contents = "<휴에이션> "+hollyDto1.getUserName()+" 님이 휴가를 신청하였습니다. 휴웨어에서 결재 해주세요";
			/////////////API 연동 전송문자전송////////////////
			String result,getCERTKEY;

			BaroService_SMSSoapProxy proxy = new BaroService_SMSSoapProxy();	
			CERTKEY certkey = new CERTKEY();
			
			getCERTKEY = certkey.getCERTKEY();
	
			result = proxy.sendMessage(getCERTKEY, "1088193762","huation", "02-2081-6713", hollyDto3.getUserName(),hollyDto3.getPhoneNo(),Contents, "", "");
		}
		if(hollyDto.getState1().equals("Y") && hollyDto.getState2().equals("Y")){
			//20200608 김진동 전체메세지 전송 주석처리.
//						TotalSMSSend(hollyDto.getUserName() , hollyDto.getStartDate() , hollyDto.getEndDate() , hollyDto.getHollyFlag(),hollyDto.getPhoneNo() );
		}
	
	}else{
		msg ="결재실패, 관리자에게 문의하세요";
	}
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "HollyDaySign action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return alertAndExit(model,msg,request.getContextPath()+"/H_Holly.do?cmd=leaveAppPageList","back");
	}
/**
 * 휴가승인 전체 SMS발송
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
	////문자 정보////
	System.out.println(DateTime2);
	System.out.println(EndDateTime2);
	if(DateTime2<=EndDateTime2){
			if(HollyFlag.equals("1")){
				HollyName = "연차";
			}else if(HollyFlag.equals("2")){
				HollyName = "오전반차";
			}else if(HollyFlag.equals("3")){
				HollyName = "오후반차";
			}else if(HollyFlag.equals("4")){
				HollyName = "병가";
			}else if(HollyFlag.equals("5")){
				HollyName = "공가";
			}else if(HollyFlag.equals("6")){
				HollyName = "무급휴가";
			}else if(HollyFlag.equals("7")){
				HollyName = "복리휴가";
			}
			
			
			String message = "<휴에이션> "+StartDateTime+" ~ "+EndDateTIme+" 까지 "+UserName+" 님의 "+HollyName+" 입니다.";
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
				
				/////////////API 연동 전송////////////////
				
				String result,getCERTKEY;
			
				BaroService_SMSSoapProxy proxy = new BaroService_SMSSoapProxy();	
				CERTKEY certkey = new CERTKEY();
				
				getCERTKEY = certkey.getCERTKEY();
				
				//전송할 메세지 만들기	
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
 * 휴가결재 액션(팝업)
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

	//로그인 처리 
	String USERID = UserBroker.getUserId(request);
	String msg = "";
	int retVal =0;
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//로그인 처리 끝.
	
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
		msg = "결재가 완료되었습니다.";
		if(hollyDto.getState1().equals("Y") && hollyDto.getState2().equals("S")){
			
			
			hollyDto1 = hollyDao.SignUserSelect(hollyDto.getUserID());
			hollyDto3 = hollyDao.SignUserSelect(hollyDto.getSignID2());
			
			String Contents = "<휴에이션> "+hollyDto1.getUserName()+" 님이 휴가를 신청하였습니다. 휴웨어에서 결재 해주세요";
			/////////////API 연동 전송문자전송////////////////
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
		msg ="결재실패, 관리자에게 문의하세요";
	}
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "HollyDaySignPop action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return alertAndExit(model,msg,request.getContextPath()+"/H_Holly.do?cmd=leaveApplicant","back");
	}

/**
 * 반려사유 레이아웃 팝업
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

	//로그인 처리 
	String USERID = UserBroker.getUserId(request);
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//로그인 처리 끝.
	
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
 * 휴가결재 팝업
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

	//로그인 처리 
	String USERID = UserBroker.getUserId(request);
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//로그인 처리 끝.
	
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
 * 오늘의 휴가자 팝업
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

	//로그인 처리 
	String USERID = UserBroker.getUserId(request);
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//로그인 처리 끝.
	
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


/* 휴가신청 도움말
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
