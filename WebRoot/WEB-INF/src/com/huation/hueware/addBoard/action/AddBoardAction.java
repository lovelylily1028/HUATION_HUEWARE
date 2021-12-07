package com.huation.hueware.addBoard.action;

import java.text.Normalizer;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huation.common.addBoard.AddBoardDAO;
import com.huation.common.addBoard.AddBoardDTO;
import com.huation.common.freeboard.FreeBoardDAO;
import com.huation.common.freeboard.FreeBoardDTO;
import com.huation.common.user.UserBroker;
import com.huation.framework.data.DataSet;
import com.huation.framework.persist.DAOException;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.struts.StrutsDispatchAction;
import com.huation.framework.util.DateTimeUtil;
import com.huation.framework.util.FileUtil;
import com.huation.framework.util.StringUtil;
import com.huation.framework.util.UploadFile;
import com.huation.framework.util.UploadFiles;
import com.oreilly.servlet.MultipartRequest;

public class AddBoardAction extends StrutsDispatchAction{


	/**
	 * 게시판 -> 추가게시판 리스트
	 * 
	 *
	 */
	 public ActionForward addBoardList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception{
		 
		 
		 //로그인처리
		 String USERID = UserBroker.getUserId(request);
		 
	 	  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
		 
		 AddBoardDAO abDao = new AddBoardDAO();
		 AddBoardDTO abDto = new AddBoardDTO();
		 
		 
		 //리스트
		 int pageNo = StringUtil.nvl(request.getParameter("curPage"), 1);
		 String category = StringUtil.nvl(request.getParameter("category"), "");
		 
		 //검색기능 사용시 pageNo는 무조건 1
		 if(category.equals("title")) {
			 pageNo = 1;
		 }
		 String searchWord = StringUtil.nvl(request.getParameter("searchWord"), "");
		 
		 abDto.setWriteUser(USERID);
		 abDto.setnRow(10); //1페이지당 게시글 10개씩 출력
		 abDto.setPageNo(pageNo);
		 
		 
		 ListDTO ld = abDao.selectAddBoardList(abDto, category, searchWord);  
		 int pageCnt = abDao.selectAddBoardListAllCnt(abDto, category, searchWord);  //총 게시물 수 - 페이징에 사용
		 
		 
		 model.put("listInfo", ld);
		 model.put("curPage", String.valueOf(pageNo));
		 model.put("pageCnt", String.valueOf(pageCnt));
		 model.put("category", category);
		 model.put("searchWord", searchWord);
		 
		return actionMapping.findForward("addBoardList");
	}
	 
	 
	 
	 
	 
	 /**
	 * 게시판 -> 쓰기 등록폼
	 * 
	 *
	 */
	 public ActionForward addBoardRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) {
		 
		 log.debug("추가게시판 등록폼");
		 return actionMapping.findForward("addBoardRegistForm");
	 }
	 
	 
	 
	 /**
	 * 게시판 -> 쓰기 처리
	 * @throws Exception 
	 * 
	 *
	 */
	 public ActionForward addBoardRegist(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "addBoard/"
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
		String BoardFileNm = "";

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
					BoardFile = uploadFilePath;  //저장경로
					rFileName = Normalizer.normalize(rFileName, Normalizer.Form.NFC);  //맥OS에서 업로드한 파일, 자모분리현상 해결
					BoardFileNm = rFileName;  //원본파일명
					
						
					if (objName.equals("BoardFile")) {
						BoardFile = uploadFilePath;
					}
				}
			}
		}

		
		curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);
