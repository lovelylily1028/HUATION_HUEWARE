package com.huation.hueware.bankmanage.action;

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

import com.huation.common.bankmanage.BankManageDAO;
import com.huation.common.bankmanage.BankManageDTO;
import com.huation.common.user.UserBroker;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;
import com.huation.common.util.CommonUtil;
import com.huation.common.util.DateSetter;
import com.huation.common.util.DateUtil;

import com.huation.common.user.UserConnectDTO;

public class BankManageAction extends StrutsDispatchAction {

	/**
	 * 법인은행관리 리스트
	 * 
	 */
	public ActionForward bankPageList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String BankCode = StringUtil.nvl(request.getParameter("BankCode"), "");
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		 */
		BankManageDAO bmDao = new BankManageDAO();
		BankManageDTO bmDto = new BankManageDTO();

		// 리스트

		bmDto.setChUserID(USERID);
		bmDto.setnRow(20);
		bmDto.setnPage(curPageCnt);
		bmDto.setBankCode(BankCode);

		ListDTO ld = bmDao.bankmanagePageList(bmDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("BankCode", BankCode);

		return actionMapping.findForward("bankPageList");
	}
	
	
	public ActionForward bankPageList2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

//		로그인 처리 
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
				String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
//			로그인 처리 끝.
		
		MultipartRequest multipartRequest = null;
		
