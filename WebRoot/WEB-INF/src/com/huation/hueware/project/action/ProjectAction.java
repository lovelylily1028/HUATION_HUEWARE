package com.huation.hueware.project.action;

import java.text.DateFormat;
import java.text.Normalizer;
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
import com.huation.common.project.ProjectDAO;
import com.huation.common.project.ProjectDTO;
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
public class ProjectAction extends StrutsDispatchAction {

	/**
	 * �������� �����
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectRegistForm(ActionMapping actionMapping,
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
		
		CommonDAO comDao = new CommonDAO();
		String curDate = comDao.getCurrentDate();
		
		
		Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	    cal.add(Calendar.DATE, -1);
	  /*  cal.add(Calendar.MONTH, 2);*/
	     
	    // Ư�� ������ ��¥�� ���� �̱� 
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    String strDate = df.format(cal.getTime());
	    System.err.println(strDate);

		
		
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
		model.put("listType", listType);
		
		return actionMapping.findForward("projectRegistForm");
	}

	/**
	 * �������� ���ó��
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectRegist(ActionMapping actionMapping,
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
		log.info("before, FileNm : "+FileNm);
		FileNm = Normalizer.normalize(FileNm, Normalizer.Form.NFC);  //맥OS에서 업로드한 파일, 자모분리현상 해결
		log.info("after, FileNm : "+FileNm);
		
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * ������������ : A, �������� : P 
		 */
		String listType = StringUtil.nvl(multipartRequest.getParameter("listType"), "P");
		
		ProjectDAO pjDao = new ProjectDAO();
		ProjectDTO pjDto = new ProjectDTO();

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

		retVal = pjDao.addProject(pjDto);

		msg = "�������� ����Ʈ ��Ͽ�  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "�������� ����Ʈ ��Ͽ� �����Ͽ����ϴ�";
		
		
		String returnPage="";
		if ("P".equals(listType)) {
			returnPage = "/B_Project.do?cmd=projectPageList&curPage=" + curPageCnt + "&searchGb=" + searchGb + "&searchtxt=" + searchtxt;
		} else {
			returnPage = "/B_Project.do?cmd=projectPageListAll&curPage=" + curPageCnt + "&searchGb=" + searchGb + "&searchtxt=" + searchtxt;;
		}

		return alertAndExit(model, msg, request.getContextPath() + returnPage, "back");
