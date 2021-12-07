package com.huation.hueware.recruit.action;

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
import com.huation.framework.util.MailUtil;
import com.huation.framework.util.StringUtil;
import com.huation.framework.util.FileUtil;
import com.huation.framework.util.UploadFile;
import com.huation.framework.util.UploadFiles;
import com.huation.framework.struts.StrutsDispatchAction;

import com.huation.common.user.UserBroker;
import com.huation.common.util.CommonUtil;
import com.huation.common.util.DateSetter;
import com.huation.common.user.UserMemDTO;
import com.huation.common.user.UserConnectDTO;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;

import com.huation.common.about.NewsDAO;
import com.huation.common.about.NewsDTO;
import com.huation.common.recruit.RecruitDAO;
import com.huation.common.recruit.RecruitDTO;
import com.huation.common.recruit.QnaDAO;
import com.huation.common.recruit.QnaDTO;
import com.huation.common.recruit.DefaultDAO;
import com.huation.common.recruit.DefaultDTO;
import com.huation.common.recruit.HistoryDAO;
import com.huation.common.recruit.HistoryDTO;
import com.huation.common.recruit.LicenseDAO;
import com.huation.common.recruit.LicenseDTO;
import com.huation.common.recruit.AwardDAO;
import com.huation.common.recruit.AwardDTO;
import com.huation.common.recruit.LangDAO;
import com.huation.common.recruit.LangDTO;
import com.huation.common.recruit.FamilyDAO;
import com.huation.common.recruit.FamilyDTO;
import com.huation.common.recruit.CareerDAO;
import com.huation.common.recruit.CareerDTO;
import com.huation.common.recruit.EduDAO;
import com.huation.common.recruit.EduDTO;
import com.huation.common.recruit.ActiveDAO;
import com.huation.common.recruit.ActiveDTO;
import com.huation.common.recruit.TrainDAO;
import com.huation.common.recruit.TrainDTO;
import com.huation.common.recruit.ProjectDAO;
import com.huation.common.recruit.ProjectDTO;
import com.huation.common.recruit.IntroDAO;
import com.huation.common.recruit.IntroDTO;

import com.huation.framework.configuration.Configuration;
import com.huation.framework.configuration.ConfigurationFactory;

