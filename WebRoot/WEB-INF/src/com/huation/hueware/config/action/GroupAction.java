package com.huation.hueware.config.action;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huation.framework.Constants;
import com.huation.framework.struts.StrutsDispatchAction;
import com.huation.framework.persist.DAOException;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.util.HtmlXSSFilter;
import com.huation.framework.util.SiteNavigation;
import com.huation.framework.util.InJectionFilter;
import com.huation.framework.util.StringUtil;

import com.huation.common.BaseDAO;
import com.huation.common.util.CommonUtil;
import com.huation.common.user.UserBroker;
import com.huation.common.user.UserMemDTO;
import com.huation.common.user.UserConnectDTO;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;
import com.huation.common.config.GroupDAO;
import com.huation.common.config.GroupDTO;

public class GroupAction extends StrutsDispatchAction{
	
	/**
	 * 그룹관리 페이지를 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupManage
	 * @throws Exception
	 */
	public ActionForward groupManage(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "groupManage action start");
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "groupManage action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("groupManage");
	}
	/**
	 * Group 리스트를 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupTreeList
	 * @throws Exception
	 */
	public ActionForward groupTreeList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "groupTreeList action start");
		
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
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "groupTreeList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("groupTreeList");
	}
	/**
	 * 그룹상세 페이지를 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupView
	 * @throws Exception
	 */
	public ActionForward groupView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "groupView action start");
		
		String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
		
		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		
		groupDto.setLogid(logid);
		groupDto.setGroupID(GroupID);
		
		groupDto=groupDao.groupView(groupDto);
		
		model.put("groupDto",groupDto);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "groupView action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("groupView");
	}
	/**
	 * 그룹을 추가 수정 삭제한다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupXML
	 * @throws Exception
	 */
	public ActionForward groupControl(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "groupControl action start");
		
		String manageGb = StringUtil.nvl(request.getParameter("manageGb"),"");
		String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
		String GroupName = StringUtil.nvl(request.getParameter("GroupName"),"");
		String faxNo = StringUtil.nvl(request.getParameter("FaxNo"),"");
		
		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		
		groupDto.setLogid(logid);
		groupDto.setGroupID(GroupID);
		groupDto.setGroupName(GroupName);
		groupDto.setFaxNo(faxNo);
		
		if(manageGb.equals("I")){
			
			groupDto=groupDao.groupInsert(groupDto);
			
		}else if(manageGb.equals("U")){
			
			groupDto=groupDao.groupUpdate(groupDto);
			
		}else if(manageGb.equals("D")){
			
			groupDto=groupDao.groupDelete(groupDto);
		}
		
		model.put("groupDto",groupDto);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "groupControl action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("groupXML");
	}
	/**
	 * 그룹 순서관리 페이지를 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupOrderList
	 * @throws Exception
	 */
	public ActionForward groupOrderList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "groupOrderList action start");
		
		String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
		int GroupStep = StringUtil.nvl(request.getParameter("GroupStep"),0);
		
		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		
		groupDto.setLogid(logid);
		groupDto.setGroupID(GroupID);
		groupDto.setGroupStep(GroupStep);
		groupDto.setJobGb("STEPLIST");
		
		ArrayList<GroupDTO> steplist =groupDao.groupTreeList(groupDto);
		
		model.put("steplist",steplist);
		model.put("GroupID",GroupID);
		model.put("GroupStep",""+GroupStep);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "groupOrderList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("groupOrderList");
	}
	/**
	 * 그룹의 순서를 정해준다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupOrderList
	 * @throws Exception
	 */
	public ActionForward groupOrderControl(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "groupOrderControl action start");
		
		String [] options = request.getParameterValues("common_select");
		String GroupID = StringUtil.nvl(request.getParameter("GroupID"),"");
		int GroupStep = StringUtil.nvl(request.getParameter("GroupStep"),0);
		int t_retVal=0;
		int retVal=0;

		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		
		groupDto.setLogid(logid);
		
		for(int j = 0; j < options.length; j++)
		{
			groupDto.setGroupSort(j);
			groupDto.setGroupID(options[j]);
			
			retVal=groupDao.groupOrderUpdate(groupDto);
			t_retVal=t_retVal+retVal;
		 }
		
		groupDto.setGroupID(GroupID);
		groupDto.setGroupStep(GroupStep);
		groupDto.setJobGb("STEPLIST");
		
		ArrayList<GroupDTO> steplist =groupDao.groupTreeList(groupDto);
		
		
		model.put("steplist",steplist);
		model.put("GroupID",GroupID);
		model.put("GroupStep",""+GroupStep);
		
		model.put("t_retVal",""+t_retVal);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "groupOrderControl action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("groupOrderList");
	}
	/**
	 * 그룹명을 체크한다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return groupXML
	 * @throws Exception
	 */
	public ActionForward groupNameDupCheck(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "groupNameDupCheck action start");
		
		String GroupName = StringUtil.nvl(request.getParameter("GroupName"),"");
		
		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();

		groupDto.setLogid(logid);
		groupDto.setGroupName(GroupName);

		groupDto=groupDao.groupNameDupCheck(groupDto);
		
		model.put("groupDto",groupDto);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "groupNameDupCheck action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("groupXML");
	}
}
