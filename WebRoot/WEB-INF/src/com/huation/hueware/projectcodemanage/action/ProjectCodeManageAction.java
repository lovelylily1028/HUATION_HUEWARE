package com.huation.hueware.projectcodemanage.action;

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

import com.huation.common.project.ProjectDAO;
import com.huation.common.project.ProjectDTO;
import com.huation.common.projectcodemanage.ProjectCodeManageDAO;
import com.huation.common.projectcodemanage.ProjectCodeManageDTO;
import com.huation.common.user.UserBroker;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;
import com.huation.common.util.CommonUtil;
import com.huation.common.util.DateSetter;
import com.huation.common.util.DateUtil;

import com.huation.common.user.UserConnectDTO;
import com.huation.common.contractmanage.ContractManageDAO;
import com.huation.common.contractmanage.ContractManageDTO;
import com.huation.common.currentstatus.CurrentStatusDAO;
import com.huation.common.currentstatus.CurrentStatusDTO;
import com.huation.common.formfile.FormFileDAO;
import com.huation.common.formfile.FormFileDTO;

public class ProjectCodeManageAction extends StrutsDispatchAction {

	/**
	 * CreateDate:2013-12-23(월) Writer:shbyeon.
	 * 프로젝트 코드관리(조회) 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgPageList_Search
	 * @throws Exception
	 */
	public ActionForward projectCodeMgPageList_Search(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);

		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		// pjMgDto 객체 셋팅.
		pjMgDto.setChUserID(USERID);
		pjMgDto.setvSearchType(searchGb);
		pjMgDto.setvSearch(searchtxt);
		pjMgDto.setnRow(10);
		pjMgDto.setnPage(curPageCnt);
		pjMgDto.setJobGb("PAGE");

		ListDTO ld = pjMgDao.projectCodeMgPageList_Search(pjMgDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		
		return actionMapping.findForward("projectCodeMgPageList_Search");
	}
	
	/**
	 * CreateDate:2013-12-23(월) Writer:shbyeon.
	 * 프로젝트 코드관리(조회) 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgPageList_Search
	 * @throws Exception
	 */
	public ActionForward projectCodeMgPageList_Search2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		
		
		MultipartRequest multipartRequest = null;
		
