package com.huation.hueware.estimate.action;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huation.common.CommonDAO;
import com.huation.common.util.DateSetter;
import com.huation.common.BaseDAO;
import com.huation.framework.persist.DAOException;
import com.huation.framework.util.DateTimeUtil;
import com.huation.framework.util.FileUtil;
import com.huation.framework.util.HtmlXSSFilter;
import com.huation.framework.util.SiteNavigation;
import com.huation.framework.util.UploadFile;
import com.huation.framework.util.UploadFiles;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.util.InJectionFilter;
import com.huation.framework.Constants;
import com.huation.framework.util.StringUtil;
import com.huation.framework.struts.StrutsDispatchAction;

import com.huation.common.user.UserBroker;
import com.huation.common.util.CommonUtil;
import com.huation.common.util.DateUtil;
import com.huation.common.user.UserMemDTO;
import com.huation.common.user.UserConnectDTO;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;

import com.huation.common.company.CompanyDAO;
import com.huation.common.company.CompanyDTO;
import com.huation.common.currentstatus.CurrentStatusDAO;
import com.huation.common.currentstatus.CurrentStatusDTO;
import com.huation.common.estimate.EstimateDAO;
import com.huation.common.estimate.EstimateDTO;
import com.huation.common.contractmanage.ContractManageDAO;
import com.huation.common.contractmanage.ContractManageDTO;

import com.huation.common.invoice.InvoiceDAO;
import com.huation.common.invoice.InvoiceDTO;
import com.oreilly.servlet.MultipartRequest;

public class EstimateAction extends StrutsDispatchAction{
		/**
		 * 견적서 리스트
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward estimatePageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
				String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String contractGb = StringUtil.nvl(request.getParameter("contractGb"),"ALL");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
			String EsStartDate = StringUtil.nvl(request.getParameter("EsStartDate"),DateUtil.getDayInterval3(-365));
			System.out.println("EsStartDate:"+EsStartDate);
			String EsEndDate = StringUtil.nvl(request.getParameter("EsEndDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),""));
			System.out.println("EsEndDate:"+EsEndDate);
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String type = StringUtil.nvl(request.getParameter("type"),"reg");
				
			EstimateDAO estimateDao = new EstimateDAO();

			ListDTO ld = estimateDao.estimatePageList(curPageCnt, searchGb, contractGb, searchtxt,EsStartDate,EsEndDate, 10, 10, type , USERID);

			model.put("listInfo",ld);	
			
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("searchGb",searchGb);
			model.put("contractGb",contractGb);
			model.put("searchtxt",searchtxt);
			model.put("EsStartDate", EsStartDate);
			model.put("EsEndDate", EsEndDate);
			model.put("type", type);
			
			
			return actionMapping.findForward("estimatePageList");
			
		}
		
		/**
		 * 견적서 리스트
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward estimatePageList2(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
//			로그인 처리 
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
					String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
// 			로그인 처리 끝.
			
			MultipartRequest multipartRequest = null;
			
			String FilePath = FileUtil.FILE_DIR+"estimate/"+DateTimeUtil.getDate()+"/";
			String uploadFilePath="";
				log.debug("FilePath= "+FilePath);
			UploadFiles uploadEntity = FileUtil.upload(request, FilePath,USERID, 10);
	     	multipartRequest = uploadEntity.getMultipart();
			
			String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"),"");
			String contractGb = StringUtil.nvl(multipartRequest.getParameter("contractGb"),"ALL");
			String searchtxt = StringUtil.nvl(multipartRequest.getParameter("searchtxt"),"");
			String type = StringUtil.nvl(multipartRequest.getParameter("type"),"reg");
			//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
			String EsStartDate = StringUtil.nvl(multipartRequest.getParameter("EsStartDate"),DateUtil.getDayInterval3(-365));
			System.out.println("EsStartDate:"+EsStartDate);
			String EsEndDate = StringUtil.nvl(multipartRequest.getParameter("EsEndDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),""));
			System.out.println("EsEndDate:"+EsEndDate);
			int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"),1);
			
			
			EstimateDAO estimateDao = new EstimateDAO();

			ListDTO ld = estimateDao.estimatePageList(curPageCnt, searchGb, contractGb, searchtxt,EsStartDate,EsEndDate, 10, 10, type , USERID);
			model.put("listInfo",ld);	
			
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("searchGb",searchGb);
			model.put("contractGb",contractGb);
			model.put("searchtxt",searchtxt);
			model.put("EsStartDate", EsStartDate);
			model.put("EsEndDate", EsEndDate);
			model.put("type",type);
			
			return actionMapping.findForward("estimatePageList");
		}
		
		
		/**
		 * 견적서 등록폼
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward estimateRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			String type = StringUtil.nvl(request.getParameter("type"),"");

//			로그인 처리 
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
					String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
// 			로그인 처리 끝.
			
			CommonDAO comDao = new CommonDAO();
			String curDate = comDao.getCurrentDate();
			DateSetter dateSetter = new DateSetter( curDate , "99991231" );
			
			//2013_04_24(수) shbyeon. 상품코드 Array 추가.
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
		   	
			
		   	model.put("codeList", codeList); 
		   	model.put("codeList2", codeList2);
		   	model.put("codeList3", codeList3);
			model.put("curDate", curDate );
			model.put("dateSetter", dateSetter );
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("searchGb",searchGb);
			model.put("searchtxt",searchtxt);
			model.put("type",type);
	
			return actionMapping.findForward("estimateRegistForm");
		}
		/**
		 * 견적서 등록처리
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 * @description : 2013-11-04 shbyeon. 견적서 등록처리 방법 UPDATE 됨.
		 */
		public ActionForward estimateRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
//			로그인 처리 
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
					String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			// 로그인 처리 끝.
			
			String msg = "";
			int retVal = 0;
			int retVal_cs = 0; //영업진행현황 등록 결과 값
			int retVal_ProductDel = 0;
			
			MultipartRequest multipartRequest = null;
			
			String objName = "";
			String rFileName = "";
			String sFileName = "";
			String filePath = "";
			String fileSize = "";		
			String sImageName = "";
			String FilePath = FileUtil.FILE_DIR+"estimate/"+DateTimeUtil.getDate()+"/";
			String uploadFilePath="";
				log.debug("FilePath= "+FilePath);
			UploadFiles uploadEntity = FileUtil.upload(request, FilePath,USERID, 10);
	     	multipartRequest = uploadEntity.getMultipart();
			String status = uploadEntity.getStatus();
			
			String estimate_e_file="";
			String estimate_p_file="";
			
