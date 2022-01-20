package com.huation.hueware.common.action;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huation.common.CommonDAO;
import com.huation.common.PostCodeDTO;
import com.huation.common.user.UserBroker;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;
import com.huation.common.config.GroupDAO;
import com.huation.common.config.GroupDTO;
import com.huation.common.config.MenuDTO;
import com.huation.common.company.CompanyDAO;
import com.huation.common.company.CompanyDTO;
import com.huation.common.estimate.EstimateDAO;
import com.huation.common.estimate.EstimateDTO;

//�Խ��� ���� DTO/DAO
import com.huation.common.dispnotify.DispNotifyDAO;
import com.huation.common.dispnotify.DispNotifyDTO;
import com.huation.common.familyevent.FamilyEventDTO;
import com.huation.common.familyevent.FamilyEventDAO;
import com.huation.common.formfile.FormFileDTO;
import com.huation.common.formfile.FormFileDAO;
import com.huation.common.freeboard.FreeBoardDTO;
import com.huation.common.freeboard.FreeBoardDAO;
import com.huation.common.newsmagazine.NewsMagazineDAO;
import com.huation.common.newsmagazine.NewsMagazineDTO;
import com.huation.common.documentfile.DocumentFileDAO;
import com.huation.common.documentfile.DocumentFileDTO;

import com.huation.common.config.AuthDTO;
import com.huation.common.config.AuthDAO;
import com.huation.common.contractmanage.ContractManageDAO;
import com.huation.common.contractmanage.ContractManageDTO;
import com.huation.common.currentstatus.CurrentStatusDAO;
import com.huation.common.currentstatus.CurrentStatusDTO;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.struts.StrutsDispatchAction;
import com.huation.framework.util.StringUtil;


public class CommonAction extends StrutsDispatchAction{

	/**
	 * ���� ������ ���� ó��
	 */
	public CommonAction() {
		super();
		// TODO Auto-generated constructor stub
	}

