package com.huation.common.invoice;  

import java.io.BufferedWriter;
import java.io.Writer;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Vector;

import com.huation.common.BaseDAO;
import com.huation.common.bankmanage.BankManageDTO;
import com.huation.common.currentstatus.CurrentStatusDTO;
import com.huation.common.estimate.EstimateDTO;

import com.huation.framework.data.DataSet;
import com.huation.framework.persist.AbstractDAO;
import com.huation.framework.persist.DAOException;
import com.huation.framework.persist.ISqlStatement;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.persist.ListStatement;
import com.huation.framework.persist.QueryStatement;
import com.huation.framework.persist.ResultDTO;
import com.huation.framework.util.DateTimeUtil;
import com.huation.framework.util.NumberUtil;
import com.huation.framework.util.StringUtil;


public class InvoiceDAO extends AbstractDAO {
	
	/**
	 * 관리번호 카운트 구하기.
	 * @param  maPre
	 * @return ActionForward
	 * @throws DAOException 
	 */
	public String getManageCntNext(String maPre) throws DAOException{
		
		String maCnt = null;
		QueryStatement sql = new QueryStatement();
		
		sql.setSql("SELECT (ISNULL(COUNT(MANAGE_NO),0)+1) MA_CNT FROM T_INVOICE WHERE SUBSTRING(MANAGE_NO,1,7)=? "); 
		sql.setString(maPre);
		
		log.debug("[getManageCntNext]" + sql.toString());

		DataSet ds = null;
		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
				 maCnt = ds.getString("MA_CNT");
			 }
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}			
		
		return maCnt;
	}

	/**
	 * 관리번호 구하기.
	 * @param maPre
	 * @param maCnt
	 * @return ActionForward
	 * @throws DAOException
	 */
	public String getMaNo(String maPre,String maCnt) throws DAOException{
		
		String maNo = null;
		int ma_no =0;
 
		ma_no = NumberUtil.parseInt(maCnt,0);
        
        maNo = String.valueOf(ma_no);
        if(maNo.length()==1){
        	maNo = maPre+"0"+ ma_no;	
        }else if(maNo.length()==2){
        	maNo = maPre+ma_no;
        }else {
        	maNo="MAX";
        }
 
		return maNo;
	}	
	
	/**
	 * 관리번호 구하기.(function 사용)
	 * @param invoiceDto 결과 리턴용 dto
	 * @return ActionForward
	 * @throws DAOException
	 */
	public InvoiceDTO getInvoiceKey(InvoiceDTO invoiceDto) throws DAOException{
		
		String maCnt = null;
		QueryStatement sql = new QueryStatement();
		
		sql.setSql("SELECT gun,ho,manageno FROM dbo.getInvoiceKey2('"+invoiceDto.getProductno()+"') "); 

		log.debug("[getInvoiceKey]" + sql.toString());

		DataSet ds = null;
		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
				 invoiceDto.setGun(ds.getString("gun"));
				 invoiceDto.setHo(ds.getString("ho"));
				 invoiceDto.setManage_no(ds.getString("manageno"));
			 }
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}			
		
		return invoiceDto;
	}	
	
	/**
	 * 세금계산서 등록하기. 
	 * @param invoiceDto 세금계산서 정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int addInvoice(InvoiceDTO invoiceDto) throws Exception{
		
		int retval = 0;
		HashMap rtnMap = new HashMap();
		BaseDAO dao = null;
		int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
		HashMap m = null;
		boolean a = false;
		
		try {
			dao = new BaseDAO(this.getClass());
			dao.startTransaction();

			sql = new QueryStatement(); 
			 sb.append(" 		INSERT INTO T_INVOICE                                                       \n");
			 sb.append(" 		(PUBLIC_NO,GUN, HO, MANAGE_NO, APPROVE_NO,RECEIVER,PUBLIC_DT,PUBLIC_ORG,COMP_CODE,DEPOSIT_AMT, DEPOSIT_DT, REFERENCE,USE_YN,REG_ID,REG_DT,PRODUCTNO ,STATE,I_SUPPLY_PRICE ,I_VAT , PRE_DEPOSIT_DT, PRE_DEPOSIT_AN,PERMIT_NO,MGTKEY,ISSUETYPE,TELL,E_MAIL,CONTRACT_CODE,INVOICE_FILE,INVOICE_FILENM,DELETED_YN \n");
			 sb.append(" 		)                                                       \n");
			 sb.append(" 		VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  'Y' ,? ,Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':',''),? ,? ,? ,? ,?,?,?,?,?,?,?,?,?,?,?                                         \n");                                                  
			 sb.append(" 		)                                                       \n");
			 
			 sql.setSql(sb.toString());

			 sql.setString(invoiceDto.getPublic_no());
			 
			 sql.setString(invoiceDto.getGun());
			 sql.setString(invoiceDto.getHo());
			 sql.setString(invoiceDto.getManage_no());
			 sql.setString(invoiceDto.getApprove_no());
			 sql.setString(invoiceDto.getReceiver());
			 sql.setString(invoiceDto.getPublic_dt());
			 sql.setString(invoiceDto.getPublic_org());
			 sql.setString(invoiceDto.getComp_code());
			 sql.setLong(invoiceDto.getDeposit_amt());
			 sql.setString(invoiceDto.getDeposit_dt());
			 sql.setString(invoiceDto.getReference());
			 sql.setString(invoiceDto.getReg_id());
			 sql.setString(invoiceDto.getProductno());
			 sql.setString(invoiceDto.getState());
			 sql.setString(invoiceDto.getSupply_price());
			 sql.setString(invoiceDto.getVat());
			 sql.setString(invoiceDto.getPre_deposit_dt());
			 sql.setString(invoiceDto.getPre_deposit_an());
			 sql.setString(invoiceDto.getPermit_no()); //2013_03_22(금)shbyeon. DB사업자등록번호 칼럼추가(리스트 목록을위해.)
			 sql.setString(invoiceDto.getMGTKEY());
			 sql.setString(invoiceDto.getIssuetype());
			 sql.setString(invoiceDto.getTELL());
			 sql.setString(invoiceDto.getE_MAIL());
			 sql.setString(invoiceDto.getCONTRACT_CODE());
			 sql.setString(invoiceDto.getINVOICE_FILE());
			 sql.setString(invoiceDto.getINVOICE_FILENM());
			 sql.setString(invoiceDto.getDELETED_YN());
			 if( dao.executeQuery(sql) > 0 ){
				retval = 1;
			} else {
				retval = 0;
			}
			
			dao.commitTransaction();	
		 } catch (Exception e) {
			 	log.error(e.getMessage(), e);
			} finally {
				dao.endTransaction();
			}
		 return retval; 
		
	}
	/*
	 * 법인통장 은행명+계좌번호 리스트
	 */