public class RecruitAction extends StrutsDispatchAction{
	
	
	/**
	 * ä����� ����Ʈ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward recruitNotifyList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

		RecruitDAO recruitDao = new RecruitDAO();
		RecruitDTO recruitDto = new RecruitDTO();
		recruitDto.setSearchGb(searchGb);
		recruitDto.setSearchtxt(searchtxt);
		
		ListDTO ld = recruitDao.recruitPageList(recruitDto,curPageCnt, 10, 10);

		model.put("listInfo",ld);	
		
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);
		
		return actionMapping.findForward("recruitNotifyList");
	}
	/**
	 * ä����� �����
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward recruitNotifyRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

//		�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
//			�α��� ó�� ��.
		
		CommonDAO comDao = new CommonDAO();
		String curDate = comDao.getCurrentDate();
		DateSetter dateSetter1 = new DateSetter( "" , "99991231" );
		DateSetter dateSetter2 = new DateSetter( "" , "99991231" );
		
		model.put("dateSetter1", dateSetter1 );
		model.put("dateSetter2", dateSetter2 );
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);

		return actionMapping.findForward("recruitNotifyRegistForm");
	}
	/**
	 * ä����� ó��
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward recruitNotifyRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
//		�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
				String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		// �α��� ó�� ��.
		
		String msg = "";
		int retVal = 0;
		
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);  
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		
		String recruit_no="";    	
		String subject= StringUtil.nvl(request.getParameter("subject"),"");    	
		String contents= StringUtil.nvl(request.getParameter("contents"),"");   
		String recruit_type= StringUtil.nvl(request.getParameter("recruit_type"),"");    
		String recruit_field= StringUtil.nvl(request.getParameter("recruit_field"),"");    
		String career= StringUtil.nvl(request.getParameter("career"),"");    
		String recruit_start= StringUtil.nvl(request.getParameter("recruit_start"),"");    
		String recruit_end= StringUtil.nvl(request.getParameter("recruit_end"),"");    
	
		RecruitDAO recruitDao = new RecruitDAO();
		RecruitDTO recruitDto = new RecruitDTO(); 
		
		recruit_no=recruitDao.getRecruitNo(recruitDao.getRecruitCntNext());
		
		recruitDto.setRecruit_no(recruit_no);
		recruitDto.setSubject(subject);
		recruitDto.setContents(contents);
		recruitDto.setRecruit_type(recruit_type);
		recruitDto.setRecruit_field(recruit_field);
		recruitDto.setCareer(career);
		recruitDto.setRecruit_start(recruit_start);
		recruitDto.setRecruit_end(recruit_end);
		recruitDto.setReg_id(USERID);
		
		 retVal=recruitDao.addRecruit(recruitDto);

		 msg = "ä����� ��Ͽ� �����߽��ϴ�.";			
	        if(retVal < 1) msg = "ä�����  ��Ͽ� �����Ͽ����ϴ�";

	        return alertAndExit(model,msg,request.getContextPath()+"/B_Recruit.do?cmd=recruitNotifyList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	

	}
	/**
	 * ä����� ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward recruitNotifyView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String recruit_no = "";  //ä��NO
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		recruit_no = StringUtil.nvl(request.getParameter("recruit_no"));
		
		RecruitDAO recruitDao = new RecruitDAO();
		RecruitDTO recruitDto = new RecruitDTO(); 
		
		recruitDto = recruitDao.getRecruitView(recruit_no); 

		DateSetter dateSetter1 = new DateSetter( recruitDto.getRecruit_start() , "99991231" );
		DateSetter dateSetter2 = new DateSetter( recruitDto.getRecruit_end() , "99991231", "s1" );
		
		model.put("dateSetter1", dateSetter1 );
		model.put("dateSetter2", dateSetter2 );
		
	    model.put("compDto", recruitDto);
	    
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("recruitNotifyView");
		
	}
	/**
	 *  ä����� �����Ѵ�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward recruitNotifyEdit(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
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

		String recruit_no = StringUtil.nvl(request.getParameter("recruit_no"));
		String subject= StringUtil.nvl(request.getParameter("subject"),""); 
		String contents= StringUtil.nvl(request.getParameter("contents"),"");  
		String recruit_type= StringUtil.nvl(request.getParameter("recruit_type"),"");    
		String recruit_field= StringUtil.nvl(request.getParameter("recruit_field"),"");    
		String career= StringUtil.nvl(request.getParameter("career"),"");    
		String recruit_start= StringUtil.nvl(request.getParameter("recruit_start"),"");    
		String recruit_end= StringUtil.nvl(request.getParameter("recruit_end"),"");    
	
		RecruitDAO recruitDao = new RecruitDAO();
		RecruitDTO recruitDto = new RecruitDTO(); 
		
		recruitDto.setRecruit_no(recruit_no);
		recruitDto.setSubject(subject);
		recruitDto.setContents(contents);
		recruitDto.setRecruit_type(recruit_type);
		recruitDto.setRecruit_field(recruit_field);
		recruitDto.setCareer(career);
		recruitDto.setRecruit_start(recruit_start);
		recruitDto.setRecruit_end(recruit_end);
		recruitDto.setMod_id(USERID);
		
		retVal = recruitDao.editRecruit(recruitDto);

		model.put("curPage",String.valueOf(curPageCnt));
		
       
        if(retVal < 1){ 
        	msg = "������ �����Ͽ����ϴ�";
        	
        }else{
            msg = "������  �����Ͽ����ϴ�";
        }
        
        return alertAndExit(model,msg,request.getContextPath()+"/B_Recruit.do?cmd=recruitNotifyList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
		
	}
	/**
	 * ä�����  ������ �����Ѵ�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward recruitNotifyDelete(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
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
		String recruit_no = StringUtil.nvl(request.getParameter("recruit_no"));
		
		RecruitDAO recruitDao = new RecruitDAO();
		RecruitDTO recruitDto = new RecruitDTO(); 
		
		recruitDto.setRecruit_no(recruit_no);
		recruitDto.setMod_id(USERID);
		
		
		retVal = recruitDao.deleteRecruitOne(recruitDto);
		
        msg = "������  �����Ͽ����ϴ�";
        if(retVal < 1) msg = "������ �����Ͽ����ϴ�";
        
        return alertAndExit(model, msg,request.getContextPath()+"/B_Recruit.do?cmd=recruitNotifyList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");		
	}
////////////////////////////////////////////////////////////////////////////////ä������ �κ� START//////////////////////////////////////////////////////////////////////////////
	/**
	 * ä����� ����Ʈ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward recruitManageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

		DefaultDAO defaultDao = new DefaultDAO();
		DefaultDTO defaultDto = new DefaultDTO();
		defaultDto.setSearchGb(searchGb);
		defaultDto.setSearchtxt(searchtxt);
		
		ListDTO ld = defaultDao.defaultPageList(defaultDto,curPageCnt, 10, 10);

		model.put("listInfo",ld);	
		
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);
		
		return actionMapping.findForward("recruitManageList");
	}
	/**
	 * ä����� ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward recruitManageView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));
		
		DefaultDAO defaultDao = new DefaultDAO();
		HistoryDAO historyDao = new HistoryDAO();
		LicenseDAO licenseDao = new LicenseDAO();
		AwardDAO awardDao = new AwardDAO();
		LangDAO langDao = new LangDAO();
		FamilyDAO familyDao = new FamilyDAO();
		CareerDAO careerDao = new CareerDAO();
		EduDAO eduDao = new EduDAO();
		ActiveDAO activeDao = new ActiveDAO();
		TrainDAO trainDao = new TrainDAO();
		ProjectDAO projectDao = new ProjectDAO();
		IntroDAO introDao = new IntroDAO();
		
		DefaultDTO defaultDto = new DefaultDTO();
		IntroDTO introDto = new IntroDTO();
		
		defaultDto.setApply_code(apply_code);
		
		defaultDto = defaultDao.defaultView(defaultDto); 	
		ArrayList<HistoryDTO> historyList=historyDao.historyListView(apply_code);
		ArrayList<LicenseDAO> licenseList=licenseDao.historyListView(apply_code);
		ArrayList<AwardDAO> awardList=awardDao.historyListView(apply_code);
		ArrayList<LangDAO> langList=langDao.historyListView(apply_code);
		ArrayList<FamilyDAO> familyList=familyDao.historyListView(apply_code);
		ArrayList<CareerDAO> careerList=careerDao.historyListView(apply_code);
		ArrayList<EduDAO> eduList=eduDao.historyListView(apply_code);
		ArrayList<ActiveDAO> activeList=activeDao.historyListView(apply_code);
		ArrayList<TrainDAO> trainList=trainDao.historyListView(apply_code);
		ArrayList<ProjectDAO> projectList=projectDao.historyListView(apply_code);
		introDto=introDao.introView(apply_code);
		
	    model.put("defaultDto", defaultDto);
	    model.put("historyList", historyList);
	    model.put("licenseList", licenseList);
	    model.put("awardList", awardList);
	    model.put("langList", langList);
	    model.put("familyList", familyList);
	    model.put("careerList", careerList);
	    model.put("eduList", eduList);
	    model.put("activeList", activeList);
	    model.put("trainList", trainList);
	    model.put("projectList", projectList);
	    model.put("introDto", introDto);
	    
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("recruitManageView");
		
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageDefaultView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));
		System.out.println("test:"+apply_code);
		DefaultDAO defaultDao = new DefaultDAO();
		DefaultDTO defaultDto = new DefaultDTO();
		
		defaultDto.setApply_code(apply_code);
		
		defaultDto = defaultDao.defaultView(defaultDto); 	
		
	    model.put("defaultDto", defaultDto);
	     
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageDefaultView");
		
	}
	/**
	 * ���� ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward photoForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		String photo=StringUtil.nvl(request.getParameter("photo"),"");
		
		model.put("fileNm", photo );		
		
		return actionMapping.findForward("photoForm");
	}
	/**
	 * top���� ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward photo(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		String photo=StringUtil.nvl(request.getParameter("photo"),"");
		
		model.put("fileNm", photo );		
		
		return actionMapping.findForward("photo");
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageHistoryView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));

		ArrayList<HistoryDTO> arrlist=null;
		HistoryDAO historyDao = new HistoryDAO();
		
		arrlist=historyDao.historyListView(apply_code);
		
		model.put("apply_code",apply_code);	
		model.put("historyList",arrlist);	
	     
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageHistoryView");
		
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageLicenseView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));

		ArrayList<LicenseDTO> arrlist=null;
		LicenseDAO licenseDao = new LicenseDAO();
		
		arrlist=licenseDao.historyListView(apply_code);
		
		model.put("apply_code",apply_code);	
		model.put("historyList",arrlist);	
	     
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageLicenseView");
		
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageAwardView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));

		ArrayList<AwardDTO> arrlist=null;
		AwardDAO awardDao = new AwardDAO();
		
		arrlist=awardDao.historyListView(apply_code);
		
		model.put("apply_code",apply_code);	
		model.put("historyList",arrlist);	
	     
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageAwardView");
		
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageLangView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));

		ArrayList<LangDTO> arrlist=null;
		LangDAO langDao = new LangDAO();
		
		arrlist=langDao.historyListView(apply_code);
		
		model.put("apply_code",apply_code);	
		model.put("historyList",arrlist);	
	     
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageLangView");
		
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageFamilyView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));

		ArrayList<FamilyDTO> arrlist=null;
		FamilyDAO familyDao = new FamilyDAO();
		
		arrlist=familyDao.historyListView(apply_code);
		
		model.put("apply_code",apply_code);	
		model.put("historyList",arrlist);	
	     
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageFamilyView");
		
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageCareerView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));

		ArrayList<CareerDTO> arrlist=null;
		CareerDAO careerDao = new CareerDAO();
		
		arrlist=careerDao.historyListView(apply_code);
		
		model.put("apply_code",apply_code);	
		model.put("historyList",arrlist);	
	     
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageCareerView");
		
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageEduView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));

		ArrayList<EduDTO> arrlist=null;
		EduDAO eduDao = new EduDAO();
		
		arrlist=eduDao.historyListView(apply_code);
		
		model.put("apply_code",apply_code);	
		model.put("historyList",arrlist);	
	     
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageEduView");
		
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageActiveView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));

		ArrayList<ActiveDTO> arrlist=null;
		ActiveDAO activeDao = new ActiveDAO();
		
		arrlist=activeDao.historyListView(apply_code);
		
		model.put("apply_code",apply_code);	
		model.put("historyList",arrlist);	
	     
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageActiveView");
		
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageTrainView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));

		ArrayList<TrainDTO> arrlist=null;
		TrainDAO trainDao = new TrainDAO();
		
		arrlist=trainDao.historyListView(apply_code);
		
		model.put("apply_code",apply_code);	
		model.put("historyList",arrlist);	
	     
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageTrainView");
		
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageProjectView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));

		ArrayList<ProjectDTO> arrlist=null;
		ProjectDAO projectDao = new ProjectDAO();
		
		arrlist=projectDao.historyListView(apply_code);
		
		model.put("apply_code",apply_code);	
		model.put("historyList",arrlist);	
	     
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageProjectView");
		
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageItroView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));

		IntroDAO introDao = new IntroDAO();
		IntroDTO introDto = new IntroDTO();
		
		introDto=introDao.introView(apply_code);
		
		model.put("apply_code",apply_code);	
		model.put("introDto",introDto);	
	     
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageItroView");
		
	}
	/**
	 * ä����� 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward manageLastView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));

		DefaultDAO defaultDao = new DefaultDAO();
		DefaultDTO defaultDto = new DefaultDTO();
		defaultDto.setApply_code(apply_code);
		defaultDto = defaultDao.registResult(defaultDto);
		
		model.put("apply_code", apply_code );
		model.put("defaultDto",defaultDto);	

		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("manageLastView");
		
	}
	/**
	 *  ä������ ������� ������Ʈ �Ѵ�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward recruitUpdate(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
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

		String apply_code = StringUtil.nvl(request.getParameter("apply_code"));
		String result_state= StringUtil.nvl(request.getParameter("result_state"),"");  
	
		DefaultDAO defaultDao = new DefaultDAO();
		DefaultDTO defaultDto = new DefaultDTO(); 
		
		defaultDto.setApply_code(apply_code);
		defaultDto.setResult_state(result_state);
		defaultDto.setMod_id(USERID);

		retVal = defaultDao.updateApply(defaultDto);

		model.put("curPage",String.valueOf(curPageCnt));
		
       
        if(retVal < 1){ 
        	msg = "������ �����Ͽ����ϴ�";
        	
        }else{
            msg = "������  �����Ͽ����ϴ�";
        }
        
        return alertAndExit(model,msg,request.getContextPath()+"/B_Recruit.do?cmd=recruitManageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
		
	}
	////////////////////////////////////////////////////////////////////////////////ä������ �κ� END//////////////////////////////////////////////////////////////////////////////
	/**
	 * ä�빮�� ����Ʈ(�����ϴ�����)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward recruitQnAList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String qna_gb=StringUtil.nvl(request.getParameter("qna_gb"),"01");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

		QnaDAO qnaDao = new QnaDAO();
		QnaDTO qnaDto = new QnaDTO();
		
		qnaDto.setQna_gb(qna_gb);
		qnaDto.setSearchGb(searchGb);
		qnaDto.setSearchtxt(searchtxt);
		
		ListDTO ld = qnaDao.recruitQnAList(qnaDto,curPageCnt, 10, 10);

		model.put("listInfo",ld);	
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		if(qna_gb.equals("01")){
			return actionMapping.findForward("recruitQnAList");
		}else{
			return actionMapping.findForward("recruitDirectList");
		}
	}
	/**
	 * ä�빮��(�����ϴ�����) �����
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward qnaRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

//		�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
//			�α��� ó�� ��.
		
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);

		return actionMapping.findForward("qnaRegistForm");
	}
	/**
	 * ä�빮��(�����ϴ�����) ó��
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward qnaRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
//		�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
				String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		// �α��� ó�� ��.
		
		String msg = "";
		int retVal = 0;
		
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);  
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		
		String qna_no="";    	
		String question= StringUtil.nvl(request.getParameter("question"),"");    	
		String answer= StringUtil.nvl(request.getParameter("answer"),"");    	
	
		QnaDAO qnaDao = new QnaDAO();
		QnaDTO qnaDto = new QnaDTO(); 
		
		qna_no=qnaDao.getQnaNo(qnaDao.getRecruitCntNext());
		
		qnaDto.setQna_no(qna_no);
		qnaDto.setQna_gb("01");
		qnaDto.setQuestion(question);
		qnaDto.setAnswer(answer);
		qnaDto.setReg_id(USERID);
		
		 retVal=qnaDao.qnaRegist(qnaDto);

		 msg = "���� ��Ͽ� �����߽��ϴ�.";			
	        if(retVal < 1) msg = "����  ��Ͽ� �����Ͽ����ϴ�";

	        return alertAndExit(model,msg,request.getContextPath()+"/B_Recruit.do?cmd=recruitQnAList&qna_gb=01&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	

	}
	/**
	 *  ä�빮��(�����ϴ�����) ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward qnaView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String qna_no = "";  //����NO
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		qna_no = StringUtil.nvl(request.getParameter("qna_no"));
		
		QnaDAO qnaDao = new QnaDAO();
		QnaDTO qnaDto = new QnaDTO(); 
		
		qnaDto = qnaDao.getQnaView(qna_no); 	
		
	    model.put("compDto", qnaDto);
	    
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("qnaView");
		
	}
	/**
	 *  ä�빮��(�����ϴ�����) �����Ѵ�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward qnaEdit(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
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

		String qna_no = StringUtil.nvl(request.getParameter("qna_no"));
		String answer= StringUtil.nvl(request.getParameter("answer"),""); 
		String email= StringUtil.nvl(request.getParameter("email"),"");  
		String subject =StringUtil.nvl(request.getParameter("subject"),"");  
		String question =StringUtil.nvl(request.getParameter("question"),"");  
	
		QnaDAO qnaDao = new QnaDAO();
		QnaDTO qnaDto = new QnaDTO(); 
		
		qnaDto.setQna_no(qna_no);
		qnaDto.setQna_gb("02");
		qnaDto.setAnswer(answer);
		qnaDto.setMod_id(USERID);
		qnaDto.setQuestion(question);

		retVal = qnaDao.editQna(qnaDto);

		model.put("curPage",String.valueOf(curPageCnt));
		
       
        if(retVal < 1){ 
        	msg = "�亯�� �����Ͽ����ϴ�";
        	
        }else{
            msg = "�亯��  �����Ͽ����ϴ�";
        	MailUtil.sendBaseMail(email, "["+email+"](��)" , "[Re]"+subject,answer+"<br>----------------------------------------------------------<br>"+question  );
        }
        
        return alertAndExit(model,msg,request.getContextPath()+"/B_Recruit.do?cmd=recruitQnAList&qna_gb=01&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
		
	}
	/**
	 * ä�빮��(�����ϴ�����)  ������ �����Ѵ�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward qnaDelete(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
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
		String qna_no = StringUtil.nvl(request.getParameter("qna_no"),"");
		
		QnaDAO qnaDao = new QnaDAO();
		QnaDTO qnaDto = new QnaDTO(); 
		
		qnaDto.setQna_no(qna_no);
		
		qnaDto.setMod_id(USERID);
		qnaDto.setQna_no(qna_no);
		
		
		retVal = qnaDao.deleteQnaOne(qnaDto);
		
        msg = "������  �����Ͽ����ϴ�";
        if(retVal < 1) msg = "������ �����Ͽ����ϴ�";
        
        return alertAndExit(model, msg,request.getContextPath()+"/B_Recruit.do?cmd=recruitQnAList&qna_gb=01&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");		
	}
	/**
	 *  ä�빮��(1:1����) ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward qnaDirectView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String qna_no = "";  //����NO
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		qna_no = StringUtil.nvl(request.getParameter("qna_no"));
		
		QnaDAO qnaDao = new QnaDAO();
		QnaDTO qnaDto = new QnaDTO(); 
		
		qnaDto = qnaDao.getQnaView(qna_no); 	
		
	    model.put("compDto", qnaDto);
	    
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("qnaDirectView");
		
	}
	/**
	 *  ä�빮��(1:1����) �亯�Ѵ�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward qnaAnswer(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
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

		String qna_no = StringUtil.nvl(request.getParameter("qna_no"));
		String question= StringUtil.nvl(request.getParameter("question"),"");    	
		String answer= StringUtil.nvl(request.getParameter("answer"),"");    	
				
		QnaDAO qnaDao = new QnaDAO();
		QnaDTO qnaDto = new QnaDTO(); 
		
		qnaDto.setQna_no(qna_no);
		qnaDto.setQna_gb("02");
		qnaDto.setQuestion(question);
		qnaDto.setAnswer(answer);
		qnaDto.setMod_id(USERID);

		retVal = qnaDao.editQna(qnaDto);

		model.put("curPage",String.valueOf(curPageCnt));
		
        msg = "�亯��  �����Ͽ����ϴ�";
        if(retVal < 1) msg = "�亯�� �����Ͽ����ϴ�";
        
        return alertAndExit(model,msg,request.getContextPath()+"/B_Recruit.do?cmd=recruitQnAList&qna_gb=02&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
		
	}
	
	/**
	 * ä����� �μ��ϱ�
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward managePrint(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		int curPageCnt = 0;
		String apply_code = "";  //�����ڵ�
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		apply_code = StringUtil.nvl(request.getParameter("apply_code"));
		log.debug("Print Page Move [managePrint Action] Get Param ä����� �ڵ�:"+apply_code);
	
		//Step1.�Ϲ���������,�⺻��������
		DefaultDAO defaultDao = new DefaultDAO();
		DefaultDTO defaultDto = new DefaultDTO();
		
		defaultDto.setApply_code(apply_code);
		defaultDto = defaultDao.defaultView(defaultDto); 	
		
		//Step2.�з»���
		ArrayList<HistoryDTO> arrlist=null;
		HistoryDAO historyDao = new HistoryDAO();
		arrlist=historyDao.historyListView(apply_code);
		
		//Step3.�ڰ�/�������
		ArrayList<LicenseDTO> arrlist2=null;
		LicenseDAO licenseDao = new LicenseDAO();
		arrlist2=licenseDao.historyListView(apply_code);
		
		//Step4. �������
		ArrayList<AwardDTO> arrlist3=null;
		AwardDAO awardDao = new AwardDAO();
		arrlist3=awardDao.historyListView(apply_code);
		
		//Step5. ���л���
		ArrayList<LangDTO> arrlist4=null;
		LangDAO langDao = new LangDAO();
		arrlist4=langDao.historyListView(apply_code);
		
		//Step6. ��������
		ArrayList<FamilyDTO> arrlist5=null;
		FamilyDAO familyDao = new FamilyDAO();
		arrlist5=familyDao.historyListView(apply_code);
		
		//Step7. ��»���
		ArrayList<CareerDTO> arrlist6=null;
		CareerDAO careerDao = new CareerDAO();
		arrlist6=careerDao.historyListView(apply_code);
		
		//Step8.��������
		ArrayList<EduDTO> arrlist7=null;
		EduDAO eduDao = new EduDAO();
		arrlist7=eduDao.historyListView(apply_code);
		
		//Step9. ��ȸ���� �� �⿩
		ArrayList<ActiveDTO> arrlist8=null;
		ActiveDAO activeDao = new ActiveDAO();
		arrlist8=activeDao.historyListView(apply_code);
		
		//Step10. �ؿܿ��� �� ����
		ArrayList<TrainDTO> arrlist9=null;
		TrainDAO trainDao = new TrainDAO();
		arrlist9=trainDao.historyListView(apply_code);
		
		//Step11. ������Ʈ ������
		ArrayList<ProjectDTO> arrlist10=null;
		ProjectDAO projectDao = new ProjectDAO();
		arrlist10=projectDao.historyListView(apply_code);
		
		//Step12. �ڱ�Ұ�
		IntroDAO introDao = new IntroDAO();
		IntroDTO introDto = new IntroDTO();
		introDto=introDao.introView(apply_code);
		
		
		//���� ä����� �ڵ�.
		model.put("apply_code",apply_code);	
		
		//Step1
		model.put("defaultDto", defaultDto);
		//Step2
		model.put("historyList",arrlist);
		//Step3
		model.put("licenseList",arrlist2);
		//Step4
		model.put("awardList",arrlist3);
		//Step5
		model.put("langList",arrlist4);
		//Step6
		model.put("familyList",arrlist5);
		//Step7
		model.put("careerList",arrlist6);
		//Step8
		model.put("eduList",arrlist7);
		//Step9
		model.put("activeList",arrlist8);
		//Step10
		model.put("trainList",arrlist9);
		//Step11
		model.put("projectList",arrlist10);	
		//Step12
		model.put("introDto",introDto);	
		
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("managePrint");
	}
	
}
