package com.huation.hueware.project.action;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huation.common.CommonDAO;
import com.huation.common.project.NonProjectDAO;
import com.huation.common.project.NonProjectDTO;
import com.huation.common.user.UserBroker;
import com.huation.common.util.DateSetter;
import com.huation.common.util.DateUtil;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.struts.StrutsDispatchAction;
import com.huation.framework.util.DateTimeUtil;
import com.huation.framework.util.FileUtil;
import com.huation.framework.util.StringUtil;
import com.huation.framework.util.UploadFile;
import com.huation.framework.util.UploadFiles;
import com.oreilly.servlet.MultipartRequest;

public class NonProjectAction extends StrutsDispatchAction {

	/**
	 * ���������� �����
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectRegistForm_Non(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		log.debug("��ü���");

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");

		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		// �α��� ó�� ��.
		
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * ������������ : A, �������� : P 
		 */
		String listType = StringUtil.nvl(request.getParameter("listType"), "P");
		
		Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	    cal.add(Calendar.DATE, -1);
	    /*  cal.add(Calendar.MONTH, 2);*/
	     
	    // Ư�� ������ ��¥�� ���� �̱� 
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    String strDate = df.format(cal.getTime());
	    System.err.println(strDate);
		
		
		

		CommonDAO comDao = new CommonDAO();
		String curDate = comDao.getCurrentDate();
		DateSetter dateSetter = new DateSetter(DateUtil.getDayInterval2(-1).replaceAll("-",""), "99991231");
		DateSetter dateSetter2 = new DateSetter(DateUtil.getDayInterval2(-1).replaceAll("-",""), "99991231", "s2");

		model.put("curDate", curDate);
		model.put("dateSetter", dateSetter);
		model.put("dateSetter2", dateSetter2);
		
		model.put("strDate", strDate);

		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("sForm", sForm);
		model.put("listType", listType);
		