			if (status.equals("E")){ 
				log.debug("첨부 파일 올리려다 실패하였습니다.");
				msg = "첨부 파일 올리려다 실패하였습니다.";	
		        return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");	
		        
			}else if (status.equals("O")){ 
				log.debug("첨부하신 파일이 용량을 초과했습니다.");
				msg = "첨부하신 파일이 용량을 초과했습니다.최대 10M 까지 가능합니다.";	
		        return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");	
				    
			}else if (status.equals("I")){
				log.debug("첨부 파일의 정보가 잘못되었습니다.");
				msg = "첨부 파일의 정보가 잘못되었습니다.";	
		        return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");	
				
			}else if(status.equals("S")){
				// 업로드된 파일의 정보를 가져와서 데이터 베이스에 넣는 작업을 해준다.
				log.debug("첨부 파일을 첨부하는데 성공하였습니다.");
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

						log.debug("파일 오브젝트명["+ objName + "]원파일명["+rFileName+"]저장파일명["+sFileName+"]파일사이즈["+fileSize+"]저장파일패스["+filePath+"]업로드 경로["+uploadFilePath+"]");

						if(objName.equals("estimate_e_file")){
							estimate_e_file=uploadFilePath;
						}else if(objName.equals("estimate_p_file")){
							estimate_p_file=uploadFilePath;
						}  
							
					}
				}
		}
			
			int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"),1);  
			String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(multipartRequest.getParameter("searchtxt"),"");
			String type = StringUtil.nvl(multipartRequest.getParameter("type"),"");
			
			String pubPre= "QU";  
			String pubNo="";
			String public_no="";
				
			//2013_04_27(토)shbyeon. 추가
			String PROJECT_PK_CODE= StringUtil.nvl(multipartRequest.getParameter("PROJECT_PK_CODE"),"");
			
			String p_public_no= StringUtil.nvl(multipartRequest.getParameter("p_public_no"),"");    	
			String estimate_dt= StringUtil.nvl(multipartRequest.getParameter("estimate_dt"),"");    	
			String comp_code= StringUtil.nvl(multipartRequest.getParameter("comp_code"),"");    	
			String receiver= StringUtil.nvl(multipartRequest.getParameter("receiver"),"");    	
			String title= StringUtil.nvl(multipartRequest.getParameter("title"),"");    	
			String supply_price= StringUtil.nvl(multipartRequest.getParameter("supply_price"),"0");    	
			String vat= StringUtil.nvl(multipartRequest.getParameter("vat"),"0");    	
			String sales_charge= StringUtil.nvl(multipartRequest.getParameter("sales_charge"),"");  
			String etc= StringUtil.nvl(multipartRequest.getParameter("etc"),""); 
			String e_comp_nm= StringUtil.nvl(multipartRequest.getParameter("e_comp_nm"),"");
			String productno= StringUtil.nvl(multipartRequest.getParameter("productno"),""); 
			String d_public_yn= StringUtil.nvl(multipartRequest.getParameter("d_public_yn"),""); 
			String orderble= StringUtil.nvl(multipartRequest.getParameter("orderble"),""); 
			String contract_yn= StringUtil.nvl(multipartRequest.getParameter("contract_yn"),"");

			String salescurrent_yn= StringUtil.nvl(multipartRequest.getParameter("SalesCurrentYn"),"");

			String ESTIMATE_E_FILENM= StringUtil.nvl(multipartRequest.getParameter("ESTIMATE_E_FILENM"),"");
			String ESTIMATE_P_FILENM= StringUtil.nvl(multipartRequest.getParameter("ESTIMATE_P_FILENM"),"");
			String checkyn= StringUtil.nvl(multipartRequest.getParameter("checkyn"),"");
			
			//견적서 경유매출 옵션으로인한 추가 파라미터 2013-11-19(화)shbyeon.
			String IndirectSalesYN= StringUtil.nvl(multipartRequest.getParameter("IndirectSalesYN"),"");
			String Purchase= StringUtil.nvl(multipartRequest.getParameter("Purchase"),"");
			String Sales_profit= StringUtil.nvl(multipartRequest.getParameter("Sales_profit"),"");
			String Profit_percent= StringUtil.nvl(multipartRequest.getParameter("Profit_percent"),"");
			
			
			//아래 파라미터 견적서 즉시발행 시(견적서 발행+영업진행현황 등록을 위해 추가함.2013_11_04)
			//최종적으로 셋팅해서 DB Insert 시키는 매핑 정보는 아래 nowPubRegist(즉시발행=3) 셋팅 해주는 부분에 주석 처리되있음.
			String nowPubRegist = StringUtil.nvl(multipartRequest.getParameter("nowPubRegist"),"");
			int Quarter = StringUtil.nvl(multipartRequest.getParameter("Quarter"),0);
			String OperatingCompany = StringUtil.nvl(multipartRequest.getParameter("OperatingCompany"),"");
			String SalesMan = StringUtil.nvl(multipartRequest.getParameter("SalesMan"),"");
			String SalesManTel = StringUtil.nvl(multipartRequest.getParameter("SalesManTel"),"");
			String salesProjections = StringUtil.nvl(multipartRequest.getParameter("salesProjections"),"");
			String ChargeSecondID = StringUtil.nvl(multipartRequest.getParameter("ChargeSecondID"),"");
			String AssignPerson = StringUtil.nvl(multipartRequest.getParameter("AssignPerson"),"");
			String DateProjections = StringUtil.nvl(multipartRequest.getParameter("DateProjections"),"");
			
			//아래 파리미터 영업진행현황 초기 조회 견적발행이 아닌 영업진행현황 조회 재 발행 일 경우 받는 값.
			String public_no_retry = StringUtil.nvl(multipartRequest.getParameter("public_no_retry"),"");
			
			//매출구분 생성으로 인한 구분값 파라미터.
			String SalesSort = StringUtil.nvl(multipartRequest.getParameter("SalesSort"),"");

			
			EstimateDAO estimateDao = new EstimateDAO();
			EstimateDTO estimateDto = new EstimateDTO(); 
			
			//2013_04_27(토) shbyeon. 추가 (영업진행현황메뉴와 견적서 메뉴 연동을위해.)
			CurrentStatusDAO csDao = new CurrentStatusDAO();
			CurrentStatusDTO csDto = new CurrentStatusDTO();
			
			/*
			//2013-11-22(금) shbyeon. 추가(계약관리메뉴와 견적서 메뉴 연동을위해.)
			ContractManageDAO cmDAo = new ContractManageDAO();
			ContractManageDTO cmDto = new ContractManageDTO();
			*/
			
			//pubPre=pubPre+DateUtil.getCurrentDate("yyMMdd");
			pubPre=pubPre+estimate_dt.substring(2);
			log.debug("[pubPre] : " + pubPre);

			pubNo=estimateDao.getPubCntNext(pubPre);
			log.debug("[pubNo]" + pubPre);
			
			public_no = estimateDao.getPubNo(pubPre,pubNo);
			
			log.debug("[public_no]" + public_no);
			
			if(public_no.equals("MAX")){
				msg = "견적서 발행코드 생성오류 [100건 이상인경우]";			
		        return alertAndExit(model,msg,request.getContextPath()+"/B_Estimate.do?cmd=estimatePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt+"&type="+type,"back");	
			}
			
			/*2013_04_26(금)shbyeon.
			 *영업진행현황 조회 등록 or 최초 견적서 발행 or 모 발행번호 조회 등록 일 경우. 
			 */
			
			if(nowPubRegist.equals("")){
				
				log.debug("[(영업/최초/모발행/)견적서 발행 Public_No 번호 생성 (년/월/일 현재 DB Max값으로 가져온 코드):["+public_no+"] action..견적서 발행]");
				log.debug("[(영업/최초/모발행/)견적서 발행 영업진행현황 PreSalesCode 코드 생성 (현재 DB에서 Max값으로 가져온 코드, 단 영업진행현황 매핑 등록 아닐시 빈값!):["+nowPubRegist+"] action..견적서 발행]");
				
				estimateDto.setPROJECT_PK_CODE(PROJECT_PK_CODE);
				estimateDto.setPublic_no(public_no);
				estimateDto.setP_public_no(p_public_no);
				estimateDto.setEstimate_dt(estimate_dt);
				estimateDto.setComp_code(comp_code);
				estimateDto.setReceiver(receiver);
				estimateDto.setTitle(title);
				estimateDto.setSupply_price(supply_price);
				estimateDto.setVat(vat);
				estimateDto.setReg_id(USERID);
				estimateDto.setSales_charge(sales_charge);
				estimateDto.setEtc(etc);
				estimateDto.setE_comp_nm(e_comp_nm);
				estimateDto.setProductno(productno);
				estimateDto.setD_public_yn(d_public_yn);
				estimateDto.setOrderble(orderble);
				estimateDto.setEstimate_e_file(estimate_e_file);
				estimateDto.setEstimate_p_file(estimate_p_file);
				estimateDto.setContract_yn(contract_yn);
				estimateDto.setSalescurrent_yn(salescurrent_yn);
				estimateDto.setESTIMATE_E_FILENM(ESTIMATE_E_FILENM);
				estimateDto.setESTIMATE_P_FILENM(ESTIMATE_P_FILENM);
				estimateDto.setCheckyn(checkyn);
				estimateDto.setIndirectSalesYN(IndirectSalesYN);
				estimateDto.setPurchase(Purchase);
				estimateDto.setSales_profit(Sales_profit);
				estimateDto.setProfit_percent(Profit_percent);
				estimateDto.setSalesSort(SalesSort);
				
				
				retVal=estimateDao.addEstimate(estimateDto);
				log.debug("[(영업/최초/모발행/)견적서발행 DB=T_ESTIMATE Insert Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal+"] action..견적서 발행]");
				
				/**
				//계약관리 연동 Loop 시작. 2013_12_13 shbyeon. 요청으로 인해 사용안함.
				
				log.debug("[견적서 계약 여부 Check Loop Start...]");
				log.debug("[견적서 발행 계약여부 : Y = 계약, N = 미계약..............실제 계약여부 값:("+estimateDto.getContract_yn()+") 계약인 경우 하위 계약관리 Insert Loop 시작됨. action..견적서 발행]");
				if(retVal == 1 && estimateDto.getContract_yn().equals("Y")){
				log.debug("[계약된 견적서로 판단하여 계약번호 코드 생성 Loop Start!]");
				String CreateCode_CQ = "";	//ContractCode 담을변수
				String CreateCode_Return=""; //ContractCode 리턴받은 변수
				CreateCode_CQ=estimateDao.addcontractRegistCode(CreateCode_Return); //계약관리 코드 Max값으로 Select하는 DAO 호출
				//계약관리번호 99건 이상 생성하려 할때 예외처리.
					if(CreateCode_CQ.equals("MAX")){
						msg = "계약관리 번호 생성오류 [99건 이상 인 경우]";			
				        return alertAndExit(model,msg,request.getContextPath()+"/B_ContractManage.do?cmd=contractMgPageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
					}
				log.debug("[견적서 계약 발행 시 생성된 Public_No 번호(년/월/일 현재 DB Max값으로 가져온 코드):["+public_no+"] action..견적서 계약 발행]");
				log.debug("[견적서 계약 발행 시 계약관리 ContractCode 코드 생성 (현재 DB에서 Max값으로 가져온 코드):["+CreateCode_CQ+"] action..견적서 계약 발행]");
				log.debug("[견적서 계약 발행 시 해당 견적서에 생성된 ContractCode DB(T_ESTIMATE) Insert Start!]");
				//생성한 계약관리 코드 셋팅.
				estimateDto.setContractCode(CreateCode_CQ);
				log.debug("[견적서 계약 발행 시 계약관리 ContractCode 코드번호 셋팅  값["+estimateDto.getContractCode()+"] action..견적서 계약 발행]");
				int retVal_Cm_Code = 0; //계약 코드번호 T_ESTIMATE Insert 성공여부 결과 값 변수.
				retVal_Cm_Code = estimateDao.contractInsertCode(estimateDto);
				//계약 코드 seelct 생성까지햇음. 이제 견적서에 우선 ContractCode 값 Update 시켜주고. 그다음에 계약관리 테이블에 견적서 매핑 정보 끌어와 Insert시켜주는 작업해야됨.
				log.debug("[견적서 계약발행 견적서 계약 코드번호 DB=T_ESTIMATE Insert Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal_Cm_Code+"] action..견적서 계약발행]");
				
					int retVal_Cm_Result = 0; //계약관리 Data Insert 결과 값.
					//계약된 견적서에 해당 계약코드번호 정상적으로 DB Insert �을 경우(결과값:retVal_Cm_Code = 1) 시작 Loop
					if(retVal_Cm_Code == 1){
					//견적서에 등록된 계약코드 번호에 대해서 계약관리에 매핑시켜줄 데이터를 넣는다.	
					cmDto.setContractCode(CreateCode_CQ); 			//계약 코드번호 셋팅.
					cmDto.setPublic_No(public_no);					//계약 견적번호 셋팅.
					cmDto.setContractFile("");						//계약 계약서파일 경로셋팅.(초기 Defualt="공백")
					cmDto.setContractFileNm("");					//계약 계약서파일 명 셋팅.(초기 Default="공백")
					cmDto.setPurchaseOrderFile("");					//발주서 파일 경로 셋팅.(초기 Defualt="공백")
					cmDto.setPurchaseOrderFileNm("");				//발주서 파일 명 셋팅.(초기 Defualt="공백")
					cmDto.setEstimate_E_File(estimate_e_file);		//계약 엑셀 견적서 경로셋팅.
					cmDto.setEstimate_E_FileNm(ESTIMATE_E_FILENM);	//계약 엑셀 견적서 파일명 셋팅.
					cmDto.setEstimate_P_File(estimate_p_file);		//계약 PDF 견적서 경로셋팅.
					cmDto.setEstimate_P_FileNm(ESTIMATE_P_FILENM);	//계약 PDF 견적서 파일명 셋팅.
					cmDto.setOrdering_Organization(e_comp_nm);		//계약 발주처 명 셋팅 = 업체명
					cmDto.setContractName(title);					//계약 계약명 = 프로젝트명
					cmDto.setContractStatus("1");					//계약종결 여부 셋팅(초기에는 1로 셋팅 1="-")
					cmDto.setContractCreateUser(USERID);			//최초등록자 세션 아이디 셋팅.
					retVal_Cm_Result = estimateDao.contractInsertData(cmDto);
					log.debug("[견적서 계약발행 데이터 Insert Success! action.. End 성공 = > Result 값 :["+retVal_Cm_Result+"]");	
					}else{
					log.debug("[견적서 계약발행 데이터 Insert Failed! action.. End 실패 = > Result 값 :["+retVal_Cm_Result+"]");	
					msg = "견적서 발행 계약관리 연동 등록 Error 관리자에게 문의하세요.";	
				    return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");
					}
					//계약된 견적서에 해당 계약코드번호 정상적으로 DB Insert �을 경우(결과값:retVal_Cm_Code = 1) 끝 Loop
	
				log.debug("[견적서 계약 발행 등록 Loop End..]");	
				}else{
				log.debug("[미계약된 견적서로 판단하여 계약번호 코드 생성 Loop Stop! 견적서 발행 관련 처리만 실행함. 계약관리와 연동안함.]");
				log.debug("[견적서 미계약 발행 등록 Loop End..]");	
				}
				//계약관리 연동 Loop 끝. 2013_12_13 shbyeon. 요청으로 인해 사용안함.
				 *
				 */
			}
			//견적서 즉시발행 일 경우 (견적서 최초 등록을 하면서 영업진행현황에도 최초 등록이 됨.)
			if(nowPubRegist.equals("3")){
				String SalesCode = ""; //영업진행현황 새로운 코드 생성 후 담을 변수
				nowPubRegist=estimateDao.addcurrentRegistCode(SalesCode);
				log.debug("[견적서 즉시발행 Public_No 번호 생성 (년/월/일 현재 DB Max값으로 가져온 코드):["+public_no+"] action..견적서 즉시발행]");
				log.debug("[견적서 즉시발행 영업진행현황 PreSalesCode 코드 생성 (현재 DB에서 Max값으로 가져온 코드):["+nowPubRegist+"] action..견적서 즉시발행]");
				
				estimateDto.setPROJECT_PK_CODE(nowPubRegist); //PROJECT_PK_CODE == SalesCode
				estimateDto.setPublic_no(public_no);
				estimateDto.setP_public_no(p_public_no);
				estimateDto.setEstimate_dt(estimate_dt);
				estimateDto.setComp_code(comp_code);
				estimateDto.setReceiver(receiver);
				estimateDto.setTitle(title);
				estimateDto.setSupply_price(supply_price);
				estimateDto.setVat(vat);
				estimateDto.setReg_id(USERID);
				estimateDto.setSales_charge(sales_charge);
				estimateDto.setEtc(etc);
				estimateDto.setE_comp_nm(e_comp_nm);
				estimateDto.setProductno(productno);
				estimateDto.setD_public_yn(d_public_yn);
				estimateDto.setOrderble(orderble);
				estimateDto.setEstimate_e_file(estimate_e_file);
				estimateDto.setEstimate_p_file(estimate_p_file);
				estimateDto.setContract_yn(contract_yn);
				estimateDto.setSalescurrent_yn(salescurrent_yn);
				estimateDto.setESTIMATE_E_FILENM(ESTIMATE_E_FILENM);
				estimateDto.setESTIMATE_P_FILENM(ESTIMATE_P_FILENM);
				estimateDto.setCheckyn(checkyn);
				estimateDto.setIndirectSalesYN(IndirectSalesYN);
				estimateDto.setPurchase(Purchase);
				estimateDto.setSales_profit(Sales_profit);
				estimateDto.setProfit_percent(Profit_percent);
				estimateDto.setSalesSort(SalesSort);
				
				retVal=estimateDao.addEstimate(estimateDto);				
				
				log.debug("[견적서 즉시발행 DB=T_ESTIMATE Insert Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal+"] action..견적서 즉시발행]");
				
				/**
				//계약관리 연동 Loop 시작. 2013_12_13 shbyeon. 요청으로 인해 사용안함.
				log.debug("[견적서 계약 여부 Check Loop Start...]");
				log.debug("[견적서 발행 계약여부 : Y = 계약, N = 미계약..............실제 계약여부 값:("+estimateDto.getContract_yn()+") 계약인 경우 하위 계약관리 Insert Loop 시작됨. action..견적서 발행]");
				if(retVal == 1 && estimateDto.getContract_yn().equals("Y")){
				log.debug("[계약된 견적서로 판단하여 계약번호 코드 생성 Loop Start!]");
				String CreateCode_CQ = "";	//ContractCode 담을변수
				String CreateCode_Return=""; //ContractCode 리턴받은 변수
				CreateCode_CQ=estimateDao.addcontractRegistCode(CreateCode_Return); //계약관리 코드 Max값으로 Select하는 DAO 호출
				//계약관리번호 99건 이상 생성하려 할때 예외처리.
					if(CreateCode_CQ.equals("MAX")){
						msg = "계약관리 번호 생성오류 [99건 이상 인 경우]";			
				        return alertAndExit(model,msg,request.getContextPath()+"/B_ContractManage.do?cmd=contractMgPageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
					}
				log.debug("[견적서 계약 발행 시 생성된 Public_No 번호(년/월/일 현재 DB Max값으로 가져온 코드):["+public_no+"] action..견적서 계약 발행]");
				log.debug("[견적서 계약 발행 시 계약관리 ContractCode 코드 생성 (현재 DB에서 Max값으로 가져온 코드):["+CreateCode_CQ+"] action..견적서 계약 발행]");
				log.debug("[견적서 계약 발행 시 해당 견적서에 생성된 ContractCode DB(T_ESTIMATE) Insert Start!]");
				//생성한 계약관리 코드 셋팅.
				estimateDto.setContractCode(CreateCode_CQ);
				log.debug("[견적서 계약 발행 시 계약관리 ContractCode 코드번호 셋팅  값["+estimateDto.getContractCode()+"] action..견적서 계약 발행]");
				int retVal_Cm_Code = 0; //계약 코드번호 T_ESTIMATE Insert 성공여부 결과 값 변수.
				retVal_Cm_Code = estimateDao.contractInsertCode(estimateDto);
				//계약 코드 seelct 생성까지햇음. 이제 견적서에 우선 ContractCode 값 Update 시켜주고. 그다음에 계약관리 테이블에 견적서 매핑 정보 끌어와 Insert시켜주는 작업해야됨.
				log.debug("[견적서 계약발행 견적서 계약 코드번호 DB=T_ESTIMATE Insert Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal_Cm_Code+"] action..견적서 계약발행]");
				
					int retVal_Cm_Result = 0; //계약관리 Data Insert 결과 값.
					//계약된 견적서에 해당 계약코드번호 정상적으로 DB Insert �을 경우(결과값:retVal_Cm_Code = 1) 시작 Loop
					if(retVal_Cm_Code == 1){
					//견적서에 등록된 계약코드 번호에 대해서 계약관리에 매핑시켜줄 데이터를 넣는다.	
					cmDto.setContractCode(CreateCode_CQ); 			//계약 코드번호 셋팅.
					cmDto.setPublic_No(public_no);					//계약 견적번호 셋팅.
					cmDto.setContractFile("");						//계약 계약서파일 경로셋팅.(초기 Defualt="공백")
					cmDto.setContractFileNm("");					//계약 계약서파일 명 셋팅.(초기 Default="-")
					cmDto.setPurchaseOrderFile("");					//발주서 파일 경로 셋팅.(초기 Defualt="공백")
					cmDto.setPurchaseOrderFileNm("");				//발주서 파일 명 셋팅.(초기 Defualt="공백")
					cmDto.setEstimate_E_File(estimate_e_file);		//계약 엑셀 견적서 경로셋팅.
					cmDto.setEstimate_E_FileNm(ESTIMATE_E_FILENM);	//계약 엑셀 견적서 파일명 셋팅.
					cmDto.setEstimate_P_File(estimate_p_file);		//계약 PDF 견적서 경로셋팅.
					cmDto.setEstimate_P_FileNm(ESTIMATE_P_FILENM);	//계약 PDF 견적서 파일명 셋팅.
					cmDto.setOrdering_Organization(e_comp_nm);		//계약 발주처 명 셋팅 = 업체명
					cmDto.setContractName(title);					//계약 계약명 = 프로젝트명
					cmDto.setContractStatus("1");					//계약종결 여부 셋팅(초기에는 1로 셋팅 1="-")
					cmDto.setContractCreateUser(USERID);			//최초등록자 세션 아이디 셋팅.
					retVal_Cm_Result = estimateDao.contractInsertData(cmDto);
					log.debug("[견적서 계약발행 데이터 Insert Success! action.. End 성공 = > Result 값 :["+retVal_Cm_Result+"]");	
					}else{
					log.debug("[견적서 계약발행 데이터 Insert Failed! action.. End 실패 = > Result 값 :["+retVal_Cm_Result+"]");
					msg = "견적서 즉시발행 계약관리 연동 등록 Error 관리자에게 문의하세요.";	
				    return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");	
					}
					//계약된 견적서에 해당 계약코드번호 정상적으로 DB Insert �을 경우(결과값:retVal_Cm_Code = 1) 끝 Loop
	
				log.debug("[견적서 계약 발행 등록 Loop End..]");	
				}else{
				log.debug("[미계약된 견적서로 판단하여 계약번호 코드 생성 Loop Stop! 견적서 발행 관련 처리만 실행함. 계약관리와 연동안함.]");
				log.debug("[견적서 미계약 발행 등록 Loop End..]");	
				}
				//계약관리 연동 Loop 끝. 2013_12_13 shbyeon. 요청으로 인해 사용안함.
				 * 
				 */
					
					//견적서 즉시발행 정상 등록 값 받아올 경우 실행.
					//영업진행현황 연동 Loop 시작.
					if(retVal == 1){
					log.debug("[견적서 즉시 발행 영업진행현황 연동 등록 Loop Start..]");	
					//영업진행현황 등록 DTO Setting
					csDto.setPreSalesCode(nowPubRegist); //영업진행현황 SC 코드(max 값 에서 +1로 생성된 코드)
					csDto.setQuarter(Quarter);			 //영업진행현황 예상일자=분기
					csDto.setEnterpriseCode(comp_code);	 //견적서 업체코드 = 영업진행현황 영업주관사(업체명)=코드번호
					csDto.setPermitNo(comp_code);		 //견적서 업체코드 = 영업진행현황 영업주관사(업체명)=코드번호
					csDto.setEnterpriseNm(e_comp_nm);	 //견적서 업체명 = 영업진행현황 영업주관사명(업체명)=이름명
					csDto.setOperatingCompany(OperatingCompany);  //영업진행현황 고객사
					csDto.setSalesMan(SalesMan);				  //영업진행현황 영업주관사 담당자
					csDto.setSalesManTel(SalesManTel);			  //영업진행현황 영업주관사 연락처
					csDto.setProjectName(title);			      //견적서 제목= 영업진행현황 프로젝트 명
					csDto.setSalesProjections(supply_price);      //견적서 공급가= 영업진행현황 예상수주액(VAT 별도)
					csDto.setOrderble(orderble);				  //견적서 수주가능성 = 영업진행현황 수주가능성
					csDto.setChargeID(sales_charge);			  //견적서 담당자 = 영업진행현황  담당영업(정)
					csDto.setChargeSecondID(ChargeSecondID);      //영업진행현황 담당영업(부)
					csDto.setAssignPerson(AssignPerson);		  //영업진행현황 배정인력
					csDto.setOrderStatus(contract_yn);			  //견적서 계약여부 = 영업진행현황 계약여부
					csDto.setDateProjections(DateProjections);	  //영업진행현황 예상일자
					csDto.setWriteUser(USERID);				      //견적서 작성자 = 영업진행현황 작성자
					csDto.setPublicNo(public_no);				  //견적서 발행번호 = 영업진행현황 발행번호
					csDto.setSalesFile_Xls(estimate_e_file);	  //견적서 엑셀파일 = 영업진행현황 엑셀파일
					csDto.setSalesFileNm_Xls(ESTIMATE_E_FILENM);  //견적서 엑셀파일명 = 영업진행현황 엑셀파일명
					csDto.setSalesFile_Pdf(estimate_p_file);	  //견적서 PDF파일 = 영업진행현황 PDF파일
					csDto.setSalesFileNm_Pdf(ESTIMATE_P_FILENM);  //견적서 PDF파일명 = 영업진행현황 PDF파일명
					
					retVal_cs = csDao.addcurrentRegist_EST(csDto);
					log.debug("[견적서 즉시발행 후 영업진행현황 DB=htSalesCurrentStatus Insert Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal_cs+"] action..견적서 즉시발행]");
					
				
					}else{
					//견적서 즉시 발행 정상 등록 값 받아 오지 못할 경우 실행.(Error Page)
					log.debug("[견적서 즉시발행:Insert Success! ---> 영업진행현황 등록처리:Insert Failed!...실패 값:["+retVal_cs+"] 관리자에게 문의하세요.");
					msg = "견적서 즉시발행 Error 관리자에게 문의하세요.";	
				    return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");	
					}
					//영업진행현황 연동 Loop 끝.
					log.debug("[견적서 즉시 발행 영업진행현황 연동 등록 Loop End..]");	
			}
			/*2013_04_26(금)shbyeon.
			업체관리에서 등록되있지 않은 업체 일때.(견적서발행 등록 폼에서 수동입력체크 후 등록하였을때 실행).
		        수동입력 업체로 업체관리쪽에 미등록업체로 등록이된다.
			단 영업진행현황 조회 즉 영업진행현황에서 등록된(미등록업체==수동입력)일 경우에는 이미 comp_code 가 생성되있는
			업체이므로 영업진행현황 조회 견적서 최초 발행시에는 등록된 업체이기 때문에 comp_code를 새로 생성해줄 필요가 없으므로
			업체관리에 등록된 업체 일때.(업체조회 등록일때 실행)에있는 등록처리를 실행한다.
				}else if(comp_code == "" && e_comp_nm != ""){
					
					estimateDto.setPROJECT_PK_CODE(PROJECT_PK_CODE);
					estimateDto.setPublic_no(public_no);
					estimateDto.setP_public_no(p_public_no);
					estimateDto.setEstimate_dt(estimate_dt);
					estimateDto.setComp_code(comp_code);
					estimateDto.setReceiver(receiver);
					estimateDto.setTitle(title);
					estimateDto.setSupply_price(supply_price);
					estimateDto.setVat(vat);
					estimateDto.setReg_id(USERID);
					estimateDto.setSales_charge(sales_charge);
					estimateDto.setEtc(etc);
					estimateDto.setE_comp_nm(e_comp_nm);
					estimateDto.setProductno(productno);
					estimateDto.setD_public_yn(d_public_yn);
					estimateDto.setOrderble(orderble);
					estimateDto.setEstimate_e_file(estimate_e_file);
					estimateDto.setEstimate_p_file(estimate_p_file);
					estimateDto.setContract_yn(contract_yn);
					estimateDto.setSalescurrent_yn(salescurrent_yn);
					estimateDto.setESTIMATE_E_FILENM(ESTIMATE_E_FILENM);
					estimateDto.setESTIMATE_P_FILENM(ESTIMATE_P_FILENM);
					estimateDto.setCheckyn(checkyn);
					
				
				  // 새로운 comp_code를 생성해주면서 업체관리쪽에 수동업체(미등록업체)를 등록하기 위해서 실행함.
				 
					CompanyDTO cpDto = new CompanyDTO();
					CompanyDAO cpDao = new CompanyDAO();
					
					retVal=estimateDao.addEstimate(estimateDto);
					
					cpDto.setComp_nm(e_comp_nm);
					System.out.println("SFDFFF:"+e_comp_nm);
					retVal = cpDao.addCompany(cpDto);
				}
				*/
				
				/*2013_04_26(금)shbyeon.
				 * 영업진행현황 PK가 있는 등록 시 실행.(즉 영업진행현황 조회 등록 이나 모발행조회 일때 이미 영업진행현황 관리에 등록되 있는 영업진행현황의 PK를 가지고 등록할때.)
				 * 영업진행현황 관련 데이터 Update 실행.	
				 */
				if(PROJECT_PK_CODE != ""){
					log.debug("[영업진행현황 관리 데이터 Update Start action..영업진행현황 관리]");
					log.debug("[영업진행현황 관리 영업진행현황 해당 코드번호:["+PROJECT_PK_CODE+"]Get Param action..영업진행현황 관리]");
					log.debug("[영업진행현황 관리 영업진행현황 해당 견적 최초발행번호:["+public_no+"]Get Param action..영업진행현황 관리]");
					log.debug("[영업진행현황 관리 영업진행현황 해당 견적 모발행번호:["+p_public_no+"]Get Param action..영업진행현황 관리]");
					log.debug("[영업진행현황 관리 영업진행현황 해당 수주가능성:["+orderble+"]Get Param action..영업진행현황 관리]");
					log.debug("[영업진행현황 관리 영업진행현황 해당 계약여부:["+contract_yn+"]Get Param action..영업진행현황 관리]");
					log.debug("[영업진행현황 관리 영업진행현황 해당 견적서 엑셀파일명:["+ESTIMATE_E_FILENM+"]Get Param action..영업진행현황 관리]");
					log.debug("[영업진행현황 관리 영업진행현황 해당 견적서 PDF파일명:["+ESTIMATE_P_FILENM+"]Get Param action..영업진행현황 관리]");
					log.debug("[영업진행현황 관리 영업진행현황 해당 견적서 엑셀파일경로:["+estimate_e_file+"]Get Param action..영업진행현황 관리]");
					log.debug("[영업진행현황 관리 영업진행현황 해당 견적서 PDF파일경로:["+estimate_p_file+"]Get Param action..영업진행현황 관리]");
					
					csDao = new CurrentStatusDAO();
					csDto = new CurrentStatusDTO();
					
					csDto.setPreSalesCode(PROJECT_PK_CODE);//견적서 발행으로 받은 영업진행현황 셋팅 pk
					csDto.setPublicNo(public_no); 		//견적서 발행으로 받은 견적번호 셋팅
					csDto.setP_PublicNo(p_public_no); 	//견적서 발행으로 받은 모발행번호 셋팅
					csDto.setOrderStatus(contract_yn);  //견적서 발행으로 받은 계약여부 셋팅
					csDto.setOrderble(orderble); 		//견적서 발행으로 받은 수주상태 셋팅
					csDto.setChargeID(sales_charge);	//견적서 발행으로 받은 담당영업(정)셋팅
					csDto.setSalesFile_Xls(estimate_e_file);      //견적서 발행으로 받은 엑셀 파일 경로 셋팅
					csDto.setSalesFileNm_Xls(ESTIMATE_E_FILENM);  //견적서 발행으로 받은 엑셀 파일 이름 셋팅
					csDto.setSalesFile_Pdf(estimate_p_file);	  //견적서 발행으로 받은 PDF 파일 경로셋팅
					csDto.setSalesFileNm_Pdf(ESTIMATE_P_FILENM);  //견적서 발행으로 받은 PDF 파일 이름 셋팅
				
					retVal = csDao.currentUpdate_EST(csDto);
					log.debug("[영업진행현황 관리 영업진행현황 DB=htSalesCurrentStatus Update Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal+"] action..영업진행현황 관리]");
					log.debug("[영업진행현황 관리 데이터 Update End action..영업진행현황 관리]");
					
				}
			
				
				//견적서 모발행번호 조회 발행일때.(모발행번호 등록 일 경우엔 새롭게 생성되는 등록이기 때문에 상품코드를 지워주지 않고 바로 Insert 해준다.)
				if(p_public_no != ""){
					if(retVal == 1){
						log.debug("[모발행번호 조회 발행 시작 Product Code Regist Start action..모발행]");
						log.debug("[영업진행현황 코드 등록 번호:"+PROJECT_PK_CODE+"] action..모발행]");
						log.debug("[견적서 최초 발행번호:"+public_no+"] action..모발행]");
						log.debug("[견적서 모 발행번호:"+p_public_no+"] action..모발행]");

						String ProductPk_Mapping = public_no; 
						String[] ProductCode = multipartRequest.getParameterValues("ProductCode"); //Arr 일때 getParameterValues //multipart 사용 시
						retVal = csDao.addproductCode_EST(ProductCode, PROJECT_PK_CODE ,ProductPk_Mapping); //(상품코드,영업진행현황코드,견적서 발행번호)
						log.debug("[Arr getValues ProductCode Count:["+ProductCode.length+"] action..모발행]");
						log.debug("[모발행번호 조회 상품코드 Insert [1]정상,[1]이 아닌 값 실패! 성공여부=["+retVal+"] action..모발행]");
						log.debug("[모발행번호 조회 발행 끝 Product Code Regist End action..모발행]");
					}else{
						msg = "상품코드 등록(Batch_SQL)실패하였습니다.(모발행번호 조회 견적발행 경우 상품코드 실패입니다. 관리자에게 문의바랍니다.)";
					}
				//영업진행현황 조회 초기 견적발행일때.(영업진행현황 조회 등록 일 경우엔 현재 상품코드 테이블 공통 사용중이므로 기존 SC_CODE의 상품코드 데이터를 지워 주고 Insert 해준다.)
				}else if(PROJECT_PK_CODE != "" && public_no != "" && public_no_retry == ""){
					if(retVal == 1){
						log.debug("[영업진행현황 조회 발행 시작 Product Code Regist Start action..영업진행현황 조회발행]");
						log.debug("[영업진행현황 코드 등록 번호:"+PROJECT_PK_CODE+"] action..영업진행현황 조회발행]");
						log.debug("[견적서 최초 발행번호:"+public_no+"]");
						retVal_ProductDel = csDao.deleteProductAll_EST(estimateDto);
						log.debug("[영업진행현황 조회 상품코드 Delete Count:["+retVal_ProductDel+"] action..영업진행현황 조회]");
						
						String ProductPk_Mapping = public_no; 
						String[] ProductCode = multipartRequest.getParameterValues("ProductCode"); //Arr 일때 getParameterValues //multipart사용시
						retVal = csDao.addproductCode_EST(ProductCode, PROJECT_PK_CODE ,ProductPk_Mapping); //(상품코드,영업진행현황코드,견적서 발행번호)
						log.debug("[Arr getValues ProductCode Count:"+ProductCode.length+"] action..영업진행현황 조회발행]");
						log.debug("[영업진행현황 조회 상품코드 Insert [1]정상,[1]이 아닌 값 실패! 성공여부=["+retVal+"] action..영업진행현황 조회]");
						log.debug("[영업진행현황 조회 발행 끝 Product Code Regist End action..영업진행현황 조회발행]");
					}else{
						msg = "상품코드 등록(Batch_SQL)실패하였습니다.(영업진행현황 조회 견적발행 경우 상품코드 실패 Case 관리자에게 문의바랍니다.)";
					}
				//영업진행현황 조회 재 견적발행일때.(영업진행현황 코드가 같은 견적 재 발행 일 경우엔 영업진행현황 코드는 같지만 견적서 초기발행번호가 다르므로 기존 상품코드 데이터를 가지고있어야 하므로 Delete 없이 Insert 해준다.)
				}else if(PROJECT_PK_CODE != "" &&  public_no != "" && public_no_retry != ""){
					if(retVal == 1){
						log.debug("[영업진행현황 조회 재 발행 시작 Product Code Regist Start action..영업진행현황 조회 재 발행]");
						log.debug("[영업진행현황 코드 등록 번호:"+PROJECT_PK_CODE+"] action..영업진행현황 조회 재 발행]");
						log.debug("[견적서 기존 발행번호:"+public_no_retry+"] action..영업진행현황 조회 재 발행]");
						log.debug("[견적서 최초 발행번호:"+public_no+"] action..영업진행현황 조회 재 발행]");
					
						String ProductPk_Mapping = public_no; 
						String[] ProductCode = multipartRequest.getParameterValues("ProductCode"); //Arr 일때 getParameterValues //multipart사용시
						retVal = csDao.addproductCode_EST(ProductCode, PROJECT_PK_CODE ,ProductPk_Mapping); //(상품코드,영업진행현황코드,견적서 발행번호)
						log.debug("[Arr getValues ProductCode Count:"+ProductCode.length+"] action..영업진행현황 조회 재 발행]");
						log.debug("[영업진행현황 조회 상품코드 Insert [1]정상,[1]이 아닌 값 실패! 성공여부=["+retVal+"] action..영업진행현황 조회 재 발행]");
						log.debug("[영업진행현황 조회 재 발행 끝 Product Code Regist End action..영업진행현황 조회 재 발행]");
					}else{
						msg = "상품코드 등록(Batch_SQL)실패하였습니다.(영업진행현황 조회(retry) 재 견적발행 경우 상품코드 실패 Case 관리자에게 문의바랍니다.)";
					}
				//견적서 최초 발행일때.(상품코드 테이블은 공통테이블사용.영업진행현황과의 매핑 관련된 이슈때문.)
				}else if(PROJECT_PK_CODE == "" && public_no != "" && nowPubRegist == ""){
					log.debug("[견적서 최초발행 시작 Product Code Regist Start action..견적서 최초발행]");
					log.debug("[견적서 최초 발행번호:"+public_no+"]");
					if(retVal == 1){
						String ProductPk = "";
						String ProductMappingPk = public_no;
						String[] ProductCode = multipartRequest.getParameterValues("ProductCode"); //Arr 일때 getParameterValues
						retVal = csDao.addproductCode_EST(ProductCode,ProductPk,ProductMappingPk); //(상품코드,영업진행현황코드,견적서 발행번호)
						log.debug("[Arr getValues ProductCode Count:"+ProductCode.length+"] action..견적서 최초발행]");	
					log.debug("[견적서 최초발행 상품코드 Insert [1]정상,[1]이 아닌 값 실패! 성공여부=["+retVal+"] action..견적서 최초발행]");
					log.debug("[견적서 최초발행 끝 Product Code Regist End action..견적서 최초발행]");	
					}else{
						msg = "상품코드 등록(Batch_SQL)실패하였습니다.(견적서 최초발행 경우 상품코드 실패 Case 관리자에게 문의바랍니다.)";
					}
				//견적서 즉시발행 일때.(상품코드 테이블은 공통테이블 사용. 영업진행현황과의 매핑 관련된 이슈때문.)	
				}else if(nowPubRegist != "" && retVal_cs == 1){
					log.debug("[견적서 즉시발행 시작 Product Code Regist Start action..견적서 즉시발행]");
					log.debug("[영업진행현황 코드 등록 번호:"+nowPubRegist+"] action..견적서 즉시발행]");
					log.debug("[견적서 최초 발행번호:"+public_no+"]");
					if(retVal == 1){
						String ProductPk = nowPubRegist;
						String ProductMappingPk = public_no;
						String[] ProductCode = multipartRequest.getParameterValues("ProductCode"); //Arr 일때 getParameterValues
						retVal = csDao.addproductCode_EST(ProductCode,ProductPk,ProductMappingPk); //(상품코드,영업진행현황코드,견적서 발행번호)
					log.debug("[Arr getValues ProductCode Count:"+ProductCode.length+"] action..견적서 즉시발행]");	
					log.debug("[견적서 즉시발행 상품코드 Insert [1]정상,[1]이 아닌 값 실패! 성공여부=["+retVal+"] action..견적서 즉시발행]");
						retVal = csDao.addproductCode_now(ProductCode,ProductPk);
					log.debug("[견적서 즉시발행으로 영업진행현황 상품코드 Insert [1]정상,[1]이 아닌 값 실패! 성공여부=["+retVal+"] action..견적서 즉시발행으로 영업진행현황]");	
					log.debug("[Arr getValues ProductCode Count:"+ProductCode.length+"] action..견적서 즉시발행으로 영업진행현황]");
					log.debug("[견적서 즉시발행 끝 Product Code Regist end action..견적서 즉시발행]");
					}else{
						msg = "상품코드 등록(Batch_SQL)실패하였습니다.(견적서 즉시발행 경우 상품코드 실패 Case 관리자에게 문의바랍니다.)";
					}
				}	
			 msg = "견적서 등록에 성공했습니다.";	
			 
		        if(retVal < 1) msg = "견적서  등록에 실패하였습니다";

		        return alertAndExit(model,msg,request.getContextPath()+"/B_Estimate.do?cmd=estimatePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt+"&type="+type,"back");	
		      
		}
		
		/**
		 * 견적서상세정보
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward estimateView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			int curPageCnt = 0;
			String public_no = "";  //발행코드
			
			curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			String type = StringUtil.nvl(request.getParameter("type"),"");
			public_no = StringUtil.nvl(request.getParameter("public_no"));
			//영업진행현황 PK
			String ProjectPk = StringUtil.nvl(request.getParameter("ProjectPk"), "");

			
			EstimateDAO estimateDao = new EstimateDAO();
			EstimateDTO estimateDto = new EstimateDTO();
			
			//상품코드 가져오기 위한 영업진행현황 객체 생성.
			CurrentStatusDAO csDao = new CurrentStatusDAO();
			CurrentStatusDTO csDtoPro = new CurrentStatusDTO(); //매핑 테이블의 htSalesProductCode 상품코드 (꺼내올 DTO 용도로 사용.)
			
			estimateDto = estimateDao.getEstimateView(public_no);
			ArrayList productList = null; //상품코드 가져올 어레이 변수 선언
			productList = csDao.getproductViewList_EST(estimateDto);//영업진행현황 등록된 상품코드 estimateDto의
																	//ProjectPk DTO를 위해 estimateDto셋팅
			
			//(코드북 상품코드)		
			String smlcode=  "P02";  //자사상품
			String smlcode2= "P03"; //비 자사상품(내자)
			String smlcode3= "P04"; //비 자사상품(외자)
			
			//자사 상품코드 Arrlist 시작
			CommonDAO common = new CommonDAO(); 
			ArrayList codeList = null; //어레이 변수 선언
		   	codeList = common.getCodeListPro(smlcode); //어레이 변수 에 코드값을 담기.
		    
		   	//비자사(내자) 상품코드 Arrlist 시작
			ArrayList codeList2 = null; //어레이 변수 선언
		   	codeList2 = common.getCodeListPro(smlcode2); //어레이 변수 에 코드값을 담기.
		   	
		   	//비자사(외자) 상품코드 Arrlist 시작
			ArrayList codeList3 = null; //어레이 변수 선언
		   	codeList3 = common.getCodeListPro(smlcode3); //어레이 변수 에 코드값을 담기.
		   	
			
			DateSetter dateSetter = new DateSetter( estimateDto.getEstimate_dt() , "99991231" );

			model.put("dateSetter", dateSetter );
		    model.put("estimateDto", estimateDto); 
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("public_no",public_no);
			model.put("searchGb", searchGb);
			model.put("searchtxt", searchtxt);
			model.put("productList", productList);//상품코드 Array
			model.put("codeList", codeList); //자사 상품코드
		   	model.put("codeList2", codeList2); //비자사(내자) 상품코드
		   	model.put("codeList3", codeList3); //비자사(외자) 상품코드
		   	model.put("csDtoPro", csDtoPro); //해당 매핑ProjectPk의 상품코드 꺼내올 DTO
		   	model.put("type", type);
			
		    if(estimateDto == null){
				String msg = "해당  견적서  정보가 없습니다.";
				return alertAndExit(model, msg,request.getContextPath()+"/B_Eestimate.do?cmd=estimatePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt+"&type="+type,"back");
		    }else{
		    	return actionMapping.findForward("estimateView");
			}
		}
		
		/**
		 * 2013_04_24(수) shbyeon.
		 * 견적서발행 - > 영업진행현황 popup 상품코드 가져오기.
		 */
		public ActionForward currentProductSelect(ActionMapping actionMapping,
				ActionForm actionForm, HttpServletRequest request,
				HttpServletResponse response, Map model) throws Exception {

			String PROJECT_PK_CODE = StringUtil.nvl(request.getParameter("PROJECT_PK_CODE"), "");
			String Public_No = StringUtil.nvl(request.getParameter("Public_No"), "");

			 
			CurrentStatusDAO csDao = new CurrentStatusDAO();
			CurrentStatusDTO csDto = new CurrentStatusDTO();
			
			csDto.setProductPk(PROJECT_PK_CODE);
			csDto.setPublicNo(Public_No);
			
			//csDto 상세보기 DTO
			String productArr = ""; //상품코드 가져올 Arr String 변수 선언 코드명
			productArr = csDao.getproductViewListEsT_pop(csDto);
			response.setContentType("text/html; charset=euc-kr"); //브라우저가 알아서 인코딩 옵션 바꾸도록 하는 명령어.
			//response.setCharacterEncoding("EUC-KR");
			response.getWriter().print(productArr); 
			
			return null;
		}
		
		
		/**
		 * 2013_04_24(수) shbyeon.
		 * 견적서발행 - > 모발행번호 popup 상품코드 가져오기.
		 */
		public ActionForward currentProductSelect2(ActionMapping actionMapping,
				ActionForm actionForm, HttpServletRequest request,
				HttpServletResponse response, Map model) throws Exception {

			String public_no = StringUtil.nvl(request.getParameter("public_no"), "");
			System.out.println("public_no:"+public_no);

			 
			CurrentStatusDAO csDao = new CurrentStatusDAO();
			CurrentStatusDTO csDto = new CurrentStatusDTO();
			
			csDto.setProductPk(public_no);
			
			//csDto 상세보기 DTO
			String productArr = ""; //상품코드 가져올 Arr String 변수 선언 코드명
			productArr = csDao.getproductViewListEsT_pop2(csDto);
			response.setContentType("text/html; charset=euc-kr"); //브라우저가 알아서 인코딩 옵션 바꾸도록 하는 명령어.
			//response.setCharacterEncoding("EUC-KR");
			response.getWriter().print(productArr); 
			
			return null;
		}
		
		
		/**
		 * 견적서 정보를 수정한다.
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward estimateEdit(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
				String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			String msg = "";
			int retVal = 0;
			int retVal_ProductDel = 0; //삭제된 상품코드 갯수
			
			MultipartRequest multipartRequest = null;
			
			String objName = "";
			String rFileName = "";
			String sFileName = "";
			String filePath = "";
			String fileSize = "";		
			String sImageName = "";
			String FilePath = FileUtil.FILE_DIR+"estimate/"+DateTimeUtil.getDate()+"/";
			String uploadFilePath="";
				log.debug("FilePath= "+FilePath);
			UploadFiles uploadEntity = FileUtil.upload(request, FilePath,USERID, 10);
	     	multipartRequest = uploadEntity.getMultipart();
			String status = uploadEntity.getStatus();

			int curPageCnt = 0;		
			String searchGb = "";
			String searchtxt = "";
			String type = "";

			String estimate_e_file= "";
			String estimate_p_file= "";

			if (status.equals("E")){ 
				log.debug("첨부 파일 올리려다 실패하였습니다.");
				msg = "첨부 파일 올리려다 실패하였습니다.";	
		        return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");	
		        
			}else if (status.equals("O")){ 
				log.debug("첨부하신 파일이 용량을 초과했습니다.");
				msg = "첨부하신 파일이 용량을 초과했습니다.";	
		        return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");	
		     
			}else if (status.equals("I")){
				log.debug("첨부 파일의 정보가 잘못되었습니다.");
				msg = "첨부 파일의 정보가 잘못되었습니다.";	
		        return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");	
		     
			}else if(status.equals("S")){
				
				curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"),1);
				searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"),"");
				searchtxt = StringUtil.nvl(multipartRequest.getParameter("searchtxt"),"");
				type = StringUtil.nvl(multipartRequest.getParameter("type"),"");

				estimate_e_file= StringUtil.nvl(multipartRequest.getParameter("p_estimate_e_file"),"");
				estimate_p_file= StringUtil.nvl(multipartRequest.getParameter("p_estimate_p_file"),"");
							
				// 업로드된 파일의 정보를 가져와서 데이터 베이스에 넣는 작업을 해준다.
				log.debug("첨부 파일을 첨부하는데 성공하였습니다.");
				ArrayList files = uploadEntity.getFiles();
				UploadFile file = null;
				for(int i = 0 ; i < files.size(); i++){
					file = (UploadFile)files.get(i);
					objName = file.getObjName();
					rFileName = StringUtil.nvl(file.getRootName());

					if(objName.equals("estimate_e_file")){
						
						if(!rFileName.equals("")) {
							sFileName = file.getUploadName();
							filePath = uploadEntity.getUploadPath();
							log.debug(" 파일 오브젝트명 =>"+ objName + ", 원 파일 명 =>"+rFileName+", 저장파일명 =>"+sFileName+",파일 사이즈 =>"+fileSize+", 저장 파일 패스 =>"+filePath);
							estimate_e_file=filePath+sFileName;
						}
					}	
					if(objName.equals("estimate_p_file")){
						
						if(!rFileName.equals("")) {
							sFileName = file.getUploadName();
							filePath = uploadEntity.getUploadPath();
							log.debug(" 파일 오브젝트명 =>"+ objName + ", 원 파일 명 =>"+rFileName+", 저장파일명 =>"+sFileName+",파일 사이즈 =>"+fileSize+", 저장 파일 패스 =>"+filePath);
							estimate_p_file=filePath+sFileName;
						}
					}	

				}
		}
			String public_no= StringUtil.nvl(multipartRequest.getParameter("public_no"),"");
			//2013_04_29(월) shbyeon. 영업진행현황==견적서발행 매핑 PkCode
			String PROJECT_PK_CODE= StringUtil.nvl(multipartRequest.getParameter("PROJECT_PK_CODE"),"");  
			String p_public_no= StringUtil.nvl(multipartRequest.getParameter("p_public_no"),"");    	
			String estimate_dt= StringUtil.nvl(multipartRequest.getParameter("estimate_dt"),"");    	
			String comp_code= StringUtil.nvl(multipartRequest.getParameter("comp_code"),"");
			String receiver= StringUtil.nvl(multipartRequest.getParameter("receiver"),"");    	
			String title= StringUtil.nvl(multipartRequest.getParameter("title"),"");    	
			String supply_price= StringUtil.nvl(multipartRequest.getParameter("supply_price"),"0");    	
			String vat= StringUtil.nvl(multipartRequest.getParameter("vat"),"0");    	
			String sales_charge= StringUtil.nvl(multipartRequest.getParameter("sales_charge"),"");
			String etc= StringUtil.nvl(multipartRequest.getParameter("etc"),"");   
			String e_comp_nm= StringUtil.nvl(multipartRequest.getParameter("e_comp_nm"),"");
			String d_public_yn= StringUtil.nvl(multipartRequest.getParameter("d_public_yn"),""); 
			String productno= StringUtil.nvl(multipartRequest.getParameter("productno"),"");
			String orderble= StringUtil.nvl(multipartRequest.getParameter("orderble"),""); 
			String contract_yn= StringUtil.nvl(multipartRequest.getParameter("contract_yn"),"");
			String salescurrent_yn= StringUtil.nvl(multipartRequest.getParameter("SalesCurrentYn"),"");
			String ESTIMATE_E_FILENM= StringUtil.nvl(multipartRequest.getParameter("ESTIMATE_E_FILENM"),"");
			String ESTIMATE_P_FILENM= StringUtil.nvl(multipartRequest.getParameter("ESTIMATE_P_FILENM"),""); 
			String checkyn= StringUtil.nvl(multipartRequest.getParameter("checkyn"),"");
			
			//견적서 경유매출 옵션으로인한 추가 파라미터 2013-11-19(화)shbyeon.
			String IndirectSalesYN= StringUtil.nvl(multipartRequest.getParameter("IndirectSalesYN"),"");
			String Purchase= StringUtil.nvl(multipartRequest.getParameter("Purchase"),"");
			String Sales_profit= StringUtil.nvl(multipartRequest.getParameter("Sales_profit"),"");
			String Profit_percent= StringUtil.nvl(multipartRequest.getParameter("Profit_percent"),"");
				
			//매출구분 으로 인해 받을 파라미터 값2013-11-20(수)
			String SalesSort= StringUtil.nvl(multipartRequest.getParameter("SalesSort"),"");
			
			//계약관리 연동으로 인해 받을 파라미터 값 2013-12-20(금) 사용안함.
			//String ContractCode = StringUtil.nvl(multipartRequest.getParameter("ContractCode"),"");
			
				EstimateDAO estimateDao = new EstimateDAO();
				EstimateDTO estimateDto = new EstimateDTO(); 
			
				//2013_04_29(월) shbyeon. 추가 (영업진행현황메뉴와 견적서 메뉴 연동을위해.)
				CurrentStatusDAO csDao = new CurrentStatusDAO();
				CurrentStatusDTO csDto = new CurrentStatusDTO();
				
				/*
				//2013-11-26(화) shbyeon. 추가(계약관리메뉴와 연동을 위해.)
				ContractManageDTO cmDto = new ContractManageDTO();
				ContractManageDAO cmDao = new ContractManageDAO();
				*/
				
				estimateDto.setMod_id(USERID);
				estimateDto.setPROJECT_PK_CODE(PROJECT_PK_CODE);
				estimateDto.setPublic_no(public_no);
				estimateDto.setP_public_no(p_public_no);
				estimateDto.setEstimate_dt(estimate_dt);
				estimateDto.setComp_code(comp_code);
				estimateDto.setReceiver(receiver);
				estimateDto.setTitle(title);
				estimateDto.setSupply_price(supply_price);
				estimateDto.setVat(vat);
				estimateDto.setSales_charge(sales_charge);
				estimateDto.setEtc(etc);
				estimateDto.setE_comp_nm(e_comp_nm);
				estimateDto.setD_public_yn(d_public_yn);
				estimateDto.setProductno(productno);
				estimateDto.setOrderble(orderble);
				estimateDto.setEstimate_e_file(estimate_e_file);
				estimateDto.setEstimate_p_file(estimate_p_file);
				estimateDto.setESTIMATE_E_FILENM(ESTIMATE_E_FILENM);
				estimateDto.setESTIMATE_P_FILENM(ESTIMATE_P_FILENM);
				estimateDto.setContract_yn(contract_yn);
				estimateDto.setSalescurrent_yn(salescurrent_yn);
				estimateDto.setCheckyn(checkyn);
				estimateDto.setIndirectSalesYN(IndirectSalesYN);
				estimateDto.setPurchase(Purchase);
				estimateDto.setSales_profit(Sales_profit);
				estimateDto.setProfit_percent(Profit_percent);
				estimateDto.setSalesSort(SalesSort);
				retVal = estimateDao.editEstimate(estimateDto);
				log.debug("[견적서 발행 수정  DB=T_ESTIMATE Update Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal+"] action..견적서 발행 수정]");	
				
				int retVal_CmCode_Delete = 0; //견적서 계약 = > 미계약 수정 시 정상 값. 변수
				int retVal_Contract_Y = 0;	  //견적서 계약 = > 계약으로 수정 시 정상 값. 변수
				if(retVal == 1){
					log.debug("[견적서 발행 수정 Update Success! action.. Start 성공 = > Result 값 :["+retVal+"] action..견적서 발행 수정 Loop Start..]");
					
					/**
					//견적서 발행 계약 => 미계약 (계약관리 연동)Loop 시작. 2013_12_13 shbyeon. 요청으로 인해 사용안함.
					if(contract_yn.equals("N") && !ContractCode.equals("")){
					log.debug("[견적서 발행 계약을 => 미계약으로 수정 시 실행되는 Loop Start action..(계약관리 연동)]");
					cmDto.setContractCode(ContractCode);
					cmDto.setPublic_No(public_no);
					retVal_CmCode_Delete = estimateDao.contractDeleteCode(cmDto);
					log.debug("[견적서 발행 계약을  = > 미계약으로 수정 DB=htContractManagement Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal_CmCode_Delete+"] action..견적서 발행 계약  = > 미계약 수정 (계약관리 연동)]");
						int retVal_Cm_Code = 0; //견적서 계약 = > 미계약 수정 시 정상 값. 변수
						if(retVal_CmCode_Delete == 1){
						log.debug("[견적서 계약관리 연동 계약코드 데이터 정상 삭제 성공으로 견적서에 연동 되있는 계약 코드번호 삭제 Start action..(계약관리 연동)]");
						log.debug("[삭제된 계약관리 코드번호:["+cmDto.getContractCode()+"] 및 견적번호:["+cmDto.getPublic_No()+" action..삭제된 계약관리 (계약관리 연동)]");
						estimateDto.setPublic_no(cmDto.getPublic_No());
						estimateDto.setContractCode(""); //계약관리 코드연동을 끊어주기 위해 빈값으로 셋팅함.
						retVal_Cm_Code = estimateDao.contractInsertCode(estimateDto);
						log.debug("[견적서 계약관리 연동 코드 DB=htContractManagement Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal_Cm_Code+"] action..견적서 계약관리 연동 코드 (계약관리 연동)");
						log.debug("[견적서 발행 계약을 => 미계약으로 수정 시 실행되는 Loop End action..(계약관리 연동)]");	
						}else{
						log.debug("[견적서 계약관리 연동 코드 Update Failed! action.. End 실패 = > Result 값 :["+retVal_Cm_Code+"] action..견적서 계약관리 연동 코드 (계약관리 연동)");	
						msg = "견적서 발행 수정  Error 관리자에게 문의하세요.";	
					    return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");
						}
					}	
					//견적서 발행 계약 => 미계약 (계약관리 연동)Loop 끝. 2013_12_13 shbyeon. 요청으로 인해 사용안함.	
					 * 
					 */
					
					/**
					//견적서 발행 계약 => 계약 (계약관리 연동)Loop 시작. 2013_12_13 shbyeon. 요청으로 인해 사용안함.
					if(contract_yn.equals("Y") && !ContractCode.equals("")){
						log.debug("[견적서 발행 계약을 => 계약으로 수정 시 실행되는 Loop Start action..(계약관리 연동)]");
						cmDto.setContractCode(ContractCode);
						cmDto.setPublic_No(public_no);
						cmDto.setEstimate_E_File(estimate_e_file);
						cmDto.setEstimate_E_FileNm(ESTIMATE_E_FILENM);
						cmDto.setEstimate_P_File(estimate_p_file);
						cmDto.setEstimate_P_FileNm(ESTIMATE_P_FILENM);
						cmDto.setOrdering_Organization(e_comp_nm);
						cmDto.setContractName(title);
						cmDto.setContractUpdateUser(USERID);
						retVal_Contract_Y = estimateDao.contractUpdateData(cmDto);
						log.debug("[견적서 발행 계약을 => 계약으로 수정 시 받아서 Setting된 계약관리 코드번호:["+ContractCode+"] 및 견적번호:["+public_no+"] action..(계약관리 연동)]");
						log.debug("[견적서 발행 계약을  = > 계약으로 수정 시 DB=htContractManagement Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal_Contract_Y+"] action..견적서 발행 계약  = > 계약 (계약관리 연동)]");
						if(retVal_Contract_Y == 1){
						log.debug("[견적서 계약관리 연동 코드 Update Success! action.. End 성공! = > Result 값 :["+retVal_Contract_Y+"] action..견적서 계약관리 연동 코드 (계약관리 연동)");	
						}else{
						log.debug("[견적서 계약관리 연동 코드 Update Failed! action.. End 실패! = > Result 값 :["+retVal_Contract_Y+"] action..견적서 계약관리 연동 코드 (계약관리 연동)");	
						msg = "견적서 발행 수정  Error 관리자에게 문의하세요.";			
						}
						//견적서 발행 계약 => 계약 (계약관리 연동)Loop 끝.
					}	
					//견적서 발행 미계약 => 계약 (계약관리 연동)Loop 시작.	
					if(contract_yn.equals("Y") && ContractCode.equals("")){
						log.debug("[견적서 발행 미계약을 => 계약으로 수정 시 실행되는 Loop Start action..(계약관리 연동)]");
						log.debug("[견적서 계약 여부 Check Loop Start...]");
						log.debug("[견적서 발행 계약여부 : Y = 계약, N = 미계약..............실제 계약여부 값:("+estimateDto.getContract_yn()+") 계약인 경우 하위 계약관리 Insert Loop 시작됨. action..견적서 발행]");
						log.debug("[계약된 견적서로 판단하여 계약번호 코드 생성 Loop Start!]");
						String CreateCode_CQ = "";	//ContractCode 담을변수
						String CreateCode_Return=""; //ContractCode 리턴받은 변수
						CreateCode_CQ=estimateDao.addcontractRegistCode(CreateCode_Return); //계약관리 코드 Max값으로 Select하는 DAO 호출
						//계약관리번호 99건 이상 생성하려 할때 예외처리.
							if(CreateCode_CQ.equals("MAX")){
								msg = "계약관리 번호 생성오류 [99건 이상 인 경우]";			
						        return alertAndExit(model,msg,request.getContextPath()+"/B_ContractManage.do?cmd=contractMgPageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
							}
						log.debug("[견적서 계약 발행 시 생성된 Public_No 번호(년/월/일 현재 DB Max값으로 가져온 코드):["+public_no+"] action..견적서 계약 발행]");
						log.debug("[견적서 계약 발행 시 계약관리 ContractCode 코드 생성 (현재 DB에서 Max값으로 가져온 코드):["+CreateCode_CQ+"] action..견적서 계약 발행]");
						log.debug("[견적서 계약 발행 시 해당 견적서에 생성된 ContractCode DB(T_ESTIMATE) Insert Start!]");
						//생성한 계약관리 코드 셋팅.
						estimateDto.setContractCode(CreateCode_CQ);
						log.debug("[견적서 계약 발행 시 계약관리 ContractCode 코드번호 셋팅  값["+estimateDto.getContractCode()+"] action..견적서 계약 발행]");
						int retVal_Cm_Code = 0; //계약 코드번호 T_ESTIMATE Insert 성공여부 결과 값 변수.
						retVal_Cm_Code = estimateDao.contractInsertCode(estimateDto);
						//계약 코드 seelct 생성까지햇음. 이제 견적서에 우선 ContractCode 값 Update 시켜주고. 그다음에 계약관리 테이블에 견적서 매핑 정보 끌어와 Insert시켜주는 작업해야됨.
						log.debug("[견적서 계약발행 견적서 계약 코드번호 DB=T_ESTIMATE Insert Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal_Cm_Code+"] action..견적서 계약발행]");
						
							int retVal_Cm_Result = 0; //계약관리 Data Insert 결과 값.
							//계약된 견적서에 해당 계약코드번호 정상적으로 DB Insert �을 경우(결과값:retVal_Cm_Code = 1) 시작 Loop
							if(retVal_Cm_Code == 1){
							//견적서에 등록된 계약코드 번호에 대해서 계약관리에 매핑시켜줄 데이터를 넣는다.	
							cmDto.setContractCode(CreateCode_CQ); 			//계약 코드번호 셋팅.
							cmDto.setPublic_No(public_no);					//계약 견적번호 셋팅.
							cmDto.setContractFile("");						//계약 계약서파일 경로셋팅.(초기 Defualt="공백")
							cmDto.setContractFileNm("");					//계약 계약서파일 명 셋팅.(초기 Default="-")
							cmDto.setPurchaseOrderFile("");					//발주서 파일 경로 셋팅.(초기 Defualt="공백")
							cmDto.setPurchaseOrderFileNm("");				//발주서 파일 명 셋팅.(초기 Defualt="공백")
							cmDto.setEstimate_E_File(estimate_e_file);		//계약 엑셀 견적서 경로셋팅.
							cmDto.setEstimate_E_FileNm(ESTIMATE_E_FILENM);	//계약 엑셀 견적서 파일명 셋팅.
							cmDto.setEstimate_P_File(estimate_p_file);		//계약 PDF 견적서 경로셋팅.
							cmDto.setEstimate_P_FileNm(ESTIMATE_P_FILENM);	//계약 PDF 견적서 파일명 셋팅.
							cmDto.setOrdering_Organization(e_comp_nm);		//계약 발주처 명 셋팅 = 업체명
							cmDto.setContractName(title);					//계약 계약명 = 프로젝트명
							cmDto.setContractStatus("1");					//계약종결 여부 셋팅(초기에는 1로 셋팅 1="-")
							cmDto.setContractCreateUser(USERID);			//최초등록자 세션 아이디 셋팅.
							retVal_Cm_Result = estimateDao.contractInsertData(cmDto);
							log.debug("[견적서 계약발행 데이터 Insert Success! action.. End 성공 = > Result 값 :["+retVal_Cm_Result+"]");	
							}else{
							log.debug("[견적서 계약발행 데이터 Insert Failed! action.. End 실패 = > Result 값 :["+retVal_Cm_Result+"]");	
							msg = "견적서 발행 계약관리 연동 등록 Error 관리자에게 문의하세요.";	
						    return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");
							}
							//계약된 견적서에 해당 계약코드번호 정상적으로 DB Insert �을 경우(결과값:retVal_Cm_Code = 1) 끝 Loop
							log.debug("[견적서 계약 발행 등록 Loop End..]");	
					}else{
					log.debug("[미계약된 견적서로 판단하여 계약번호 코드 생성 Loop Stop! 견적서 발행 관련 처리만 실행함. 계약관리와 연동안함.]");
					log.debug("[견적서 미계약 발행 등록 Loop End..]");	
					}
					//견적서 발행 미계약 => 계약 (계약관리 연동)Loop 끝. 2013_12_13 shbyeon. 요청으로 인해 사용안함.
					 * 	
					 */
					
				}else{
					log.debug("[견적서 발행 수정 Update Failed! action.. End 실패 = > Result 값 :["+retVal+"] action..견적서 발행 수정");	
					msg = "견적서 발행 수정  Error 관리자에게 문의하세요.(견적서 발행 수정)";	
				    return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");
				}
			

				/*2013_04_26(금)shbyeon.
				 * 영업진행현황 조회로 등록시 실행.(즉 해당 해당영업에 대한 최초 견적서 발행일 경우 실행.)
				 * Description:견적서발행 수정일 경우에도 등록과 마찬가지로 공통 SP로 UPDATE를
				 * 쳐준다. 현재 publicno 견적번호 max 로 모발행번호 최근 데이터로 UPDATE
				 */
				if(PROJECT_PK_CODE != ""){
					System.out.println("PROJECT_PK_CODE:"+PROJECT_PK_CODE);
					System.out.println("public_no:"+public_no);
					System.out.println("p_public_no:"+p_public_no);
					System.out.println("contract_yn:"+contract_yn);
					System.out.println("orderble:"+orderble);
					System.out.println("ESTIMATE_E_FILENM:"+ESTIMATE_E_FILENM);
					System.out.println("ESTIMATE_P_FILENM:"+ESTIMATE_P_FILENM);
					System.out.println("estimate_e_file:"+estimate_e_file);
					System.out.println("estimate_p_file:"+estimate_p_file);
					
					csDao = new CurrentStatusDAO();
					csDto = new CurrentStatusDTO();
					
					csDto.setPreSalesCode(PROJECT_PK_CODE);//견적서 발행으로 받은 영업진행현황 셋팅 pk
					csDto.setPublicNo(public_no); 		//견적서 발행으로 받은 견적번호 셋팅
					csDto.setP_PublicNo(p_public_no); 	//견적서 발행으로 받은 모발행번호 셋팅
					csDto.setOrderStatus(contract_yn);  //견적서 발행으로 받은 계약여부 셋팅
					csDto.setOrderble(orderble); 		//견적서 발행으로 받은 수주상태 셋팅
					csDto.setChargeID(sales_charge);   ///견적서 발행으로 받은 담당영업
					csDto.setSalesFile_Xls(estimate_e_file);      //견적서 발행으로 받은 엑셀 파일 경로 셋팅
					csDto.setSalesFileNm_Xls(ESTIMATE_E_FILENM);  //견적서 발행으로 받은 엑셀 파일 이름 셋팅
					csDto.setSalesFile_Pdf(estimate_p_file);	  //견적서 발행으로 받은 PDF 파일 경로셋팅
					csDto.setSalesFileNm_Pdf(ESTIMATE_P_FILENM);  //견적서 발행으로 받은 PDF 파일 이름 셋팅
				
					retVal = csDao.currentUpdate_EST(csDto);
					
				}
				
				//견적서 (최초/모발행)일 경우의 상품코드 수정.
				//최초 발행건과 모발행이 같이 수정이 되는 것이 아니라 모발행을 하여 견적서를 발행하게되면
				//최초 발행 견적번호가 생성되므로 1건에 대한 견적서를 수정하기 때므로 최초 견적번호만 알고 있으면된다. 즉 모발행건의 상품코드는 수정 대상이 아니다.
				if(public_no !="" && PROJECT_PK_CODE == ""){
					if(retVal == 1){
						log.debug("[견적서 최초발행 건 수정시작 Product Code Regist Start action..견적서(최초/모)발행 건 수정시작]");
						log.debug("[수정되는 견적서 최초 발행번호:"+public_no+"] action..견적서 (최초/모)발행 건 수정시작");
						retVal_ProductDel = csDao.deleteProductAll_EST2(estimateDto);
						log.debug("[견적서 최초발행 건 수정 상품코드 Delete Count:["+retVal_ProductDel+"] action..견적서 (최초/모)발행 건 수정]");
						String ProductPk = multipartRequest.getParameter("PROJECT_PK_CODE"); //Arr 일때 getParameterValues
						String ProductPk_Mapping = public_no; 
						String[] ProductCode = multipartRequest.getParameterValues("ProductCode"); //Arr 일때 getParameterValues //multipart사용시
						retVal = csDao.addproductCode_EST(ProductCode, ProductPk ,ProductPk_Mapping);
						log.debug("[Arr getValues ProductCode Count:"+ProductCode.length+"] action..견적서 (최초/모)발행 건 수정]");
						log.debug("[견적서 최초발행 건 수정 상품코드 Insert [1]정상,[1]이 아닌 값 실패! 성공여부=["+retVal+"] action..견적서 (최초/모)발행 건 수정]");
						log.debug("[견적서 최초발행 건 수정 발행 끝 Product Code Regist End action..견적서 (최초/모)발행 건 수정]");
					}else{
						msg = "상품코드 등록(Batch_SQL)실패하였습니다.(견적서 최초발행 건 수정 상품코드 실패 Case 관리자에게 문의바랍니다.)";
					}	
				//영업진행현황 조회 발행 일 경우 상품코드 수정.
				}else if(public_no !="" && PROJECT_PK_CODE != ""){
					if(retVal == 1){
						log.debug("[영업진행현황 조회 발행 건 수정 시작 Product Code Regist Start action..영업진행현황 조회 발행 건 수정 시작]");
						log.debug("[수정되는 영업진행현황 코드 등록 번호:"+PROJECT_PK_CODE+"] action..영업진행현황 조회 발행 건 수정]");
						log.debug("[수정되는 견적서 발행번호:"+public_no+"] action..영업진행현황 조회 발행 건 수정]");
						retVal_ProductDel= csDao.deleteProductAll_EST2(estimateDto);
						log.debug("[영업진행현황 조회 발행 건 수정 상품코드 Delete Count:["+retVal_ProductDel+"] action..영업진행현황 조회 발행 건 수정]");
						String ProductPk = multipartRequest.getParameter("PROJECT_PK_CODE"); //Arr 일때 getParameterValues
						String ProductPk_Mapping = public_no; 
						String[] ProductCode = multipartRequest.getParameterValues("ProductCode"); //Arr 일때 getParameterValues //multipart사용시
						retVal = csDao.addproductCode_EST(ProductCode, ProductPk ,ProductPk_Mapping);
						log.debug("[Arr getValues ProductCode Count:"+ProductCode.length+"] action..영업진행현황 조회 발행 건 수정]");
						log.debug("[영업진행현황 조회 발행 건 수정 상품코드 Insert [1]정상,[1]이 아닌 값 실패! 성공여부=["+retVal+"] action..영업진행현황 조회 발행 건 수정]");
						log.debug("[영업진행현황 조회 발행 건 수정 건 Product Code Regist End action..영업진행현황 조회 발행 건 수정 건]");
					}else{
						msg = "상품코드 등록(Batch_SQL)실패하였습니다.(영업진행현황 조회 발행 건 경우 상품코드 실패 Case 관리자에게 문의바랍니다.)";
					}
				}
			model.put("curPage",String.valueOf(curPageCnt));
			
	        msg = "수정에  성공하였습니다";
	        if(retVal < 1) msg = "수정에 실패하였습니다";
	        
	        return alertAndExit(model,msg,request.getContextPath()+"/B_Estimate.do?cmd=estimatePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt+"&type="+type,"back");
		}
		/**
		 * 견적서 정보를 삭제한다.
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward estimateDelete(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
				String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			String msg = "";
			int retVal = 0;
			int curPageCnt = 0;		
			curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			String type = StringUtil.nvl(request.getParameter("type"),"");
			String public_no = StringUtil.nvl(request.getParameter("public_no"),"");
			String PROJECT_PK_CODE = StringUtil.nvl(request.getParameter("PROJECT_PK_CODE"),"");
			String ContractCode	= StringUtil.nvl(request.getParameter("ContractCode"),"");
			System.out.println("code:"+ContractCode);
			String contract_yn = StringUtil.nvl(request.getParameter("contract_yn"),"");
			System.out.println("contractYN:"+contract_yn);
			
			EstimateDAO estimateDao = new EstimateDAO();
			EstimateDTO estimateDto = new EstimateDTO(); 
			
			//2013_04_29(월) shbyeon. 추가 (영업진행현황 메뉴와 견적서 메뉴 연동을 위해.)
			CurrentStatusDAO csDao = new CurrentStatusDAO();
			CurrentStatusDTO csDto = new CurrentStatusDTO();
			
			/*
			//2013_11_27(수) shbyeon. 추가(계약관리 메뉴와 견적서 메뉴 연동을 위해.)
			ContractManageDAO cmDao = new ContractManageDAO();
			ContractManageDTO cmDto = new ContractManageDTO();
			*/
			
			estimateDto.setMod_id(USERID);
			estimateDto.setPublic_no(public_no);
			
			retVal = estimateDao.deleteEstimateOne(estimateDto);
			log.debug("[견적서 삭제 DB = T_ESTIMATE 성공여부[1]=성공! , [1]이 아닌값 실패! 최종 RESULT:["+retVal+"]값]");
		if(retVal == 1){
			if(PROJECT_PK_CODE != ""){
				log.debug("[영업진행현황 연동 관련 삭제 loop Start action..]");
				csDao = new CurrentStatusDAO();
				csDto = new CurrentStatusDTO();
				
				csDto.setPreSalesCode(PROJECT_PK_CODE);//견적서 발행으로 받은 영업진행현황 셋팅 pk
				csDto.setPublicNo(public_no); 		   //견적서 발행으로 받은 견적번호 셋팅
				
				csDto = estimateDao.getPubSelect(csDto); //영업진행현황 매핑 견적서 삭제 시 이전에 영업진행현황 매핑으로 등록한 견적서가 있다면 데이터 가져오기 DAO
				log.debug("[영업진행현황 매핑 등록한 견적서 이전 데이터 Select Start action..]");
				log.debug("[영업진행현황 매핑 등록한 견적서 이전 데이터 Select 견적서 발행번호:["+public_no+"] action..]");
				log.debug("[영업진행현황 매핑 등록한 견적서 이전 데이터 Select 영업진행현황 코드 값:["+csDto.getPreSalesCode()+"] action..]");
				log.debug("[영업진행현황 매핑 등록한 견적서 이전 데이터 Select End action..]");
			
				log.debug("[해당 견적서를 삭제 한다. 견적서 발행번호:["+public_no+"] action..]");
				log.debug("[견적서 발행번호:["+public_no+"]의 영업진행현황 코드 값이 Null이면 영업진행현황 초기 셋팅! , 코드 값이 있다면 이전 견적서로 셋팅! action..]");
				//견적서 그전 데이터 가 존재하지 않을 경우 영업진행현황 초기값으로 Update.
				if(csDto.getPreSalesCode() == null){
				log.debug("[견적서 발행번호:["+public_no+"],영업진행현황 코드 값:["+csDto.getPreSalesCode()+"] 영업진행현황 Mapping 견적서가 없므로 영업진행현황 초기 셋팅 Start! action..영업진행현황 초기 셋팅]");	
					 csDto.setPreSalesCode(PROJECT_PK_CODE);
					 csDto.setOrderStatus("N");
					 int retVal_ProductDel = 0;
					 retVal_ProductDel = csDao.deleteProductAll_EST2(estimateDto);
				log.debug("[영업진행현황 초기 셋팅 상품코드 Delete Count:["+retVal_ProductDel+"] action..영업진행현황 초기 셋팅]");
					 
					 retVal = csDao.currentUpdate_EST2(csDto);
				log.debug("[영진행현황 수정 DB =htSalesCurrentStatus 성공여부[1]=성공! , [1]이 아닌값 실패! 최종 RESULT:["+retVal+"]값 action..영업진행현황 초기 셋팅]");	 
				log.debug("[영업진행현황 Mapping 견적서가 아님. 영업진행현황 초기 셋팅 End! action..영업진행현황 초기 셋팅]");
				log.debug("[영업진행현황 연동 관련 삭제 loop End action..]");
				//견적서(영업진행현황 코드 + 발행번호)이전 데이터가 존재 할 경우 에 으로 (영업진행현황 코드 + 발행번호)기준으로 이전 견적서 데이터로 수정.
				}else{
				log.debug("[견적서 발행번호:["+public_no+"],영업진행현황 코드 값:["+csDto.getPreSalesCode()+"] 영업진행현황 Mapping 견적서가 있으므로 견적서 이전 데이터 셋팅 Start! action..견적서 이전 데이터 셋팅]");	
					csDto.setPreSalesCode(PROJECT_PK_CODE);
					retVal = csDao.currentUpdate_EST(csDto);
				log.debug("[영업진행현황 수정 DB =htSalesCurrentStatus 성공여부[1]=성공! , [1]이 아닌값 실패! 최종 RESULT:["+retVal+"]값 action..견적서 이전 데이터 셋팅]");	
				log.debug("[영업진행현황 Mapping 견적서가 맞음. 견적서 이전 데이터로 셋팅 End! action..견적서 이전 데이터 셋팅]");	
				log.debug("[영업진행현황 연동 관련 삭제 loop End action..]");
				}
			}
			
			/**
			//견적서 발행 계약 = 계약 삭제 건 (계약관리 연동)Loop 시작. 2013_12_13 shbyeon. 요청으로 인해 사용안함.
			int retVal_CmCode_Delete = 0;
			if(contract_yn.equals("Y") && !ContractCode.equals("")){
			log.debug("[견적서 발행 건 계약 = 계약 인 경우 삭제 시 실행되는 Loop Start action..(계약관리 연동)]");
			cmDto.setContractCode(ContractCode);
			cmDto.setPublic_No(public_no);
			retVal_CmCode_Delete = estimateDao.contractDeleteCode(cmDto);
			log.debug("[견적서 발행 건 계약  = 계약 인 삭제 DB=htContractManagement Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal_CmCode_Delete+"] action..견적서 발행 건 계약  = 계약 삭제 (계약관리 연동)]");
				int retVal_Cm_Code = 0; //견적서 계약 = 계약 삭제 시 정상 값. 변수
				if(retVal_CmCode_Delete == 1){
				log.debug("[견적서 계약관리 연동 계약코드 데이터 정상 삭제 성공으로 견적서에 연동 되있는 계약 코드번호 삭제 Start action..(계약관리 연동)]");
				log.debug("[삭제된 계약관리 코드번호:["+cmDto.getContractCode()+"] 및 견적번호:["+cmDto.getPublic_No()+"] action..삭제된 계약관리 (계약관리 연동)]");
				estimateDto.setPublic_no(cmDto.getPublic_No());
				estimateDto.setContractCode(""); //계약관리 코드연동을 끊어주기 위해 빈값으로 셋팅함.
				retVal_Cm_Code = estimateDao.contractInsertCode(estimateDto);
				log.debug("[견적서 계약관리 연동 코드 DB=htContractManagement Success 여부: 성공[1] 실패[1보다 크거나 작으면] = 결과 값:["+retVal_Cm_Code+"] action..견적서 계약관리 연동 코드 (계약관리 연동)");
				log.debug("[견적서 발행 건 계약 = 계약으로 삭제 시 실행되는 Loop End action..(계약관리 연동)]");	
				}else{
				log.debug("[견적서 계약관리 연동 코드 Delete Failed! action.. End 실패 = > Result 값 :["+retVal_Cm_Code+"] action..견적서 계약관리 연동 코드 (계약관리 연동)");	
				msg = "견적서 발행 건 삭제  Error 관리자에게 문의하세요.";	
			    return alertAndExit(model,msg,request.getContextPath()+"/jsp/hueware/common/error.jsp","back");
				}
			}
			//견적서 발행 계약 = 계약 삭제 건 (계약관리 연동)Loop 끝. 2013_12_13 shbyeon. 요청으로 인해 사용안함.
			**/
		}else{
			log.debug("[견적서 발행 건 삭제 Delete Failed! action.. End 실패 = > Result 값 :["+retVal+"] action..견적서 발행 건 삭제");	
		}
			
	        msg = "삭제에  성공하였습니다";
	        if(retVal < 1) msg = "삭제에 실패하였습니다";
	        
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_Estimate.do?cmd=estimatePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt+"&type="+type,"back");		
		}
		/**
		 * 견적서별 세금계산서 리스트
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward invoiceDetailList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			String publicno = StringUtil.nvl(request.getParameter("publicno"),"");
			String title = StringUtil.nvl(request.getParameter("title"),"");	
			InvoiceDAO invoiceDao = new InvoiceDAO();
			InvoiceDTO invoiceDto = new InvoiceDTO();
			
			invoiceDto.setPublic_no(publicno);
			invoiceDto.setTITLE(title);
			ArrayList<InvoiceDTO> arrlist  = invoiceDao.getInvoiceListDetail(invoiceDto);

			model.put("arrlist",arrlist);
			model.put("publicno",publicno);
			model.put("title",title);
			
			return actionMapping.findForward("invoiceDetailList");
		}
		/**
		 * 견적서 리스트(Excel)
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward estimateExcelList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String contractGb = StringUtil.nvl(request.getParameter("contractGb"),"ALL");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
			String EsStartDate = StringUtil.nvl(request.getParameter("EsStartDate"),DateUtil.getDayInterval3(-365));
			System.out.println("EsStartDate:"+EsStartDate);
			String EsEndDate = StringUtil.nvl(request.getParameter("EsEndDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),""));
			System.out.println("EsEndDate:"+EsEndDate);
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
				
			EstimateDAO dao = new EstimateDAO();
			EstimateDTO estimateDTO = new EstimateDTO();

			estimateDTO.setSearchGb(searchGb);
			estimateDTO.setSearchTxt(searchtxt);
			estimateDTO.setContract_yn(contractGb);
			estimateDTO.setEsStartDate(EsStartDate); //달력조회 날짜 셋팅해줌. 2013_05_29(수)shbyeon.
			estimateDTO.setEsEndDate(EsEndDate); //달력조회 날짜 셋팅해줌. 2013_05_29(수)shbyeon.
			
			ArrayList<EstimateDTO> arrlist = dao.getEstimateListExcel(estimateDTO);

			model.put("listInfo",arrlist);	
			
			return actionMapping.findForward("estimateExcelList");
		}
	
		/**
		 * 계약코드 미발행 현황 리스트
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward contractCodeUnissued(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			/*//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
			String EsStartDate = StringUtil.nvl(request.getParameter("EsStartDate"),DateUtil.getDayInterval3(-365));
			System.out.println("EsStartDate:"+EsStartDate);
			String EsEndDate = StringUtil.nvl(request.getParameter("EsEndDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),""));
			System.out.println("EsEndDate:"+EsEndDate);*/
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
				
			EstimateDAO estimateDao = new EstimateDAO();
			EstimateDTO estimateDto = new EstimateDTO();

			
			estimateDto.setCurPage(curPageCnt);
			estimateDto.setSearchGb(searchGb);
			estimateDto.setSearchTxt(searchtxt);
//			estimateDto.setEsStartDate(EsStartDate);
//			estimateDto.setEsEndDate(EsEndDate);
			estimateDto.setnRow(10);
			ListDTO ld = estimateDao.contractCodeUnissued(estimateDto);

			model.put("listInfo",ld);	
			
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("searchGb",searchGb);
			model.put("searchtxt",searchtxt);
//			model.put("EsStartDate", EsStartDate);
//			model.put("EsEndDate", EsEndDate);
			
			return actionMapping.findForward("contractCodeUnissued");
		}
		
		/**
		 * 계약코드 미발행 현황 Excel 리스트
		 * @param actionMapping
		 * @param actionForm
		 * @param request
		 * @param response
		 * @param model
		 * @return
		 * @throws Exception
		 */
		public ActionForward contractCodeUnissuedExcelList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			/*//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
			String EsStartDate = StringUtil.nvl(request.getParameter("EsStartDate"),DateUtil.getDayInterval3(-365));
			System.out.println("EsStartDate:"+EsStartDate);
			String EsEndDate = StringUtil.nvl(request.getParameter("EsEndDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),""));
			System.out.println("EsEndDate:"+EsEndDate);*/
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
				
			EstimateDAO estimateDao = new EstimateDAO();
			EstimateDTO estimateDto = new EstimateDTO();

			
			estimateDto.setCurPage(curPageCnt);
			estimateDto.setSearchGb(searchGb);
			estimateDto.setSearchTxt(searchtxt);
//			estimateDto.setEsStartDate(EsStartDate);
//			estimateDto.setEsEndDate(EsEndDate);
			estimateDto.setnRow(10);
			ListDTO ld = estimateDao.contractCodeUnissuedExcelList(estimateDto);

			model.put("listInfo",ld);	
//			model.put("curPage",String.valueOf(curPageCnt));
//			model.put("searchGb",searchGb);
//			model.put("searchtxt",searchtxt);
//			model.put("EsStartDate", EsStartDate);
//			model.put("EsEndDate", EsEndDate);
			
			return actionMapping.findForward("contractCodeUnissuedExcelList");
		}
}
