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

import com.huation.common.BaseDAO;
import com.huation.framework.persist.DAOException;
import com.huation.framework.util.HtmlXSSFilter;
import com.huation.framework.util.SiteNavigation;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.util.InJectionFilter;
import com.huation.framework.Constants;
import com.huation.framework.util.StringUtil;
import com.huation.framework.struts.StrutsDispatchAction;

import com.huation.common.user.UserBroker;
import com.huation.common.util.CommonUtil;
import com.huation.common.user.UserMemDTO;
import com.huation.common.user.UserConnectDTO;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;

import com.huation.common.config.AuthDAO;
import com.huation.common.config.AuthDTO;
import com.huation.common.config.MenuDTO;
import com.huation.common.config.GroupDAO;
import com.huation.common.config.GroupDTO;

public class AuthAction extends StrutsDispatchAction{
	/**
	 * �޴����ٱ��� �������� �����´�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authManageList
	 * @throws Exception
	 */
	public ActionForward authManage(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "authManage action start");
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authManage action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("authManage");
	}
	/**
	 * GROUP�� ����� ����Ʈ�� �����´�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authGroupTree
	 * @throws Exception
	 */
	public ActionForward authGroupTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "authGroupTree action start");
		
		String userID = StringUtil.nvl(request.getParameter("UserID"),"");

		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		groupDto.setLogid(logid);
		groupDto.setUserID(userID);
		groupDto.setJobGb("GROUPUSER");
		
		ArrayList<GroupDTO> grouplist =groupDao.groupTreeList(groupDto);

		model.put("grouplist",grouplist);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authGroupTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("authGroupTree");
	}
	/**
	 * MENU ����Ʈ�� �����´�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authMenuTree
	 * @throws Exception
	 */
	public ActionForward authMenuTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "authMenuTree action start");
		
		String authGb = StringUtil.nvl(request.getParameter("authGb"),"");
		String authKey = StringUtil.nvl(request.getParameter("authKey"),"");
		String userid = StringUtil.nvl(request.getParameter("userid"),"");
		
		AuthDAO authDao = new AuthDAO();
		AuthDTO authDto = new AuthDTO();
		
		authDto.setAuthGb(authGb);
		authDto.setAuthKey(authKey);
		authDto.setLogid(logid);
		authDto.setUserID(userid);

		ArrayList<MenuDTO> menulist = authDao.authMenuTree(authDto);
		
		model.put("menulist",menulist);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authMenuTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("authMenuTree");
	}
	/**
	 * ����ں� ���� �޴� ����Ʈ�� �����´�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return authGroupTree
	 * @throws Exception
	 */
	public ActionForward userAuthMenuTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userAuthMenuTree action start");
		
		String userid = StringUtil.nvl(request.getParameter("userid"),"");
		String usernm = StringUtil.nvl(request.getParameter("usernm"),"");

		AuthDAO authDao = new AuthDAO();
		AuthDTO authDto = new AuthDTO();
		UserDAO userDao =new UserDAO();
		UserDTO userDto =new UserDTO();
		
		authDto.setLogid(logid);
		authDto.setUserID(userid);
		
		userDto.setLogid(logid);
		userDto.setID(userid);
		
		ArrayList<MenuDTO> menulist =authDao.authMenuTree(authDto);
		
		userDto = userDao.userView(userDto);
		
		model.put("menulist",menulist);
		model.put("userDto",userDto);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userAuthMenuTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("userAuthMenuTree");
	}
	public ActionForward authRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "authRegist action start");
		
//		�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		/*
			if(USERID.equals("")){
					String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
	//			�α��� ó�� ��.
*/
		
		int retVal=-1;
		int retVals =-1;
		String msg="";

		String[] users = request.getParameterValues("users");
		String[] menus = request.getParameterValues("menus");

		AuthDAO authDao = new AuthDAO();

		retVal =authDao.authDeletes(logid,USERID,users);// ���� ��ϳ����� ������� �����Ѵ�.
		
		if(retVal==-1){
			msg="�������!";
			return alertAndExit(model,msg,request.getContextPath()+"/H_Auth.do?cmd=authManage","");	
		}

		retVals = authDao.authRegists(logid,USERID,users,menus); //���ο� ���� ���

		if(retVals==-1){
			msg="�������!";
		}else if(retVals==0){
			msg="�������!";
		}else{
			msg="����Ϸ�!";
		}
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "authRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/H_Auth.do?cmd=authManage","");	
	
	}
}