//		return alertAndExit(model, msg, request.getContextPath() + returnPage
//				+ "/B_Project.do?cmd=projectPageList&curPage=" + curPageCnt
//				+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt, "back");
	}

	/**
	 * �������� ���� ����Ʈ
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward projectPageList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String CompanyCode = StringUtil.nvl(
				request.getParameter("CompanyCode"), "");
		String FrDate = StringUtil.nvl(request.getParameter("FrDate"),
				DateUtil.getDayInterval2(-31));
		String ToDate = StringUtil.nvl(request.getParameter("ToDate"),
				DateTimeUtil.getDateFormat(DateTimeUtil.getDate(), "-"));
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
		
		ProjectDAO pjDao = new ProjectDAO();
		ProjectDTO pjDto = new ProjectDTO();

		// ����Ʈ

		pjDto.setChUserID(USERID);
		pjDto.setvSearchType(searchGb);
		pjDto.setvSearch(searchtxt);
		pjDto.setnRow(20);
		pjDto.setnPage(curPageCnt);
		pjDto.setFrDate(FrDate);
		pjDto.setToDate(ToDate);
		pjDto.setCompanyCode(CompanyCode);
		pjDto.setListType(listType);
		
		ListDTO ld = pjDao.ProjectPageList(pjDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("FrDate", FrDate);
		model.put("ToDate", ToDate);
		model.put("CompanyCode", CompanyCode);
		model.put("listType", listType);

		return actionMapping.findForward("projectPageList");
	}
	
	/**
	 * �������� ���� ����Ʈ(����)
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward projectPageListAll(ActionMapping actionMapping,
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
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
		 */
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * ������������ : A, �������� : P 
		 */
		String listType = StringUtil.nvl(request.getParameter("listType"), "A");
		
		ProjectDAO pjDao = new ProjectDAO();
		ProjectDTO pjDto = new ProjectDTO();

		// ����Ʈ

		pjDto.setChUserID(USERID);
		pjDto.setvSearchType(searchGb);
		pjDto.setvSearch(searchtxt);
		pjDto.setnRow(20);
		pjDto.setnPage(curPageCnt);
		pjDto.setFrDate(FrDate);
		pjDto.setToDate(ToDate);
		pjDto.setCompanyCode(CompanyCode);
		pjDto.setListType(listType);
		
		ListDTO ld = pjDao.ProjectPageListAll(pjDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("FrDate", FrDate);
		model.put("ToDate", ToDate);
		model.put("CompanyCode", CompanyCode);
		model.put("listType", listType);
	
		return actionMapping.findForward("projectPageListAll");
	}
	
	/**
	 * �������� ���� ����Ʈ
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward projectPageList2(ActionMapping actionMapping,
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
		String FrDate = StringUtil.nvl(multipartRequest.getParameter("FrDate"),DateUtil.getDayInterval2(-2));
		String ToDate = StringUtil.nvl(multipartRequest.getParameter("ToDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(), "-"));
		
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * ������������ : A, �������� : P 
		 */
		String listType = StringUtil.nvl(multipartRequest.getParameter("listType"), "A");
		
		ProjectDAO pjDao = new ProjectDAO();
		ProjectDTO pjDto = new ProjectDTO();

		// ����Ʈ

		pjDto.setChUserID(USERID);
		pjDto.setvSearchType(searchGb);
		pjDto.setvSearch(searchtxt);
		pjDto.setnRow(20);
		pjDto.setnPage(curPageCnt);
		pjDto.setFrDate(FrDate);
		pjDto.setToDate(ToDate);
		pjDto.setCompanyCode(CompanyCode);

		ListDTO ld = new ListDTO();
		String returnPage = "";
		
		if ("P".equals(listType)) {
			ld = pjDao.ProjectPageList(pjDto);
			returnPage = "projectPageList";
		} else {
			ld = pjDao.ProjectPageListAll(pjDto);
			returnPage = "projectPageListAll";
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
	 * ����(����Ʈ)������
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");
		int Seq = StringUtil.nvl(request.getParameter("Seq"), 1);
		String CompanyCode = StringUtil.nvl(
				request.getParameter("CompanyCode"), "");
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
		String frDate = StringUtil.nvl(request.getParameter("FrDate"),DateUtil.getDayInterval2(-2));
		String toDate = StringUtil.nvl(request.getParameter("ToDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(), "-"));
		
		ProjectDAO pjDao = new ProjectDAO();
		ProjectDTO pjDto = new ProjectDTO();
		
		pjDto.setSeq(Seq);
		pjDto.setCompanyCode(CompanyCode);
		pjDto = pjDao.projectView(pjDto);
		log.debug("compan3:"+CompanyCode);
		DateSetter dateSetter = new DateSetter(pjDto.getStartDate(), "99991231");
		log.debug("statdate:"+pjDto.getStartDate());
		DateSetter dateSetter2 = new DateSetter(pjDto.getEndDate(), "99991231",
				"s2");
		
		//������� ���ư� ��� �ش� �˻��Ⱓ�� �����ϱ� ���ذ˻������� ���ڸ� ������ �ش�. 
		pjDto.setFrDate(frDate);
		pjDto.setToDate(toDate);
		
		model.put("pjDto", pjDto);
		model.put("dateSetter", dateSetter);
		model.put("dateSetter2", dateSetter2);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("sForm", sForm);
		model.put("listType", listType);
		//if (pjDto == null) {
		if (pjDto.getCreateDateTime() == null) {	
			String msg = "���� ����Ʈ  ������ �����ϴ�.";
//			return alertAndExit(model, msg, request.getContextPath()
//					+ "/B_Project.do?cmd=projectPageList&curPage=" + curPageCnt
//					+ "&searchGb=" + searchGb, "back");
			
			String returnPage = "";
			if ("P".equals(listType)) {
				returnPage = "/B_Project.do?cmd=projectPageList&curPage=" + curPageCnt + "&searchGb=" + searchGb;			
			} else {
				returnPage = "/B_Project.do?cmd=projectPageListAll&curPage=" + curPageCnt + "&searchGb=" + searchGb;
			}
			
			return alertAndExit(model, msg, request.getContextPath() + returnPage, "back");					 
		} else {
			return actionMapping.findForward("projectView");
		}
	}

	/**
	 * ����Ʈ������ �����Ѵ�.
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectEdit(ActionMapping actionMapping,
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
			log.debug("PageExcel1:"+curPageCnt);
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
		
		String chUserID = StringUtil.nvl(
				multipartRequest.getParameter("chUserID"), "");
		String FrDate = StringUtil.nvl(multipartRequest.getParameter("FrDate"),
				DateUtil.getDayInterval2(-2));
		String ToDate = StringUtil.nvl(multipartRequest.getParameter("ToDate"),
				DateTimeUtil.getDateFormat(DateTimeUtil.getDate(), "-"));
		
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * ������������ : A, �������� : P 
		 */
		String listType = StringUtil.nvl(multipartRequest.getParameter("listType"), "P");
		
		ProjectDAO pjDao = new ProjectDAO();
		ProjectDTO pjDto = new ProjectDTO();

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
		pjDto.setSearchGb(searchGb);
		pjDto.setnRow(20);
		pjDto.setnPage(curPageCnt);
		log.debug("PageExcel2:"+curPageCnt);
		pjDto.setFrDate(FrDate);
		log.debug("FrDate:"+FrDate);
		pjDto.setToDate(ToDate);
		retVal = pjDao.editProject(pjDto);

		model.put("curPage", String.valueOf(curPageCnt));
		model.put("listType", listType);
		
		msg = "������  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "������ �����Ͽ����ϴ�";

		String returnPage="";
				
		if (sForm.equals("N")) {
			if ("P".equals(listType)) {
				returnPage = "/B_Project.do?cmd=projectPageList&curPage=" + curPageCnt + "&searchGb=" + searchGb + "&Seq=" + Seq + "&FrDate=" + FrDate + "&ToDate="+ ToDate;
			} else {
				returnPage = "/B_Project.do?cmd=projectPageListAll&curPage=" + curPageCnt + "&searchGb=" + searchGb + "&Seq=" + Seq + "&FrDate=" + FrDate + "&ToDate="+ ToDate;
			}
			
//			return alertAndExit(model, msg, request.getContextPath()
//					+ "/B_Project.do?cmd=projectPageList&curPage=" + curPageCnt
//					+ "&searchGb=" + searchGb + "&Seq=" + Seq + "&FrDate=" + FrDate + "&ToDate="+ ToDate,
//					"back");
		} else {
			if ("P".equals(listType)) {
				returnPage = "/B_Project.do?cmd=projectPageList&curPage=" + curPageCnt	+ "&searchGb=" + searchGb + "&Seq=" + Seq;
			} else {
				returnPage = "/B_Project.do?cmd=projectPageListAll&curPage=" + curPageCnt	+ "&searchGb=" + searchGb + "&Seq=" + Seq;
			}
			
//			return alertAndExit(model, msg, request.getContextPath()
//					+ "/B_Project.do?cmd=projectPageList&curPage=" + curPageCnt
//					+ "&searchGb=" + searchGb + "&Seq=" + Seq,
//					"back");
		}
		return alertAndExit(model, msg, request.getContextPath() + returnPage, "back");
	}

	/**
	 * ����Ʈ������ �����Ѵ�.
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectDelete(ActionMapping actionMapping,
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
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * ������������ : A, �������� : P 
		 */
		String listType = StringUtil.nvl(multipartRequest.getParameter("listType"), "P");
		
		ProjectDAO pjDao = new ProjectDAO();
		ProjectDTO pjDto = new ProjectDTO();

		pjDto.setSeq(Seq);
		retVal = pjDao.deleteProjectOne(pjDto);

		msg = "������  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "������ �����Ͽ����ϴ�";

		String returnPage = "";
		if ("P".equals(listType)) {
			returnPage = "/B_Project.do?cmd=projectPageList&curPage=" + curPageCnt	+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt;
		} else {
			returnPage = "/B_Project.do?cmd=projectPageListAll&curPage=" + curPageCnt	+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt;
		}
		
		return alertAndExit(model, msg, request.getContextPath() + returnPage, "back");
		
//		return alertAndExit(model, msg, request.getContextPath()
//				+ "/B_Project.do?cmd=projectPageList&curPage=" + curPageCnt
//				+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt, "back");
	}

	/**
	 * ���� ����Ʈ���� ����Ʈ(Excel)
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward projectListExcel(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String CompanyCode = StringUtil.nvl(request.getParameter("CompanyCode"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		log.debug("Page1:"+curPageCnt);
		String FrDate = StringUtil.nvl(request.getParameter("FrDate"),
				DateUtil.getDayInterval2(-31));
		String ToDate = StringUtil.nvl(request.getParameter("ToDate"),
				DateTimeUtil.getDateFormat(DateTimeUtil.getDate(), "-"));
		/**
		 * ���հ� �����ϱ� ���� listType �߰��� 
		 * ������������ : A, �������� : P 
		 */
		String listType = StringUtil.nvl(request.getParameter("listType"), "P");
		
		ProjectDAO pjDAO = new ProjectDAO();
		ProjectDTO pjDTO = new ProjectDTO();

		pjDTO.setChUserID(USERID);
		pjDTO.setSearchGb(searchGb);
		pjDTO.setnRow(20);
		pjDTO.setnPage(1);
		log.debug("Page2:"+curPageCnt);
		pjDTO.setFrDate(FrDate);
		pjDTO.setToDate(ToDate);
		pjDTO.setCompanyCode(CompanyCode);
		pjDTO.setListType(listType);
		ListDTO ld = pjDAO.projectListExcel(pjDTO);
		log.debug("Page2:"+curPageCnt);
		model.put("listInfo", ld);
		model.put("pjDTO", pjDTO);
		model.put("FrDate", FrDate);
		model.put("ToDate", ToDate);
		model.put("listType", listType);

		return actionMapping.findForward("projectListExcel");
	}
	
}
