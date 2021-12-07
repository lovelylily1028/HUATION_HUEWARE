package com.huation.hueware.freeboard.action;

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

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.oreilly.servlet.MultipartRequest;
import com.sun.org.apache.xalan.internal.xsltc.runtime.Parameter;
import com.sun.org.apache.xerces.internal.impl.RevalidationHandler;

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

import com.huation.common.freeboard.FreeBoardDAO;
import com.huation.common.freeboard.FreeBoardDTO;


public class FreeBoardAction extends StrutsDispatchAction {

	/**
	 * 게시판->자유게시판 등록폼
	 *
	 */
	public ActionForward freeBoardRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		log.debug("경조사 등록");

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
		return actionMapping.findForward("freeBoardRegistForm");
	}

	/**
	 * 자유게시판 등록처리
	 *
	 * 	 
	 */
	public ActionForward freeBoardRegist(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "freeboard/"
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

		String BoardFile = "";

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

					if (objName.equals("BoardFile")) {
						BoardFile = uploadFilePath;
					}
				}
			}
		}

		
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		String BoardFileNm = StringUtil.nvl(
				multipartRequest.getParameter("BoardFileNm"), "");
		log.debug("파일이름"+BoardFileNm);
		String Title = StringUtil.nvl(
				multipartRequest.getParameter("Title"), "");
		String Contents = StringUtil.nvl(
				multipartRequest.getParameter("Contents"), "");
		log.debug("내용"+Contents.length());
		
		FreeBoardDAO fbDao = new FreeBoardDAO();
		FreeBoardDTO fbDto = new FreeBoardDTO();

		fbDto.setWriteUser(USERID);
		//log.debug("사용자"+USERID);
		fbDto.setBoardFile(BoardFile);
		fbDto.setBoardFileNm(BoardFileNm);
		//log.debug("파일경로"+BoardFile);
		//log.debug("파일이름"+BoardFileNm);
		fbDto.setTitle(Title);
		//log.debug("제목"+Title);
		fbDto.setContents(Contents);
		//log.debug("내용"+Contents);
		
		retVal = fbDao.addBoardRegist(fbDto);

		 msg = "게시글 등록에 성공하였습니다";
	        if(retVal < 1) msg = "게시글 등록에 실패하였습니다";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_FreeBoard.do?cmd=freeBoardPageList&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
	}
	
	/**
	 * 자유게시판  덧글 등록처리
	 *
	 * 	 
	 */
	public ActionForward freeBoardRegistRep(ActionMapping actionMapping,
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
		/*
		 * 삭제시에도 multipartrequest로 요청 삭제 해야된다.
		 */
		String FilePath = FileUtil.FILE_DIR + "freeboard/"
		+ DateTimeUtil.getDate() + "/";
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				30);
		MultipartRequest multipartRequest = null;
		multipartRequest = uploadEntity.getMultipart();
		int curPageCnt = 0;
		
		int Seq = StringUtil
		.nvl(multipartRequest.getParameter("Seq"), 1);
		curPageCnt = StringUtil
				.nvl(request.getParameter("curPage"), 1);
		int SeqBoard = StringUtil
		.nvl(request.getParameter("SeqBoard"), 1);
		String TitleBoard = StringUtil.nvl(
				request.getParameter("TitleBoard"), "");
		String WriteUserBoard = StringUtil.nvl(
				request.getParameter("WriteUserBoard"), "");
		String ContentsRep = StringUtil.nvl(
				multipartRequest.getParameter("ContentsRep"), "");
	
		FreeBoardDAO fbDao = new FreeBoardDAO();
		FreeBoardDTO fbDto = new FreeBoardDTO();

		fbDto.setSeqBoard(SeqBoard);
		fbDto.setWriteUserBoard(WriteUserBoard);
		fbDto.setRepWriteUser(USERID);
		fbDto.setTitleBoard(TitleBoard);
		fbDto.setContentsRep(ContentsRep);
		
		retVal = fbDao.addBoardRegistRep(fbDto);
		
		msg = "덧글 등록에 성공하였습니다";
	
			
		    //int hit = fbDto.getReplyCount();
			//hit += +1;
			//fbDto.setReplyCount(fbDto.getReplyCount()+1);	
				//System.out.println(fbDto.getReplyCount());
		

	        if(retVal < 1) msg = "덧글 등록에 실패하였습니다";
	        
	        return alertAndExit(model, msg, request.getContextPath()
					+ "/B_FreeBoard.do?cmd=freeBoardReplyIframe&Seq="+Seq , "back");
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
	 * 게시판->자유게시판 리스트
	 * 
	 *
	 */
	public ActionForward freeBoardPageList(ActionMapping actionMapping,
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
	
		FreeBoardDAO fbDao = new FreeBoardDAO();
		FreeBoardDTO fbDto = new FreeBoardDTO();

		// 리스트
		
		fbDto.setWriteUser(USERID);
		fbDto.setvSearchType(searchGb);
		fbDto.setvSearch(searchtxt);
		fbDto.setnRow(20);
		fbDto.setnPage(curPageCnt);
		ListDTO ld = fbDao.BoardPageList(fbDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("freeBoardPageList");
	}

	
	
	/**
	 * 게시판->자유게시판 리스트
	 * 
	 *
	 */
	public ActionForward freeBoardPageList2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);

		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		  
		  MultipartRequest multipartRequest = null;
		  
		  String FilePath = FileUtil.FILE_DIR + "freeboard/"
					+ DateTimeUtil.getDate() + "/";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				500);	//500M
		//UploadFiles (,,,500)500의미 MB용량 단위설정
		multipartRequest = uploadEntity.getMultipart();
		  

		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil.nvl(multipartRequest.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);
		
	
		FreeBoardDAO fbDao = new FreeBoardDAO();
		FreeBoardDTO fbDto = new FreeBoardDTO();

		// 리스트
		
		fbDto.setWriteUser(USERID);
		fbDto.setvSearchType(searchGb);
		fbDto.setvSearch(searchtxt);
		fbDto.setnRow(20);
		fbDto.setnPage(curPageCnt);
		ListDTO ld = fbDao.BoardPageList(fbDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("freeBoardPageList");
	}
	
	
	
	
	
	/**
	 * 자유게시판 덧글 상세정보
	 * 
	 */
	public ActionForward freeBoardReplyIframe(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;
		int retVal = 0;
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String moreC = StringUtil.nvl(request.getParameter("moreC"),"N");
		String moreCC = StringUtil.nvl(request.getParameter("moreCC"),"N");
		int Seq = StringUtil.nvl(request.getParameter("Seq"), 1);
		int SeqRep = StringUtil.nvl(request.getParameter("SeqRep"), 1);
		int SeqBoard = StringUtil.nvl(request.getParameter("SeqBoard"), 1);
		int ReplyCount = StringUtil.nvl(request.getParameter("ReplyCount"), 1);
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		
		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		 
		FreeBoardDAO fbDao = new FreeBoardDAO();
		FreeBoardDTO fbDto = new FreeBoardDTO();
		//UserMemDTO useridd = new UserMemDTO();
		fbDto.setSeq(Seq);
		fbDto.setSeqRep(SeqRep);
		//System.out.println("SeqRep:::::SET:::"+SeqRep);
		//fbDto.setSeqBoard(SeqBoard);//fbDto 안에 들어있는 게시글 SEQ값을 가져와야 그 게시글(SEQ)에 대한 댓글(SEQBOARD)확인 후 리스트를 가져올수 있다.
		//System.out.println("SEqBoard::::ViewSET11::::"+fbDto.getSeqBoard());
		fbDto = fbDao.BoardView(fbDto);
		//System.out.println("SEqBoard::::ViewSET22::::"+SeqBoard);//View 상세보기에서 데이타값 SELECT해오는지 확인하는 로그.
		
		
		
	
		
	

				
				//자유게시판 덧글리스트 
				//fbDto.setRepWriteUser(USERID);
				System.out.println("댓글리스트::액션::set:세션체크::"+USERID);
				fbDto.setSeqRep(fbDto.getSeqRep());
				System.out.println("SeqRep::Set::LIST::"+fbDto.getSeqRep());
				fbDto.setSeqBoard(fbDto.getSeqBoard()); //fbDto에있는  SeqBoard 를 가져온다
				//System.out.println("SeqBoard:::set:::LIST::"+fbDto.getSeqBoard());
				//fbDto.setSeq(Seq);
				// 리스트
				//fbDto.setRepWriteUser(USERID);
				fbDto.setnRow(5); //초기에 5개지정해준게이놈이고
				
				fbDto.setnPage(curPageCnt);
				ListDTO ld = fbDao.BoardPageListRep(fbDto);
				
				model.put("listInfo", ld);   //자유게시판 댓글 리스트

		
				
		model.put("moreC", moreC);
		model.put("moreCC", moreCC);
		model.put("fbDto", fbDto);
		model.put("curPage", String.valueOf(curPageCnt));
		//model.put("useridd", useridd);
		if (fbDto == null) {
			String msg = "덧글  정보가 없습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_FreeBoard.do?cmd=freeBoardPageList&curPage=" + curPageCnt 
					, "back");
		} else {
			return actionMapping.findForward("freeBoardReplyIframe");
		}
	}
	
	/**
	 * 자유게시판 상세정보
	 * 
	 */
	public ActionForward freeBoardView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;
		int retVal = 0;
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		int Seq = StringUtil.nvl(request.getParameter("Seq"), 1);
		int SeqRep = StringUtil.nvl(request.getParameter("SeqRep"), 1);
		int SeqBoard = StringUtil.nvl(request.getParameter("SeqBoard"), 1);
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		
		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		 
		FreeBoardDAO fbDao = new FreeBoardDAO();
		FreeBoardDTO fbDto = new FreeBoardDTO();
		//UserMemDTO useridd = new UserMemDTO();
		fbDto.setSeq(Seq);
		fbDto.setSeqRep(SeqRep);
		//System.out.println("SeqRep:::::SET:::"+SeqRep);
		//fbDto.setSeqBoard(SeqBoard);//fbDto 안에 들어있는 게시글 SEQ값을 가져와야 그 게시글(SEQ)에 대한 댓글(SEQBOARD)확인 후 리스트를 가져올수 있다.
		//System.out.println("SEqBoard::::ViewSET11::::"+fbDto.getSeqBoard());
		fbDto = fbDao.BoardView(fbDto);
		//System.out.println("SEqBoard::::ViewSET22::::"+SeqBoard);//View 상세보기에서 데이타값 SELECT해오는지 확인하는 로그.
		
		
		
		if(fbDto != null){
			
			
			// 프로시저사용안할시 java단에서 처리할때..
			// int hit = disDto.getReadCount();
			// hit += +1;
			// disDto.setReadCount(disDto.getReadCount()+1);	
				//System.out.println(ReadCount+=hit);
				
				
			fbDto.setReadCount(fbDto.getReadCount());
				retVal = fbDao.freeBoardCount(fbDto);
				System.out.println("readcount1:"+fbDto.getReadCount());
			}
				
				//자유게시판
				//fbDto.setRepWriteUser(USERID);
				System.out.println("댓글리스트::액션::set:세션체크::"+USERID);
				fbDto.setSeqRep(fbDto.getSeqRep());
				System.out.println("SeqRep::Set::LIST::"+fbDto.getSeqRep());
				fbDto.setSeqBoard(fbDto.getSeqBoard()); //fbDto에있는  SeqBoard 를 가져온다
				System.out.println("SeqBoard:::set:::LIST::"+fbDto.getSeqBoard());
				//fbDto.setSeq(Seq);
				// 리스트
				//fbDto.setRepWriteUser(USERID);
				fbDto.setnRow(5);  
				
				fbDto.setnPage(curPageCnt);
				ListDTO ld = fbDao.BoardPageListRep(fbDto);
				ListDTO ld2 = fbDao.BoardPageListRep(fbDto);
				//
				//System.out.println(fbDto.getSeqBoard());
				
				model.put("listInfo", ld);   //자유게시판 댓글 리스트
				model.put("listInfo2", ld2);
				
				
		model.put("fbDto", fbDto);
		model.put("curPage", String.valueOf(curPageCnt));
		//model.put("useridd", useridd);
		if (fbDto == null) {
			String msg = "게시글  정보가 없습니다.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_FreeBoard.do?cmd=freeBoardPageList&curPage=" + curPageCnt
					, "back");
		} else {
			return actionMapping.findForward("freeBoardView");
		}
	}
	
	
	

	/**
	 * 자유게시판 수정
	 *
	 * 	 
	 */
	public ActionForward freeBoardEdit(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "freeboard/"
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

		String BoardFile = "";

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
			BoardFile = StringUtil.nvl(
					multipartRequest.getParameter("p_BoardFile"), "");//p_BoardFile Web(기존데이터)에서받고  BoardFile DB로담아준다.
			//BoardFile Request.getparameter 넘겨주는이유 수정시 파일은 수정하지않았을경우 가지고있는파일 유지를위해서 
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

					if (objName.equals("BoardFile")) {
						BoardFile = uploadFilePath;
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
		String BoardFileNm = StringUtil.nvl(
				multipartRequest.getParameter("BoardFileNm"), "");
		log.debug("파일이름"+BoardFileNm);
		
		FreeBoardDAO fbDao = new FreeBoardDAO();
		FreeBoardDTO fbDto = new FreeBoardDTO();

		fbDto.setSeq(Seq);
		fbDto.setWriteUser(USERID);
		log.debug("사용자"+USERID);
		fbDto.setBoardFile(BoardFile);
		log.debug("파일경로"+BoardFile);
		fbDto.setBoardFileNm(BoardFileNm);
		log.debug("파일이름"+BoardFileNm);
		fbDto.setTitle(Title);
		log.debug("제목"+Title);
		fbDto.setContents(Contents);
		log.debug("내용"+Contents);
		
		retVal = fbDao.BoardUpdate(fbDto);
		
		msg = "게시글 정보가 수정되었습니다";
		if (retVal < 1)
			msg = "게시글 정보 수정이 실패하였습니다";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_FreeBoard.do?cmd=freeBoardPageList&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
	}

	/**
	 * 자유게시판 = > 삭제
	 */
	public ActionForward freeBoardDelete(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "freeboard/"
		+ DateTimeUtil.getDate() + "/";
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				30);
		MultipartRequest multipartRequest = null;
		multipartRequest = uploadEntity.getMultipart();


		
		String msg = "";
		int retVal = 0;
		int Seq = StringUtil.nvl(multipartRequest.getParameter("Seq"), 1);
		
		FreeBoardDAO fbDao = new FreeBoardDAO();
		FreeBoardDTO fbDto = new FreeBoardDTO();

		fbDto.setSeq(Seq);
		retVal = fbDao.deleteBoardOne(fbDto);
		
		msg = "삭제에  성공하였습니다";
		if (retVal < 1)
			msg = "삭제에 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_FreeBoard.do?cmd=freeBoardPageList" , "back");
	}

	/**
	 * 자유게시판 = > 덧글삭제
	 */
	public ActionForward freeBoardDeleteRep(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "freeboard/"
		+ DateTimeUtil.getDate() + "/";
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				30);
		MultipartRequest multipartRequest = null;
		multipartRequest = uploadEntity.getMultipart();


		
		String msg = "";
		int retVal = 0;
		int Seq = StringUtil.nvl(multipartRequest.getParameter("Seq"), 1);
		int SeqRep = StringUtil.nvl(multipartRequest.getParameter("SeqRep"), 1);
		int SeqBoard = StringUtil.nvl(multipartRequest.getParameter("SeqBoard"), 1);
		System.out.println("page::"+SeqBoard);
		FreeBoardDAO fbDao = new FreeBoardDAO();
		FreeBoardDTO fbDto = new FreeBoardDTO();

		fbDto.setSeqRep(SeqRep);
		System.out.println("덧글시퀀스::"+SeqRep);
		retVal = fbDao.deleteBoardOneRep(fbDto);

		msg = "삭제에  성공하였습니다";
		if (retVal < 1)
			msg = "삭제에 실패하였습니다";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_FreeBoard.do?cmd=freeBoardReplyIframe&Seq="+Seq, "back");
	}
	
}