		return actionMapping.findForward("projectRegistForm_Non");
	}

	/**
	 * ���������� ���ó��
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectRegist_Non(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		// �α��� ó�� ��.

		int retVal = 0;
		String msg = "";

		
		
		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "upload/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				10);
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String ReportFile = "";

		if (status.equals("E")) {
			log.debug("÷�� ���� �ø����� �����Ͽ����ϴ�.");
			msg = "÷�� ���� �ø����� �����Ͽ����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("O")) {
			log.debug("÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.");
			msg = "÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.�ִ� 10M ���� �����մϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("I")) {
			log.debug("÷�� ������ ������ �߸��Ǿ����ϴ�.");
			msg = "÷�� ������ ������ �߸��Ǿ����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("S")) {
			// ���ε�� ������ ������ �����ͼ� ������ ���̽��� �ִ� �۾��� ���ش�.
			log.debug("÷�� ������ ÷���ϴµ� �����Ͽ����ϴ�.");
			ArrayList files = uploadEntity.getFiles();
			UploadFile file = null;
			for (int i = 0; i < files.size(); i++) {
				file = (UploadFile) files.get(i);
				objName = file.getObjName();
				rFileName = StringUtil.nvl(file.getRootName());
				if (!rFileName.equals("")) {
					log.debug("++++++++++++++++ ObjName = " + file.getObjName());
					log.debug("++++++++++++++++ FileName = "
							+ file.getRootName());
					log.debug("++++++++++++++++ path = "
							+ uploadEntity.getUploadPath());

					sFileName = file.getUploadName();
					fileSize = String.valueOf(file.getSize());
					filePath = uploadEntity.getUploadPath();
					uploadFilePath = filePath + sFileName;

					log.debug("���� ������Ʈ��[" + objName + "]�����ϸ�[" + rFileName
							+ "]�������ϸ�[" + sFileName + "]���ϻ�����[" + fileSize
							+ "]���������н�[" + filePath + "]���ε� ���["
							+ uploadFilePath + "]");

					if (objName.equals("ReportFile")) {
						ReportFile = uploadFilePath;
					}
				}
			}
		}
		 

		
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		searchGb = StringUtil
				.nvl(multipartRequest.getParameter("searchGb"), "");
		searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),
				"");
		// sForm= StringUtil.nvl(multipartRequest.getParameter("sForm"),"N");

		String CompanyCode = StringUtil.nvl(
				multipartRequest.getParameter("CompanyCode"), "");
		String CheckReason = StringUtil.nvl(
				multipartRequest.getParameter("CheckReason"), "");
		String StartDateTime = StringUtil.nvl(
				multipartRequest.getParameter("StartDateTime"), "");
		String EndDateTime = StringUtil.nvl(
				multipartRequest.getParameter("EndDateTime"), "");
		String ChargeID = StringUtil.nvl(
				multipartRequest.getParameter("ChargeID"), "");
		String RequestNm = StringUtil.nvl(
				multipartRequest.getParameter("RequestNm"), "");
		String WorkSite = StringUtil.nvl(
				multipartRequest.getParameter("WorkSite"), "");
		String WorkContents = StringUtil.nvl(
				multipartRequest.getParameter("WorkContents"), "");
		String IssueReport = StringUtil.nvl(
				multipartRequest.getParameter("IssueReport"), "");
		String chUserID = StringUtil.nvl(
				multipartRequest.getParameter("chUserID"), "");
		String FileNm = StringUtil.nvl(
				multipartRequest.getParameter("FileNm"), "");
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * ������������ : A, �������� : P 
		 */
		String listType = StringUtil.nvl(multipartRequest.getParameter("listType"), "P");
		
		NonProjectDAO npjDao = new NonProjectDAO();
		NonProjectDTO npjDto = new NonProjectDTO();

		npjDto.setCompanyCode(CompanyCode);
		npjDto.setCheckReason(CheckReason);
		npjDto.setStartDateTime(StartDateTime);
		npjDto.setEndDateTime(EndDateTime);
		npjDto.setChargeID(ChargeID);
		npjDto.setRequestNm(RequestNm);
		npjDto.setWorkSite(WorkSite);
		npjDto.setWorkContents(WorkContents);
		npjDto.setIssueReport(IssueReport);
		npjDto.setReportFile(ReportFile);
		npjDto.setChUserID(USERID);
		npjDto.setFileNm(FileNm);
		retVal = npjDao.addProject_Non(npjDto);

		msg = "���������� ����Ʈ ��Ͽ�  �����Ͽ����ϴ�";
	    if(retVal < 1) msg = "���������� ����Ʈ ��Ͽ� �����Ͽ����ϴ�";
	    
	    String returnPage = "";
	    if ("P".equals(listType)) {
	    	returnPage = "/N_Project.do?cmd=projectPageList_Non&curPage="+curPageCnt+"&searchGb="+searchGb;
	    } else {
	    	returnPage = "/N_Project.do?cmd=projectPageListNonAll&curPage="+curPageCnt+"&searchGb="+searchGb;
	    }
	    
	    return alertAndExit(model, msg,request.getContextPath()+returnPage,"back");
