package com.huation.hueware.sms.action;

import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import sun.text.normalizer.Replaceable;

import com.baroservice.ws.BaroService_SMSSoapProxy;
import com.baroservice.ws.CERTKEY;
import com.baroservice.ws.SMSMessage;
import com.baroservice.ws.XMSMessage;

import com.huation.framework.logging.Log;
import com.huation.framework.logging.LogFactory;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.util.StringUtil;
import com.huation.framework.struts.StrutsDispatchAction;

import com.huation.common.config.GroupDAO;
import com.huation.common.config.GroupDTO;
import com.huation.common.config.SmsGroupDAO;
import com.huation.common.config.SmsGroupDTO;
import com.huation.common.freeboard.FreeBoardDAO;
import com.huation.common.freeboard.FreeBoardDTO;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;
import com.huation.common.user.UserBroker;
import com.huation.hueware.user.action.UserAction;

public class SmsAction extends StrutsDispatchAction{
	
	/**
	 * 문자 발송 페이지
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
   public ActionForward smsSend(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "smsSend action start");
	
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝.
		
		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		
		userDto.setLogid(logid);
		userDto.setID(USERID);
		
		userDto = userDao.userView(userDto);
	  
		model.put("userDto", userDto);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "smsSend action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("smsSend");
   	}
   /**
	 * 문자 발송
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
  public ActionForward smsSendSubmit(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "smsSendSubmit action start");
	
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 
		
		///예약시간///
		String reserveDT2 = StringUtil.nvl(request.getParameter("reserveDT"),"00").replaceAll("-", "");
		
		String stTime = StringUtil.nvl(request.getParameter("stTime"),"00");//조회시간
		String stMinute = StringUtil.nvl(request.getParameter("stMinute"),"00");
		
		
		String startTime = String.format("%02d", Integer.parseInt(stTime))+String.format("%02d", Integer.parseInt(stMinute))+"00";
		String reserveDT = "";
		////////////
		
		long todaytime;
        SimpleDateFormat day, time, militime;
        String Day, Time, Militime;
            
        todaytime = System.currentTimeMillis(); 
        day = new SimpleDateFormat("yyyyMMdd");
        time = new SimpleDateFormat("HHmmss");
          
        Day =  day.format(new Date(todaytime));
        Time = time.format(new Date(todaytime));

		
		///즉시/예약 전송여부//
		String cmChk = StringUtil.nvl(request.getParameter("cmChk"),"");
		if(cmChk.equals("2")){
			reserveDT = reserveDT2+startTime;
		}else{
			reserveDT = "";
		}
		////////////
		////문자 정보////
		String sendNum = StringUtil.nvl(request.getParameter("sendNum"),"00").replaceAll("-", "");
		System.out.println("====== : "+sendNum);
		String message = StringUtil.nvl(request.getParameter("message"),"");
		String[] phoneno = request.getParameterValues("phoneno");
		String[] username= request.getParameterValues("username");
		
		SmsGroupDAO smsgroupDao = new SmsGroupDAO();
		SmsGroupDTO smsgroupDto = new SmsGroupDTO();
		
		
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
		result = proxy.sendMessages(getCERTKEY,"1088193762","huation",arrxms.length,false,arrxms,reserveDT);
		//////////////////////////////////////////////////////////////
		
		
		/////휴웨어 디비값 넣기////
		
		int retval = 0;
		int retval2 = 0;
		String msg = "";
		smsgroupDto.setSendNum(sendNum);//보내는사람
		smsgroupDto.setMessage(message);
		smsgroupDto.setSendKey(result);
		smsgroupDto.setReserveCheck(cmChk);
		smsgroupDto.setRegID(USERID);
		
		if(cmChk.equals("2")){
		smsgroupDto.setSendStartTime(reserveDT);
		}else{
		smsgroupDto.setSendStartTime(Day+Time);	
		}
		retval=smsgroupDao.SmsSubmitRegist(smsgroupDto);
		retval2=smsgroupDao.smsReceiveRegist(result,phoneno,username);
		
		msg = "접수가 완료되었습니다.";
		
		
		System.out.println("result======================== :"+result);
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "smsSendSubmit action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/S_Sms.do?cmd=smsSendPageList","back");
  	}
   
   
   /**
	 * 문자전송내역 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
  public ActionForward smsSendPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "smsSendPageList action start");
	
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		
		Calendar cal = Calendar.getInstance ( );//오늘 날짜를 기준으루..
		cal.add ( cal.MONTH, -2 ); //2개월 전....
		String StartDate = Integer.toString(cal.get ( cal.YEAR ))+"-"+String.format("%02d", cal.get ( cal.MONTH ) + 1)+"-"+String.format("%02d",cal.get ( cal.DATE ));
		
		
		
		Calendar cals = Calendar.getInstance ( );//오늘 날짜를 기준으루..
		cals.add ( cals.MONTH, +1 ); //2개월 전....
		String EndDate = Integer.toString(cals.get ( cals.YEAR ))+"-"+String.format("%02d",cals.get ( cals.MONTH ) + 1)+"-"+String.format("%02d",cals.get ( cals.DATE ));
		
		
		
		String StartDT =  StringUtil.nvl(request.getParameter("StartDT"), StartDate);
		String EndDT =  StringUtil.nvl(request.getParameter("EndDT"), EndDate);
		
		SmsGroupDAO smsgroupDao = new SmsGroupDAO();
		SmsGroupDTO smsgroupDto = new SmsGroupDTO();

		// 리스트
		
		smsgroupDto.setSearchGb(searchGb);
		smsgroupDto.setSearchtxt(searchtxt);
		smsgroupDto.setnRow(5);
		smsgroupDto.setnPage(curPageCnt);
		smsgroupDto.setStartDT(StartDT);
		smsgroupDto.setEndDT(EndDT);
		smsgroupDto.setJobGb("PAGE");
		
		ListDTO ld = smsgroupDao.SmsPageList(smsgroupDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("StartDT", StartDT);
		model.put("EndDT", EndDT);
		model.put("searchtxt", searchtxt);
		
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "smsSendPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("smsSendPageList");
  	}
  
  
  /**
	 * 문자예약 내역 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
 public ActionForward smsReservePageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "smsReservePageList action start");
	
		//로그인 처리 
		String USERID = UserBroker.getUserId(request);
		
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//로그인 처리 끝. 
	  
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "smsReservePageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("smsReservePageList");
 	}
 
 /**
	 * SMS 주소록
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
public ActionForward smsAddList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "smsAddList action start");
		
		
	
		SmsGroupDAO smsgroupDao = new SmsGroupDAO();
		SmsGroupDTO smsgroupDto = new SmsGroupDTO();
		smsgroupDto.setLogID(logid);
		smsgroupDto.setJobGb("SUBAUTH");
		
		ArrayList<SmsGroupDTO> smsgrouplist = smsgroupDao.smsGroupTreeList(smsgroupDto);
		
		model.put("smsgrouplist",smsgrouplist);
		/*model.put("GroupStep",GroupStep);
		model.put("SelectType",SelectType);*/
		
		 
	  
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "smsAddList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("smsAddList");
	}

