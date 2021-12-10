
package com.huation.hueware.baroinvoice.action;


import java.text.*;
import java.util.*;

import java.io.*;
import java.net.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huation.common.BaseDAO;
import com.huation.common.CommonDAO;
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
import com.huation.common.util.DateSetter;
import com.huation.common.util.DateUtil;
import com.huation.common.user.UserMemDTO;
import com.huation.common.user.UserConnectDTO;
import com.huation.common.user.UserDAO;
import com.huation.common.user.UserDTO;

import com.huation.common.estimate.EstimateDTO;
import com.huation.common.invoice.InvoiceDAO;
import com.huation.common.invoice.InvoiceDTO;
import com.huation.common.bankmanage.BankManageDTO;
import com.huation.common.bankmanage.BankManageDAO;
import com.huation.common.company.CompanyDAO;
import com.oreilly.servlet.MultipartRequest;
import com.sun.mail.handlers.multipart_mixed;

import com.baroservice.*;
import com.baroservice.ws.*;



public class BaroInvoiceAction extends StrutsDispatchAction{
	
	//국세청 발행 테스트키
	//public static String INVOICE_KEY = config.getString("framework.hueware.invocekey_dev");
	//실서버키
	public static String INVOICE_KEY = config.getString("framework.hueware.invocekey");
	
	
	
	//세금계산서 상세 정보 
	public ActionForward baroInvoiceView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		int curPageCnt = 0;
		String invoice_code = "";  //계산서 코드
		
		curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		String gun= StringUtil.nvl(request.getParameter("gun"),"");    	
		String ho= StringUtil.nvl(request.getParameter("ho"),"");    	
		String manage_no= StringUtil.nvl(request.getParameter("manage_no"),"");    	
		String pre_deposit_an = StringUtil.nvl(request.getParameter("pre_deposit_an"),"");
		String mgtkey = StringUtil.nvl(request.getParameter("mgkey"),"");
		
		
		InvoiceDAO invoiceDao = new InvoiceDAO();
		InvoiceDTO invoiceDto = new InvoiceDTO(); 
		EstimateDTO esDto = new EstimateDTO();
		
		invoiceDto.setGun(gun);
		invoiceDto.setHo(ho);
		invoiceDto.setManage_no(manage_no);
		invoiceDto.setPre_deposit_an(pre_deposit_an);
		invoiceDto.setMGTKEY(mgtkey);
	
	
		invoiceDto = invoiceDao.getInvoiceView(invoiceDto);
		
		
		
		DateSetter dateSetter1 = new DateSetter( invoiceDto.getPublic_dt() , "99991231" );
		DateSetter dateSetter2 = new DateSetter( invoiceDto.getDeposit_dt() , "99991231" ,"s1" );
		DateSetter dateSetter3 = new DateSetter( invoiceDto.getPre_deposit_dt() , "99991231" ,"s2" );
		model.put("dateSetter1", dateSetter1 );
		model.put("dateSetter2", dateSetter2 );
		model.put("dateSetter3", dateSetter3 );
	    model.put("invoiceDto", invoiceDto);
	    model.put("esDto", esDto);
	   /* model.put("itemList", itemList);//상품코드 Array
*/		model.put("curPage",String.valueOf(curPageCnt));
		model.put("gun",gun);
		model.put("ho",ho);
		model.put("manage_no",manage_no);
		model.put("searchGb", searchGb);
		model.put("searchtxt", searchtxt);
		
	    if(invoiceDto == null){
			String msg = "해당  업체  정보가 없습니다.";
			return alertAndExit(model, msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");
	    }else{
	    	return actionMapping.findForward("baroInvoiceView");
		}
	}
	
	
	
	//세금계산서 페이지리스트
	public ActionForward baroInvoicePageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
//		String IvStartDate = StringUtil.nvl(request.getParameter("IvStartDate"),DateUtil.getDayInterval3(-365));
		//2019_02_19 조회시작일을 당해년도 1월1일로 설정
		String today = DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-");
		String currentYear = "2019";
		if (today.length() >= 4) {
			currentYear = today.substring(0,4);
		}
		String IvStartDate = StringUtil.nvl(request.getParameter("IvStartDate"),currentYear+"-01-01");
		System.out.println("IvStartDate:"+IvStartDate);
		String IvEndDate = StringUtil.nvl(request.getParameter("IvEndDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
		System.out.println("IvEndDate:"+IvEndDate);
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		
		System.out.println("#####################################"+INVOICE_KEY);
			
		InvoiceDAO invoiceDao = new InvoiceDAO();

		ListDTO ld = invoiceDao.invoicePageList(curPageCnt, searchGb, searchtxt,IvStartDate, IvEndDate, 10, 10);
		InvoiceDTO invoiceDto = invoiceDao.getSumSupplyPrice(searchGb, searchtxt,IvStartDate, IvEndDate);

		model.put("listInfo",ld);	
		
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);
		model.put("IvStartDate", IvStartDate);
		model.put("IvEndDate", IvEndDate);
		model.put("invoiceDto", invoiceDto);
		
		return actionMapping.findForward("baroInvoicePageList");
	}
	
	//바로빌연동 액션, 세금계산서리스트에서 보기 버튼 클릭시 이벤트발생
	public ActionForward invoiceDetailView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		
		
		String MgtNum1 = StringUtil.nvl(request.getParameter("mgkey"),"");
		String sForm = StringUtil.nvl(request.getParameter("sForm"),"");
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			

		  
		String CERTKEY = INVOICE_KEY;				//발행 인증키

		String CorpNum = "1088193762";				//연계사업자 사업자번호 ('-' 제외, 10자리)
		String MgtKey = MgtNum1;					//자체문서관리번호
		String ID = "huation";						//연계사업자 아이디
		String PWD = "huation@2100";					//연계사업자 비밀번호
		
		BaroService_TISoapProxy BST = new BaroService_TISoapProxy();
		
		String Result = BST.getTaxInvoicePopUpURL(CERTKEY, CorpNum, MgtKey, ID, PWD);

		int intResult; 
		
		try{
			intResult = Integer.parseInt(Result);
		}catch(NumberFormatException e){
			intResult = 0;
		}
		
		if (intResult < 0){
			System.out.println("오류코드 : " + Result + "<br><br>" + BST.getErrString(CERTKEY, intResult));
			response.setContentType("text/html; charset=euc-kr");
			response.getWriter().print("fail");
		}else{		
			String URL1 =  Result;	//URL
						
			response.setContentType("text/html; charset=euc-kr");
			response.getWriter().print(URL1);
			
		}       
		return null;
     
	}/**
		 * 세금계산서 등록처리
		 * @param String 
		 * @return ActionForward
		 * @throws DAOException
		 */
		//바로빌 연동 및 휴웨어 디비에 값 넣기
		public ActionForward baroRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			
			
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			//로그인 처리 
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
					String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
