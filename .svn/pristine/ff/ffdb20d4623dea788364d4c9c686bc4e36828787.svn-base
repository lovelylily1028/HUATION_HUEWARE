package com.huation.hueware.invoice.action;

import java.net.URLEncoder;
import java.text.*;
import java.util.*;

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
import com.huation.framework.util.HtmlXSSFilter;
import com.huation.framework.util.SiteNavigation;
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

public class InvoiceAction extends StrutsDispatchAction{
		/**
		 * 세금계산서 리스트
		 * @param String 
		 * @return ActionForward
		 * @throws DAOException
		 */
		public ActionForward invoicePageList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
//			String IvStartDate = StringUtil.nvl(request.getParameter("IvStartDate"),DateUtil.getDayInterval3(-365));
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
				
			InvoiceDAO invoiceDao = new InvoiceDAO();

			ListDTO ld = invoiceDao.invoicePageList(curPageCnt, searchGb, searchtxt,IvStartDate, IvEndDate, 10, 10);

			model.put("listInfo",ld);	
			
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("searchGb",searchGb);
			model.put("searchtxt",searchtxt);
			model.put("IvStartDate", IvStartDate);
			model.put("IvEndDate", IvEndDate);
			
			return actionMapping.findForward("invoicePageList");
		}
		/**
		 * 세금계산서 등록폼
		 * @param String 
		 * @return ActionForward
		 * @throws DAOException
		 */
		public ActionForward invoiceRegistForm(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
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
		   /* cal.add(Calendar.DATE, -1);*/
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
			return actionMapping.findForward("invoiceRegistForm");
		}
		/**
		 * 세금계산서 등록처리
		 * @param String 
		 * @return ActionForward
		 * @throws DAOException
		 */
		public ActionForward invoiceRegist(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
//			로그인 처리 
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
					String rtnUrl = request.getContextPath()+"/B_Login.do?cmd=loginForm";
					return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			// 로그인 처리 끝.
			
			String msg = "";
			int retVal = 0;
			
			int curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);  
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");

			String gun="";    	
			String ho= "";    	
			String manage_no= "";  
			String maPre="";
			String maNo="";
				
			String public_no= StringUtil.nvl(request.getParameter("public_no"),"");    	
			
			String approve_no= StringUtil.nvl(request.getParameter("approve_no"),"");   	
			String receiver= StringUtil.nvl(request.getParameter("receiver"),"");    	
			String public_dt= StringUtil.nvl(request.getParameter("public_dt"),"");
			String public_org= StringUtil.nvl(request.getParameter("public_org"),"");    
			String comp_code= StringUtil.nvl(request.getParameter("comp_code"),"");
			String permit_no= StringUtil.nvl(request.getParameter("permit_no"),"");
			System.out.println("permit_no:"+permit_no);
			String deposit_amt= StringUtil.nvl(request.getParameter("deposit_amt"),"0");  
			String deposit_dt= StringUtil.nvl(request.getParameter("deposit_dt"),"");
			String reference= StringUtil.nvl(request.getParameter("reference"),"");
			String productno= StringUtil.nvl(request.getParameter("productno"),""); 
			String state= StringUtil.nvl(request.getParameter("state"),"");
			String supply_price= StringUtil.nvl(request.getParameter("supply_price"),"0");    	
			String vat= StringUtil.nvl(request.getParameter("vat"),"0");  
			String pre_deposit_dt= StringUtil.nvl(request.getParameter("pre_deposit_dt"),"");
			String pre_deposit_an= StringUtil.nvl(request.getParameter("pre_deposit_an"),"");
			String TITLE= StringUtil.nvl(request.getParameter("title"),"");
			
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
			 invoiceDto.setSupply_price(supply_price);
			 invoiceDto.setVat(vat);
			 invoiceDto.setPre_deposit_dt(pre_deposit_dt);
			 invoiceDto.setPre_deposit_an(pre_deposit_an);
			 invoiceDto.setTITLE(TITLE);
			 invoiceDto.setDELETED_YN("N");
			 retVal=invoiceDao.addInvoice(invoiceDto);

			 msg = "세금계산서 등록에 성공했습니다.";			
		        if(retVal < 1) msg = "세금계산서 등록에 실패하였습니다";

		        return alertAndExit(model,msg,request.getContextPath()+"/B_Invoice.do?cmd=invoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
		}
		/**
		 * 세금계산서 상세정보 
		 * @param String 
		 * @return ActionForward
		 * @throws DAOException
		 */
		public ActionForward invoiceView(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			int curPageCnt = 0;
			String invoice_code = "";  //계산서 코드
			
			curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			String gun= StringUtil.nvl(request.getParameter("gun"),"");    	
			String ho= StringUtil.nvl(request.getParameter("ho"),"");    	
			String manage_no= StringUtil.nvl(request.getParameter("manage_no"),"");    	
			String pre_deposit_an = StringUtil.nvl(request.getParameter("pre_deposit_an"),"");
			InvoiceDAO invoiceDao = new InvoiceDAO();
			InvoiceDTO invoiceDto = new InvoiceDTO(); 
			EstimateDTO esDto = new EstimateDTO();
			invoiceDto.setGun(gun);
			invoiceDto.setHo(ho);
			invoiceDto.setManage_no(manage_no);
			invoiceDto.setPre_deposit_an(pre_deposit_an);
			
			invoiceDto = invoiceDao.getInvoiceView(invoiceDto); 	
			
			DateSetter dateSetter1 = new DateSetter( invoiceDto.getPublic_dt() , "99991231" );
			DateSetter dateSetter2 = new DateSetter( invoiceDto.getDeposit_dt() , "99991231" ,"s1" );
			DateSetter dateSetter3 = new DateSetter( invoiceDto.getPre_deposit_dt() , "99991231" ,"s2" );
			model.put("dateSetter1", dateSetter1 );
			model.put("dateSetter2", dateSetter2 );
			model.put("dateSetter3", dateSetter3 );
		    model.put("invoiceDto", invoiceDto);
		    model.put("esDto", esDto);
		    
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("gun",gun);
			model.put("ho",ho);
			model.put("manage_no",manage_no);
			model.put("searchGb", searchGb);
			model.put("searchtxt", searchtxt);
			
			
		    if(invoiceDto == null){
				String msg = "해당  업체  정보가 없습니다.";
				return alertAndExit(model, msg,request.getContextPath()+"/B_Invoice.do?cmd=invoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");
		    }else{
		    	return actionMapping.findForward("invoiceView");
			}
		}
		/**
		 * 세금계산서를 수정한다.
		 * @param request
		 * @return ActionForward
		 * @throws DAOException
		 */
		public ActionForward invoiceEdit(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
			String USERID = UserBroker.getUserId(request);
			if(USERID.equals("")){
				String rtnUrl = "'/B_Login.do?cmd=loginForm'";
				return goSessionOut(model, rtnUrl,"huation-sessionOut");
			}
			
			String msg = "";
			int retVal = 0;
			int curPageCnt = 0;		
			curPageCnt = StringUtil.nvl(request.getParameter("curPage"),1);
			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
 	
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
			String TITLE= StringUtil.nvl(request.getParameter("title"),"");
			
					
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
			System.out.println("pre_deposit_an2:"+pre_deposit_an);
			invoiceDto.setState(state);
			invoiceDto.setPermit_no(permit_no);
			invoiceDto.setTITLE(TITLE);
			System.out.println("TITLE:"+TITLE);


			retVal = invoiceDao.editInvoice(invoiceDto);
			
			model.put("curPage",String.valueOf(curPageCnt));
			
	        msg = "수정에  성공하였습니다";
	        if(retVal < 1) msg = "수정에 실패하였습니다";
	        
	        return alertAndExit(model,msg,request.getContextPath()+"/B_Invoice.do?cmd=invoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");	
		}
		/**
		 * 세금계산서를 삭제한다.
		 * @param request
		 * @return ActionForward
		 * @throws DAOException
		 */
		public ActionForward invoiceDelete(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
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
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_Invoice.do?cmd=invoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");		
		}
		/**
		 * 세금계산서 발행을 취소한다.
		 * @param request
		 * @return ActionForward
		 * @throws DAOException
		 */
		public ActionForward invoiceCancel(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{
			
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
			
			retVal = invoiceDao.cancelInvoiceOne(invoiceDto);
			
	        msg = "발행 취소를  성공하였습니다";
	        if(retVal < 1) msg = "발행 취소를 실패하였습니다";
	        
	        return alertAndExit(model, msg,request.getContextPath()+"/B_Invoice.do?cmd=invoicePageList&curPage="+curPageCnt+"&searchGb="+searchGb+"&searchtxt="+searchtxt,"back");		
		}
		/**
		 * 세금계산서 리스트(Excel)
		 * @param String 
		 * @return ActionForward
		 * @throws DAOException
		 */
		public ActionForward invoiceExcelList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
//			String IvStartDate = StringUtil.nvl(request.getParameter("IvStartDate"),DateUtil.getDayInterval3(-365));
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
				
			InvoiceDAO dao = new InvoiceDAO();
			InvoiceDTO invoiceDTO = new InvoiceDTO();

			invoiceDTO.setSearchGb(searchGb);
			invoiceDTO.setSearchTxt(searchtxt);
			invoiceDTO.setIvStartDate(IvStartDate);
			invoiceDTO.setIvEndDate(IvEndDate);

			ArrayList<InvoiceDTO> arrlist = dao.getInvoiceListExcel(invoiceDTO);


			model.put("listInfo",arrlist);	

			return actionMapping.findForward("invoiceExcelList");
		}
		
		/**
		 * 계산서 미발행 리스트
		 * @param String 
		 * @return ActionForward
		 * @throws DAOException
		 */
		public ActionForward invoiceUnissuedList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

			String searchGb = StringUtil.nvl(request.getParameter("searchGb"),"");
			String searchtxt = StringUtil.nvl(request.getParameter("searchtxt"),"");
			//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
			String IvStartDate = StringUtil.nvl(request.getParameter("IvStartDate"),DateUtil.getDayInterval3(-365));
			System.out.println("IvStartDate:"+IvStartDate);
			String IvEndDate = StringUtil.nvl(request.getParameter("IvEndDate"),DateTimeUtil.getDateFormat(DateTimeUtil.getDate(),"-"));
			System.out.println("IvEndDate:"+IvEndDate);
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
			
			

			ListDTO ld = invoiceDao.invoiceUnissuedList(invoiceDto);

			model.put("listInfo",ld);	
			
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("searchGb",searchGb);
			model.put("searchtxt",searchtxt);
			//model.put("IvStartDate", IvStartDate);
			//model.put("IvEndDate", IvEndDate);
			
			return actionMapping.findForward("invoiceUnissuedList");
		}
		
		/**
		 * 계산서 미발행 Excel 리스트
		 * @param String 
		 * @return ActionForward
		 * @throws DAOException
		 */
		public ActionForward invoiceUnissuedExcelList(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response, Map model) throws Exception{

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
			
			

			ListDTO ld = invoiceDao.invoiceUnissuedExcelList(invoiceDto);

			model.put("listInfo",ld);	
			
			model.put("curPage",String.valueOf(curPageCnt));
			model.put("searchGb",searchGb);
			model.put("searchtxt",searchtxt);
			//model.put("IvStartDate", IvStartDate);
			//model.put("IvEndDate", IvEndDate);
			
			return actionMapping.findForward("invoiceUnissuedExcelList");
		}
}