		String FilePath = FileUtil.FILE_DIR + "bankmanage/"
				+ DateTimeUtil.getDate() + "/";
		String uploadFilePath="";
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath,USERID, 10);
     	multipartRequest = uploadEntity.getMultipart();

		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);
		//String BankCode = StringUtil.nvl(multipartRequest.getParameter("BankCode"), "");

		BankManageDAO bmDao = new BankManageDAO();
		BankManageDTO bmDto = new BankManageDTO();

		// 리스트

		bmDto.setChUserID(USERID);
		bmDto.setnRow(20);
		bmDto.setnPage(curPageCnt);
		//bmDto.setBankCode(BankCode);

		ListDTO ld = bmDao.bankmanagePageList(bmDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		//model.put("BankCode", BankCode);

		return actionMapping.findForward("bankPageList");
	}

	/**
	 * 법인은행관리 등록폼
	 */
	public ActionForward bankRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		
		Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	    /*cal.add(Calendar.DATE, -1);*/
	  /*  cal.add(Calendar.MONTH, 2);*/
	     
	    // 특정 형태의 날짜로 값을 뽑기 
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    String strDate = df.format(cal.getTime());
	    System.err.println(strDate);
		
		
		
		
		// 달력 생성 넘겨주는값.
		CommonDAO comDao = new CommonDAO();
		String curDate = comDao.getCurrentDate();
		DateSetter dateSetter = new DateSetter(DateUtil.getDayInterval2(0)
				.replaceAll("-", ""), "99991231");
		DateSetter dateSetter2 = new DateSetter(DateUtil.getDayInterval2(0)
				.replaceAll("-", ""), "99991231", "s2");
		DateSetter dateSetter3 = new DateSetter(DateUtil.getDayInterval2(0)
				.replaceAll("-", ""), "99991231", "s3");
		model.put("sFrom", sForm);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("curDate", curDate);
		model.put("dateSetter", dateSetter);
		model.put("dateSetter2", dateSetter2);
		model.put("dateSetter3", dateSetter3);
		
		model.put("strDate", strDate);
		return actionMapping.findForward("bankRegistForm");
	}

	/**
	 * 법인통장관리 등록처리
	 */
	public ActionForward bankManageRegist(ActionMapping actionMapping,
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

		int retVal = -1;
		String msg = "";

		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "bankmanage/"
				+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				10);
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String sForm = "N";

		String BankBookFile = "";

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

					if (objName.equals("BankBookFile")) {
						BankBookFile = uploadFilePath;
					}
				}
			}
		}

		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		
		String BankCode = StringUtil.nvl(
				multipartRequest.getParameter("BankCode"), "");
		String AccountNumber = StringUtil.nvl(
				multipartRequest.getParameter("AccountNumber"), "");
		String NewDate = StringUtil.nvl(
				multipartRequest.getParameter("NewDate"), "");
		String ReturnDate = StringUtil.nvl(
				multipartRequest.getParameter("ReturnDate"), "");
		String BankBook = StringUtil.nvl(
				multipartRequest.getParameter("BankBook"), "");
		String AccountManage = StringUtil.nvl(
				multipartRequest.getParameter("AccountManage"), "");
		String CustomerNum = StringUtil.nvl(
				multipartRequest.getParameter("CustomerNum"), "");
		String RegistrationDate = StringUtil.nvl(
				multipartRequest.getParameter("RegistrationDate"), "");
		String Registration = StringUtil.nvl(
				multipartRequest.getParameter("Registration"), "");
		String BankBookFileNm = StringUtil.nvl(
				multipartRequest.getParameter("BankBookFileNm"), "");
		String AccountIssue = StringUtil.nvl(
				multipartRequest.getParameter("AccountIssue"), "");

		BankManageDAO bmDao = new BankManageDAO();
		BankManageDTO bmDto = new BankManageDTO();

		bmDto.setBankCode(BankCode);
		bmDto.setAccountNumber(AccountNumber);
		bmDto.setNewDate(NewDate);
		bmDto.setReturnDate(ReturnDate);
		bmDto.setBankBook(BankBook);
		bmDto.setAccountManage(AccountManage);
		bmDto.setCustomerNum(CustomerNum);
		bmDto.setRegistrationDate(RegistrationDate);
		bmDto.setRegistration(Registration);
		bmDto.setBankBookFile(BankBookFile);
		bmDto.setBankBookFileNm(BankBookFileNm);
		bmDto.setAccountIssue(AccountIssue);

		retVal = bmDao.addBankManage(bmDto);

		msg = "법인통장 등록에  성공하였습니다";
		if (retVal < 1)
			msg = "법인통장 등록에 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_BankManage.do?cmd=bankPageList&curPage=" + curPageCnt, "back");
	}

	/**
	 * 법인통장 계좌번호체크
	 */
	public ActionForward AcNumCheck(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String AccountNumber = StringUtil.nvl(
				request.getParameter("AccountNumber"), "");

		BankManageDAO bmDao = new BankManageDAO();
		BankManageDTO bmDto = new BankManageDTO();

		bmDto.setAccountNumber(AccountNumber);

		String result = bmDao.acnumberCheck(bmDto);

		model.put("result", result);

		return actionMapping.findForward("acNumberChkXML");
		//실제로 struts.XML타고 포워딩 태워주는 네임(acNumberChkXML)  return actionMapping.findForward("acNumberChkXML");
	}
	/**
	 * (Excel)법인통장관리 리스트
	 */
	public ActionForward bankExcelList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);

		String BankCode = StringUtil.nvl(request.getParameter("BankCode"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		log.debug("Page1:"+curPageCnt);
		BankManageDAO bmDao = new BankManageDAO();
		BankManageDTO bmDto = new BankManageDTO();
		
		bmDto.setChUserID(USERID);
		bmDto.setnRow(20);
		bmDto.setnPage(1);
		log.debug("Page2:"+curPageCnt);
		bmDto.setBankCode(BankCode);
		ListDTO ld = bmDao.bankListExcel(bmDto);
		log.debug("Page2:"+curPageCnt);
		model.put("listInfo", ld);
		model.put("bmDto", bmDto);

		return actionMapping.findForward("bankExcelList");
	}
	/**
	 * 법인통장관리 상세
	 */
	public ActionForward bankView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");
		String AccountNumber = StringUtil.nvl(
				request.getParameter("AccountNumber"), "");
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		 */
		BankManageDAO bmDao = new BankManageDAO();
		BankManageDTO bmDto = new BankManageDTO();

		
		bmDto.setAccountNumber(AccountNumber);
		bmDto = bmDao.BankView(bmDto);
		
		
		//replaceAll("-", "") <<2012-01-01 데이터날짜 (-)잘라서 꺼내오기.
		DateSetter dateSetter = new DateSetter(bmDto.getNewDate().replaceAll("-", ""), "99991231");
		log.debug("newdate:"+bmDto.getNewDate());
		DateSetter dateSetter2 = new DateSetter(bmDto.getReturnDate().replaceAll("-", ""), "99991231", "s2");
		DateSetter dateSetter3 = new DateSetter(bmDto.getRegistrationDate().replaceAll("-", ""), "99991231", "s3");

		model.put("bmDto", bmDto);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("sForm", sForm);
		model.put("dateSetter", dateSetter);
		model.put("dateSetter2", dateSetter2);
		model.put("dateSetter3", dateSetter3);
		if (bmDto == null) {
			String msg = "법인통장  정보가 없습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_BankManage.do?cmd=bankPageList&curPage=" + curPageCnt + "back");
		} else {
			return actionMapping.findForward("bankView");
		}
	}
	/**
	 * 법인통장관리 수정처리
	 */
	public ActionForward bankManageEdit(ActionMapping actionMapping,
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

		int retVal = -1;
		String msg = "";

		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "bankmanage/"
				+ DateTimeUtil.getDate() + "/";
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

		String BankBookFile = "";

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
			curPageCnt = StringUtil.nvl(
					multipartRequest.getParameter("curPage"), 1);
			log.debug("PageExcel1:"+curPageCnt);
			searchGb = StringUtil.nvl(
					multipartRequest.getParameter("searchGb"), "");
			searchtxt = StringUtil.nvl(
					multipartRequest.getParameter("searchtxt"), "");
			sForm = StringUtil.nvl(multipartRequest.getParameter("sForm"), "N");
			
			//BankBookFile Request.getparameter 넘겨주는이유 수정시 파일은 수정하지않았을경우 가지고있는파일 유지를위해서 
			BankBookFile = StringUtil.nvl(
					multipartRequest.getParameter("p_BankBookFile"), "");//p_BankBookFile Web(기존데이터)에서받고  BankBookFile DB로담아준다.
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

					if (objName.equals("BankBookFile")) {
						BankBookFile = uploadFilePath;
					}
				}
			}
		}

		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		searchGb = StringUtil
				.nvl(multipartRequest.getParameter("searchGb"), "");
		// sForm= StringUtil.nvl(multipartRequest.getParameter("sForm"),"N");

		String BankCode = StringUtil.nvl(
				multipartRequest.getParameter("BankCode"), "");
		String AccountNumber = StringUtil.nvl(
				multipartRequest.getParameter("AccountNumber"), "");
		String NewDate = StringUtil.nvl(
				multipartRequest.getParameter("NewDate"), "");
		String ReturnDate = StringUtil.nvl(
				multipartRequest.getParameter("ReturnDate"), "");
		String BankBook = StringUtil.nvl(
				multipartRequest.getParameter("BankBook"), "");
		String AccountManage = StringUtil.nvl(
				multipartRequest.getParameter("AccountManage"), "");
		String CustomerNum = StringUtil.nvl(
				multipartRequest.getParameter("CustomerNum"), "");
		String RegistrationDate = StringUtil.nvl(
				multipartRequest.getParameter("RegistrationDate"), "");
		String Registration = StringUtil.nvl(
				multipartRequest.getParameter("Registration"), "");
		String BankBookFileNm = StringUtil.nvl(
				multipartRequest.getParameter("BankBookFileNm"), "");
		String AccountIssue = StringUtil.nvl(
				multipartRequest.getParameter("AccountIssue"), "");
		
		System.out.println("NewDate : "+NewDate);
		System.out.println("ReturnDate : "+ReturnDate);
		System.out.println("RegistrationDate : "+RegistrationDate);

		BankManageDAO bmDao = new BankManageDAO();
		BankManageDTO bmDto = new BankManageDTO();

		bmDto.setBankCode(BankCode);
		bmDto.setAccountNumber(AccountNumber);
		bmDto.setNewDate(NewDate);
		bmDto.setReturnDate(ReturnDate);
		bmDto.setBankBook(BankBook);
		bmDto.setAccountManage(AccountManage);
		bmDto.setCustomerNum(CustomerNum);
		bmDto.setRegistrationDate(RegistrationDate);
		bmDto.setRegistration(Registration);
		bmDto.setBankBookFile(BankBookFile);
		bmDto.setBankBookFileNm(BankBookFileNm);
		bmDto.setAccountIssue(AccountIssue);

		retVal = bmDao.updateBankManage(bmDto);

		msg = "법인통장 정보가 수정되었습니다";
		if (retVal < 1)
			msg = "법인통장 정보 수정이 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_BankManage.do?cmd=bankPageList&curPage=" + curPageCnt
				+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt, "back");
	}

	/**
	 * 법인통장관리 정보 삭제
	 */
	public ActionForward bankManageDelete(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		String FilePath = FileUtil.FILE_DIR + "bankmanage/"
				+ DateTimeUtil.getDate() + "/";
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				10);
		MultipartRequest multipartRequest = null;
		multipartRequest = uploadEntity.getMultipart();

		String msg = "";
		int retVal = 0;
		int curPageCnt = 0;
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		String AccountNumber = StringUtil.nvl(multipartRequest.getParameter("AccountNumber"), "");

		BankManageDAO bmDao = new BankManageDAO();
		BankManageDTO bmDto = new BankManageDTO();

		bmDto.setAccountNumber(AccountNumber);
		retVal = bmDao.deleteBankManageOne(bmDto);

		msg = "삭제에  성공하였습니다";
		if (retVal < 1)
			msg = "삭제에 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_BankManage.do?cmd=bankPageList&curPage=" + curPageCnt, "back");
	}
}
