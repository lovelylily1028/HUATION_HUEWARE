package com.huation.hueware.formfile.action;

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
import com.huation.common.formfile.FormFileDTO;
import com.huation.common.formfile.FormFileDAO;

public class FormFileAction extends StrutsDispatchAction {

	/**
	 * �Խ���->�������� �����
	 *
	 */
	public ActionForward formFileRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
 
		log.debug("�������� ���");

		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String sForm = StringUtil.nvl(request.getParameter("sForm"), "N");

		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}
		// �α��� ó�� ��.
		
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("sForm", sForm);
		return actionMapping.findForward("formFileRegistForm");
	}

	/**
	 * �������� ���ó��
	 *
	 * 	 
	 */
	
	public ActionForward formFileRegist(ActionMapping actionMapping,
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

		int retVal = 0;
		String msg = "";

		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "formfile/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				500);   //500M
		//UploadFiles (,,,500)500�ǹ� MB�뷮 ��������
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String FormFile = "";

		if (status.equals("E")) {
			log.debug("÷�� ���� �ø����� �����Ͽ����ϴ�.");
			msg = "÷�� ���� �ø����� �����Ͽ����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("O")) {
			log.debug("÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.");
			msg = "÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.�ִ� 500M ���� �����մϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("I")) {
			log.debug("÷�� ������ ������ �߸��Ǿ����ϴ�.");
			msg = "÷�� ������ ������ �߸��Ǿ����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("S")) {
			// ���ε�� ������ ������ �����ͼ� ������ ���̽��� �ִ� �۾��� ���ش�.
			log.debug("÷�� ������ ÷���ϴµ� �����Ͽ����ϴ�.");
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

					log.debug("���� ������Ʈ��[" + objName + "]�����ϸ�[" + rFileName
							+ "]�������ϸ�[" + sFileName + "]���ϻ�����[" + fileSize
							+ "]���������н�[" + filePath + "]���ε� ���["
							+ uploadFilePath + "]");

					if (objName.equals("FormFile")) {
						FormFile = uploadFilePath;
					}
				}
			}
		}

		
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		String WriteFormUser = StringUtil.nvl(
				multipartRequest.getParameter("WriteFormUser"), "");
		String FormGroup = StringUtil.nvl(
				multipartRequest.getParameter("FormGroup"), "");
		String Title = StringUtil.nvl(
				multipartRequest.getParameter("Title"), "");
		//log.debug("����"+Title);
		String Contents = StringUtil.nvl(
				multipartRequest.getParameter("Contents"), "");
		//log.debug("����"+Contents);
		String FormFileNm = StringUtil.nvl(
				multipartRequest.getParameter("FormFileNm"), "");
		//log.debug("�����̸�"+NotifyFileNm);
		
		FormFileDAO ffDao = new FormFileDAO();
		FormFileDTO ffDto = new FormFileDTO();

		ffDto.setWriteUser(USERID);
		ffDto.setWriteFormUser(WriteFormUser);
		ffDto.setFormGroup(FormGroup);
		//log.debug("�����"+USERID);
		ffDto.setFormFile(FormFile);
		//log.debug("���ϰ��"+NotifyFile);
		ffDto.setFormFileNm(FormFileNm);
		//log.debug("�����̸�"+NotifyFileNm);
		ffDto.setTitle(Title);
		//log.debug("����"+Title);
		ffDto.setContents(Contents);
		//log.debug("����"+Contents);
		
		retVal = ffDao.addFormFileRegist(ffDto);

		 msg = "�������� ��Ͽ� �����Ͽ����ϴ�";
	        if(retVal < 1) msg = "�������� ��Ͽ� �����Ͽ����ϴ�";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_FormFile.do?cmd=formFilePageList&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
	}

	/**
	 * �Խ���-> �������� ����Ʈ
	 * 
	 *
	 */
	public ActionForward formFilePageList(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);

		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
	
		FormFileDAO ffDao = new FormFileDAO();
		FormFileDTO ffDto = new FormFileDTO();

		// ����Ʈ
		
		//ffDto.setWriteUser(USERID);
		ffDto.setvSearchType(searchGb);
		ffDto.setvSearch(searchtxt);
		ffDto.setnRow(20);
		ffDto.setnPage(curPageCnt);
		ListDTO ld = ffDao.formFilePageList(ffDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("formFilePageList");
	}
	
	

	/**
	 * �Խ���-> �������� ����Ʈ
	 * 
	 *
	 */
	public ActionForward formFilePageList2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);

		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
		  
		  MultipartRequest multipartRequest = null;
		  
		  String FilePath = FileUtil.FILE_DIR + "dispnotify/"
					+ DateTimeUtil.getDate() + "/";
			log.debug("FilePath= " + FilePath);
			UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
					500);	//500M
			//UploadFiles (,,,500)500�ǹ� MB�뷮 ��������
			multipartRequest = uploadEntity.getMultipart();
		  
		  

		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil.nvl(multipartRequest.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);
	
		FormFileDAO ffDao = new FormFileDAO();
		FormFileDTO ffDto = new FormFileDTO();

		// ����Ʈ
		
		//ffDto.setWriteUser(USERID);
		ffDto.setvSearchType(searchGb);
		ffDto.setvSearch(searchtxt);
		ffDto.setnRow(20);
		ffDto.setnPage(curPageCnt);
		ListDTO ld = ffDao.formFilePageList(ffDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("formFilePageList");
	}

	/**
	 * �������� ������
	 * 
	 */
	
	public ActionForward formfileView(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		int curPageCnt = 0;
		int retVal = 0;
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		int Seq = StringUtil.nvl(request.getParameter("Seq"), 1);
		
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		
		
		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
		 
		FormFileDAO ffDao = new FormFileDAO();
		FormFileDTO ffDto = new FormFileDTO();
		//UserMemDTO useridd = new UserMemDTO();
		ffDto.setSeq(Seq);
		ffDto = ffDao.formfileView(ffDto);
	
		if(ffDto != null){
			
			
			// ���ν��������ҽ� java�ܿ��� ó���Ҷ�..
			// int hit = disDto.getReadCount();
			// hit += +1;
			// disDto.setReadCount(disDto.getReadCount()+1);	
				//System.out.println(ReadCount+=hit);
				
				
			ffDto.setReadCount(ffDto.getReadCount());
				retVal = ffDao.formFileCount(ffDto);
				System.out.println("readcount1:"+ffDto.getReadCount());
			}

		model.put("ffDto", ffDto);
		model.put("curPage", String.valueOf(curPageCnt));
		//model.put("useridd", useridd);
		if (ffDto == null) {
			String msg = "��������  ������ �����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_FormFile.do?cmd=formFilePageList&curPage=" + curPageCnt
					, "back");
		} else {
			return actionMapping.findForward("formfileView");
		}
	}
	
	/**
	 * �������� ����
	 *
	 * 	 
	 */
	
	public ActionForward formFileEdit(ActionMapping actionMapping,
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

		int retVal = 0;
		String msg = "";

		MultipartRequest multipartRequest = null;

		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR + "dispnotify/"
						+ DateTimeUtil.getDate() + "/";
		String uploadFilePath = "";
		log.debug("FilePath= " + FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				500);	//500M
		//UploadFiles (,,,500)500�ǹ� MB�뷮 ��������
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String FormFile = "";

		if (status.equals("E")) {
			log.debug("÷�� ���� �ø����� �����Ͽ����ϴ�.");
			msg = "÷�� ���� �ø����� �����Ͽ����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("O")) {
			log.debug("÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.");
			msg = "÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.�ִ� 500M ���� �����մϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("I")) {
			log.debug("÷�� ������ ������ �߸��Ǿ����ϴ�.");
			msg = "÷�� ������ ������ �߸��Ǿ����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/jsp/hueware/common/error.jsp", "back");

		} else if (status.equals("S")) {
			// ���ε�� ������ ������ �����ͼ� ������ ���̽��� �ִ� �۾��� ���ش�.
			FormFile = StringUtil.nvl(
					multipartRequest.getParameter("p_FormFile"), "");//p_FormFile Web(����������)�����ް�  FormFile DB�δ���ش�.
			//FormFile Request.getparameter �Ѱ��ִ����� ������ ������ ���������ʾ������ �������ִ����� ���������ؼ� 
			log.debug("÷�� ������ ÷���ϴµ� �����Ͽ����ϴ�.");
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

					log.debug("���� ������Ʈ��[" + objName + "]�����ϸ�[" + rFileName
							+ "]�������ϸ�[" + sFileName + "]���ϻ�����[" + fileSize
							+ "]���������н�[" + filePath + "]���ε� ���["
							+ uploadFilePath + "]");

					if (objName.equals("FormFile")) {
						FormFile = uploadFilePath;
					}
				}
			}
		}

		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		//������ pk�� ���� Update ����ߵ�.
		int Seq = StringUtil.nvl(multipartRequest.getParameter("Seq"), 1);
		String WriteFormUser = StringUtil.nvl(
				multipartRequest.getParameter("WriteFormUser"), "");
		String FormGroup = StringUtil.nvl(
				multipartRequest.getParameter("FormGroup"), "");
		String Title = StringUtil.nvl(
				multipartRequest.getParameter("Title"), "");
		//log.debug("����"+Title);
		String Contents = StringUtil.nvl(
				multipartRequest.getParameter("Contents"), "");
		//log.debug("����"+Contents);
		String FormFileNm = StringUtil.nvl(
				multipartRequest.getParameter("FormFileNm"), "");
		String UpdateUser = StringUtil.nvl(multipartRequest.getParameter("UpdateUser"));
		FormFileDAO ffDao = new FormFileDAO();
		FormFileDTO ffDto = new FormFileDTO();

		ffDto.setSeq(Seq);
		ffDto.setWriteFormUser(WriteFormUser);
		ffDto.setFormGroup(FormGroup);
		//log.debug("�����"+USERID);
		ffDto.setFormFile(FormFile);
		//log.debug("���ϰ��"+NotifyFile);
		ffDto.setFormFileNm(FormFileNm);
		//log.debug("�����̸�"+NotifyFileNm);
		ffDto.setTitle(Title);
		//log.debug("����"+Title);
		ffDto.setContents(Contents);
		ffDto.setUpdateUser(UpdateUser);
		log.debug("UpdateUser::"+UpdateUser);
		retVal = ffDao.FormFileUpdate(ffDto);
		
		msg = "�������� ������ �����Ǿ����ϴ�";
		if (retVal < 1)
			msg = "�������� ���� ������ �����Ͽ����ϴ�";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_FormFile.do?cmd=formFilePageList&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
	}
	/**
	 * �������� = > ����
	 */
	
	public ActionForward formFileDelete(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String USERID = UserBroker.getUserId(request);
		if (USERID.equals("")) {
			String rtnUrl = request.getContextPath()
					+ "/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl, "huation-sessionOut");
		}

		/*
		 * �����ÿ��� multipartrequest�� ��û ���� �ؾߵȴ�.
		 */
		String FilePath = FileUtil.FILE_DIR + "formfile/"
		+ DateTimeUtil.getDate() + "/";
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				20);
		MultipartRequest multipartRequest = null;
		multipartRequest = uploadEntity.getMultipart();


		
		String msg = "";
		int retVal = 0;
		int Seq = StringUtil.nvl(multipartRequest.getParameter("Seq"), 1);
		String DeletedUser = StringUtil.nvl(multipartRequest.getParameter("DeletedUser"),"");
		FormFileDAO ffDao = new FormFileDAO();
		FormFileDTO ffDto = new FormFileDTO();

		ffDto.setSeq(Seq);
		ffDto.setDeletedUser(DeletedUser);
		log.debug("DeletedUser::"+DeletedUser);
		retVal = ffDao.deleteFormFileOne(ffDto);

		msg = "������  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "������ �����Ͽ����ϴ�";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_FormFile.do?cmd=formFilePageList" , "back");
	}
	 
}
