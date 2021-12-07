package com.huation.hueware.login.action;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

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
import com.huation.common.BaseDAO;
import com.huation.common.BaseAction;

public class LoginAction extends StrutsDispatchAction{
		/**
		 * 관리자 로그인 관련 페이지
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward loginForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			log.debug(" 로그인 폼");

			return actionMapping.findForward("loginForm");
		}
		public ActionForward loginProcess(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			//로그인 처리 		
			boolean bLogin = BaseAction.isSession(request);			

			log.debug("세션정보"+bLogin);
				
			if(bLogin == true){		
				return actionMapping.findForward("loginProcess");
			}else{
				return actionMapping.findForward("loginForm");
			}
			
		}
		public ActionForward loginError(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			log.debug("관리자 로그인 에러");

			return actionMapping.findForward("loginError");
		}
		public ActionForward loginOut(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			log.debug("관리자 로그아웃");

			return actionMapping.findForward("loginOut");
		}
		public ActionForward adminMain(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			log.debug("관리자 메인페이지");

			return actionMapping.findForward("adminMain");
		}
		/**
		 * 관리자 로그인 처리.
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward setLogin(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			String userId = StringUtil.nvl(request.getParameter("userId"),"");
			String passWd = StringUtil.nvl(request.getParameter("passWd"),"");
			String rtnUrl = StringUtil.nvl(request.getParameter("rtnUrl"),"");
				
			boolean isSuccess = false;
			
			UserDAO userDao = new UserDAO();
			UserDTO userDto =new UserDTO();
			
			userDto.setID(userId);

			UserDTO userInfo = userDao.userView(userDto);
			String msg = null;
			
			String encPasswd =userDao.setPasswdEncode(passWd);
			
			log.debug("encPasswd["+encPasswd+"]userInfo.getPasswd()["+userInfo.getPassword()+"]");
			// 회원 존재의 존재유무 판단.
			
			
			if(!"".equals(userInfo.getID())) { 
				
				// 패스워드가 맞는지 판단한다.
				if(!encPasswd.equals(userInfo.getPassword())) {
					msg = "패스워드가 틀렸습니다.";
				} else {

					// 세션에 셋팅 
					log.debug("세션에 셋팅");
					setUserInfoMem(request, userDao, userInfo);

					msg = "로그인 성공!!";
					log.debug(msg);
					isSuccess = true;
					
				}
			} else {
				msg = "해당 관리자의 ID가 존재하지 않습니다.";
				isSuccess = false;
			}
			log.debug("isSuccess:"+isSuccess);
			log.debug("msg:"+msg);
			request.setAttribute("msg", msg);
			
			//로그인처리가 성공하면 공통 액션인 Common에 mainPage 를찾아간다.
			if(isSuccess){
				return alertAndExit(model, "", request.getContextPath()
						+ "/B_Common.do?cmd=mainPage",
						 "back");
			} else { 
				return actionMapping.findForward("loginError");
			}
			
		}
		/**
		 * 세션 정보 셋팅.
		 * @param request
		 * @param userdao
		 * @param userinfo
		 * @throws Exception
		 */
		private void setUserInfoMem(HttpServletRequest request, UserDAO userdao, UserDTO userinfo) throws Exception{    
			
			HttpSession session = request.getSession(false);    
			
			// 세션 정보를 셋팅해 준다.   
			//session.setMaxInactiveInterval(60*30);
	        session.setAttribute(Constants.LOGIN_USERID, userinfo.getID());
	        session.setAttribute(Constants.LOGIN_PASSWD, userinfo.getPassword());
	        session.setAttribute(Constants.LOGIN_USERNAME,userinfo.getName());
	        // 회원 정보를 새롭게 생성한다.
			UserMemDTO newUserInfo =  new UserMemDTO();
			newUserInfo.setUserId(userinfo.getID());
			newUserInfo.setPasswd(userinfo.getPassword());
			newUserInfo.setUserNm(userinfo.getName());
			newUserInfo.setGroupnm(userinfo.getGroupName());
			newUserInfo.setPhone(userinfo.getOfficeTellNo());
			newUserInfo.setEmail(userinfo.getEmail());
			newUserInfo.setPosition(userinfo.getPosition());
			// 새로운 회원 정보를 셋팅해준다.
			session.setAttribute("USERINFO",newUserInfo);
		}
		/**
		 * 로그아웃.
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param httpServletResponse
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward loginOff(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
			
			HttpSession session = request.getSession(false);
	        session.removeAttribute("USERINFO");
	        session.invalidate();	
       
	        return actionMapping.findForward("loginOut");

	    }
}
