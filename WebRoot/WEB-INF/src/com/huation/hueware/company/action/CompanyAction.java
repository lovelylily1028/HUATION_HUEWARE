package com.huation.hueware.company.action;

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

import com.huation.common.*;
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

import com.huation.common.project.NonProjectDAO;
import com.huation.common.project.NonProjectDTO;
import com.huation.common.user.UserBroker;
import com.huation.common.util.CommonUtil;
import com.huation.common.util.DateSetter;
import com.huation.common.user.UserMemDTO;
import com.huation.common.user.UserConnectDTO;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;

import com.huation.common.company.CompanyDAO;
import com.huation.common.company.CompanyDTO;
import com.huation.common.currentstatus.*;

public class CompanyAction extends StrutsDispatchAction {
	/**
	 * 업체리스트
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward companyPageList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		//미등록업체 조회 추가 2013_03_18(월)shbyeon.(search) 현재사용안함.
		String search = StringUtil.nvl(request.getParameter("search"), "");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);

		CompanyDAO compDao = new CompanyDAO();
		CompanyDTO compDto = new CompanyDTO();

		ListDTO ld = compDao.companyPageList(curPageCnt, search, searchGb, searchtxt,
				"Y","Y", 20, 10);

		model.put("listInfo", ld);
		model.put("compDto", compDto);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("search", search);
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("companyPageList");
	}
	
	
	/**
	 * 업체리스트
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward companyPageList2(ActionMapping actionMapping,
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
	
	
		String FilePath = FileUtil.FILE_DIR + "company/"
			+ DateTimeUtil.getDate() + "/";
			UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
					10);
			MultipartRequest multipartRequest = null;
			multipartRequest = uploadEntity.getMultipart();
				
		//미등록업체 조회 추가 2013_03_18(월)shbyeon.(search) 현재사용안함.
		String search = StringUtil.nvl(multipartRequest.getParameter("search"), "");
		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);

		CompanyDAO compDao = new CompanyDAO();
		CompanyDTO compDto = new CompanyDTO();

		ListDTO ld = compDao.companyPageList(curPageCnt, search, searchGb, searchtxt, "Y","Y", 20, 10);
		
		model.put("listInfo", ld);
		model.put("compDto", compDto);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("search", search);
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("companyPageList");
	}


	/**
	 * 업체등록폼
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward companyRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		log.debug("업체등록");

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");

		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		// 로그인 처리 끝.

		CommonDAO comDao = new CommonDAO();
		// String curDate = comDao.getCurrentDate();
		String curDate = "";
		DateSetter dateSetter = new DateSetter(curDate, "99991231");

		model.put("curDate", curDate);
		model.put("dateSetter", dateSetter);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("sForm", sForm);

		return actionMapping.findForward("companyRegistForm");
	}

	/**
	 * 업체 등록처리
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward companyRegist(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "company/"
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

		String comp_file = "";
		String account_copy1 = "";
		String account_copy2 = "";
		String account_copy3 = "";
		String account_copy4 = "";
		String account_copy5 = "";

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

					if (objName.equals("comp_file")) {
						comp_file = uploadFilePath;
					} else if (objName.equals("account_copy1")) {
						account_copy1 = uploadFilePath;
					} else if (objName.equals("account_copy2")) {
						account_copy2 = uploadFilePath;
					} else if (objName.equals("account_copy3")) {
						account_copy3 = uploadFilePath;
					} else if (objName.equals("account_copy4")) {
						account_copy4 = uploadFilePath;
					} else if (objName.equals("account_copy5")) {
						account_copy5 = uploadFilePath;
					}

				}
			}
		}
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
		sForm = StringUtil.nvl(multipartRequest.getParameter("sForm"), "N");

		String permit_no = StringUtil.nvl(
				multipartRequest.getParameter("permit_no"), "");
		String comp_nm = StringUtil.nvl(
				multipartRequest.getParameter("comp_nm"), "");
		String comp_no = StringUtil.nvl(
				multipartRequest.getParameter("comp_no"), "");
		String owner_nm = StringUtil.nvl(
				multipartRequest.getParameter("owner_nm"), "");
		String business = StringUtil.nvl(
				multipartRequest.getParameter("business"), "");
		String b_item = StringUtil.nvl(multipartRequest.getParameter("b_item"),
				"");
		String address = StringUtil.nvl(
				multipartRequest.getParameter("address"), "");
		String addr_detail = StringUtil.nvl(
				multipartRequest.getParameter("addr_detail"), "");
		String post = StringUtil.nvl(multipartRequest.getParameter("post"), "");
		String open_dt = StringUtil.nvl(
				multipartRequest.getParameter("open_dt"), "");
		String charge_nm = StringUtil.nvl(
				multipartRequest.getParameter("charge_nm"), "");
		String charge_email = StringUtil.nvl(
				multipartRequest.getParameter("charge_email"), "");
		String COMPANY_FILENM = StringUtil.nvl(
				multipartRequest.getParameter("COMPANY_FILENM"), "");
		String ACCOUNT_COPYNM1 = StringUtil.nvl(
				multipartRequest.getParameter("ACCOUNT_COPYNM1"), "");
		String COMPANYEVALUATION = StringUtil.nvl( 
				multipartRequest.getParameter("COMPANYEVALUATION"),"");
		CompanyDAO compDao = new CompanyDAO();
		CompanyDTO compDto = new CompanyDTO();

		// comp_code = compDao.getCompCode(compDao.getCompCntNext());
		compDto.setPermit_no(permit_no);
		compDto.setComp_nm(comp_nm);
		compDto.setComp_no(comp_no);
		compDto.setOwner_nm(owner_nm);
		compDto.setBusiness(business);
		compDto.setB_item(b_item);
		compDto.setAddress(address);
		compDto.setAddr_detail(addr_detail);
		compDto.setPost(post);
		compDto.setReg_id(USERID);
		compDto.setOpen_dt(open_dt);
		compDto.setCharge_nm(charge_nm);
		compDto.setCharge_email(charge_email);
		
		compDto.setComp_file(comp_file);
		compDto.setAccount_copy1(account_copy1);
		compDto.setAccount_copy2(account_copy2);
		compDto.setAccount_copy3(account_copy3);
		compDto.setAccount_copy4(account_copy4);
		compDto.setAccount_copy5(account_copy5);
		compDto.setCOMPANY_FILENM(COMPANY_FILENM);
		compDto.setACCOUNT_COPYNM1(ACCOUNT_COPYNM1);
		compDto.setCOMPANYEVALUATION(COMPANYEVALUATION);
		retVal = compDao.addCompany(compDto);

		msg = "업체 등록에 성공했습니다.";
		if (retVal < 1)
			msg = "업체 등록에 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_Company.do?cmd=companyPageList&curPage=" + curPageCnt
				+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt, "back");

	}

	/**
	 * 업체상세정보
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward companyView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;
		String comp_code = ""; // 업체코드

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");
		comp_code = StringUtil.nvl(request.getParameter("comp_code"));

		CompanyDAO compDao = new CompanyDAO();
		CompanyDTO compDto = new CompanyDTO();

		compDto = compDao.getCompanyView(comp_code);

		DateSetter dateSetter = new DateSetter(compDto.getOpen_dt(), "99991231");

		model.put("dateSetter", dateSetter);
		model.put("compDto", compDto);

		model.put("curPage", String.valueOf(curPageCnt));
		model.put("comp_code", comp_code);
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("sForm", sForm);
		model.put("UserID", compDto.getUnfit_id());
		
		System.out.println(compDto.getUnfit_id());

		if (compDto == null) {
			String msg = "해당  업체  정보가 없습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_Company.do?cmd=companyPageList&curPage=" + curPageCnt
					+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt,
					"back");
		} else {
			return actionMapping.findForward("companyView");
		}
	}

	/**
	 * 업체정보를 수정한다.
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward companyEdit(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);
		
		
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		
		String userID = USERID;
		
		int retVal = -1;
		String msg = "";

		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "company/"
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

		String comp_file = "";
		String account_copy1 = "";
		String account_copy2 = "";
		String account_copy3 = "";
		String account_copy4 = "";
		String account_copy5 = "";

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

			comp_file = StringUtil.nvl(
					multipartRequest.getParameter("p_comp_file"), "");
			account_copy1 = StringUtil.nvl(
					multipartRequest.getParameter("p_account_copy1"), "");
			account_copy2 = StringUtil.nvl(
					multipartRequest.getParameter("p_account_copy2"), "");
			account_copy3 = StringUtil.nvl(
					multipartRequest.getParameter("p_account_copy3"), "");
			account_copy4 = StringUtil.nvl(
					multipartRequest.getParameter("p_account_copy4"), "");
			account_copy5 = StringUtil.nvl(
					multipartRequest.getParameter("p_account_copy5"), "");

			// 업로드된 파일의 정보를 가져와서 데이터 베이스에 넣는 작업을 해준다.
			log.debug("첨부 파일을 첨부하는데 성공하였습니다.");
			ArrayList files = uploadEntity.getFiles();
			UploadFile file = null;
			for (int i = 0; i < files.size(); i++) {
				file = (UploadFile) files.get(i);
				objName = file.getObjName();
				rFileName = StringUtil.nvl(file.getRootName());

				if (objName.equals("comp_file")) {

					if (!rFileName.equals("")) {
						sFileName = file.getUploadName();
						filePath = uploadEntity.getUploadPath();
						log.debug(" 파일 오브젝트명 =>" + objName + ", 원 파일 명 =>"
								+ rFileName + ", 저장파일명 =>" + sFileName
								+ ",파일 사이즈 =>" + fileSize + ", 저장 파일 패스 =>"
								+ filePath);
						comp_file = filePath + sFileName;
					}
				}
				if (objName.equals("account_copy1")) {

					if (!rFileName.equals("")) {
						sFileName = file.getUploadName();
						filePath = uploadEntity.getUploadPath();
						log.debug(" 파일 오브젝트명 =>" + objName + ", 원 파일 명 =>"
								+ rFileName + ", 저장파일명 =>" + sFileName
								+ ",파일 사이즈 =>" + fileSize + ", 저장 파일 패스 =>"
								+ filePath);
						account_copy1 = filePath + sFileName;
					}
				}
				if (objName.equals("account_copy2")) {

					if (!rFileName.equals("")) {
						sFileName = file.getUploadName();
						filePath = uploadEntity.getUploadPath();
						log.debug(" 파일 오브젝트명 =>" + objName + ", 원 파일 명 =>"
								+ rFileName + ", 저장파일명 =>" + sFileName
								+ ",파일 사이즈 =>" + fileSize + ", 저장 파일 패스 =>"
								+ filePath);
						account_copy2 = filePath + sFileName;
					}
				}
				if (objName.equals("account_copy3")) {

					if (!rFileName.equals("")) {
						sFileName = file.getUploadName();
						filePath = uploadEntity.getUploadPath();
						log.debug(" 파일 오브젝트명 =>" + objName + ", 원 파일 명 =>"
								+ rFileName + ", 저장파일명 =>" + sFileName
								+ ",파일 사이즈 =>" + fileSize + ", 저장 파일 패스 =>"
								+ filePath);
						account_copy3 = filePath + sFileName;
					}
				}
				if (objName.equals("account_copy4")) {

					if (!rFileName.equals("")) {
						sFileName = file.getUploadName();
						filePath = uploadEntity.getUploadPath();
						log.debug(" 파일 오브젝트명 =>" + objName + ", 원 파일 명 =>"
								+ rFileName + ", 저장파일명 =>" + sFileName
								+ ",파일 사이즈 =>" + fileSize + ", 저장 파일 패스 =>"
								+ filePath);
						account_copy4 = filePath + sFileName;
					}
				}
				if (objName.equals("account_copy5")) {

					if (!rFileName.equals("")) {
						sFileName = file.getUploadName();
						filePath = uploadEntity.getUploadPath();
						log.debug(" 파일 오브젝트명 =>" + objName + ", 원 파일 명 =>"
								+ rFileName + ", 저장파일명 =>" + sFileName
								+ ",파일 사이즈 =>" + fileSize + ", 저장 파일 패스 =>"
								+ filePath);
						account_copy5 = filePath + sFileName;
					}
				}

			}
		}

		String comp_code = StringUtil.nvl(
				multipartRequest.getParameter("comp_code"), "");
		String permit_no = StringUtil.nvl(
				multipartRequest.getParameter("permit_no"), ""); //업체관리코드 추가 2013_03_18(월) shbyeon.
		String comp_nm = StringUtil.nvl(
				multipartRequest.getParameter("comp_nm"), "");
		String comp_no = StringUtil.nvl(
				multipartRequest.getParameter("comp_no"), "");
		String owner_nm = StringUtil.nvl(
				multipartRequest.getParameter("owner_nm"), "");
		String business = StringUtil.nvl(
				multipartRequest.getParameter("business"), "");
		String b_item = StringUtil.nvl(multipartRequest.getParameter("b_item"),
				"");
		String address = StringUtil.nvl(
				multipartRequest.getParameter("address"), "");
		String addr_detail = StringUtil.nvl(
				multipartRequest.getParameter("addr_detail"), "");
		String post = StringUtil.nvl(multipartRequest.getParameter("post"), "");
		String open_dt = StringUtil.nvl(
				multipartRequest.getParameter("open_dt"), "");
		String charge_nm = StringUtil.nvl(
				multipartRequest.getParameter("charge_nm"), "");
		String charge_email = StringUtil.nvl(
				multipartRequest.getParameter("charge_email"), "");
		String COMPANY_FILENM = StringUtil.nvl(
				multipartRequest.getParameter("COMPANY_FILENM"), "");
		String ACCOUNT_COPYNM1 = StringUtil.nvl(
				multipartRequest.getParameter("ACCOUNT_COPYNM1"), "");
		String COMPANYEVALUATION = StringUtil.nvl( 
				multipartRequest.getParameter("COMPANYEVALUATION"),"");
		String unfit_reason = StringUtil.nvl( 
				multipartRequest.getParameter("unfit_reason"),"");
		String business_check = StringUtil.nvl( 
				multipartRequest.getParameter("business_check"),"");
		String date = StringUtil.nvl( 
				multipartRequest.getParameter("date"),"");
		String unfit_id = StringUtil.nvl( 
				multipartRequest.getParameter("unfit_id"),"");
				
		CompanyDAO compDao = new CompanyDAO();
		CompanyDTO compDto = new CompanyDTO();

		compDto.setComp_code(comp_code);
		compDto.setPermit_no(permit_no);
		compDto.setComp_nm(comp_nm);
		compDto.setComp_no(comp_no);
		compDto.setOwner_nm(owner_nm);
		compDto.setBusiness(business);
		compDto.setB_item(b_item);
		compDto.setAddress(address);
		compDto.setAddr_detail(addr_detail);
		compDto.setPost(post);
		compDto.setMod_id(USERID);
		compDto.setOpen_dt(open_dt);
		compDto.setCharge_nm(charge_nm);
		compDto.setCharge_email(charge_email);
		

		compDto.setComp_file(comp_file);
		compDto.setAccount_copy1(account_copy1);
		compDto.setAccount_copy2(account_copy2);
		compDto.setAccount_copy3(account_copy3);
		compDto.setAccount_copy4(account_copy4);
		compDto.setAccount_copy5(account_copy5);
		compDto.setCOMPANY_FILENM(COMPANY_FILENM);
		compDto.setACCOUNT_COPYNM1(ACCOUNT_COPYNM1);
		compDto.setCOMPANYEVALUATION(COMPANYEVALUATION);
		compDto.setUnfit_reason(unfit_reason);
		compDto.setBusiness_check(business_check);
		compDto.setDate(date);
		compDto.setUnfit_id(unfit_id);
		
		
		retVal = compDao.editCompany(compDto);

		model.put("curPage", String.valueOf(curPageCnt));
		
		msg = "수정에  성공하였습니다";
		if (retVal < 1)
			msg = "수정에 실패하였습니다";
		if (sForm.equals("N")) {
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_Company.do?cmd=companyPageList&curPage=" + curPageCnt
					+ "&searchGb=" + searchGb + "&searchtxt=" + searchtxt,
					"back");
		} else {
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_Common.do?cmd=searchComp&sForm=" + sForm, "back");
		}
	}

	
	/**
	 * 업체리스트(Excel)
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward companyExcelList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);

		CompanyDAO dao = new CompanyDAO();
		CompanyDTO companyDTO = new CompanyDTO();

		companyDTO.setSearchGb(searchGb);
		companyDTO.setSearchTxt(searchtxt);

		ArrayList<CompanyDTO> arrlist = dao.getCompanyListExcel(companyDTO);

		model.put("listInfo", arrlist);

		return actionMapping.findForward("companyExcelList");
	}
	
	/**
	 * 2012.11.27(화) bsh.
	 * 업체관리 = 삭제
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward companyDelete(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}

		String FilePath = FileUtil.FILE_DIR + "company/"
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
		System.out.println("curPage:"+curPageCnt);
		String searchGb = StringUtil.nvl(
				multipartRequest.getParameter("searchGb"), "");
		String comp_code = StringUtil.nvl(multipartRequest.getParameter("comp_code"), "");
		
		CompanyDAO dao = new CompanyDAO();
		CompanyDTO compDto = new CompanyDTO();

		compDto.setComp_code(comp_code);
		retVal = dao.deleteCompanyOne1(compDto);

		msg = "삭제에  성공하였습니다";
		if (retVal < 1)
			msg = "삭제에 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_Company.do?cmd=companyPageList&curPage=" + curPageCnt
				+ "&searchGb=" + searchGb, "back");
	}


	
	/**
	 * 부적격 업체
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward companyUnfit(ActionMapping actionMapping,
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
		
		
	
		String comp_code = StringUtil.nvl(request.getParameter("comp_code"), "");
		int retVal=0;
		
		CompanyDAO compDao = new CompanyDAO();
		CompanyDTO compDto = new CompanyDTO();
//		UserDTO userDto = new UserDTO();
		
		compDto.setComp_code(comp_code);
		compDto.setUnfit_id(USERID);
		String name = UserBroker.getUserNm(request);
		System.out.println("============name : =========================================================" + name);
		System.out.println("=================================="+compDto.getUnfit_id());
		
		compDto = compDao.getCompanyUnfitView(compDto);
		
		DateSetter dateSetter = new DateSetter(compDto.getDate(), "99991231");
		
		model.put("compDto", compDto);
		model.put("dateSetter", dateSetter);
		model.put("name", name);
	
			return actionMapping.findForward("companyUnfit");
	
	}
	
}
