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
	 * ����������� ����Ʈ
	 * 
	 */
	public ActionForward bankPageList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String BankCode = StringUtil.nvl(request.getParameter("BankCode"), "");
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
		 */
		BankManageDAO bmDao = new BankManageDAO();
		BankManageDTO bmDto = new BankManageDTO();

		// ����Ʈ

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

//		�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
				String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
//			�α��� ó�� ��.
		
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

		// ����Ʈ

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
	 * ����������� �����
	 */
	public ActionForward bankRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");
		// �α��� ó��
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
	     
	    // Ư�� ������ ��¥�� ���� �̱� 
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    String strDate = df.format(cal.getTime());
	    System.err.println(strDate);
		
		
		
		
		// �޷� ���� �Ѱ��ִ°�.
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
	 * ����������� ���ó��
	 */
	public ActionForward bankManageRegist(ActionMapping actionMapping,
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

		msg = "�������� ��Ͽ�  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "�������� ��Ͽ� �����Ͽ����ϴ�";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_BankManage.do?cmd=bankPageList&curPage=" + curPageCnt, "back");
	}

	/**
	 * �������� ���¹�ȣüũ
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
		//������ struts.XMLŸ�� ������ �¿��ִ� ����(acNumberChkXML)  return actionMapping.findForward("acNumberChkXML");
	}
	/**
	 * (Excel)����������� ����Ʈ
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
	 * ����������� ��
	 */
	public ActionForward bankView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");
		String AccountNumber = StringUtil.nvl(
				request.getParameter("AccountNumber"), "");
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
		 */
		BankManageDAO bmDao = new BankManageDAO();
		BankManageDTO bmDto = new BankManageDTO();

		
		bmDto.setAccountNumber(AccountNumber);
		bmDto = bmDao.BankView(bmDto);
		
		
		//replaceAll("-", "") <<2012-01-01 �����ͳ�¥ (-)�߶� ��������.
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
			String msg = "��������  ������ �����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_BankManage.do?cmd=bankPageList&curPage=" + curPageCnt + "back");
		} else {
			return actionMapping.findForward("bankView");
		}
	}
	/**
	 * ����������� ����ó��
	 */
	public ActionForward bankManageEdit(ActionMapping actionMapping,
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
			curPageCnt = StringUtil.nvl(
					multipartRequest.getParameter("curPage"), 1);
			log.debug("PageExcel1:"+curPageCnt);
			searchGb = StringUtil.nvl(
					multipartRequest.getParameter("searchGb"), "");
			searchtxt = StringUtil.nvl(
					multipartRequest.getParameter("searchtxt"), "");
			sForm = StringUtil.nvl(multipartRequest.getParameter("sForm"), "N");
			
			//BankBookFile Request.getparameter �Ѱ��ִ����� ������ ������ ���������ʾ������ �������ִ����� ���������ؼ� 
			BankBookFile = StringUtil.nvl(
					multipartRequest.getParameter("p_BankBookFile"), "");//p_BankBookFile Web(����������)�����ް�  BankBookFile DB�δ���ش�.
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

		msg = "�������� ������ �����Ǿ����ϴ�";
		if (retVal < 1)
			msg = "�������� ���� ������ �����Ͽ����ϴ�";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_BankManage.do?cmd=bankPageList&curPage=" + curPageCnt
				+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt, "back");
	}

	/**
	 * ����������� ���� ����
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

		msg = "������  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "������ �����Ͽ����ϴ�";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_BankManage.do?cmd=bankPageList&curPage=" + curPageCnt, "back");
	}
}