//	        return alertAndExit(model, msg,request.getContextPath()+"/N_Project.do?cmd=projectPageList_Non&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
	}

	/**
	 * ���������� ���� ����Ʈ
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward projectPageList_Non(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
		String CompanyCode = StringUtil.nvl(request.getParameter("CompanyCode"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String FrDate = StringUtil.nvl(request.getParameter("FrDate"),DateUtil.getDayInterval2(-31));
		String ToDate = StringUtil.nvl(request.getParameter("ToDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
		 */
		
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * �������������� : A, ���������� : P 
		 */
		String listType = StringUtil.nvl(request.getParameter("listType"), "P");
		
		NonProjectDAO npjDao = new NonProjectDAO();
		NonProjectDTO npjDto = new NonProjectDTO();

		// ����Ʈ
		
		npjDto.setChUserID(USERID);
		npjDto.setvSearchType(searchGb);
		npjDto.setvSearch(searchtxt);
		npjDto.setnRow(20);
		npjDto.setnPage(curPageCnt);
		npjDto.setFrDate(FrDate);
		npjDto.setToDate(ToDate);
		npjDto.setCompanyCode(CompanyCode);
		npjDto.setListType(listType);
		
		ListDTO ld = npjDao.ProjectPageList_Non(npjDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("FrDate", FrDate);
		model.put("ToDate", ToDate);
		model.put("CompanyCode", CompanyCode);
		model.put("listType", listType);
		
		return actionMapping.findForward("projectPageList_Non");
	}

	/**
	 * ���������� ���� ����Ʈ(����)
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward projectPageListNonAll(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		String CompanyCode = StringUtil.nvl(
				request.getParameter("CompanyCode"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String FrDate = StringUtil.nvl(request.getParameter("FrDate"),DateUtil.getDayInterval2(-31));
		String ToDate = StringUtil.nvl(request.getParameter("ToDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
		 */
		
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * �������������� : A, ���������� : P 
		 */
		String listType = StringUtil.nvl(request.getParameter("listType"), "A");
		
		NonProjectDAO npjDao = new NonProjectDAO();
		NonProjectDTO npjDto = new NonProjectDTO();

		// ����Ʈ
		
		npjDto.setChUserID(USERID);
		npjDto.setvSearchType(searchGb);
		npjDto.setvSearch(searchtxt);
		npjDto.setnRow(20);
		npjDto.setnPage(curPageCnt);
		npjDto.setFrDate(FrDate);
		npjDto.setToDate(ToDate);
		npjDto.setCompanyCode(CompanyCode);
		npjDto.setListType(listType);
		
		ListDTO ld = npjDao.ProjectPageListNonAll(npjDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("FrDate", FrDate);
		model.put("ToDate", ToDate);
		model.put("CompanyCode", CompanyCode);
		model.put("listType", listType);
		
		return actionMapping.findForward("projectPageListNonAll");
	}
	
	/**
	 * ���������� ���� ����Ʈ
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward projectPageList_Non2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
		 */
		MultipartRequest multipartRequest = null;
		
		String FilePath = FileUtil.FILE_DIR + "upload/";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				10);
		multipartRequest = uploadEntity.getMultipart();

		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil.nvl(multipartRequest.getParameter("searchtxt"), "");
		String CompanyCode = StringUtil.nvl(multipartRequest.getParameter("CompanyCode"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);
		String FrDate = StringUtil.nvl(multipartRequest.getParameter("FrDate"),DateUtil.getDayInterval2(-31));
		String ToDate = StringUtil.nvl(multipartRequest.getParameter("ToDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
				
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * �������������� : A, ���������� : P 
		 */
		String listType = StringUtil.nvl(multipartRequest.getParameter("listType"), "P");
		
		NonProjectDAO npjDao = new NonProjectDAO();
		NonProjectDTO npjDto = new NonProjectDTO();

		// ����Ʈ
		npjDto.setChUserID(USERID);
		npjDto.setvSearchType(searchGb);
		npjDto.setvSearch(searchtxt);
		npjDto.setnRow(20);
		npjDto.setnPage(curPageCnt);
		npjDto.setFrDate(FrDate);
		npjDto.setToDate(ToDate);
		npjDto.setCompanyCode(CompanyCode);
		npjDto.setListType(listType);
		
		ListDTO ld = new ListDTO();
		String returnPage = "";
		
		if ("P".equals(listType)) {
			ld = npjDao.ProjectPageList_Non(npjDto);
			returnPage = "projectPageList_Non";
		} else {
			ld = npjDao.ProjectPageListNonAll(npjDto);
			returnPage = "projectPageListNonAll";
		}
		
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("FrDate", FrDate);
		model.put("ToDate", ToDate);
		model.put("CompanyCode", CompanyCode);
		model.put("listType", listType);
		
		return actionMapping.findForward(returnPage);
	}
	
	/**
	 * ���������� ����(����Ʈ)������
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectView_Non(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");
		int Seq = StringUtil.nvl(request.getParameter("Seq"), 1);
		String CompanyCode = StringUtil.nvl(
				request.getParameter("CompanyCode"), "");
		String FrDate = StringUtil.nvl(request.getParameter("FrDate"),DateUtil.getDayInterval2(-2));
		String ToDate = StringUtil.nvl(request.getParameter("ToDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		log.debug("compan2:"+CompanyCode);
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
		 */
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * ������������ : A, �������� : P 
		 */
		String listType = StringUtil.nvl(request.getParameter("listType"), "P");
		
		NonProjectDAO npjDao = new NonProjectDAO();
		NonProjectDTO npjDto = new NonProjectDTO();
		
		npjDto.setSeq(Seq);
		npjDto.setCompanyCode(CompanyCode);
		npjDto = npjDao.projectView_Non(npjDto);
		log.debug("compan2:"+CompanyCode);
		DateSetter dateSetter = new DateSetter(npjDto.getStartDate(), "99991231");
		DateSetter dateSetter2 = new DateSetter(npjDto.getEndDate(), "99991231",
				"s2");
		
		//������� ���ư� ��� �ش� �˻��Ⱓ�� �����ϱ� ���ذ˻������� ���ڸ� ������ �ش�. 
		npjDto.setFrDate(FrDate);
		npjDto.setToDate(ToDate);
		
		model.put("npjDto", npjDto);
		model.put("dateSetter", dateSetter);
		model.put("dateSetter2", dateSetter2);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("sForm", sForm);
		model.put("listType", listType);
		
//		if (npjDto == null) {
		if (npjDto.getCreateDateTime() == null) {
			String msg = "���� ����Ʈ  ������ �����ϴ�.";
			
//			return alertAndExit(model, msg, request.getContextPath()
//					+ "/N_Project_H.do?cmd=projectPageList_Non_H&curPage=" + curPageCnt
//					+ "&searchGb=" + searchGb, "back");
			
			String returnPage = "";
			if ("P".equals(listType)) {
				returnPage = "/N_Project.do?cmd=projectPageList_Non&curPage=" + curPageCnt
						+ "&searchGb=" + searchGb + "&StartDateTime=" + request.getParameter("FrDate") + "&EndDateTime=" + request.getParameter("ToDate");
			} else {
				returnPage = "/N_Project.do?cmd=projectPageListNonAll&curPage=" + curPageCnt
						+ "&searchGb=" + searchGb + "&StartDateTime=" + request.getParameter("FrDate") + "&EndDateTime=" + request.getParameter("ToDate");
			}
			return alertAndExit(model, msg, request.getContextPath() + returnPage, "back");
		} else {
			return actionMapping.findForward("projectView_Non");
		}
	}

	/**
	 * ���������� ����
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectEdit_Non(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		// �α��� ó�� ��.

		int retVal = 0;
		String msg = "";
		
		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "upload/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				10);
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String ReportFile = "";

		if (status.equals("E")) {
			log.debug("÷�� ���� �ø����� �����Ͽ����ϴ�.");
			msg = "÷�� ���� �ø����� �����Ͽ����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("O")) {
			log.debug("÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.");
			msg = "÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.�ִ� 10M ���� �����մϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("I")) {
			log.debug("÷�� ������ ������ �߸��Ǿ����ϴ�.");
			msg = "÷�� ������ ������ �߸��Ǿ����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("S")) {
			// ���ε�� ������ ������ �����ͼ� ������ ���̽��� �ִ� �۾��� ���ش�.
			log.debug("÷�� ������ ÷���ϴµ� �����Ͽ����ϴ�.");
			ArrayList files = uploadEntity.getFiles();
			UploadFile file = null;
			for (int i = 0; i < files.size(); i++) {
				file = (UploadFile) files.get(i);
				objName = file.getObjName();
				rFileName = StringUtil.nvl(file.getRootName());
				if (!rFileName.equals("")) {
					log.debug("++++++++++++++++ ObjName = " + file.getObjName());
					log.debug("++++++++++++++++ FileName = "
							+ file.getRootName());
					log.debug("++++++++++++++++ path = "
							+ uploadEntity.getUploadPath());

					sFileName = file.getUploadName();
					fileSize = String.valueOf(file.getSize());
					filePath = uploadEntity.getUploadPath();
					uploadFilePath = filePath + sFileName;

					log.debug("���� ������Ʈ��[" + objName + "]�����ϸ�[" + rFileName
							+ "]�������ϸ�[" + sFileName + "]���ϻ�����[" + fileSize
							+ "]���������н�[" + filePath + "]���ε� ���["
							+ uploadFilePath + "]");

					if (objName.equals("ReportFile")) {
						ReportFile = uploadFilePath;
					}
				}
			}
		}
		 
		
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		searchGb = StringUtil
				.nvl(multipartRequest.getParameter("searchGb"), "");
		// sForm= StringUtil.nvl(multipartRequest.getParameter("sForm"),"N");

		int Seq = StringUtil.nvl(multipartRequest.getParameter("Seq"), 1);
		String CompanyCode = StringUtil.nvl(
				multipartRequest.getParameter("CompanyCode"), "");
		String CheckReason = StringUtil.nvl(
				multipartRequest.getParameter("CheckReason"), "");
		String StartDateTime = StringUtil.nvl(
				multipartRequest.getParameter("StartDateTime"), "");
		String EndDateTime = StringUtil.nvl(
				multipartRequest.getParameter("EndDateTime"), "");
		String ChargeID = StringUtil.nvl(
				multipartRequest.getParameter("ChargeID"), "");
		String RequestNm = StringUtil.nvl(
				multipartRequest.getParameter("RequestNm"), "");
		String WorkSite = StringUtil.nvl(
				multipartRequest.getParameter("WorkSite"), "");
		String WorkContents = StringUtil.nvl(
				multipartRequest.getParameter("WorkContents"), "");
		String IssueReport = StringUtil.nvl(
				multipartRequest.getParameter("IssueReport"), "");
		String FileNm = StringUtil.nvl(
				multipartRequest.getParameter("FileNm"), "");
		String chUserID = StringUtil.nvl(
				multipartRequest.getParameter("chUserID"), "");
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * ������������ : A, �������� : P 
		 */
		String listType = StringUtil.nvl(multipartRequest.getParameter("listType"), "P");
		
		NonProjectDAO npjDao = new NonProjectDAO();
		NonProjectDTO npjDto = new NonProjectDTO();

		npjDto.setSeq(Seq);
		npjDto.setCompanyCode(CompanyCode);
		npjDto.setCheckReason(CheckReason);
		npjDto.setStartDateTime(StartDateTime);
		npjDto.setEndDateTime(EndDateTime);
		npjDto.setChargeID(ChargeID);
		npjDto.setRequestNm(RequestNm);
		npjDto.setWorkSite(WorkSite);
		npjDto.setWorkContents(WorkContents);
		npjDto.setIssueReport(IssueReport);
		npjDto.setReportFile(ReportFile);
		npjDto.setFileNm(FileNm);
		npjDto.setChUserID(USERID);
		
		retVal = npjDao.editProject_Non(npjDto);

		msg = " ����Ʈ ���� �Ϸ��߽��ϴ�. ";

		if (retVal < 1) {
			msg = "����Ʈ ���� �����߽��ϴ�.";
		}

		model.put("curPage", String.valueOf(curPageCnt));

		String returnPage = "";
	    if ("P".equals(listType)) {
	    	returnPage = "/N_Project.do?cmd=projectPageList_Non&curPage=" + curPageCnt	+ "&searchGb=" + searchGb + "&Seq=" + Seq +"&StartDateTime=" + StartDateTime + "&EndDateTime=" + EndDateTime;
	    } else {
	    	returnPage = "/N_Project.do?cmd=projectPageListNonAll&curPage=" + curPageCnt	+ "&searchGb=" + searchGb + "&Seq=" + Seq +"&StartDateTime=" + StartDateTime + "&EndDateTime=" + EndDateTime;
	    }
	    
	    return alertAndExit(model, msg, request.getContextPath() + returnPage, "back");
	    
//		return alertAndExit(model, msg, request.getContextPath()
//				+ "/N_Project.do?cmd=projectPageList_Non&curPage=" + curPageCnt
//				+ "&searchGb=" + searchGb + "&Seq=" + Seq +"&StartDateTime=" + StartDateTime + "&EndDateTime=" + EndDateTime, "back");
	}

	/**
	 * ����������(����Ʈ����)�� �����Ѵ�.
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectDelete_Non(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		/**
		 * ȭ�鿡�� multipart �� �Ѱ��ֱ� ������ getParameter �Ϸ��� multipartRequest �� �޾ƾ��ؼ� �Ʒ� �ּ��� Ǯ�� ������
		 */
		String FilePath = FileUtil.FILE_DIR + "upload/";
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				10);
		MultipartRequest multipartRequest = null;
		multipartRequest = uploadEntity.getMultipart();
		

		
		String msg = "";
		int retVal = 0;
		int curPageCnt = 0;
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		String searchGb = StringUtil.nvl(
				multipartRequest.getParameter("searchGb"), "");
		int Seq = StringUtil.nvl(multipartRequest.getParameter("Seq"), 1);
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * ������������ : A, �������� : P 
		 */
		String listType = StringUtil.nvl(multipartRequest.getParameter("listType"), "P");
		
		NonProjectDAO npjDao = new NonProjectDAO();
		NonProjectDTO npjDto = new NonProjectDTO();

		npjDto.setSeq(Seq);
		retVal = npjDao.deleteProjectOne_Non(npjDto);

		msg = "������  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "������ �����Ͽ����ϴ�";

		String returnPage = "";
	    if ("P".equals(listType)) {
	    	returnPage = "/N_Project.do?cmd=projectPageList_Non&curPage=" + curPageCnt	+ "&searchGb=" + searchGb;
	    } else {
	    	returnPage = "/N_Project.do?cmd=projectPageListNonAll&curPage=" + curPageCnt	+ "&searchGb=" + searchGb;
	    }
	    
	    return alertAndExit(model, msg, request.getContextPath() + returnPage, "back");
				