// 			로그인 처리 끝.
			
			
			
			//세금계산서 에 넣을 값//
			//공통부분//
			int TaxType = StringUtil.nvl(request.getParameter("TaxType"),1);
			int InvoiceeType = StringUtil.nvl(request.getParameter("InvoiceeType"),1);
			String Kwon= StringUtil.nvl(request.getParameter("Kwon"),"");
			String Ho= StringUtil.nvl(request.getParameter("Ho"),"");
			String SerialNum= StringUtil.nvl(request.getParameter("SerialNum"),"");
			
			String AmountTotal2= StringUtil.nvl(request.getParameter("AmountTotal"),"");
			String TaxTotal2= StringUtil.nvl(request.getParameter("TaxTotal"),"");
			String Remark1= StringUtil.nvl(request.getParameter("Remark1"),"");
			String Remark2= StringUtil.nvl(request.getParameter("Remark2"),"");
			String Remark3= StringUtil.nvl(request.getParameter("Remark3"),"");
			String WriteDT= StringUtil.nvl(request.getParameter("WriteDT"),"");
			String issuetype= StringUtil.nvl(request.getParameter("issuetype"),"");
			String contractno= StringUtil.nvl(request.getParameter("contract_no"),"");
			
			
			
			
			String AmountTotal = AmountTotal2.replaceAll(",","");
			String TaxTotal = TaxTotal2.replaceAll(",", "");
			
			//품목//
			String[] ItemName = request.getParameterValues("ItemName");
			String[] PurchaseDT1= request.getParameterValues("PurchaseDT");
			String[] PurchaseDT2= request.getParameterValues("PurchaseDT1");
			String[] PurchaseDT3= request.getParameterValues("PurchaseDT2");
			String[] Spec= request.getParameterValues("Spec");
			String[] Qty= request.getParameterValues("Qty_view");
			String[] UnitCost= request.getParameterValues("UnitCost_view");
			String[] Amount= request.getParameterValues("Amount_view");
			String[] Tax= request.getParameterValues("Tax_view");
			String[] Remark= request.getParameterValues("Remark");
			
			System.out.println("ItemName : "+ItemName);
			System.out.println("PurchaseDT1 : "+PurchaseDT1);
			System.out.println("PurchaseDT2 : "+PurchaseDT2);
			System.out.println("PurchaseDT3 : "+PurchaseDT3);
			System.out.println("Spec : "+Spec);
			System.out.println("Qty : "+Qty);
			System.out.println("UnitCost : "+UnitCost);
			System.out.println("Amount : "+Amount);
			System.out.println("Tax : "+Tax);
			System.out.println("Remark : "+Remark);
			
			///////
			
			
			
			
			
			
			
			
			int PurposeType = StringUtil.nvl(request.getParameter("PurposeType"),1);
			
			String TotalAmount2= StringUtil.nvl(request.getParameter("TotalAmount"),"");
			String TotalAmount = TotalAmount2.replaceAll(",","");
			
			//공급자//
			String InvoicerCorpNum= StringUtil.nvl(request.getParameter("InvoicerCorpNum"),"");
			String InvoicerTaxRegID= StringUtil.nvl(request.getParameter("InvoicerTaxRegID"),"");
			String InvoicerCorpName= StringUtil.nvl(request.getParameter("InvoicerCorpName"),"");
			String InvoicerCEOName= StringUtil.nvl(request.getParameter("InvoicerCEOName"),"");
			String InvoicerAddr= StringUtil.nvl(request.getParameter("InvoicerAddr"),"");
			String InvoicerBizType= StringUtil.nvl(request.getParameter("InvoicerBizType"),"");
			String InvoicerBizClass= StringUtil.nvl(request.getParameter("InvoicerBizClass"),"");
			String InvoicerContactName1= StringUtil.nvl(request.getParameter("InvoicerContactName1"),"");
			String InvoicerTEL1= StringUtil.nvl(request.getParameter("InvoicerTEL1"),"");
			String InvoicerEmail1= StringUtil.nvl(request.getParameter("InvoicerEmail1"),"");
			/////////
			
			//공급받는자//
			String InvoiceeCorpNum= StringUtil.nvl(request.getParameter("InvoiceeCorpNum"),"");
			String InvoiceeTaxRegID= StringUtil.nvl(request.getParameter("InvoiceeTaxRegID"),"");
			String InvoiceeCorpName= StringUtil.nvl(request.getParameter("InvoiceeCorpName"),"");
			String InvoiceeCEOName= StringUtil.nvl(request.getParameter("InvoiceeCEOName"),"");
			String InvoiceeAddr= StringUtil.nvl(request.getParameter("InvoiceeAddr"),"");
			String InvoiceeBizType= StringUtil.nvl(request.getParameter("InvoiceeBizType"),"");
			String InvoiceeBizClass= StringUtil.nvl(request.getParameter("InvoiceeBizClass"),"");
			String InvoiceeContactName1= StringUtil.nvl(request.getParameter("InvoiceeContactName1"),"");
			String InvoiceeTEL1= StringUtil.nvl(request.getParameter("InvoiceeTEL1"),"");
			String InvoiceeEmail1= StringUtil.nvl(request.getParameter("InvoiceeEmail1"),"");
			/////////
			System.out.println("InvoiceeCorpNum:"+InvoiceeCorpNum);
			System.out.println("AmountTotal:"+AmountTotal);
			System.out.println("1:"+TaxTotal);
			
			//ToDay String by YYYYMMDD
			DecimalFormat df = new DecimalFormat("00");	
			Calendar cal = Calendar.getInstance();	
			String Today = Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE));
			String MgtNum = Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE))+df.format(cal.getTimeInMillis());

			
								//인증키
			String CERTKEY = INVOICE_KEY;				//발행 인증키
			String CorpNum = "1088193762";				//연계사업자 사업자번호 ('-' 제외, 10자리)
			System.out.println("1:"+TaxTotal);
			//전자세금계산서 내용 채우기
			TaxInvoice clsTI = new TaxInvoice();
			
			clsTI.setIssueDirection(1);					//1-정발행, 2-역발행(위수탁 세금계산서는 정발행만 허용)
			clsTI.setTaxInvoiceType(1);					//1-세금계산서, 2-계산서, 4-위수탁세금계산서, 5-위수탁계산서

			//-------------------------------------------
			//과세형태
			//-------------------------------------------
			//TaxInvoiceType 이 1,4 일 때 : 1-과세, 2-영세
			//TaxInvoiceType 이 2,5 일 때 : 3-면세
			//-------------------------------------------
			clsTI.setTaxType(1);

			clsTI.setTaxCalcType(1);					//세율계산방법 : 1-절상, 2-절사, 3-반올림
			clsTI.setPurposeType(2);					//1-영수, 2-청구

			//-------------------------------------------
			//수정사유코드
			//-------------------------------------------
			//수정세금계산서를 작성하는 경우에 사용
			//1-기재사항의 착오 정정, 2-공급가액의 변동, 3-재화의 환입, 4-계약의 해제, 5-내국신용장 사후개설, 6-착오에 의한 이중발행
			//-------------------------------------------
				
			
			if(issuetype.equals("02")){
			clsTI.setModifyCode("1");
			}
			
			
			clsTI.setKwon(request.getParameter(Kwon));							//별지서식 11호 상의 [권] 항목
			clsTI.setHo(Ho);							//별지서식 11호 상의 [호] 항목
			clsTI.setSerialNum(SerialNum);				//별지서식 11호 상의 [일련번호] 항목

			//-------------------------------------------
			//공급가액 총액
			//-------------------------------------------
			clsTI.setAmountTotal(AmountTotal);
			
			//-------------------------------------------
			//세액합계
			//-------------------------------------------
			//clsTI.setTaxType 이 2 또는 3 으로 셋팅된 경우 0으로 입력
			//-------------------------------------------
			clsTI.setTaxTotal(TaxTotal);

			//-------------------------------------------
			//합계금액
			//-------------------------------------------
			//공급가액 총액 + 세액합계 와 일치해야 합니다.
			//-------------------------------------------
			clsTI.setTotalAmount(TotalAmount);

			clsTI.setCash("");							//현금
			clsTI.setChkBill("");						//수표
			clsTI.setNote("");							//어음
			clsTI.setCredit("");						//외상미수금

			clsTI.setRemark1(Remark1);
			clsTI.setRemark2(Remark2);
			clsTI.setRemark3(Remark3);

			clsTI.setWriteDate(WriteDT);					//작성일자 (YYYYMMDD), 공백입력 시 Today로 작성됨.
			System.out.println("2:"+TaxTotal);
			//-------------------------------------------
			//공급자 정보 - 정발행시 세금계산서 작성자
			//-------------------------------------------
			clsTI.setInvoicerParty(new InvoiceParty());
			clsTI.getInvoicerParty().setMgtNum(MgtNum);							//정발행시 필수입력 - 자체문서관리번호
			clsTI.getInvoicerParty().setCorpNum("1088193762");						//필수입력 - 연계사업자 사업자번호 (//-// 제외, 10자리)
			clsTI.getInvoicerParty().setTaxRegID(InvoicerTaxRegID);
			clsTI.getInvoicerParty().setCorpName(InvoicerCorpName);			//필수입력
			clsTI.getInvoicerParty().setCEOName(InvoicerCEOName);				//필수입력
			clsTI.getInvoicerParty().setAddr(InvoicerAddr);
			clsTI.getInvoicerParty().setBizType(InvoicerBizType);
			clsTI.getInvoicerParty().setBizClass(InvoicerBizClass);
			clsTI.getInvoicerParty().setContactID("huation");						//필수입력 - 담당자 바로빌 아이디
			clsTI.getInvoicerParty().setContactName(InvoicerContactName1);				//필수입력
			clsTI.getInvoicerParty().setTEL(InvoicerTEL1);
			clsTI.getInvoicerParty().setHP(InvoicerTEL1);
			clsTI.getInvoicerParty().setEmail(InvoicerEmail1);			//필수입력

			//-------------------------------------------
			//공급받는자 정보 - 역발행시 세금계산서 작성자
			//-------------------------------------------
			clsTI.setInvoiceeParty(new InvoiceParty());
			clsTI.getInvoiceeParty().setMgtNum("");							//역발행시 필수입력 - 자체문서관리번호
			clsTI.getInvoiceeParty().setCorpNum(InvoiceeCorpNum);				//필수입력
			clsTI.getInvoiceeParty().setTaxRegID(InvoiceeTaxRegID);
			clsTI.getInvoiceeParty().setCorpName(InvoiceeCorpName);		//필수입력
			clsTI.getInvoiceeParty().setCEOName(InvoiceeCEOName);				//필수입력
			clsTI.getInvoiceeParty().setAddr(InvoiceeAddr);
			clsTI.getInvoiceeParty().setBizType(InvoiceeBizType);
			clsTI.getInvoiceeParty().setBizClass(InvoiceeBizClass);
			clsTI.getInvoiceeParty().setContactID("");						//역발행시 필수입력 - 담당자 바로빌 아이디
			clsTI.getInvoiceeParty().setContactName(InvoiceeContactName1);				//필수입력
			clsTI.getInvoiceeParty().setTEL(InvoiceeTEL1);
			/*clsTI.getInvoiceeParty().setHP(InvoiceeTEL1);*/
			clsTI.getInvoiceeParty().setEmail(InvoiceeEmail1);			//역발행시 필수입력

			System.out.println("3:"+TaxTotal);
			//현재 사용 안함
		/*	//-------------------------------------------
			//수탁자 정보 - 위수탁 발행시 세금계산서 작성자
			//-------------------------------------------
			clsTI.setBrokerParty(new InvoiceParty());
			clsTI.getBrokerParty().setMgtNum("");							//위수탁발행시 필수입력 - 자체문서관리번호
			clsTI.getBrokerParty().setCorpNum("");							//위수탁발행시 필수입력 - 연계사업자 사업자번호 (//-// 제외, 10자리)
			clsTI.getBrokerParty().setTaxRegID("");
			clsTI.getBrokerParty().setCorpName("");							//위수탁발행시 필수입력
			clsTI.getBrokerParty().setCEOName("");							//위수탁발행시 필수입력
			clsTI.getBrokerParty().setAddr("");
			clsTI.getBrokerParty().setBizType("");
			clsTI.getBrokerParty().setBizClass("");
			clsTI.getBrokerParty().setContactID("");						//위수탁발행시 필수입력 - 담당자 바로빌 아이디
			clsTI.getBrokerParty().setContactName("");						//위수탁발행시 필수입력
			clsTI.getBrokerParty().setTEL("");
			clsTI.getBrokerParty().setHP("");
			clsTI.getBrokerParty().setEmail("");							//위수탁발행시 필수입력
*/			
			//-------------------------------------------
			//품목
			//-------------------------------------------	
			TaxInvoiceTradeLineItem[] TaxInvoiceTradeLineItems = new TaxInvoiceTradeLineItem[ItemName.length];

			for (int i=0 ; i<TaxInvoiceTradeLineItems.length ; i++){		
				TaxInvoiceTradeLineItems[i] = new TaxInvoiceTradeLineItem();
				TaxInvoiceTradeLineItems[i].setPurchaseExpiry(WriteDT);		//YYYYMMDD
				TaxInvoiceTradeLineItems[i].setName(ItemName[i]);
				TaxInvoiceTradeLineItems[i].setInformation(Spec[i]);
				TaxInvoiceTradeLineItems[i].setChargeableUnit(Qty[i]);
				TaxInvoiceTradeLineItems[i].setUnitPrice(UnitCost[i]);
				TaxInvoiceTradeLineItems[i].setAmount(Amount[i]);
				TaxInvoiceTradeLineItems[i].setTax(Tax[i]);
				TaxInvoiceTradeLineItems[i].setDescription(Remark[i]);
			}

			clsTI.setTaxInvoiceTradeLineItems(TaxInvoiceTradeLineItems);
			
			System.out.println("4:"+TaxTotal);
			//////////////////////////////////////////////////////////////////////
			/*TaxInvoiceTradeLineItem[] TaxInvoiceTradeLineItems = new TaxInvoiceTradeLineItem[4];

			for (int i=0 ; i<TaxInvoiceTradeLineItems.length ; i++){
				
				
				TaxInvoiceTradeLineItems[i] = new TaxInvoiceTradeLineItem();
				TaxInvoiceTradeLineItems[i].setPurchaseExpiry(Today);		//YYYYMMDD
				TaxInvoiceTradeLineItems[i].setName("품목명1-" + (i + 1));
				TaxInvoiceTradeLineItems[i].setInformation("EA1");
				TaxInvoiceTradeLineItems[i].setChargeableUnit("25");
				TaxInvoiceTradeLineItems[i].setUnitPrice("40");
				TaxInvoiceTradeLineItems[i].setAmount("1000");
				TaxInvoiceTradeLineItems[i].setTax("100");
				TaxInvoiceTradeLineItems[i].setDescription("품목비고1-" + (i + 1));
			}

			clsTI.setTaxInvoiceTradeLineItems(TaxInvoiceTradeLineItems);	
*/			System.out.println("1:"+TaxTotal);
			String msg = "";
			
			
			
			//-------------------------------------------
			
			int IssueTiming = 1;	//발행시점 : 1-공급자 직접발행, 2-공급받는자 승인시 자동발행
									//발행예정 기능을 사용한 경우에만 적용됨.
			
			//-------------------------------------------

			BaroService_TISoapProxy BST = new BaroService_TISoapProxy();
			
			int Result = BST.registTaxInvoiceEX(CERTKEY, clsTI.getInvoicerParty().getCorpNum(), clsTI, IssueTiming);		//정발행
			//int Result = BST.registTaxInvoiceReverse(CERTKEY, clsTI.getInvoiceeParty().getCorpNum(), clsTI);				//역발행
			//int Result = BST.registBrokerTaxInvoiceEX(CERTKEY, clsTI.getBrokerParty().getCorpNum(), clsTI, issueTiming);	//위수탁
			
			
			
						
			if (Result < 0){		
			
				msg="세금계산서 등록을 실패하였습니다.  " + BST.getErrString(CERTKEY, Result);
				
				 // System.out.println("오류코드 : " + Result + "<br><br>" + BST.getErrString(CERTKEY, Result));
				  return alertAndExit(model,msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroRegistForm","back");	
			
			}else{		
				System.out.println(Result);	
				/*
				1 : 성공
				*/
			}
			///////여기까지가 임시저장함에 전자계산서 등록////////////
			
			
			
			
		/*	////////전자계산서 국세청 즉시 발행////////////
						//인증키
						//연계사업자 사업자번호 ('-' 제외, 10자리)	
			String MgtKey = MgtNum;					//자체문서관리번호
			boolean SendSMS = false;			//발행 알림문자 전송여부 (발행비용과 별도로 과금됨)
			int NTSSendOption = 1;				//현재 사용되지 않는 항목으로 1을 입력하면 된다.
			boolean ForceIssue = false;			//가산세 부과 여부에 상관없이 발행할지 여부	
			String MailTitle = "";				//발행 알림메일의 제목 (공백이나 Null의 경우 바로빌 기본값으로 전송됨.)

			BaroService_TISoapProxy BST1 = new BaroService_TISoapProxy();
			
			int Result1 = BST.issueTaxInvoice(CERTKEY, CorpNum, MgtKey, SendSMS, NTSSendOption, ForceIssue, MailTitle);
			
			if (Result < 0){		
				System.out.println("오류코드 : " + Result + "<br><br>" + BST.getErrString(CERTKEY, Result));	
			}else{		
				System.out.println("국세청발행:"+Result);	
			}
				1 : 성공
				2 : 성공(포인트 부족으로 SMS 전송실패)
				3 : 성공(이메일 전송실패, SendEmail 함수로 이메일을 재전송 하십시오.)
				
			
			
			/////////////////////////
*/			
			
		
			
			
			//휴웨어 디비에 넣을 값
			String manage_no= "";  
			String maPre="";
			String maNo="";
			
			int retVal = 0;
			String permit_no= StringUtil.nvl(request.getParameter("permit_no"),"");
			String public_dt= StringUtil.nvl(request.getParameter("public_dt"),"");
			
			String state= StringUtil.nvl(request.getParameter("state"),"");
			String TITLE= StringUtil.nvl(request.getParameter("title"),"");
			String pre_deposit_dt= StringUtil.nvl(request.getParameter("pre_deposit_dt"),"");
			String pre_deposit_an= StringUtil.nvl(request.getParameter("pre_deposit_an"),"");
			String reference= StringUtil.nvl(request.getParameter("reference"),"");
			String comp_code= StringUtil.nvl(request.getParameter("comp_code"),"");
			String public_no= StringUtil.nvl(request.getParameter("p_public_no"),"");    	
			String approve_no= StringUtil.nvl(request.getParameter("approve_no"),""); 
			String public_org= StringUtil.nvl(request.getParameter("public_org"),"");
			String deposit_amt= StringUtil.nvl(request.getParameter("deposit_amt"),"0");  
			String deposit_dt= StringUtil.nvl(request.getParameter("deposit_dt"),"");
			
			InvoiceDAO invoiceDao = new InvoiceDAO();
			InvoiceDTO invoiceDto = new InvoiceDTO(); 
			
			
			invoiceDto=invoiceDao.getInvoiceKey(invoiceDto);
			
			log.debug("[getGun]" + invoiceDto.getGun());
			log.debug("[getHo]" + invoiceDto.getHo());
			log.debug("[getManage_no]" + invoiceDto.getManage_no());
				
			if(invoiceDto.getManage_no().equals("MAX") || invoiceDto.getManage_no().equals(null) ){
				msg = "관리번호 생성오류 [100건 이상인경우]";			
		        return alertAndExit(model,msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
			}
			
			 
			 
				String mgtnum5 = MgtNum;
				////////전자계산서 국세청 즉시 발행////////////
							//인증키
							//연계사업자 사업자번호 ('-' 제외, 10자리)	
				String CERTKEY3 = INVOICE_KEY;				//발행 인증키
				
			 	String CorpNum3 = "1088193762";				//연계사업자 사업자번호 ('-' 제외, 10자리)	
				String MgtKey3 = mgtnum5;					//자체문서관리번호
				boolean SendSMS = false;			//발행 알림문자 전송여부 (발행비용과 별도로 과금됨)
				int NTSSendOption = 1;				//현재 사용되지 않는 항목으로 1을 입력하면 된다.
				boolean ForceIssue = false;			//가산세 부과 여부에 상관없이 발행할지 여부	
				String MailTitle = "";				//발행 알림메일의 제목 (공백이나 Null의 경우 바로빌 기본값으로 전송됨.)

				BaroService_TISoapProxy BST3 = new BaroService_TISoapProxy();
				
				int Result4 = BST.issueTaxInvoice(CERTKEY3, CorpNum3, MgtKey3, SendSMS, NTSSendOption, ForceIssue, MailTitle);
				
				if (Result4 < 0){		
					System.out.println("오류코드 : " + Result4 + "<br><br>" + BST.getErrString(CERTKEY3, Result4));	
				}else{		
					System.out.println("국세청발행:"+Result4);	
					/*
					1 : 성공
					2 : 성공(포인트 부족으로 SMS 전송실패)
					3 : 성공(이메일 전송실패, SendEmail 함수로 이메일을 재전송 하십시오.)
					*/
				}
				
				////////세금계산서 상태확인 ////
				//자체문서관리번호
			String ID = "huation";						//연계사업자 아이디
			String PWD = "huation@2100";					//연계사업자 비밀번호
			BaroService_TISoapProxy BST1 = new BaroService_TISoapProxy();//
			BaroService_TISoapProxy BST2 = new BaroService_TISoapProxy();//
			String MgtKey = MgtNum;//
			
			String Result2 = BST1.getTaxInvoicePopUpURL(CERTKEY, CorpNum, MgtKey, ID, PWD);
			TaxInvoiceState Result3 = BST.getTaxInvoiceState(CERTKEY, CorpNum, MgtKey);
			String approveno = Result3.getNTSSendKey();
			int intResult; 
			
			try{
				intResult = Integer.parseInt(Result2);
			}catch(NumberFormatException e){
				intResult = 0;
			}
			
			if (intResult < 0){
				System.out.println("오류코드 : " + Result2 + "<br><br>" + BST2.getErrString(CERTKEY, intResult));	
			}else{		
				System.out.println("<a href=\"" + Result2 + "\" target=\"_blank\">" + Result2 + "</a>");	//URL		
			}	
			invoiceDto.setPublic_no(public_no);
			 invoiceDto.setApprove_no(approveno);
			 invoiceDto.setReceiver(InvoiceeContactName1);
			 invoiceDto.setPublic_dt(WriteDT);
			 invoiceDto.setPublic_org(public_org);
			 invoiceDto.setComp_code(comp_code);
			 invoiceDto.setPermit_no(permit_no);
			 invoiceDto.setDeposit_amt(deposit_amt);
			 invoiceDto.setDeposit_dt(deposit_dt);
			 invoiceDto.setReference(reference);
			 invoiceDto.setReg_id(USERID);
			 invoiceDto.setState(state);
			 invoiceDto.setIssuetype(issuetype);
			 invoiceDto.setSupply_price(AmountTotal);
			 invoiceDto.setVat(TaxTotal);
			 invoiceDto.setPre_deposit_dt(pre_deposit_dt);
			 invoiceDto.setPre_deposit_an(pre_deposit_an);
			 invoiceDto.setTITLE(TITLE);
			 invoiceDto.setMGTKEY(MgtNum);
			 invoiceDto.setIssuetype(issuetype);
			 invoiceDto.setTELL(InvoiceeTEL1);
			 invoiceDto.setE_MAIL(InvoiceeEmail1);
			 invoiceDto.setCONTRACT_CODE(contractno);
			 invoiceDto.setDELETED_YN("N");
			 
			 
					
			 retVal=invoiceDao.addInvoiceItem(MgtNum,WriteDT,ItemName,Spec,Qty,UnitCost,Amount,Tax,Remark);
			 retVal=invoiceDao.addInvoice(invoiceDto);


			 msg = "세금계산서 등록에 성공했습니다.";			
		        if(retVal < 1) msg = "세금계산서 등록에 실패하였습니다";
			
		        return alertAndExit(model,msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");
			/*return actionMapping.findForward("baroRegistForm");*/
		}
		
		
		
		
		/**
		 * 수정세금계산서 취소분 등록 처리
		 * @param String 
		 * @return ActionForward
		 * @throws DAOException
		 */
		//바로빌 연동 및 휴웨어 디비에 값 넣기
		public ActionForward baroModifyRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			
			log.debug("발행취소분 액션시작");
			int curPageCnt1 = StringUtil.nvl(request.getParameter("curPage1"),1);
			String searchGb1 = StringUtil.nvl(request.getParameter("searchGb1"),"");
			String searchtxt1 = StringUtil.nvl(request.getParameter("searchtxt1"),"");
			//로그인 처리 
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
					String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
// 			로그인 처리 끝.
			
			
			
			//세금계산서 에 넣을 값//
			//공통부분//
			int TaxType1 = StringUtil.nvl(request.getParameter("TaxType1"),1);
			int InvoiceeType1 = StringUtil.nvl(request.getParameter("InvoiceeType1"),1);
			String Kwon1= StringUtil.nvl(request.getParameter("Kwon1"),"");
			String Ho1= StringUtil.nvl(request.getParameter("Ho1"),"");
			String SerialNum1= StringUtil.nvl(request.getParameter("SerialNum1"),"");
			
			String modifyFlag = StringUtil.nvl(request.getParameter("modifyFlag"),"");
			
			String AmountTotal1= StringUtil.nvl(request.getParameter("AmountTotal1"),"");
			String TaxTotal1= StringUtil.nvl(request.getParameter("TaxTotal1"),"");
			String Remark11= StringUtil.nvl(request.getParameter("Remark11"),"");
			String Remark21= StringUtil.nvl(request.getParameter("Remark21"),"");
			String Remark31= StringUtil.nvl(request.getParameter("Remark31"),"");
			String WriteDT1= StringUtil.nvl(request.getParameter("WriteDT1"),"");
			String issuetype1= StringUtil.nvl(request.getParameter("issuetype1"),"");
			String contractno1= StringUtil.nvl(request.getParameter("contract1"),"");
			String aprove1= StringUtil.nvl(request.getParameter("aprove1"),"");
			String publicorg = StringUtil.nvl(request.getParameter("publicorg1"),"");
			//품목//
			
			String[] ItemName1 = request.getParameterValues("ItemName1");
			String PurchaseDT11= StringUtil.nvl(request.getParameter("PurchaseDT11"),"");
			String PurchaseDT21= StringUtil.nvl(request.getParameter("PurchaseDT21"),"");
			String[] Spec1= request.getParameterValues("Spec1");
			String[] Qty1= request.getParameterValues("Qty1");
			String[] UnitCost1= request.getParameterValues("UnitCost1");
			String[] Amount1= request.getParameterValues("Amount1");
			String[] Tax1= request.getParameterValues("Tax1");
			String[] Remark1= request.getParameterValues("Remark1");
			///////
			String msg ="";
			
			
			
			
			
			
			
			int PurposeType1 = StringUtil.nvl(request.getParameter("PurposeType1"),1);
			
			String TotalAmount1= StringUtil.nvl(request.getParameter("TotalAmount1"),"");
			
			//공급자//
			String InvoicerCorpNum1= StringUtil.nvl(request.getParameter("InvoicerCorpNum1"),"");
			String InvoicerTaxRegID1= StringUtil.nvl(request.getParameter("InvoicerTaxRegID1"),"");
			String InvoicerCorpName1= StringUtil.nvl(request.getParameter("InvoicerCorpName1"),"");
			String InvoicerCEOName1= StringUtil.nvl(request.getParameter("InvoicerCEOName1"),"");
			String InvoicerAddr1= StringUtil.nvl(request.getParameter("InvoicerAddr1"),"");
			String InvoicerBizType1= StringUtil.nvl(request.getParameter("InvoicerBizType1"),"");
			String InvoicerBizClass1= StringUtil.nvl(request.getParameter("InvoicerBizClass1"),"");
			String InvoicerContactName11= StringUtil.nvl(request.getParameter("InvoicerContactName11"),"");
			String InvoicerTEL11= StringUtil.nvl(request.getParameter("InvoicerTEL11"),"");
			String InvoicerEmail11= StringUtil.nvl(request.getParameter("InvoicerEmail11"),"");
			/////////
			
			//공급받는자//
			String InvoiceeCorpNum1= StringUtil.nvl(request.getParameter("InvoiceeCorpNum1"),"");
			String InvoiceeTaxRegID1= StringUtil.nvl(request.getParameter("InvoiceeTaxRegID1"),"");
			String InvoiceeCorpName1= StringUtil.nvl(request.getParameter("InvoiceeCorpName1"),"");
			String InvoiceeCEOName1= StringUtil.nvl(request.getParameter("InvoiceeCEOName1"),"");
			String InvoiceeAddr1= StringUtil.nvl(request.getParameter("InvoiceeAddr1"),"");
			String InvoiceeBizType1= StringUtil.nvl(request.getParameter("InvoiceeBizType1"),"");
			String InvoiceeBizClass1= StringUtil.nvl(request.getParameter("InvoiceeBizClass1"),"");
			String InvoiceeContactName11= StringUtil.nvl(request.getParameter("InvoiceeContactName11"),"");
			String InvoiceeTEL11= StringUtil.nvl(request.getParameter("InvoiceeTEL11"),"");
			String InvoiceeEmail11= StringUtil.nvl(request.getParameter("InvoiceeEmail11"),"");
			/////////
			System.out.println("InvoiceeCorpNum1:"+InvoiceeCorpNum1);
			System.out.println("AmountTotal1:"+AmountTotal1);
			System.out.println("TaxTotal1:"+TaxTotal1);
			
			
			//ToDay String by YYYYMMDD
			DecimalFormat df = new DecimalFormat("00");	
			Calendar cal = Calendar.getInstance();	
			String Today = Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE));
			String MgtNum1 = Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE))+df.format(cal.getTimeInMillis());

								//인증키
			String CERTKEY1 = INVOICE_KEY;				//발행 인증키
			String CorpNum1 = "1088193762";				//연계사업자 사업자번호 ('-' 제외, 10자리)
			
						
			//전자세금계산서 내용 채우기
			TaxInvoice clsTI = new TaxInvoice();
			
			clsTI.setIssueDirection(1);					//1-정발행, 2-역발행(위수탁 세금계산서는 정발행만 허용)
			clsTI.setTaxInvoiceType(1);					//1-세금계산서, 2-계산서, 4-위수탁세금계산서, 5-위수탁계산서

			//-------------------------------------------
			//과세형태
			//-------------------------------------------
			//TaxInvoiceType 이 1,4 일 때 : 1-과세, 2-영세
			//TaxInvoiceType 이 2,5 일 때 : 3-면세
			//-------------------------------------------
			clsTI.setTaxType(1);

			clsTI.setTaxCalcType(1);					//세율계산방법 : 1-절상, 2-절사, 3-반올림
			clsTI.setPurposeType(2);					//1-영수, 2-청구

			//-------------------------------------------
			//수정사유코드
			//-------------------------------------------
			//수정세금계산서를 작성하는 경우에 사용
			//1-기재사항의 착오 정정, 2-공급가액의 변동, 3-재화의 환입, 4-계약의 해제, 5-내국신용장 사후개설, 6-착오에 의한 이중발행
			//-------------------------------------------
			if(modifyFlag.equals("01")){
				clsTI.setModifyCode("1");	
			}else if(modifyFlag.equals("02")){
				clsTI.setModifyCode("6");
			}else if(modifyFlag.equals("03")){
				clsTI.setModifyCode("2");
			}else if(modifyFlag.equals("04")){
				clsTI.setModifyCode("4");
			}else if(modifyFlag.equals("05")){
				clsTI.setModifyCode("3");
			}
			
			
			clsTI.setKwon(request.getParameter(Kwon1));							//별지서식 11호 상의 [권] 항목
			clsTI.setHo(Ho1);							//별지서식 11호 상의 [호] 항목
			clsTI.setSerialNum(SerialNum1);				//별지서식 11호 상의 [일련번호] 항목

			//-------------------------------------------
			//공급가액 총액
			//-------------------------------------------
			clsTI.setAmountTotal(AmountTotal1);
			
			//-------------------------------------------
			//세액합계
			//-------------------------------------------
			//clsTI.setTaxType 이 2 또는 3 으로 셋팅된 경우 0으로 입력
			//-------------------------------------------
			clsTI.setTaxTotal(TaxTotal1);

			//-------------------------------------------
			//합계금액
			//-------------------------------------------
			//공급가액 총액 + 세액합계 와 일치해야 합니다.
			//-------------------------------------------
			clsTI.setTotalAmount(TotalAmount1);

			clsTI.setCash("");							//현금
			clsTI.setChkBill("");						//수표
			clsTI.setNote("");							//어음
			clsTI.setCredit("");						//외상미수금

			clsTI.setRemark1(Remark11);
			clsTI.setRemark2(Remark21);
			clsTI.setRemark3(Remark31);

			clsTI.setWriteDate(WriteDT1);					//작성일자 (YYYYMMDD), 공백입력 시 Today로 작성됨.

			//-------------------------------------------
			//공급자 정보 - 정발행시 세금계산서 작성자
			//-------------------------------------------
			clsTI.setInvoicerParty(new InvoiceParty());
			clsTI.getInvoicerParty().setMgtNum(MgtNum1);							//정발행시 필수입력 - 자체문서관리번호
			clsTI.getInvoicerParty().setCorpNum("1088193762");						//필수입력 - 연계사업자 사업자번호 (//-// 제외, 10자리)
			clsTI.getInvoicerParty().setTaxRegID(InvoicerTaxRegID1);
			clsTI.getInvoicerParty().setCorpName(InvoicerCorpName1);			//필수입력
			clsTI.getInvoicerParty().setCEOName(InvoicerCEOName1);				//필수입력
			clsTI.getInvoicerParty().setAddr(InvoicerAddr1);
			clsTI.getInvoicerParty().setBizType(InvoicerBizType1);
			clsTI.getInvoicerParty().setBizClass(InvoicerBizClass1);
			clsTI.getInvoicerParty().setContactID("huation");						//필수입력 - 담당자 바로빌 아이디
			clsTI.getInvoicerParty().setContactName(InvoicerContactName11);				//필수입력
			clsTI.getInvoicerParty().setTEL(InvoicerTEL11);
			clsTI.getInvoicerParty().setHP(InvoicerTEL11);
			clsTI.getInvoicerParty().setEmail(InvoicerEmail11);			//필수입력

			//-------------------------------------------
			//공급받는자 정보 - 역발행시 세금계산서 작성자
			//-------------------------------------------
			clsTI.setInvoiceeParty(new InvoiceParty());
			clsTI.getInvoiceeParty().setMgtNum("");							//역발행시 필수입력 - 자체문서관리번호
			clsTI.getInvoiceeParty().setCorpNum(InvoiceeCorpNum1);				//필수입력
			clsTI.getInvoiceeParty().setTaxRegID(InvoiceeTaxRegID1);
			clsTI.getInvoiceeParty().setCorpName(InvoiceeCorpName1);		//필수입력
			clsTI.getInvoiceeParty().setCEOName(InvoiceeCEOName1);				//필수입력
			clsTI.getInvoiceeParty().setAddr(InvoiceeAddr1);
			clsTI.getInvoiceeParty().setBizType(InvoiceeBizType1);
			clsTI.getInvoiceeParty().setBizClass(InvoiceeBizClass1);
			clsTI.getInvoiceeParty().setContactID("");						//역발행시 필수입력 - 담당자 바로빌 아이디
			clsTI.getInvoiceeParty().setContactName(InvoiceeContactName11);				//필수입력
			clsTI.getInvoiceeParty().setTEL(InvoiceeTEL11);
			/*clsTI.getInvoiceeParty().setHP(InvoiceeTEL1);*/
			clsTI.getInvoiceeParty().setEmail(InvoiceeEmail11);			//역발행시 필수입력

			
			//현재사용안함
			/*//-------------------------------------------
			//수탁자 정보 - 위수탁 발행시 세금계산서 작성자
			//-------------------------------------------
			clsTI.setBrokerParty(new InvoiceParty());
			clsTI.getBrokerParty().setMgtNum("");							//위수탁발행시 필수입력 - 자체문서관리번호
			clsTI.getBrokerParty().setCorpNum("");							//위수탁발행시 필수입력 - 연계사업자 사업자번호 (//-// 제외, 10자리)
			clsTI.getBrokerParty().setTaxRegID("");
			clsTI.getBrokerParty().setCorpName("");							//위수탁발행시 필수입력
			clsTI.getBrokerParty().setCEOName("");							//위수탁발행시 필수입력
			clsTI.getBrokerParty().setAddr("");
			clsTI.getBrokerParty().setBizType("");
			clsTI.getBrokerParty().setBizClass("");
			clsTI.getBrokerParty().setContactID("");						//위수탁발행시 필수입력 - 담당자 바로빌 아이디
			clsTI.getBrokerParty().setContactName("");						//위수탁발행시 필수입력
			clsTI.getBrokerParty().setTEL("");
			clsTI.getBrokerParty().setHP("");
			clsTI.getBrokerParty().setEmail("");							//위수탁발행시 필수입력
			*/
			
			//-------------------------------------------
			//품목
			//-------------------------------------------	
			TaxInvoiceTradeLineItem[] TaxInvoiceTradeLineItems = new TaxInvoiceTradeLineItem[ItemName1.length];

			for (int i=0 ; i<TaxInvoiceTradeLineItems.length ; i++){		
				TaxInvoiceTradeLineItems[i] = new TaxInvoiceTradeLineItem();
				TaxInvoiceTradeLineItems[i].setPurchaseExpiry(WriteDT1);		//YYYYMMDD
				TaxInvoiceTradeLineItems[i].setName(ItemName1[i]);
				TaxInvoiceTradeLineItems[i].setInformation(Spec1[i]);
				TaxInvoiceTradeLineItems[i].setChargeableUnit(Qty1[i]);
				TaxInvoiceTradeLineItems[i].setUnitPrice(UnitCost1[i]);
				TaxInvoiceTradeLineItems[i].setAmount(Amount1[i]);
				TaxInvoiceTradeLineItems[i].setTax(Tax1[i]);
				TaxInvoiceTradeLineItems[i].setDescription(Remark1[i]);
			}

			clsTI.setTaxInvoiceTradeLineItems(TaxInvoiceTradeLineItems);
						
			
			String OriginalNTSSenKey = aprove1;	//당초 세금계산서의 국세청 승인번호
			//바로빌을 통해 발행된 세금계산서만 가능합니다.
			
			
			
			//-------------------------------------------
		
			//-------------------------------------------

			BaroService_TISoapProxy BST = new BaroService_TISoapProxy();
			
			int Result = BST.registModifyTaxInvoice(CERTKEY1, clsTI.getInvoicerParty().getCorpNum(), clsTI, OriginalNTSSenKey);		//정발행
			//int Result = BST.registTaxInvoiceReverse(CERTKEY, clsTI.getInvoiceeParty().getCorpNum(), clsTI);				//역발행
			//int Result = BST.registBrokerTaxInvoiceEX(CERTKEY, clsTI.getBrokerParty().getCorpNum(), clsTI, issueTiming);	//위수탁
			
			if (Result < 0){		
				msg="세금계산서 등록을 실패하였습니다.  " + BST.getErrString(CERTKEY1, Result);
				
				 // System.out.println("오류코드 : " + Result + "<br><br>" + BST.getErrString(CERTKEY, Result));
				 return alertAndExit(model,msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt1+"&searchGb="+searchGb1+"&searchtxt="+searchtxt1,"back");
			}else{		
				System.out.println("(취소분)임시저장 결과 : "+Result);	
				/*
				1 : 성공
				*/
			}
			///////여기까지가 임시저장함에 전자계산서 등록////////////
	
			
			
			
			
			
			String manage_no= "";  
			String maPre="";
			String maNo="";
		
			int retVal = 0;
			String permit_no= StringUtil.nvl(request.getParameter("permit_no1"),"");
			String public_dt= StringUtil.nvl(request.getParameter("public_dt1"),"");
			
			String state= StringUtil.nvl(request.getParameter("state1"),"");
			String TITLE= StringUtil.nvl(request.getParameter("title1"),"");
			String pre_deposit_dt= StringUtil.nvl(request.getParameter("pre_deposit_dt1"),"");
			String pre_deposit_an= StringUtil.nvl(request.getParameter("pre_deposit_an1"),"");
			String reference= StringUtil.nvl(request.getParameter("reference1"),"");
			String comp_code= StringUtil.nvl(request.getParameter("comp_code1"),"");
			String public_no= StringUtil.nvl(request.getParameter("p_public_no1"),"");    	
			String approve_no= StringUtil.nvl(request.getParameter("approve_no1"),""); 
			String public_org= StringUtil.nvl(request.getParameter("public_org1"),"");
			String deposit_amt= StringUtil.nvl(request.getParameter("deposit_amt1"),"0");  
			String deposit_dt= StringUtil.nvl(request.getParameter("deposit_dt1"),"");
			String contract= StringUtil.nvl(request.getParameter("contract"),"");
			String publicno= StringUtil.nvl(request.getParameter("publicno"),"");
			
			InvoiceDAO invoiceDao = new InvoiceDAO();
			InvoiceDTO invoiceDto = new InvoiceDTO(); 
			
			
			invoiceDto=invoiceDao.getInvoiceKey(invoiceDto);
			
			log.debug("[getGun1]" + invoiceDto.getGun());
			log.debug("[getHo1]" + invoiceDto.getHo());
			log.debug("[getManage_no1]" + invoiceDto.getManage_no());
				
			if(invoiceDto.getManage_no().equals("MAX") || invoiceDto.getManage_no().equals(null) ){
				msg = "관리번호 생성오류 [100건 이상인경우]";			
		        return alertAndExit(model,msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt1+"&searchGb="+searchGb1+"&searchtxt="+searchtxt1,"back");	
			}
			
			
			
			
			
				////////전자계산서 국세청 즉시 발행////////////
						//인증키
						//연계사업자 사업자번호 ('-' 제외, 10자리)	
			String MgtKey1 = MgtNum1;					//자체문서관리번호
			boolean SendSMS = false;			//발행 알림문자 전송여부 (발행비용과 별도로 과금됨)
			int NTSSendOption = 1;				//현재 사용되지 않는 항목으로 1을 입력하면 된다.
			boolean ForceIssue = false;			//가산세 부과 여부에 상관없이 발행할지 여부	
			String MailTitle = "";				//발행 알림메일의 제목 (공백이나 Null의 경우 바로빌 기본값으로 전송됨.)
			
			BaroService_TISoapProxy BST1 = new BaroService_TISoapProxy();
			
			int Result1 = BST.issueTaxInvoice(CERTKEY1, CorpNum1, MgtKey1, SendSMS, NTSSendOption, ForceIssue, MailTitle);
			
			if (Result < 0){		
				System.out.println("(취소분)국세청발행 오류코드 : " + Result + "<br><br>" + BST.getErrString(CERTKEY1, Result));	
			}else{		
				System.out.println("(취소분)국세청발행 결과:	"+Result);	
			}
			/*	1 : 성공
				2 : 성공(포인트 부족으로 SMS 전송실패)
				3 : 성공(이메일 전송실패, SendEmail 함수로 이메일을 재전송 하십시오.)
				
			*/
			
			/////////////////////////
			
	////////세금계산서 상태확인 ////
						//자체문서관리번호
			String ID = "huation";						//연계사업자 아이디
			String PWD = "huation@2100";					//연계사업자 비밀번호
			//BaroService_TISoapProxy BST1 = new BaroService_TISoapProxy();
			BaroService_TISoapProxy BST2 = new BaroService_TISoapProxy();
			//String MgtKey1 = MgtNum1;
			
			String Result2 = BST1.getTaxInvoicePopUpURL(CERTKEY1, CorpNum1, MgtKey1, ID, PWD);
			TaxInvoiceState Result3 = BST.getTaxInvoiceState(CERTKEY1, CorpNum1, MgtKey1);
			String approveno = Result3.getNTSSendKey();
			int intResult; 
			
			try{
			intResult = Integer.parseInt(Result2);
			}catch(NumberFormatException e){
			intResult = 0;
			}
			
			if (intResult < 0){
			
			System.out.println("(취소분) 상태확인 오류코드 : " + Result2 + "<br><br>" + BST2.getErrString(CERTKEY1, intResult));	
			}else{		
			System.out.println("(취소분) 상태확인 결과<a href=\"" + Result2 + "\" target=\"_blank\">" + Result2 + "</a>");	//URL		
			}	
			
			 invoiceDto.setPublic_no(public_no);
			 invoiceDto.setApprove_no(approveno);
			 invoiceDto.setReceiver(InvoiceeContactName11);
			 invoiceDto.setPublic_dt(WriteDT1);
			 invoiceDto.setPublic_org(publicorg);
			 invoiceDto.setComp_code(comp_code);
			 invoiceDto.setPermit_no(permit_no);
			 invoiceDto.setDeposit_amt(deposit_amt);
			 invoiceDto.setDeposit_dt(deposit_dt);
			 invoiceDto.setReference(reference);
			 invoiceDto.setReg_id(USERID);
			 invoiceDto.setState(state);
			 invoiceDto.setIssuetype(issuetype1);
			 invoiceDto.setSupply_price(AmountTotal1);
			 invoiceDto.setVat(TaxTotal1);
			 invoiceDto.setPre_deposit_dt(pre_deposit_dt);
			 invoiceDto.setPre_deposit_an(pre_deposit_an);
			 invoiceDto.setTITLE(TITLE);
			 invoiceDto.setMGTKEY(MgtNum1);
			 invoiceDto.setIssuetype(issuetype1);
			 invoiceDto.setTELL(InvoiceeTEL11);
			 invoiceDto.setE_MAIL(InvoiceeEmail11);
			 invoiceDto.setCONTRACT_CODE(contractno1);
			 invoiceDto.setPublic_no(publicno);
			 invoiceDto.setDELETED_YN("Y");
			 
			 retVal=invoiceDao.addInvoiceItem(MgtNum1,WriteDT1,ItemName1,Spec1,Qty1,UnitCost1,Amount1,Tax1,Remark1);
			 retVal=invoiceDao.addInvoice(invoiceDto);

			 msg = "세금계산서 등록에 성공했습니다.";			
		        if(retVal < 1) msg = "세금계산서 등록에 실패하였습니다";
		        
		        
			
			
			log.debug("발행취소분 액션 종료");
			
			
		       
		        return alertAndExit(model,msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt1+"&searchGb="+searchGb1+"&searchtxt="+searchtxt1,"back");
			/*return actionMapping.findForward("baroRegistForm");*/
		
		}
		
		
		
		
		
		
		/**
		 * 수정세금계산서 등록처리
		 * @param String 
		 * @return ActionForward
		 * @throws DAOException
		 */
		//바로빌 연동 및 휴웨어 디비에 값 넣기
		public ActionForward baroInvoiceModifyRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			
			
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			//로그인 처리 
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
					String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
