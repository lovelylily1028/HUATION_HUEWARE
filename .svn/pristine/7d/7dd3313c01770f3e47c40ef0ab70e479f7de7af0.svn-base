package com.huation.hueware.about.action;

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

import com.oreilly.servlet.MultipartRequest;

import com.huation.common.BaseDAO;
import com.huation.common.CommonDAO;
import com.huation.framework.persist.DAOException;
import com.huation.framework.util.HtmlXSSFilter;
import com.huation.framework.util.SiteNavigation;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.util.InJectionFilter;
import com.huation.framework.Constants;
import com.huation.framework.util.StringUtil;
import com.huation.framework.util.FileUtil;
import com.huation.framework.util.UploadFile;
import com.huation.framework.util.UploadFiles;
import com.huation.framework.struts.StrutsDispatchAction;

import com.huation.common.user.UserBroker;
import com.huation.common.util.CommonUtil;
import com.huation.common.util.DateSetter;
import com.huation.common.util.DateUtil;
import com.huation.common.user.UserMemDTO;
import com.huation.common.user.UserConnectDTO;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;

import com.huation.common.about.NotifyDAO;
import com.huation.common.about.NotifyDTO;
import com.huation.common.about.NewsDAO;
import com.huation.common.about.NewsDTO;

public class AboutAction extends StrutsDispatchAction{
	
