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
	 * �Խ���->News_Magazine �����_2012_10_24(��)bsh
	 *
	 */
	public ActionForward newsMagazineRegistForm(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		log.debug("NewsMagazine:���");

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
		return actionMapping.findForward("newsMagazineRegistForm");
	}

	/**
	 * News_Magazine ���ó��
	 *
	 * 	 
	 */
	public ActionForward newsMagazineRegist(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "newsmagazine/"
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

		String NewsFile = "";

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
		log.debug("����"+Title);
		String Contents = StringUtil.nvl(
				multipartRequest.getParameter("Contents"), "");
		log.debug("����"+Contents);
		String NewsFileNm = StringUtil.nvl(
				multipartRequest.getParameter("NewsFileNm"), "");
		log.debug("�����̸�"+NewsFileNm);
		
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		NewsMagazineDTO nmDto = new NewsMagazineDTO();

		nmDto.setWriteUser(USERID);
		log.debug("�����"+USERID);
		nmDto.setNewsFile(NewsFile);
		log.debug("���ϰ��"+NewsFile);
		nmDto.setNewsFileNm(NewsFileNm);
		log.debug("�����̸�"+NewsFileNm);
		nmDto.setTitle(Title);
		log.debug("����"+Title);
		nmDto.setContents(Contents);
		log.debug("����"+Contents);
		
		retVal = nmDao.addNewsRegist(nmDto);

		 msg = "News&Magazine ��Ͽ� �����Ͽ����ϴ�";
	        if(retVal < 1) msg = "News&Magazine ��Ͽ� �����Ͽ����ϴ�";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_NewsMagazine.do?cmd=newsMagazinePageList&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
	}


	/**
	 * �Խ���-> News_Magazine����Ʈ
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
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);

		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
	
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		NewsMagazineDTO nmDto = new NewsMagazineDTO();

		// ����Ʈ
		
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
	 * �Խ���-> News_Magazine����Ʈ
	 * 
	 *
	 */
	public ActionForward newsMagazinePageList2(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {
		
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);

		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.

		  
		  MultipartRequest multipartRequest = null;
		  
		  String FilePath = FileUtil.FILE_DIR + "newsmagazine/"
					+ DateTimeUtil.getDate() + "/";
			log.debug("FilePath= " + FilePath);
			UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
					500);	//500M
			//UploadFiles (,,,500)500�ǹ� MB�뷮 ��������
			multipartRequest = uploadEntity.getMultipart();
		  
		  
		String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"), "");
		String searchtxt = StringUtil.nvl(multipartRequest.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"), 1);
	
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		NewsMagazineDTO nmDto = new NewsMagazineDTO();

		// ����Ʈ
		
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
	 * News_Magazine ������
	 * 
	 */
	public ActionForward newsMagazineView(ActionMapping actionMapping,
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
		 
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		NewsMagazineDTO nmDto = new NewsMagazineDTO();
		//UserMemDTO useridd = new UserMemDTO();

		nmDto.setSeq(Seq);
		nmDto = nmDao.newsMagazineView(nmDto);
		
		//�Խ��� ��ȸ�� ������Ű��.
		//�󼼺��� ����Ʈ�� ReadCount(��ȸ���� �������µ��ÿ� Update�� ReadCount+1 ������Ų��.)
		//�̶� disDto�� ��ȸ���� �����͸� �������ٶ�
		//disDto.setReadCount(disDto.getReadCount()); disDto���ִ� ReadCount�����ͼ� �����Ѵ�.
		if(nmDto != null){
			
			
		// ���ν��������ҽ� java�ܿ��� ó���Ҷ�..
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
			String msg = "News&Magazine  ������ �����ϴ�.";
			return alertAndExit(model, msg, request.getContextPath()
					+ "/B_NewsMagazine.do?cmd=newsMagazinePageList&curPage=" + curPageCnt
					, "back");
		} else {
			return actionMapping.findForward("newsMagazineView");
		}
	}
	

	/**
	 * News_Magazine ����
	 *
	 * 	 
	 */
	public ActionForward newsMagazineEdit(ActionMapping actionMapping,
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
		String FilePath = FileUtil.FILE_DIR + "newsmagazine/"
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

		String NewsFile = "";

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
			NewsFile = StringUtil.nvl(
					multipartRequest.getParameter("p_NewsFile"), "");//p_BankBookFile Web(����������)�����ް�  BankBookFile DB�δ���ش�.
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

					if (objName.equals("NewsFile")) {
						NewsFile = uploadFilePath;
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
		String NewsFileNm = StringUtil.nvl(
				multipartRequest.getParameter("NewsFileNm"), "");
		log.debug("�����̸�"+NewsFileNm);
		
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		NewsMagazineDTO nmDto = new NewsMagazineDTO();

		nmDto.setSeq(Seq);
		nmDto.setWriteUser(USERID);
		log.debug("�����"+USERID);
		nmDto.setNewsFile(NewsFile);
		log.debug("���ϰ��"+NewsFile);
		nmDto.setNewsFileNm(NewsFileNm);
		log.debug("�����̸�"+NewsFileNm);
		nmDto.setTitle(Title);
		log.debug("����"+Title);
		nmDto.setContents(Contents);
		log.debug("����"+Contents);
		
		retVal = nmDao.newsMagazineUpdate(nmDto);
		
		msg = "News&Magazine ������ �����Ǿ����ϴ�";
		if (retVal < 1)
			msg = "News&Magazine ���� ������ �����Ͽ����ϴ�";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_NewsMagazine.do?cmd=newsMagazinePageList&curPage="+curPageCnt+"&searchGb="+searchGb,"back");		
	}

	/**
	 * News_Magazine = > ����
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
		 * �����ÿ��� multipartrequest�� ��û ���� �ؾߵȴ�.
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

		msg = "������  �����Ͽ����ϴ�";
		if (retVal < 1)
			msg = "������ �����Ͽ����ϴ�";

		return alertAndExit(model, msg, request.getContextPath()
				+ "/B_NewsMagazine.do?cmd=newsMagazinePageList" , "back");
	}

}
