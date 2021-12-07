package com.huation.hueware.project_h.action;

import java.net.URLEncoder;
import java.text.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jsx3.gui.Alerts;

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
import com.huation.framework.util.DateTimeUtil;
import com.huation.framework.util.StringUtil;
import com.huation.framework.util.FileUtil;
import com.huation.framework.util.UploadFile;
import com.huation.framework.util.UploadFiles;
import com.huation.framework.struts.StrutsDispatchAction;

import com.huation.common.user.UserBroker;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;
import com.huation.common.util.CommonUtil;
import com.huation.common.util.DateSetter;
import com.huation.common.util.DateUtil;

import com.huation.common.user.UserConnectDTO;
import com.huation.common.project_h.Project_H_DAO;
import com.huation.common.project_h.Project_H_DTO;

public class Project_H_Action extends StrutsDispatchAction {

	/**
	 * �������� �����(�Ѽ�)
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectRegistForm_H(ActionMapping actionMapping,
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
		DateSetter dateSetter = new DateSetter(DateUtil.getDayInterval2(-1)
				.replaceAll("-", ""), "99991231");
		DateSetter dateSetter2 = new DateSetter(DateUtil.getDayInterval2(-1)
				.replaceAll("-", ""), "99991231", "s2");

		model.put("curDate", curDate);
		model.put("dateSetter", dateSetter);
		model.put("dateSetter2", dateSetter2);
		
		model.put("strDate", strDate);

		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("sForm", sForm);
		return actionMapping.findForward("projectRegistForm_H");
	}


	/**
	 * �������� ���ó��(�Ѽ�)
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectRegist_H(ActionMapping actionMapping,
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

		String CompanyCode = StringUtil.nvl(
				multipartRequest.getParameter("CompanyCode"), "");
		String StartDateTime = StringUtil.nvl(
				multipartRequest.getParameter("StartDateTime"), "");
		String EndDateTime = StringUtil.nvl(
				multipartRequest.getParameter("EndDateTime"), "");
		String TargetMonth = StringUtil.nvl(
				multipartRequest.getParameter("TargetMonth"), "");
		String ChargeID = StringUtil.nvl(
				multipartRequest.getParameter("ChargeID"), "");
		String CustChargeNm = StringUtil.nvl(
				multipartRequest.getParameter("CustChargeNm"), "");
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
		Project_H_DAO pjDao = new Project_H_DAO();
		Project_H_DTO pjDto = new Project_H_DTO();

		pjDto.setCompanyCode(CompanyCode);
		pjDto.setStartDateTime(StartDateTime);
		pjDto.setEndDateTime(EndDateTime);
		pjDto.setTargetMonth(TargetMonth);
		pjDto.setChargeID(ChargeID);
		pjDto.setCustChargeNm(CustChargeNm);
		pjDto.setWorkSite(WorkSite);
		pjDto.setWorkContents(WorkContents);
		pjDto.setIssueReport(IssueReport);
		pjDto.setReportFile(ReportFile);
		pjDto.setFileNm(FileNm);
		pjDto.setChUserID(USERID);

		retVal = pjDao.addProject_H(pjDto);

		msg = "�������� ����Ʈ ��Ͽ�  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "�������� ����Ʈ ��Ͽ� �����Ͽ����ϴ�";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_Project_H.do?cmd=projectPageList_H&curPage=" + curPageCnt
				+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt, "back");
	}

	/**
	 * �������� ���� ����Ʈ(�Ѽ�)
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward projectPageList_H(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String CompanyCode = StringUtil.nvl(
				request.getParameter("CompanyCode"), "");
		String FrDate = StringUtil.nvl(request.getParameter("FrDate"),
				DateUtil.getDayInterval2(-31));
		String ToDate = StringUtil.nvl(request.getParameter("ToDate"),
				DateTimeUtil.getDateFormat(DateTimeUtil.getDate(), "-"));
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		
		 if(USERID.equals("")){ String rtnUrl =
		 request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.

		Project_H_DAO pjDao = new Project_H_DAO();
		Project_H_DTO pjDto = new Project_H_DTO();

		// ����Ʈ

		pjDto.setChUserID(USERID);
		pjDto.setvSearchType(searchGb);
		pjDto.setvSearch(searchtxt);
		pjDto.setnRow(20);
		pjDto.setnPage(curPageCnt);
		pjDto.setFrDate(FrDate);
		pjDto.setToDate(ToDate);
		pjDto.setCompanyCode(CompanyCode);

		ListDTO ld = pjDao.ProjectPageList_H(pjDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("FrDate", FrDate);
		model.put("ToDate", ToDate);
		model.put("CompanyCode", CompanyCode);

		return actionMapping.findForward("projectPageList_H");
	}
	
	
	/**
	 * �������� ���� ����Ʈ(�Ѽ�)
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward projectPageList_H2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		
		 if(USERID.equals("")){ String rtnUrl =
		 request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
		 
		 MultipartRequest multipartRequest = null;
		 
		 
		 String FilePath = FileUtil.FILE_DIR + "upload/";
			log.debug("FilePath= " + FilePath);
			UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
					10);
			multipartRequest = uploadEntity.getMultipart();
		 

		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil.nvl(multipartRequest.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);
		String CompanyCode = StringUtil.nvl(multipartRequest.getParameter("CompanyCode"), "");
		String FrDate = StringUtil.nvl(request.getParameter("FrDate"),DateUtil.getDayInterval2(-31));
		String ToDate = StringUtil.nvl(request.getParameter("ToDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(), "-"));

		Project_H_DAO pjDao = new Project_H_DAO();
		Project_H_DTO pjDto = new Project_H_DTO();

		// ����Ʈ

		pjDto.setChUserID(USERID);
		pjDto.setvSearchType(searchGb);
		pjDto.setvSearch(searchtxt);
		pjDto.setnRow(20);
		pjDto.setnPage(curPageCnt);
		pjDto.setFrDate(FrDate);
		pjDto.setToDate(ToDate);
		pjDto.setCompanyCode(CompanyCode);

		ListDTO ld = pjDao.ProjectPageList_H(pjDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("FrDate", FrDate);
		model.put("ToDate", ToDate);
		model.put("CompanyCode", CompanyCode);

		return actionMapping.findForward("projectPageList_H");
	}
	
	
	/**
	 * ����(����Ʈ)������(�Ѽ�)
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectView_H(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");
		int Seq = StringUtil.nvl(request.getParameter("Seq"), 1);
		String CompanyCode = StringUtil.nvl(
				request.getParameter("CompanyCode"), "");

		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
		 */
		Project_H_DAO pjDao = new Project_H_DAO();
		Project_H_DTO pjDto = new Project_H_DTO();

