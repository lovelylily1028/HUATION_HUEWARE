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
import com.huation.common.huebooklist.HueBookListDTO;
import com.huation.common.huebooklist.HueBookListDAO;
import com.huation.common.user.UserBroker;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;
import com.huation.common.util.CommonUtil;
import com.huation.common.util.DateSetter;
import com.huation.common.util.DateUtil;

import com.huation.common.user.UserConnectDTO;

public class HueBookManageAppAction extends StrutsDispatchAction {

	/**
	 * 2012.11.21(수) bsh
	 * HueBook관리 = > 도서결재 리스트
	 * 
	 */
	public ActionForward hueBookAppPageList(ActionMapping actionMapping,
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
		HueBookManageDAO hbDao = new HueBookManageDAO();
		HueBookManageDTO hbDto = new HueBookManageDTO();

		// 리스트

		hbDto.setApprovalUser(USERID);
		hbDto.setvSearchType(searchGb);
		hbDto.setvSearch(searchtxt);
		hbDto.setnRow(10);
		hbDto.setnPage(curPageCnt);

		ListDTO ld = hbDao.hbManageAppPageList(hbDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("hueBookAppPageList");
	}

	/**
	 * 2012.11.21(수) bsh
	 * HueBook관리 = > 등록폼(도서결재 쪽에서사용안함.)
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
	 * HueBook관리 = > 등록처리(도서결재쪽에서 사용안함.)
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
	 * HueBook=>관리 리스트(Excel)
	 */
	public ActionForward hueBookAppExcel(ActionMapping actionMapping,
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
		
		ListDTO ld = hbDao.bookListExcelAPP(hbDto);
		model.put("listInfo", ld);
		model.put("hbDto", hbDto);

		return actionMapping.findForward("hueBookAppExcel");
	}
	/**
	 * 2012-11-23(금) bsh
	 * HueBook관리 = > 도서결재 상세보기.
	 */
	public ActionForward hueBookAppView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N"); //사용자값 sForm으로받아 Y일시 넘겨줌.
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		int SeqPk = StringUtil.nvl(
				request.getParameter("SeqPk"), 0);
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		HueBookManageDAO hbDao = new HueBookManageDAO();
		HueBookManageDTO hbDto = new HueBookManageDTO();
		
		hbDto.setSeqPk(SeqPk);
		hbDto = hbDao.hueBookAppView(hbDto);
		
		Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	  /*  cal.add(Calendar.DATE, -1);*/
	  /*  cal.add(Calendar.MONTH, 2);*/
	     
	    // 특정 형태의 날짜로 값을 뽑기 
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    String strDate = df.format(cal.getTime());
	    System.err.println(strDate);
		
		
		//replaceAll("-", "") <<2012-01-01 데이터날짜 (-)잘라서 꺼내오기. s3(readOnly 버튼없는 달력)
		DateSetter dateSetter1 = new DateSetter(hbDto.getRequestDate().replaceAll("-", ""), "99991231", "s3");
		DateSetter dateSetter2 = new DateSetter(hbDto.getClearDate().replaceAll("-", ""), "99991231", "s3");
		DateSetter dateSetter3 = new DateSetter(hbDto.getBuyDate().replaceAll("-", ""), "99991231", "s3");
		
		// 달력 생성 오늘날짜로 넘겨주는 곳(ex신청중(Update시켜줄 값이 있을때 이 변수로 달력을 가져옴.)
		CommonDAO comDao = new CommonDAO();
		String curDate = comDao.getCurrentDate();
		DateSetter dateSetterUp = new DateSetter(DateUtil.getDayInterval2(0)
				.replaceAll("-", ""), "99991231");
		DateSetter dateSetterUp2 = new DateSetter(DateUtil.getDayInterval2(0)
				.replaceAll("-", ""), "99991231", "s2");
		DateSetter dateSetterUp3 = new DateSetter(DateUtil.getDayInterval2(0)
				.replaceAll("-", ""), "99991231", "s3");
		model.put("hbDto", hbDto);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("dateSetter1", dateSetter1);
		model.put("dateSetter2", dateSetter2);
		model.put("dateSetter3", dateSetter3);
		model.put("curDate", curDate);
		model.put("dateSetterUp3", dateSetterUp3);
		model.put("dateSetterUp2", dateSetterUp2);
		model.put("dateSetterUp", dateSetterUp);
		model.put("strDate", strDate);
		model.put("sFrom", sForm);
		if (hbDto == null) {
			String msg = "등록된 도서  정보가 없습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_HueBookManageApp.do?cmd=hueBookAppPageList&curPage=" + curPageCnt + "back");
		} else {
			return actionMapping.findForward("hueBookAppView");
		}
	}
	/**
	 * 2012-11-28(수) bsh.
	 * HueBook관리=> 도서결재(결재)UPDATE
	 */
	public ActionForward hueBookManageAppEditY(ActionMapping actionMapping,
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
		int SeqPk = StringUtil
		.nvl(request.getParameter("SeqPk"), 1);
		String status = StringUtil.nvl(
				request.getParameter("status"), "2");
		String approvalAndReturn = StringUtil.nvl(
				request.getParameter("approvalAndReturn"), "");
		String clearDate = StringUtil.nvl(
				request.getParameter("clearDate"), "");
		String approvalUser = StringUtil.nvl(
				request.getParameter("approvalUser"), "");
		
		HueBookManageDAO hbDao = new HueBookManageDAO();
		HueBookManageDTO hbDto = new HueBookManageDTO();
		
		hbDto.setSeqPk(SeqPk);
		hbDto.setStatus(status);
		hbDto.setApprovalAndReturn(approvalAndReturn);
		hbDto.setClearDate(clearDate);
		hbDto.setApprovalUser(approvalUser);
		retVal = hbDao.updateBookManageApp(hbDto);

		msg = "도서결재가 완료되었습니다";
		if (retVal < 1)
			msg = "도서결재가 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_HueBookManageApp.do?cmd=hueBookAppPageList&curPage=" + curPageCnt, "back");
	}

	/**
	 * 2012-11-28(수) bsh.
	 * HueBook관리=> 도서결재(구매완료)UPDATE
	 */
	public ActionForward hueBookManageAppEditBuy(ActionMapping actionMapping,
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
		int SeqPk = StringUtil
		.nvl(request.getParameter("SeqPk"), 1);
		String status = StringUtil.nvl(
				request.getParameter("status"), "3");
		String buyDate = StringUtil.nvl(
				request.getParameter("buyDate"), "");
		int buyPrice = StringUtil.nvl(
				request.getParameter("buyPrice"), 0);
		String approvalUser = StringUtil.nvl(
				request.getParameter("approvalUser"), "");
		String purchasingOffice = StringUtil.nvl(
				request.getParameter("purchasingOffice"), "");
		String updateYN = StringUtil.nvl(
				request.getParameter("updateYN"), "N");
		String hueBookCode = StringUtil.nvl(
				request.getParameter("hueBookCode"), "");
		
		HueBookManageDAO hbDao = new HueBookManageDAO();
		HueBookManageDTO hbDto = new HueBookManageDTO();
		
		hbDto.setSeqPk(SeqPk);
		hbDto.setStatus(status);
		hbDto.setBuyDate(buyDate);
		hbDto.setBuyPrice(buyPrice);
		hbDto.setApprovalUser(approvalUser);
		hbDto.setPurchasingOffice(purchasingOffice);
		retVal = hbDao.updateBookManageBuy(hbDto);
		
		/*status=3(구매완료) 값 3 넘어올시 휴북목록 데이터 자동등록 (INSERT)
		* 2012.11.29(목) bsh.
		* HueBook관리=>휴북목록 등록하기.
		* log에서 첫번째 hueBookCode값 Null(정상) DB프로시저에서 코드값 셋팅해줌.
		*/
		String statusBuy = "3";
		if(status.equals(statusBuy)){
			
			int retVal2 = -1;
			
			String branchCode = StringUtil.nvl(
					request.getParameter("branchCode"), "");
			String bookName = StringUtil.nvl(
					request.getParameter("bookName"), "");
			String publisher = StringUtil.nvl(
					request.getParameter("publisher"), "");
			String writer = StringUtil.nvl(
					request.getParameter("writer"), "");
			String requestUser = StringUtil.nvl(
					request.getParameter("requestUser"), "");
			String requestDate = StringUtil.nvl(
					request.getParameter("requestDate"), "");
			approvalUser = StringUtil.nvl(
					request.getParameter("approvalUser"), "");
			String clearDate = StringUtil.nvl(
					request.getParameter("clearDate"), "");
			
			//구매완료 htHueBookList 등록시킬 동일한 PARAM NAME명
			purchasingOffice = StringUtil.nvl(
					request.getParameter("purchasingOffice"), "");

			buyPrice = StringUtil.nvl(
					request.getParameter("buyPrice"), 0);

			buyDate = StringUtil.nvl(
					request.getParameter("buyDate"), "");

			
			HueBookListDTO hlDto = new HueBookListDTO();
			HueBookListDAO hlDao = new HueBookListDAO();
			
			hlDto.setBranchCode(branchCode);
			hlDto.setBookName(bookName);
			hlDto.setPublisher(publisher);
			hlDto.setWriter(writer);
			hlDto.setPurchasingOffice(purchasingOffice);
			hlDto.setRequestUser(requestUser);
			hlDto.setRequestDate(requestDate);
			hlDto.setApprovalUser(approvalUser);
			hlDto.setClearDate(clearDate);
			hlDto.setBuyPrice(buyPrice);
			hlDto.setBuyDate(buyDate);
			//업데이트 유무 추가. //휴북코드추가
			hlDto.setUpdateYN(updateYN);
			hlDto.setHueBookCode(hueBookCode);
			retVal2 = hlDao.insertBookList(hlDto);

			
		}
		
		msg = "도서구매가 완료되었습니다";
		if (retVal < 1)
			msg = "도서구매가 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_HueBookManageApp.do?cmd=hueBookAppPageList&curPage=" + curPageCnt, "back");
	}
	
	/**
	 * 2012-11-28(수) bsh.
	 * HueBook관리=> 도서결재(반려)UPDATE
	 */
	public ActionForward hueBookManageAppEditRT(ActionMapping actionMapping,
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
		int SeqPk = StringUtil
		.nvl(request.getParameter("SeqPk"), 1);
		String status = StringUtil.nvl(
				request.getParameter("status"), "4");
		String approvalUser = StringUtil.nvl(
				request.getParameter("approvalUser"), ""); //반려결재자
		String approvalAndReturn = StringUtil.nvl(
				request.getParameter("approvalAndReturn"), "");
		
		HueBookManageDAO hbDao = new HueBookManageDAO();
		HueBookManageDTO hbDto = new HueBookManageDTO();
		
		hbDto.setSeqPk(SeqPk);
		hbDto.setStatus(status);
		hbDto.setApprovalUser(approvalUser);
		hbDto.setApprovalAndReturn(approvalAndReturn);
		retVal = hbDao.updateBookManageRT(hbDto);

		msg = "해당도서가 반려되었습니다";
		if (retVal < 1)
			msg = "해당도서가 반려되지 않았습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_HueBookManageApp.do?cmd=hueBookAppPageList&curPage=" + curPageCnt, "back");
	}

}