//		String BoardFileNm = StringUtil.nvl(multipartRequest.getParameter("BoardFileNm"), "");
//		log.debug("파일이름"+BoardFileNm);
		String Title = StringUtil.nvl(multipartRequest.getParameter("title"), "");
		String Contents = StringUtil.nvl(multipartRequest.getParameter("contents"), "");
		log.debug("내용"+Contents.length());
		

		AddBoardDAO abDao = new AddBoardDAO();
		AddBoardDTO abDto = new AddBoardDTO();
		
		
		abDto.setWriteUser(USERID);
		//log.debug("사용자"+USERID);
		//abDto.setBoardFile(BoardFile);
		//abDto.setBoardFileNm(BoardFileNm);
		//log.debug("파일경로"+BoardFile);
		//log.debug("파일이름"+BoardFileNm);
		abDto.setTitle(Title);
		//log.debug("제목"+Title);
		abDto.setContents(Contents);
		//log.debug("내용"+Contents);
		
		retVal = abDao.insertAddBoardRegist(abDto, BoardFile, BoardFileNm);

		 msg = "게시글 등록에 성공하였습니다";
	        if(retVal < 1) msg = "게시글 등록에 실패하였습니다";
	        
		 return alertAndExit(model, msg, request.getContextPath()+"/B_AddBoard.do?cmd=addBoardList", "back");
	 }
	 
	 

	 
	 /**
	 * 게시판 -> 상세페이지
	 * @throws Exception 
	 * 
	 *
	 */
	 public ActionForward addBoardView(ActionMapping actionMapping,
				ActionForm actionForm, HttpServletRequest request,
				HttpServletResponse response, Map model) throws Exception {
		 
		 
		 //넘어온 변수 처리
		 int addBoardSeq = Integer.parseInt(request.getParameter("addBoardSeq"));
		 int pageNo = StringUtil.nvl(request.getParameter("curPage"), 1);
		 String category = StringUtil.nvl(request.getParameter("category"), "");
		 String searchWord = StringUtil.nvl(request.getParameter("searchWord"), "");
		 int comPageNo = StringUtil.nvl(request.getParameter("comPageNo"), 1);
		 int comPageSize = 5;  //1페이지당 댓글 5개씩 출력
		 
		 // 로그인 처리
		 String USERID = UserBroker.getUserId(request);
		 if (USERID.equals("")) {
			String rtnUrl = request.getContextPath() + "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		 }// 로그인 처리 끝.
		 
		 
		 AddBoardDAO abDao = new AddBoardDAO();
		 AddBoardDTO abDto = new AddBoardDTO();
		 Map<String, Object> map = new HashedMap();
		 
		 
		 //조회수 1 증가처리
		 abDao.updateAddBoardReadCnt(addBoardSeq);
		 
		 
		 //게시글 상세내용
		 map = abDao.selectAddBoardDetail(addBoardSeq, USERID);
		 abDto = (AddBoardDTO) map.get("abDto");
		 String boardFile = (String) map.get("boardFile");
		 String boardFileNm = (String) map.get("boardFileNm");
		 
		 
		 //댓글 리스트
		 ListDTO ld = abDao.selectAddBoardComDetail(addBoardSeq, USERID, comPageNo, comPageSize);
		 
		 //댓글 총 개수
		 int comCnt = abDao.selectAddBoardComCnt(addBoardSeq);
		 
		 //댓글 페이징 개수
		 int comPageCnt = 0;
		 int remain = (int) (comCnt % comPageSize);
		 if(remain == 0) {
			 comPageCnt = (int) (comCnt/comPageSize);
		 }else {
			 comPageCnt = (int) (comCnt/comPageSize) + 1;
		 }
		 
		 
		 model.put("abDto", abDto);
		 model.put("boardFile", boardFile);
		 model.put("boardFileNm", boardFileNm);
		 model.put("pageNo", String.valueOf(pageNo));
		 model.put("category", category);
		 model.put("searchWord", searchWord);
		 model.put("comListInfo", ld);
		 model.put("comCnt", String.valueOf(comCnt));  //총 댓글 개수
		 model.put("comPageCnt", String.valueOf(comPageCnt)); //총 댓글 페이징 갯수
		 model.put("comPageNo", String.valueOf(comPageNo));  //현재 댓글 페이지
		 
		 return actionMapping.findForward("addBoardView");
	 }
	 
	 
	 
	 
	 
	 /**
	 * 게시판 -> 삭제하기
	 * @throws Exception 
	 * 
	 *
	 */
	 public ActionForward addBoardDelete(ActionMapping actionMapping,
				ActionForm actionForm, HttpServletRequest request,
				HttpServletResponse response, Map model) throws Exception {
		 
		 //변수선언
		 String msg = "";
		 int retVal = 0;
		 
		 
		 // 로그인 처리
		 String USERID = UserBroker.getUserId(request);
		 if (USERID.equals("")) {
		 	 String rtnUrl = request.getContextPath() + "/B_Login.do?cmd=loginForm";
			 return goSessionOut(model, rtnUrl, "huation-sessionOut");
		 }// 로그인 처리 끝.
		 
		 
		 //넘어온 변수 처리하기
		 int addBoardSeq = StringUtil.nvl(request.getParameter("addBoardSeq"), 1);
		 int curPage = StringUtil.nvl(request.getParameter("curPage"), 1);
		
		 
		 AddBoardDAO abDao = new AddBoardDAO();

		 retVal = abDao.deleteAddBoardOne(addBoardSeq);
		 msg = "삭제에  성공하였습니다";
			if (retVal < 1)
				msg = "삭제에 실패하였습니다";
		 
		 return alertAndExit(model, msg, request.getContextPath()+"/B_AddBoard.do?cmd=addBoardList&curPage="+curPage, "back");
	 }
	 
	 
	 
	 
	 
	 
	 
	 /**
	 * 게시판 -> 수정하기
	 * 
	 *
	 */
	 public ActionForward addBoardModify (ActionMapping actionMapping,
				ActionForm actionForm, HttpServletRequest request,
				HttpServletResponse response, Map model) throws Exception{
		 
		 
		 // 로그인 처리
		 String USERID = UserBroker.getUserId(request);
		 if (USERID.equals("")) {
			 String rtnUrl = request.getContextPath() + "/B_Login.do?cmd=loginForm";
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
		 String FilePath = FileUtil.FILE_DIR + "addBoard/" + DateTimeUtil.getDate() + "/";
		 String uploadFilePath = "";
		 log.debug("FilePath= " + FilePath);
		 UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID, 500);	//500M
		 //UploadFiles (,,,500)500의미 MB용량 단위설정
		 multipartRequest = uploadEntity.getMultipart();
		 String status = uploadEntity.getStatus();

		 int curPageCnt = 0;
		 String searchGb = "";
		 String searchtxt = "";
		 String sForm = "N";

		 String BoardFile = "";
		 String BoardFileNm = "";
		 
		 
		 if (status.equals("E")) {
			 log.debug("첨부 파일 올리려다 실패하였습니다.");
			 msg = "첨부 파일 올리려다 실패하였습니다.";
			 return alertAndExit(model, msg, request.getContextPath() + "/jsp/hueware/common/error.jsp", "back");

		 } else if (status.equals("O")) {
			 log.debug("첨부하신 파일이 용량을 초과했습니다.");
			 msg = "첨부하신 파일이 용량을 초과했습니다.최대 500M 까지 가능합니다.";
			 return alertAndExit(model, msg, request.getContextPath() + "/jsp/hueware/common/error.jsp", "back");

		 } else if (status.equals("I")) {
			 log.debug("첨부 파일의 정보가 잘못되었습니다.");
			 msg = "첨부 파일의 정보가 잘못되었습니다.";
			 return alertAndExit(model, msg, request.getContextPath() + "/jsp/hueware/common/error.jsp", "back");

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
					 log.debug("++++++++++++++++ FileName = " + file.getRootName());
					 log.debug("++++++++++++++++ path = " + uploadEntity.getUploadPath());

					 sFileName = file.getUploadName();
					 fileSize = String.valueOf(file.getSize());
					 filePath = uploadEntity.getUploadPath();
					 uploadFilePath = filePath + sFileName;

					 log.debug("파일 오브젝트명[" + objName + "]원파일명[" + rFileName
							 + "]저장파일명[" + sFileName + "]파일사이즈[" + fileSize
							 + "]저장파일패스[" + filePath + "]업로드 경로["
							 + uploadFilePath + "]");
					 BoardFile = uploadFilePath;  //저장경로
					 BoardFileNm = rFileName;  //원본파일명
						
					 if (objName.equals("BoardFile")) {
						 BoardFile = uploadFilePath;
					 }
				 }
			 }
		 }

		 
		 
		 curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);
