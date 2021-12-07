package com.huation.hueware.huebooklist.action;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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

import com.huation.common.huebooklist.HueBookListDAO;
import com.huation.common.huebooklist.HueBookListDTO;
import com.huation.common.user.UserBroker;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;
import com.huation.common.util.CommonUtil;
import com.huation.common.util.DateSetter;
import com.huation.common.util.DateUtil;

import com.huation.common.user.UserConnectDTO;

public class HueBookListAction extends StrutsDispatchAction {

	/**
	 * 2012.11.28(수) bsh
	 * HueBook관리 = > 휴북목록 리스트
	 * 
	 */
	public ActionForward hueBookPageList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), ""); //검색구분
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), ""); //검색명
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		/*
		 * if(USERID.equals("")){ String rtnUrl =
		 * request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		 * goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		 */
		HueBookListDAO hlDao = new HueBookListDAO();
		HueBookListDTO hlDto = new HueBookListDTO();

		// 리스트

		hlDto.setRequestUser(USERID);
		hlDto.setvSearchType(searchGb);
		hlDto.setvSearch(searchtxt);
		hlDto.setnRow(10);
		hlDto.setnPage(curPageCnt);

		ListDTO ld = hlDao.hbManagePageList(hlDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("hueBookPageList");
	}

	/**
	 * 2012.11.21(수) bsh
	 * HueBook관리 = > 등록폼(현재사용안함)
	public ActionForward hueBookReRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		// 달력 생성 넘겨주는값.
		CommonDAO comDao = new CommonDAO();
		String curDate = comDao.getCurrentDate();
		
		DateSetter dateSetter3 = new DateSetter(DateUtil.getDayInterval2(0) //금일날짜
				.replaceAll("-", ""), "99991231", "s3");

		model.put("curPage", String.valueOf(curPageCnt));
		model.put("curDate", curDate);
		model.put("dateSetter3", dateSetter3);
		return actionMapping.findForward("hueBookReRegistForm");
	}

	 */
	/**
	 * 2012.11.21(수) bsh
	 * HueBook관리 = > 등록처리(현재사용안함)
	public ActionForward hueBookReRegist(ActionMapping actionMapping,
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
		
		int curPageCnt = StringUtil
				.nvl(request.getParameter("curPage"), 1);
		String requestUser = StringUtil.nvl(
				request.getParameter("requestUser"), "");
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

		msg = "도서신청이 정상처리되었습니다";
		if (retVal < 1)
			msg = "도서신청이 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_HueBookManageRe.do?cmd=hueBookRePageList&curPage=" + curPageCnt, "back");
	}

	 */
	/**
	 * 2012-11-23(금) bsh.
	 * HueBook=>휴북목록 리스트(Excel)
	 */
	public ActionForward hueBookExcelList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		HueBookListDAO hlDao = new HueBookListDAO();
		HueBookListDTO hlDto = new HueBookListDTO();
		
		hlDto.setRequestUser(USERID);
		hlDto.setnRow(10);
		hlDto.setnPage(1);
		
		ListDTO ld = hlDao.bookListExcel(hlDto);
		model.put("listInfo", ld);
		model.put("hlDto", hlDto);

		return actionMapping.findForward("hueBookExcelList");
	}
	/**
	 * 2012-11-29(목) bsh.
	 * HueBook관리 = > 휴북목록 상세보기.
	 */
	public ActionForward hueBookView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String hueBookCode = StringUtil.nvl(
				request.getParameter("hueBookCode"), "");
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		HueBookListDAO hlDao = new HueBookListDAO();
		HueBookListDTO hlDto = new HueBookListDTO();
		
		hlDto.setHueBookCode(hueBookCode);
		hlDto = hlDao.hueBookView(hlDto);
		
		//replaceAll("-", "") <<2012-01-01 데이터날짜 (-)잘라서 꺼내오기. s3(readOnly 버튼없는 달력)
		DateSetter dateSetter1 = new DateSetter(hlDto.getRequestDate().replaceAll("-", ""), "99991231", "s3");
		DateSetter dateSetter2 = new DateSetter(hlDto.getClearDate().replaceAll("-", ""), "99991231", "s3");
		DateSetter dateSetter3 = new DateSetter(hlDto.getBuyDate().replaceAll("-", ""), "99991231", "s3");
		
		model.put("hlDto", hlDto);
		model.put("dateSetter1", dateSetter1);
		model.put("dateSetter2", dateSetter2);
		model.put("dateSetter3", dateSetter3);
		model.put("curPage", String.valueOf(curPageCnt));
		if (hlDto == null) {
			String msg = "휴북도서  정보가 없습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_HueBookList.do?cmd=hueBookPageList&curPage=" + curPageCnt + "back");
		} else {
			return actionMapping.findForward("hueBookView");
		}
	}
	/**
	 * 2012-11-29(목) bsh.
	 * HueBook관리=> 휴북목록(수정)
	 */
	public ActionForward hueBookListEdit(ActionMapping actionMapping,
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

		int curPageCnt = StringUtil
		.nvl(request.getParameter("curPage"), 1);
		String hueBookCode = StringUtil
		.nvl(request.getParameter("hueBookCode"), "");
		String bookName = StringUtil.nvl(
				request.getParameter("bookName"), "");
		String writer = StringUtil.nvl(
				request.getParameter("writer"), "");
		String branchCode = StringUtil.nvl(
				request.getParameter("branchCode"), "");
		String publisher = StringUtil.nvl(
				request.getParameter("publisher"), "");
		String useYN = StringUtil.nvl(
				request.getParameter("useYN"), "");
		
		HueBookListDAO hlDao = new HueBookListDAO();
		HueBookListDTO hlDto = new HueBookListDTO();
		
		hlDto.setHueBookCode(hueBookCode);
		hlDto.setBranchCode(branchCode);
		hlDto.setBookName(bookName);
		hlDto.setPublisher(publisher);
		hlDto.setWriter(writer);
		hlDto.setUseYN(useYN);
		retVal = hlDao.updateBookList(hlDto);

		msg = "휴북목록 도서 정보가 수정되었습니다";
		if (retVal < 1)
			msg = "휴북목록 도서 정보 수정이 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_HueBookList.do?cmd=hueBookPageList&curPage=" + curPageCnt, "back");
	}

	/**
	 * 2012-11-29(목) bsh.
	 * HueBook관리 = 휴북목록(삭제)
	 */
	public ActionForward hueBookDelete(ActionMapping actionMapping,
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
		String hueBookCode = StringUtil.nvl(request.getParameter("hueBookCode"), "");

		HueBookListDAO hlDao = new HueBookListDAO();
		HueBookListDTO hlDto = new HueBookListDTO();

		hlDto.setHueBookCode(hueBookCode);
		retVal = hlDao.deleteBookListOne(hlDto);

		msg = "휴북 도서목록을  삭제하였습니다";
		if (retVal < 1)
			msg = "휴북 도서목록 삭제를 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_HueBookList.do?cmd=hueBookPageList&curPage=" + curPageCnt, "back");
	}
}