		String FilePath = FileUtil.FILE_DIR + "projectcodemanage/"
				+ DateTimeUtil.getDate() + "/";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				500);
		//UploadFiles (,,,20)20의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();

		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(multipartRequest.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);

		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		// pjMgDto 객체 셋팅.
		pjMgDto.setChUserID(USERID);
		pjMgDto.setvSearchType(searchGb);
		pjMgDto.setvSearch(searchtxt);
		pjMgDto.setnRow(10);
		pjMgDto.setnPage(curPageCnt);
		pjMgDto.setJobGb("PAGE");

		ListDTO ld = pjMgDao.projectCodeMgPageList_Search(pjMgDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		
		return actionMapping.findForward("projectCodeMgPageList_Search");
	}
	
	
	/**
	 * CreateDate:2014-01-25(토) Writer:shbyeon.
	 * 프로젝트 진행관리 상세보기
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgSearchView
	 * @throws Exception
	 */
	public ActionForward projectCodeMgSearchView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		int PjSeq = StringUtil.nvl(request.getParameter("PjSeq"), 0);


		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//로그인 아이디 세션처리
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDTO pjMgDto_Cm = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		pjMgDto.setPjSeq(PjSeq);
		pjMgDto = pjMgDao.projectCodeMgView(pjMgDto);
		
		ArrayList arrDataList = null; //행추가(계약코드) 가져올 Array 변수 선언
		arrDataList = pjMgDao.getArrDataList(pjMgDto);//프로젝트 코드 매핑 테이블에 등록된 계약코드 데이타 가져오기.
		
		model.put("pjMgDto", pjMgDto);
		model.put("pjMgDto_Cm", pjMgDto_Cm);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("arrDataList", arrDataList);

		if (pjMgDto == null) {
			String msg = " 프로젝트 진행 정보가 없습니다.";
			return alertAndExit(model, msg,request.getContextPath()+"/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Search&curPage=" + curPageCnt,"back");
		} else {
			return actionMapping.findForward("projectCodeMgSearchView");
		}
	}
	
	/**
	 * CreateDate:2013-12-24(화) Writer:shbyeon.
	 * 프로젝트 코드관리(조회) Excel Upload 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgPageList_Search_Excel
	 * @throws Exception
	 */
	public ActionForward projectCodeMgPageList_Search_Excel(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);

		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		// pjMgDto 객체 셋팅.
		pjMgDto.setChUserID(USERID);
		pjMgDto.setvSearchType(searchGb);
		pjMgDto.setvSearch(searchtxt);
		pjMgDto.setnRow(10);
		pjMgDto.setnPage(curPageCnt);
		pjMgDto.setJobGb("PAGE");

		ListDTO ld = pjMgDao.projectCodeMgPageList_Search_Excel(pjMgDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		
		return actionMapping.findForward("projectCodeMgPageList_Search_Excel");
	}
	/**
	 * CreateDate:2014-01-26(일) Writer:shbyeon.
	 * 프로젝트 진행관리 Excel Upload 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgPageList_Progress_Excel
	 * @throws Exception
	 */
	public ActionForward projectCodeMgPageList_Progress_Excel(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);

		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		// pjMgDto 객체 셋팅.
		pjMgDto.setChUserID(USERID);
		pjMgDto.setvSearchType(searchGb);
		pjMgDto.setvSearch(searchtxt);
		pjMgDto.setnRow(10);
		pjMgDto.setnPage(curPageCnt);
		pjMgDto.setJobGb("LIST");

		ListDTO ld = pjMgDao.projectCodeMgPageList_Progress_Excel(pjMgDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		
		return actionMapping.findForward("projectCodeMgPageList_Progress_Excel");
	}
	
	/**
	 * CreateDate:2014-01-26(일) Writer:shbyeon.
	 * 프로젝트 코드관리(등록/수정) Excel Upload 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgPageList_Edit_Excel
	 * @throws Exception
	 */
	public ActionForward projectCodeMgPageList_Edit_Excel(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);

		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		// pjMgDto 객체 셋팅.
		pjMgDto.setChUserID(USERID);
		pjMgDto.setvSearchType(searchGb);
		pjMgDto.setvSearch(searchtxt);
		pjMgDto.setnRow(10);
		pjMgDto.setnPage(curPageCnt);
		pjMgDto.setJobGb("PAGE");

		ListDTO ld = pjMgDao.projectCodeMgPageList_Search_Excel(pjMgDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		
		return actionMapping.findForward("projectCodeMgPageList_Edit_Excel");
	}
	
	/**
	 * CreateDate:2013-12-24(화) Writer:shbyeon.
	 * 프로젝트 코드관리(등록/수정) 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgPageList_Search
	 * @throws Exception
	 */
	public ActionForward projectCodeMgPageList_Edit(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);

		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		// pjMgDto 객체 셋팅.
		pjMgDto.setChUserID(USERID);
		pjMgDto.setvSearchType(searchGb);
		pjMgDto.setvSearch(searchtxt);
		pjMgDto.setnRow(10);
		pjMgDto.setnPage(curPageCnt);
		pjMgDto.setJobGb("PAGE");

		ListDTO ld = pjMgDao.projectCodeMgPageList_Search(pjMgDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("projectCodeMgPageList_Edit");
	}
	
	/**
	 * CreateDate:2013-12-24(화) Writer:shbyeon.
	 * 프로젝트 코드관리(등록/수정) 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgPageList_Search
	 * @throws Exception
	 */
	public ActionForward projectCodeMgPageList_Edit2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		
		MultipartRequest multipartRequest = null;
		
		String FilePath = FileUtil.FILE_DIR + "projectcodemanage/"
				+ DateTimeUtil.getDate() + "/";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				500);
		//UploadFiles (,,,20)20의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
				
		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(multipartRequest.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);
	
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		// pjMgDto 객체 셋팅.
		pjMgDto.setChUserID(USERID);
		pjMgDto.setvSearchType(searchGb);
		pjMgDto.setvSearch(searchtxt);
		pjMgDto.setnRow(10);
		pjMgDto.setnPage(curPageCnt);
		pjMgDto.setJobGb("PAGE");

		ListDTO ld = pjMgDao.projectCodeMgPageList_Search(pjMgDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("projectCodeMgPageList_Edit");
	}
	
	
	
	/**
	 * CreateDate:2013-12-26(목) Writer:shbyeon.
	 * 프로젝트 코드 (등록/편집) 폼 화면 호출
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgPageList
	 * @throws Exception
	 */
	public ActionForward projectCodeMgRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		String msg = "";
		log.debug("프로젝트 코드(등록/편집) 메뉴 로그인 세션 ID:"+USERID);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		
		return actionMapping.findForward("projectCodeMgRegistForm");
	}
	
	
	/*
	 * 임시 프로젝트코드 보여주기
	 */
	public ActionForward projectCodeCreate(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		String ProjectCode = StringUtil.nvl(request.getParameter("ProjectCode"),"");
		
		
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		// 로그인 처리 끝.
		
		
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();
		
		
		String ProjectCode_CQ = "";	//ContractCode 담을변수
		String ProjectCode_Return=""; //ContractCode 리턴받은 변수
		ProjectCode_CQ=pjMgDao.ProjectCodeCreate(ProjectCode_Return,USERID); //계약관리 코드 Max값으로 Select하는 DAO 호출

		
		ProjectCode += ProjectCode_CQ;
		
		response.setContentType("text/html; charset=euc-kr");
		response.getWriter().print(ProjectCode);
		
		
		return null;

	}
	/**
	 * CreateDate:2013-12-26(목) Writer:shbyeon.
	 * 프로젝트코드 등록처리
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgEdit
	 * @throws Exception
	 */
	public ActionForward projectCodeMgRegist(ActionMapping actionMapping,
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
		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		
		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "projectcodemanage/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				500);
		//UploadFiles (,,,20)20의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		String ProjectProgressFile = ""; 		//프로젝트 진행문서 파일 받을 파라미터


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
			ProjectProgressFile = StringUtil.nvl(
					multipartRequest.getParameter("p_ProjectProgressFile"), "");//p_ContractFile Web(기존데이터)에서받고  ContractFile DB로담아준다.
			//ContractFile Request.getparameter 넘겨주는이유 수정시 파일은 수정하지 않을 경우 가지고있는파일 유지를위해서 
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
					
					//새로운 파일명으로 업로드 할때.
					if (objName.equals("ProjectProgressFile")) {
						ProjectProgressFile = uploadFilePath;
					}
				}
			}
		}
		
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		String ProjectCode = StringUtil.nvl(
				multipartRequest.getParameter("ProjectCode"),"");
		String ProjectDivision = StringUtil.nvl(
				multipartRequest.getParameter("ProjectDivision"), "");
		String PurchaseDivision = StringUtil.nvl(
				multipartRequest.getParameter("PurchaseDivision"), "");
		String P_ProjectCode = StringUtil.nvl(
				multipartRequest.getParameter("P_ProjectCode"), "");
		String P_ProjectName = StringUtil.nvl(
				multipartRequest.getParameter("P_ProjectName"), "");
		String MoreCode = StringUtil.nvl(
				multipartRequest.getParameter("MoreCode"), "");
		String Public_No = StringUtil.nvl(
				multipartRequest.getParameter("Public_No"), "");
		String Pub_ProjectName = StringUtil.nvl(
				multipartRequest.getParameter("Pub_ProjectName"), "");
		String ProjectName = StringUtil.nvl(
				multipartRequest.getParameter("ProjectName"), "");
		String CustomerName = StringUtil.nvl(
				multipartRequest.getParameter("CustomerName"),"");
		String PurchaseName = StringUtil.nvl(
				multipartRequest.getParameter("PurchaseName"),"");
		String ProjectStartDate = StringUtil.nvl(
				multipartRequest.getParameter("ProjectStartDate"), "");
		String ProjectEndDate = StringUtil.nvl(
				multipartRequest.getParameter("ProjectEndDate"),"");
		int ProjectProgressDate = StringUtil.nvl(
				multipartRequest.getParameter("ProjectProgressDate"),0);
		String ChargeID = StringUtil.nvl(
				multipartRequest.getParameter("ChargeID"),"");
		String ChargeProjectManager = StringUtil.nvl(
				multipartRequest.getParameter("ChargeProjectManager"),"");
		String ChargeComent = StringUtil.nvl(
				multipartRequest.getParameter("ChargeComent"),"");
		String ContractCodeYN = StringUtil.nvl(
				multipartRequest.getParameter("ContractCodeYN"),"");
		String ProjectProgressFileNm = StringUtil.nvl(
				multipartRequest.getParameter("ProjectProgressFileNm"),"");
		String user_nm = StringUtil.nvl(
				multipartRequest.getParameter("user_nm"),"");
		String user_nm2 = StringUtil.nvl(
				multipartRequest.getParameter("user_nm2"),"");
		String FreeCostYN = StringUtil.nvl(
				multipartRequest.getParameter("FreeCostYN"),"");
		
		//프로젝트 코드 임시 생성 시작.
		log.debug("[프로젝트 코드 임시생성 Loop Start...]");
		String ProjectCode_CQ = "";	//ContractCode 담을변수
		String ProjectCode_Return=""; //ContractCode 리턴받은 변수
		ProjectCode_CQ=pjMgDao.ProjectCodeCreate(ProjectCode_Return,USERID); //계약관리 코드 Max값으로 Select하는 DAO 호출
		//계약관리번호 999999건 이상 생성하려 할때 예외처리.
			if(ProjectCode_CQ.equals("MAX")){
				msg = "프로젝트코드 생성오류 [999999건 이상 인 경우]";			
		        return alertAndExit(model,msg,request.getContextPath()+"/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Edit&curPage="+curPageCnt,"back");	
			}else{
				pjMgDto.setProjectCode(ProjectCode_CQ);
				log.debug("임시생성된 프로젝트 코드 등록화면으로 가져오기위해 DTO Setting..["+ProjectCode_CQ+"]");
			}
			
		log.debug("[프로젝트 코드 임시생성 ProjectCode 코드 생성 (현재 DB에서 Max값으로 가져온 코드):["+ProjectCode_CQ+"] action..프로젝트 코드 임시생성]");
		log.debug("[프로젝트 코드 임시생성 Loop End...]");
		
		pjMgDto.setProjectCode(ProjectCode+ProjectCode_CQ);
		log.debug("[프로젝트코드 등록 ProjectCode Param Setting:"+ProjectCode+ProjectCode_CQ+" action..");
		pjMgDto.setProjectDivision(ProjectDivision);
		log.debug("[프로젝트코드 등록 ProjectDivision Param Setting:"+ProjectDivision+" action..");
		pjMgDto.setPurchaseDivision(PurchaseDivision);
		log.debug("[프로젝트코드 등록 PurchaseDivision Param Setting:"+PurchaseDivision+" action..");
		pjMgDto.setP_ProjectCode(P_ProjectCode);
		log.debug("[프로젝트코드 등록 P_ProjectCode Param Setting:"+P_ProjectCode+" action..");
		pjMgDto.setP_ProjectName(P_ProjectName);
		log.debug("[프로젝트코드 등록 P_ProjectName Param Setting:"+P_ProjectName+" action..");
		pjMgDto.setMoreCode(MoreCode);
		log.debug("[프로젝트코드 등록 MoreCode Param Setting:"+MoreCode+" action..");
		pjMgDto.setPublic_No(Public_No);
		log.debug("[프로젝트코드 등록 Public_No Param Setting:"+Public_No+" action..");
		pjMgDto.setPub_ProjectName(Pub_ProjectName);
		log.debug("[프로젝트코드 등록 Pub_ProjectName Param Setting:"+Pub_ProjectName+" action..");
		pjMgDto.setProjectName(ProjectName);
		log.debug("[프로젝트코드 등록 ProjectName Param Setting:"+ProjectName+" action..");
		pjMgDto.setCustomerName(CustomerName);
		log.debug("[프로젝트코드 등록 CustomerName Param Setting:"+CustomerName+" action..");
		pjMgDto.setPurchaseName(PurchaseName);
		log.debug("[프로젝트코드 등록 PurchaseName Param Setting:"+PurchaseName+" action..");
		pjMgDto.setProjectStartDate(ProjectStartDate);
		log.debug("[프로젝트코드 등록 ProjectStartDate Param Setting:"+ProjectStartDate+" action..");
		pjMgDto.setProjectEndDate(ProjectEndDate);
		log.debug("[프로젝트코드 등록 ProjectEndDate Param Setting:"+ProjectEndDate+" action..");
		pjMgDto.setProjectProgressDate(ProjectProgressDate);
		log.debug("[프로젝트코드 등록 ProjectProgressDate Param Setting:"+ProjectProgressDate+" action..");
		pjMgDto.setChargeID(ChargeID);
		log.debug("[프로젝트코드 등록 ChargeID Param Setting:"+ChargeID+" action..");
		pjMgDto.setChargeProjectManager(ChargeProjectManager);
		log.debug("[프로젝트코드 등록 ChargeProjectManager Param Setting:"+ChargeProjectManager+" action..");
		pjMgDto.setChargeComent(ChargeComent);
		log.debug("[프로젝트코드 등록 ChargeComent Param Setting:"+ChargeComent+" action..");
		pjMgDto.setProjectCreateUser(USERID);
		log.debug("[프로젝트코드 등록 ProjectCreateUser Param Setting:"+USERID+" action..");
		pjMgDto.setContractCodeYN(ContractCodeYN);
		log.debug("[프로젝트코드 등록 ContractCodeYN Param Setting:"+ContractCodeYN+" action..");
		pjMgDto.setProjectProgressFile(ProjectProgressFile);
		log.debug("[프로젝트코드 등록 ProjectProgressFile Param Setting:"+ProjectProgressFile+" action..");
		pjMgDto.setProjectProgressFileNm(ProjectProgressFileNm);
		log.debug("[프로젝트코드 등록 ProjectProgressFileNm Param Setting:"+ProjectProgressFileNm+" action..");
		pjMgDto.setChargeNm(user_nm);
		log.debug("[프로젝트코드 등록 ChargeNm Param Setting:"+user_nm+" action..");
		pjMgDto.setChargePmNm(user_nm2);
		log.debug("[프로젝트코드 등록 ChargePmNm Param Setting:"+user_nm2+" action..");
		pjMgDto.setFreeCostYN(FreeCostYN);
		log.debug("[프로젝트코드 등록 FreeCostYN Param Setting:"+FreeCostYN+" action..");
		
		
		retVal = pjMgDao.projectCodeInsertData(pjMgDto);
		log.debug("[프로젝트코드 등록 Insert 처리 여부 retVal=[1]성공! retVal=[1]이 아닌 것 실패!------- final retVal:["+retVal+"] action..");
		
		//계약코드 배치 등록 Loop 시작..
		if(retVal == 1 && ContractCodeYN.equals("Y")){
			log.debug("[프로젝트 코드 등록 Batch Insert Start..]");
			String ProjectCode_Mp = ProjectCode+ProjectCode_CQ;
			String[] ContractCode = multipartRequest.getParameterValues("ContractCode");		    //Arr 일때 getParameterValues
			String[] Con_ProjectName = multipartRequest.getParameterValues("Con_ProjectName");	//Arr 일때 getParameterValues
			String[] SortID = multipartRequest.getParameterValues("SortID");						//Arr 일때 getParameterValues
			
			log.debug("[Batch Insert Mapping 프로젝트코드:"+ProjectCode_Mp+" action..]");
			log.debug("[Batch Insert Data Count 계약코드:"+ContractCode.length+" action..]");
			log.debug("[Batch Insert Data Count 프로젝트명:"+Con_ProjectName.length+" action..]");
			log.debug("[Batch Insert Data Count 프로젝트명:"+SortID.length+" action..]");
			
			retVal = pjMgDao.projectCodeBatchInsertData(ProjectCode_Mp,ContractCode,Con_ProjectName,SortID);
			
			if(retVal != 1){
				msg = "프로젝트 코드 등록 Batch Insert 실패!";
			}
			
			log.debug("[프로젝트코드 등록 Batch Insert 처리 여부 retVal=[1]성공! retVal=[1]이 아닌 것 실패!------- final retVal:["+retVal+"] action..");
			log.debug("[프로젝트 코드 등록 Batch Insert end..]");
		}
		//계약코드 배치 등록 Loop 끝..
		
		msg = "프로젝트코드 정보가 등록되었습니다";
		if (retVal != 1)
			msg = "프로젝트코드 정보 등록 실패하였습니다";
		
		
	        return alertAndExit(model, msg,request.getContextPath()+"/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Edit&curPage=" + curPageCnt+"&searchGb="+searchGb,"back");		
	}
	
	
	/**
	  * CreateDate:2014-01-07(화) Writer:shbyeon.
	  * 모 프로젝트 코드 조회 리스트(Popup)
	  * @param actionMapping
	  * @param actionForm
	  * @param request
	  * @param response
	  * @param model
	  * @return p_projectCodeSearch
	  * @throws Exception
	  */
	public ActionForward p_projectCodeSearch(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			 HttpServletResponse response, Map model) throws Exception {
			
		log.debug("모 프로젝트 코드 p_projectCodeSearch Action Start..");
			// 로그인 처리
			String USERID = UserBroker.getUserId(request);
				
			//세션 끊길 시 초기화면
			if(USERID.equals("")){ String rtnUrl =
			request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
			goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
			
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
			String searchtxt = StringUtil
					.nvl(request.getParameter("searchtxt"), "");
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
			String sForm = StringUtil.nvl(request.getParameter("sForm"), "");
			
			ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
			ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();
				
			// pjMgDto 객체 셋팅.
			pjMgDto.setChUserID(USERID);
			pjMgDto.setvSearchType(searchGb);
			pjMgDto.setvSearch(searchtxt);
			pjMgDto.setnRow(10);
			pjMgDto.setnPage(curPageCnt);
			pjMgDto.setJobGb("PAGE");
			
			ListDTO ld = pjMgDao.p_ProjectCodeList(pjMgDto);
				
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("sForm", sForm);
		log.debug("모 프로젝트 코드 p_projectCodeSearch Action End..");
		return actionMapping.findForward("p_projectCodeSearch");
	}
	
	/**
	 * CreateDate:2014-01-08(수) Writer:shbyeon.
	 * 모 프로젝트 코드 선택으로 인한 증설코드 생성 Action 호출
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgPageList
	 * @throws Exception
	 */
	public ActionForward projectMoreCodeMgCreate(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		log.debug("모 프로젝트 코드 생성 projectMoreCodeMgCreate Action Start..");
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		String msg = "";
		log.debug("프로젝트 코드(등록/편집) 메뉴 로그인 세션 ID:"+USERID);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		
		String project_code = StringUtil.nvl(request.getParameter("project_code"), "");
		log.debug("모 프로젝트 코드 생성 Action Param = > ["+project_code+"]..action 모 프로젝트 코드생성");
		
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();
		
		String MoreCode = pjMgDao.projectMoreCodeMgCreate(project_code);
		response.setContentType("text/html; charset=euc-kr"); //브라우저가 알아서 인코딩 옵션 바꾸도록 하는 명령어.
		//response.setCharacterEncoding("EUC-KR");
		response.getWriter().print(MoreCode); //Jsp 페이지 해당 Ajax로 전송해줄 결과 값
		
		
		log.debug("모 프로젝트 코드 생성 projectMoreCodeMgCreate Action End..");
		
		return null;
	}
	
	/**
	 * CreateDate:2014-01-19(일) Writer:shbyeon.
	 * 프로젝트코드 상세보기
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgView
	 * @throws Exception
	 */
	public ActionForward projectCodeMgView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		int PjSeq = StringUtil.nvl(request.getParameter("PjSeq"), 0);


		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//로그인 아이디 세션처리
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDTO pjMgDto_Cm = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		pjMgDto.setPjSeq(PjSeq);
		pjMgDto = pjMgDao.projectCodeMgView(pjMgDto);
		
		ArrayList arrDataList = null; //행추가(계약코드) 가져올 Array 변수 선언
		arrDataList = pjMgDao.getArrDataList(pjMgDto);//프로젝트 코드 매핑 테이블에 등록된 계약코드 데이타 가져오기.
		
		model.put("pjMgDto", pjMgDto);
		model.put("pjMgDto_Cm", pjMgDto_Cm);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("arrDataList", arrDataList);

		if (pjMgDto == null) {
			String msg = " 프로젝트코드 정보가 없습니다.";
			return alertAndExit(model, msg,request.getContextPath()+"/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Edit&curPage=" + curPageCnt,"back");
		} else {
			return actionMapping.findForward("projectCodeMgView");
		}
	}
	
	/**
	 * CreateDate:2014-01-25(토) Writer:shbyeon.
	 * 프로젝트코드 수정처리
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgPageList_Edit
	 * @throws Exception
	 */
	public ActionForward projectCodeMgEdit(ActionMapping actionMapping,
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
		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		
		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "projectcodemanage/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				500);
		//UploadFiles (,,,20)20의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		String ProjectProgressFile = ""; 		//프로젝트 진행문서 파일 받을 파라미터


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
			ProjectProgressFile = StringUtil.nvl(
					multipartRequest.getParameter("p_ProjectProgressFile"), "");//p_ContractFile Web(기존데이터)에서받고  ContractFile DB로담아준다.
			//ContractFile Request.getparameter 넘겨주는이유 수정시 파일은 수정하지 않을 경우 가지고있는파일 유지를위해서 
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
					
					//새로운 파일명으로 업로드 할때.
					if (objName.equals("ProjectProgressFile")) {
						ProjectProgressFile = uploadFilePath;
					}
				}
			}
		}
		
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		int PjSeq = StringUtil.nvl(
				multipartRequest.getParameter("PjSeq"),0);
		String ProjectCode = StringUtil.nvl(
				multipartRequest.getParameter("ProjectCode"),"");
		String ProjectDivision = StringUtil.nvl(
				multipartRequest.getParameter("ProjectDivision"), "");
		String PurchaseDivision = StringUtil.nvl(
				multipartRequest.getParameter("PurchaseDivision"), "");
		String P_ProjectCode = StringUtil.nvl(
				multipartRequest.getParameter("P_ProjectCode"), "");
		String P_ProjectName = StringUtil.nvl(
				multipartRequest.getParameter("P_ProjectName"), "");
		String MoreCode = StringUtil.nvl(
				multipartRequest.getParameter("MoreCode"), "");
		String Public_No = StringUtil.nvl(
				multipartRequest.getParameter("Public_No"), "");
		String Pub_ProjectName = StringUtil.nvl(
				multipartRequest.getParameter("Pub_ProjectName"), "");
		String ProjectName = StringUtil.nvl(
				multipartRequest.getParameter("ProjectName"), "");
		String CustomerName = StringUtil.nvl(
				multipartRequest.getParameter("CustomerName"),"");
		String PurchaseName = StringUtil.nvl(
				multipartRequest.getParameter("PurchaseName"),"");
		String ProjectStartDate = StringUtil.nvl(
				multipartRequest.getParameter("ProjectStartDate"), "");
		String ProjectEndDate = StringUtil.nvl(
				multipartRequest.getParameter("ProjectEndDate"),"");
		int ProjectProgressDate = StringUtil.nvl(
				multipartRequest.getParameter("ProjectProgressDate"),0);
		String ChargeID = StringUtil.nvl(
				multipartRequest.getParameter("ChargeID"),"");
		String ChargeProjectManager = StringUtil.nvl(
				multipartRequest.getParameter("ChargeProjectManager"),"");
		String ChargeComent = StringUtil.nvl(
				multipartRequest.getParameter("ChargeComent"),"");
		String ContractCodeYN = StringUtil.nvl(
				multipartRequest.getParameter("ContractCodeYN"),"");
		String ProjectProgressFileNm = StringUtil.nvl(
				multipartRequest.getParameter("ProjectProgressFileNm"),"");
		String user_nm = StringUtil.nvl(
				multipartRequest.getParameter("user_nm"),"");
		String user_nm2 = StringUtil.nvl(
				multipartRequest.getParameter("user_nm2"),"");
		String FreeCostYN = StringUtil.nvl(
				multipartRequest.getParameter("FreeCostYN"),"");
		
		pjMgDto.setPjSeq(PjSeq);
		log.debug("[프로젝트코드 수정 PjSeq Param Setting:"+PjSeq+" action..");
		pjMgDto.setProjectCode(ProjectCode);
		log.debug("[프로젝트코드 수정 ProjectCode Param Setting:"+ProjectCode+" action..");
		pjMgDto.setProjectDivision(ProjectDivision);
		log.debug("[프로젝트코드 수정 ProjectDivision Param Setting:"+ProjectDivision+" action..");
		pjMgDto.setPurchaseDivision(PurchaseDivision);
		log.debug("[프로젝트코드 수정 PurchaseDivision Param Setting:"+PurchaseDivision+" action..");
		pjMgDto.setP_ProjectCode(P_ProjectCode);
		log.debug("[프로젝트코드 수정 P_ProjectCode Param Setting:"+P_ProjectCode+" action..");
		pjMgDto.setP_ProjectName(P_ProjectName);
		log.debug("[프로젝트코드 수정 P_ProjectName Param Setting:"+P_ProjectName+" action..");
		pjMgDto.setMoreCode(MoreCode);
		log.debug("[프로젝트코드 수정 MoreCode Param Setting:"+MoreCode+" action..");
		pjMgDto.setPublic_No(Public_No);
		log.debug("[프로젝트코드 수정 Public_No Param Setting:"+Public_No+" action..");
		pjMgDto.setPub_ProjectName(Pub_ProjectName);
		log.debug("[프로젝트코드 수정 Pub_ProjectName Param Setting:"+Pub_ProjectName+" action..");
		pjMgDto.setProjectName(ProjectName);
		log.debug("[프로젝트코드 수정 ProjectName Param Setting:"+ProjectName+" action..");
		pjMgDto.setCustomerName(CustomerName);
		log.debug("[프로젝트코드 수정 CustomerName Param Setting:"+CustomerName+" action..");
		pjMgDto.setPurchaseName(PurchaseName);
		log.debug("[프로젝트코드 수정 PurchaseName Param Setting:"+PurchaseName+" action..");
		pjMgDto.setProjectStartDate(ProjectStartDate);
		log.debug("[프로젝트코드 수정 ProjectStartDate Param Setting:"+ProjectStartDate+" action..");
		pjMgDto.setProjectEndDate(ProjectEndDate);
		log.debug("[프로젝트코드 수정 ProjectEndDate Param Setting:"+ProjectEndDate+" action..");
		pjMgDto.setProjectProgressDate(ProjectProgressDate);
		log.debug("[프로젝트코드 수정 ProjectProgressDate Param Setting:"+ProjectProgressDate+" action..");
		pjMgDto.setChargeID(ChargeID);
		log.debug("[프로젝트코드 수정 ChargeID Param Setting:"+ChargeID+" action..");
		pjMgDto.setChargeProjectManager(ChargeProjectManager);
		log.debug("[프로젝트코드 수정 ChargeProjectManager Param Setting:"+ChargeProjectManager+" action..");
		pjMgDto.setChargeComent(ChargeComent);
		log.debug("[프로젝트코드 수정 ChargeComent Param Setting:"+ChargeComent+" action..");
		pjMgDto.setProjectUpdateUser(USERID);
		log.debug("[프로젝트코드 수정 ProjectCreateUser Param Setting:"+USERID+" action..");
		pjMgDto.setContractCodeYN(ContractCodeYN);
		log.debug("[프로젝트코드 수정 ContractCodeYN Param Setting:"+ContractCodeYN+" action..");
		pjMgDto.setProjectProgressFile(ProjectProgressFile);
		log.debug("[프로젝트코드 수정 ProjectProgressFile Param Setting:"+ProjectProgressFile+" action..");
		pjMgDto.setProjectProgressFileNm(ProjectProgressFileNm);
		log.debug("[프로젝트코드 수정 ProjectProgressFileNm Param Setting:"+ProjectProgressFileNm+" action..");
		pjMgDto.setChargeNm(user_nm);
		log.debug("[프로젝트코드 등록 ChargeNm Param Setting:"+user_nm+" action..");
		pjMgDto.setChargePmNm(user_nm2);
		log.debug("[프로젝트코드 등록 ChargePmNm Param Setting:"+user_nm2+" action..");
		pjMgDto.setFreeCostYN(FreeCostYN);
		log.debug("[프로젝트코드 등록 FreeCostYN Param Setting:"+FreeCostYN+" action..");
		
		retVal = pjMgDao.projectCodeUpdateData(pjMgDto);
		log.debug("[프로젝트코드 등록 Insert 처리 여부 retVal=[1]성공! retVal=[1]이 아닌 것 실패!------- final retVal:["+retVal+"] action..");
		
		//계약코드 배치 재 등록(수정) Loop 시작..
		if(retVal == 1 && ContractCodeYN.equals("Y")){
			log.debug("[프로젝트 코드 수정(재 등록을 위한) Batch Delete Start..]");
			int DeleteCount = 0;
			DeleteCount = pjMgDao.projectCodeBatchDeleteData(pjMgDto);
			log.debug("[프로젝트 코드 수정(재 등록을 위한) Batch Delete Count=>["+DeleteCount+"]..");
			log.debug("[프로젝트 코드 수정(재 등록을 위한) Batch Delete End..]");
			
			log.debug("[프로젝트 코드 수정 Batch Update Start..]");
			int PjSeq_Mp = PjSeq;														//프로젝트 시퀀스 PK
			String ProjectCode_Mp = ProjectCode;										//프로젝트 코드 
			String[] ContractCode = multipartRequest.getParameterValues("ContractCode");		    //Arr 일때 getParameterValues
			String[] Con_ProjectName = multipartRequest.getParameterValues("Con_ProjectName");	//Arr 일때 getParameterValues
			String[] SortID = multipartRequest.getParameterValues("SortID");						//Arr 일때 getParameterValues
			
			log.debug("[Batch Insert Mapping 프로젝트 시퀀스 PK:"+PjSeq_Mp+" action..]");
			log.debug("[Batch Insert Mapping 프로젝트코드:"+ProjectCode_Mp+" action..]");
			log.debug("[Batch Insert Data Count 계약코드:"+ContractCode.length+" action..]");
			log.debug("[Batch Insert Data Count 프로젝트명:"+Con_ProjectName.length+" action..]");
			log.debug("[Batch Insert Data Count 프로젝트명:"+SortID.length+" action..]");
			
			retVal = pjMgDao.projectCodeBatchUpdateData(PjSeq_Mp,ProjectCode_Mp,ContractCode,Con_ProjectName,SortID);
			
			if(retVal != 1){
				msg = "프로젝트 코드 수정 Batch Update 실패!";
			}
			
			log.debug("[프로젝트코드 수정 Batch Update 처리 여부 retVal=[1]성공! retVal=[1]이 아닌 것 실패!------- final retVal:["+retVal+"] action..");
			log.debug("[프로젝트 코드 수정 Batch Update end..]");
		//계약코드 배치 재 등록(수정) Loop 끝..
		
		//계약코드 미사용 시 매핑 데이타 삭제 Loop 시작..
		}else{
			log.debug("[프로젝트 코드 수정 건으로 인한 계약코드 사용여부:["+ContractCodeYN+"] => [N]이면 미사용..");
			log.debug("[프로젝트 코드 계약코드 미사용으로 데이타 삭제 Batch Delete Start..]");
			int DeleteCount = 0;
			DeleteCount = pjMgDao.projectCodeBatchDeleteData(pjMgDto);
			log.debug("[프로젝트 코드 계약코드 미사용으로  데이타 삭제 Batch Delete Count=>["+DeleteCount+"]..");
			log.debug("[프로젝트 코드 계약코드 미사용으로  데이타 삭제 Batch Delete End..]");
		}
		//계약코드 미사용 시 매핑 데이타 삭제 Loop 끝..
		
		msg = "프로젝트코드 정보가 수정되었습니다";
		if (retVal != 1)
			msg = "프로젝트코드 정보 수정 실패하였습니다";
		
		
	        return alertAndExit(model, msg,request.getContextPath()+"/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Edit&curPage=" + curPageCnt+"&searchGb="+searchGb,"back");		
	}
	
	/**
	 * CreateDate:2014-01-25(토) Writer:shbyeon.
	 * 프로젝트 진행관리 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgPageList_Search
	 * @throws Exception
	 */
	public ActionForward projectCodeMgPageList_Progress(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);

		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		// pjMgDto 객체 셋팅.
		pjMgDto.setChUserID(USERID);
		pjMgDto.setvSearchType(searchGb);
		pjMgDto.setvSearch(searchtxt);
		pjMgDto.setnRow(10);
		pjMgDto.setnPage(curPageCnt);
		pjMgDto.setJobGb("PAGE");

		ListDTO ld = pjMgDao.projectCodeMgPageList_Progress(pjMgDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("projectCodeMgPageList_Progress");
	}
	
	
	/**
	 * CreateDate:2014-01-25(토) Writer:shbyeon.
	 * 프로젝트 진행관리 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgPageList_Search
	 * @throws Exception
	 */
	public ActionForward projectCodeMgPageList_Progress2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.

		MultipartRequest multipartRequest = null;
		
		String FilePath = FileUtil.FILE_DIR + "projectcodemanage/"
				+ DateTimeUtil.getDate() + "/";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				500);
		//UploadFiles (,,,20)20의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		
		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(multipartRequest.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);

	
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		// pjMgDto 객체 셋팅.
		pjMgDto.setChUserID(USERID);
		pjMgDto.setvSearchType(searchGb);
		pjMgDto.setvSearch(searchtxt);
		pjMgDto.setnRow(10);
		pjMgDto.setnPage(curPageCnt);
		pjMgDto.setJobGb("PAGE");

		ListDTO ld = pjMgDao.projectCodeMgPageList_Progress(pjMgDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("projectCodeMgPageList_Progress");
	}
	
	
	
	/**
	 * CreateDate:2014-01-25(토) Writer:shbyeon.
	 * 프로젝트 진행관리 상세보기
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgView
	 * @throws Exception
	 */
	public ActionForward projectCodeMgProgressView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		int PjSeq = StringUtil.nvl(request.getParameter("PjSeq"), 0);


		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//로그인 아이디 세션처리
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDTO pjMgDto_Cm = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		pjMgDto.setPjSeq(PjSeq);
		pjMgDto = pjMgDao.projectCodeMgView(pjMgDto);
		
		ArrayList arrDataList = null; //행추가(계약코드) 가져올 Array 변수 선언
		arrDataList = pjMgDao.getArrDataList(pjMgDto);//프로젝트 코드 매핑 테이블에 등록된 계약코드 데이타 가져오기.
		
		model.put("pjMgDto", pjMgDto);
		model.put("pjMgDto_Cm", pjMgDto_Cm);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("arrDataList", arrDataList);

		if (pjMgDto == null) {
			String msg = " 프로젝트 진행 정보가 없습니다.";
			return alertAndExit(model, msg,request.getContextPath()+"/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Progress&curPage=" + curPageCnt,"back");
		} else {
			return actionMapping.findForward("projectCodeMgProgressView");
		}
	}
	
	/**
	 * CreateDate:2014-01-25(토) Writer:shbyeon.
	 * 프로젝트 진행관리 편집.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return projectCodeMgPageList_Edit
	 * @throws Exception
	 */
	public ActionForward projectCodeMgProgressUpdate(ActionMapping actionMapping,
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
		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		
		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "projectcodemanage/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				500);
		//UploadFiles (,,,20)20의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		String CheckDocumentFile = ""; 		//검수완료 증빙문서 파일 받을 파라미터
		String ProjectEndDocumentFile = ""; //프로젝트 최종산출물 파일 받을 파라미터

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
			CheckDocumentFile = StringUtil.nvl(
					multipartRequest.getParameter("p_CheckDocumentFile"), "");//p_ContractFile Web(기존데이터)에서받고  ContractFile DB로담아준다.
			//ContractFile Request.getparameter 넘겨주는이유 수정시 파일은 수정하지 않을 경우 가지고있는파일 유지를위해서 
			ProjectEndDocumentFile = StringUtil.nvl(
					multipartRequest.getParameter("p_ProjectEndDocumentFile"), "");//p_PurchaseOrderFile Web(기존데이터)에서받고  PurchaseOrderFile DB로담아준다.
			//PurchaseOrderFile Request.getparameter 넘겨주는이유 수정시 파일은 수정하지 않을 경우 가지고있는파일 유지를위해서 
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
					
					//새로운 파일명으로 업로드 할때.
					if (objName.equals("CheckDocumentFile")) {
						CheckDocumentFile = uploadFilePath;
					}
					if (objName.equals("ProjectEndDocumentFile")) {
						ProjectEndDocumentFile = uploadFilePath;
					}
				}
			}
		}
		
		ProjectCodeManageDTO pjMgDto = new ProjectCodeManageDTO();
		ProjectCodeManageDAO pjMgDao = new ProjectCodeManageDAO();

		
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		int PjSeq = StringUtil.nvl(
				multipartRequest.getParameter("PjSeq"),0);
		String ProjectEndDate = StringUtil.nvl(
				multipartRequest.getParameter("ProjectEndDate"),"");
		int ProjectProgressDate = StringUtil.nvl(
				multipartRequest.getParameter("ProjectProgressDate"),0);
		String ChargeProjectManager = StringUtil.nvl(
				multipartRequest.getParameter("ChargeProjectManager"),"");
		int ProgressPercent = StringUtil.nvl(
				multipartRequest.getParameter("ProgressPercent"),0);
		String CheckSuccessYN = StringUtil.nvl(
				multipartRequest.getParameter("CheckSuccessYN"),"");
		String CheckDocumentFileNm = StringUtil.nvl(
				multipartRequest.getParameter("CheckDocumentFileNm"),"");
		String ProjectEndYN = StringUtil.nvl(
				multipartRequest.getParameter("ProjectEndYN"),"");
		String ProjectEndDocumentFileNm = StringUtil.nvl(
				multipartRequest.getParameter("ProjectEndDocumentFileNm"),"");
		String user_nm2 = StringUtil.nvl(
				multipartRequest.getParameter("user_nm2"),"");
		
		pjMgDto.setPjSeq(PjSeq);
		log.debug("[프로젝트 진행관리 수정 PjSeq Param Setting:"+PjSeq+" action..");
		pjMgDto.setProjectEndDate(ProjectEndDate);
		log.debug("[프로젝트 진행관리 수정 ProjectEndDate Param Setting:"+ProjectEndDate+" action..");
		pjMgDto.setProjectProgressDate(ProjectProgressDate);
		log.debug("[프로젝트 진행관리 수정 ProjectProgressDate Param Setting:"+ProjectProgressDate+" action..");
		pjMgDto.setChargeProjectManager(ChargeProjectManager);
		log.debug("[프로젝트 진행관리 수정 ChargeProjectManager Param Setting:"+ChargeProjectManager+" action..");
		pjMgDto.setProjectUpdateUser(USERID);
		log.debug("[프로젝트 진행관리 수정 ProjectUpdateUser Param Setting:"+USERID+" action..");
		pjMgDto.setProgressPercent(ProgressPercent);
		log.debug("[프로젝트 진행관리 수정 ProgressPercent Param Setting:"+ProgressPercent+" action..");
		pjMgDto.setCheckSuccessYN(CheckSuccessYN);
		log.debug("[프로젝트 진행관리 수정 CheckSuccessYN Param Setting:"+CheckSuccessYN+" action..");
		//검수완료 시
		if(CheckSuccessYN.equals("Y")){
		pjMgDto.setCheckDocumentFile(CheckDocumentFile);
		log.debug("[프로젝트 진행관리 수정 CheckDocumentFile Param Setting:"+CheckDocumentFileNm+" action..");
		pjMgDto.setCheckDocumentFileNm(CheckDocumentFileNm);
		log.debug("[프로젝트 진행관리 수정 CheckDocumentFileNm Param Setting:"+CheckDocumentFileNm+" action..");
		}else{
		pjMgDto.setCheckDocumentFile("");
		log.debug("[프로젝트 진행관리 수정 CheckDocumentFile Param Setting:검수완료(N) 이므로 셋팅안함. action..");
		pjMgDto.setCheckDocumentFileNm("");
		log.debug("[프로젝트 진행관리 수정 CheckDocumentFileNm Param Setting:검수완료(N) 이므로 셋팅안함. action..");	
		}
		pjMgDto.setProjectEndYN(ProjectEndYN);
		log.debug("[프로젝트 진행관리 수정 ProjectEndYN Param Setting:"+ProjectEndYN+" action..");
		if(ProjectEndYN.equals("Y")){			
		pjMgDto.setProjectEndDocumentFile(ProjectEndDocumentFile);
		log.debug("[프로젝트 진행관리 수정 ProjectEndDocumentFile Param Setting:"+ProjectEndDocumentFile+" action..");
		pjMgDto.setProjectEndDocumentFileNm(ProjectEndDocumentFileNm);
		log.debug("[프로젝트 진행관리 수정 ProjectEndDocumentFileNm Param Setting:"+ProjectEndDocumentFileNm+" action..");
		}else{
		pjMgDto.setProjectEndDocumentFile("");
		log.debug("[프로젝트 진행관리 수정 ProjectEndDocumentFile Param Setting:프로젝트종료(N) 이므로 셋팅 안함. action..");
		pjMgDto.setProjectEndDocumentFileNm("");
		log.debug("[프로젝트 진행관리 수정 ProjectEndDocumentFileNm Param Setting:프로젝트종료(N) 이므로 셋팅 안함. action..");	
		}
		pjMgDto.setChargePmNm(user_nm2);
		log.debug("[프로젝트 진행관리 수정 ChargePmNm Param Setting:"+user_nm2+" action..");
		
		
		
		retVal = pjMgDao.projectProgressUpdateData(pjMgDto);
		log.debug("[프로젝트코드 등록 Insert 처리 여부 retVal=[1]성공! retVal=[1]이 아닌 것 실패!------- final retVal:["+retVal+"] action..");
		
		msg = "프로젝트 진행 정보가 수정 되었습니다";
		if (retVal != 1)
			msg = "프로젝트 진행 정보 수정 실패하였습니다";
		
		
	        return alertAndExit(model, msg,request.getContextPath()+"/B_ProjectCodeManage.do?cmd=projectCodeMgPageList_Progress&curPage=" + curPageCnt+"&searchGb="+searchGb,"back");		
	}
	
}