/**
 * SMS 주소록(사내직원)
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward smsAddList2(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "smsAddList2 action start");
	
	

	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setJobGb("SUBAUTH");
	
	ArrayList<SmsGroupDTO> smsgrouplist = smsgroupDao.smsGroupTreeList(smsgroupDto);
	
	model.put("smsgrouplist",smsgrouplist);
	/*model.put("GroupStep",GroupStep);
	model.put("SelectType",SelectType);*/
	
	 
  
    
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "smsAddList2 action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
  return actionMapping.findForward("smsAddList2");
}

/**
 * SMS AddList Ajax
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward ajaxSmsAddList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "ajaxSmsAddList action start");
	
	String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"S00001");
	
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setJobGb("SUBAUTH");
	smsgroupDto.setSmsGroupID(GroupID);
	
	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	
	ArrayList<SmsGroupDTO> smsList =smsgroupDao.smsUserList(smsgroupDto);
	
	model.put("smsList",smsList);
	model.put("selectGroupID", GroupID);
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "ajaxSmsAddList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
  return actionMapping.findForward("ajaxSmsAddList");
}



/**
 * SMS AddList Ajax
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward ajaxSmsGroupList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "ajaxSmsGroupList action start");
	

	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setJobGb("SUBAUTH");
	
	ArrayList<SmsGroupDTO> smsgrouplist = smsgroupDao.smsGroupTreeList(smsgroupDto);
	
	model.put("smsgrouplist",smsgrouplist);
	/*model.put("GroupStep",GroupStep);
	model.put("SelectType",SelectType);*/
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "ajaxSmsGroupList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
  return actionMapping.findForward("ajaxSmsGroupList");
}



