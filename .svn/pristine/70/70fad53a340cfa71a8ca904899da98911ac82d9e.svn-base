package com.huation.hueware.code.action;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huation.common.BaseDAO;
import com.huation.common.CommonDAO;
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
import com.huation.common.util.DateSetter;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;
import com.huation.common.user.UserMemDTO;
import com.huation.common.user.UserConnectDTO;
import com.huation.common.code.CodeDAO;
import com.huation.common.code.CodeDTO;

public class CodeAction extends StrutsDispatchAction{
		
		/**
		 * 코드북 리스트
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward codePageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

			CodeDAO codeDao = new CodeDAO();
			CodeDTO codeDto = new CodeDTO();
			codeDto.setSearchGb(searchGb);
			codeDto.setSearchtxt(searchtxt);
			
			ListDTO ld = codeDao.getBigPageList(codeDto,curPageCnt, 10, 10);

			model.put("listInfo",ld);	
			
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("searchGb",searchGb);
			model.put("searchtxt",searchtxt);
			
			return actionMapping.findForward("codePageList");
		}
		/**
		 * 코드북 리스트
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward codeDetailList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			int listPage = StringUtil.nvl(request.getParameter("listPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			String sml_cd = StringUtil.nvl(request.getParameter("sml_cd"),"");

			CodeDAO codeDao = new CodeDAO();
			CodeDTO codeDto = new CodeDTO();
			codeDto.setSmlCd(sml_cd);

			ListDTO ld = codeDao.getSmlPageList(codeDto,curPageCnt, 10, 10);

			model.put("listInfo",ld);	
			
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("listPage",String.valueOf(listPage));
			model.put("searchGb",searchGb);
			model.put("searchtxt",searchtxt);
			model.put("sml_cd",sml_cd);
			
			return actionMapping.findForward("codeDetailList");
		}
		/**
		 * 코드북 등록폼
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward codeRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			String gubun = StringUtil.nvl(request.getParameter("gubun"),"");
			String sml_cd = StringUtil.nvl(request.getParameter("sml_cd"),"");

//			로그인 처리 
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
					String rtnUrl =  request.getContextPath()+"/B_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
//				로그인 처리 끝.
			
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("searchGb",searchGb);
			model.put("searchtxt",searchtxt);
			model.put("gubun",gubun);
			model.put("sml_cd",sml_cd);

			return actionMapping.findForward("codeRegistForm");
		}
		/**
		 * 코드북 등록
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward codeRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
//			로그인 처리 
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
					String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			// 로그인 처리 끝.
			
			String msg = "";
			int retVal = 0;
			
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);  
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			String gubun = StringUtil.nvl(request.getParameter("gubun"),"");
  	
			String big_cd= StringUtil.nvl(request.getParameter("big_cd"),"");    	
			String sml_cd= StringUtil.nvl(request.getParameter("sml_cd"),"");   
			String cd_nm= StringUtil.nvl(request.getParameter("cd_nm"),"");    
			String cd_desc= StringUtil.nvl(request.getParameter("cd_desc"),"");    
			
			CodeDAO codeDao = new CodeDAO();
			CodeDTO codeDto = new CodeDTO(); 
			
			codeDto.setBigCd(big_cd);
			codeDto.setSmlCd(sml_cd);
			codeDto.setCdNm(cd_nm);
			codeDto.setCdDesc(cd_desc);
			codeDto.setUseYn("Y");
			codeDto.setRegId(USERID);
			
			 retVal=codeDao.addCode(codeDto);

			 String cmdVal="";
			 
			 if(gubun.equals("BIG")){
				 cmdVal="codePageList";
			 }else{
				 cmdVal="codeDetailList&sml_cd="+sml_cd; 
			 }

			 msg = "코드 등록에 성공했습니다.";			
	        
			 if(retVal < 1) msg = "코드  등록에 실패하였습니다";

	        return alertAndExit(model,msg,request.getContextPath()+"/B_Code.do?cmd="+cmdVal+"&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	

		}
		/**
		 * 코드북 상세정보
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward codeView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			int curPageCnt = 0;
			String recruit_no = "";  //채용NO
			
			curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			String big_cd= StringUtil.nvl(request.getParameter("big_cd"),"");    	
			String sml_cd= StringUtil.nvl(request.getParameter("sml_cd"),"");  
			String gubun = StringUtil.nvl(request.getParameter("gubun"),"");
			
			CodeDAO codeDao = new CodeDAO();
			CodeDTO codeDto = new CodeDTO(); 
			
			codeDto = codeDao.getCodeInfo(big_cd,sml_cd); 
			
		    model.put("codeDto", codeDto);
		    
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("searchGb", searchGb);
			model.put("searchtxt", searchtxt);
			model.put("gubun",gubun);
			
			return actionMapping.findForward("codeView");
			
		}
		/**
		 * 코드북 수정한다.
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward codeEdit(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
				String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			String msg = "";
			int retVal = 0;
			int curPageCnt = 0;		
			curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

			String big_cd= StringUtil.nvl(request.getParameter("big_cd"),"");    	
			String sml_cd= StringUtil.nvl(request.getParameter("sml_cd"),"");   
			String cd_nm= StringUtil.nvl(request.getParameter("cd_nm"),"");    
			String cd_desc= StringUtil.nvl(request.getParameter("cd_desc"),"");   
			String gubun = StringUtil.nvl(request.getParameter("gubun"),"");
			
			CodeDAO codeDao = new CodeDAO();
			CodeDTO codeDto = new CodeDTO(); 
			
			codeDto.setBigCd(big_cd);
			codeDto.setSmlCd(sml_cd);
			codeDto.setCdNm(cd_nm);
			codeDto.setCdDesc(cd_desc);
			codeDto.setUseYn("Y");
			
			codeDto.setModId(USERID);
			
			retVal = codeDao.modifyCode(codeDto);

			model.put("curPage",String.valueOf(curPageCnt));
			
	       
	        if(retVal < 1){ 
	        	msg = "수정에 실패하였습니다";
	        	
	        }else{
	            msg = "수정에  성공하였습니다";
	        }
	        
			 String cmdVal="";
			 
			 if(gubun.equals("BIG")){
				 cmdVal="codePageList";
			 }else{
				 cmdVal="codeDetailList&sml_cd="+sml_cd; 
			 }
	        
	        return alertAndExit(model,msg,request.getContextPath()+"/B_Code.do?cmd="+cmdVal+"&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
			
		}
		/**
		 * 코드북  정보를 삭제한다.
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward codeDelete(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
				String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			String msg = "";
			boolean retVal = false;
			int curPageCnt = 0;		
			curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			String big_cd= StringUtil.nvl(request.getParameter("big_cd"),"");    	
			String sml_cd= StringUtil.nvl(request.getParameter("sml_cd"),"");  
			String gubun = StringUtil.nvl(request.getParameter("gubun"),"");
			
			CodeDAO codeDao = new CodeDAO();
			
			retVal=codeDao.delCode("",big_cd,sml_cd);
			
			 String cmdVal="";
			 
			 if(gubun.equals("BIG")){
				 cmdVal="codePageList";
			 }else{
				 cmdVal="codeDetailList&sml_cd="+sml_cd; 
			 }
			
	        msg = "삭제에  성공하였습니다";
	        if(retVal == false) msg = "삭제에 실패하였습니다";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_Code.do?cmd="+cmdVal+"&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");		
		}
		public ActionForward existCode(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
			
			String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
			String big_cd = StringUtil.nvl(request.getParameter("big_cd"),"");
			String sml_cd = StringUtil.nvl(request.getParameter("sml_cd"),"");
			int existyn=0;
	
			CodeDAO codeDao = new CodeDAO();
			
			existyn = codeDao.existCode(big_cd,sml_cd);
			
			model.put("existyn",""+existyn);	
			
			model.put("sForm",sForm);
			model.put("big_cd",big_cd);
			model.put("sml_cd",sml_cd);	
			 
	        return actionMapping.findForward("existCode"); 
		}
		/**
		 * 코드북 리스트
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward codePageExcelList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

			CodeDAO codeDao = new CodeDAO();
			CodeDTO codeDto = new CodeDTO();
			codeDto.setSearchGb(searchGb);
			codeDto.setSearchtxt(searchtxt);
			
			ListDTO ld = codeDao.getBigPageExcelList(codeDto, 10, 10);

			model.put("listInfo",ld);	
			
			//model.put("curPage",String.valueOf(curPageCnt));
			model.put("searchGb",searchGb);
			model.put("searchtxt",searchtxt);
			
			return actionMapping.findForward("codePageExcelList");
		}
}