//		return alertAndExit(model, msg, request.getContextPath()
//				+ "/N_Project.do?cmd=projectPageList_Non&curPage=" + curPageCnt
//				+ "&searchGb=" + searchGb, "back");
	}
	/**
	 * ���������� ����Ʈ���� ����Ʈ(Excel)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectListExcel_Non(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		
		String USERID = UserBroker.getUserId(request);
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String FrDate = StringUtil.nvl(request.getParameter("FrDate"),DateUtil.getDayInterval2(-31));
		String ToDate = StringUtil.nvl(request.getParameter("ToDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		String CompanyCode = StringUtil.nvl(request.getParameter("CompanyCode"),"");
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * �������������� : A, ���������� : P 
		 */
		String listType = StringUtil.nvl(request.getParameter("listType"), "P");
		
		NonProjectDAO npjDAO = new NonProjectDAO();
		NonProjectDTO npjDTO = new NonProjectDTO();
		
		npjDTO.setChUserID(USERID);
		npjDTO.setSearchGb(searchGb);
		npjDTO.setnRow(10);
		npjDTO.setnPage(1);
		npjDTO.setFrDate(FrDate);
		npjDTO.setToDate(ToDate);
		npjDTO.setCompanyCode(CompanyCode);
		npjDTO.setListType(listType);
		
		ListDTO ld = npjDAO.projectListExcel_Non(npjDTO);
		

		model.put("listInfo",ld);
		model.put("npjDTO", npjDTO);
		model.put("listType", listType);
		
		
		return actionMapping.findForward("projectListExcel_Non");
	}	

}