    /**
     * ���θ� �����ȣ�� �˻��Ѵ�.
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward searchPost(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String pForm = StringUtil.nvl(request.getParameter("pForm"),"");
		String pZip = StringUtil.nvl(request.getParameter("pZip"),"");
		String pAddr = StringUtil.nvl(request.getParameter("pAddr"),"");
		String pDong = StringUtil.nvl(request.getParameter("pDong"),""); 

		String vSearchType = StringUtil.nvl(request.getParameter("searchGb"),"0"); 
		System.out.println("vSearchType:"+vSearchType);
		String vSearch = StringUtil.nvl(request.getParameter("searchtxt"),"");
	
		CommonDAO commonDAO = new CommonDAO();
		PostCodeDTO ptCode = new PostCodeDTO(); 
		
		ptCode.setvSearchType(vSearchType);
		ptCode.setvSearch(vSearch);
		
		ListDTO ld = commonDAO.searchPost(ptCode);
		
        model.put("listInfo", ld);
    	model.put("pForm",pForm);
		model.put("pZip",pZip);
		model.put("pAddr",pAddr);
		model.put("pDong",pDong);
		
		model.put("vSearchType",vSearchType);
		model.put("vSearch",vSearch);
		
		 
        return actionMapping.findForward("postlist"); 
	}
	
	/**
     * ���� �ּ� �����ȣ�� �˻��Ѵ�.
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward searchPost2(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String pForm = StringUtil.nvl(request.getParameter("pForm"),"");
		String pZip = StringUtil.nvl(request.getParameter("pZip"),"");
		String pAddr = StringUtil.nvl(request.getParameter("pAddr"),"");
		String pDong = StringUtil.nvl(request.getParameter("pDong"),""); 

		model.put("pForm",pForm);
		model.put("pZip",pZip);
		model.put("pAddr",pAddr);
		model.put("pDong",pDong);
		
		CommonDAO commonDAO 	= 	new CommonDAO();
		 
		ArrayList postList =  new ArrayList();
		if(!pDong.equals(""))
			postList =  commonDAO.searchPost(pDong);
		
        model.put("postList", postList);
		
		 
        return actionMapping.findForward("postlist2"); 
	}
	
	/**
     * ��ü������ �˻��Ѵ�.
     * 2013_03_22(��) shbyeon.
     * complist.jsp ȣ��� (����� ��Ϲ�ȣ Permit_no �ִ� �����͸� �˻�)
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward searchComp(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			
		CompanyDAO compDao = new CompanyDAO();

		ListDTO ld = compDao.companyPageListPop(curPageCnt, searchGb, searchtxt,"Y","Y","2014-08-08", 10, 10);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);	
		 
        return actionMapping.findForward("complist"); 
	}
	
	
	
	
	public ActionForward searchComp_lC(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			
		CompanyDAO compDao = new CompanyDAO();

		ListDTO ld = compDao.companyPageListPop(curPageCnt, searchGb, searchtxt,"Y","Y","test", 10, 10);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);	
		 
        return actionMapping.findForward("complist_Ic"); 
	}
	

	
	/**
     * ��ü������ �˻��Ѵ�.(���ݰ�꼭 �뵵)
     * 2013_03_22(��) shbyeon.
     * complist_Ic.jsp ȣ��� (����� ��Ϲ�ȣ Permit_no �ִ� �����͸� �˻�)
     * COMP_CODE , PERMIT_NO �ѱ������.
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward searchComp_Ic(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			
		CompanyDAO compDao = new CompanyDAO();

		ListDTO ld = compDao.companyPageListPop(curPageCnt, searchGb, searchtxt,"Y","Y","2014-08-08",10, 10);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);	
		 
        return actionMapping.findForward("complist_Ic"); 
	}
	/**
     * ��������� �˻��Ѵ�.
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	
	
	
public ActionForward searchComp_baro(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			
		CompanyDAO compDao = new CompanyDAO();

		ListDTO ld = compDao.companyPageListPop(curPageCnt, searchGb, searchtxt,"Y","Y",10, 10);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);	
		 
        return actionMapping.findForward("complist_baro"); 
	}
	/**
     * ��������� �˻��Ѵ�.
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	
	
	
	
	
	public ActionForward searchUser(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			
		UserDAO userDao = new UserDAO();
		UserDTO userDto =new UserDTO();
		
		userDto.setLogid("");
		userDto.setvSearchType(searchGb);
		userDto.setvSearch(searchtxt);
		userDto.setnRow(10);
		userDto.setnPage(curPageCnt);
		
		ListDTO ld = userDao.userPageList(userDto);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);	
		 
        return actionMapping.findForward("userlist"); 
	}
	
	/**
     * ��������� �˻��Ѵ�. ���� �ι�° �˾�â
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward searchUser2(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			
		UserDAO userDao = new UserDAO();
		UserDTO userDto =new UserDTO();
		
		userDto.setLogid("");
		userDto.setvSearchType(searchGb);
		userDto.setvSearch(searchtxt);
		userDto.setnRow(10);
		userDto.setnPage(curPageCnt);
		
		ListDTO ld = userDao.userPageList(userDto);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);	
		 
        return actionMapping.findForward("userlist2"); 
	}
	
	/**
     * ����������Ȳ�� �˻��Ѵ�.(������ ���� �����.)
     * 2013_04_16(ȭ) shbyeon.
     * ProjectPk.
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward searchPreSalesCode(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGbYear = StringUtil.nvl(request.getParameter("searchGbYear"), ""); //�˻����� (�⵵)
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), ""); //�˻����� (��������)
		String searchGb2 = StringUtil.nvl(request.getParameter("searchGb2"), ""); //�˻����� (���)
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), ""); //�˻���
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		
			
		CurrentStatusDAO csDao = new CurrentStatusDAO();
		CurrentStatusDTO csDto = new CurrentStatusDTO();

		//����Ʈ
		csDto.setvSearchYear(searchGbYear); //�˻����� (�⵵)
		csDto.setvSearchType(searchGb);  //�˻����� (��������)
		csDto.setvSearchType2(searchGb2); //�˻����� (���)
		csDto.setvSearch(searchtxt);
		//csDto.setnRow(0); SP���� JobGB�� LIST���·� �޾Ƽ� ��ü ����Ʈ�������´�.
		csDto.setnPage(1);
		
		//1/2/3/4 �б⺰ ����Ʈ
		ListDTO ld = csDao.CurrentStatusList(csDto);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGbYear", searchGbYear);
		model.put("searchGb", searchGb);
		model.put("searchGb2", searchGb2);
		model.put("searchtxt",searchtxt);	
		 
        return actionMapping.findForward("projectcodelist"); 
	}
	
	/**
     * �����ȣ�� �˻��Ѵ�.(������ �����.)
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward searchPublicNo(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String USERID = UserBroker.getUserId(request);
		if(USERID.equals("")){
			String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
		}
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String contractGb = StringUtil.nvl(request.getParameter("contractGb"),"Y");
		String type = StringUtil.nvl(request.getParameter("type"),"reg");
		
		EstimateDAO estimateDao = new EstimateDAO();

		ListDTO ld = estimateDao.estimatePageListPop(curPageCnt, searchGb,contractGb, searchtxt,10, 10 , type , USERID);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("contractGb",contractGb);
		model.put("searchtxt",searchtxt);
		model.put("type",type);
		 
        return actionMapping.findForward("publicnolist"); 
	}
	/**
     * �����ȣ�� �˻��Ѵ�(��� �� �Ǹ�/���ݰ�꼭 �����.).
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward searchPublicNoConY(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String contractGb = StringUtil.nvl(request.getParameter("contractGb"),"Y");
			
		EstimateDAO estimateDao = new EstimateDAO();

		ListDTO ld = estimateDao.estimatePageListPopConY(curPageCnt, searchGb,contractGb, searchtxt,10, 10);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("contractGb",contractGb);
		model.put("searchtxt",searchtxt);
		 
        return actionMapping.findForward("publicnolistcontract"); 
	}

	
	public ActionForward searchPublicNoConY_baro(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String contractGb = StringUtil.nvl(request.getParameter("contractGb"),"Y");
			
		EstimateDAO estimateDao = new EstimateDAO();

		ListDTO ld = estimateDao.estimatePageListPopConY(curPageCnt, searchGb,contractGb, searchtxt,10, 10);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("contractGb",contractGb);
		model.put("searchtxt",searchtxt);
		 
        return actionMapping.findForward("publicnolistcontract_baro"); 
	}





/**
 * CreateDate:2013-11-21(��) Writer:shbyeon.
 * ������ ����Ʈ
 * @param actionMapping
 * @param actionForm
 * @param request
 * @param response
 * @param model
 * @return contractMgPageList
 * @throws Exception
 */
public ActionForward searchContractNoConY_baro(ActionMapping actionMapping,
		ActionForm actionForm, HttpServletRequest request,
		HttpServletResponse response, Map model) throws Exception {

	
	String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
	String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
	String searchtxt = StringUtil
			.nvl(request.getParameter("searchtxt"), "");
	int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
	String contractGb = StringUtil.nvl(request.getParameter("contractGb"),"Y");
/*	
	// �α��� ó��
	String USERID = UserBroker.getUserId(request);
	
	//���� ���� �� �ʱ�ȭ��
	if(USERID.equals("")){ String rtnUrl =
	request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
	goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
*/
	//ProjectDAO pjDao = new ProjectDAO();
	ContractManageDTO cmDto = new ContractManageDTO();
	ContractManageDAO cmDao = new ContractManageDAO();

	// cmDto ��ü ����.
	/*cmDto.setChUserID(USERID);*/
	cmDto.setvSearchType(searchGb);
	cmDto.setvSearch(searchtxt);
	cmDto.setnRow(10);
	cmDto.setnPage(curPageCnt);
	cmDto.setJobGb("PAGE");

	ListDTO ld = cmDao.contractMgPageList(cmDto);
	
	// �𵨰�ü ����
	model.put("listInfo", ld);
	model.put("curPage", String.valueOf(curPageCnt));
	model.put("searchGb", searchGb);
	model.put("searchtxt", searchtxt);
	model.put("sForm",sForm);
	
	return actionMapping.findForward("searchContractNoConY_baro");
}
	
	
	/**
     * �����ȣ�� �˻��Ѵ�(���� ������ �� ��/������Ʈ �ڵ� ���� �뵵.).
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward searchPublicNoConY_Pj(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String contractGb = StringUtil.nvl(request.getParameter("contractGb"),"Y");
			
		EstimateDAO estimateDao = new EstimateDAO();

		ListDTO ld = estimateDao.estimatePageListPopConY_PJ(curPageCnt, searchGb,contractGb, searchtxt,10, 10);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("contractGb",contractGb);
		model.put("searchtxt",searchtxt);
		 
        return actionMapping.findForward("searchPublicNoConY_Pj"); 
	}
	
	/**
	 * CreateDate:2013-12-27(��) Writer:shbyeon.
	 * ������ ��ȸ ����Ʈ(�������� �ǿ� ���ؼ���/������Ʈ �ڵ� ���� �˾� ��ȸ �뵵.)
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return searchContractNoConN_Pj
	 * @throws Exception
	 */
	public ActionForward searchContractNoConN_Pj(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		
		String CtCd_tr_Cnt = StringUtil.nvl(request.getParameter("CtCd_tr_Cnt"),"0");	//�θ�â���� ���� ����ڵ� Param ��. ����ڵ�.
		String PjNm_tr_Cnt = StringUtil.nvl(request.getParameter("PjNm_tr_Cnt"),"0");	//�θ�â���� ���� ����ڵ� Param ��. ������Ʈ��.
		
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		
		//���� ���� �� �ʱ�ȭ��
		if(USERID.equals("")){ String rtnUrl =
		request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.

		//ProjectDAO pjDao = new ProjectDAO();
		ContractManageDTO cmDto = new ContractManageDTO();
		ContractManageDAO cmDao = new ContractManageDAO();

		// cmDto ��ü ����.
		cmDto.setChUserID(USERID);
		cmDto.setvSearchType(searchGb);
		cmDto.setSearchGb2("");
		cmDto.setvSearch(searchtxt);
		cmDto.setnRow(10);
		cmDto.setnPage(curPageCnt);
		cmDto.setJobGb("PAGE");

		ListDTO ld = cmDao.contractMgPageList_Pop_Pj(cmDto);
		
		// �𵨰�ü ����
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("sForm",sForm);
		model.put("CtCd_tr_Cnt",CtCd_tr_Cnt); //�θ�â���� ���� tr Cnt(��ġ,Param ��)
		model.put("PjNm_tr_Cnt",PjNm_tr_Cnt); //�θ�â���� ���� tr Cnt(��ġ,Param ��)
		
		return actionMapping.findForward("searchContractNoConN_Pj");
	}
	
	/**
=======
     * �����ȣ�� �˻��Ѵ�(��� �� �Ǹ�/������ �뵵.).
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward searchPublicNoConY_Cm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String contractGb = StringUtil.nvl(request.getParameter("contractGb"),"Y");
			
		EstimateDAO estimateDao = new EstimateDAO();

		ListDTO ld = estimateDao.estimatePageListPopConY_CM(curPageCnt, searchGb,contractGb, searchtxt,10, 10);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("contractGb",contractGb);
		model.put("searchtxt",searchtxt);
		 
        return actionMapping.findForward("searchPublicNoConY_Cm"); 
	}
	
	/**
>>>>>>> .r596
     * ����� ��Ϲ�ȣ�� �˻��Ѵ�.
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward searchCompNoOld(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"B");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"--");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			
		CompanyDAO companyDao = new CompanyDAO();

		ListDTO ld = companyDao.companyPageListPop(curPageCnt, searchGb, searchtxt ,"ALL","Y",10, 10);

		model.put("listInfo",ld);	
		
		model.put("sForm",sForm);
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);	
		 
        return actionMapping.findForward("compnolist"); 
	}
	/**
	 * ����� ��Ϲ�ȣ�� �˻��ϰ� ������ ����� �̸� , ������������ �����Ѵ�..
	 * +�������� �߰�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param httpServletResponse
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward searchCompNo(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String sForm = StringUtil.nvl(request.getParameter("sForm"),""); //companyRegist ,companyView
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"B");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"--");
		String deleteYn = StringUtil.nvl(request.getParameter("deleteYn"),"N");
		
		CompanyDAO companyDao = new CompanyDAO();
		CompanyDTO compDto = new CompanyDTO(); 
		if(deleteYn.equals("Y")) { //�������������߰�
			companyDao.deleteCompanyOne2(searchtxt);
		}
		String checkComp = "Y";
		//�����ϴ� ���ϴ�. �˻��� �ٽ� �Ѵ�.  �˻��Ǽ��� �մٸ� ȭ�鿡�� �ִٰ� �����ְ� ������ư�� Ȱ��ȭ�Ѵ�.
		if(!searchtxt.equals("--")) {
			compDto = companyDao.getCompanyView2(searchtxt ); 	
		}else {
			compDto = null;
		}
		
	    if(compDto == null){
			checkComp = "N";
	    }
	    

		model.put("checkComp",checkComp); //���� ���� ����	
	    model.put("compDto", compDto);
		
		model.put("sForm",sForm);
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);	
		
		return actionMapping.findForward("compnolist"); 
	}
	/**
     * ��ü �������� �����ش�.
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward companyView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String comp_code = "";  //��ü�ڵ�
		
		comp_code = StringUtil.nvl(request.getParameter("comp_code"));
		
		CompanyDAO compDao = new CompanyDAO();
		CompanyDTO compDto = new CompanyDTO(); 
		
		compDto = compDao.getCompanyView(comp_code ); 	
		
	    model.put("compDto", compDto);
	    
		model.put("comp_code",comp_code);

	    if(compDto == null){
			String msg = "�ش�  ��ü  ������ �����ϴ�.";
			return alertAndExit(model, msg,"","back");
	    }else{
	    	return actionMapping.findForward("companyView");
		}
	}
	
	/**
	 * 2013_03_26(ȭ)shbyeon.
	 * ��ü��  �ߺ�üũ(����������Ȳ ���.)
	 */
	public ActionForward CompNameCheck(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String CompName_Dup = StringUtil.nvl(
				request.getParameter("e_comp_nm"), "");
		System.out.println("CompName_Dup:"+CompName_Dup);

		CurrentStatusDAO csDao = new CurrentStatusDAO();
		CurrentStatusDTO csDto = new CurrentStatusDTO();

		csDto.setEnterpriseNm(CompName_Dup);
		System.out.println("Enter:"+CompName_Dup);

		String result = csDao.compNameCheck(csDto);

		model.put("result", result);

		return actionMapping.findForward("compNameChkXML");
		//������ struts.XMLŸ�� ������ �¿��ִ� ����(acNumberChkXML)  return actionMapping.findForward("acNumberChkXML");
	}
	
	/**
	 * 2013_03_26(ȭ)shbyeon.
	 * ��ü��  �ߺ�üũ(���������� ���.)
	 */
	public ActionForward CompNameCheckEs(ActionMapping actionMapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response, Map model) throws Exception {

		String CompName_Dup = StringUtil.nvl(
				request.getParameter("e_comp_nm"), "");
		System.out.println("CompName_Dup:"+CompName_Dup);

		EstimateDAO esDao = new EstimateDAO();
		EstimateDTO esDto = new EstimateDTO();

		esDto.setE_comp_nm(CompName_Dup);
		System.out.println("Enter:"+CompName_Dup);

		String result = esDao.compNameCheckEs(esDto);

		model.put("result", result);

		return actionMapping.findForward("compNameChkXML");
		//������ struts.XMLŸ�� ������ �¿��ִ� ����(acNumberChkXML)  return actionMapping.findForward("acNumberChkXML");
	}
	
	/**
	 * Group �������� �����´�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward groupFrame(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//Group �������� �����´�.
		
		return actionMapping.findForward("groupFrame");
	}
	/**
	 * Group ����Ʈ�� �����´�.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward groupTree(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//log action execute time start
		String logid=log.logid();
		long t1 = System.currentTimeMillis();
		log.trace(logid, "groupTree action start");
		
		String groupID = StringUtil.nvl(request.getParameter("GroupID"),"G00001");
		int groupStep = StringUtil.nvl(request.getParameter("GroupStep"),0);

		GroupDAO groupDao = new GroupDAO();
		GroupDTO groupDto = new GroupDTO();
		groupDto.setLogid(logid);
		groupDto.setGroupID(groupID);
		groupDto.setGroupStep(groupStep);
		groupDto.setJobGb("LIST");
		
		ArrayList<GroupDTO> grouplist =groupDao.groupTreeList(groupDto);
		
		model.put("grouplist",grouplist);
		model.put("GroupID",groupID);
		model.put("GroupStep",""+groupStep);
		
		//log action execute time end
		long t2 = System.currentTimeMillis();
		log.trace(logid, "groupTree action end execute time:[" + (t2-t1)/1000.0 + "] seconds");
		
		return actionMapping.findForward("groupTree");
	}
	/**
	 * ���������� (�������/��������/������/�����Խ���/News&Magazine/�����޴���)6���� �Խ��� ��Ͽ� �ִ� �Խñ��� �����´�._2012_10_24_(bsh)
	 */
	public ActionForward mainPage(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String AuthID = StringUtil.nvl(request.getParameter("AuthID"), "");
		String MenuID = StringUtil.nvl(request.getParameter("MenuID"),"");
		// �α��� ó��
		String USERID = UserBroker.getUserId(request);
		
		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //�α��� ó�� ��.
	
		  //���� ������ ����Ʈ ���� ����(���������� 6���� ��� ������ ����üũ)2012_10_24(��)bsh
		  AuthDTO atDto = new AuthDTO();
		  AuthDAO atDao = new AuthDAO();
		  MenuDTO mtDto = new MenuDTO();
		  
		  atDto.setUserID(USERID);
		  System.out.println("setChUserID::"+USERID);
		  mtDto.setAuthID(AuthID);
		  System.out.println("setChAuthID::"+AuthID);
		  //atDto.setMenuID(atDto.getMenuID());
		  //System.out.println("setCMenuID::ActionSET::"+atDto.getMenuID());
		  ArrayList<AuthDTO> arraylist= atDao.userAuthMenuTreeView(atDto);
		

		//�������  
		DispNotifyDAO disDao = new DispNotifyDAO();
		DispNotifyDTO disDto = new DispNotifyDTO();
		// ����Ʈ
		disDto.setWriteUser(USERID);
		disDto.setvSearchType(searchGb);
		disDto.setvSearch(searchtxt);
		disDto.setnRow(7);
		disDto.setnPage(curPageCnt);
		ListDTO ld = disDao.dispNotifyPageList(disDto);
		
		//��������
		FormFileDAO ffDao = new FormFileDAO();
		FormFileDTO ffDto = new FormFileDTO();
		// ����Ʈ
		//ffDto.setWriteUser(USERID);
		ffDto.setvSearchType(searchGb);
		ffDto.setvSearch(searchtxt);
		ffDto.setnRow(7);
		ffDto.setnPage(curPageCnt);
		ListDTO ld2 = ffDao.formFilePageList(ffDto);
		
		//������
		FamilyEventDAO feDao = new FamilyEventDAO();
		FamilyEventDTO feDto = new FamilyEventDTO();
		// ����Ʈ
		feDto.setWriteUser(USERID);
		feDto.setvSearchType(searchGb);
		feDto.setvSearch(searchtxt);
		feDto.setnRow(7);
		feDto.setnPage(curPageCnt);
		ListDTO ld3 = feDao.dispEventPageList(feDto);
		
		//�����Խ���
		FreeBoardDAO fbDao = new FreeBoardDAO();
		FreeBoardDTO fbDto = new FreeBoardDTO();
		// ����Ʈ
		fbDto.setWriteUser(USERID);
		fbDto.setvSearchType(searchGb);
		fbDto.setvSearch(searchtxt);
		fbDto.setnRow(7);
		fbDto.setnPage(curPageCnt);
		ListDTO ld4 = fbDao.BoardPageList(fbDto);
		
		//News&Magazine
		NewsMagazineDTO nmDto = new NewsMagazineDTO();
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		
		//����Ʈ
		nmDto.setWriteUser(USERID);
		nmDto.setvSearchType(searchGb);
		nmDto.setvSearch(searchtxt);
		nmDto.setnRow(7);
		nmDto.setnPage(curPageCnt);
		ListDTO ld5 = nmDao.dispNewsPageList(nmDto);
		
		//����Menual ����Ʈ
		DocumentFileDAO dfDao = new DocumentFileDAO();
		DocumentFileDTO dfDto = new DocumentFileDTO();

		// ����Ʈ
		
		//dfDto.setWriteUser(USERID);
		dfDto.setvSearchType(searchGb);
		dfDto.setvSearch(searchtxt);
		dfDto.setnRow(7);
		dfDto.setnPage(curPageCnt);
		ListDTO ld6 = dfDao.documentFilePageList(dfDto);

		model.put("listInfo", ld);   //�������
		model.put("listInfo2", ld2); //��������
		model.put("listInfo3", ld3); //������
		model.put("listInfo4", ld4); //�����Խ���
		model.put("listInfo5", ld5); //News&Magazine
		model.put("listInfo6", ld6); //����Menual
		model.put("arraylist",arraylist);
		model.put("MenuID", MenuID);
		model.put("AuthID", AuthID);
		model.put("mtDto", mtDto);
		model.put("atDto", atDto);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
		return actionMapping.findForward("mainPage");
	}
}