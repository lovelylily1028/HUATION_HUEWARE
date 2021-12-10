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

//게시판 관련 DTO/DAO
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
	 * 공통 사용업무 관련 처리
	 */
	public CommonAction() {
		super();
		// TODO Auto-generated constructor stub
	}

    /**
     * 도로명 우편번호를 검색한다.
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
     * 기존 주소 우편번호를 검색한다.
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
     * 업체정보를 검색한다.
     * 2013_03_22(금) shbyeon.
     * complist.jsp 호출용 (사업자 등록번호 Permit_no 있는 데이터만 검색)
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
     * 업체정보를 검색한다.(세금계산서 용도)
     * 2013_03_22(금) shbyeon.
     * complist_Ic.jsp 호출용 (사업자 등록번호 Permit_no 있는 데이터만 검색)
     * COMP_CODE , PERMIT_NO 넘기기위해.
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
     * 사원정보를 검색한다.
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
     * 사원정보를 검색한다.
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
     * 사원정보를 검색한다. 별도 두번째 팝업창
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
     * 영업진행현황을 검색한다.(견적서 최초 발행용.)
     * 2013_04_16(화) shbyeon.
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
		String searchGbYear = StringUtil.nvl(request.getParameter("searchGbYear"), ""); //검색구분 (년도)
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), ""); //검색구분 (영업상태)
		String searchGb2 = StringUtil.nvl(request.getParameter("searchGb2"), ""); //검색구분 (목록)
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), ""); //검색명
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		
			
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
     * 발행번호를 검색한다.(견적서 발행용.)
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
     * 발행번호를 검색한다(계약 된 건만/세금계산서 발행용.).
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
	// 로그인 처리
	String USERID = UserBroker.getUserId(request);
	
	//세션 끊길 시 초기화면
	if(USERID.equals("")){ String rtnUrl =
	request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
	goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
*/
	//ProjectDAO pjDao = new ProjectDAO();
	ContractManageDTO cmDto = new ContractManageDTO();
	ContractManageDAO cmDao = new ContractManageDAO();

	// cmDto 객체 셋팅.
	/*cmDto.setChUserID(USERID);*/
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
	model.put("sForm",sForm);
	
	return actionMapping.findForward("searchContractNoConY_baro");
}
	
	
	/**
     * 발행번호를 검색한다(계약된 견적서 건 만/프로젝트 코드 관리 용도.).
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
	 * CreateDate:2013-12-27(금) Writer:shbyeon.
	 * 계약관리 조회 리스트(진행중인 건에 대해서만/프로젝트 코드 관리 팝업 조회 용도.)
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
		
		String CtCd_tr_Cnt = StringUtil.nvl(request.getParameter("CtCd_tr_Cnt"),"0");	//부모창에서 받은 계약코드 Param 값. 계약코드.
		String PjNm_tr_Cnt = StringUtil.nvl(request.getParameter("PjNm_tr_Cnt"),"0");	//부모창에서 받은 계약코드 Param 값. 프로젝트명.
		
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
		cmDto.setSearchGb2("");
		cmDto.setvSearch(searchtxt);
		cmDto.setnRow(10);
		cmDto.setnPage(curPageCnt);
		cmDto.setJobGb("PAGE");

		ListDTO ld = cmDao.contractMgPageList_Pop_Pj(cmDto);
		
		// 모델객체 셋팅
		model.put("listInfo", ld);
		model.put("curPage", String.valueOf(curPageCnt));
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		model.put("sForm",sForm);
		model.put("CtCd_tr_Cnt",CtCd_tr_Cnt); //부모창에서 받은 tr Cnt(위치,Param 값)
		model.put("PjNm_tr_Cnt",PjNm_tr_Cnt); //부모창에서 받은 tr Cnt(위치,Param 값)
		
		return actionMapping.findForward("searchContractNoConN_Pj");
	}
	
	/**
=======
     * 발행번호를 검색한다(계약 된 건만/계약관리 용도.).
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
     * 사업자 등록번호를 검색한다.
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
	 * 사업자 등록번호를 검색하고 갯수와 사업자 이름 , 삭제유무를을 리턴한다..
	 * +완전삭제 추가.
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
		if(deleteYn.equals("Y")) { //완전삭제로직추가
			companyDao.deleteCompanyOne2(searchtxt);
		}
		String checkComp = "Y";
		//삭제하던 안하던. 검색을 다시 한다.  검색건수가 잇다면 화면에서 있다고 보여주고 삭제버튼을 활성화한다.
		if(!searchtxt.equals("--")) {
			compDto = companyDao.getCompanyView2(searchtxt ); 	
		}else {
			compDto = null;
		}
		
	    if(compDto == null){
			checkComp = "N";
	    }
	    

		model.put("checkComp",checkComp); //기존 존재 여부	
	    model.put("compDto", compDto);
		
		model.put("sForm",sForm);
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);	
		
		return actionMapping.findForward("compnolist"); 
	}
	/**
     * 업체 상세정보를 보여준다.
     * @param actionMapping
     * @param actionForm
     * @param request
     * @param httpServletResponse
     * @param model
     * @return
     * @throws Exception
     */
	public ActionForward companyView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
		
		String comp_code = "";  //업체코드
		
		comp_code = StringUtil.nvl(request.getParameter("comp_code"));
		
		CompanyDAO compDao = new CompanyDAO();
		CompanyDTO compDto = new CompanyDTO(); 
		
		compDto = compDao.getCompanyView(comp_code ); 	
		
	    model.put("compDto", compDto);
	    
		model.put("comp_code",comp_code);

	    if(compDto == null){
			String msg = "해당  업체  정보가 없습니다.";
			return alertAndExit(model, msg,"","back");
	    }else{
	    	return actionMapping.findForward("companyView");
		}
	}
	
	/**
	 * 2013_03_26(화)shbyeon.
	 * 업체명  중복체크(영업진행현황 사용.)
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
		//실제로 struts.XML타고 포워딩 태워주는 네임(acNumberChkXML)  return actionMapping.findForward("acNumberChkXML");
	}
	
	/**
	 * 2013_03_26(화)shbyeon.
	 * 업체명  중복체크(견적서발행 사용.)
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
		//실제로 struts.XML타고 포워딩 태워주는 네임(acNumberChkXML)  return actionMapping.findForward("acNumberChkXML");
	}
	
	/**
	 * Group 프레임을 가져온다.
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public ActionForward groupFrame(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		//Group 프레임을 가져온다.
		
		return actionMapping.findForward("groupFrame");
	}
	/**
	 * Group 리스트를 가져온다.
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
	 * 메인페이지 (전사공지/서식파일/경조사/자유게시판/News&Magazine/업무메뉴얼)6개의 게시판 목록에 있는 게시글을 가져온다._2012_10_24_(bsh)
	 */
	public ActionForward mainPage(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"), "");
		String searchtxt = StringUtil
				.nvl(request.getParameter("searchtxt"), "");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"), 1);
		String AuthID = StringUtil.nvl(request.getParameter("AuthID"), "");
		String MenuID = StringUtil.nvl(request.getParameter("MenuID"),"");
		// 로그인 처리
		String USERID = UserBroker.getUserId(request);
		
		  if(USERID.equals("")){ String rtnUrl =
		  request.getContextPath()+"/H_Login.do?cmd=loginForm"; return
		  goSessionOut(model, rtnUrl,"huation-sessionOut"); } //로그인 처리 끝.
	
		  //메인 페이지 리스트 권한 여부(메인페이지 6개의 목록 프레임 권한체크)2012_10_24(수)bsh
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
		

		//전사공지  
		DispNotifyDAO disDao = new DispNotifyDAO();
		DispNotifyDTO disDto = new DispNotifyDTO();
		// 리스트
		disDto.setWriteUser(USERID);
		disDto.setvSearchType(searchGb);
		disDto.setvSearch(searchtxt);
		disDto.setnRow(7);
		disDto.setnPage(curPageCnt);
		ListDTO ld = disDao.dispNotifyPageList(disDto);
		
		//서식파일
		FormFileDAO ffDao = new FormFileDAO();
		FormFileDTO ffDto = new FormFileDTO();
		// 리스트
		//ffDto.setWriteUser(USERID);
		ffDto.setvSearchType(searchGb);
		ffDto.setvSearch(searchtxt);
		ffDto.setnRow(7);
		ffDto.setnPage(curPageCnt);
		ListDTO ld2 = ffDao.formFilePageList(ffDto);
		
		//경조사
		FamilyEventDAO feDao = new FamilyEventDAO();
		FamilyEventDTO feDto = new FamilyEventDTO();
		// 리스트
		feDto.setWriteUser(USERID);
		feDto.setvSearchType(searchGb);
		feDto.setvSearch(searchtxt);
		feDto.setnRow(7);
		feDto.setnPage(curPageCnt);
		ListDTO ld3 = feDao.dispEventPageList(feDto);
		
		//자유게시판
		FreeBoardDAO fbDao = new FreeBoardDAO();
		FreeBoardDTO fbDto = new FreeBoardDTO();
		// 리스트
		fbDto.setWriteUser(USERID);
		fbDto.setvSearchType(searchGb);
		fbDto.setvSearch(searchtxt);
		fbDto.setnRow(7);
		fbDto.setnPage(curPageCnt);
		ListDTO ld4 = fbDao.BoardPageList(fbDto);
		
		//News&Magazine
		NewsMagazineDTO nmDto = new NewsMagazineDTO();
		NewsMagazineDAO nmDao = new NewsMagazineDAO();
		
		//리스트
		nmDto.setWriteUser(USERID);
		nmDto.setvSearchType(searchGb);
		nmDto.setvSearch(searchtxt);
		nmDto.setnRow(7);
		nmDto.setnPage(curPageCnt);
		ListDTO ld5 = nmDao.dispNewsPageList(nmDto);
		
		//업무Menual 리스트
		DocumentFileDAO dfDao = new DocumentFileDAO();
		DocumentFileDTO dfDto = new DocumentFileDTO();

		// 리스트
		
		//dfDto.setWriteUser(USERID);
		dfDto.setvSearchType(searchGb);
		dfDto.setvSearch(searchtxt);
		dfDto.setnRow(7);
		dfDto.setnPage(curPageCnt);
		ListDTO ld6 = dfDao.documentFilePageList(dfDto);

		model.put("listInfo", ld);   //전사공지
		model.put("listInfo2", ld2); //서식파일
		model.put("listInfo3", ld3); //경조사
		model.put("listInfo4", ld4); //자유게시판
		model.put("listInfo5", ld5); //News&Magazine
		model.put("listInfo6", ld6); //업무Menual
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