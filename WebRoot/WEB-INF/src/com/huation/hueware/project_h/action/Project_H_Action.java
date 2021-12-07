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
	 * 정기점검 등록폼(한솔)
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

		log.debug("업체등록");

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");

		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		// 로그인 처리 끝.
		
		
		
		Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	    cal.add(Calendar.DATE, -1);
	  /*  cal.add(Calendar.MONTH, 2);*/
	     
	    // 특정 형태의 날짜로 값을 뽑기 
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
	 * 정기점검 등록처리(한솔)
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

		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		// 로그인 처리 끝.

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
			log.debug("첨부 파일 올리려다 실패하였습니다.");
			msg = "첨부 파일 올리려다 실패하였습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("O")) {
			log.debug("첨부하신 파일이 용량을 초과했습니다.");
			msg = "첨부하신 파일이 용량을 초과했습니다.최대 10M 까지 가능합니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("I")) {
			log.debug("첨부 파일의 정보가 잘못되었습니다.");
			msg = "첨부 파일의 정보가 잘못되었습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("S")) {
			// 업로드된 파일의 정보를 가져와서 데이터 베이스에 넣는 작업을 해준다.
			log.debug("첨부 파일을 첨부하는데 성공하였습니다.");
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

					log.debug("파일 오브젝트명[" + objName + "]원파일명[" + rFileName
							+ "]저장파일명[" + sFileName + "]파일사이즈[" + fileSize
							+ "]저장파일패스[" + filePath + "]업로드 경로["
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

		msg = "정기점검 사이트 등록에  성공하였습니다";
		if (retVal < 1)
			msg = "정기점검 사이트 등록에 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_Project_H.do?cmd=projectPageList_H&curPage=" + curPageCnt
				+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt, "back");
	}

	/**
	 * 정기점검 관리 리스트(한솔)
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
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		 if(USERID.equals("")){ String rtnUrl =
		 request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.

		Project_H_DAO pjDao = new Project_H_DAO();
		Project_H_DTO pjDto = new Project_H_DTO();

		// 리스트

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
	 * 정기점검 관리 리스트(한솔)
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
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		 if(USERID.equals("")){ String rtnUrl =
		 request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		 
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

		// 리스트

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
	 * 고객사(사이트)상세정보(한솔)
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

		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
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
			String msg = "점검 사이트  정보가 없습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_Project.do?cmd=projectPageList&curPage=" + curPageCnt
					+ "&searchGb=" + searchGb, "back");
		} else {
			return actionMapping.findForward("projectView_H");
		}
	}

	/**
	 * 사이트정보를 수정한다.(한솔)
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
			log.debug("첨부 파일 올리려다 실패하였습니다.");
			msg = "첨부 파일 올리려다 실패하였습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("O")) {
			log.debug("첨부하신 파일이 용량을 초과했습니다.");
			msg = "첨부하신 파일이 용량을 초과했습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("I")) {
			log.debug("첨부 파일의 정보가 잘못되었습니다.");
			msg = "첨부 파일의 정보가 잘못되었습니다.";
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

			// 업로드된 파일의 정보를 가져와서 데이터 베이스에 넣는 작업을 해준다.
			log.debug("첨부 파일을 첨부하는데 성공하였습니다.");
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
						log.debug(" 파일 오브젝트명 =>" + objName + ", 원 파일 명 =>"
								+ rFileName + ", 저장파일명 =>" + sFileName
								+ ",파일 사이즈 =>" + fileSize + ", 저장 파일 패스 =>"
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

		msg = "수정에  성공하였습니다";
		if (retVal < 1)
			msg = "수정에 실패하였습니다";

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
	 * 사이트정보를 삭제한다.(한솔)
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

		msg = "삭제에  성공하였습니다";
		if (retVal < 1)
			msg = "삭제에 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_Project_H.do?cmd=projectPageList_H&curPage=" + curPageCnt
				+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt, "back");
	}
	/**
	 * 점검 사이트정보 리스트(Excel)(한솔)
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