// 			로그인 처리 끝.
			
			
			//세금계산서 에 넣을 값//
			//공통부분//
			int TaxType = StringUtil.nvl(request.getParameter("TaxType"),1);
			System.out.println("--------------TaxType:"+TaxType);
			int InvoiceeType = StringUtil.nvl(request.getParameter("InvoiceeType"),1);
			System.out.println("--------------InvoiceeType:"+InvoiceeType);
			String Kwon= StringUtil.nvl(request.getParameter("Kwon"),"");
			System.out.println("--------------Kwon:"+Kwon);
			String Ho= StringUtil.nvl(request.getParameter("Ho"),"");
			System.out.println("--------------Ho:"+Ho);
			String SerialNum= StringUtil.nvl(request.getParameter("SerialNum"),"");
			System.out.println("--------------SerialNum:"+SerialNum);
			String AmountTotal2= StringUtil.nvl(request.getParameter("AmountTotal"),"");
			System.out.println("--------------AmountTotal2:"+AmountTotal2);
			String TaxTotal2= StringUtil.nvl(request.getParameter("TaxTotal"),"");
			System.out.println("--------------TaxTotal2:"+TaxTotal2);
			String Remark1= StringUtil.nvl(request.getParameter("Remark1"),"");
			System.out.println("--------------Remark1:"+Remark1);
			String Remark2= StringUtil.nvl(request.getParameter("Remark2"),"");
			System.out.println("--------------Remark2:"+Remark2);
			String Remark3= StringUtil.nvl(request.getParameter("Remark3"),"");
			System.out.println("--------------Remark3:"+Remark3);
			String WriteDT= StringUtil.nvl(request.getParameter("WriteDT"),"");
			System.out.println("--------------WriteDT:"+WriteDT);
			String issuetype= StringUtil.nvl(request.getParameter("issuetype"),"");
			System.out.println("--------------issuetype:"+issuetype);
			String contractno= StringUtil.nvl(request.getParameter("contract_no"),"");
			System.out.println("--------------contractno:"+contractno);
			
			
			
			String AmountTotal = AmountTotal2.replaceAll(",","");
			System.out.println("--------------AmountTotal:"+AmountTotal);
			String TaxTotal = TaxTotal2.replaceAll(",", "");
			System.out.println("--------------TaxTotal:"+TaxTotal);
			//품목//
			String[] ItemName = request.getParameterValues("ItemName");
			System.out.println("--------------ItemName:"+ItemName);
			String[] PurchaseDT1= request.getParameterValues("PurchaseDT");
			System.out.println("--------------PurchaseDT1:"+PurchaseDT1);
			String[] PurchaseDT2= request.getParameterValues("PurchaseDT1");
			System.out.println("--------------PurchaseDT2:"+PurchaseDT2);
			String[] PurchaseDT3= request.getParameterValues("PurchaseDT2");
			System.out.println("--------------PurchaseDT3:"+PurchaseDT3);
			String[] Spec= request.getParameterValues("Spec");
			System.out.println("--------------Spec:"+Spec);
			String[] Qty= request.getParameterValues("Qty_view");
			System.out.println("--------------Qty:"+Qty);
			String[] UnitCost= request.getParameterValues("UnitCost_view");
			System.out.println("--------------UnitCost:"+UnitCost);
			String[] Amount= request.getParameterValues("Amount_view");
			System.out.println("--------------Amount:"+Amount);
			String[] Tax= request.getParameterValues("Tax");
			System.out.println("--------------Tax:"+Tax);
			String[] Remark= request.getParameterValues("Remark");
			System.out.println("--------------Remark:"+Remark);
			///////
			
			
			
			
			
			String TotalAmount2= StringUtil.nvl(request.getParameter("TotalAmount"),"");
			String TotalAmount = TotalAmount2.replaceAll(",","");
			
			
			int PurposeType = StringUtil.nvl(request.getParameter("PurposeType"),1);
			System.out.println("--------------PurposeType:"+PurposeType);
			
			System.out.println("--------------TotalAmount:"+TotalAmount);
			//공급자//
			String InvoicerCorpNum= StringUtil.nvl(request.getParameter("InvoicerCorpNum"),"");
			System.out.println("--------------InvoicerCorpNum:"+InvoicerCorpNum);
			String InvoicerTaxRegID= StringUtil.nvl(request.getParameter("InvoicerTaxRegID"),"");
			System.out.println("--------------InvoicerTaxRegID:"+InvoicerTaxRegID);
			String InvoicerCorpName= StringUtil.nvl(request.getParameter("InvoicerCorpName"),"");
			System.out.println("--------------InvoicerCorpName:"+InvoicerCorpName);
			String InvoicerCEOName= StringUtil.nvl(request.getParameter("InvoicerCEOName"),"");
			System.out.println("--------------InvoicerCEOName:"+InvoicerCEOName);
			String InvoicerAddr= StringUtil.nvl(request.getParameter("InvoicerAddr"),"");
			System.out.println("--------------InvoicerAddr:"+InvoicerAddr);
			String InvoicerBizType= StringUtil.nvl(request.getParameter("InvoicerBizType"),"");
			System.out.println("--------------InvoicerBizType:"+InvoicerBizType);
			String InvoicerBizClass= StringUtil.nvl(request.getParameter("InvoicerBizClass"),"");
			System.out.println("--------------InvoicerBizClass:"+InvoicerBizClass);
			String InvoicerContactName1= StringUtil.nvl(request.getParameter("InvoicerContactName1"),"");
			System.out.println("--------------InvoicerContactName1:"+InvoicerContactName1);
			String InvoicerTEL1= StringUtil.nvl(request.getParameter("InvoicerTEL1"),"");
			System.out.println("--------------InvoicerTEL1:"+InvoicerTEL1);
			String InvoicerEmail1= StringUtil.nvl(request.getParameter("InvoicerEmail1"),"");
			System.out.println("--------------InvoicerEmail1:"+InvoicerEmail1);
			/////////
			
			//공급받는자//
			String InvoiceeCorpNum= StringUtil.nvl(request.getParameter("InvoiceeCorpNum"),"");
			System.out.println("--------------InvoiceeCorpNum:"+InvoiceeCorpNum);
			String InvoiceeTaxRegID= StringUtil.nvl(request.getParameter("InvoiceeTaxRegID"),"");
			System.out.println("--------------InvoiceeTaxRegID:"+InvoiceeTaxRegID);
			String InvoiceeCorpName= StringUtil.nvl(request.getParameter("InvoiceeCorpName"),"");
			System.out.println("--------------InvoiceeCorpName:"+InvoiceeCorpName);
			String InvoiceeCEOName= StringUtil.nvl(request.getParameter("InvoiceeCEOName"),"");
			System.out.println("--------------InvoiceeCEOName:"+InvoiceeCEOName);
			String InvoiceeAddr= StringUtil.nvl(request.getParameter("InvoiceeAddr"),"");
			System.out.println("--------------InvoiceeAddr:"+InvoiceeAddr);
			String InvoiceeBizType= StringUtil.nvl(request.getParameter("InvoiceeBizType"),"");
			System.out.println("--------------InvoiceeBizType:"+InvoiceeBizType);
			String InvoiceeBizClass= StringUtil.nvl(request.getParameter("InvoiceeBizClass"),"");
			System.out.println("--------------InvoiceeBizClass:"+InvoiceeBizClass);
			String InvoiceeContactName1= StringUtil.nvl(request.getParameter("InvoiceeContactName1"),"");
			System.out.println("--------------InvoiceeContactName1:"+InvoiceeContactName1);
			String InvoiceeTEL1= StringUtil.nvl(request.getParameter("InvoiceeTEL1"),"");
			System.out.println("--------------InvoiceeTEL1:"+InvoiceeTEL1);
			String InvoiceeEmail1= StringUtil.nvl(request.getParameter("InvoiceeEmail1"),"");
			System.out.println("--------------InvoiceeEmail1:"+InvoiceeEmail1);
			String aprove = StringUtil.nvl(request.getParameter("aprove"),"");
			System.out.println("--------------aprove:"+aprove);
			String modifyFlag = StringUtil.nvl(request.getParameter("modifyFlag"),"");
			
			
			
			System.out.println("----------------aprove:"+aprove);
			System.out.println("----------------modifyFlag11:"+modifyFlag);
			/////////
			System.out.println("InvoiceeCorpNum:"+InvoiceeCorpNum);
			System.out.println("AmountTotal:"+AmountTotal);
			System.out.println("TaxTotal:"+TaxTotal);
			
			
			//ToDay String by YYYYMMDD
			DecimalFormat df = new DecimalFormat("00");	
			Calendar cal = Calendar.getInstance();	
			String Today = Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE));
			String MgtNum = Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE))+df.format(cal.getTimeInMillis());
			System.out.println("--------------MgtNum:"+MgtNum);
			
			System.out.println("--------------Today:"+Today);
								//인증키
			String CERTKEY = INVOICE_KEY;				//발행 인증키
			String CorpNum = "1088193762";				//연계사업자 사업자번호 ('-' 제외, 10자리)
			
						
			//전자세금계산서 내용 채우기
			TaxInvoice clsTI = new TaxInvoice();
			
			clsTI.setIssueDirection(1);					//1-정발행, 2-역발행(위수탁 세금계산서는 정발행만 허용)
			clsTI.setTaxInvoiceType(1);					//1-세금계산서, 2-계산서, 4-위수탁세금계산서, 5-위수탁계산서

			//-------------------------------------------
			//과세형태
			//-------------------------------------------
			//TaxInvoiceType 이 1,4 일 때 : 1-과세, 2-영세
			//TaxInvoiceType 이 2,5 일 때 : 3-면세
			//-------------------------------------------
			clsTI.setTaxType(1);

			clsTI.setTaxCalcType(1);					//세율계산방법 : 1-절상, 2-절사, 3-반올림
			clsTI.setPurposeType(2);					//1-영수, 2-청구

			//-------------------------------------------
			//수정사유코드
			//-------------------------------------------
			//수정세금계산서를 작성하는 경우에 사용
			//1-기재사항의 착오 정정, 2-공급가액의 변동, 3-재화의 환입, 4-계약의 해제, 5-내국신용장 사후개설, 6-착오에 의한 이중발행
			//-------------------------------------------
				
			
			clsTI.setModifyCode("1");
			
			
			
			clsTI.setKwon(request.getParameter(Kwon));							//별지서식 11호 상의 [권] 항목
			clsTI.setHo(Ho);							//별지서식 11호 상의 [호] 항목
			clsTI.setSerialNum(SerialNum);				//별지서식 11호 상의 [일련번호] 항목

			//-------------------------------------------
			//공급가액 총액
			//-------------------------------------------
			clsTI.setAmountTotal(AmountTotal);
			
			//-------------------------------------------
			//세액합계
			//-------------------------------------------
			//clsTI.setTaxType 이 2 또는 3 으로 셋팅된 경우 0으로 입력
			//-------------------------------------------
			clsTI.setTaxTotal(TaxTotal);

			//-------------------------------------------
			//합계금액
			//-------------------------------------------
			//공급가액 총액 + 세액합계 와 일치해야 합니다.
			//-------------------------------------------
			clsTI.setTotalAmount(TotalAmount);

			clsTI.setCash("");							//현금
			clsTI.setChkBill("");						//수표
			clsTI.setNote("");							//어음
			clsTI.setCredit("");						//외상미수금

			clsTI.setRemark1(Remark1);
			clsTI.setRemark2(Remark2);
			clsTI.setRemark3(Remark3);

			clsTI.setWriteDate(WriteDT);					//작성일자 (YYYYMMDD), 공백입력 시 Today로 작성됨.

			//-------------------------------------------
			//공급자 정보 - 정발행시 세금계산서 작성자
			//-------------------------------------------
			clsTI.setInvoicerParty(new InvoiceParty());
			clsTI.getInvoicerParty().setMgtNum(MgtNum);							//정발행시 필수입력 - 자체문서관리번호
			clsTI.getInvoicerParty().setCorpNum("1088193762");						//필수입력 - 연계사업자 사업자번호 (//-// 제외, 10자리)
			clsTI.getInvoicerParty().setTaxRegID(InvoicerTaxRegID);
			clsTI.getInvoicerParty().setCorpName(InvoicerCorpName);			//필수입력
			clsTI.getInvoicerParty().setCEOName(InvoicerCEOName);				//필수입력
			clsTI.getInvoicerParty().setAddr(InvoicerAddr);
			clsTI.getInvoicerParty().setBizType(InvoicerBizType);
			clsTI.getInvoicerParty().setBizClass(InvoicerBizClass);
			clsTI.getInvoicerParty().setContactID("huation");						//필수입력 - 담당자 바로빌 아이디
			clsTI.getInvoicerParty().setContactName(InvoicerContactName1);				//필수입력
			clsTI.getInvoicerParty().setTEL(InvoicerTEL1);
			clsTI.getInvoicerParty().setHP(InvoicerTEL1);
			clsTI.getInvoicerParty().setEmail(InvoicerEmail1);			//필수입력

			//-------------------------------------------
			//공급받는자 정보 - 역발행시 세금계산서 작성자
			//-------------------------------------------
			clsTI.setInvoiceeParty(new InvoiceParty());
			clsTI.getInvoiceeParty().setMgtNum("");							//역발행시 필수입력 - 자체문서관리번호
			clsTI.getInvoiceeParty().setCorpNum(InvoiceeCorpNum);				//필수입력
			clsTI.getInvoiceeParty().setTaxRegID(InvoiceeTaxRegID);
			clsTI.getInvoiceeParty().setCorpName(InvoiceeCorpName);		//필수입력
			clsTI.getInvoiceeParty().setCEOName(InvoiceeCEOName);				//필수입력
			clsTI.getInvoiceeParty().setAddr(InvoiceeAddr);
			clsTI.getInvoiceeParty().setBizType(InvoiceeBizType);
			clsTI.getInvoiceeParty().setBizClass(InvoiceeBizClass);
			clsTI.getInvoiceeParty().setContactID("");						//역발행시 필수입력 - 담당자 바로빌 아이디
			clsTI.getInvoiceeParty().setContactName(InvoiceeContactName1);				//필수입력
			clsTI.getInvoiceeParty().setTEL(InvoiceeTEL1);
			/*clsTI.getInvoiceeParty().setHP(InvoiceeTEL1);*/
			clsTI.getInvoiceeParty().setEmail(InvoiceeEmail1);			//역발행시 필수입력

			//-------------------------------------------
			//수탁자 정보 - 위수탁 발행시 세금계산서 작성자
			//-------------------------------------------
			clsTI.setBrokerParty(new InvoiceParty());
			clsTI.getBrokerParty().setMgtNum("");							//위수탁발행시 필수입력 - 자체문서관리번호
			clsTI.getBrokerParty().setCorpNum("");							//위수탁발행시 필수입력 - 연계사업자 사업자번호 (//-// 제외, 10자리)
			clsTI.getBrokerParty().setTaxRegID("");
			clsTI.getBrokerParty().setCorpName("");							//위수탁발행시 필수입력
			clsTI.getBrokerParty().setCEOName("");							//위수탁발행시 필수입력
			clsTI.getBrokerParty().setAddr("");
			clsTI.getBrokerParty().setBizType("");
			clsTI.getBrokerParty().setBizClass("");
			clsTI.getBrokerParty().setContactID("");						//위수탁발행시 필수입력 - 담당자 바로빌 아이디
			clsTI.getBrokerParty().setContactName("");						//위수탁발행시 필수입력
			clsTI.getBrokerParty().setTEL("");
			clsTI.getBrokerParty().setHP("");
			clsTI.getBrokerParty().setEmail("");							//위수탁발행시 필수입력
			
			//-------------------------------------------
			//품목
			//-------------------------------------------	
			TaxInvoiceTradeLineItem[] TaxInvoiceTradeLineItems = new TaxInvoiceTradeLineItem[ItemName.length];

			for (int i=0 ; i<TaxInvoiceTradeLineItems.length ; i++){		
				TaxInvoiceTradeLineItems[i] = new TaxInvoiceTradeLineItem();
				TaxInvoiceTradeLineItems[i].setPurchaseExpiry(WriteDT);		//YYYYMMDD
				TaxInvoiceTradeLineItems[i].setName(ItemName[i]);
				TaxInvoiceTradeLineItems[i].setInformation(Spec[i]);
				TaxInvoiceTradeLineItems[i].setChargeableUnit(Qty[i]);
				TaxInvoiceTradeLineItems[i].setUnitPrice(UnitCost[i]);
				TaxInvoiceTradeLineItems[i].setAmount(Amount[i]);
				TaxInvoiceTradeLineItems[i].setTax(Tax[i]);
				TaxInvoiceTradeLineItems[i].setDescription(Remark[i]);
			}

			clsTI.setTaxInvoiceTradeLineItems(TaxInvoiceTradeLineItems);
			//////////////////////////////////////////////////////////////////////
			/*TaxInvoiceTradeLineItem[] TaxInvoiceTradeLineItems = new TaxInvoiceTradeLineItem[4];

			for (int i=0 ; i<TaxInvoiceTradeLineItems.length ; i++){
				
				
				TaxInvoiceTradeLineItems[i] = new TaxInvoiceTradeLineItem();
				TaxInvoiceTradeLineItems[i].setPurchaseExpiry(Today);		//YYYYMMDD
				TaxInvoiceTradeLineItems[i].setName("품목명1-" + (i + 1));
				TaxInvoiceTradeLineItems[i].setInformation("EA1");
				TaxInvoiceTradeLineItems[i].setChargeableUnit("25");
				TaxInvoiceTradeLineItems[i].setUnitPrice("40");
				TaxInvoiceTradeLineItems[i].setAmount("1000");
				TaxInvoiceTradeLineItems[i].setTax("100");
				TaxInvoiceTradeLineItems[i].setDescription("품목비고1-" + (i + 1));
			}

			clsTI.setTaxInvoiceTradeLineItems(TaxInvoiceTradeLineItems);	
*/			
			String OriginalNTSSenKey = aprove;	//당초 세금계산서의 국세청 승인번호
			//바로빌을 통해 발행된 세금계산서만 가능합니다.
			
			String msg ="";
			

			BaroService_TISoapProxy BST = new BaroService_TISoapProxy();
			
			int Result = BST.registModifyTaxInvoice(CERTKEY, clsTI.getInvoicerParty().getCorpNum(), clsTI, OriginalNTSSenKey);		//정발행
			//int Result = BST.registTaxInvoiceReverse(CERTKEY, clsTI.getInvoiceeParty().getCorpNum(), clsTI);				//역발행
			//int Result = BST.registBrokerTaxInvoiceEX(CERTKEY, clsTI.getBrokerParty().getCorpNum(), clsTI, issueTiming);	//위수탁
			
			if (Result < 0){		
				msg="세금계산서 등록을 실패하였습니다.  " + BST.getErrString(CERTKEY, Result);
				
				 // System.out.println("오류코드 : " + Result + "<br><br>" + BST.getErrString(CERTKEY, Result));
				 return alertAndExit(model,msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");
			}else{		
				System.out.println("(수정분)임시저장 결과 : "+Result);	
				/*
				1 : 성공
				*/
			}
			///////여기까지가 임시저장함에 전자계산서 등록////////////
			
			
			
			
			
			
			
			////////전자계산서 국세청 즉시 발행////////////
						//인증키
						//연계사업자 사업자번호 ('-' 제외, 10자리)	
			String MgtKey = MgtNum;					//자체문서관리번호
			boolean SendSMS = false;			//발행 알림문자 전송여부 (발행비용과 별도로 과금됨)
			int NTSSendOption = 1;				//현재 사용되지 않는 항목으로 1을 입력하면 된다.
			boolean ForceIssue = false;			//가산세 부과 여부에 상관없이 발행할지 여부	
			String MailTitle = "";				//발행 알림메일의 제목 (공백이나 Null의 경우 바로빌 기본값으로 전송됨.)

			BaroService_TISoapProxy BST1 = new BaroService_TISoapProxy();
			
			int Result1 = BST.issueTaxInvoice(CERTKEY, CorpNum, MgtKey, SendSMS, NTSSendOption, ForceIssue, MailTitle);
			
			System.out.println("여기까지와야된다고");
			if (Result < 0){		
				System.out.println("오류코드11 : " + Result + "<br><br>" + BST.getErrString(CERTKEY, Result));	
			}else{		
				System.out.println(Result);	
			}
			/*	1 : 성공
				2 : 성공(포인트 부족으로 SMS 전송실패)
				3 : 성공(이메일 전송실패, SendEmail 함수로 이메일을 재전송 하십시오.)
				
			*/
			
			/////////////////////////
			
			
			
			
			
			////////세금계산서 상태확인 ////
							//자체문서관리번호
			String ID = "huation";						//연계사업자 아이디
			String PWD = "huation@2100";					//연계사업자 비밀번호
			//BaroService_TISoapProxy BST1 = new BaroService_TISoapProxy();
			BaroService_TISoapProxy BST2 = new BaroService_TISoapProxy();
			//String MgtKey = MgtNum;
			
			String Result2 = BST1.getTaxInvoicePopUpURL(CERTKEY, CorpNum, MgtKey, ID, PWD);
			TaxInvoiceState Result3 = BST.getTaxInvoiceState(CERTKEY, CorpNum, MgtKey);
			String approveno = Result3.getNTSSendKey();
			int intResult; 
			
			try{
				intResult = Integer.parseInt(Result2);
			}catch(NumberFormatException e){
				intResult = 0;
			}
			
			if (intResult < 0){
				System.out.println("오류코드11 : " + Result2 + "<br><br>" + BST2.getErrString(CERTKEY, intResult));	
			}else{		
				System.out.println("<a href=\"" + Result2 + "\" target=\"_blank\">" + Result2 + "</a>");	//URL		
			}	
			
			
			
			
			
			
			
			String manage_no= "";  
			String maPre="";
			String maNo="";
			
			int retVal = 0;
			String permit_no= StringUtil.nvl(request.getParameter("permit_no"),"");
			String public_dt= StringUtil.nvl(request.getParameter("public_dt"),"");
			
			String state= StringUtil.nvl(request.getParameter("state"),"");
			System.out.println("----------------state:"+state);
			String TITLE= StringUtil.nvl(request.getParameter("title"),"");
			System.out.println("----------------TITLE:"+TITLE);
			String pre_deposit_dt= StringUtil.nvl(request.getParameter("pre_deposit_dt"),"");
			System.out.println("----------------pre_deposit_dt:"+pre_deposit_dt);
			String pre_deposit_an= StringUtil.nvl(request.getParameter("pre_deposit_an"),"");
			System.out.println("----------------pre_deposit_an:"+pre_deposit_an);
			String reference= StringUtil.nvl(request.getParameter("reference"),"");
			System.out.println("----------------reference:"+reference);
			String comp_code= StringUtil.nvl(request.getParameter("comp_code"),"");
			System.out.println("----------------comp_code:"+comp_code);
			String public_no= StringUtil.nvl(request.getParameter("p_public_no"),"");    	
			System.out.println("----------------public_no:"+public_no);
			String approve_no= StringUtil.nvl(request.getParameter("approve_no"),""); 
			System.out.println("----------------approve_no:"+approve_no);
			String public_org= StringUtil.nvl(request.getParameter("public_org"),"");
			System.out.println("----------------public_org:"+public_org);
			String deposit_amt= StringUtil.nvl(request.getParameter("deposit_amt"),"0");  
			System.out.println("----------------deposit_amt:"+deposit_amt);
			String deposit_dt= StringUtil.nvl(request.getParameter("deposit_dt"),"");
			System.out.println("----------------deposit_dt:"+deposit_dt);
			InvoiceDAO invoiceDao = new InvoiceDAO();
			InvoiceDTO invoiceDto = new InvoiceDTO(); 
			
			
			invoiceDto=invoiceDao.getInvoiceKey(invoiceDto);
			
			log.debug("[getGun]" + invoiceDto.getGun());
			log.debug("[getHo]" + invoiceDto.getHo());
			log.debug("[getManage_no]" + invoiceDto.getManage_no());
				
			if(invoiceDto.getManage_no().equals("MAX") || invoiceDto.getManage_no().equals(null) ){
				msg = "관리번호 생성오류 [100건 이상인경우]";			
		        return alertAndExit(model,msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
			}
			
			 invoiceDto.setPublic_no(public_no);
			 invoiceDto.setApprove_no(approveno);
			 invoiceDto.setReceiver(InvoiceeContactName1);
			 invoiceDto.setPublic_dt(WriteDT);
			 invoiceDto.setPublic_org(public_org);
			 invoiceDto.setComp_code(comp_code);
			 invoiceDto.setPermit_no(permit_no);
			 invoiceDto.setDeposit_amt(deposit_amt);
			 invoiceDto.setDeposit_dt(deposit_dt);
			 invoiceDto.setReference(reference);
			 invoiceDto.setReg_id(USERID);
			 invoiceDto.setState(state);
			 invoiceDto.setIssuetype(issuetype);
			 invoiceDto.setSupply_price(AmountTotal);
			 invoiceDto.setVat(TaxTotal);
			 invoiceDto.setPre_deposit_dt(pre_deposit_dt);
			 invoiceDto.setPre_deposit_an(pre_deposit_an);
			 invoiceDto.setTITLE(TITLE);
			 invoiceDto.setMGTKEY(MgtNum);
		
			 invoiceDto.setTELL(InvoiceeTEL1);
			 invoiceDto.setE_MAIL(InvoiceeEmail1);
			 invoiceDto.setCONTRACT_CODE(contractno);
			 invoiceDto.setDELETED_YN("N");
			 ////////////////////////////////////////////
		/*	 String[] ItemName = request.getParameterValues("ItemName");
				String PurchaseDT1= StringUtil.nvl(request.getParameter("PurchaseDT1"),"");
				String PurchaseDT2= StringUtil.nvl(request.getParameter("PurchaseDT2"),"");
				String[] Spec= request.getParameterValues("Spec");
				String[] Qty= request.getParameterValues("Qty");
				String[] UnitCost= request.getParameterValues("UnitCost");
				String[] Amount= request.getParameterValues("Amount");
				String[] Tax= request.getParameterValues("Tax");
				String[] Remark= request.getParameterValues("Remark");
				///////
				
				
				String[] ProductCode = multipartRequest.getParameterValues("ProductCode"); //Arr 일때 getParameterValues //multipart 사용 시
				retVal = csDao.addproductCode_EST( ProductCode, PROJECT_PK_CODE ,ProductPk_Mapping); //(상품코드,영업진행현황코드,견적서 발행번호)
			*/
				///////////////////////////////////////////
			 
			 
				
			 retVal =invoiceDao.addInvoiceItem(MgtNum,WriteDT,ItemName,Spec,Qty,UnitCost,Amount,Tax,Remark);
			 retVal=invoiceDao.addInvoice(invoiceDto);

			 msg = "세금계산서 등록에 성공했습니다.";			
		        if(retVal < 1) msg = "세금계산서 등록에 실패하였습니다";
			
			
			
			
		        return alertAndExit(model,msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");
			/*return actionMapping.findForward("baroRegistForm");*/
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		/**
		 * 역발행 등록폼
		 * @param String 
		 * @return ActionForward
		 * @throws DAOException
		 */
		public ActionForward inverseRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			log.debug("업체등록");
			
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			//로그인 처리 
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
					String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
// 			로그인 처리 끝.
			
			CommonDAO comDao = new CommonDAO();
			String curDate = comDao.getCurrentDate();
			BankManageDTO bmDto = new BankManageDTO();
			InvoiceDAO ivDao = new InvoiceDAO();
			
			Calendar cal = Calendar.getInstance();
		    cal.setTime(new Date());
		  /*  cal.add(Calendar.DATE, -1);*/
		  /*  cal.add(Calendar.MONTH, 2);*/
		     
		    // 특정 형태의 날짜로 값을 뽑기 
		    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		    String strDate = df.format(cal.getTime());
		    System.err.println(strDate);
			
			
			DateSetter dateSetter = new DateSetter( curDate , "99991231" );
			DateSetter dateSetter1 = new DateSetter( curDate , "99991231" );
			DateSetter dateSetter2 = new DateSetter( "" , "99991231" );
			DateSetter dateSetter3 = new DateSetter( "" , "99991231" );

			model.put("curDate", curDate );
			model.put("dateSetter1", dateSetter1 );
			model.put("dateSetter2", dateSetter2 );
			model.put("dateSetter3", dateSetter2 );
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("searchGb",searchGb);
			model.put("searchtxt",searchtxt);
			model.put("strDate", strDate);
			
			return actionMapping.findForward("inverseRegistForm");
		}
		
		/**
		 * 역발행 등록처리
		 * @param String 
		 * @return ActionForward
		 * @throws DAOException
		 */
		public ActionForward inverseRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			log.debug("역발행 등록처리");
//			로그인 처리 
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
					String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			// 로그인 처리 끝.
			DecimalFormat df = new DecimalFormat("00");	
			Calendar cal = Calendar.getInstance();	
			String MgtNum = Integer.toString(cal.get(Calendar.YEAR)) + df.format(cal.get(Calendar.MONTH)+1) + df.format(cal.get(Calendar.DATE))+df.format(cal.getTimeInMillis());
			MultipartRequest multipartRequest = null;
			
			
			String msg = "";
			
			
			int retVal = 0;
			
			/*int curPageCnt = StringUtil.nvl(multipartRequest.getParameter("curPage"),1);  
			String searchGb = StringUtil.nvl(multipartRequest.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(multipartRequest.getParameter("searchtxt"),"");
			*/
			
			log.debug("역발행 등록처리4");
			String objName = "";
			String rFileName = "";
			String sFileName = "";
			String filePath = "";
			String fileSize = "";
			String sImageName = "";
			String FilePath = FileUtil.FILE_DIR + "inverseregist/"
							+ DateTimeUtil.getDate() + "/";
			String uploadFilePath = "";
			log.debug("FilePath= " + FilePath);
			UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
					20);
			//UploadFiles (,,,20)20의미 MB용량 단위설정
			multipartRequest = uploadEntity.getMultipart();
			String status = uploadEntity.getStatus();
			
			
			int curPageCnt = 0;
			String searchGb = "";
			String searchtxt = "";
			String sForm = "N";

			String inverseregist = ""; // 계약서 파일 받을 파라미터
			

			if (status.equals("E")) {
				log.debug("첨부 파일 올리려다 실패하였습니다.");
				msg = "첨부 파일 올리려다 실패하였습니다.";
				return alertAndExit(model, msg, request.getContextPath()
						+ "/jsp/hueware/common/error.jsp", "back");

			} else if (status.equals("O")) {
				log.debug("첨부하신 파일이 용량을 초과했습니다.");
				msg = "첨부하신 파일이 용량을 초과했습니다.최대 20M 까지 가능합니다.";
				return alertAndExit(model, msg, request.getContextPath()
						+ "/jsp/hueware/common/error.jsp", "back");

			} else if (status.equals("I")) {
				log.debug("첨부 파일의 정보가 잘못되었습니다.");
				msg = "첨부 파일의 정보가 잘못되었습니다.";
				return alertAndExit(model, msg, request.getContextPath()
						+ "/jsp/hueware/common/error.jsp", "back");

			} else if (status.equals("S")) {
				// 업로드된 파일의 정보를 가져와서 데이터 베이스에 넣는 작업을 해준다.
				inverseregist = StringUtil.nvl(
						multipartRequest.getParameter("inverseregist"), "");
				System.out.println("tst:"+inverseregist);
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

						if (objName.equals("inverseregist")) {
							inverseregist = uploadFilePath;
						}
						
					}
				}
			}
			
			curPageCnt = StringUtil
			.nvl(multipartRequest.getParameter("curPage"), 1);
			log.debug("역발행 등록처리5");
			String gun="";    	
			String ho= "";    	
			String manage_no= "";  
			String maPre="";
			String maNo="";
				
			String public_no= StringUtil.nvl(multipartRequest.getParameter("public_no"),"");    	
			
			String approve_no= StringUtil.nvl(multipartRequest.getParameter("approve_no"),"");   	
			String receiver= StringUtil.nvl(multipartRequest.getParameter("receiver"),"");    	
			String public_dt= StringUtil.nvl(multipartRequest.getParameter("public_dt"),"");
			String public_org= StringUtil.nvl(multipartRequest.getParameter("public_org"),"");    
			String comp_code= StringUtil.nvl(multipartRequest.getParameter("comp_code"),"");
			String permit_no= StringUtil.nvl(multipartRequest.getParameter("permit_no"),"");
			System.out.println("permit_no:"+permit_no);
			String deposit_amt= StringUtil.nvl(multipartRequest.getParameter("deposit_amt"),"0");  
			String deposit_dt= StringUtil.nvl(multipartRequest.getParameter("deposit_dt"),"");
			String reference= StringUtil.nvl(multipartRequest.getParameter("reference"),"");
			String productno= StringUtil.nvl(multipartRequest.getParameter("productno"),""); 
			String state= StringUtil.nvl(multipartRequest.getParameter("state"),"");
			String supply_price= StringUtil.nvl(multipartRequest.getParameter("supply_price_view"),"0");    	
			String vat= StringUtil.nvl(multipartRequest.getParameter("vat_view"),"0");  
			String pre_deposit_dt= StringUtil.nvl(multipartRequest.getParameter("pre_deposit_dt"),"");
			String pre_deposit_an= StringUtil.nvl(multipartRequest.getParameter("pre_deposit_an"),"");
			String TITLE= StringUtil.nvl(multipartRequest.getParameter("title"),"");
			String ISSUETYPE= StringUtil.nvl(multipartRequest.getParameter("issuetype"),"");
			String CONTRACT_CODE= StringUtil.nvl(multipartRequest.getParameter("contract_no"),"");
			String INVOICE_FILENM = StringUtil.nvl(multipartRequest.getParameter("inverseregistNm"),"");
			
			InvoiceDAO invoiceDao = new InvoiceDAO();
			InvoiceDTO invoiceDto = new InvoiceDTO(); 
			
			/*
			 maPre=DateUtil.getCurrentDate("yyyyMM");
			 log.debug("[maPre1] : " + maPre);
			 maPre=maPre.substring(0, 4)+"-"+maPre.substring(4, 6);
			 log.debug("[maPre2] : " + maPre);
			 maNo=invoiceDao.getManageCntNext(maPre);
			 log.debug("[maPre3] : " + maPre);
			 manage_no = invoiceDao.getMaNo(maPre,maNo);	
			 log.debug("[manage_no]" + manage_no);
			 */
			invoiceDto.setProductno(productno);
			invoiceDto=invoiceDao.getInvoiceKey(invoiceDto);
			
			log.debug("[getGun]" + invoiceDto.getGun());
			log.debug("[getHo]" + invoiceDto.getHo());
			log.debug("[getManage_no]" + invoiceDto.getManage_no());
				
			if(invoiceDto.getManage_no().equals("MAX") || invoiceDto.getManage_no().equals(null) ){
				msg = "관리번호 생성오류 [100건 이상인경우]";			
		        return alertAndExit(model,msg,request.getContextPath()+"/B_Invoice.do?cmd=invoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
			}
			 
			 invoiceDto.setPublic_no(public_no);
			 invoiceDto.setApprove_no(approve_no);
			 invoiceDto.setReceiver(receiver);
			 invoiceDto.setPublic_dt(public_dt);
			 invoiceDto.setPublic_org(public_org);
			 invoiceDto.setComp_code(comp_code);
			 invoiceDto.setPermit_no(permit_no);
			 invoiceDto.setDeposit_amt(deposit_amt);
			 invoiceDto.setDeposit_dt(deposit_dt);
			 invoiceDto.setReference(reference);
			 invoiceDto.setReg_id(USERID);
			 invoiceDto.setState(state);
			 invoiceDto.setSupply_price(supply_price.replaceAll(",", ""));
			 invoiceDto.setVat(vat.replaceAll(",", ""));
			 invoiceDto.setPre_deposit_dt(pre_deposit_dt);
			 invoiceDto.setPre_deposit_an(pre_deposit_an);
			 invoiceDto.setTITLE(TITLE);
			 invoiceDto.setIssuetype(ISSUETYPE);
			 invoiceDto.setCONTRACT_CODE(CONTRACT_CODE);
			 invoiceDto.setINVOICE_FILE(inverseregist);
			 invoiceDto.setINVOICE_FILENM(INVOICE_FILENM);
			 invoiceDto.setMGTKEY(MgtNum);
			 invoiceDto.setDELETED_YN("N");
			 retVal=invoiceDao.addInvoice(invoiceDto);

			 msg = "세금계산서 등록에 성공했습니다.";			
		        if(retVal < 1) msg = "세금계산서 등록에 실패하였습니다";

		        return alertAndExit(model,msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
		}
		
		
		
		
		
		
		
		
		
		
				
		
		
//세금계산서 등록 폼
public ActionForward baroRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
	
	log.debug("업체등록");
	
	
	
	//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
//	String IvStartDate = StringUtil.nvl(request.getParameter("IvStartDate"),DateUtil.getDayInterval3(-365));
	//2019_02_19 조회시작일을 당해년도 1월1일로 설정
	String today = DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-");
	String currentYear = "2019";
	if (today.length() >= 4) {
		currentYear = today.substring(0,4);
	}
	String IvStartDate = StringUtil.nvl(request.getParameter("IvStartDate"),currentYear+"-01-01");
	System.out.println("IvStartDate:"+IvStartDate);
	String IvEndDate = StringUtil.nvl(request.getParameter("IvEndDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),""));
	System.out.println("IvEndDate:"+IvEndDate);
	
	
	int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
	String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
	String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
	//로그인 처리 
	String USERID = UserBroker.getUserId(request);
	if(USERID.equals("")){
			String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
			return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
//		로그인 처리 끝.
	
	
	
	CommonDAO comDao = new CommonDAO();
	String curDate = comDao.getCurrentDate();
	BankManageDTO bmDto = new BankManageDTO();
	InvoiceDAO ivDao = new InvoiceDAO();
	
	DateSetter dateSetter = new DateSetter( curDate , "99991231" );
	DateSetter dateSetter1 = new DateSetter( curDate , "99991231" );
	DateSetter dateSetter2 = new DateSetter( "" , "99991231" );
	DateSetter dateSetter3 = new DateSetter( "" , "99991231" );

	model.put("curDate", curDate );
	model.put("dateSetter1", dateSetter1 );
	model.put("dateSetter2", dateSetter2 );
	model.put("dateSetter3", dateSetter2 );
	model.put("curPage",String.valueOf(curPageCnt));
	model.put("searchGb",searchGb);
	model.put("searchtxt",searchtxt);
	
	
	
	String public_no= StringUtil.nvl(request.getParameter("public_no"),""); 
	
	
	
	
	
	
	
	
	return actionMapping.findForward("baroRegistForm");
}


/**
 * 세금계산서를 삭제한다.
 * @param request
 * @return ActionForward
 * @throws DAOException
 */
public ActionForward BaroInvoiceDelete(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
	
	String USERID = UserBroker.getUserId(request);
	if(USERID.equals("")){
		String rtnUrl =request.getContextPath()+"/B_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	String msg = "";
	int retVal = 0;
	int curPageCnt = 0;		
	curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
	String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
	String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
	String gun = StringUtil.nvl(request.getParameter("gun"),"");
	String ho = StringUtil.nvl(request.getParameter("ho"),"");
	String manageno = StringUtil.nvl(request.getParameter("manage_no"),"");
	
	InvoiceDAO invoiceDao = new InvoiceDAO();
	InvoiceDTO invoiceDto = new InvoiceDTO();
	
	invoiceDto.setGun(gun);
	invoiceDto.setHo(ho);
	invoiceDto.setManage_no(manageno);
	invoiceDto.setMod_id(USERID);
	
	retVal = invoiceDao.deleteInvoiceOne(invoiceDto);
	
    msg = "삭제에  성공하였습니다";
    if(retVal < 1) msg = "삭제에 실패하였습니다";
    
    return alertAndExit(model, msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");		
}


/**
 * 세금계산서를 수정한다.(역발행)
 * @param request
 * @return ActionForward
 * @throws DAOException
 */
public ActionForward BaroInvoiceEdit(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
	
	String USERID = UserBroker.getUserId(request);
	if(USERID.equals("")){
		String rtnUrl = "'/B_Login.do?cmd=loginForm'";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	
	MultipartRequest multipartRequest = null;
	String msg = "";
	
	String objName = "";
	String rFileName = "";
	String sFileName = "";
	String filePath = "";
	String fileSize = "";
	String sImageName = "";
	String FilePath = FileUtil.FILE_DIR + "inverseregist/"
					+ DateTimeUtil.getDate() + "/";
	String uploadFilePath = "";
	log.debug("FilePath= " + FilePath);
	UploadFiles uploadEntity = FileUtil.upload(request, FilePath, USERID,
			20);
	//UploadFiles (,,,20)20의미 MB용량 단위설정
	multipartRequest = uploadEntity.getMultipart();
	String status = uploadEntity.getStatus();
	
	
	int curPageCnt = 0;
	String searchGb = "";
	String searchtxt = "";
	String sForm = "N";

	String inverseregist = ""; // 계약서 파일 받을 파라미터
	

	if (status.equals("E")) {
		log.debug("첨부 파일 올리려다 실패하였습니다.");
		msg = "첨부 파일 올리려다 실패하였습니다.";
		return alertAndExit(model, msg, request.getContextPath()
				+ "/jsp/hueware/common/error.jsp", "back");

	} else if (status.equals("O")) {
		log.debug("첨부하신 파일이 용량을 초과했습니다.");
		msg = "첨부하신 파일이 용량을 초과했습니다.최대 20M 까지 가능합니다.";
		return alertAndExit(model, msg, request.getContextPath()
				+ "/jsp/hueware/common/error.jsp", "back");

	} else if (status.equals("I")) {
		log.debug("첨부 파일의 정보가 잘못되었습니다.");
		msg = "첨부 파일의 정보가 잘못되었습니다.";
		return alertAndExit(model, msg, request.getContextPath()
				+ "/jsp/hueware/common/error.jsp", "back");

	} else if (status.equals("S")) {
		// 업로드된 파일의 정보를 가져와서 데이터 베이스에 넣는 작업을 해준다.
		inverseregist = StringUtil.nvl(
				multipartRequest.getParameter("inverseregist"), "");
		System.out.println("tst:"+inverseregist);
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

				if (objName.equals("inverseregist")) {
					inverseregist = uploadFilePath;
				}
				
			}
		}
	}
	curPageCnt = StringUtil
	.nvl(multipartRequest.getParameter("curPage"), 1);
	
	int retVal = 0;
	
	String public_no= StringUtil.nvl(multipartRequest.getParameter("public_no"),"");    	
	String gun= StringUtil.nvl(multipartRequest.getParameter("gun"),"");    	
	String ho= StringUtil.nvl(multipartRequest.getParameter("ho"),"");    	
	String manage_no= StringUtil.nvl(multipartRequest.getParameter("manage_no"),"");    	
	String approve_no= StringUtil.nvl(multipartRequest.getParameter("approve_no"),"");    	  	
	String receiver= StringUtil.nvl(multipartRequest.getParameter("receiver"),"");    	
	String public_dt= StringUtil.nvl(multipartRequest.getParameter("public_dt"),"");
	String public_org= StringUtil.nvl(multipartRequest.getParameter("public_org"),"");    
	String comp_code= StringUtil.nvl(multipartRequest.getParameter("comp_code"),"");
	String permit_no= StringUtil.nvl(multipartRequest.getParameter("permit_no"),"");
	String deposit_amt= StringUtil.nvl(multipartRequest.getParameter("deposit_amt"),"0"); 
	String deposit_dt= StringUtil.nvl(multipartRequest.getParameter("deposit_dt"),"");  
	String reference= StringUtil.nvl(multipartRequest.getParameter("reference"),"");  
	String supply_price= StringUtil.nvl(multipartRequest.getParameter("supply_price"),"0");    	
	String vat= StringUtil.nvl(multipartRequest.getParameter("vat"),"0");  
	String pre_deposit_dt= StringUtil.nvl(multipartRequest.getParameter("pre_deposit_dt"),"");
	String pre_deposit_an= StringUtil.nvl(multipartRequest.getParameter("pre_deposit_an"),"");
	log.debug("pre_deposit_an:"+pre_deposit_an);
	String state= StringUtil.nvl(multipartRequest.getParameter("state"),"");
	String issuetype= StringUtil.nvl(multipartRequest.getParameter("issuetype"),"");
	String TITLE= StringUtil.nvl(multipartRequest.getParameter("title"),"");
	String INVOICE_FILENM = StringUtil.nvl(multipartRequest.getParameter("inverseregistNm"),"");
	String contract_no= StringUtil.nvl(multipartRequest.getParameter("contract_no"),"");    		
	String depositFinish= StringUtil.nvl(multipartRequest.getParameter("depositFinish"),"");    
	
	
	InvoiceDAO invoiceDao = new InvoiceDAO();
	InvoiceDTO invoiceDto = new InvoiceDTO(); 
	
	invoiceDto.setPublic_no(public_no);
	invoiceDto.setGun(gun);
    invoiceDto.setHo(ho);
	invoiceDto.setManage_no(manage_no);
	invoiceDto.setApprove_no(approve_no);
	invoiceDto.setReceiver(receiver);
	invoiceDto.setPublic_dt(public_dt);
	invoiceDto.setPublic_org(public_org);
	invoiceDto.setComp_code(comp_code);
	invoiceDto.setDeposit_amt(deposit_amt);
	invoiceDto.setDeposit_dt(deposit_dt);
	invoiceDto.setReference(reference);
	invoiceDto.setMod_id(USERID);
	invoiceDto.setSupply_price(supply_price);
	invoiceDto.setVat(vat);
	invoiceDto.setPre_deposit_dt(pre_deposit_dt);
	invoiceDto.setPre_deposit_an(pre_deposit_an);
	invoiceDto.setState(state);
	invoiceDto.setIssuetype(issuetype);
	invoiceDto.setPermit_no(permit_no);
	invoiceDto.setTITLE(TITLE);
	invoiceDto.setINVOICE_FILE(inverseregist);
	invoiceDto.setINVOICE_FILENM(INVOICE_FILENM);
	invoiceDto.setCONTRACT_CODE(contract_no);
	invoiceDto.setDepositFinish(depositFinish);
	System.out.println("TITLE:"+TITLE);
	System.out.println("contract_no:"+contract_no);

	retVal = invoiceDao.editInvoice(invoiceDto);
	
	model.put("curPage",String.valueOf(curPageCnt));
	
    msg = "수정에  성공하였습니다";
    if(retVal < 1) msg = "수정에 실패하였습니다";
    
    return alertAndExit(model,msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
}

/**
 * 세금계산서를 수정한다.(정발행)
 * @param request
 * @return ActionForward
 * @throws DAOException
 */
public ActionForward BaroInvoiceEdit_2(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
	
	String USERID = UserBroker.getUserId(request);
	if(USERID.equals("")){
		String rtnUrl = "'/B_Login.do?cmd=loginForm'";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	
	
	String msg = "";
	
	
	int curPageCnt = 0;
	String searchGb = "";
	String searchtxt = "";
	
	
	curPageCnt = StringUtil
	.nvl(request.getParameter("curPage"), 1);
	
	int retVal = 0;
	
	String public_no= StringUtil.nvl(request.getParameter("public_no"),"");    	
	String gun= StringUtil.nvl(request.getParameter("gun"),"");    	
	String ho= StringUtil.nvl(request.getParameter("ho"),"");    	
	String manage_no= StringUtil.nvl(request.getParameter("manage_no"),"");    	
	String approve_no= StringUtil.nvl(request.getParameter("approve_no"),"");    	  	
	String receiver= StringUtil.nvl(request.getParameter("receiver"),"");    	
	String public_dt= StringUtil.nvl(request.getParameter("public_dt"),"");
	String public_org= StringUtil.nvl(request.getParameter("public_org"),"");    
	String comp_code= StringUtil.nvl(request.getParameter("comp_code"),"");
	String permit_no= StringUtil.nvl(request.getParameter("permit_no"),"");
	String deposit_amt= StringUtil.nvl(request.getParameter("deposit_amt"),"0"); 
	String deposit_dt= StringUtil.nvl(request.getParameter("deposit_dt"),"");  
	String reference= StringUtil.nvl(request.getParameter("reference"),"");  
	String supply_price= StringUtil.nvl(request.getParameter("supply_price"),"0");    	
	String vat= StringUtil.nvl(request.getParameter("vat"),"0");  
	String pre_deposit_dt= StringUtil.nvl(request.getParameter("pre_deposit_dt"),"");
	String pre_deposit_an= StringUtil.nvl(request.getParameter("pre_deposit_an"),"");
	log.debug("pre_deposit_an:"+pre_deposit_an);
	String state= StringUtil.nvl(request.getParameter("state"),"");
	String issuetype= StringUtil.nvl(request.getParameter("issuetype"),"");
	String TITLE= StringUtil.nvl(request.getParameter("title"),"");
	String INVOICE_FILENM = StringUtil.nvl(request.getParameter("inverseregistNm"),"");
	String contract_no= StringUtil.nvl(request.getParameter("contract_no"),"");    
	String depositFinish= StringUtil.nvl(request.getParameter("depositFinish"),""); 
	InvoiceDAO invoiceDao = new InvoiceDAO();
	InvoiceDTO invoiceDto = new InvoiceDTO(); 
	
	invoiceDto.setPublic_no(public_no);
	invoiceDto.setGun(gun);
    invoiceDto.setHo(ho);
	invoiceDto.setManage_no(manage_no);
	invoiceDto.setApprove_no(approve_no);
	invoiceDto.setReceiver(receiver);
	invoiceDto.setPublic_dt(public_dt);
	invoiceDto.setPublic_org(public_org);
	invoiceDto.setComp_code(comp_code);
	invoiceDto.setDeposit_amt(deposit_amt);
	invoiceDto.setDeposit_dt(deposit_dt);
	invoiceDto.setReference(reference);
	invoiceDto.setMod_id(USERID);
	invoiceDto.setSupply_price(supply_price);
	invoiceDto.setVat(vat);
	invoiceDto.setPre_deposit_dt(pre_deposit_dt);
	invoiceDto.setPre_deposit_an(pre_deposit_an);
	invoiceDto.setState(state);
	invoiceDto.setIssuetype(issuetype);
	invoiceDto.setPermit_no(permit_no);
	invoiceDto.setTITLE(TITLE);
	invoiceDto.setCONTRACT_CODE(contract_no);
	invoiceDto.setINVOICE_FILENM(INVOICE_FILENM);
	invoiceDto.setDepositFinish(depositFinish);
	System.out.println("TITLE:"+TITLE);
	System.out.println("contract_no:"+contract_no);

	retVal = invoiceDao.editInvoice(invoiceDto);
	
	model.put("curPage",String.valueOf(curPageCnt));
	
    msg = "수정에  성공하였습니다";
    if(retVal < 1) msg = "수정에 실패하였습니다";
    
    return alertAndExit(model,msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
}
/**
 * 세금계산서 발행을 취소한다.
 * @param request
 * @return ActionForward
 * @throws DAOException
 */
public ActionForward BaroInvoiceCancel(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
	
	log.debug("세금계산서 발행취소 Start ....");
	String USERID = UserBroker.getUserId(request);
	if(USERID.equals("")){
		String rtnUrl =request.getContextPath()+"/B_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
		
	int retVal = 0;
	int curPageCnt = 0;		
	
	
	curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
	String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
	String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
	String gun = StringUtil.nvl(request.getParameter("gun"),"");
	String ho = StringUtil.nvl(request.getParameter("ho"),"");
	String manageno = StringUtil.nvl(request.getParameter("manage_no"),"");
	String pre_deposit_an = StringUtil.nvl(request.getParameter("pre_deposit_an"),"");
	
	String modifyFlag = StringUtil.nvl(request.getParameter("modifyFlag"),"");
	
	
	String receiver = StringUtil.nvl(request.getParameter("receiver"),"");	
	String compnm = StringUtil.nvl(request.getParameter("comp_nm"),"");	
	String business = StringUtil.nvl(request.getParameter("business"),"");	
	String b_item = StringUtil.nvl(request.getParameter("b_item"),"");	
	String ownernm = StringUtil.nvl(request.getParameter("owner_nm"),"");	
	String post = StringUtil.nvl(request.getParameter("post"),"");	
	String address = StringUtil.nvl(request.getParameter("address"),"");	
	String addrdetail = StringUtil.nvl(request.getParameter("addr_detail"),"");	
	String publicorg = StringUtil.nvl(request.getParameter("public_org"),"");	
	String permitno = StringUtil.nvl(request.getParameter("permit_no"),"");
	String compcode = StringUtil.nvl(request.getParameter("comp_code"),"");
	String publicno = StringUtil.nvl(request.getParameter("p_public_no"),"");
	String title = StringUtil.nvl(request.getParameter("title"),"");
	
	String mgtkey = StringUtil.nvl(request.getParameter("mgtkey"),"");
	
	String supply_price= StringUtil.nvl(request.getParameter("supply_price"),"");
	String vat= StringUtil.nvl(request.getParameter("vat"),"");
	String tell= StringUtil.nvl(request.getParameter("TELL"),"");
	String e_mail= StringUtil.nvl(request.getParameter("E_MAIL"),"");
	String aprove= StringUtil.nvl(request.getParameter("approve"),"");
	String contract= StringUtil.nvl(request.getParameter("contract"),"");
	String public_dt = StringUtil.nvl(request.getParameter("public_dt"),"");
	
	
	
	
	System.out.println("mgtkry:"+mgtkey);
	
	EstimateDTO esDto = new EstimateDTO();
					
	InvoiceDAO invoiceDao = new InvoiceDAO();
	InvoiceDTO invoiceDto = new InvoiceDTO();
	
	invoiceDto.setGun(gun);
	invoiceDto.setHo(ho);
	invoiceDto.setManage_no(manageno);
	invoiceDto.setPre_deposit_an(pre_deposit_an);
	invoiceDto.setReceiver(receiver);
	invoiceDto.setComp_nm(compnm);
	invoiceDto.setBusiness(business);
	invoiceDto.setB_item(b_item);
	invoiceDto.setOwner_nm(ownernm);
	invoiceDto.setPost(post);
	invoiceDto.setAddress(address);
	invoiceDto.setAddr_detail(addrdetail);
	invoiceDto.setPublic_org(publicorg);
	invoiceDto.setPermit_no(permitno);
	invoiceDto.setComp_code(compcode);
	invoiceDto.setPublic_no(publicno);
	invoiceDto.setTITLE(title);
	invoiceDto.setMGTKEY(mgtkey);
	invoiceDto.setSupply_price(supply_price);
	invoiceDto.setVat(vat);
	invoiceDto.setTELL(tell);
	invoiceDto.setE_MAIL(e_mail);
	invoiceDto.setApprove_no(aprove);
	invoiceDto.setCONTRACT_CODE(contract);
	invoiceDto.setPublic_dt(public_dt);
	invoiceDto.setModifyFlag(modifyFlag);
	/*ArrayList itemList = null; //상품코드 가져올 어레이 변수 선언
*/	ListDTO ld   = invoiceDao.getItemList(invoiceDto);
	
	
	
			
	DateSetter dateSetter1 = new DateSetter( invoiceDto.getPublic_dt() , "99991231" );
	DateSetter dateSetter2 = new DateSetter( invoiceDto.getDeposit_dt() , "99991231" ,"s1" );
	DateSetter dateSetter3 = new DateSetter( invoiceDto.getPre_deposit_dt() , "99991231" ,"s2" );
	model.put("dateSetter1", dateSetter1 );
	model.put("dateSetter2", dateSetter2 );
	model.put("dateSetter3", dateSetter3 );
    model.put("invoiceDto", invoiceDto);
    model.put("esDto", esDto);
    model.put("listInfo",ld);	
	model.put("curPage",String.valueOf(curPageCnt));
	model.put("gun",gun);
	model.put("ho",ho);
	model.put("manage_no",manageno);
	model.put("searchGb", searchGb);
	model.put("searchtxt", searchtxt);
	model.put("modifyFlag", modifyFlag);
	
	
	//invoiceDto = invoiceDao.getEditInvoiceView(invoiceDto);
	
	//retVal = invoiceDao.cancelInvoiceOne(invoiceDto);
	
  /*  msg = "발행 취소를  성공하였습니다";
    if(retVal < 1) msg = "발행 취소를 실패하였습니다";*/
    
   /* return alertAndExit(model, msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=editInvoiceRegist&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");*/		

	
	/*return alertPopupClose(model, msg, request.getContextPath()+"/B_BaroInvoice.do?cmd=editInvoiceRegist");*/
	 
	if(modifyFlag.equals("01")){
	return actionMapping.findForward("editInvoiceRegist1"); 
	}else if(modifyFlag.equals("02")){
		return actionMapping.findForward("editInvoiceRegist2"); 
	}else if(modifyFlag.equals("03")){
		return actionMapping.findForward("editInvoiceRegist3"); 
	}else if(modifyFlag.equals("04")){
		return actionMapping.findForward("editInvoiceRegist4");
	}else{
		return actionMapping.findForward("editInvoiceRegist5");
	}
}


//수정발행 팝업 플레그
public ActionForward modifyInvoiceFlag(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
	
	String USERID = UserBroker.getUserId(request);
	if(USERID.equals("")){
		String rtnUrl =request.getContextPath()+"/B_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	
	
	
	
	
	
	
	
	String gun = StringUtil.nvl(request.getParameter("gun"),"");
	String ho = StringUtil.nvl(request.getParameter("ho"),"");
	String manage = StringUtil.nvl(request.getParameter("manage"),"");
	String mgtkey = StringUtil.nvl(request.getParameter("mgtkey"),"");
	InvoiceDAO invoiceDao = new InvoiceDAO();
	InvoiceDTO invoiceDto = new InvoiceDTO(); 
	EstimateDTO esDto = new EstimateDTO();
	
	
	
	invoiceDto.setGun(gun);
	invoiceDto.setHo(ho);
	invoiceDto.setManage_no(manage);
	invoiceDto.setMGTKEY(mgtkey);


	invoiceDto = invoiceDao.getInvoiceView(invoiceDto);
	
	
	model.put("invoiceDto", invoiceDto);
    model.put("esDto", esDto);
    model.put("gun",gun);
	model.put("ho",ho);
	model.put("manage_no",manage);
	
	
	
	
    return actionMapping.findForward("modifyInvoiceFlag"); 
}
		

//임시 수정발행 팝업 플레그
public ActionForward cancel(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse httpServletResponse, Map model) throws Exception{
	
	String USERID = UserBroker.getUserId(request);
	if(USERID.equals("")){
		String rtnUrl =request.getContextPath()+"/B_Login.do?cmd=loginForm";
		return goSessionOut(model, rtnUrl,"huation-sessionOut");
	}
	
	
	String gun = StringUtil.nvl(request.getParameter("gun"),"");
	String ho = StringUtil.nvl(request.getParameter("ho"),"");
	String manage = StringUtil.nvl(request.getParameter("manage"),"");
	String mgtkey = StringUtil.nvl(request.getParameter("mgtkey"),"");
	InvoiceDAO invoiceDao = new InvoiceDAO();
	InvoiceDTO invoiceDto = new InvoiceDTO(); 
	EstimateDTO esDto = new EstimateDTO();
	
	int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
	String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
	String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
	String manage_no= StringUtil.nvl(request.getParameter("manage_no"),"");    	
	String pre_deposit_an = StringUtil.nvl(request.getParameter("pre_deposit_an"),"");
	
	invoiceDto.setGun(gun);
	invoiceDto.setHo(ho);
	invoiceDto.setManage_no(manage);
	invoiceDto.setMGTKEY(mgtkey);


	invoiceDto = invoiceDao.getInvoiceView(invoiceDto);
	
	
	model.put("invoiceDto", invoiceDto);
    model.put("esDto", esDto);
    model.put("gun",gun);
	model.put("ho",ho);
	model.put("manage_no",manage);
	
	
	int retVal=0;
	String msg="";
	retVal = invoiceDao.cancelInvoiceOne(invoiceDto);
	
	    msg = "발행 취소를  성공하였습니다";
	    if(retVal < 1) msg = "발행 취소를 실패하였습니다";
	    
	 return alertAndExit(model, msg,request.getContextPath()+"/B_BaroInvoice.do?cmd=baroInvoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");		

}




	//미수채권 현황 리스트
	public ActionForward outstandingBondList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
	
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
		String IvStartDate = StringUtil.nvl(request.getParameter("IvStartDate"),DateUtil.getDayInterval3(-365));
//		System.out.println("IvStartDate:"+IvStartDate);
		String IvEndDate = StringUtil.nvl(request.getParameter("IvEndDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),""));
//		System.out.println("IvEndDate:"+IvEndDate);
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		
		InvoiceDAO invoiceDao = new InvoiceDAO();
		InvoiceDTO invoiceDto = new InvoiceDTO();
		
		invoiceDto.setCurPage(curPageCnt);
		invoiceDto.setSearchGb(searchGb);
		invoiceDto.setSearchTxt(searchtxt);
		invoiceDto.setIvStartDate(IvStartDate);
		invoiceDto.setIvEndDate(IvEndDate);
		invoiceDto.setnRow(10);
		invoiceDto.setnPage(10);
		
		ListDTO ld = invoiceDao.outstandingBondList(invoiceDto);
		
		model.put("listInfo",ld);	
		
		model.put("curPage",String.valueOf(curPageCnt));
		model.put("searchGb",searchGb);
		model.put("searchtxt",searchtxt);
		//model.put("IvStartDate", IvStartDate);
		//model.put("IvEndDate", IvEndDate);
		
		return actionMapping.findForward("outstandingBondList");
	}

	//미수채권 현황 Excel 리스트
	public ActionForward outstandingBondExcelList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
		String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
		String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
		//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
		/*String IvStartDate = StringUtil.nvl(request.getParameter("IvStartDate"),DateUtil.getDayInterval3(-365));
		System.out.println("IvStartDate:"+IvStartDate);
		String IvEndDate = StringUtil.nvl(request.getParameter("IvEndDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),""));
		System.out.println("IvEndDate:"+IvEndDate);*/
		int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
		
		InvoiceDAO invoiceDao = new InvoiceDAO();
		InvoiceDTO invoiceDto = new InvoiceDTO();
		
		invoiceDto.setCurPage(curPageCnt);
		invoiceDto.setSearchGb(searchGb);
		invoiceDto.setSearchTxt(searchtxt);
		//invoiceDto.setIvStartDate(IvStartDate);
		//invoiceDto.setIvEndDate(IvEndDate);
		invoiceDto.setnRow(10);
		invoiceDto.setnPage(10);
		
		ListDTO ld = invoiceDao.outstandingBondExcelList(invoiceDto);
		model.put("listInfo",ld);	
		//model.put("curPage",String.valueOf(curPageCnt));
		//model.put("searchGb",searchGb);
		//model.put("searchtxt",searchtxt);
		//model.put("IvStartDate", IvStartDate);
		//model.put("IvEndDate", IvEndDate);
		
		return actionMapping.findForward("outstandingBondExcelList");
	}



}