/**
 * SMS AddList Ajax
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward ajaxSmsAddList2(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "ajaxSmsAddList2 action start");
	
	String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"G00001");
    System.out.println(GroupID);
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setJobGb("SUBAUTH");
	smsgroupDto.setSmsGroupID(GroupID);
	
	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	
	ArrayList<SmsGroupDTO> smsList =smsgroupDao.smsUserList2(smsgroupDto);
	
	model.put("smsList",smsList);
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "ajaxSmsAddList2 action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
  return actionMapping.findForward("ajaxSmsAddList2");
}

/**
 * SMS AddList Ajax
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward ajaxSmsGroupList2(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "ajaxSmsGroupList2 action start");
	
	
	
	//////
	String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"G00001");
	String GroupStep = StringUtil.nvl(request.getParameter("GroupStep"),"1");

	GroupDAO groupDao = new GroupDAO();
	GroupDTO groupDto = new GroupDTO();
	groupDto.setLogid(logid);
	groupDto.setGroupID(GroupID);
	groupDto.setJobGb("LIST");

	ArrayList<GroupDTO> grouplist = groupDao.groupTreeList(groupDto);
	
	model.put("grouplist",grouplist);
	model.put("GroupID",GroupID);
	model.put("GroupStep",GroupStep);
	//////
	/*model.put("GroupStep",GroupStep);
	model.put("SelectType",SelectType);*/
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "ajaxSmsGroupList2 action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
  return actionMapping.findForward("ajaxSmsGroupList2");
}