	/**
	 * 공지사항 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward notifyPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

		NotifyDAO nofityDao = new NotifyDAO();
		NotifyDTO nofityDto = new NotifyDTO();
		nofityDto.setSearchGb(searchGb);
		nofityDto.setSearchtxt(searchtxt);
		
		ListDTO ld = nofityDao.notifyPageList(nofityDto,curPageCnt, 10, 10);

		model.put("listInfo",ld);	
		
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);
		
		return actionMapping.findForward("notifyPageList");
	}
	/**
	 * 공지사항 등록폼
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward notifyRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

//		로그인 처리 
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
//			로그인 처리 끝.
		
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);

		return actionMapping.findForward("notifyRegistForm");
	}
	/**
	 * 공지사항 등록처리
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward notifyRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
//		로그인 처리 
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
		
		String notify_no="";    	
		String subject= StringUtil.nvl(request.getParameter("subject"),"");    	
		String contents= StringUtil.nvl(request.getParameter("contents"),"");    	
	
		NotifyDAO notifyDao = new NotifyDAO();
		NotifyDTO notifyDto = new NotifyDTO(); 
		
		notify_no=notifyDao.getNofityNo(notifyDao.getNotifyCntNext());
		
		notifyDto.setNotify_no(notify_no);
		notifyDto.setSubject(subject);
		notifyDto.setContents(contents);
		notifyDto.setReg_id(USERID);
		
		 retVal=notifyDao.addNotify(notifyDto);

		 msg = "공지사항 등록에 성공했습니다.";			
	        if(retVal < 1) msg = "공지사항  등록에 실패하였습니다";

	        return alertAndExit(model,msg,request.getContextPath()+"/B_About.do?cmd=notifyPageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	

	}
	/**
	 * 공지사항 상세정보
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward notifyView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String notify_no = "";  //공지NO
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		notify_no = StringUtil.nvl(request.getParameter("notify_no"));
		
		NotifyDAO notifyDao = new NotifyDAO();
		NotifyDTO notifyDto = new NotifyDTO(); 
		
		notifyDto = notifyDao.getNotifyView(notify_no ); 	
		
	    model.put("compDto", notifyDto);
	    
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("notifyView");
		
	}
	/**
	 * 공지사항을 수정한다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward notityEdit(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
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

		String notify_no = StringUtil.nvl(request.getParameter("notify_no"));
		String subject= StringUtil.nvl(request.getParameter("subject"),"");    	
		String contents= StringUtil.nvl(request.getParameter("contents"),"");    	
				
		NotifyDAO notifyDao = new NotifyDAO();
		NotifyDTO notifyDto = new NotifyDTO(); 
		
		notifyDto.setNotify_no(notify_no);
		notifyDto.setSubject(subject);
		notifyDto.setContents(contents);
		notifyDto.setMod_id(USERID);

		retVal = notifyDao.editNotify(notifyDto);

		model.put("curPage",String.valueOf(curPageCnt));
		
        msg = "수정에  성공하였습니다";
        if(retVal < 1) msg = "수정에 실패하였습니다";
        
        return alertAndExit(model,msg,request.getContextPath()+"/B_About.do?cmd=notifyPageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
		
	}
	/**
	 * 공지사항 정보를 삭제한다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward notifyDelete(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
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
		String notify_no = StringUtil.nvl(request.getParameter("notify_no"),"");
		
		NotifyDAO notifyDao = new NotifyDAO();
		NotifyDTO notifyDto = new NotifyDTO(); 
		
		notifyDto.setMod_id(USERID);
		notifyDto.setNotify_no(notify_no);
		
		retVal = notifyDao.deleteNotifyOne(notifyDto);
		
        msg = "삭제에  성공하였습니다";
        if(retVal < 1) msg = "삭제에 실패하였습니다";
        
        return alertAndExit(model, msg,request.getContextPath()+"/B_About.do?cmd=notifyPageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");		
	}
	/**
	 * 뉴스 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward newsPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

		NewsDAO newsDao = new NewsDAO();
		NewsDTO newsDto = new NewsDTO();
		newsDto.setSearchGb(searchGb);
		newsDto.setSearchtxt(searchtxt);
		
		ListDTO ld = newsDao.newsPageList(newsDto,curPageCnt, 10, 10);

		model.put("listInfo",ld);	

		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);
		
		return actionMapping.findForward("newsPageList");
	}
	/**
	 * 뉴스 등록폼
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward newsRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

//		로그인 처리 
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
//			로그인 처리 끝.
		
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);

		return actionMapping.findForward("newsRegistForm");
	}
	/**
	 * 뉴스등록처리
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward newsRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
//		로그인 처리 
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
		
		String news_no="";    	
		String subject= StringUtil.nvl(request.getParameter("subject"),"");    	
		String contents= StringUtil.nvl(request.getParameter("contents"),"");    	
	
		NewsDAO newsyDao = new NewsDAO();
		NewsDTO newsDto = new NewsDTO(); 
		
		news_no=newsyDao.getNewsNo(newsyDao.getNewsCntNext());
		
		newsDto.setNews_no(news_no);
		newsDto.setSubject(subject);
		newsDto.setContents(contents);
		newsDto.setReg_id(USERID);
		
		 retVal=newsyDao.addNews(newsDto);

		 msg = "뉴스 등록에 성공했습니다.";			
	        if(retVal < 1) msg = "뉴스  등록에 실패하였습니다";

	        return alertAndExit(model,msg,request.getContextPath()+"/B_About.do?cmd=newsPageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	

	}
	/**
	 * 뉴스 상세정보
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward newsView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String news_no = "";  //뉴스NO
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		news_no = StringUtil.nvl(request.getParameter("news_no"));
		
		NewsDAO notifyDao = new NewsDAO();
		NewsDTO newsDto = new NewsDTO(); 
		
		newsDto = notifyDao.getNewsView(news_no ); 	
		
	    model.put("compDto", newsDto);
	    
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("newsView");
		
	}
	/**
	 * 뉴스를 수정한다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward newsEdit(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
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

		String news_no = StringUtil.nvl(request.getParameter("news_no"));
		String subject= StringUtil.nvl(request.getParameter("subject"),"");    	
		String contents= StringUtil.nvl(request.getParameter("contents"),"");    	
				
		NewsDAO newsDao = new NewsDAO();
		NewsDTO newsDto = new NewsDTO(); 
		
		newsDto.setNews_no(news_no);
		newsDto.setSubject(subject);
		newsDto.setContents(contents);
		newsDto.setMod_id(USERID);

		retVal = newsDao.editNews(newsDto);

		model.put("curPage",String.valueOf(curPageCnt));
		
        msg = "수정에  성공하였습니다";
        if(retVal < 1) msg = "수정에 실패하였습니다";
        
        return alertAndExit(model,msg,request.getContextPath()+"/B_About.do?cmd=newsPageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
		
	}
	/**
	 * 뉴스 정보를 삭제한다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward newsDelete(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
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
		String news_no = StringUtil.nvl(request.getParameter("news_no"),"");
		
		NewsDAO newsDao = new NewsDAO();
		NewsDTO newsDto = new NewsDTO(); 
		
		newsDto.setMod_id(USERID);
		newsDto.setNews_no(news_no);
		
		retVal = newsDao.deleteNewsOne(newsDto);
		
        msg = "삭제에  성공하였습니다";
        if(retVal < 1) msg = "삭제에 실패하였습니다";
        
        return alertAndExit(model, msg,request.getContextPath()+"/B_About.do?cmd=newsPageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");		
	}
}
