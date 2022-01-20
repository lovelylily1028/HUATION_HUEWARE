package com.huation.hueware.user.action;

import java.text.*;
import java.util.*;

import javax.servlet.http.*;

import org.apache.struts.action.*;

import com.huation.common.user.*;
import com.huation.framework.persist.*;
import com.huation.framework.struts.*;
import com.huation.framework.util.*;
import com.oreilly.servlet.*;

public class UserAction extends StrutsDispatchAction{
	
	/**
	 * �������� ���� ����Ʈ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
   public ActionForward userPageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

	    //log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userPageList action start");
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String SearchGroup = StringUtil.nvl(request.getParameter("SearchGroup"),"G00001");
	
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
	/*	
		if(USERID.equals("")){
			String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 
		*/
		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
	  
  
	//����Ʈ
		userDto.setLogid(logid);
		userDto.setChUserID(USERID);
		userDto.setvSearchType(searchGb);
		userDto.setvSearch(searchtxt);
		userDto.setnRow(20);
		userDto.setnPage(curPageCnt);
	    
		ListDTO ld = userDao.userPageList(userDto);

	  //ī��Ʈ ����
		UserDTO userDtoCount = userDao.userTotCount(userDto);
		
		model.put("totalInfo", userDtoCount );
		model.put("listInfo",ld);
		model.put("curPage",String.valueOf(curPageCnt));
	    model.put("searchGb",searchGb);
	    model.put("searchtxt",searchtxt);
	    
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userPageList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("userPageList");
   	}
	/**
	 * ���� ��� �� (���۾���-���� ȣ��)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userRegistForm
	 * @throws Exception
	 */
	public ActionForward userRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userRegistForm action start");
 
	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userRegistForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		

	  return actionMapping.findForward("userRegistForm");
	 }
	/**
	 * ���� ���
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward userRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userRegist action start");
		
//		�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		String msg="";
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
		//UploadFiles (,,,500)500�ǹ� MB�뷮 ��������
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String BoardFile = "";

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

					if (objName.equals("BoardFile")) {
						BoardFile = uploadFilePath;
					}
				}
			}
		}
		String BoardFileNm = StringUtil.nvl(multipartRequest.getParameter("BoardFileNm"), "");
		log.debug("�����̸�"+BoardFileNm);
		
		String ID = StringUtil.nvl(multipartRequest.getParameter("ID"),"");
		String Name = StringUtil.nvl(multipartRequest.getParameter("Name"),"");
		String FaxNo = StringUtil.nvl(multipartRequest.getParameter("FaxNo"),"");
		String GroupID = StringUtil.nvl(multipartRequest.getParameter("GroupID"),"");
		String AuthID = StringUtil.nvl(multipartRequest.getParameter("AuthID"),"");
		String OfficeTellNo = StringUtil.nvl(multipartRequest.getParameter("OfficeTellNo"),"");//�ڵ�����ȣ
		String OfficeTellNo2 = StringUtil.nvl(multipartRequest.getParameter("OfficeTellNo2"),"");//�系�����ȣ
		String Password = StringUtil.nvl(multipartRequest.getParameter("Password"),"");
		String UseYN = StringUtil.nvl(multipartRequest.getParameter("UseYN"),"");
		String Description = StringUtil.nvl(multipartRequest.getParameter("Description"),"");
		String HireDateTime = StringUtil.nvl(multipartRequest.getParameter("HireDateTime"), "");
		String FireDateTime = StringUtil.nvl(multipartRequest.getParameter("FireDateTime"), "");
		String Position = StringUtil.nvl(multipartRequest.getParameter("Position"), "");
		String Photo = StringUtil.nvl(multipartRequest.getParameter("photo"), "");
		String EmployeeNum_check = StringUtil.nvl(multipartRequest.getParameter("EmployeeNum"), "");
		String jumin1 = StringUtil.nvl(multipartRequest.getParameter("jumin1"), "");
		String jumin2 = StringUtil.nvl(multipartRequest.getParameter("jumin2"), "");
		String zip = StringUtil.nvl(multipartRequest.getParameter("zip"), "");
		
		String encPasswd="";
		String date = HireDateTime.substring(0, 4) + HireDateTime.substring(5, 7);
		int retVal=0;
		

		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		
		encPasswd=userDao.setPasswdEncode(Password);
		String EmployeeNum = userDao.EmployeeNumCreate(EmployeeNum_check, date);
		userDto.setLogid(logid);
		userDto.setChUserID(USERID);
		userDto.setID(ID);
		userDto.setName(Name);
		userDto.setFaxNo(FaxNo);
		userDto.setGroupID(GroupID);
		userDto.setAuthID(AuthID);
		userDto.setOfficeTellNo(OfficeTellNo);
		userDto.setOfficeTellNo2(OfficeTellNo2);
		userDto.setPassword(encPasswd);
		userDto.setUseYN(UseYN);
		userDto.setDescription(Description);
		userDto.setHireDateTime(HireDateTime);
		userDto.setFireDateTime(FireDateTime);
		userDto.setPosition(Position);
		userDto.setPhoto(Photo);
		userDto.setBoardFileNm(BoardFileNm);
		userDto.setBoardFile(BoardFile);
		userDto.setEmployeeNum(EmployeeNum);
		userDto.setJumin1(jumin1);
		userDto.setJumin2(jumin2);
		userDto.setZip(zip);
		
		retVal=userDao.userRegist(userDto);

		if(retVal==-1){
			msg="��Ͽ���!";
		}else if(retVal==0){
			msg="��Ͻ���!";
		}else{
			msg="��ϿϷ�!";
		}			
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userRegist action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return closePopupReload(model, msg,"","", request.getContextPath()+"/B_User.do?cmd=userPageList");
	}
	/**
	 * ���üũ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 *//*
	public String EmployeeNum(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		String position = StringUtil.nvl(request.getParameter("position"),"");
		String HireDate = StringUtil.nvl(request.getParameter("HireDateTime"),"");
		String EmployeeNumber = null;
		
		String yyyy=null, mm=null;
			
		yyyy = HireDate.substring(0,4);
		mm = HireDate.substring(5,7);
		HireDate = yyyy+mm;

		System.out.println("HireDate = " + HireDate);
		
		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		
		EmployeeNumber = userDao.EmployeeNumCreate(position, HireDate);
		model.put("EmployeeNumber", EmployeeNumber);
		
		userDto.setEmployeeNum(EmployeeNumber);
		
		response.setContentType("text/html; charset=euc-kr");
		response.getWriter().print(EmployeeNumber);
		return EmployeeNumber;
	}*/
	/**
	 * ���� ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userModifyForm
	 * @throws Exception
	 */
	public ActionForward userModifyForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userModifyForm action start");
		
		String ID = StringUtil.nvl(request.getParameter("ID"),"");
		String Name = StringUtil.nvl(request.getParameter("Name"),"");
		String Password = StringUtil.nvl(request.getParameter("Password"),"");
		String msg ="";
		
		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		/*
		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��. 
			*/
		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		
		userDto.setLogid(logid);
		userDto.setID(ID);
		userDto.setName(Name);
		userDto.setPassword(Password);
		
		userDto = userDao.userView(userDto);
		
		if(userDto == null){
			msg = "����� ������ �����ϴ�.";	
	    }
		
		model.put("userDto", userDto);
	    model.put("msg", msg);

	    //log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userModifyForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");

	    return actionMapping.findForward("userModifyForm");
	
	}
	/**
	 * ���� ������ �����Ѵ�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward userModify(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userModify action start");
		
		String USERID = UserBroker.getUserId(request);
		String msg="";
		/*
//		�α��� ó�� 

		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
//			�α��� ó�� ��.
*/
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
		//UploadFiles (,,,500)500�ǹ� MB�뷮 ��������
		multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();

		int curPageCnt = 0;
		String searchGb = "";
		String searchtxt = "";
		String sForm = "N";

		String BoardFile = "";

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
			BoardFile = StringUtil.nvl(
					multipartRequest.getParameter("p_BoardFile"), "");//p_BoardFile Web(����������)�����ް�  BoardFile DB�δ���ش�.
			//BoardFile Request.getparameter �Ѱ��ִ����� ������ ������ ���������ʾ������ �������ִ����� ���������ؼ� 
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

					if (objName.equals("BoardFile")) {
						BoardFile = uploadFilePath;
					}
				}
			}
		}
		String BoardFileNm = StringUtil.nvl(multipartRequest.getParameter("BoardFileNm"), "");
		log.debug("�����̸�"+BoardFileNm);
		
		String ID = StringUtil.nvl(multipartRequest.getParameter("ID"),"");
		String Name = StringUtil.nvl(multipartRequest.getParameter("Name"),"");
		String FaxNo = StringUtil.nvl(multipartRequest.getParameter("FaxNo"),"");
		String GroupID = StringUtil.nvl(multipartRequest.getParameter("GroupID"),"");
		String AuthID = StringUtil.nvl(multipartRequest.getParameter("AuthID"),"");
		String OfficeTellNo = StringUtil.nvl(multipartRequest.getParameter("OfficeTellNo"),"");
		String OfficeTellNo2 = StringUtil.nvl(multipartRequest.getParameter("OfficeTellNo2"),"");
		String Password = StringUtil.nvl(multipartRequest.getParameter("Password"),"");
		String UseYN = StringUtil.nvl(multipartRequest.getParameter("UseYN"),"");
		String Description = StringUtil.nvl(multipartRequest.getParameter("Description"),"");
		String PasswordModifyYN = StringUtil.nvl(multipartRequest.getParameter("PasswordModifyYN"),"");
		String HireDateTime = StringUtil.nvl(multipartRequest.getParameter("HireDateTime"), "");
		String FireDateTime = StringUtil.nvl(multipartRequest.getParameter("FireDateTime"), "");
		String Position = StringUtil.nvl(multipartRequest.getParameter("Position"), "");
		String Photo = StringUtil.nvl(multipartRequest.getParameter("photo"), "");
		String encPasswd ="";
		String section = StringUtil.nvl(multipartRequest.getParameter("section"), "");
		String getEmployeeNum = StringUtil.nvl(multipartRequest.getParameter("getEmployeeNum"), "");
		String jumin1 = StringUtil.nvl(multipartRequest.getParameter("jumin1"), "");
		String jumin2 = StringUtil.nvl(multipartRequest.getParameter("jumin2"), "");
		String jumin3 = StringUtil.nvl(multipartRequest.getParameter("jumin3"), "");
		String zip = StringUtil.nvl(multipartRequest.getParameter("zip"), "");
		if(jumin2.equals("huemast"))jumin2=jumin3; //���� ��Ŷ css�� ���� password�� ������ ���Ұ�� �ٲ�.
		System.out.println("Photo :"+Photo);
		String EmployeeNum="";
		int retVal=0;
		
		String date = HireDateTime.substring(0, 4) + HireDateTime.substring(5, 7);
		
		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();
		
		if(getEmployeeNum.isEmpty()){
			EmployeeNum = userDao.EmployeeNumCreate(section, date);
		}else if((getEmployeeNum.substring(2, 8)).equals(date)){
			if(!getEmployeeNum.substring(0, 2).equals(section)){
				EmployeeNum = section + getEmployeeNum.substring(2);
			}else{
				EmployeeNum = getEmployeeNum;
			}
		}else {
			EmployeeNum = userDao.EmployeeNumCreate(section, date);
		}
		
		
		if(PasswordModifyYN.equals("Y")){
			encPasswd=userDao.setPasswdEncode(Password);
		}else{
			encPasswd=Password;
		}
		
		userDto.setLogid(logid);
		userDto.setName(Name);
		userDto.setID(ID);
		userDto.setFaxNo(FaxNo);
		userDto.setGroupID(GroupID);
		userDto.setAuthID(AuthID);
		userDto.setOfficeTellNo(OfficeTellNo);
		userDto.setOfficeTellNo2(OfficeTellNo2);
		userDto.setPassword(encPasswd);
		userDto.setUseYN(UseYN);
		userDto.setDescription(Description);
		userDto.setRegID(USERID);
		userDto.setLastUpdateUserID(USERID);
		userDto.setHireDateTime(HireDateTime);
		userDto.setFireDateTime(FireDateTime);
		userDto.setPosition(Position);
		userDto.setPhoto(Photo);
		userDto.setBoardFileNm(BoardFileNm);
		userDto.setBoardFile(BoardFile);
		userDto.setEmployeeNum(EmployeeNum);
		userDto.setJumin1(jumin1);
		userDto.setJumin2(jumin2);
		userDto.setZip(zip);
		
		retVal=userDao.userModify(userDto);
		
		if(retVal==-1){
			msg="��������!";
		}else if(retVal==0){
			msg="��������!";
		}else{
			msg="�����Ϸ�!";
		}
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userModify action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return closePopupReload(model, msg,"","", request.getContextPath()+"/B_User.do?cmd=userPageList");

	}
	/**
	 * ���� ������ �����Ѵ�.(�ٰ�)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userPageList
	 * @throws Exception
	 */
	public ActionForward userDeletes(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userDeletes action start");

		//�α��� ó�� 
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.

		int retVal=0;
		String msg="";
		
		String[] users = request.getParameterValues("seqs");

		UserDAO userDao = new UserDAO();

		retVal = userDao.userDeletes(logid,users, USERID);
		
		if(retVal==-1){
			msg="��������!";
		}else if(retVal==0){
			msg="��������!";
		}else{
			msg="�����Ϸ�!";
		}
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userDeletes action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return alertAndExit(model,msg,request.getContextPath()+"/B_User.do?cmd=userPageList","");	
		
	}
	/**
	 * ���� ���� EXCEL EXPORT
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userExcelList
	 * @throws Exception
	 */
	public ActionForward userExcelList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userExcelList action start");
		
		String USERID = UserBroker.getUserId(request);
		/*
		//�α��� ó�� 
		if(USERID.equals("")){
				String rtnUrl =  request.getContextPath()+"/H_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		//�α��� ó�� ��.
		*/
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
	    String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
	    int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
	
	    UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();

		userDto.setLogid(logid);
		userDto.setChUserID(USERID);
		userDto.setvSearchType(searchGb);
		userDto.setvSearch(searchtxt);
		userDto.setnRow(100);
		userDto.setnPage(curPageCnt);

		ListDTO ld = userDao.userPageList(userDto);
		
		model.put("listInfo",ld);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userExcelList action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("userExcelList");
	}
	/**
	 * ����� �ߺ�üũ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return userXML
	 * @throws Exception
	 */
	public ActionForward userDupCheck(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "userDupCheck action start");
		
		String user = StringUtil.nvl(request.getParameter("userid"),"");

		UserDAO userDao = new UserDAO();
		UserDTO userDto = new UserDTO();

		userDto.setLogid(logid);
		userDto.setID(user);
	
		String result = userDao.userDupCheck(userDto);

		model.put("result", result );
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "userDupCheck action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
	  return actionMapping.findForward("userXML");
	}
	
	/**
	 * �н����� ��ȣȭ
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward pwdEnc(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{


		String cpawd = StringUtil.nvl(request.getParameter("cpawd"),"");
		/*2012.12.12(��) bsh.
			Ư�� ��й�ȣ ����� ��ȣȭ���� Ʋ����
			���� ��й�ȣ ���� ���� ��й�ȣ�� ���� Ʋ�� Ư���� ���� ��ġ �����ֱ�����
			dpawd(������й�ȣ���� get������γѱ�.) �߰�.  
		*/
		String dpawd = StringUtil.nvl(request.getParameter("dpawd"),"");
		String encPasswd ="";
		String encPasswd2 =dpawd;
		
		
		UserDAO userDao = new UserDAO();
		encPasswd =userDao.setPasswdEncode(cpawd);
		
		System.out.println("encPasswd  ���� ��й�ȣ ��ȣȭ ��:"+encPasswd);
		System.out.println("encPasswd2  ���� ��й�ȣ ��ȣȭ ��:"+encPasswd2);
		
		model.put("encPasswd",encPasswd);

		return actionMapping.findForward("pwResult");
	}
	
	/**
	 * �н����� ����
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward passModify(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		String userId = StringUtil.nvl(request.getParameter("userid"),"");
		String passWd = StringUtil.nvl(request.getParameter("password"),"");
		String encPasswd ="";
			
		int reVal = 0;
		String msg="";
		
		UserDAO userDao = new UserDAO();
		encPasswd =userDao.setPasswdEncode(passWd);
		
		reVal=userDao.getPasswdModify(userId,encPasswd);
		
		log.debug("reVal:"+reVal);
		log.debug("msg:"+msg);
		
		model.put("msg",msg);
		model.put("passwd", encPasswd);
		model.put("user_id", userId);
		
		if(reVal>0){
			msg="��й�ȣ ����Ϸ�!!";
	
		return alertAndExit(model,msg,request.getContextPath()+"/B_Login.do?cmd=loginOff","");
		
		}else{
			msg="��й�ȣ �������!!(�����ڿ��� �����ϼ���.)";
			
		return alertAndExit(model,msg,request.getContextPath()+"/B_Common.do?cmd=mainPage","");		
		
		}
	}
	/**
	 * ����� ���� ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward passwdEdit(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		String user_id = StringUtil.nvl(request.getParameter("user_id"),"");
		//System.out.println("USERID:"+user_id); ajax ������� ���� ����ھ��̵�
		String passwd = StringUtil.nvl(request.getParameter("passwd"),"");
		//System.out.println("passwd:"+passwd); ajax ������� ���� ����ں�й�ȣ
		
		model.put("page","E");
		model.put("user_id", user_id);
		model.put("passwd", passwd);

		return actionMapping.findForward("passwdEdit");
	}
	
	
	
	
	
	
	
	
	/**
	 * ���� ���ε� ������
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward photoForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "photoForm action start");
		
		
		
		String photo=StringUtil.nvl(request.getParameter("photo"),"");
		String Flag=StringUtil.nvl(request.getParameter("Flag"),"");
		System.out.println("photo : "+photo);
		System.out.println("Flag : "+Flag);
		
		
		
		model.put("fileNm", photo);		
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "photoForm action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		if(Flag.equals("R")){
		return actionMapping.findForward("photoUpload");
		}else{
		return actionMapping.findForward("photoModifyUpload");	
		}
	
	}
	
	
	/**
	 * ���� ���ε�
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward photoUpload(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		MultipartRequest multipartRequest = null;
		String msg = "";
		
		String fileNm="";
		
		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";		
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR+"recruit/";
		String uploadFilePath="";
		log.debug("FilePath= "+FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath,"huation", 10);
     	multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();
		
		if (status.equals("E")){ 
			log.debug("÷�� ���� �ø����� �����Ͽ����ϴ�.");
			msg = "÷�� ���� �ø����� �����Ͽ����ϴ�.";	
	        return alertAndExit(model,msg,request.getContextPath()+"/jsp/back/common/error.jsp","back");	
	        
		}else if (status.equals("O")){ 
			log.debug("÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.");
			msg = "÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.�ִ� 10M ���� �����մϴ�.";	
	        return alertAndExit(model,msg,request.getContextPath()+"/jsp/back/common/error.jsp","back");	
			    
		}else if (status.equals("I")){
			log.debug("÷�� ������ ������ �߸��Ǿ����ϴ�.");
			msg = "÷�� ������ ������ �߸��Ǿ����ϴ�.";	
	        return alertAndExit(model,msg,request.getContextPath()+"/jsp/back/common/error.jsp","back");	
			
		}else if(status.equals("S")){
			// ���ε�� ������ ������ �����´�
			log.debug("÷�� ������ ÷���ϴµ� �����Ͽ����ϴ�.");
			ArrayList files = uploadEntity.getFiles();
			UploadFile file = null;
			for(int i = 0 ; i < files.size(); i++){
				file = (UploadFile)files.get(i);
				objName = file.getObjName();
				rFileName = StringUtil.nvl(file.getRootName());
				if(!rFileName.equals("")) {
					log.debug("++++++++++++++++ ObjName = "+file.getObjName());
					log.debug("++++++++++++++++ FileName = "+file.getRootName());
					log.debug("++++++++++++++++ path = "+uploadEntity.getUploadPath());
					
					sFileName = file.getUploadName();
					fileSize = String.valueOf(file.getSize());
					filePath = uploadEntity.getUploadPath();
					uploadFilePath=filePath + sFileName;

					log.debug("���� ������Ʈ��["+ objName + "]�����ϸ�["+rFileName+"]�������ϸ�["+sFileName+"]���ϻ�����["+fileSize+"]���������н�["+filePath+"]���ε� ���["+uploadFilePath+"]");

					if(objName.equals("photo_file")){
						fileNm=uploadFilePath;
					} 	
				}
			}
		}
		
		model.put("fileNm", fileNm);		
		
		return actionMapping.findForward("photoUpload");
	}
	
	/**
	 * ���� ���ε�
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward photoModifyUpload(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		MultipartRequest multipartRequest = null;
		String msg = "";
		
		String fileNm="";
		
		String objName = "";
		String rFileName = "";
		String sFileName = "";
		String filePath = "";
		String fileSize = "";		
		String sImageName = "";
		String FilePath = FileUtil.FILE_DIR+"recruit/";
		String uploadFilePath="";
		log.debug("FilePath= "+FilePath);
		UploadFiles uploadEntity = FileUtil.upload(request, FilePath,"huation", 10);
     	multipartRequest = uploadEntity.getMultipart();
		String status = uploadEntity.getStatus();
		
		if (status.equals("E")){ 
			log.debug("÷�� ���� �ø����� �����Ͽ����ϴ�.");
			msg = "÷�� ���� �ø����� �����Ͽ����ϴ�.";	
	        return alertAndExit(model,msg,request.getContextPath()+"/jsp/back/common/error.jsp","back");	
	        
		}else if (status.equals("O")){ 
			log.debug("÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.");
			msg = "÷���Ͻ� ������ �뷮�� �ʰ��߽��ϴ�.�ִ� 10M ���� �����մϴ�.";	
	        return alertAndExit(model,msg,request.getContextPath()+"/jsp/back/common/error.jsp","back");	
			    
		}else if (status.equals("I")){
			log.debug("÷�� ������ ������ �߸��Ǿ����ϴ�.");
			msg = "÷�� ������ ������ �߸��Ǿ����ϴ�.";	
	        return alertAndExit(model,msg,request.getContextPath()+"/jsp/back/common/error.jsp","back");	
			
		}else if(status.equals("S")){
			// ���ε�� ������ ������ �����´�
			log.debug("÷�� ������ ÷���ϴµ� �����Ͽ����ϴ�.");
			ArrayList files = uploadEntity.getFiles();
			UploadFile file = null;
			for(int i = 0 ; i < files.size(); i++){
				file = (UploadFile)files.get(i);
				objName = file.getObjName();
				rFileName = StringUtil.nvl(file.getRootName());
				if(!rFileName.equals("")) {
					log.debug("++++++++++++++++ ObjName = "+file.getObjName());
					log.debug("++++++++++++++++ FileName = "+file.getRootName());
					log.debug("++++++++++++++++ path = "+uploadEntity.getUploadPath());
					
					sFileName = file.getUploadName();
					fileSize = String.valueOf(file.getSize());
					filePath = uploadEntity.getUploadPath();
					uploadFilePath=filePath + sFileName;

					log.debug("���� ������Ʈ��["+ objName + "]�����ϸ�["+rFileName+"]�������ϸ�["+sFileName+"]���ϻ�����["+fileSize+"]���������н�["+filePath+"]���ε� ���["+uploadFilePath+"]");

					if(objName.equals("photo_file")){
						fileNm=uploadFilePath;
					} 	
				}
			}
		}
		
		model.put("fileNm", fileNm);		
		
		return actionMapping.findForward("photoModifyUpload");
	}
	
	
}