/**
 * SMS 주소록 등록
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward smsUserRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "smsUserRegist action start");
	
	int retVal =0;
	String msg="";
	
	String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"S00001");
	
	String phoneNo = StringUtil.nvl(request.getParameter("phoneNo"),"");
	String userName =  StringUtil.nvl(URLDecoder.decode(request.getParameter("userName"),"UTF-8"),"");
	String faxNo = StringUtil.nvl(request.getParameter("faxNo"),"");
	String Memo = StringUtil.nvl(URLDecoder.decode(request.getParameter("Memo"),"UTF-8"),"");
	String smsGroupID = StringUtil.nvl(request.getParameter("smsGroupID"),"");
	
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setJobGb("SUBAUTH");
	smsgroupDto.setSmsGroupID(GroupID);//조회 그룹
	smsgroupDto.setPhoneNumber(phoneNo);
	smsgroupDto.setUserName(userName);
	smsgroupDto.setMemo(Memo);
	smsgroupDto.setGroupID(smsGroupID);//등록할때 그룹
	
	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	
	retVal=smsgroupDao.smsUserRegist(smsgroupDto);
	
	String retVal2 = Integer.toString(retVal);
	ArrayList<SmsGroupDTO> smsList =smsgroupDao.smsUserList(smsgroupDto);
	
	
	model.put("smsList",smsList);
	model.put("retVal",retVal2);
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "smsUserRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return actionMapping.findForward("ajaxSmsAddList");
	}

/**
 * SMS 사용자 수정
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward smsUserModify(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "smsUserModify action start");
	
	int retVal =0;
	String msg="";
	
	String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"S00001");
	
	String phoneNo = StringUtil.nvl(request.getParameter("phoneNo"),"");
	String userName =  StringUtil.nvl(URLDecoder.decode(request.getParameter("userName"),"UTF-8"),"");
	String faxNo = StringUtil.nvl(request.getParameter("faxNo"),"");
	String Memo = StringUtil.nvl(URLDecoder.decode(request.getParameter("Memo"),"UTF-8"),"");
	String smsGroupID = StringUtil.nvl(request.getParameter("smsGroupID"),"");
	int index = StringUtil.nvl(request.getParameter("index"),0);
	
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setJobGb("SUBAUTH");
	smsgroupDto.setSmsGroupID(GroupID);//조회 그룹
	smsgroupDto.setPhoneNumber(phoneNo);
	smsgroupDto.setUserName(userName);
	smsgroupDto.setMemo(Memo);
	smsgroupDto.setGroupID(smsGroupID);//등록할때 그룹
	smsgroupDto.setIndex(index);
	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	
	retVal=smsgroupDao.smsUserModify(smsgroupDto);
	
	String retVal2 = Integer.toString(retVal);
	ArrayList<SmsGroupDTO> smsList =smsgroupDao.smsUserList(smsgroupDto);
	
	
	model.put("smsList",smsList);
	model.put("retVal2",retVal2);
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "smsUserModify action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return actionMapping.findForward("ajaxSmsAddList");
	}
/**
 * SMS 주소록 등록
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward smsGroupRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "smsGroupRegist action start");
	
	int retVal =0;
	String msg="";
	
	//ToDay String by YYYYMMDD
	DecimalFormat df = new DecimalFormat("00");	
	Calendar cal = Calendar.getInstance();	
	String MgtNum = "S"+Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE))+df.format(cal.getTimeInMillis());

	
	String NewGroupID = MgtNum;
	String NewGroupName = StringUtil.nvl(request.getParameter("NewGroupName"),"");
	
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setGroupID(NewGroupID);
	smsgroupDto.setGroupName(NewGroupName);
	smsgroupDto.setJobGb("SUBAUTH");
	
	
	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	
	retVal=smsgroupDao.smsGroupRegist(smsgroupDto);
	
	if(retVal==-1){
		msg="등록을 실패하였습니다.(-1)";
	}else if(retVal==0){
		msg="등록을 실패하였습니다.(0)";
	}else{
		msg="등록이 완료되었습니다.";
	}
	ArrayList<SmsGroupDTO> smsgrouplist = smsgroupDao.smsGroupTreeList(smsgroupDto);
	
	model.put("smsgrouplist",smsgrouplist);
	
	String returnUrl="/S_Sms.do?cmd=smsAddList";
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "smsGroupRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
		
	
	return alertAndExit(model, msg, request.getContextPath()+returnUrl,"");
	}
	
	
/**
 * SMS 주소록 등록
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
	
	String msg="";
	
	
	String phoneNo = StringUtil.nvl(request.getParameter("phoneNo"),"");
	
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setPhoneNumber(phoneNo);
	
	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	
	smsgroupDto = smsgroupDao.DupCheck(smsgroupDto);
	
	response.setContentType("text/html; charset=euc-kr");
	response.getWriter().print(smsgroupDto.getResult());
	
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "DupCheck action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return null;
	}

/**
 * SMS 주소록 등록
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward modifyDupCheck(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "modifyDupCheck action start");
	
	String msg="";
	int Result =0;
	
	String phoneNo = StringUtil.nvl(request.getParameter("phoneNo"),"");
	String oldPhoneNo = StringUtil.nvl(request.getParameter("oldPhoneNo"),"");
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setPhoneNumber(phoneNo);
	
	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	
	smsgroupDto = smsgroupDao.DupCheck(smsgroupDto);
	
	if(phoneNo.equals(oldPhoneNo)){
		Result=0;
	}else{
		Result=smsgroupDto.getResult();
	}
	
	response.setContentType("text/html; charset=euc-kr");
	response.getWriter().print(Result);
	
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "modifyDupCheck action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return null;
	}
/**
 * 그룹등록폼
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward GroupReg(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "GroupReg action start");
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "GroupReg action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return actionMapping.findForward("GroupReg");
	}

/**
 * 사용자 수정 폼
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward goModifyForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "goModifyForm action start");
	
	int index = StringUtil.nvl(request.getParameter("index"),0);
	
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setIndex(index);
	smsgroupDto.setJobGb("SUBAUTH");
	
	
	
	
	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	
	ArrayList<SmsGroupDTO> smsgrouplist = smsgroupDao.smsGroupTreeList(smsgroupDto);
	smsgroupDto = smsgroupDao.goModifyForm(smsgroupDto);
	
	model.put("smsgroupDto", smsgroupDto);
	model.put("smsgrouplist",smsgrouplist);
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "goModifyForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return actionMapping.findForward("goModifyForm");
	}
/**
 * SMS 주소록 등록 중복체크
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward smsGroupDupCheck(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "smsGroupDupCheck action start");
	
	String msg="";
	
	String NewGroupName =  StringUtil.nvl(URLDecoder.decode(request.getParameter("NewGroupName"),"UTF-8"),"");
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setGroupName(NewGroupName);
	
	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	
	smsgroupDto = smsgroupDao.smsGroupDupCheck(smsgroupDto);
	
	response.setContentType("text/html; charset=euc-kr");
	response.getWriter().print(smsgroupDto.getResult2());
	
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "smsGroupDupCheck action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return null;
	}

/**
 * SMS 유저 삭제(다건)
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */

