package com.huation.hueware.contractmanage.action;

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

import com.huation.common.project.ProjectDAO;
import com.huation.common.project.ProjectDTO;
import com.huation.common.user.UserBroker;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;
import com.huation.common.util.CommonUtil;
import com.huation.common.util.DateSetter;
import com.huation.common.util.DateUtil;

import com.huation.common.user.UserConnectDTO;
import com.huation.common.contractmanage.ContractManageDAO;
import com.huation.common.contractmanage.ContractManageDTO;
import com.huation.common.formfile.FormFileDAO;
import com.huation.common.formfile.FormFileDTO;

public class ContractManageAction extends StrutsDispatchAction {

	/**
	 * CreateDate:2013-11-21(목) Writer:shbyeon.
	 * 계약관리 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgPageList
	 * @throws Exception
	 */
	public ActionForward contractMgPageList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchGb2 = StringUtil.nvl(request.getParameter("searchGb2"), "");
		String searchGb3 = StringUtil.nvl(request.getParameter("searchGb3"), "");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);

		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		//ProjectDAO pjDao = new ProjectDAO();
		ContractManageDTO cmDto = new ContractManageDTO();
		ContractManageDAO cmDao = new ContractManageDAO();

		// cmDto 객체 셋팅.
		cmDto.setChUserID(USERID);
		cmDto.setvSearchType(searchGb);
		cmDto.setSearchGb2(searchGb2);
		cmDto.setSearchGb3(searchGb3);
		cmDto.setvSearch(searchtxt);
		cmDto.setnRow(10);
		cmDto.setnPage(curPageCnt);
		cmDto.setJobGb("PAGE");

		ListDTO ld = cmDao.contractMgPageList(cmDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchGb2", searchGb2);
		model.put("searchGb3", searchGb3);
		model.put("searchtxt", searchtxt);

		
		return actionMapping.findForward("contractMgPageList");
	}
	
	/**
	 * CreateDate:2013-11-21(목) Writer:shbyeon.
	 * 계약관리 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgPageList
	 * @throws Exception
	 */
	public ActionForward contractMgPageList2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		
		MultipartRequest multipartRequest = null;
		
		String FilePath = FileUtil.FILE_DIR + "contractmanage/"
				+ DateTimeUtil.getDate() + "/";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID, 20);
		//UploadFiles (,,,20)20의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();

		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(multipartRequest.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);

		//ProjectDAO pjDao = new ProjectDAO();
		ContractManageDTO cmDto = new ContractManageDTO();
		ContractManageDAO cmDao = new ContractManageDAO();

		// cmDto 객체 셋팅.
		cmDto.setChUserID(USERID);
		cmDto.setvSearchType(searchGb);
		cmDto.setvSearch(searchtxt);
		cmDto.setnRow(10);
		cmDto.setnPage(curPageCnt);
		cmDto.setJobGb("PAGE");

		ListDTO ld = cmDao.contractMgPageList(cmDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		
		return actionMapping.findForward("contractMgPageList");
	}
	
	/**
	 * CreateDate:2013-11-21(목) Writer:shbyeon.
	 * 계약관리 리스트(Excel-Down)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgPageList
	 * @throws Exception
	 */
	public ActionForward contractMgExcel(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
//			HttpServletResponse response, Map model) throws Exception {
		HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchGb2 = StringUtil.nvl(request.getParameter("searchGb2"), "");
		String searchGb3 = StringUtil.nvl(request.getParameter("searchGb3"), "");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);

		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ContractManageDTO cmDto = new ContractManageDTO();
		ContractManageDAO cmDao = new ContractManageDAO();

		// cmDto 객체 셋팅.
		cmDto.setChUserID(USERID);
		cmDto.setvSearchType(searchGb);
		cmDto.setSearchGb2(searchGb2);
		cmDto.setSearchGb3(searchGb3);
		cmDto.setvSearch(searchtxt);
		cmDto.setnRow(500);
		cmDto.setnPage(1);
		cmDto.setJobGb("PAGE");

		ListDTO ld = cmDao.contractMgPageList(cmDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		
		return actionMapping.findForward("contractMgExcel");
	}
	
	/**
	 * CreateDate:2013-12-13(금) Writer:shbyeon.
	 * 계약관리 등록 폼 화면 호출
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgPageList
	 * @throws Exception
	 */
	public ActionForward contractMgRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		log.debug("계약관리 메뉴 로그인 세션 ID:"+USERID);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		
		Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	   /* cal.add(Calendar.DATE, -1);*/
	  /*  cal.add(Calendar.MONTH, 2);*/
	     
	    // 특정 형태의 날짜로 값을 뽑기 
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    String strDate = df.format(cal.getTime());
	    System.err.println(strDate);

		
		
		model.put("strDate", strDate);

		return actionMapping.findForward("contractMgRegistForm");
	}
	
	/**
	 * CreateDate:2013-12-13(금) Writer:shbyeon.
	 * 계약관리 등록처리
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgEdit
	 * @throws Exception
	 */
	public ActionForward contractMgRegist(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "contractmanage/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				20);
		//UploadFiles (,,,20)20의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String ContractFile = ""; // 계약서 파일 받을 파라미터
		String PurchaseOrderFile = ""; //발주서 파일 받을 파라미터

		if (status.equals("E")) {
			log.debug("첨부 파일 올리려다 실패하였습니다.");
			msg = "첨부 파일 올리려다 실패하였습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("O")) {
			log.debug("첨부하신 파일이 용량을 초과했습니다.");
			msg = "첨부하신 파일이 용량을 초과했습니다.최대 20M 까지 가능합니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("I")) {
			log.debug("첨부 파일의 정보가 잘못되었습니다.");
			msg = "첨부 파일의 정보가 잘못되었습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("S")) {
			// 업로드된 파일의 정보를 가져와서 데이터 베이스에 넣는 작업을 해준다.
			ContractFile = StringUtil.nvl(
					multipartRequest.getParameter("ContractFile"), "");
			System.out.println("tst:"+ContractFile);
			PurchaseOrderFile = StringUtil.nvl(
					multipartRequest.getParameter("PurchaseOrderFile"), "");
			System.out.println("tgg:"+PurchaseOrderFile);
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

					if (objName.equals("ContractFile")) {
						ContractFile = uploadFilePath;
					}
					if (objName.equals("PurchaseOrderFile")) {
						PurchaseOrderFile = uploadFilePath;
					}
				}
			}
		}
		
		ContractManageDAO cmDao = new ContractManageDAO();
		ContractManageDTO cmDto = new ContractManageDTO();

		
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		//계약관리 번호 생성 시작.
		log.debug("[계약관리 번호 생성 Loop Start...]");
		String CreateCode_CQ = "";	//ContractCode 담을변수
		String CreateCode_Return=""; //ContractCode 리턴받은 변수
		CreateCode_CQ=cmDao.addcontractRegistCode(CreateCode_Return); //계약관리 코드 Max값으로 Select하는 DAO 호출
		//계약관리번호 99건 이상 생성하려 할때 예외처리.
			if(CreateCode_CQ.equals("MAX")){
				msg = "계약관리 번호 생성오류 [99건 이상 인 경우]";			
		        return alertAndExit(model,msg,request.getContextPath()+"/B_ContractManage.do?cmd=contractMgPageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
			}
		log.debug("[계약관리 등록으로 인한 ContractCode 코드 생성 (현재 DB에서 년/월/일Max값으로 가져온 코드):["+CreateCode_CQ+"] action..계약관리 등록]");
		log.debug("[계약관리 번호 생성 Loop Start...]");	
		String Public_No = StringUtil.nvl(
				multipartRequest.getParameter("Public_No"),"");
		String ContractFileNm = StringUtil.nvl(
				multipartRequest.getParameter("ContractFileNm"), "");
		String PurchaseOrderFileNm = StringUtil.nvl(
				multipartRequest.getParameter("PurchaseOrderFileNm"), "");
		String ContractName = StringUtil.nvl(
				multipartRequest.getParameter("ContractName"), "");
		String ContractStatus = StringUtil.nvl(
				multipartRequest.getParameter("ContractStatus"), "1"); //계약등록시 진행중인 것만 등록하고 조기종료나 종료는 수정에서 바꿈(2014-10-21)
		String ContractReason = StringUtil.nvl(
				multipartRequest.getParameter("ContractReason"), "");
		String ContractEndDate = StringUtil.nvl(
				multipartRequest.getParameter("ContractEndDate"),"");
		String Ordering_Organization = StringUtil.nvl(
				multipartRequest.getParameter("Ordering_Organization"),"");
		String CustomerName = StringUtil.nvl(
				multipartRequest.getParameter("CustomerName"), "");
		String CustomerTel = StringUtil.nvl(
				multipartRequest.getParameter("CustomerTel"),"");
		String CustomerMobile = StringUtil.nvl(
				multipartRequest.getParameter("CustomerMobile"),"");
		String ContractDate = StringUtil.nvl(
				multipartRequest.getParameter("ContractDate"),"");
		String ConChk = StringUtil.nvl(
				multipartRequest.getParameter("ConChk"),"N");
		String PurchaseDate = StringUtil.nvl(
				multipartRequest.getParameter("PurchaseDate"),"");
		String PurChk = StringUtil.nvl(
				multipartRequest.getParameter("PurChk"),"N");

		
		cmDto.setContractCode(CreateCode_CQ);
		log.debug("[계약관리 ContractCode Param Setting:"+CreateCode_CQ+" action..");
		cmDto.setPublic_No(Public_No);
		log.debug("[계약관리 Public_No Param Setting:"+Public_No+" action..");
		cmDto.setContractFile(ContractFile);
		log.debug("[계약관리 ContractFile Param Setting:"+ContractFile+" action..");
		cmDto.setContractFileNm(ContractFileNm);
		log.debug("[계약관리 ContractFileNm Param Setting:"+ContractFileNm+" action..");
		cmDto.setPurchaseOrderFile(PurchaseOrderFile);
		log.debug("[계약관리 PurchaseOrderFile Param Setting:"+PurchaseOrderFile+" action..");
		cmDto.setPurchaseOrderFileNm(PurchaseOrderFileNm);
		log.debug("[계약관리 PurchaseOrderFileNm Param Setting:"+PurchaseOrderFileNm+" action..");
		cmDto.setContractName(ContractName);
		log.debug("[계약관리 ContractName Param Setting:"+ContractName+" action..");
		cmDto.setContractCreateUser(USERID);
		log.debug("[계약관리 ContractCreateUser Param Setting:"+USERID+" action..");
		cmDto.setContractStatus(ContractStatus);
		log.debug("[계약관리 ContractStatus Param Setting:"+ContractStatus+" action..");
		cmDto.setContractReason(ContractReason);
		log.debug("[계약관리 ContractReason Param Setting:"+ContractReason+" action..");
		
		cmDto.setConChk(ConChk);
		log.debug("[계약관리 ConChk Param Setting:"+ConChk+" action..");
		cmDto.setPurChk(PurChk);
		log.debug("[계약관리 PurChk Param Setting:"+PurChk+" action..");
		if(ConChk.equals("Y")){			
		cmDto.setContractDate(ContractDate);
		log.debug("[계약관리 ContractDate Param Setting:"+ContractDate+" action..");
		}else{
		log.debug("[계약관리 ContractDate Param Setting:"+ContractDate+" action..");	
		}
		if(PurChk.equals("Y")){
		cmDto.setPurchaseDate(PurchaseDate);
		log.debug("[계약관리 PurchaseDate Param Setting:"+PurchaseDate+" action..");
		}else{
		log.debug("[계약관리 PurchaseDate Param Setting:"+PurchaseDate+" action..");	
		}
		//종료 여부 값 진행중 일 경우 ""값 셋팅
		if(ContractStatus.equals("1")){
		log.debug("[계약관리 ContractEndDate Param Setting:"+ContractEndDate+" action..");
		//종료 여부 값 진행중이 아닐 경우 받은 종료 일자 값 셋팅.
		}else{			
		cmDto.setContractEndDate(ContractEndDate);
		log.debug("[계약관리 ContractEndDate Param Setting:"+ContractEndDate+" action..");
		}
		cmDto.setOrdering_Organization(Ordering_Organization);
		log.debug("[계약관리 Ordering_Organization Param Setting:"+Ordering_Organization+" action..");
		cmDto.setCustomerName(CustomerName);
		log.debug("[계약관리 CustomerName Param Setting:"+CustomerName+" action..");
		cmDto.setCustomerTel(CustomerTel);
		log.debug("[계약관리 CustomerTel Param Setting:"+CustomerTel+" action..");
		cmDto.setCustomerMobile(CustomerMobile);
		log.debug("[계약관리 CustomerMobile Param Setting:"+CustomerMobile+" action..");
		
		
		
		retVal = cmDao.contractInsertData(cmDto);
		log.debug("[계약관리 Insert 처리 여부 retVal=[1]성공! retVal=[1]이 아닌 것 실패!------- final retVal:["+retVal+"] action..");
		
		
		msg = "계약관리 정보가 등록되었습니다";
		if (retVal != 1)
			msg = "계약관리 정보 등록 실패하였습니다";
	
	        return alertAndExit(model, msg,request.getContextPath()+"/B_ContractManage.do?cmd=contractMgRegistList&curPage=" + curPageCnt+"&searchGb="+searchGb,"back");		
	}
	
	/**
	 * CreateDate:2013-11-21(목) Writer:shbyeon.
	 * 계약등록 상세보기
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgView
	 * @throws Exception
	 */
	public ActionForward contractRegistMgView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String ContractCode = StringUtil.nvl(request.getParameter("ContractCode"), "");


		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//로그인 아이디 세션처리
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ContractManageDAO cmDao = new ContractManageDAO();
		ContractManageDTO cmDto = new ContractManageDTO();

		cmDto.setContractCode(ContractCode);
		cmDto = cmDao.contractManageView(cmDto);

		// 계산서 발행금액(세금계산서 발행내역 동일. 데이터 가져오기.)
		ListDTO ld = cmDao.invoiceDetailList(cmDto);
		
		// 수금현황(세금계산서 발행내역 동일. 데이터 가져오기.)
		ListDTO ld2 = cmDao.invoiceDetailList(cmDto);
		
		
		
		Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	  /*  cal.add(Calendar.DATE, -1);*/
	  /*  cal.add(Calendar.MONTH, 2);*/
	     
	    // 특정 형태의 날짜로 값을 뽑기 
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    String strDate = df.format(cal.getTime());
	    System.err.println(strDate);
		
		model.put("cmDto", cmDto);
		model.put("listInfo", ld);
		model.put("listInfo2", ld2);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("strDate", strDate);

		if (cmDto == null) {
			String msg = " 계약관리  정보가 없습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_ContractManage.do?cmd=contractMgRegistList&curPage=" + curPageCnt
					, "back");
		} else {
			return actionMapping.findForward("contractRegistMgView");
		}
	}
	
	
	/**
	 * CreateDate:2013-11-21(목) Writer:shbyeon.
	 * 계약관리 상세보기
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgView
	 * @throws Exception
	 */
	public ActionForward contractMgView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;

		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String ContractCode = StringUtil.nvl(request.getParameter("ContractCode"), "");


		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//로그인 아이디 세션처리
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ContractManageDAO cmDao = new ContractManageDAO();
		ContractManageDTO cmDto = new ContractManageDTO();

		cmDto.setContractCode(ContractCode);
		cmDto = cmDao.contractManageView(cmDto);

		// 계산서 발행금액(세금계산서 발행내역 동일. 데이터 가져오기.)
		ListDTO ld = cmDao.invoiceDetailList(cmDto);
		
		// 수금현황(세금계산서 발행내역 동일. 데이터 가져오기.)
		ListDTO ld2 = cmDao.invoiceDetailList(cmDto);
		
		
		
		Calendar cal = Calendar.getInstance();
	    cal.setTime(new Date());
	  /*  cal.add(Calendar.DATE, -1);*/
	  /*  cal.add(Calendar.MONTH, 2);*/
	     
	    // 특정 형태의 날짜로 값을 뽑기 
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    String strDate = df.format(cal.getTime());
	    System.err.println(strDate);
		
		
		
		
		
		
		
		
		model.put("cmDto", cmDto);
		model.put("listInfo", ld);
		model.put("listInfo2", ld2);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("strDate", strDate);

		if (cmDto == null) {
			String msg = " 계약관리  정보가 없습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_ContractManage.do?cmd=contractMgPageList&curPage=" + curPageCnt
					, "back");
		} else {
			return actionMapping.findForward("contractMgView");
		}
	}
	
	/**
	 * CreateDate:2013-11-27(수) Writer:shbyeon.
	 * 계약등록 수정처리
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgEdit
	 * @throws Exception
	 */
	public ActionForward contractRegistMgEdit(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "contractmanage/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				20);
		//UploadFiles (,,,20)20의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String ContractFile = ""; // 계약서 파일 받을 파라미터
		String PurchaseOrderFile = ""; //발주서 파일 받을 파라미터

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
			ContractFile = StringUtil.nvl(
					multipartRequest.getParameter("p_ContractFile"), "");//p_ContractFile Web(기존데이터)에서받고  ContractFile DB로담아준다.
			//ContractFile Request.getparameter 넘겨주는이유 수정시 파일은 수정하지 않을 경우 가지고있는파일 유지를위해서 
			PurchaseOrderFile = StringUtil.nvl(
					multipartRequest.getParameter("p_PurchaseOrderFile"), "");//p_PurchaseOrderFile Web(기존데이터)에서받고  PurchaseOrderFile DB로담아준다.
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

					if (objName.equals("ContractFile")) {
						ContractFile = uploadFilePath;
					}
					if (objName.equals("PurchaseOrderFile")) {
						PurchaseOrderFile = uploadFilePath;
					}
				}
			}
		}
		
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		String ContractCode = StringUtil.nvl(multipartRequest.getParameter("ContractCode"), "");
		String Public_No = StringUtil.nvl(multipartRequest.getParameter("Public_No"),"");
		String ContractFileNm = StringUtil.nvl(
				multipartRequest.getParameter("ContractFileNm"), "");
		String PurchaseOrderFileNm = StringUtil.nvl(
				multipartRequest.getParameter("PurchaseOrderFileNm"), "");
		String ContractName = StringUtil.nvl(
				multipartRequest.getParameter("ContractName"), "");
		String ContractStatus = StringUtil.nvl(
				multipartRequest.getParameter("ContractStatus"), "");
		String ContractReason = StringUtil.nvl(
				multipartRequest.getParameter("ContractReason"), "");
		String CustomerName = StringUtil.nvl(
				multipartRequest.getParameter("CustomerName"), "");
		String CustomerTel = StringUtil.nvl(multipartRequest.getParameter("CustomerTel"),"");
		String CustomerMobile = StringUtil.nvl(multipartRequest.getParameter("CustomerMobile"),"");
		String ContractEndDate = StringUtil.nvl(multipartRequest.getParameter("ContractEndDate"),"");
		String Ordering_Organization = StringUtil.nvl(multipartRequest.getParameter("Ordering_Organization"),"");
		String ContractDate = StringUtil.nvl(multipartRequest.getParameter("ContractDate"),"");
		String ConChk = StringUtil.nvl(multipartRequest.getParameter("ConChk"),"N");
		String PurchaseDate = StringUtil.nvl(multipartRequest.getParameter("PurchaseDate"),"");
		String PurChk = StringUtil.nvl(multipartRequest.getParameter("PurChk"),"N");
		
		ContractManageDAO cmDao = new ContractManageDAO();
		ContractManageDTO cmDto = new ContractManageDTO();

		cmDto.setContractCode(ContractCode);
		log.debug("[계약관리 ContractCode Param Setting:"+ContractCode+" action..");
		cmDto.setPublic_No(Public_No);
		log.debug("[계약관리 Public_No Param Setting:"+Public_No+" action..");
		cmDto.setContractFile(ContractFile);
		log.debug("[계약관리 ContractFile Param Setting:"+ContractFile+" action..");
		cmDto.setContractFileNm(ContractFileNm);
		log.debug("[계약관리 ContractFileNm Param Setting:"+ContractFileNm+" action..");
		cmDto.setPurchaseOrderFile(PurchaseOrderFile);
		log.debug("[계약관리 PurchaseOrderFile Param Setting:"+PurchaseOrderFile+" action..");
		cmDto.setPurchaseOrderFileNm(PurchaseOrderFileNm);
		log.debug("[계약관리 PurchaseOrderFileNm Param Setting:"+PurchaseOrderFileNm+" action..");
		cmDto.setContractName(ContractName);
		log.debug("[계약관리 ContractName Param Setting:"+ContractName+" action..");
		cmDto.setContractUpdateUser(USERID);
		log.debug("[계약관리 ContractUpdateUser Param Setting:"+USERID+" action..");
		cmDto.setConChk(ConChk);
		log.debug("[계약관리 ConChk Param Setting:"+ConChk+" action..");
		cmDto.setPurChk(PurChk);
		log.debug("[계약관리 PurChk Param Setting:"+PurChk+" action..");
		if(ConChk.equals("Y")){			
		cmDto.setContractDate(ContractDate);
		log.debug("[계약관리 ContractDate Param Setting:"+ContractDate+" action..");
		}else{
		log.debug("[계약관리 ContractDate Param Setting:"+ContractDate+" action..");	
		}
		if(PurChk.equals("Y")){
		cmDto.setPurchaseDate(PurchaseDate);
		log.debug("[계약관리 PurchaseDate Param Setting:"+PurchaseDate+" action..");
		}else{
		log.debug("[계약관리 PurchaseDate Param Setting:"+PurchaseDate+" action..");	
		}
		cmDto.setContractStatus(ContractStatus);
		log.debug("[계약관리 ContractStatus Param Setting:"+ContractStatus+" action..");
		if(ContractStatus.equals("1")){
			log.debug("[계약관리 ContractReason Param Setting: Data Setting No! 빈 값으로 초기화 action..(종료여부 진행 중 이기 때문..)");
		}else if(ContractStatus.equals("3")){
			log.debug("[계약관리 ContractReason Param Setting: Data Setting No! 빈 값으로 초기화 action..(종료여부 계약종료  이기 때문..)");
		}else{
			cmDto.setContractReason(ContractReason);
			log.debug("[계약관리 ContractReason Param Setting:"+ContractReason+" action..");
		}
		cmDto.setOrdering_Organization(Ordering_Organization);
		log.debug("[계약관리 Ordering_Organization Param Setting:"+Ordering_Organization+" action..");
		cmDto.setCustomerName(CustomerName);
		log.debug("[계약관리 CustomerName Param Setting:"+CustomerName+" action..");
		cmDto.setCustomerTel(CustomerTel);
		log.debug("[계약관리 CustomerTel Param Setting:"+CustomerTel+" action..");
		cmDto.setCustomerMobile(CustomerMobile);
		log.debug("[계약관리 CustomerMobile Param Setting:"+CustomerMobile+" action..");
		cmDto.setContractEndDate(ContractEndDate);
		log.debug("[계약관리 ContractEndDate Param Setting:"+ContractEndDate+" action..");
		
		retVal = cmDao.contractUpdateData(cmDto);
		log.debug("[계약관리 Update 처리 여부 retVal=[1]성공! retVal=[1]이 아닌 것 실패!------- final retVal:["+retVal+"] action..");
		
		
		msg = "계약관리 정보가 수정되었습니다";
		if (retVal != 1)
			msg = "계약관리 정보 수정이 실패하였습니다";
	
	        return alertAndExit(model, msg,request.getContextPath()+"/B_ContractManage.do?cmd=contractMgRegistList&curPage=" + curPageCnt+"&searchGb="+searchGb,"back");		
	}
	
	/**
	 * CreateDate:2013-11-27(수) Writer:shbyeon.
	 * 계약관리 수정처리
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgEdit
	 * @throws Exception
	 */
	public ActionForward contractMgEdit(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "contractmanage/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				20);
		//UploadFiles (,,,20)20의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String ContractFile = ""; // 계약서 파일 받을 파라미터
		String PurchaseOrderFile = ""; //발주서 파일 받을 파라미터

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
			ContractFile = StringUtil.nvl(
					multipartRequest.getParameter("p_ContractFile"), "");//p_ContractFile Web(기존데이터)에서받고  ContractFile DB로담아준다.
			//ContractFile Request.getparameter 넘겨주는이유 수정시 파일은 수정하지 않을 경우 가지고있는파일 유지를위해서 
			PurchaseOrderFile = StringUtil.nvl(
					multipartRequest.getParameter("p_PurchaseOrderFile"), "");//p_PurchaseOrderFile Web(기존데이터)에서받고  PurchaseOrderFile DB로담아준다.
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

					if (objName.equals("ContractFile")) {
						ContractFile = uploadFilePath;
					}
					if (objName.equals("PurchaseOrderFile")) {
						PurchaseOrderFile = uploadFilePath;
					}
				}
			}
		}
		
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		String ContractCode = StringUtil.nvl(multipartRequest.getParameter("ContractCode"), "");
		String Public_No = StringUtil.nvl(multipartRequest.getParameter("Public_No"),"");
		String ContractFileNm = StringUtil.nvl(
				multipartRequest.getParameter("ContractFileNm"), "");
		String PurchaseOrderFileNm = StringUtil.nvl(
				multipartRequest.getParameter("PurchaseOrderFileNm"), "");
		String ContractName = StringUtil.nvl(
				multipartRequest.getParameter("ContractName"), "");
		String ContractStatus = StringUtil.nvl(
				multipartRequest.getParameter("ContractStatus"), "");
		String ContractReason = StringUtil.nvl(
				multipartRequest.getParameter("ContractReason"), "");
		String CustomerName = StringUtil.nvl(
				multipartRequest.getParameter("CustomerName"), "");
		String CustomerTel = StringUtil.nvl(multipartRequest.getParameter("CustomerTel"),"");
		String CustomerMobile = StringUtil.nvl(multipartRequest.getParameter("CustomerMobile"),"");
		String ContractEndDate = StringUtil.nvl(multipartRequest.getParameter("ContractEndDate"),"");
		String Ordering_Organization = StringUtil.nvl(multipartRequest.getParameter("Ordering_Organization"),"");
		String ContractDate = StringUtil.nvl(multipartRequest.getParameter("ContractDate"),"");
		String ConChk = StringUtil.nvl(multipartRequest.getParameter("ConChk"),"N");
		String PurchaseDate = StringUtil.nvl(multipartRequest.getParameter("PurchaseDate"),"");
		String PurChk = StringUtil.nvl(multipartRequest.getParameter("PurChk"),"N");
		
		ContractManageDAO cmDao = new ContractManageDAO();
		ContractManageDTO cmDto = new ContractManageDTO();

		cmDto.setContractCode(ContractCode);
		log.debug("[계약관리 ContractCode Param Setting:"+ContractCode+" action..");
		cmDto.setPublic_No(Public_No);
		log.debug("[계약관리 Public_No Param Setting:"+Public_No+" action..");
		cmDto.setContractFile(ContractFile);
		log.debug("[계약관리 ContractFile Param Setting:"+ContractFile+" action..");
		cmDto.setContractFileNm(ContractFileNm);
		log.debug("[계약관리 ContractFileNm Param Setting:"+ContractFileNm+" action..");
		cmDto.setPurchaseOrderFile(PurchaseOrderFile);
		log.debug("[계약관리 PurchaseOrderFile Param Setting:"+PurchaseOrderFile+" action..");
		cmDto.setPurchaseOrderFileNm(PurchaseOrderFileNm);
		log.debug("[계약관리 PurchaseOrderFileNm Param Setting:"+PurchaseOrderFileNm+" action..");
		cmDto.setContractName(ContractName);
		log.debug("[계약관리 ContractName Param Setting:"+ContractName+" action..");
		cmDto.setContractUpdateUser(USERID);
		log.debug("[계약관리 ContractUpdateUser Param Setting:"+USERID+" action..");
		cmDto.setConChk(ConChk);
		log.debug("[계약관리 ConChk Param Setting:"+ConChk+" action..");
		cmDto.setPurChk(PurChk);
		log.debug("[계약관리 PurChk Param Setting:"+PurChk+" action..");
		if(ConChk.equals("Y")){			
		cmDto.setContractDate(ContractDate);
		log.debug("[계약관리 ContractDate Param Setting:"+ContractDate+" action..");
		}else{
		log.debug("[계약관리 ContractDate Param Setting:"+ContractDate+" action..");	
		}
		if(PurChk.equals("Y")){
		cmDto.setPurchaseDate(PurchaseDate);
		log.debug("[계약관리 PurchaseDate Param Setting:"+PurchaseDate+" action..");
		}else{
		log.debug("[계약관리 PurchaseDate Param Setting:"+PurchaseDate+" action..");	
		}
		cmDto.setContractStatus(ContractStatus);
		log.debug("[계약관리 ContractStatus Param Setting:"+ContractStatus+" action..");
		if(ContractStatus.equals("1")){
			log.debug("[계약관리 ContractReason Param Setting: Data Setting No! 빈 값으로 초기화 action..(종료여부 진행 중 이기 때문..)");
		}else if(ContractStatus.equals("3")){
			log.debug("[계약관리 ContractReason Param Setting: Data Setting No! 빈 값으로 초기화 action..(종료여부 계약종료  이기 때문..)");
		}else{
			cmDto.setContractReason(ContractReason);
			log.debug("[계약관리 ContractReason Param Setting:"+ContractReason+" action..");
		}
		cmDto.setOrdering_Organization(Ordering_Organization);
		log.debug("[계약관리 Ordering_Organization Param Setting:"+Ordering_Organization+" action..");
		cmDto.setCustomerName(CustomerName);
		log.debug("[계약관리 CustomerName Param Setting:"+CustomerName+" action..");
		cmDto.setCustomerTel(CustomerTel);
		log.debug("[계약관리 CustomerTel Param Setting:"+CustomerTel+" action..");
		cmDto.setCustomerMobile(CustomerMobile);
		log.debug("[계약관리 CustomerMobile Param Setting:"+CustomerMobile+" action..");
		cmDto.setContractEndDate(ContractEndDate);
		log.debug("[계약관리 ContractEndDate Param Setting:"+ContractEndDate+" action..");
		
		retVal = cmDao.contractUpdateData(cmDto);
		log.debug("[계약관리 Update 처리 여부 retVal=[1]성공! retVal=[1]이 아닌 것 실패!------- final retVal:["+retVal+"] action..");
		
		
		msg = "계약관리 정보가 수정되었습니다";
		if (retVal != 1)
			msg = "계약관리 정보 수정이 실패하였습니다";
	
	        return alertAndExit(model, msg,request.getContextPath()+"/B_ContractManage.do?cmd=contractMgPageList&curPage=" + curPageCnt+"&searchGb="+searchGb,"back");		
	}
	
	/**
	 * CreateDate:2013-12-02(월) Writer:shbyeon.
	 * 세금계산서 발행 리스트(계약관리 연동)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return invoiceDetailList
	 * @throws Exception
	 */
	public ActionForward invoiceDetailList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String ContractCode = StringUtil.nvl(request.getParameter("contractcode"), "");
		String ContractName = StringUtil.nvl(request.getParameter("contractname"), "");
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		ContractManageDTO cmDto = new ContractManageDTO();
		ContractManageDAO cmDao = new ContractManageDAO();

		// cmDto 객체 셋팅.
		cmDto.setContractCode(ContractCode);
		
		ListDTO ld = cmDao.invoiceDetailList(cmDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("ContractCode", ContractCode);
		model.put("ContractName", ContractName);
		
		return actionMapping.findForward("invoiceDetailList");
	}
	
	
	
	/**
	 * CreateDate:2013-11-21(목) Writer:shbyeon.
	 * 계약등록 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgPageList
	 * @throws Exception
	 */
	public ActionForward contractMgRegistList(ActionMapping actionMapping,
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
	
		//ProjectDAO pjDao = new ProjectDAO();
		ContractManageDTO cmDto = new ContractManageDTO();
		ContractManageDAO cmDao = new ContractManageDAO();

		// cmDto 객체 셋팅.
		cmDto.setChUserID(USERID);
		cmDto.setvSearchType(searchGb);
		cmDto.setvSearch(searchtxt);
		cmDto.setnRow(10);
		cmDto.setnPage(curPageCnt);
		cmDto.setJobGb("PAGE");

		ListDTO ld = cmDao.contractMgRegistList(cmDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		
		return actionMapping.findForward("contractMgRegistList");
	}
	
	/**
	 * CreateDate:2013-11-21(목) Writer:shbyeon.
	 * 계약등록 리스트
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return contractMgPageList
	 * @throws Exception
	 */
	public ActionForward contractMgRegistList2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		//세션 끊길 시 초기화면
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		
		MultipartRequest multipartRequest = null;
		
		String FilePath = FileUtil.FILE_DIR + "contractmanage/"
				+ DateTimeUtil.getDate() + "/";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID, 20);
		//UploadFiles (,,,20)20의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();

		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(multipartRequest.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);

		//ProjectDAO pjDao = new ProjectDAO();
		ContractManageDTO cmDto = new ContractManageDTO();
		ContractManageDAO cmDao = new ContractManageDAO();

		// cmDto 객체 셋팅.
		cmDto.setChUserID(USERID);
		cmDto.setvSearchType(searchGb);
		cmDto.setvSearch(searchtxt);
		cmDto.setnRow(10);
		cmDto.setnPage(curPageCnt);
		cmDto.setJobGb("PAGE");

		ListDTO ld = cmDao.contractMgRegistList(cmDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		
		return actionMapping.findForward("contractMgRegistList");
	}
	
	
	/**
	 * 미발행/미수 리스트
	 * shbyeon. 2013_02_27(수)
	 */
	public ActionForward UnissuedNoCollect(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), ""); //검색구분 (영업상태)
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), ""); //검색명
		
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);

		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
	/*	ContractManageDTO cmDto = new ContractManageDTO();
		ContractManageDAO cmDao = new ContractManageDAO();

		//리스트
		
		cmDto.setChUserID(USERID);
		cmDto.setvSearchType(searchGb);
		cmDto.setvSearch(searchtxt);
		cmDto.setnRow(10);
		cmDto.setnPage(curPageCnt);
		

		
		
		ListDTO ld = cmDao.UnissuedNoCollectList(cmDto);*/

		ContractManageDTO cmDto = new ContractManageDTO();
		ContractManageDAO cmDao = new ContractManageDAO(); 
		
		  cmDto.setChUserID(USERID);
		  cmDto.setvSearch(searchtxt);
		
		ListDTO ld = cmDao.UnissuedNoCollectList(cmDto);
		model.put("listInfo", ld);
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("invoiceUnissued");
	}
	
	
}