public ListDTO getInvoiceViewBankAc(BankManageDTO bmDto) throws DAOException{
		
		String procedure = " { CALL hp_BankManageBankNameAC ( ?,?,? ) } ";
		
		ListDTO retVal = null;

		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setString(bmDto.getChUserID()); // 세션 아이디
		sql.setString("LIST"); // sp 구분
		sql.setString(bmDto.getAccountNumber());//코드검색(사이트명)

		sql.setSql(procedure);
		
		try{
			retVal=broker.executeListProcedure(sql);
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}			
		return retVal;
	}

	
	/**
	 * 계산서 수정하기. 
	 * @param invoiceDto 계산서 키
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int editInvoice(InvoiceDTO invoiceDto) throws DAOException{
		 int retVal = 0;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
		 ResultDTO rsDto = null;
		 
		 try{
			 sql = new QueryStatement(); 
			 sb.append(" UPDATE T_INVOICE SET					 ");
			 sb.append(" PUBLIC_NO=?, APPROVE_NO=?,CONTRACT_CODE=?,RECEIVER=?,PUBLIC_DT=? ,PUBLIC_ORG=?,COMP_CODE=?,DEPOSIT_AMT =?,DEPOSIT_DT=?,REFERENCE=?,I_SUPPLY_PRICE=? ,I_VAT=?,INVOICE_FILE=?,INVOICE_FILENM=?,PRE_DEPOSIT_DT=?,PRE_DEPOSIT_AN=?, MOD_ID=? ,STATE=?,PERMIT_NO=?, DEPOSITFINISH=?, MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','') ");
	         sb.append(" WHERE GUN=? AND HO=? AND MANAGE_NO=?				 ");
			 
	         sql.setSql(sb.toString());
	         sql.setString(invoiceDto.getPublic_no());
			 sql.setString(invoiceDto.getApprove_no());
			 sql.setString(invoiceDto.getCONTRACT_CODE());
			 sql.setString(invoiceDto.getReceiver());
			 sql.setString(invoiceDto.getPublic_dt());
			 sql.setString(invoiceDto.getPublic_org());
			 sql.setString(invoiceDto.getComp_code());
			 sql.setLong(invoiceDto.getDeposit_amt());
			 sql.setString(invoiceDto.getDeposit_dt());
			 sql.setString(invoiceDto.getReference());
			 sql.setString(invoiceDto.getSupply_price());
			 sql.setString(invoiceDto.getVat());
			 sql.setString(invoiceDto.getINVOICE_FILE());
			 sql.setString(invoiceDto.getINVOICE_FILENM());
			 sql.setString(invoiceDto.getPre_deposit_dt());
			 sql.setString(invoiceDto.getPre_deposit_an());
			 System.out.println("Pre_deposit_an:"+invoiceDto.getPre_deposit_an());
			 sql.setString(invoiceDto.getMod_id());
			 sql.setString(invoiceDto.getState());
			 sql.setString(invoiceDto.getPermit_no());
			 sql.setString(invoiceDto.getDepositFinish());
			 sql.setString(invoiceDto.getGun());
			 sql.setString(invoiceDto.getHo());
			 sql.setString(invoiceDto.getManage_no());
			
			 
			 
			 log.debug("[editInvoice]" + sql.toString());
			 conn = broker.getConnection();
			 conn.setAutoCommit(false);		 
			 
			 retVal = broker.executeUpdate(sql, conn);
		     if(retVal > 0){
			     conn.commit();
		     }else{
		     	 conn.rollback();
		     }	     
		 }catch(Exception e){
		 	e.printStackTrace();
			try {
				if(conn != null) conn.rollback(); 
			} catch(SQLException ignore) {
				log.error(ignore.getMessage(), ignore);
			}
			throw new DAOException(e.getMessage());
		 } finally {
		 	 if(rsDto != null) rsDto.close();
		 	 if(conn != null)  try    {conn.close();}     catch (Exception e) {}
		 }		 	
	 
	 return retVal; 
	}
	
	/**
	 * 세금계산서를 삭제한다.
	 * @param invoiceDto 계산서 키
	 * @return ActionForward
	 * @throws DAOException
	 */	
	public int deleteInvoiceOne(InvoiceDTO invoiceDto) throws DAOException{
		
		int retVal = 0;
		QueryStatement sql = new QueryStatement();
		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		
		sb.append(" UPDATE T_INVOICE  SET  	\n");
		sb.append(" USE_YN = 'N' ,MOD_ID=? ,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')	\n");
		sb.append("	WHERE GUN=? AND HO=? AND MANAGE_NO=? \n");
		
		sql.setString(invoiceDto.getMod_id());
		sql.setString(invoiceDto.getGun());
		sql.setString(invoiceDto.getHo());
		sql.setString(invoiceDto.getManage_no());
		sql.setSql(sb.toString());
		
		log.debug("[deleteInvoiceOne]" + sql.toString());

		try{
			conn = broker.getConnection();
			conn.setAutoCommit(false);
		    retVal = broker.executeUpdate(sql,conn);
		    
		    if(retVal > 0){
			    conn.commit();
			}else{
			    conn.rollback();
			}
		    
		}catch(Exception e){
			try {
				if(conn != null) conn.rollback(); 
			} catch(SQLException ignore) {
				log.error(ignore.getMessage(), ignore);
			}
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		 	 if(conn != null)  try    {conn.close();}     catch (Exception e) {}
		}		 
		return retVal;
	}
	/**
	 * 세금계산서 발행을 취소한다.
	 * @param invoiceDto 계산서 키
	 * @return ActionForward
	 * @throws DAOException
	 */	
	public int cancelInvoiceOne(InvoiceDTO invoiceDto) throws DAOException{
		
		int retVal = 0;
		QueryStatement sql = new QueryStatement();
		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		
		sb.append(" UPDATE T_INVOICE  SET  	\n");
		sb.append(" ISSUETYPE = '02', STATE = '02' ,MOD_ID=? ,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')	\n");
		sb.append("	WHERE GUN=? AND HO=? AND MANAGE_NO=? \n");
		
		sql.setString(invoiceDto.getMod_id());
		sql.setString(invoiceDto.getGun());
		sql.setString(invoiceDto.getHo());
		sql.setString(invoiceDto.getManage_no());
		sql.setSql(sb.toString());
		
		log.debug("[cancelInvoiceOne]" + sql.toString());

		try{
			conn = broker.getConnection();
			conn.setAutoCommit(false);
		    retVal = broker.executeUpdate(sql,conn);
		    
		    if(retVal > 0){
			    conn.commit();
			}else{
			    conn.rollback();
			}
		    
		}catch(Exception e){
			try {
				if(conn != null) conn.rollback(); 
			} catch(SQLException ignore) {
				log.error(ignore.getMessage(), ignore);
			}
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		 	 if(conn != null)  try    {conn.close();}     catch (Exception e) {}
		}		 
		return retVal;
	}	
		
	/**
	 * 세금계산서 리스트.   
	 * @param curpage  현재페이지
	 * @param searchGb   검색구분
	 * @param searchtxt  검색키 
	 * @param listScale  리스트 갯수
	 * @param pageScale  페이징 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO invoicePageList(int curpage,  String searchGb, String searchtxt, String IvStartDate, String IvEndDate,  int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;

		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			
			sql.setAlias(" PUBLIC_NO,GUN, HO, MANAGE_NO, APPROVE_NO,RECEIVER,PUBLIC_DT,PUBLIC_ORG,COMP_CODE,PERMIT_NO,COMP_NM,OWNER_NM,I_SUPPLY_PRICE, I_VAT,DEPOSIT_AMT, DEPOSIT_DT, REFERENCE,STATE,PRE_DEPOSIT_DT,TITLE,MGTKEY,ISSUETYPE,INVOICE_FILE,INVOICE_FILENM, REG_DT, ITEM_NAME ");
			sql.setSelect(" T1.PUBLIC_NO,T1.GUN, T1.HO, T1.MANAGE_NO, T1.APPROVE_NO,T1.RECEIVER,T1.PUBLIC_DT,T1.PUBLIC_ORG,T1.COMP_CODE, T1.PERMIT_NO,T2.COMP_NM, T2.OWNER_NM,T1.I_SUPPLY_PRICE, T1.I_VAT, T1.DEPOSIT_AMT, T1.DEPOSIT_DT, T1.REFERENCE,T1.STATE,T1.PRE_DEPOSIT_DT,T3.TITLE,T1.MGTKEY,T1.ISSUETYPE,T1.INVOICE_FILE,T1.INVOICE_FILENM, T1.REG_DT, case when T1.ISSUETYPE = '01' then (SELECT TOP 1 T4.ITEM_NAME FROM T_INVOICEITEM T4 WHERE T4.MGT_KEY = T1.MGTKEY) else T3.TITLE end AS ITEM_NAME ");
			sql.setFrom	(" T_INVOICE T1,T_COMPANY T2, T_ESTIMATE T3 \n");

			where += " T1.COMP_CODE=T2.COMP_CODE AND T1.DELETED_YN='N' AND T1.USE_YN='Y' AND T1.PUBLIC_NO = T3.PUBLIC_NO \n ";
			if(searchGb != null && !searchGb.equals(""))
			{
				if(searchGb.equals("A"))
				{
					where += " AND T1.PUBLIC_NO LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("B"))
				{
					where += " AND T3.TITLE LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("C"))
				{
					where += " AND T2.PERMIT_NO LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("D"))
				{
					where += " AND T2.COMP_NM LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("E"))
				{
					where += " AND T2.OWNER_NM LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				
			}
		
			//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
			if(IvStartDate != null && !IvStartDate.equals("") && IvEndDate != null && !IvEndDate.equals(""))
			{
					where += " AND PUBLIC_DT between ? and ? ";
					sql.setString(IvStartDate);
					sql.setString(IvEndDate);
			}

			sql.setWhere(where);
			sql.setOrderby(" REG_DT DESC ");
			//sql.setOrderby(" PUBLIC_DT DESC, PUBLIC_NO DESC ");
		
			conn = broker.getConnection();
			conn.setAutoCommit(false);
			
			//---- 쿼리실행 및 반환값 설정
			if(listScale != -1 && pageScale != -1){
				retVal = broker.executeListQuery(sql, curpage, listScale, pageScale);
			}else{
				retVal = broker.executeListQuery(sql, curpage);
			}
			
		    if(retVal != null){
			    conn.commit();
			}else{
			    conn.rollback();
			}
			
			
		}catch(SQLException e){
			try {
				if(conn != null) conn.rollback(); 
			} catch(SQLException ignore) {
				log.error(ignore.getMessage(), ignore);
			}
			log.error(e);
			throw new DAOException(e.getMessage());
		}catch(Exception e){
			try {
				if(conn != null) conn.rollback(); 
			} catch(SQLException ignore) {
				log.error(ignore.getMessage(), ignore);
			}
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		 	 if(conn != null)  try    {conn.close();}     catch (Exception e) {}
		}	
		
		return retVal;
	}
	
	
	/**
	 * 세금계산서 중 공급가액 합계.   
	 * @param searchGb   검색구분
	 * @param searchtxt  검색키 
	 * @return ActionForward
	 * @throws DAOException
	 */
	public InvoiceDTO getSumSupplyPrice(String searchGb, String searchtxt, String IvStartDate, String IvEndDate) throws DAOException {
		InvoiceDTO invoiceDto = new InvoiceDTO();
		
		Connection conn = null;
		QueryStatement sql = new QueryStatement();
		StringBuilder sb = new StringBuilder();
		
		sb.append(" SELECT replace( convert( VARCHAR, convert( MONEY, sum(case when issuetype = '02' then 0 else T1.I_SUPPLY_PRICE end) ), 1 ), '.00', '' )  as sumSupplyPrice \n");
		sb.append("      , replace( convert( VARCHAR, convert( MONEY, sum(case when issuetype = '02' then 0 else T1.I_VAT end) ), 1 ), '.00', '' )  as sumVat \n");
		sb.append("      , replace( convert( VARCHAR, convert( MONEY, sum(case when issuetype = '02' then 0 else T1.I_SUPPLY_PRICE + T1.I_VAT end) ), 1 ), '.00', '' )  as totalAmt \n");
		sb.append(" FROM   T_INVOICE T1,T_COMPANY T2, T_ESTIMATE T3 \n");
        sb.append(" WHERE  T1.COMP_CODE=T2.COMP_CODE AND T1.DELETED_YN='N' AND T1.USE_YN='Y' AND T1.PUBLIC_NO = T3.PUBLIC_NO \n ");
		
        if(searchGb != null && !searchGb.equals(""))
		{
			if(searchGb.equals("A"))
			{
				sb.append("      AND T1.PUBLIC_NO LIKE ? ");
			}
			if(searchGb.equals("B"))
			{
				sb.append("       AND T3.TITLE LIKE ? ");
			}
			if(searchGb.equals("C"))
			{
				sb.append("       AND T2.PERMIT_NO LIKE ? ");
			}
			if(searchGb.equals("D"))
			{
				sb.append("       AND T2.COMP_NM LIKE ? ");
			}
			if(searchGb.equals("E"))
			{
				sb.append("       AND T2.OWNER_NM LIKE ? ");
			}
		}
	
		if(IvStartDate != null && !IvStartDate.equals("") && IvEndDate != null && !IvEndDate.equals(""))
		{
			sb.append("       AND PUBLIC_DT between ? and ? ");
		}
		
		sql.setSql(sb.toString());
		
		if(searchGb != null && !searchGb.equals(""))
		{
			if(searchGb.equals("A"))
			{
				sql.setString("%" + searchtxt + "%");
			}
			if(searchGb.equals("B"))
			{
				sql.setString("%" + searchtxt + "%");
			}
			if(searchGb.equals("C"))
			{
				sql.setString("%" + searchtxt + "%");
			}
			if(searchGb.equals("D"))
			{
				sql.setString("%" + searchtxt + "%");
			}
			if(searchGb.equals("E"))
			{
				sql.setString("%" + searchtxt + "%");
			}
			
		}
	
		if(IvStartDate != null && !IvStartDate.equals("") && IvEndDate != null && !IvEndDate.equals(""))
		{
			sql.setString(IvStartDate);
			sql.setString(IvEndDate);
		}
		
		log.debug("[sumSupplyPrice]" + sql.toString());
		
		
		DataSet ds = null;
		try{
			conn = broker.getConnection();
			conn.setAutoCommit(false);
			
			ds = broker.executeQuery(sql);
			
			if(ds.next()){ 
				invoiceDto.setSupply_price(ds.getString("sumSupplyPrice"));
				invoiceDto.setVat(ds.getString("sumVat"));
				invoiceDto.setTotalAmt(ds.getString("totalAmt"));
			}
		
		}catch(SQLException e){
			try {
				if(conn != null) conn.rollback(); 
			} catch(SQLException ignore) {
				log.error(ignore.getMessage(), ignore);
			}
			log.error(e);
			throw new DAOException(e.getMessage());
		}catch(Exception e){
			try {
				if(conn != null) conn.rollback(); 
			} catch(SQLException ignore) {
				log.error(ignore.getMessage(), ignore);
			}
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
			if(conn != null)  try    {conn.close();}     catch (Exception e) {}
		}	
		
		return invoiceDto;
	}
	
	/**
	 * 세금계산서 View 정보.
	 * @param invoiceDto 계산서 키
	 * @return ActionForward
	 * @throws DAOException
	 */
	public InvoiceDTO getInvoiceView( InvoiceDTO invoiceDto) throws DAOException{
		
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		
		sb.append("				SELECT T1.PUBLIC_NO,T1.GUN,T1.HO,T1.MANAGE_NO,T1.APPROVE_NO ,T1.RECEIVER,T1.PUBLIC_DT,T1.PUBLIC_ORG,T1.DEPOSIT_AMT,T1.DEPOSIT_DT,T1.REFERENCE,T1.DEPOSITFINISH,  \n");
		sb.append("				       T2.COMP_CODE,T2.PERMIT_NO,T2.COMP_NM,T2.OWNER_NM,T2.BUSINESS,T2.B_ITEM,T2.ADDRESS,T2.ADDR_DETAIL,T2.POST,   \n");
		sb.append("				       T1.I_SUPPLY_PRICE,T1.I_VAT,T1.PRE_DEPOSIT_DT,T1.PRE_DEPOSIT_AN,  T3.TITLE,T1.CONTRACT_CODE , T1.TELL, T1.E_MAIL ,T1.MGTKEY,T1.APPROVE_NO,T1.ISSUETYPE, T1.DEPOSITFINISH  \n");
		sb.append("				FROM T_INVOICE T1,T_COMPANY T2, T_ESTIMATE T3	\n");
		sb.append("				WHERE T1.PERMIT_NO=T2.PERMIT_NO AND T1.USE_YN='Y' 	\n");
		sb.append("				    AND T1.PUBLIC_NO = T3.PUBLIC_NO AND T1.GUN=? AND T1.HO=? AND T1.MANAGE_NO=?	\n");
		
		//param
		sql.setSql(sb.toString());
		
		sql.setString(invoiceDto.getGun());
		sql.setString(invoiceDto.getHo());
		sql.setString(invoiceDto.getManage_no());
		
		log.debug(sb.toString());
		
		DataSet ds = null;
		try{
			ds = broker.executeQuery(sql);
			
			if(ds.next()){ 
				invoiceDto = new InvoiceDTO();
				EstimateDTO esDto = new EstimateDTO();
				
				invoiceDto.setPublic_no(StringUtil.nvl(ds.getString("PUBLIC_NO"),""));
				invoiceDto.setGun(StringUtil.nvl(ds.getString("GUN"),""));
				invoiceDto.setHo(StringUtil.nvl(ds.getString("HO"),""));
				invoiceDto.setManage_no(StringUtil.nvl(ds.getString("MANAGE_NO"),""));
				invoiceDto.setApprove_no(StringUtil.nvl(ds.getString("APPROVE_NO"),""));
				invoiceDto.setReceiver(StringUtil.nvl(ds.getString("RECEIVER"),""));
				invoiceDto.setPublic_dt(StringUtil.nvl(ds.getString("PUBLIC_DT"),""));
				invoiceDto.setPublic_org(StringUtil.nvl(ds.getString("PUBLIC_ORG"),""));
				invoiceDto.setDeposit_amt(StringUtil.nvl(ds.getString("DEPOSIT_AMT"),"0"));
				invoiceDto.setDeposit_dt(StringUtil.nvl(ds.getString("DEPOSIT_DT"),""));
				invoiceDto.setReference(StringUtil.nvl(ds.getString("REFERENCE"),""));
				invoiceDto.setComp_code(StringUtil.nvl(ds.getString("COMP_CODE"),""));
				invoiceDto.setComp_nm(StringUtil.nvl(ds.getString("COMP_NM"),""));
				invoiceDto.setOwner_nm(StringUtil.nvl(ds.getString("OWNER_NM"),""));
				invoiceDto.setBusiness(StringUtil.nvl(ds.getString("BUSINESS"),""));
				invoiceDto.setB_item(StringUtil.nvl(ds.getString("B_ITEM"),""));
				invoiceDto.setAddress(StringUtil.nvl(ds.getString("ADDRESS"),""));
				invoiceDto.setAddr_detail(StringUtil.nvl(ds.getString("ADDR_DETAIL"),""));
				invoiceDto.setPost(StringUtil.nvl(ds.getString("POST"),""));
				invoiceDto.setSupply_price(StringUtil.nvl(ds.getString("I_SUPPLY_PRICE"),"0"));
				invoiceDto.setVat(StringUtil.nvl(ds.getString("I_VAT"),"0"));
				invoiceDto.setPre_deposit_dt(StringUtil.nvl(ds.getString("PRE_DEPOSIT_DT"),""));
				invoiceDto.setPre_deposit_an(StringUtil.nvl(ds.getString("PRE_DEPOSIT_AN"), ""));
				invoiceDto.setCONTRACT_CODE(StringUtil.nvl(ds.getString("CONTRACT_CODE"), ""));
				invoiceDto.setTELL(StringUtil.nvl(ds.getString("TELL"), ""));
				invoiceDto.setE_MAIL(StringUtil.nvl(ds.getString("E_MAIL"), ""));
				invoiceDto.setMGTKEY(StringUtil.nvl(ds.getString("MGTKEY"), ""));
				invoiceDto.setApprove_no(StringUtil.nvl(ds.getString("APPROVE_NO"), ""));
				invoiceDto.setIssuetype(StringUtil.nvl(ds.getString("ISSUETYPE"), ""));
				invoiceDto.setDepositFinish(StringUtil.nvl(ds.getString("DEPOSITFINISH"), ""));
				log.debug("title1:"+ds.getString("TITLE"));
				invoiceDto.setTITLE(StringUtil.nvl(ds.getString("TITLE"),""));
				log.debug("title2:"+ds.getString("TITLE"));
				invoiceDto.setPermit_no(StringUtil.nvl(ds.getString("PERMIT_NO"),""));
				log.debug("title2:"+ds.getString("PERMIT_NO"));
			}
		}catch(Exception e){
		    e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}
		
		return invoiceDto;
	}
	
	/**
	 * 영업지원->(견적서발행) 상품코드 리스트.
	 * 2013_04_29(월) shbyeon.
	 *
	 */
	public ListDTO getItemList(InvoiceDTO invoiceDto) throws DAOException{
	    ListDTO  itemList = null;
		/* QueryStatement sql = new QueryStatement();*/
		/* StringBuffer sb = new StringBuffer();
		 sb.append(" select A.ProductCode, B.CD_NM as ProductName "); 
		 sb.append(" from htSalesProductCode A ");
		 sb.append(" left join T_CODE B on B.BIG_CD = A.ProductCode ");
		 sb.append(" where ProductMappingPk = ? and EstimateUpdate = 'Y' ");
		 sql.setString(invoiceDto.getMGTKEY()); //견적서 발행의 PreSalesCode 셋팅.
		 log.debug("[견적서 발행 상세정보  PUBLIC_NO=SQL_SET("+estimateDto.getPublic_no()+") DAO..");
		 sb.append(" order by CreateDateTime asc ");
		 sql.setSql(sb.toString());*/
	    String mgtkey = invoiceDto.getMGTKEY();
	   
		 String procedure = "{ CALL hp_InvoiceItemSelect ( ? ) }";
		 
		 DataSet rs = null;
		 
		 QueryStatement sql = new QueryStatement();
		 sql.setSql(procedure);
		 sql.setString(mgtkey);
		 System.out.println("여기는 dao--:"+mgtkey);
			
		 
		 
		 try{
			 itemList = broker.executeListProcedure(sql);
			/* itemList = new ArrayList();
			 while(rs.next()){
				 CurrentStatusDTO  csDtoPro = new CurrentStatusDTO(); //견적서 발행에 상세정보의 상품코드를 꺼내올 용도로 사용한 DTO
				 InvoiceItemDTO itemDto = new InvoiceItemDTO();
				 itemDto.setMGT_KEY(rs.getString("MGT_KEY"));    //영업진행현황 DTO사용한 것. 별도의 DTO생성을 줄이기 위함.
				 itemDto.setWHITE_DT(rs.getString("WHITE_DT")); //상품 코드
				 itemDto.setITEM_NAME(rs.getString("ITEM_NAME")); //상품 명
				 itemDto.setSPEC(rs.getString("SPEC"));
				 itemDto.setQTY(rs.getString("QTY"));
				 itemDto.setUNIT_COSE(rs.getString("UNIT_COSE"));
				 itemDto.setAMOUNT(rs.getString("AMOUNT"));
				 itemDto.setTAX(rs.getString("TAX"));
				 itemDto.setETC(rs.getString("ETC"));
				 itemList.add(itemDto);
				 System.out.println("견적서발행 상품리스트2");
				 System.out.println("aasdasdasd:"+rs.getString("MGT_KEY"));
				 System.out.println("aasdasdasd:"+rs.getString("WHITE_DT"));
				 System.out.println("aasdasdasd:"+rs.getString("ITEM_NAME"));*/
			
		 }catch(Exception e){
			 e.printStackTrace();
			 throw new DAOException(e.getMessage());
		 }

		 return itemList;   
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 세금계산서 수정발행 정보.
	 * @param invoiceDto 계산서 키
	 * @return ActionForward
	 * @throws DAOException
	 */
	public InvoiceDTO getEditInvoiceView( InvoiceDTO invoiceDto) throws DAOException{
		
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		
		sb.append("				SELECT T1.PUBLIC_NO,T1.GUN,T1.HO,T1.MANAGE_NO,T1.APPROVE_NO ,T1.RECEIVER,T1.PUBLIC_DT,T1.PUBLIC_ORG,T1.DEPOSIT_AMT,T1.DEPOSIT_DT,T1.REFERENCE,   \n");
		sb.append("				       T2.COMP_CODE,T2.PERMIT_NO,T2.COMP_NM,T2.OWNER_NM,T2.BUSINESS,T2.B_ITEM,T2.ADDRESS,T2.ADDR_DETAIL,T2.POST,   \n");
		sb.append("				       T1.I_SUPPLY_PRICE,T1.I_VAT,T1.PRE_DEPOSIT_DT,T1.PRE_DEPOSIT_AN, T3.TITLE   \n");
		sb.append("				FROM T_INVOICE T1,T_COMPANY T2, T_ESTIMATE T3	\n");
		sb.append("				WHERE T1.PERMIT_NO=T2.PERMIT_NO AND T1.USE_YN='Y' 	\n");
		sb.append("				    AND T1.PUBLIC_NO = T3.PUBLIC_NO AND T1.GUN=? AND T1.HO=? AND T1.MANAGE_NO=?	\n");
		
		//param
		sql.setSql(sb.toString());
		
		sql.setString(invoiceDto.getGun());
		sql.setString(invoiceDto.getHo());
		sql.setString(invoiceDto.getManage_no());
		
		log.debug(sb.toString());
		
		DataSet ds = null;
		try{
			ds = broker.executeQuery(sql);
			
			if(ds.next()){ 
				invoiceDto = new InvoiceDTO();
				EstimateDTO esDto = new EstimateDTO();
				
				invoiceDto.setPublic_no(StringUtil.nvl(ds.getString("PUBLIC_NO"),""));
				invoiceDto.setGun(StringUtil.nvl(ds.getString("GUN"),""));
				invoiceDto.setHo(StringUtil.nvl(ds.getString("HO"),""));
				invoiceDto.setManage_no(StringUtil.nvl(ds.getString("MANAGE_NO"),""));
				invoiceDto.setApprove_no(StringUtil.nvl(ds.getString("APPROVE_NO"),""));
				invoiceDto.setReceiver(StringUtil.nvl(ds.getString("RECEIVER"),""));
				invoiceDto.setPublic_dt(StringUtil.nvl(ds.getString("PUBLIC_DT"),""));
				invoiceDto.setPublic_org(StringUtil.nvl(ds.getString("PUBLIC_ORG"),""));
				invoiceDto.setDeposit_amt(StringUtil.nvl(ds.getString("DEPOSIT_AMT"),"0"));
				invoiceDto.setDeposit_dt(StringUtil.nvl(ds.getString("DEPOSIT_DT"),""));
				invoiceDto.setReference(StringUtil.nvl(ds.getString("REFERENCE"),""));
				invoiceDto.setComp_code(StringUtil.nvl(ds.getString("COMP_CODE"),""));
				invoiceDto.setComp_nm(StringUtil.nvl(ds.getString("COMP_NM"),""));
				invoiceDto.setOwner_nm(StringUtil.nvl(ds.getString("OWNER_NM"),""));
				invoiceDto.setBusiness(StringUtil.nvl(ds.getString("BUSINESS"),""));
				invoiceDto.setB_item(StringUtil.nvl(ds.getString("B_ITEM"),""));
				invoiceDto.setAddress(StringUtil.nvl(ds.getString("ADDRESS"),""));
				invoiceDto.setAddr_detail(StringUtil.nvl(ds.getString("ADDR_DETAIL"),""));
				invoiceDto.setPost(StringUtil.nvl(ds.getString("POST"),""));
				invoiceDto.setSupply_price(StringUtil.nvl(ds.getString("I_SUPPLY_PRICE"),"0"));
				invoiceDto.setVat(StringUtil.nvl(ds.getString("I_VAT"),"0"));
				invoiceDto.setPre_deposit_dt(StringUtil.nvl(ds.getString("PRE_DEPOSIT_DT"),""));
				invoiceDto.setPre_deposit_an(StringUtil.nvl(ds.getString("PRE_DEPOSIT_AN"), ""));
				
				
				System.out.println("PRE_DEPOSIT_AN:"+ds.getString("PRE_DEPOSIT_AN"));
				System.out.println("PRE_DEPOSIT_AN:"+ds.getString("APPROVE_NO"));
				System.out.println("PRE_DEPOSIT_AN:"+ds.getString("MANAGE_NO"));
				System.out.println("PRE_DEPOSIT_AN:"+ds.getString("RECEIVER"));
				System.out.println("PRE_DEPOSIT_AN:"+ds.getString("PUBLIC_DT"));
				System.out.println("PRE_DEPOSIT_AN:"+ds.getString("GUN"));
				
				log.debug("title1:"+ds.getString("TITLE"));
				invoiceDto.setTITLE(StringUtil.nvl(ds.getString("TITLE"),""));
				log.debug("title2:"+ds.getString("TITLE"));
				invoiceDto.setPermit_no(StringUtil.nvl(ds.getString("PERMIT_NO"),""));
				log.debug("title2:"+ds.getString("PERMIT_NO"));
			}
		}catch(Exception e){
		    e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}
		
		return invoiceDto;
	}
	
	
	
	
	
	
	
	
	/**
	 * 세금계산서 EXCEL 리스트
	 * @param dto 계산서정보
	 * @return jsp
	 * @throws DAOException
	 */
	public ArrayList getInvoiceListExcel(InvoiceDTO dto) throws DAOException {
		QueryStatement sql = new QueryStatement();
		StringBuffer sbSql = new StringBuffer();
		InvoiceDTO invoiceDTO  =null;
		ArrayList<InvoiceDTO> arrlist = new ArrayList<InvoiceDTO>();
		try{			
			String searchGb=dto.getSearchGb();
			String IvStartDate=dto.getIvStartDate();
			String IvEndDate=dto.getIvEndDate();
			
			sbSql.append(" SELECT T1.PUBLIC_NO,T1.GUN, T1.HO, T1.MANAGE_NO, T1.APPROVE_NO,T1.RECEIVER,T1.PUBLIC_DT,T1.PUBLIC_ORG,T1.COMP_CODE,T2.COMP_NM,T2.OWNER_NM,T1.I_SUPPLY_PRICE, T1.I_VAT, T1.DEPOSIT_AMT, T1.DEPOSIT_DT, T1.REFERENCE,T1.STATE,T1.PRE_DEPOSIT_DT,T1.PERMIT_NO,T3.TITLE,T1.MGTKEY,T1.ISSUETYPE, T1.REG_DT, case when T1.ISSUETYPE = '01' then (SELECT TOP 1 T4.ITEM_NAME FROM T_INVOICEITEM T4 WHERE T4.MGT_KEY = T1.MGTKEY) else T3.TITLE end AS ITEM_NAME  ");
			sbSql.append(" FROM T_INVOICE T1,T_COMPANY T2,T_ESTIMATE T3 ");
			sbSql.append(" WHERE T1.PERMIT_NO=T2.PERMIT_NO AND T1.PUBLIC_NO = T3.PUBLIC_NO  AND T1.USE_YN='Y'  ");
			
			if(!("").equals(searchGb)){
				if( "A".equals(searchGb) && !("").equals(dto.getSearchTxt()) ){
					sbSql.append(" and T1.PUBLIC_NO like '%"+dto.getSearchTxt()+"%' ");
				} else if ("B".equals(searchGb)  && !("").equals(dto.getSearchTxt()) ){
					sbSql.append(" and T1.PUBLIC_ORG like '%"+dto.getSearchTxt()+"%' ");
				}else if ("C".equals(searchGb)  && !("").equals(dto.getSearchTxt()) ){
					sbSql.append(" and T2.COMP_CODE like '%"+dto.getSearchTxt()+"%' ");
				}else if ("D".equals(searchGb)  && !("").equals(dto.getSearchTxt()) ){
					sbSql.append(" and T2.COMP_NM like '%"+dto.getSearchTxt()+"%' ");
				}else if ("E".equals(searchGb)  && !("").equals(dto.getSearchTxt()) ){
					sbSql.append(" and T2.OWNER_NM like '%"+dto.getSearchTxt()+"%' ");
				}
			}
			
			//2013_05_29(수)shbyeon. 달력 검색 기능 추가.
			if(IvStartDate != null && !IvStartDate.equals("") && IvEndDate != null && !IvEndDate.equals(""))
			{
					sbSql.append(" AND PUBLIC_DT between '"+IvStartDate+"'and'"+IvEndDate+"' ");
					//sql.setString(IvStartDate);
					//sql.setString(IvEndDate);
			}
			
			sbSql.append(" ORDER BY REG_DT DESC ");
//			sbSql.append(" ORDER BY PUBLIC_DT DESC, PUBLIC_NO DESC ");
			
			sql.setSql(sbSql.toString());
			log.debug("getInvoiceListExcel["+sbSql.toString()+"]");	
			
			 DataSet ds = null;
			 try{
				 ds = broker.executeQuery(sql);
			
				 while(ds.next()){ 
					 invoiceDTO = new InvoiceDTO();
					 invoiceDTO.setPublic_no(ds.getString("PUBLIC_NO"));
					 invoiceDTO.setGun(ds.getString("GUN"));
					 invoiceDTO.setHo(ds.getString("HO"));
					 invoiceDTO.setManage_no(ds.getString("MANAGE_NO"));
					 invoiceDTO.setApprove_no(ds.getString("APPROVE_NO"));
					 invoiceDTO.setReceiver(ds.getString("RECEIVER"));
					 invoiceDTO.setPublic_dt(ds.getString("PUBLIC_DT"));
					 invoiceDTO.setPublic_org(ds.getString("PUBLIC_ORG"));
					 invoiceDTO.setComp_code(ds.getString("COMP_CODE"));
					 invoiceDTO.setComp_nm(ds.getString("COMP_NM"));
					 invoiceDTO.setOwner_nm(ds.getString("OWNER_NM"));
					 invoiceDTO.setSupply_price(ds.getString("I_SUPPLY_PRICE"));
					 invoiceDTO.setVat(ds.getString("I_VAT"));
					 invoiceDTO.setDeposit_amt(ds.getString("DEPOSIT_AMT"));
					 invoiceDTO.setDeposit_dt(ds.getString("DEPOSIT_DT"));
					 invoiceDTO.setReference(ds.getString("REFERENCE"));
					 invoiceDTO.setState(ds.getString("STATE"));
					 invoiceDTO.setPre_deposit_dt(ds.getString("PRE_DEPOSIT_DT"));
					 invoiceDTO.setTITLE(ds.getString("TITLE"));
					 System.out.println("견적서명::"+ds.getString("TITLE"));
					 invoiceDTO.setPermit_no(ds.getString("PERMIT_NO"));
					 invoiceDTO.setMGTKEY(ds.getString("MGTKEY"));
					 invoiceDTO.setIssuetype(ds.getString("ISSUETYPE"));
					 invoiceDTO.setITEM_NAME(ds.getString("ITEM_NAME"));
					 arrlist.add(invoiceDTO);
				 }
			 }catch(Exception e){
			      e.printStackTrace();
			      log.error(e.getMessage());
				 throw new DAOException(e.getMessage());
			 }finally{
				 if(ds != null) ds.close();
		    }
			 return arrlist;

			 
		}catch(Exception e){
			throw new DAOException(e.getMessage());
		}
	}
	/**
	 * 세금계산서 발행 리스트
	 * @param dto 
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ArrayList getInvoiceListDetail(InvoiceDTO dto) throws DAOException {
		QueryStatement sql = new QueryStatement();
		StringBuffer sbSql = new StringBuffer();
		InvoiceDTO invoiceDTO  =null;
		ArrayList<InvoiceDTO> arrlist = new ArrayList<InvoiceDTO>();
		try{			
			String searchGb=dto.getSearchGb();
			
			sbSql.append(" SELECT T2.GUN,T2.HO,T2.MANAGE_NO, T2.APPROVE_NO,T2.PUBLIC_DT,T2.DEPOSIT_AMT, T2.DEPOSIT_DT , T2.STATE , T2.PRE_DEPOSIT_DT , T2.I_VAT , T2.I_SUPPLY_PRICE , ");
			sbSql.append(" (SELECT (SUPPLY_PRICE+VAT) AS T_ESTIAMT FROM T_ESTIMATE WHERE PUBLIC_NO = '"+dto.getPublic_no()+"' ) AS T_ESTIAMT ,");
			sbSql.append(" (SELECT (SUM(T1.DEPOSIT_AMT))AS T_DEPOSIAMT FROM T_INVOICE T1 WHERE T1.PUBLIC_NO ='"+dto.getPublic_no()+"' AND T1.PUBLIC_DT <=T2.PUBLIC_DT AND T1.USE_YN='Y') AS T_DEPOSIAMT");
			sbSql.append(" FROM T_INVOICE T2 ");
			sbSql.append(" WHERE T2.USE_YN='Y' AND T2.STATE <> '02' AND T2.PUBLIC_NO = '"+dto.getPublic_no()+"' ORDER BY PUBLIC_DT ASC ");
			
			//sbSql.append(" ORDER BY PUBLIC_DT ASC ");
			
			sql.setSql(sbSql.toString());
			log.debug("getInvoiceListDetail["+sbSql.toString()+"]");	
			
			 DataSet ds = null;
			 try{
				 ds = broker.executeQuery(sql);
			
				 while(ds.next()){ 
					 invoiceDTO = new InvoiceDTO();
					 invoiceDTO.setGun(ds.getString("GUN")); 
					 invoiceDTO.setHo(ds.getString("HO"));
					 invoiceDTO.setManage_no(ds.getString("MANAGE_NO"));
					 invoiceDTO.setApprove_no(ds.getString("APPROVE_NO"));
					 invoiceDTO.setPublic_dt(ds.getString("PUBLIC_DT"));
					 invoiceDTO.setDeposit_amt(ds.getString("DEPOSIT_AMT"));
					 invoiceDTO.setDeposit_dt(ds.getString("DEPOSIT_DT"));
					 invoiceDTO.setT_estiamt(ds.getString("T_ESTIAMT"));
					 invoiceDTO.setT_deposiamt(ds.getString("T_DEPOSIAMT"));
					 invoiceDTO.setState(ds.getString("STATE"));
					 System.out.println("상태값:"+ds.getString("STATE"));
					 invoiceDTO.setPre_deposit_dt(ds.getString("PRE_DEPOSIT_DT"));
					 invoiceDTO.setVat_i(ds.getLong("I_VAT"));
					 invoiceDTO.setSupply_price_i(ds.getLong("I_SUPPLY_PRICE"));
					 arrlist.add(invoiceDTO);
				 }
			 }catch(Exception e){
			      e.printStackTrace();
			      log.error(e.getMessage());
				 throw new DAOException(e.getMessage());
			 }finally{
				 if(ds != null) ds.close();
		    }
			 return arrlist;

			 
		}catch(Exception e){
			throw new DAOException(e.getMessage());
		}
	}
	
	
	/**
	 * 2013_03_14(목) shbyeon.
	 * 영업지원->견적서 최초 발행으로 상품코드 등록
	 * Description : 견적서 최초발행,모발행,영업진행현황 최초발행,즉시발행 공통사용 됨.
	 * @throws DAOException
	 */	
	public int addInvoiceItem(String MgtNum, String WriteDT, String[] ItemName,String[] Spec,String[] Qty,String[] UnitCost,String[] Amount,String[] Tax,String[] Remark) throws DAOException{
		
		String procedure = " { CALL hp_invoiceITemUpdate ( ?,?,?,?,?,?,?,?,? ) } ";
		
		int retVal = 0;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; ItemName != null && i<ItemName.length; i++){ 
				
				List batch=new Vector();

				
				batch.add(MgtNum);
				batch.add(WriteDT);
				batch.add(ItemName[i]);
				batch.add(Spec[i]);
				batch.add(Qty[i]);
				batch.add(UnitCost[i]);
				batch.add(Amount[i]);
				batch.add(Tax[i]);
				batch.add(Remark[i]);
				batchList.add(batch);
			}
			
		
			sql.setBatch(batchList);
			resultVal=broker.executeProcedureBatch(sql);
			
			for(int i=0;i<resultVal.length;i++){
				if(resultVal[i]==-1){
					retVal=-1;
					break;
				}else{
					retVal=resultVal[i];
				}
			}
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally{
			return retVal;
		}

    }
	
	/**
	 * 계산서미발행현황리스트
	 * @param dto 
	 * @return ActionForward
	 * @throws DAOException
	 */
	
	public ListDTO invoiceUnissuedList(InvoiceDTO invoiceDto) throws DAOException {
		ListDTO retVal = null;
		Connection conn = null;

		String procedure = " { CALL hp_invoiceUnissued (?,?,?,?,?) } ";	
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setString(invoiceDto.getSearchGb());
		sql.setString(invoiceDto.getSearchTxt());
		//sql.setString(EsStartDate);
		//sql.setString(EsEndDate);
		sql.setInteger(invoiceDto.getnRow());
		sql.setInteger(invoiceDto.getCurPage());
		sql.setString("PAGE"); 
		
		try {

			retVal = broker.executeListProcedure(sql);

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;
	}
	
	
	/**
	 * 계산서미발행현황 Excel 리스트
	 * @param dto 
	 * @return ActionForward
	 * @throws DAOException
	 */
	
	public ListDTO invoiceUnissuedExcelList(InvoiceDTO invoiceDto) throws DAOException {
		ListDTO retVal = null;
		Connection conn = null;

		String procedure = " { CALL hp_invoiceUnissued (?,?,?,?,?) } ";	
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setString(invoiceDto.getSearchGb());
		sql.setString(invoiceDto.getSearchTxt());
		//sql.setString(EsStartDate);
		//sql.setString(EsEndDate);
		sql.setInteger(invoiceDto.getnRow());
		sql.setInteger(invoiceDto.getCurPage());
		sql.setString("LIST"); 
		
		try {

			retVal = broker.executeListProcedure(sql);

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;
	}
	
	
	/**
	 * 미수채권 현황 리스트.   
	 * @param curpage  현재페이지
	 * @param searchGb  검색구분	
	 * @param searchtxt   검색키
	 * @param listScale  리스트 갯수
	 * @param pageScale  페이징 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO outstandingBondList(InvoiceDTO invoiceDto) throws DAOException {
		ListDTO retVal = null;
		Connection conn = null;

		String procedure = " { CALL hp_outstandingBond (?,?,?,?,?) } ";	
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setString(invoiceDto.getSearchGb());
		sql.setString(invoiceDto.getSearchTxt());
		//sql.setString(EsStartDate);
		//sql.setString(EsEndDate);
		sql.setInteger(invoiceDto.getnRow());
		sql.setInteger(invoiceDto.getCurPage());
		sql.setString("PAGE"); 
		
		try {
			retVal = broker.executeListProcedure(sql);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;
	}
	
	/**
	 * 미수채권 현황 Excel 리스트.   
	 * @param curpage  현재페이지
	 * @param searchGb  검색구분	
	 * @param searchtxt   검색키
	 * @param listScale  리스트 갯수
	 * @param pageScale  페이징 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO outstandingBondExcelList(InvoiceDTO invoiceDto) throws DAOException {
		ListDTO retVal = null;

		String procedure = " { CALL hp_outstandingBond (?,?,?,?,?) } ";	
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setString(invoiceDto.getSearchGb());
		sql.setString(invoiceDto.getSearchTxt());
		//sql.setString(EsStartDate);
		//sql.setString(EsEndDate);
		sql.setInteger(invoiceDto.getnRow());
		sql.setInteger(invoiceDto.getCurPage());
		sql.setString("LIST"); 
		
		try {

			retVal = broker.executeListProcedure(sql);

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;
	}
	
	
	
 }
