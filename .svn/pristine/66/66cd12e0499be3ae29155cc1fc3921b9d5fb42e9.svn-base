package com.huation.hueware.currentstatus.action;

import java.util.*;

import javax.servlet.http.*;

import org.apache.struts.action.*;

import com.huation.common.*;
import com.huation.common.contractmanage.*;
import com.huation.common.currentstatus.*;
import com.huation.common.user.*;
import com.huation.framework.persist.*;
import com.huation.framework.struts.*;
import com.huation.framework.util.*;
import com.oreilly.servlet.*;




public class CurrentStatusAction extends StrutsDispatchAction {

	/**
	 * 2013_03_07(목) shbyeon.
	 * 영업진행현황->영업진행현황 등록폼
	 *
	 */
	public ActionForward currentStaRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		log.debug("영업진행현황 등록");

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");

		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		// 로그인 처리 끝.
		
		String smlcode=  "P02";  //자사상품
		String smlcode2= "P03"; //비 자사상품(내자)
		String smlcode3= "P04"; //비 자사상품(외수)
		
		//자사 상품코드 Arrlist 시작
		CommonDAO common = new CommonDAO(); 
		ArrayList codeList = null; //어레이 변수 선언
	   	codeList = common.getCodeListPro(smlcode); //어레이 변수 에 코드값을 담기.
	    
	   	//비자사(내수) 상품코드 Arrlist 시작
		ArrayList codeList2 = null; //어레이 변수 선언
	   	codeList2 = common.getCodeListPro(smlcode2); //어레이 변수 에 코드값을 담기.
	   	
	   	//비자사(외수) 상품코드 Arrlist 시작
		ArrayList codeList3 = null; //어레이 변수 선언
	   	codeList3 = common.getCodeListPro(smlcode3); //어레이 변수 에 코드값을 담기.
		