		pjDto.setSeq(Seq);
		pjDto.setCompanyCode(CompanyCode);
		pjDto = pjDao.projectView_H(pjDto);

		DateSetter dateSetter = new DateSetter(pjDto.getStartDate(), "99991231");
		DateSetter dateSetter2 = new DateSetter(pjDto.getEndDate(), "99991231",
				"s2");

		model.put("pjDto", pjDto);
		model.put("dateSetter", dateSetter);
		model.put("dateSetter2", dateSetter2);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("sForm", sForm);
		if (pjDto == null) {
			String msg = "���� ����Ʈ  ������ �����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_Project.do?cmd=projectPageList&curPage=" + curPageCnt
					+ "&searchGb=" + searchGb, "back");
		} else {
			return actionMapping.findForward("projectView_H");
		}
	}

	/**
	 * ����Ʈ������ �����Ѵ�.(�Ѽ�)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectEdit_H(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		int retVal = -1;
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
			msg = "÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("I")) {
			log.debug("÷�� ������ ������ �߸��Ǿ����ϴ�.");
			msg = "÷�� ������ ������ �߸��Ǿ����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("S")) {

			curPageCnt = StringUtil.nvl(
					multipartRequest.getParameter("curPage"), 1);
			searchGb = StringUtil.nvl(
					multipartRequest.getParameter("searchGb"), "");
			searchtxt = StringUtil.nvl(
					multipartRequest.getParameter("searchtxt"), "");
			sForm = StringUtil.nvl(multipartRequest.getParameter("sForm"), "N");

			ReportFile = StringUtil.nvl(
					multipartRequest.getParameter("p_report_file"), "");

			// ���ε�� ������ ������ �����ͼ� ������ ���̽��� �ִ� �۾��� ���ش�.
			log.debug("÷�� ������ ÷���ϴµ� �����Ͽ����ϴ�.");
			ArrayList files = uploadEntity.getFiles();
			UploadFile file = null;
			for (int i = 0; i < files.size(); i++) {
				file = (UploadFile) files.get(i);
				objName = file.getObjName();
				rFileName = StringUtil.nvl(file.getRootName());

				if (objName.equals("ReportFile")) {

					if (!rFileName.equals("")) {
						sFileName = file.getUploadName();
						filePath = uploadEntity.getUploadPath();
						log.debug(" ���� ������Ʈ�� =>" + objName + ", �� ���� �� =>"
								+ rFileName + ", �������ϸ� =>" + sFileName
								+ ",���� ������ =>" + fileSize + ", ���� ���� �н� =>"
								+ filePath);
						ReportFile = filePath + sFileName;
					}
				}

			}
		}
		int Seq = StringUtil.nvl(multipartRequest.getParameter("Seq"), 1);
		String CompanyCode = StringUtil.nvl(
				multipartRequest.getParameter("CompanyCode"), "");
		String StartDateTime = StringUtil.nvl(
				multipartRequest.getParameter("StartDateTime"), "");
		String EndDateTime = StringUtil.nvl(
				multipartRequest.getParameter("EndDateTime"), "");
		String TargetMonth = StringUtil.nvl(
				multipartRequest.getParameter("TargetMonth"), "");
		String ChargeID = StringUtil.nvl(
				multipartRequest.getParameter("ChargeID"), "");
		String CustChargeNm = StringUtil.nvl(
				multipartRequest.getParameter("CustChargeNm"), "");
		String WorkSite = StringUtil.nvl(
				multipartRequest.getParameter("WorkSite"), "");
		String WorkContents = StringUtil.nvl(
				multipartRequest.getParameter("WorkContents"), "");
		String IssueReport = StringUtil.nvl(
				multipartRequest.getParameter("IssueReport"), "");
		String FileNm = StringUtil.nvl(
				multipartRequest.getParameter("FileNm"), "");

		log.debug("FileName:" + FileNm);
		Project_H_DAO pjDao = new Project_H_DAO();
		Project_H_DTO pjDto = new Project_H_DTO();

		pjDto.setSeq(Seq);
		pjDto.setCompanyCode(CompanyCode);
		pjDto.setStartDateTime(StartDateTime);
		pjDto.setEndDateTime(EndDateTime);
		pjDto.setTargetMonth(TargetMonth);
		pjDto.setChargeID(ChargeID);
		pjDto.setCustChargeNm(CustChargeNm);
		pjDto.setWorkSite(WorkSite);
		pjDto.setWorkContents(WorkContents);
		pjDto.setIssueReport(IssueReport);
		pjDto.setReportFile(ReportFile);
		pjDto.setFileNm(FileNm);
		pjDto.setChUserID(USERID);
		retVal = pjDao.editProject_H(pjDto);

		model.put("curPage", String.valueOf(curPageCnt));

		msg = "������  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "������ �����Ͽ����ϴ�";

		if (sForm.equals("N")) {
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_Project_H.do?cmd=projectPageList_H&curPage=" + curPageCnt
					+ "&searchGb=" + searchGb +  "&Seq=" + Seq,
					"back");
		} else {
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_Project_H.do?cmd=projectPageList_H&curPage=" + curPageCnt
					+ "&searchGb=" + searchGb + "&Seq=" + Seq,
					"back");
		}
	}

	/**
	 * ����Ʈ������ �����Ѵ�.(�Ѽ�)
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectDelete_H(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
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
		String searchtxt = StringUtil.nvl(
				multipartRequest.getParameter("searchtxt"), "");
		int Seq = StringUtil.nvl(multipartRequest.getParameter("Seq"), 1);
		
		Project_H_DAO pjDao = new Project_H_DAO();
		Project_H_DTO pjDto = new Project_H_DTO();

		pjDto.setSeq(Seq);
		retVal = pjDao.deleteProjectOne_H(pjDto);

		msg = "������  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "������ �����Ͽ����ϴ�";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_Project_H.do?cmd=projectPageList_H&curPage=" + curPageCnt
				+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt, "back");
	}
	/**
	 * ���� ����Ʈ���� ����Ʈ(Excel)(�Ѽ�)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectListExcel_H(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String CompanyCode = StringUtil.nvl(request.getParameter("CompanyCode"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String FrDate = StringUtil.nvl(request.getParameter("FrDate"),
				DateUtil.getDayInterval2(-31));
		String ToDate = StringUtil.nvl(request.getParameter("ToDate"),
				DateTimeUtil.getDateFormat(DateTimeUtil.getDate(), "-"));
		Project_H_DAO pjDAO = new Project_H_DAO();
		Project_H_DTO pjDTO = new Project_H_DTO();

		pjDTO.setChUserID(USERID);
		pjDTO.setSearchGb(searchGb);
		pjDTO.setSearchTxt(searchtxt);
		pjDTO.setnRow(10);
		pjDTO.setnPage(1);
		pjDTO.setFrDate(FrDate);
		pjDTO.setToDate(ToDate);
		pjDTO.setCompanyCode(CompanyCode);
		ListDTO ld = pjDAO.projectListExcel_H(pjDTO);

		model.put("listInfo", ld);
		model.put("pjDTO", pjDTO);

		return actionMapping.findForward("projectListExcel_H");
	}

}
