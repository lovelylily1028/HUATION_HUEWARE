package com.huation.hueware.newsmagazine.action;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jsx3.gui.Alerts;
import jsx3.net.Request;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.oreilly.servlet.MultipartRequest;
import com.sun.org.apache.xalan.internal.xsltc.runtime.Parameter;

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
import com.huation.common.user.UserMemDTO;
import com.huation.common.util.CommonUtil;
import com.huation.common.util.DateSetter;
import com.huation.common.util.DateUtil;

import com.huation.common.user.UserConnectDTO;
import com.huation.common.newsmagazine.NewsMagazineDTO;
import com.huation.common.newsmagazine.NewsMagazineDAO;

public class NewsMagazineAction extends StrutsDispatchAction {

	/**
	 * 게시판->News_Magazine 등록폼_2012_10_24(수)bsh
	 *
	 */
	public ActionForward newsMagazineRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		log.debug("NewsMagazine:등록");

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
		
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("sForm", sForm);
		return actionMapping.findForward("newsMagazineRegistForm");
	}

	/**
	 * News_Magazine 등록처리
	 *
	 * 	 
	 */
	public ActionForward newsMagazineRegist(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "newsmagazine/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				500);	//500M
		//UploadFiles (,,,500)500의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String NewsFile = "";

		if (status.equals("E")) {
			log.debug("첨부 파일 올리려다 실패하였습니다.");
			msg = "첨부 파일 올리려다 실패하였습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("O")) {
			log.debug("첨부하신 파일이 용량을 초과했습니다.");
			msg = "첨부하신 파일이 용량을 초과했습니다.최대 500M 까지 가능합니다.";
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

					if (objName.equals("NewsFile")) {
						NewsFile = uploadFilePath;
					}
				}
			}
		}

		
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		String Title = StringUtil.nvl(
				multipartRequest.getParameter("Title"), "");
		log.debug("제목"+Title);
		String Contents = StringUtil.nvl(
				multipartRequest.getParameter("Contents"), "");
		log.debug("내용"+Contents);
		String NewsFileNm = StringUtil.nvl(
				multipartRequest.getParameter("NewsFileNm"), "");
		log.debug("파일이름"+NewsFileNm);
		
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		NewsMagazineDTO nmDto = new NewsMagazineDTO();

		nmDto.setWriteUser(USERID);
		log.debug("사용자"+USERID);
		nmDto.setNewsFile(NewsFile);
		log.debug("파일경로"+NewsFile);
		nmDto.setNewsFileNm(NewsFileNm);
		log.debug("파일이름"+NewsFileNm);
		nmDto.setTitle(Title);
		log.debug("제목"+Title);
		nmDto.setContents(Contents);
		log.debug("내용"+Contents);
		
		retVal = nmDao.addNewsRegist(nmDto);

		 msg = "News&Magazine 등록에 성공하였습니다";
	        if(retVal < 1) msg = "News&Magazine 등록에 실패하였습니다";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_NewsMagazine.do?cmd=newsMagazinePageList&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
	}


	/**
	 * 게시판-> News_Magazine리스트
	 * 
	 *
	 */
	public ActionForward newsMagazinePageList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);

		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		NewsMagazineDTO nmDto = new NewsMagazineDTO();

		// 리스트
		
		nmDto.setWriteUser(USERID);
		nmDto.setvSearchType(searchGb);
		nmDto.setvSearch(searchtxt);
		nmDto.setnRow(20);
		nmDto.setnPage(curPageCnt);
		ListDTO ld = nmDao.dispNewsPageList(nmDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("newsMagazinePageList");
	}

	/**
	 * 게시판-> News_Magazine리스트
	 * 
	 *
	 */
	public ActionForward newsMagazinePageList2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);

		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.

		  
		  MultipartRequest multipartRequest = null;
		  
		  String FilePath = FileUtil.FILE_DIR + "newsmagazine/"
					+ DateTimeUtil.getDate() + "/";
			log.debug("FilePath= " + FilePath);
			UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
					500);	//500M
			//UploadFiles (,,,500)500의미 MB용량 단위설정
			multipartRequest = uploadEntity.getMultipart();
		  
		  
		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil.nvl(multipartRequest.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);
	
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		NewsMagazineDTO nmDto = new NewsMagazineDTO();

		// 리스트
		
		nmDto.setWriteUser(USERID);
		nmDto.setvSearchType(searchGb);
		nmDto.setvSearch(searchtxt);
		nmDto.setnRow(20);
		nmDto.setnPage(curPageCnt);
		ListDTO ld = nmDao.dispNewsPageList(nmDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("newsMagazinePageList");
	}	
	
	
	
	
	
	/**
	 * News_Magazine 상세정보
	 * 
	 */
	public ActionForward newsMagazineView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;
		int retVal = 0;
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		int Seq = StringUtil.nvl(request.getParameter("Seq"), 1);
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		
		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		 
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		NewsMagazineDTO nmDto = new NewsMagazineDTO();
		//UserMemDTO useridd = new UserMemDTO();

		nmDto.setSeq(Seq);
		nmDto = nmDao.newsMagazineView(nmDto);
		
		//게시판 조회수 증가시키기.
		//상세보기 셀렉트시 ReadCount(조회수를 가져오는동시에 Update로 ReadCount+1 증가시킨다.)
		//이때 disDto에 조회수를 데이터를 셋팅해줄때
		//disDto.setReadCount(disDto.getReadCount()); disDto에있는 ReadCount가져와서 셋팅한다.
		if(nmDto != null){
			
			
		// 프로시저사용안할시 java단에서 처리할때..
		// int hit = disDto.getReadCount();
		// hit += +1;
		// disDto.setReadCount(disDto.getReadCount()+1);	
			//System.out.println(ReadCount+=hit);
			
			
			nmDto.setReadCount(nmDto.getReadCount());
			retVal = nmDao.newsMagazineCount(nmDto);
			System.out.println("readcount1:"+nmDto.getReadCount());
		}
	
	

		model.put("nmDto", nmDto);
		model.put("curPage", String.valueOf(curPageCnt));
		//model.put("useridd", useridd);
		if (nmDto == null) {
			String msg = "News&Magazine  정보가 없습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_NewsMagazine.do?cmd=newsMagazinePageList&curPage=" + curPageCnt
					, "back");
		} else {
			return actionMapping.findForward("newsMagazineView");
		}
	}
	

	/**
	 * News_Magazine 수정
	 *
	 * 	 
	 */
	public ActionForward newsMagazineEdit(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "newsmagazine/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				500);	//500M
		//UploadFiles (,,,500)500의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String NewsFile = "";

		if (status.equals("E")) {
			log.debug("첨부 파일 올리려다 실패하였습니다.");
			msg = "첨부 파일 올리려다 실패하였습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("O")) {
			log.debug("첨부하신 파일이 용량을 초과했습니다.");
			msg = "첨부하신 파일이 용량을 초과했습니다.최대 500M 까지 가능합니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("I")) {
			log.debug("첨부 파일의 정보가 잘못되었습니다.");
			msg = "첨부 파일의 정보가 잘못되었습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("S")) {
			// 업로드된 파일의 정보를 가져와서 데이터 베이스에 넣는 작업을 해준다.
			NewsFile = StringUtil.nvl(
					multipartRequest.getParameter("p_NewsFile"), "");//p_BankBookFile Web(기존데이터)에서받고  BankBookFile DB로담아준다.
			//BankBookFile Request.getparameter 넘겨주는이유 수정시 파일은 수정하지않았을경우 가지고있는파일 유지를위해서 
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

					if (objName.equals("NewsFile")) {
						NewsFile = uploadFilePath;
					}
				}
			}
		}

		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		//수정시 pk값 으로 Update 쳐줘야됨.
		int Seq = StringUtil.nvl(multipartRequest.getParameter("Seq"), 1);
		String Title = StringUtil.nvl(
				multipartRequest.getParameter("Title"), "");
		log.debug("제목"+Title);
		String Contents = StringUtil.nvl(
				multipartRequest.getParameter("Contents"), "");
		log.debug("내용"+Contents);
		String NewsFileNm = StringUtil.nvl(
				multipartRequest.getParameter("NewsFileNm"), "");
		log.debug("파일이름"+NewsFileNm);
		
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		NewsMagazineDTO nmDto = new NewsMagazineDTO();

		nmDto.setSeq(Seq);
		nmDto.setWriteUser(USERID);
		log.debug("사용자"+USERID);
		nmDto.setNewsFile(NewsFile);
		log.debug("파일경로"+NewsFile);
		nmDto.setNewsFileNm(NewsFileNm);
		log.debug("파일이름"+NewsFileNm);
		nmDto.setTitle(Title);
		log.debug("제목"+Title);
		nmDto.setContents(Contents);
		log.debug("내용"+Contents);
		
		retVal = nmDao.newsMagazineUpdate(nmDto);
		
		msg = "News&Magazine 정보가 수정되었습니다";
		if (retVal < 1)
			msg = "News&Magazine 정보 수정이 실패하였습니다";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_NewsMagazine.do?cmd=newsMagazinePageList&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
	}

	/**
	 * News_Magazine = > 삭제
	 */
	public ActionForward newsMagazineDelete(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}

		/*
		 * 삭제시에도 multipartrequest로 요청 삭제 해야된다.
		 */
		String FilePath = FileUtil.FILE_DIR + "newsmagazine/"
		+ DateTimeUtil.getDate() + "/";
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				500);
		MultipartRequest multipartRequest = null;
		multipartRequest = uploadEntity.getMultipart();


		
		String msg = "";
		int retVal = 0;
		int Seq = StringUtil.nvl(multipartRequest.getParameter("Seq"), 1);
		
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		NewsMagazineDTO nmDto = new NewsMagazineDTO();

		nmDto.setSeq(Seq);
		retVal = nmDao.deleteNewsMagazineOne(nmDto);

		msg = "삭제에  성공하였습니다";
		if (retVal < 1)
			msg = "삭제에 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_NewsMagazine.do?cmd=newsMagazinePageList" , "back");
	}

}
