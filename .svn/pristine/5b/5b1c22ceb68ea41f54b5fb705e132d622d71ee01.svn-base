package com.huation.hueware.huebookmanage.action;

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

import com.huation.common.huebookmanage.HueBookManageDAO;
import com.huation.common.huebookmanage.HueBookManageDTO;
import com.huation.common.user.UserBroker;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;
import com.huation.common.util.CommonUtil;
import com.huation.common.util.DateSetter;
import com.huation.common.util.DateUtil;

import com.huation.common.user.UserConnectDTO;

public class HueBookManageReAction extends StrutsDispatchAction {

	/**
	 * 2012.11.21(��) bsh
	 * HueBook���� = > ������û ����Ʈ
	 * 
	 */
	public ActionForward hueBookRePageList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "1"); //�˻�����
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), ""); //�˻���
		
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
		 */
		HueBookManageDAO hbDao = new HueBookManageDAO();
		HueBookManageDTO hbDto = new HueBookManageDTO();

		// ����Ʈ

		hbDto.setRequestUser(USERID);
		hbDto.setvSearchType(searchGb);
		hbDto.setvSearch(searchtxt);
		hbDto.setnRow(10);
		hbDto.setnPage(curPageCnt);

		ListDTO ld = hbDao.hbManageRePageList(hbDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("hueBookRePageList");
	}

	/**
	 * 2012.11.21(��) bsh
	 * HueBook���� = > �����
	 */
	public ActionForward hueBookReRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		
		Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	   /* cal.add(Calendar.DATE, -1);*/
	  /*  cal.add(Calendar.MONTH, 2);*/
	     
	    // Ư�� ������ ��¥�� ���� �̱� 
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    String strDate = df.format(cal.getTime());
	    System.err.println(strDate);
		
		
		
		
		// �޷� ���� �Ѱ��ִ°�.
		CommonDAO comDao = new CommonDAO();
		String curDate = comDao.getCurrentDate();
		
		DateSetter dateSetter3 = new DateSetter(DateUtil.getDayInterval2(0) //���ϳ�¥
				.replaceAll("-", ""), "99991231", "s3");

		model.put("curPage", String.valueOf(curPageCnt));
		model.put("curDate", curDate);
		model.put("dateSetter3", dateSetter3);
		model.put("strDate", strDate);
		return actionMapping.findForward("hueBookReRegistForm");
	}

	/**
	 * 2012.11.21(��) bsh
	 * HueBook���� = > ���ó��
	 */
	public ActionForward hueBookReRegist(ActionMapping actionMapping,
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
		
		int curPageCnt = StringUtil
				.nvl(request.getParameter("curPage"), 1);
		String requestUser = StringUtil.nvl(
				request.getParameter("requestUser"), "");
		String requestName = StringUtil.nvl(
				request.getParameter("requestName"), "");
		String bookName = StringUtil.nvl(
				request.getParameter("bookName"), "");
		String writer = StringUtil.nvl(
				request.getParameter("writer"), "");
		int price = StringUtil.nvl(
				request.getParameter("price"), 0);
		String branchCode = StringUtil.nvl(
				request.getParameter("branchCode"), "");
		String publisher = StringUtil.nvl(
				request.getParameter("publisher"), "");
		String translator = StringUtil.nvl(
				request.getParameter("translator"), "");
		String requestBookCount = StringUtil.nvl(
				request.getParameter("requestBookCount"), "");
		String contents = StringUtil.nvl(
				request.getParameter("contents"), "");
		String status = StringUtil.nvl(
				request.getParameter("status"), "");
		String requestDate = StringUtil.nvl(
				request.getParameter("requestDate"), "");

		HueBookManageDAO hbDao = new HueBookManageDAO();
		HueBookManageDTO hbDto = new HueBookManageDTO();

		hbDto.setRequestUser(requestUser);
		hbDto.setRequestName(requestName);
		hbDto.setBookName(bookName);
		hbDto.setWriter(writer);
		hbDto.setPrice(price);
		hbDto.setBranchCode(branchCode);
		hbDto.setPublisher(publisher);
		hbDto.setTranslator(translator);
		hbDto.setRequestBookCount(requestBookCount);
		hbDto.setContents(contents);
		hbDto.setStatus(status);
		hbDto.setRequestDate(requestDate);

		retVal = hbDao.addReHueBookManage(hbDto);

		msg = "������û�� ����ó���Ǿ����ϴ�";
		if (retVal < 1)
			msg = "������û�� �����Ͽ����ϴ�";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_HueBookManageRe.do?cmd=hueBookRePageList&curPage=" + curPageCnt, "back");
	}

	/**
	 * 2012-11-23(��) bsh.
	 * HueBook=>���� ����Ʈ(Excel)
	 */
	public ActionForward HueBookReExcelList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		log.debug("Page1:"+curPageCnt);
		HueBookManageDAO hbDao = new HueBookManageDAO();
		HueBookManageDTO hbDto = new HueBookManageDTO();
		
		hbDto.setRequestUser(USERID);
		hbDto.setnRow(10);
		hbDto.setnPage(1);
		
		ListDTO ld = hbDao.bookListExcel(hbDto);
		model.put("listInfo", ld);
		model.put("bmDto", hbDto);

		return actionMapping.findForward("HueBookReExcelList");
	}
	/**
	 * 2012-11-22(��) bsh
	 * HueBook���� = > ������û �󼼺���.
	 */
	public ActionForward hueBookReView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		int SeqPk = StringUtil.nvl(
				request.getParameter("SeqPk"), 0);
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		
		HueBookManageDAO hbDao = new HueBookManageDAO();
		HueBookManageDTO hbDto = new HueBookManageDTO();
		
		hbDto.setSeqPk(SeqPk);
		hbDto = hbDao.hueBookReView(hbDto);
		
		
		//replaceAll("-", "") <<2012-01-01 �����ͳ�¥ (-)�߶� ��������.
		log.debug("DATE:"+hbDto.getRequestDate());
		DateSetter dateSetter1 = new DateSetter(hbDto.getRequestDate().replaceAll("-", ""), "99991231", "s3");
		DateSetter dateSetter2 = new DateSetter(hbDto.getClearDate().replaceAll("-", ""), "99991231", "s3");
		DateSetter dateSetter3 = new DateSetter(hbDto.getBuyDate().replaceAll("-", ""), "99991231", "s3");
		
		model.put("hbDto", hbDto);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("dateSetter1", dateSetter1);
		model.put("dateSetter2", dateSetter2);
		model.put("dateSetter3", dateSetter3);
		if (hbDto == null) {
			String msg = "������û  ������ �����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_HueBookManageRe.do?cmd=hueBookRePageList&curPage=" + curPageCnt + "back");
		} else {
			return actionMapping.findForward("hueBookReView");
		}
	}
	/**
	 * 2012-11-23(��) bsh.
	 * HueBook����=> ������û(����)
	 */
	public ActionForward hueBookManageEdit(ActionMapping actionMapping,
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

		int curPageCnt = StringUtil
		.nvl(request.getParameter("curPage"), 1);
		int SeqPk = StringUtil
		.nvl(request.getParameter("SeqPk"), 1);
		String requestUser = StringUtil.nvl(
				request.getParameter("requestUser"), "");
		String requestName = StringUtil.nvl(
				request.getParameter("requestName"), "");
		String bookName = StringUtil.nvl(
				request.getParameter("bookName"), "");
		String writer = StringUtil.nvl(
				request.getParameter("writer"), "");
		int price = StringUtil.nvl(
				request.getParameter("price"), 0);
		String branchCode = StringUtil.nvl(
				request.getParameter("branchCode"), "");
		String publisher = StringUtil.nvl(
				request.getParameter("publisher"), "");
		String translator = StringUtil.nvl(
				request.getParameter("translator"), "");
		String requestBookCount = StringUtil.nvl(
				request.getParameter("requestBookCount"), "");
		String contents = StringUtil.nvl(
				request.getParameter("contents"), "");
		String status = StringUtil.nvl(
				request.getParameter("status"), "");
		String requestDate = StringUtil.nvl(
				request.getParameter("requestDate"), "");
		String updateUser = StringUtil.nvl(
				request.getParameter("updateUser"), "");
		
		HueBookManageDAO hbDao = new HueBookManageDAO();
		HueBookManageDTO hbDto = new HueBookManageDTO();
		
		hbDto.setSeqPk(SeqPk);
		hbDto.setRequestUser(requestUser);
		hbDto.setRequestName(requestName);
		hbDto.setBookName(bookName);
		hbDto.setWriter(writer);
		hbDto.setRequestDate(requestDate);
		hbDto.setPrice(price);
		hbDto.setBranchCode(branchCode);
		hbDto.setPublisher(publisher);
		hbDto.setTranslator(translator);
		hbDto.setRequestBookCount(requestBookCount);
		hbDto.setContents(contents);
		hbDto.setStatus(status);
		hbDto.setUpdateUser(updateUser);
		retVal = hbDao.updateBookManage(hbDto);

		msg = "������û ������ �����Ǿ����ϴ�";
		if (retVal < 1)
			msg = "������û ���� ������ �����Ͽ����ϴ�";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_HueBookManageRe.do?cmd=hueBookRePageList&curPage=" + curPageCnt, "back");
	}

	/**
	 * 2012-11-23(��) bsh.
	 * HueBook���� = ������û(����)
	 */
	public ActionForward hueBookReDelete(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		String msg = "";
		int retVal = 0;
		int curPageCnt = StringUtil
				.nvl(request.getParameter("curPage"), 1);
		int SeqPk = StringUtil.nvl(request.getParameter("SeqPk"), 1);

		HueBookManageDAO hbDao = new HueBookManageDAO();
		HueBookManageDTO hbDto = new HueBookManageDTO();

		hbDto.setSeqPk(SeqPk);
		retVal = hbDao.deleteBookManageOne(hbDto);

		msg = "������û �����  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "������ �����Ͽ����ϴ�";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_HueBookManageRe.do?cmd=hueBookRePageList&curPage=" + curPageCnt, "back");
	}
}
