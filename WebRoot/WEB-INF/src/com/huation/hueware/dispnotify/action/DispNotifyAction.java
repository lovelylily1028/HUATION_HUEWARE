package com.huation.hueware.dispnotify.action;

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
import com.huation.common.dispnotify.DispNotifyDTO;
import com.huation.common.dispnotify.DispNotifyDAO;

public class DispNotifyAction extends StrutsDispatchAction {

	/**
	 * �Խ���->������� �����
	 *
	 */
	public ActionForward dispNotifyRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		log.debug("����������");

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
		return actionMapping.findForward("dispNotifyRegistForm");
	}

	/**
	 * ������� ���ó��
	 *
	 * 	 
	 */
	public ActionForward dispNotifyRegist(ActionMapping actionMapping,
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
				500);   //1.5GB
		//UploadFiles (,,,500)500 MB�뷮 ��������
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String NotifyFile = "";

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

					if (objName.equals("NotifyFile")) {
						NotifyFile = uploadFilePath;
					}
				}
			}
		}

		
		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		String Title = StringUtil.nvl(
				multipartRequest.getParameter("Title"), "");
		log.debug("����"+Title);
		String Contents = StringUtil.nvl(
				multipartRequest.getParameter("Contents"), "");
		log.debug("����"+Contents);
		String NotifyFileNm = StringUtil.nvl(
				multipartRequest.getParameter("NotifyFileNm"), "");
		log.debug("�����̸�"+NotifyFileNm);
		
		DispNotifyDAO disDao = new DispNotifyDAO();
		DispNotifyDTO disDto = new DispNotifyDTO();

		disDto.setWriteUser(USERID);
		log.debug("�����"+USERID);
		disDto.setNotifyFile(NotifyFile);
		log.debug("���ϰ��"+NotifyFile);
		disDto.setNotifyFileNm(NotifyFileNm);
		log.debug("�����̸�"+NotifyFileNm);
		disDto.setTitle(Title);
		log.debug("����"+Title);
		disDto.setContents(Contents);
		log.debug("����"+Contents);
		
		retVal = disDao.addNotifyRegist(disDto);

		 msg = "������� ��Ͽ� �����Ͽ����ϴ�";
	        if(retVal < 1) msg = "������� ��Ͽ� �����Ͽ����ϴ�";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_DispNotify.do?cmd=dispNotifyPageList&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
	}


	/**
	 * �Խ���->������� ����Ʈ
	 * 
	 *
	 */
	public ActionForward dispNotifyPageList(ActionMapping actionMapping,
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
	
		DispNotifyDAO disDao = new DispNotifyDAO();
		DispNotifyDTO disDto = new DispNotifyDTO();

		// ����Ʈ
		
		disDto.setWriteUser(USERID);
		disDto.setvSearchType(searchGb);
		disDto.setvSearch(searchtxt);
		disDto.setnRow(20);
		disDto.setnPage(curPageCnt);
		ListDTO ld = disDao.dispNotifyPageList(disDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("dispNotifyPageList");
	}
	
	/**
	 * �Խ���->������� ����Ʈ
	 * 
	 *
	 */
	public ActionForward dispNotifyPageList2(ActionMapping actionMapping,
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
					500);   //500MB(�ִ�뷮)
			//UploadFiles (,,,500)500�ǹ� MB�뷮 ��������
			multipartRequest = uploadEntity.getMultipart();

		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(multipartRequest.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);
	
	
		DispNotifyDAO disDao = new DispNotifyDAO();
		DispNotifyDTO disDto = new DispNotifyDTO();

		// ����Ʈ
		
		disDto.setWriteUser(USERID);
		disDto.setvSearchType(searchGb);
		disDto.setvSearch(searchtxt);
		disDto.setnRow(20);
		disDto.setnPage(curPageCnt);
		ListDTO ld = disDao.dispNotifyPageList(disDto);

		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);

		return actionMapping.findForward("dispNotifyPageList");
	}

	/**
	 * ������� (����Ʈ)������
	 * 
	 */
	public ActionForward dispNotifyView(ActionMapping actionMapping,
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
		 
		DispNotifyDAO disDao = new DispNotifyDAO();
		DispNotifyDTO disDto = new DispNotifyDTO();
		//UserMemDTO useridd = new UserMemDTO();

		disDto.setSeq(Seq);
		disDto = disDao.dispNotifyView(disDto);
		
		//�Խ��� ��ȸ�� ������Ű��.
		//�󼼺��� ����Ʈ�� ReadCount(��ȸ���� �������µ��ÿ� Update�� ReadCount+1 ������Ų��.)
		//�̶� disDto�� ��ȸ���� �����͸� �������ٶ�
		//disDto.setReadCount(disDto.getReadCount()); disDto���ִ� ReadCount�����ͼ� �����Ѵ�.
		if(disDto != null){
			
			
		// ���ν��������ҽ� java�ܿ��� ó���Ҷ�..
		// int hit = disDto.getReadCount();
		// hit += +1;
		// disDto.setReadCount(disDto.getReadCount()+1);	
			//System.out.println(ReadCount+=hit);
			
			
			disDto.setReadCount(disDto.getReadCount());
			retVal = disDao.dispNotifyCount(disDto);
			System.out.println("readcount1:"+disDto.getReadCount());
		}
	
	

		model.put("disDto", disDto);
		model.put("curPage", String.valueOf(curPageCnt));
		//model.put("useridd", useridd);
		if (disDto == null) {
			String msg = "�������  ������ �����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_DispNotify.do?cmd=dispNotifyPageList&curPage=" + curPageCnt
					, "back");
		} else {
			return actionMapping.findForward("dispNotifyView");
		}
	}
	

	/**
	 * ������� ����
	 *
	 * 	 
	 */
	public ActionForward dispNotifyEdit(ActionMapping actionMapping,
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
				500);   //500MB(�ִ�뷮)
		//UploadFiles (,,,500)500�ǹ� MB�뷮 ��������
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String NotifyFile = "";

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
			NotifyFile = StringUtil.nvl(
					multipartRequest.getParameter("p_NotifyFile"), "");//p_BankBookFile Web(����������)�����ް�  BankBookFile DB�δ���ش�.
			//BankBookFile Request.getparameter �Ѱ��ִ����� ������ ������ ���������ʾ������ �������ִ����� ���������ؼ� 
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

					if (objName.equals("NotifyFile")) {
						NotifyFile = uploadFilePath;
					}
				}
			}
		}

		curPageCnt = StringUtil
				.nvl(multipartRequest.getParameter("curPage"), 1);
		//������ pk�� ���� Update ����ߵ�.
		int Seq = StringUtil.nvl(multipartRequest.getParameter("Seq"), 1);
		String Title = StringUtil.nvl(
				multipartRequest.getParameter("Title"), "");
		log.debug("����"+Title);
		String Contents = StringUtil.nvl(
				multipartRequest.getParameter("Contents"), "");
		log.debug("����"+Contents);
		String NotifyFileNm = StringUtil.nvl(
				multipartRequest.getParameter("NotifyFileNm"), "");
		log.debug("�����̸�"+NotifyFileNm);
		
		DispNotifyDAO disDao = new DispNotifyDAO();
		DispNotifyDTO disDto = new DispNotifyDTO();

		disDto.setSeq(Seq);
		disDto.setWriteUser(USERID);
		log.debug("�����"+USERID);
		disDto.setNotifyFile(NotifyFile);
		log.debug("���ϰ��"+NotifyFile);
		disDto.setNotifyFileNm(NotifyFileNm);
		log.debug("�����̸�"+NotifyFileNm);
		disDto.setTitle(Title);
		log.debug("����"+Title);
		disDto.setContents(Contents);
		log.debug("����"+Contents);
		
		retVal = disDao.NotifyUpdate(disDto);
		
		msg = "������� ������ �����Ǿ����ϴ�";
		if (retVal < 1)
			msg = "������� ���� ������ �����Ͽ����ϴ�";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_DispNotify.do?cmd=dispNotifyPageList&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
	}

	/**
	 * ������� = > ����
	 */
	public ActionForward dispNotifyDelete(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "dispnotify/"
		+ DateTimeUtil.getDate() + "/";
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
				30);
		MultipartRequest multipartRequest = null;
		multipartRequest = uploadEntity.getMultipart();


		
		String msg = "";
		int retVal = 0;
		int Seq = StringUtil.nvl(multipartRequest.getParameter("Seq"), 1);
		
		DispNotifyDAO disDao = new DispNotifyDAO();
		DispNotifyDTO disDto = new DispNotifyDTO();

		disDto.setSeq(Seq);
		retVal = disDao.deletedispNotifyOne(disDto);

		msg = "������  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "������ �����Ͽ����ϴ�";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_DispNotify.do?cmd=dispNotifyPageList" , "back");
	}

}