public ActionForward userDelete(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "userDelete action start");
	
	String msg ="";
	String returnUrl ="";
	String[] devices = request.getParameterValues("seqs");
	
	for(int i=0; i<devices.length; i++ ){
		System.out.println("device :"+devices[i]);
	}
	
	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setJobGb("SUBAUTH");
	

	int retVal = smsgroupDao.deviceDeletes(logid,devices);
	ArrayList<SmsGroupDTO> smsgrouplist = smsgroupDao.smsGroupTreeList(smsgroupDto);
	
	if(retVal==-1){
		msg="삭제를 실패하였습니다. (-1)";
	}else if(retVal==0){
		msg="삭제를 실패하였습니다. (0)";
	}else{
		msg="삭제가 완료되었습니다.";
	}
	
		returnUrl="/S_Sms.do?cmd=smsAddList";
	
	
	model.put("smsgrouplist",smsgrouplist);
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "userDelete action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
	return alertAndExit(model, msg, request.getContextPath()+returnUrl,"");
	}


/**
 * 발송내역 상세보기
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward smsSendView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "smsSendView action start");

	//로그인 처리 
	String USERID = UserBroker.getUserId(request);
	
	if(USERID.equals("")){
		String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	//로그인 처리 끝. 
	
	String SendKey = StringUtil.nvl(request.getParameter("SendKey"),"");
	String sendDT = StringUtil.nvl(request.getParameter("sendDT"),"");
    
	System.out.println("sendDT : "+sendDT);
	model.put("SendKey",SendKey);
	model.put("sendDT",sendDT);
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "smsSendView action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
  return actionMapping.findForward("smsSendView");
	}


/**
 * SMS 그룹 삭제
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return userPageList
 * @throws Exception
 */
public ActionForward SmsGroupDelete(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

    //log action execute time start
	String logid=log.logid();
	long t1 = System.currentTimeMillis();
	log.trace(logid, "SmsGroupDelete action start");
	
	int retVal =0;
	String msg="";
	
	String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
	System.out.println("GroupID : "+GroupID);
	SmsGroupDTO smsgroupDto = new SmsGroupDTO();
	smsgroupDto.setLogID(logid);
	smsgroupDto.setGroupID(GroupID);
	smsgroupDto.setJobGb("SUBAUTH");
	
	
	SmsGroupDAO smsgroupDao = new SmsGroupDAO();
	
	retVal=smsgroupDao.smsGroupDelete(smsgroupDto);
	
	if(retVal==-1){
		msg="삭제를 실패하였습니다. (-1)";
	}else if(retVal==0){
		msg="삭제를 실패하였습니다. (0)";
	}else{
		msg="삭제가 완료되었습니다.";
	}
	
	ArrayList<SmsGroupDTO> smsgrouplist = smsgroupDao.smsGroupTreeList(smsgroupDto);
	
	model.put("smsgrouplist",smsgrouplist);
	
	
	
	String returnUrl="/S_Sms.do?cmd=smsAddList";
	
	//log action execute time end
	long t2 = System.currentTimeMillis();
	log.trace(logid, "SmsGroupDelete action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
	
		
	
	return alertAndExit(model, msg, request.getContextPath()+returnUrl,"");
	}


}