//		 String BoardFileNm = StringUtil.nvl(multipartRequest.getParameter("BoardFileNm"), "");
//		 log.debug("파일이름"+BoardFileNm);
		 String Title = StringUtil.nvl(multipartRequest.getParameter("title"), "");
		 String Contents = StringUtil.nvl(multipartRequest.getParameter("contents"), "");
		 int addBoardSeq = StringUtil.nvl(multipartRequest.getParameter("addBoardSeq"), 1);
		 log.debug("내용"+Contents.length());
		 
		 
		 //첨부파일을 변경하지 않은 경우 저장경로, 파일명 처리
		 BoardFile = StringUtil.nvl(BoardFile, "");
		 BoardFileNm = StringUtil.nvl(BoardFileNm, "");

		 AddBoardDAO abDao = new AddBoardDAO();
		 AddBoardDTO abDto = new AddBoardDTO();
		
		
		 abDto.setWriteUser(USERID);
		 //log.debug("사용자"+USERID);
		 //abDto.setBoardFile(BoardFile);
		 //abDto.setBoardFileNm(BoardFileNm);
		 //log.debug("파일경로"+BoardFile);
		 //log.debug("파일이름"+BoardFileNm);
		 abDto.setTitle(Title);
		 //log.debug("제목"+Title);
		 abDto.setContents(Contents);
		 //log.debug("내용"+Contents);
		 abDto.setAddBoardSeq(addBoardSeq);
		
		 retVal = abDao.updateAddBoardModify(abDto, BoardFile, BoardFileNm);

		 msg = "게시글 수정에 성공하였습니다";
	         if(retVal < 1) msg = "게시글 수정에 실패하였습니다";

	     return alertAndExit(model, msg, request.getContextPath()+"/B_AddBoard.do?cmd=addBoardList", "back");

	 }
	 
	 
		/*
		 * 
		 * 댓글 -> 쓰기 등록
		 * 
		 */
	 	public ActionForward addBoardComRegist(ActionMapping actionMapping,
				ActionForm actionForm, HttpServletRequest request,
				HttpServletResponse response, Map model) throws Exception{
	 		
	 		
	 		//변수선언
	 		int retVal = 0;
			String msg = "";

	 		
		 	// 로그인 처리
			String USERID = UserBroker.getUserId(request);
			if (USERID.equals("")) {
				String rtnUrl = request.getContextPath()
						+ "/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl, "huation-sessionOut");
			}
			// 로그인 처리 끝.
			
			
			//넘어온 변수 처리하기
			int curPage = StringUtil.nvl(request.getParameter("curPage"), 1);
			int addBoardSeq = StringUtil.nvl(request.getParameter("addBoardSeq"), 1);
			String comWriteUser = StringUtil.nvl(request.getParameter("comWriteUser"), "");
			String comContents = StringUtil.nvl(request.getParameter("comContents"), "");
			
		 		
			AddBoardDAO abDao = new AddBoardDAO();
			AddBoardDTO abDto = new AddBoardDTO();
			
			abDto.setAddBoardSeq(addBoardSeq);
			abDto.setComWriteUser(comWriteUser);
			abDto.setComContents(comContents);
			
			retVal = abDao.insertAddBoardComRegist(abDto);
			
			msg = "댓글 등록에 성공하였습니다";
			if(retVal < 1) {
				msg = "댓글 등록에 실패하였습니다";
			}
		
	 		return alertAndExit(model, msg, request.getContextPath()+"/B_AddBoard.do?cmd=addBoardView&addBoardSeq="+addBoardSeq+"&curPage="+curPage, "back");
	 	}
	 
	 
	 	
	 	
	 	
	 	/*
		 * 
		 * 댓글 -> 수정하기
		 * 
		 */
	 	public ActionForward addBoardComModify(ActionMapping actionMapping,
				ActionForm actionForm, HttpServletRequest request,
				HttpServletResponse response, Map model) throws Exception{
	 		
	 		
	 		//변수선언
	 		int retVal = 0;
	 		String msg = "";
	 		
	 		
	 		// 로그인 처리
			String USERID = UserBroker.getUserId(request);
			if (USERID.equals("")) {
				String rtnUrl = request.getContextPath() + "/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl, "huation-sessionOut");
			}
			// 로그인 처리 끝.

	 		
			
			//넘어온 변수 처리하기
			int curPage = StringUtil.nvl(request.getParameter("curPage"), 1);
			int comSeq = StringUtil.nvl(request.getParameter("comSeq"), 1);
			int addBoardSeq = StringUtil.nvl(request.getParameter("addBoardSeq"), 1);
			String comWriteUser = StringUtil.nvl(request.getParameter("comWriteUser"), "");
			String comContentsModify = StringUtil.nvl(request.getParameter("comContentsModify"), "");
	 		
			
			AddBoardDAO abDao = new AddBoardDAO();
			AddBoardDTO abDto = new AddBoardDTO();

			abDto.setComSeq(comSeq);
			abDto.setAddBoardSeq(addBoardSeq);
			abDto.setComContents(comContentsModify);
			
			retVal = abDao.updateAddBoardComModify(abDto);
			
			msg = "댓글 수정이 완료되었습니다.";
			if(retVal < 1) {
				msg = "댓글 수정이 실패하였습니다.";
			}
	 		
			return alertAndExit(model, msg, request.getContextPath()+"/B_AddBoard.do?cmd=addBoardView&addBoardSeq="+addBoardSeq+"&curPage="+curPage, "back");
	 	}
	 	
	 	
	 	
	 	
	 	
	 	
	 	/*
		 * 
		 * 댓글 -> 삭제하기
		 * 
		 */
	 	public ActionForward addBoardComDelete(ActionMapping actionMapping,
				ActionForm actionForm, HttpServletRequest request,
				HttpServletResponse response, Map model) throws Exception{
	 		
	 		
	 		//변수선언
	 		int retVal = 0;
	 		String msg = "";

	 		
	 		// 로그인 처리
			String USERID = UserBroker.getUserId(request);
			if (USERID.equals("")) {
				String rtnUrl = request.getContextPath() + "/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl, "huation-sessionOut");
			}
			// 로그인 처리 끝.
			
			
			//넘어온 변수 처리하기
			int curPage = StringUtil.nvl(request.getParameter("curPage"), 1);
			int comSeq = StringUtil.nvl(request.getParameter("comSeq"), 1);
			int addBoardSeq = StringUtil.nvl(request.getParameter("addBoardSeq"), 1);
			String comWriteUser = StringUtil.nvl(request.getParameter("comWriteUser"), "");

			
			AddBoardDAO abDao = new AddBoardDAO();
			AddBoardDTO abDto = new AddBoardDTO();

	 		abDto.setComSeq(comSeq);
	 		abDto.setAddBoardSeq(addBoardSeq);
	 		abDto.setComWriteUser(comWriteUser);
	 		
	 		retVal = abDao.deleteAddBoardComOne(abDto);
	 		
	 		msg = "삭제되었습니다.";
	 		if(retVal < 1) {
	 			msg = "삭제에 실패하였습니다.";
	 		}
	 		
	 		
	 		return alertAndExit(model, msg, request.getContextPath()+"/B_AddBoard.do?cmd=addBoardView&addBoardSeq="+addBoardSeq+"&curPage="+curPage, "back");
	 	}
	 
	 

}//class
