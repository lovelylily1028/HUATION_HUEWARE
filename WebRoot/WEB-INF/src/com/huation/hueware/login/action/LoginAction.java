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
import com.huation.common.util.EncryptUtil;
import com.huation.common.user.UserMemDTO;
import com.huation.common.user.UserConnectDTO;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;
import com.huation.common.BaseDAO;
import com.huation.common.BaseAction;

public class LoginAction extends StrutsDispatchAction{
		/**
		 * ������ �α��� ���� ������
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward loginForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			log.debug(" �α��� ��");

			return actionMapping.findForward("loginForm");
		}
		public ActionForward loginProcess(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			//�α��� ó�� 		
			boolean bLogin = BaseAction.isSession(request);			

			log.debug("��������"+bLogin);
				
			if(bLogin == true){		
				return actionMapping.findForward("loginProcess");
			}else{
				return actionMapping.findForward("loginForm");
			}
			
		}
		public ActionForward loginError(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			log.debug("������ �α��� ����");

			return actionMapping.findForward("loginError");
		}
		public ActionForward loginOut(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			log.debug("������ �α׾ƿ�");

			return actionMapping.findForward("loginOut");
		}
		public ActionForward adminMain(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			log.debug("������ ����������");

			return actionMapping.findForward("adminMain");
		}
		/**
		 * ������ �α��� ó��.
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
			// ȸ�� ������ �������� �Ǵ�.
			
			if(!"".equals(userInfo.getID())) { 
				
				// �н����尡 �´��� �Ǵ��Ѵ�.
				if(!encPasswd.equals(userInfo.getPassword())) {
					msg = "�н����尡 Ʋ�Ƚ��ϴ�.";
				} else {

					// ���ǿ� ���� 
					log.debug("���ǿ� ����");
					setUserInfoMem(request, userDao, userInfo);

					msg = "�α��� ����!!";
					log.debug(msg);
					isSuccess = true;
					
				}
			} else {
				msg = "�ش� �������� ID�� �������� �ʽ��ϴ�.";
				isSuccess = false;
			}
			log.debug("isSuccess:"+isSuccess);
			log.debug("msg:"+msg);
			request.setAttribute("msg", msg);
			
			//�α���ó���� �����ϸ� ���� �׼��� Common�� mainPage ��ã�ư���.
			if(isSuccess){
				return alertAndExit(model, "", request.getContextPath()
						+ "/B_Common.do?cmd=mainPage",
						 "back");
			} else { 
				return actionMapping.findForward("loginError");
			}
			
		}
		
		/**
		 * ���� ���� ����.
		 * @param request
		 * @param userdao
		 * @param userinfo
		 * @throws Exception
		 */
		private void setUserInfoMem(HttpServletRequest request, UserDAO userdao, UserDTO userinfo) throws Exception{    
			
			HttpSession session = request.getSession(false);    
			
			// ���� ������ ������ �ش�.   
			//session.setMaxInactiveInterval(60*30);
	        session.setAttribute(Constants.LOGIN_USERID, userinfo.getID());
	        session.setAttribute(Constants.LOGIN_PASSWD, userinfo.getPassword());
	        session.setAttribute(Constants.LOGIN_USERNAME,userinfo.getName());
	        // ȸ�� ������ ���Ӱ� �����Ѵ�.
			UserMemDTO newUserInfo =  new UserMemDTO();
			newUserInfo.setUserId(userinfo.getID());
			newUserInfo.setPasswd(userinfo.getPassword());
			newUserInfo.setUserNm(userinfo.getName());
			newUserInfo.setGroupnm(userinfo.getGroupName());
			newUserInfo.setPhone(userinfo.getOfficeTellNo());
			newUserInfo.setEmail(userinfo.getEmail());
			newUserInfo.setPosition(userinfo.getPosition());
			// ���ο� ȸ�� ������ �������ش�.
			session.setAttribute("USERINFO",newUserInfo);
		}
		/**
		 * �α׾ƿ�.
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