	   	model.put("codeList", codeList); 
	   	model.put("codeList2", codeList2);
	   	model.put("codeList3", codeList3);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("sForm", sForm);
		return actionMapping.findForward("currentStaRegistForm");
	}

	/**
	 * 2013_03_12(화) shbyeon.
	 * 영업지원 - > 영업진행현황 등록처리
	 */
	public ActionForward currentStaRegist(ActionMapping actionMapping,
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
		String sForm = "N";
		
		
		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "comment/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				200);
		//UploadFiles (,,,200)200의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		String SalesFile = "";

		if (status.equals("E")) {
			log.debug("첨부 파일 올리려다 실패하였습니다.");
			msg = "첨부 파일 올리려다 실패하였습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("O")) {
			log.debug("첨부하신 파일이 용량을 초과했습니다.");
			msg = "첨부하신 파일이 용량을 초과했습니다.최대 200M 까지 가능합니다.";
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

					if (objName.equals("SalesFile")) {
						SalesFile = uploadFilePath;
					}
				}
			}
		}
	
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		int Quarter = StringUtil.nvl(
				multipartRequest.getParameter("Quarter"), 0);
		String EnterpriseCode = StringUtil.nvl(
				multipartRequest.getParameter("comp_code"), ""); 
		log.debug("영업주관사 코드"+EnterpriseCode);
		String EnterpriseNm = StringUtil.nvl(
				multipartRequest.getParameter("e_comp_nm"), ""); 
		log.debug("영업주관사 명:"+EnterpriseNm);
		String PermitNo = StringUtil.nvl(
				multipartRequest.getParameter("permit_no"), ""); 
		log.debug("permitNO:"+PermitNo);
		String OperatingCompany = StringUtil.nvl(
				multipartRequest.getParameter("OperatingCompany"), "");
		log.debug("고객사"+OperatingCompany);
		String SalesMan = StringUtil.nvl(
				multipartRequest.getParameter("SalesMan"), "");
		log.debug("고객사 담당자"+SalesMan);
		String SalesManTel = StringUtil.nvl(
				multipartRequest.getParameter("SalesManTel"), "");
		log.debug("고객사 담당자"+SalesMan);
		String ProjectName = StringUtil.nvl(
				multipartRequest.getParameter("ProjectName"), "");
		log.debug("프로젝트명"+ProjectName);
		String SalesProjections = StringUtil.nvl(
				multipartRequest.getParameter("SalesProjections"), "");
		log.debug("예상매출액"+SalesProjections);
		String Orderble = StringUtil.nvl(
				multipartRequest.getParameter("Orderble"), "");
		log.debug("수주가능성"+Orderble);
		String ChargeID = StringUtil.nvl(
				multipartRequest.getParameter("ChargeID"), "");
		log.debug("담당영업정"+ChargeID);
		String ChargeSecondID = StringUtil.nvl(
				multipartRequest.getParameter("ChargeSecondID"), "");
		log.debug("담당영업부"+ChargeSecondID);
		String AssignPerson = StringUtil.nvl(
				multipartRequest.getParameter("AssignPerson"), "");
		log.debug("배정인력"+AssignPerson);
		String DateProjections = StringUtil.nvl(
				multipartRequest.getParameter("DateProjections"), "0");
		log.debug("예상시기"+DateProjections);
		
		String SalesMan_co = StringUtil.nvl(
				multipartRequest.getParameter("SalesMan_co"), "");
		System.out.println("SalesMan_co:"+SalesMan_co);
		String ChargeID_co = StringUtil.nvl(
				multipartRequest.getParameter("ChargeID_co"), "");
		System.out.println("ChargeID_co:"+ChargeID_co);
		String Contents = StringUtil.nvl(
				multipartRequest.getParameter("Contents"), "");
		System.out.println("Contents:"+Contents);
		String SalesFileNm = StringUtil.nvl(
				multipartRequest.getParameter("SalesFileNm"), "");
		System.out.println("SalesFileNm:"+SalesFileNm);
		
	if(OperatingCompany != ""){
		System.out.println("OperatingCompany:"+OperatingCompany);
		
		CurrentStatusDAO csDao = new CurrentStatusDAO();
		CurrentStatusDTO csDto = new CurrentStatusDTO();
		
		String SalesCode = "";
		System.out.println("SalesCode:"+SalesCode);
		
		SalesCode = csDao.addcurrentRegistCode(SalesCode);
		
		
		csDto.setPreSalesCode(SalesCode);
		csDto.setQuarter(Quarter);
		csDto.setEnterpriseCode(EnterpriseCode);
		csDto.setPermitNo(PermitNo);
		csDto.setEnterpriseNm(EnterpriseNm);
		csDto.setOperatingCompany(OperatingCompany);
		csDto.setSalesMan(SalesMan);
		csDto.setSalesManTel(SalesManTel);
		csDto.setProjectName(ProjectName);
		csDto.setSalesProjections(SalesProjections);
		csDto.setOrderble(Orderble);
		csDto.setChargeID(ChargeID);
		csDto.setChargeSecondID(ChargeSecondID);
		csDto.setAssignPerson(AssignPerson);
		csDto.setDateProjections(DateProjections);
		csDto.setWriteUser(USERID);
		
		retVal = csDao.addcurrentRegist(csDto);
		
		//이슈 코멘트 등록 시작.. 2013_05_13(월)shbyeon.
		if(SalesMan_co != ""){
			
			csDto.setProjectPkCo(SalesCode);
			csDto.setSalesMan_co(SalesMan_co);
			csDto.setChargeID_co(USERID);
			csDto.setContents(Contents);
			csDto.setSalesFile(SalesFile);
			csDto.setSalesFileNm(rFileName);
			
			retVal = csDao.addCommentRegist(csDto);
			
		}
		
		/*
		 * 영업진행현황 업체 등록할때 업체명 중복확인 후 등록할때 업체코드 생성해주기.
		 * 2013_05_09(목)현재는사용안함.
		}else if(EnterpriseCode == "" && EnterpriseNm != ""){
			
			csDto.setQuarter(Quarter);
			csDto.setEnterpriseCode(EnterpriseCode);
			csDto.setEnterpriseNm(EnterpriseNm);
			csDto.setOperatingCompany(OperatingCompany);
			csDto.setSalesMan(SalesMan);
			csDto.setSalesManTel(SalesManTel);
			csDto.setProjectName(ProjectName);
			csDto.setSalesProjections(SalesProjections);
			csDto.setOrderble(Orderble);
			csDto.setChargeID(ChargeID);
			csDto.setChargeSecondID(ChargeSecondID);
			csDto.setAssignPerson(AssignPerson);
			csDto.setDateProjections(DateProjections);
			csDto.setWriteUser(USERID);
			
			CompanyDTO cpDto = new CompanyDTO();
			CompanyDAO cpDao = new CompanyDAO();
			retVal = csDao.addcurrentRegist(csDto);
		
			cpDto.setComp_nm(EnterpriseNm);
			System.out.println("SFDFFF:"+EnterpriseNm);
			retVal = cpDao.addCompany(cpDto);
			
		}
		 */
			
		if(retVal == 1){
			String[] ProductCode = multipartRequest.getParameterValues("ProductCode"); //Arr 일때 getParameterValues
			System.out.println("batch count 상품코드 갯수:"+ProductCode.length);
			retVal = csDao.addproductCode(ProductCode);
		}else{
			msg = "영업진행현황(Batch_SQL)실패하였습니다.";
		}

		 msg = "영업진행현황 등록에 성공하였습니다";
	        if(retVal < 1) msg = "영업진행현황 등록에 실패하였습니다";
	} 
	        return alertAndExit(model, msg,request.getContextPath()+"/B_CurrentStatus.do?cmd=currentStaPageList&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
}
	
	/**
	 * 2013_04_07(토) shbyeon.
	 * 영업진행현황  코멘트 등록처리 
	 */
	public ActionForward currentStaComment(ActionMapping actionMapping,
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
		
		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "comment/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				200);
		//UploadFiles (,,,200)200의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String SalesFile = "";

		if (status.equals("E")) {
			log.debug("첨부 파일 올리려다 실패하였습니다.");
			msg = "첨부 파일 올리려다 실패하였습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("O")) {
			log.debug("첨부하신 파일이 용량을 초과했습니다.");
			msg = "첨부하신 파일이 용량을 초과했습니다.최대 200M 까지 가능합니다.";
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

					if (objName.equals("SalesFile")) {
						SalesFile = uploadFilePath;
					}
				}
			}
		}
		
		curPageCnt = StringUtil
				.nvl(request.getParameter("curPage"), 1);
		String PreSalesCode = StringUtil
		.nvl(multipartRequest.getParameter("PreSalesCode"), "");
		System.out.println("PROPK:"+PreSalesCode);
		String ProjectPkCo = StringUtil
		.nvl(multipartRequest.getParameter("ProjectPkCo"), "");
		System.out.println("ProjectPkCo:"+ProjectPkCo);
		String SalesMan_co = StringUtil.nvl(
				multipartRequest.getParameter("SalesMan_co"), "");
		System.out.println("SalesMan:"+SalesMan_co);
		String ChargeID_co = StringUtil.nvl(
				multipartRequest.getParameter("ChargeID_co"), "");
		System.out.println("ChargeID_co:"+ChargeID_co);
		String Contents = StringUtil.nvl(
				multipartRequest.getParameter("Contents"), "");
		System.out.println("Contents:"+Contents);
		String SalesFileNm = StringUtil.nvl(
				multipartRequest.getParameter("SalesFileNm"), "");
		System.out.println("SalesFileNm:"+SalesFileNm);
	
		CurrentStatusDAO csDao = new CurrentStatusDAO();
		CurrentStatusDTO csDto = new CurrentStatusDTO();

		csDto.setProjectPkCo(ProjectPkCo);
		csDto.setSalesMan_co(SalesMan_co);
		csDto.setChargeID_co(USERID);
		csDto.setContents(Contents);
		csDto.setSalesFile(SalesFile);
		csDto.setSalesFileNm(rFileName);
		
		retVal = csDao.addCommentRegist(csDto);
		
		 msg = "이슈 코멘트를 등록하였습니다.";
	        if(retVal < 1) msg = "이슈 코멘트 등록 실패하였습니다.";
	        csDto.setComentPk(retVal);
	        model.put("csDto", csDto);
	        model.put("msg", msg);
	        
	        return actionMapping.findForward("commentRegistResult");
	}
	
	
	
	/**
	 * 2013_04_07(토) shbyeon.
	 * 영업진행현황  코멘트 수정처리 
	 */
	public ActionForward currentStaCommentUp(ActionMapping actionMapping,
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
		
		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "comment/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				200);
		//UploadFiles (,,,200)200의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String SalesFile = "";
		String p_SalesFile = "";
		String ModifyFlag = "N";

		if (status.equals("E")) {
			log.debug("첨부 파일 올리려다 실패하였습니다.");
			msg = "첨부 파일 올리려다 실패하였습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("O")) {
			log.debug("첨부하신 파일이 용량을 초과했습니다.");
			msg = "첨부하신 파일이 용량을 초과했습니다.최대 200M 까지 가능합니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("I")) {
			log.debug("첨부 파일의 정보가 잘못되었습니다.");
			msg = "첨부 파일의 정보가 잘못되었습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("S")) {
			// 업로드된 파일의 정보를 가져와서 데이터 베이스에 넣는 작업을 해준다.
			SalesFile = StringUtil.nvl(
					multipartRequest.getParameter("p_SalesFile"), "");
			p_SalesFile = StringUtil.nvl(
					multipartRequest.getParameter("p_SalesFile"), "");
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

					if (objName.equals("SalesFile")) {
						SalesFile = uploadFilePath;
					}
				}
			}
		}
		
		if(SalesFile.equals(p_SalesFile)){
			ModifyFlag="N";
		}else{
			ModifyFlag="Y";
			
		}
		curPageCnt = StringUtil
				.nvl(request.getParameter("curPage"), 1);
		int ComentPk = StringUtil
		.nvl(multipartRequest.getParameter("ComentPk"), 1);
		System.out.println("ComentPk 수정:"+ComentPk);
		String ProjectPkCo = StringUtil
		.nvl(multipartRequest.getParameter("ProjectPkCo"), "");
		System.out.println("ProjectPkCo 수정:"+ProjectPkCo);
		String SalesMan_co = StringUtil.nvl(
				multipartRequest.getParameter("SalesMan_co"), "");
		System.out.println("SalesMan:"+SalesMan_co);
		String ChargeID_co = StringUtil.nvl(
				multipartRequest.getParameter("ChargeID_co"), "");
		System.out.println("ChargeID_co:"+ChargeID_co);
		String Contents = StringUtil.nvl(
				multipartRequest.getParameter("Contents"), "");
		System.out.println("Contents:"+Contents);
		String SalesFileNm = StringUtil.nvl(
				multipartRequest.getParameter("SalesFileNm"), "");
		System.out.println("SalesFileNm:"+SalesFileNm);
	    
		CurrentStatusDAO csDao = new CurrentStatusDAO();
		CurrentStatusDTO csDto = new CurrentStatusDTO();

		csDto.setComentPk(ComentPk);
		csDto.setProjectPkCo(ProjectPkCo);
		csDto.setSalesMan_co(SalesMan_co);
		csDto.setChargeID_co(USERID);
		csDto.setContents(Contents);
		csDto.setSalesFile(SalesFile);
		csDto.setSalesFileNm(SalesFileNm);
		
		retVal = csDao.CommentUpdate(csDto);
		
		
		
		 msg = "이슈 코멘트를 수정하였습니다.";
	        if(retVal < 1) msg = "이슈 코멘트 수정 실패하였습니다.";
	       
	        model.put("msg", msg);
	        model.put("SalesFile", SalesFile);
	        model.put("SalesFileNm", SalesFileNm);
	        model.put("ComentPk", ""+ComentPk);
	        model.put("ModifyFlag", ModifyFlag);
	        return actionMapping.findForward("comentModifyResult");
	}
	
	
	/**
	 * 자유게시판  덧글 수정처리
	 *
	 * 	 
	public ActionForward freeBoardUpdateRep(ActionMapping actionMapping,
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
		
		  //ㄱㄱㄱㄱ삭제시에도 multipartrequest로 요청 삭제 해야된다.
		
		String FilePath = FileUtil.FILE_DIR + "freeboard/"
		+ DateTimeUtil.getDate() + "/";
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				30);
		MultipartRequest multipartRequest = null;
		multipartRequest = uploadEntity.getMultipart();
		int curPageCnt = 0;
		
		curPageCnt = StringUtil
				.nvl(request.getParameter("curPage"), 1);
		int SeqBoard = StringUtil
		.nvl(multipartRequest.getParameter("SeqBoard"), 1);
		log.debug("게시글시퀀스SeqBoard//ActionRequest:"+SeqBoard);
		//덧글 pk SeqRep Update
		int SeqRep = StringUtil
		.nvl(multipartRequest.getParameter("SeqRep"), 1);
		log.debug("SeqRep//ActionRequest:"+SeqRep);
		String TitleBoard = StringUtil.nvl(
				request.getParameter("TitleBoard"), "");
		log.debug("자유게시판글제목TitleBoard//ActionRequest:"+TitleBoard);
		String WriteUserBoard = StringUtil.nvl(
				request.getParameter("WriteUserBoard"), "");
		String ContentsRep = StringUtil.nvl(
				multipartRequest.getParameter("ContentsRep"), "");
		log.debug("덧글내용SeqBoard//ActionRequest:"+ContentsRep);
		
		FreeBoardDAO fbDao = new FreeBoardDAO();
		FreeBoardDTO fbDto = new FreeBoardDTO();

		fbDto.setSeqRep(SeqRep);
		log.debug("자유게시판 글 SeqRep Pk:ActionSet UPDATE:"+SeqRep);
		fbDto.setSeqBoard(SeqBoard);
		log.debug("자유게시판 글 Seq Pk:Action:"+SeqBoard);
		fbDto.setWriteUserBoard(WriteUserBoard);
		log.debug("자유게시판글사용자Action:"+WriteUserBoard);
		fbDto.setRepWriteUser(USERID);
		log.debug("덧글등록사용자Action:"+USERID);
		fbDto.setTitleBoard(TitleBoard);
		log.debug("자유게시판글목록Action:"+TitleBoard);
		fbDto.setContentsRep(ContentsRep);
		log.debug("덧글내용Action:"+ContentsRep);
		
		retVal = fbDao.BoardUpdateRep(fbDto);

		 msg = "덧글을 수정하였습니다";
	        if(retVal < 1) msg = "덧글 수정을 실패하였습니다";
	        
	        return alertAndExit(model, msg, request.getContextPath()
					+ "/B_FreeBoard.do?cmd=freeBoardPageList&curPage=" + curPageCnt
					, "back");
	}
*/


	/**
	 * 영업지원->영업진행현황 리스트
	 * shbyeon. 2013_02_27(수)
	 */
	public ActionForward currentStaPageList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String searchGbYear = StringUtil.nvl(request.getParameter("searchGbYear"), ""); //검색구분 (년도)
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), ""); //검색구분 (영업상태)
		String searchGb2 = StringUtil.nvl(request.getParameter("searchGb2"), ""); //검색구분 (목록)
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), ""); //검색명
		
		//int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1); //현재페이지 사용x
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);

		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		CurrentStatusDAO csDao = new CurrentStatusDAO();
		CurrentStatusDTO csDto = new CurrentStatusDTO();

		//리스트
		csDto.setvSearchYear(searchGbYear); //검색구분 (년도)
		csDto.setvSearchType(searchGb);  //검색구분 (영업상태)
		csDto.setvSearchType2(searchGb2); //검색구분 (목록)
		csDto.setvSearch(searchtxt);
		//csDto.setnRow(0); SP에서 JobGB를 LIST형태로 받아서 전체 리스트를가져온다.
		csDto.setnPage(1);
		
		//1/2/3/4 분기별 리스트
		ListDTO ld = csDao.CurrentStatusList(csDto);


		model.put("listInfo", ld);
		model.put("searchGbYear", searchGbYear);
		model.put("searchGb", searchGb);
		model.put("searchGb2", searchGb2);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("currentStaPageList");
	}
	
	
	/**
	 * 영업지원->영업진행현황 Excel 리스트
	 * 2013_03_07 shbyeon.
	 */
	public ActionForward currentStaExcel(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String searchGbYear = StringUtil.nvl(request.getParameter("searchGbYear"), ""); //검색구분 (년도)
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), ""); //검색구분 (영업상태)
		String searchGb2 = StringUtil.nvl(request.getParameter("searchGb2"), ""); //검색구분 (목록)
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), ""); //검색명
		
		CurrentStatusDAO csDao = new CurrentStatusDAO();
		CurrentStatusDTO csDto = new CurrentStatusDTO();
		
		csDto.setvSearchYear(searchGbYear); //검색구분 (년도)
		csDto.setvSearchType(searchGb);  //검색구분 (영업상태)
		csDto.setvSearchType2(searchGb2); //검색구분 (목록)
		csDto.setvSearch(searchtxt);
		//csDto.setnRow(0);SP에서 JobGB를 LIST형태로 받아서 전체 리스트를가져온다.
		csDto.setnPage(1);
		
		ListDTO ld = csDao.currentListExcel(csDto);
		model.put("listInfo", ld);
		model.put("csDto", csDto);
		model.put("searchGbYear", searchGbYear);
		model.put("searchGb", searchGb);
		model.put("searchGb2", searchGb2);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("currentStaExcel");
	}
	
	/**
	 * 2013_04_08(월) shbyeon.
	 * 영업진행현황 = > 이슈 코멘트 상세보기
	 */
	public ActionForward currentCommentIframe(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;
		int retVal = 0;
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String PreSalesCode = StringUtil.nvl(request.getParameter("PreSalesCode"), "");
		//해당게시글에관한 pk
		String ProjectPkCo = StringUtil.nvl(request.getParameter("ProjectPkCo"), "");
		//해당게시글에 관한 매핑 pk
		int ComentPk = StringUtil.nvl(request.getParameter("ComentPk"), 1);
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		 
		CurrentStatusDAO csDao = new CurrentStatusDAO();
		CurrentStatusDTO csDto = new CurrentStatusDTO();
		//UserMemDTO useridd = new UserMemDTO();
		csDto.setPreSalesCode(PreSalesCode);
		//System.out.println("영업진행현황 VIEW_PK:"+PreSalesCode);
		csDto.setComentPk(ComentPk);
		//System.out.println("코멘트_VIEW_PK:"+ComentPk);
		csDto.setChargeID_co(USERID);
		csDto = csDao.currentView(csDto);
	
		
				//영업진행현황  이슈 코멘트 리스트 
				csDto.setComentPk(csDto.getComentPk());
				csDto.setProjectPkCo(csDto.getProjectPkCo()); //csDto에있는  ProjectPkCo 를 가져온다
				
				// 리스트 
				csDto.setnRow(0); //초기에 5개지정해준게이놈이고
				csDto.setnPage(curPageCnt);
				
				ListDTO ld = csDao.currentListComment(csDto);
				model.put("listInfo", ld);   //영업진행현황 코멘트 리스트
				model.put("csDto", csDto);
				model.put("curPage", String.valueOf(curPageCnt));
				
		if (csDto == null) {
			String msg = "영업진행현황 이슈 코멘트  정보가 없습니다.";
			 return alertAndExit(model, msg,request.getContextPath()+"" +
			 		"/B_CurrentStatus.do?cmd=currentStaPageList&curPage=","back");		
		} else {
			return actionMapping.findForward("currentCommentIframe");
		}
	}
	
	
	/**
	 * 2013_03_14(목) shbyeon.
	 * 영업지원 - > 영업진행현황 상세보기
	 */
	public ActionForward currentStaView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;
		int retVal = 0;
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String PreSalesCode = StringUtil.nvl(request.getParameter("PreSalesCode"), "");
		String PublicNo = StringUtil.nvl(request.getParameter("PublicNo"), "");

		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } 
		//로그인 처리 끝.
		 
		CurrentStatusDAO csDao = new CurrentStatusDAO();
		CurrentStatusDTO csDto = new CurrentStatusDTO();
		CurrentStatusDTO csDtoPro = new CurrentStatusDTO();
		
		ArrayList productList = null; //상품코드 가져올 어레이 변수 선언
		
		//영업진행현황 & 견적서발행 연동으로 인해 견적서발행번호로 벨류데이션 체크 시작..
		
		if(PublicNo == ""){
		log.debug("[영업진행현황 상세정보 선택된 Action SC_CODE=("+PreSalesCode+") 해당 ProductCode Select List Start Action..");	
		log.debug("[견적서 발행번호 =("+PublicNo+") 빈값 이므로 영업진행현황 독립적인 상품코드 로 판단함..OK] Action..");
		//csDto 영업진행현황 상세보기 DTO
		//csDtoPro 상품코드 리스트 DTO PreSalesCode 겹치지 않게 객체 셋팅 하기위함 겹칠 경우에 값을 제대로 못받아옴.
		csDto.setPreSalesCode(PreSalesCode);
		csDtoPro.setPreSalesCode(PreSalesCode);
		csDto.setPublicNo(PublicNo);
		csDtoPro.setPublicNo(PublicNo);
		
		productList = csDao.getproductViewList(csDtoPro);
		log.debug("[영업진행현황 상세정보 선택된  ProductList=("+productList+") 맞는 상품코드 Array List 가져옴. Action..");	
		log.debug("[영업진행현황 상세정보 선택된  SC_CODE=("+PreSalesCode+") 해당 ProductCode Select List end Action..");	
		//영업진행현황 & 견적서발행 연동으로 인해 견적서발행번호로 벨류데이션 체크 끝..
		
		
		//영업진행현황 상세보기 시작..
		//영업진행현황 htSalesCurrentStatus 입력 데이터를 가져옴. 상품코드 (x)
		csDto = csDao.currentView(csDto);
		
		//(코드북 상품코드)		
		String smlcode=  "P02";  //자사상품
		String smlcode2= "P03"; //비 자사상품(내자)
		String smlcode3= "P04"; //비 자사상품(외자)
		
		//자사 상품코드 Arrlist 시작
		CommonDAO common = new CommonDAO(); 
		ArrayList codeList = null; //어레이 변수 선언
	   	codeList = common.getCodeListPro(smlcode); //어레이 변수 에 코드값을 담기.
	    
	   	//비자사(내수) 상품코드 Arrlist 시작
		ArrayList codeList2 = null; //어레이 변수 선언
	   	codeList2 = common.getCodeListPro(smlcode2); //어레이 변수 에 코드값을 담기.
	   	
	   	//비자사(외수) 상품코드 Arrlist 시작
		ArrayList codeList3 = null; //어레이 변수 선언
	   	
		
		codeList3 = common.getCodeListPro(smlcode3); //어레이 변수 에 코드값을 담기.
	   	
	   	csDto.setProjectPkCo(PreSalesCode);
	   	ListDTO ld = csDao.currentListComment(csDto);
			
	   	model.put("listInfo", ld);   //영업진행현황 코멘트 리스트
	   	model.put("productList", productList);
	   	model.put("codeList", codeList); 
	   	model.put("codeList2", codeList2);
	   	model.put("codeList3", codeList3);		
		model.put("csDto", csDto);
		model.put("csDtoPro", csDtoPro);
		model.put("curPage", String.valueOf(curPageCnt));
		}else{
		log.debug("[영업진행현황 상세정보 선택된 Action SC_CODE=("+PreSalesCode+") 해당 ProductCode Select List Start Action..");	
		log.debug("[견적서 발행번호 =("+PublicNo+") 값이 있으므로 영업진행현황 조회로 견적서를 발행한 상품코드로 판단함..OK] Action..");
		
		//csDto 영업진행현황 상세보기 DTO
		//csDtoPro 상품코드 리스트 DTO PreSalesCode 겹치지 않게 객체 셋팅 하기위함 겹칠 경우에 값을 제대로 못받아옴.
		csDto.setPreSalesCode(PreSalesCode);
		csDtoPro.setPreSalesCode(PreSalesCode);
		csDto.setPublicNo(PublicNo);
		csDtoPro.setPublicNo(PublicNo);
		
		productList = csDao.getproductViewList_EST_SC(csDtoPro);
		log.debug("[영업진행현황 상세정보 선택된  ProductList=("+productList+") 맞는 상품코드 Array List 가져옴. Action..");	
		log.debug("[영업진행현황 상세정보 선택된  SC_CODE=("+PreSalesCode+") 해당 ProductCode Select List end Action..");	
		//영업진행현황 & 견적서발행 연동으로 인해 견적서발행번호로 벨류데이션 체크 끝..
		
		
		//영업진행현황 상세보기 시작..
		//영업진행현황 htSalesCurrentStatus 입력 데이터를 가져옴. 상품코드 (x)
		csDto = csDao.currentView(csDto);
		
		//(코드북 상품코드)		
		String smlcode=  "P02";  //자사상품
		String smlcode2= "P03"; //비 자사상품(내자)
		String smlcode3= "P04"; //비 자사상품(외자)
		
		//자사 상품코드 Arrlist 시작
		CommonDAO common = new CommonDAO(); 
		ArrayList codeList = null; //어레이 변수 선언
	   	codeList = common.getCodeListPro(smlcode); //어레이 변수 에 코드값을 담기.
	    
	   	//비자사(내수) 상품코드 Arrlist 시작
		ArrayList codeList2 = null; //어레이 변수 선언
	   	codeList2 = common.getCodeListPro(smlcode2); //어레이 변수 에 코드값을 담기.
	   	
	   	//비자사(외수) 상품코드 Arrlist 시작
		ArrayList codeList3 = null; //어레이 변수 선언
	   	
		
		codeList3 = common.getCodeListPro(smlcode3); //어레이 변수 에 코드값을 담기.
	   	
	   	csDto.setProjectPkCo(PreSalesCode);
	   	System.out.println("PreSalesCode:"+PreSalesCode);
	   	ListDTO ld = csDao.currentListComment(csDto);
			
	   	model.put("listInfo", ld);   //영업진행현황 코멘트 리스트
	   	model.put("productList", productList);
	   	model.put("codeList", codeList); 
	   	model.put("codeList2", codeList2);
	   	model.put("codeList3", codeList3);		
		model.put("csDto", csDto);
		model.put("csDtoPro", csDtoPro);
		model.put("curPage", String.valueOf(curPageCnt));
		}
	
		if (csDto == null) {
			String msg = "영업진행현황  정보가 없습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_CurrentStatus.do?cmd=currentStaPageList&curPage=" + curPageCnt
					, "back");
		} else {
			return actionMapping.findForward("currentStaView");
		}
	}
	
	
	

	/**
	 * 2013_04_06(금) shbyeon.
	 * 영업지원 - > 영업진행현황 수정처리
	 */
	public ActionForward currentStaEdit(ActionMapping actionMapping,
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

		int retVal = 0; //데이터 수정처리 결과값
		int retVal_ProductDel = 0; //상품코드 수정처리 결과값
		String msg = "";

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";
		
		curPageCnt = StringUtil
				.nvl(request.getParameter("curPage"), 1);
		String PreSalesCode = StringUtil.nvl(request.getParameter("PreSalesCode"), "");
		log.debug("[영업진행현황 수정처리 Start GetValue SC_CODE:["+PreSalesCode+"] action..영업진행현황 수정처리 Param");
		int Quarter = StringUtil.nvl(
				request.getParameter("Quarter"), 0);
		String EnterpriseCode = StringUtil.nvl(
				request.getParameter("comp_code"), ""); 
		//log.debug("영업주관사 코드"+EnterpriseCode);
		String PermitNo = StringUtil.nvl(
				request.getParameter("permit_no"), ""); 
		//log.debug("영업주관사 코드"+EnterpriseCode);
		String EnterpriseNm = StringUtil.nvl(
				request.getParameter("e_comp_nm"), ""); 
		//log.debug("영업주관사 명:"+EnterpriseNm);
		String OperatingCompany = StringUtil.nvl(
				request.getParameter("OperatingCompany"), "");
		//log.debug("고객사"+OperatingCompany);
		String SalesMan = StringUtil.nvl(
				request.getParameter("SalesMan"), "");
		//log.debug("고객사 담당자"+SalesMan);
		String SalesManTel = StringUtil.nvl(
				request.getParameter("SalesManTel"), "");
		//log.debug("고객사 담당자 전화번호"+SalesManTel);
		String ProjectName = StringUtil.nvl(
				request.getParameter("ProjectName"), "");
		//log.debug("예상프로젝트명"+ProjectName);
		String SalesProjections = StringUtil.nvl(
				request.getParameter("SalesProjections"), "");
		//log.debug("예상수주액"+SalesProjections);
		String Orderble = StringUtil.nvl(
				request.getParameter("Orderble"), "");
		//log.debug("수주가능성"+Orderble);
		String ChargeID = StringUtil.nvl(
				request.getParameter("ChargeID"), "");
		//log.debug("담당영업정"+ChargeID);
		String ChargeSecondID = StringUtil.nvl(
				request.getParameter("ChargeSecondID"), "");
		//log.debug("담당영업부"+ChargeSecondID);
		String AssignPerson = StringUtil.nvl(
				request.getParameter("AssignPerson"), "");
		//log.debug("기술분야 배정인력"+AssignPerson);
		String DateProjections = StringUtil.nvl(
				request.getParameter("DateProjections"), "");
		//log.debug("예상시기"+DateProjections);
		String checkyn= StringUtil.nvl(request.getParameter("checkyn"),"");
		
		String PublicNo= StringUtil.nvl(request.getParameter("PublicNo"),"");
		log.debug("[영업진행현황 수정처리 Start GetValue PublicNo:["+PublicNo+"] action..영업진행현황 수정처리 Param");
		CurrentStatusDAO csDao = new CurrentStatusDAO();
		CurrentStatusDTO csDto = new CurrentStatusDTO();
		//CurrentStatusDTO csDtoPro = new CurrentStatusDTO();
		
		csDto.setPreSalesCode(PreSalesCode);
		//csDtoPro.setPreSalesCode(PreSalesCode);
		csDto.setQuarter(Quarter);
		csDto.setEnterpriseCode(EnterpriseCode);
		csDto.setPermitNo(PermitNo);
		csDto.setEnterpriseNm(EnterpriseNm);
		csDto.setOperatingCompany(OperatingCompany);
		csDto.setSalesMan(SalesMan);
		csDto.setSalesManTel(SalesManTel);
		csDto.setProjectName(ProjectName);
		csDto.setSalesProjections(SalesProjections);
		csDto.setOrderble(Orderble);
		csDto.setChargeID(ChargeID);
		csDto.setChargeSecondID(ChargeSecondID);
		csDto.setAssignPerson(AssignPerson);
		csDto.setDateProjections(DateProjections);
		csDto.setUpdateUser(USERID);
		csDto.setCheckyn(checkyn);
		retVal = csDao.currentUpdate(csDto);
		System.out.println("retVal : "+retVal);
		
		//영업진행현황 수정처리 시 견적서 매핑(견적번호)이 안되있는 상태.
		if(PublicNo == ""){
			if(retVal == 1){
				log.debug("[영업진행현황 Single 수정처리 시작 Product Code Regist Start action..영업진행현황 Single 수정처리]");
				log.debug("[영업진행현황 Single 수정대상 코드번호:"+PreSalesCode+"] action..영업진행현황 Single]");
				
				retVal_ProductDel = csDao.deleteProductAll(csDto);
				log.debug("[영업진행현황 Single 상품코드 Delete Count:["+retVal_ProductDel+"] action..영업진행현황 Single]");
				
				String ProductPk = request.getParameter("PreSalesCode"); //Arr 일때 getParameterValues
				String ProductMappingPk = request.getParameter("PublicNo");
				String[] ProductCode = request.getParameterValues("ProductCode"); //Arr 일때 getParameterValues
				retVal = csDao.upDateproductCode(ProductCode, ProductPk,ProductMappingPk);
				log.debug("[Arr getValues ProductCode Count:"+ProductCode.length+"] action..영업진행현황 Single 수정처리]");
				log.debug("[영업진행현황 Single 수정처리 상품코드 Insert [1]정상,[1]이 아닌 값 실패! 성공여부=["+retVal+"] action..영업진행현황 Single 수정처리]");	
				log.debug("[영업진행현황 Single 수정처리 끝 Product Code Regist end action..영업진행현황 Single 수정처리]");
			}else{
				msg = "상품코드 등록(Batch_SQL)실패하였습니다.";
			}
		//영업진행현황 수정처리 시 견적서 매핑(견적번호)이 되있는 상태.
		}else{
			if(retVal == 1){
				log.debug("[영업진행현황 Mapping 수정처리 시작 Product Code Regist Start action..영업진행현황 Mapping 수정처리]");
				log.debug("[영업진행현황 Mapping 수정대상 코드번호:"+PreSalesCode+"] action..영업진행현황 Mapping 수정처리]");
				log.debug("[영업진행현황 Mapping 수정대상  견적서 발행번호:"+PublicNo+"] action..영업진행현황 Mapping 수정처리");
				
				csDto.setPublicNo(PublicNo); //매핑값으로 받은 견적서 발행번호 수정대상 값 셋팅. 상품코드 UPDATE 용도. 영업진행현황 데이터에는 물리적으로 UPDATE 되지않음.
				retVal_ProductDel = csDao.deleteProductAll(csDto);
				log.debug("[영업진행현황 Mapping 상품코드 Delete Count:["+retVal_ProductDel+"] action..영업진행현황 Mapping 수정처리]");
				
				String ProductPk = request.getParameter("PreSalesCode"); //Arr 일때 getParameterValues
				String ProductMappingPk = request.getParameter("PublicNo");
				String[] ProductCode = request.getParameterValues("ProductCode"); //Arr 일때 getParameterValues
				retVal = csDao.upDateproductCode(ProductCode, ProductPk,ProductMappingPk);
				log.debug("[Arr getValues ProductCode Count:"+ProductCode.length+"] action..영업진행현황 Mapping 수정처리]");
				log.debug("[영업진행현황  Mapping 수정처리 상품코드 Insert [1]정상,[1]이 아닌 값 실패! 성공여부=["+retVal+"] action..영업진행현황 Mapping 수정처리]");	
				log.debug("[영업진행현황  Mapping 수정처리 끝 Product Code Regist end action..영업진행현황 Mapping 수정처리]");
			}else{
				msg = "상품코드 등록(Batch_SQL)실패하였습니다.";
			}
		}

		 msg = "영업진행현황 수정에 성공하였습니다";
	        if(retVal < 1) msg = "영업진행현황 수정에 실패하였습니다";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_CurrentStatus.do?cmd=currentStaPageList&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
	}

	/**
	 * 2013_04_08(월) shbyeon.
	 * 영업진행현황 = > 목록삭제
	 */
	public ActionForward currentStaDelete(ActionMapping actionMapping,
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
		String PreSalesCode = StringUtil.nvl(request.getParameter("PreSalesCode"), "");
		
		CurrentStatusDAO csDao = new CurrentStatusDAO();
		CurrentStatusDTO csDto = new CurrentStatusDTO();

		csDto.setPreSalesCode(PreSalesCode);
		retVal = csDao.deleteCurrentOne(csDto);
		
		msg = "영업진행현황 목록 삭제완료.";
		if (retVal < 1)
			msg = "영입잰행현황 목록 삭제실패.";

		 return alertAndExit(model, msg,request.getContextPath()+"/B_CurrentStatus.do?cmd=currentStaPageList","back");
	}

	/**
	 * 자유게시판 = > 덧글삭제
	 */
	public ActionForward comentDeleteResult(ActionMapping actionMapping,
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
		int ComentPk = StringUtil.nvl(request.getParameter("ComentPk"), 1);

		CurrentStatusDAO csDao = new CurrentStatusDAO();
		CurrentStatusDTO csDto = new CurrentStatusDTO();

		csDto.setComentPk(ComentPk);
		retVal = csDao.deleteOneComent(csDto);

		msg = "삭제에  성공하였습니다";
		if (retVal < 1)
			msg = "삭제에 실패하였습니다";
		
		model.put("msg", msg);
		model.put("ComentPk", ""+ComentPk);

		return actionMapping.findForward("comentDeleteResult");
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

		return actionMapping.findForward("UnissuedNoCollect");
	}
	
	
	/**
	 * 영업지원->미발행/미수 Excel 리스트
	 * 2013_03_07 shbyeon.
	 */
	public ActionForward UnissuedNoCollectExcel(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		String USERID = UserBroker.getUserId(request);
		
		
		
		
		ContractManageDTO cmDto = new ContractManageDTO();
		ContractManageDAO cmDao = new ContractManageDAO(); 
		CommonDAO comDao = new CommonDAO();

		ListDTO ld = cmDao.UnissuedNoCollectExcelList();
		model.put("listInfo", ld);
		model.put("cmDto", cmDto);
		model.put("comDao", comDao);

		return actionMapping.findForward("UnissuedNoCollectExcel");
	}
	
	/**
	 * 영업지원->미발행/미수 Excel 리스트
	 * 2013_03_07 shbyeon.
	 */
	public ActionForward UnissuedNoCollectExcel2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		String USERID = UserBroker.getUserId(request);
		
		
		
		
		ContractManageDTO cmDto = new ContractManageDTO();
		ContractManageDAO cmDao = new ContractManageDAO(); 
		CommonDAO comDao = new CommonDAO();

		ListDTO ld = cmDao.UnissuedNoCollectExcelList();
		model.put("listInfo", ld);
		model.put("cmDto", cmDto);
		model.put("comDao", comDao);

		return actionMapping.findForward("UnissuedNoCollectExcel2");
	}
	
		
	
}
