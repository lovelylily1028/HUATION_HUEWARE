package com.huation.common.estimate;  


import java.io.BufferedWriter;
import java.io.Writer;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.huation.common.BaseDAO;
import com.huation.common.contractmanage.ContractManageDTO;
import com.huation.common.currentstatus.CurrentStatusDTO;
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


public class EstimateDAO extends AbstractDAO {
	
	/**
	 * 발행 일련 카운트 구하기.
	 * @param  pubPre 이전키값
	 * @return ActionForward
	 * @throws DAOException 
	 */
	public String getPubCntNext(String pubPre) throws DAOException{
		
		String pubCnt = null;
		QueryStatement sql = new QueryStatement();
		
		sql.setSql("SELECT (ISNULL(COUNT(PUBLIC_NO),0)+1) PUB_CNT FROM T_ESTIMATE WHERE SUBSTRING(PUBLIC_NO,1,8)=? and USE_YN='Y'"); 
		sql.setString(pubPre);
		
		log.debug("[getPubCntNext]" + sql.toString());

		DataSet ds = null;
		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
			 	pubCnt = ds.getString("PUB_CNT");

			 }
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}			
		
		return pubCnt;
	}

	/**
	 * 발행번호 구하기.
	 * @param pubPre 이전키값
	 * @param pubCnt 카운트
	 * @return ActionForward
	 * @throws DAOException
	 */
	public String getPubNo(String pubPre,String pubCnt) throws DAOException{
		
		String pubNo = null;
		int pub_no =0;
 
        pub_no = NumberUtil.parseInt(pubCnt,0);
        
        pubNo = String.valueOf(pub_no);
        if(pubNo.length()==1){
        	pubNo = pubPre+"0"+ pub_no;	
        }else if(pubNo.length()==2){
        	pubNo = pubPre+pub_no;
        }else {
        	pubNo="MAX";
        }
 
		return pubNo;
	}
	
	/**
	 * 2013_05_13(월)shbyeon.
	 * 발행번호 삭제하고 날짜(publicNo 발행번호)기준으로 바로 그전 데이터로  가져오기.
	 * @param  pubPre 이전키값
	 * @return ActionForward
	 * @throws DAOException 
	 */
	public CurrentStatusDTO getPubSelect(CurrentStatusDTO csDto) throws DAOException{
		
		String pubCnt = null;
		QueryStatement sql = new QueryStatement();
		
		sql.setSql("select PROJECT_PK_CODE,PUBLIC_NO,P_PUBLIC_NO,CONTRACT_YN,ORDERBLE,SALES_CHARGE,ESTIMATE_E_FILE,ESTIMATE_E_FILENM,ESTIMATE_P_FILE,ESTIMATE_P_FILENM  from T_ESTIMATE where PROJECT_PK_CODE = ? and PUBLIC_NO <> ? and USE_YN ='Y' order by REG_DT desc "); 
		sql.setString(csDto.getPreSalesCode());
		sql.setString(csDto.getPublicNo());
	
		//log.debug("[getPubCntNext]" + sql.toString());

		DataSet ds = null;
		csDto = new CurrentStatusDTO();
		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
				 	csDto.setPreSalesCode(ds.getString("PROJECT_PK_CODE")); //견적서 프로젝트 코드 셋팅
				    csDto.setPublicNo(ds.getString("PUBLIC_NO")); 		//견적서 발행으로 받은 견적번호 셋팅
					csDto.setP_PublicNo(ds.getString("P_PUBLIC_NO")); 	//견적서 발행으로 받은 모발행번호 셋팅
					csDto.setOrderStatus(ds.getString("CONTRACT_YN"));  //견적서 발행으로 받은 계약여부 셋팅
					csDto.setOrderble(ds.getString("ORDERBLE")); 		//견적서 발행으로 받은 수주상태 셋팅
					csDto.setChargeID(ds.getString("SALES_CHARGE"));	//견적서 발행으로 받은 담당영업 셋팅
					csDto.setSalesFile_Xls(ds.getString("ESTIMATE_E_FILE"));      //견적서 발행으로 받은 엑셀 파일 경로 셋팅
					csDto.setSalesFileNm_Xls(ds.getString("ESTIMATE_E_FILENM"));  //견적서 발행으로 받은 엑셀 파일 이름 셋팅
					csDto.setSalesFile_Pdf(ds.getString("ESTIMATE_P_FILE"));	  //견적서 발행으로 받은 PDF 파일 경로셋팅
					csDto.setSalesFileNm_Pdf(ds.getString("ESTIMATE_P_FILENM"));  //견적서 발행으로 받은 PDF 파일 이름 셋팅
			 }
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}			
		
		return csDto;
	}
	
	/**
	 * 견적서 등록하기. 
	 * @param estimateDto 견적서 정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int addEstimate(EstimateDTO estimateDto) throws Exception{
		
		int retVal = 0;
		//HashMap rtnMap = new HashMap(); 프로시저 변경 후 사용안함.
		//BaseDAO dao = null; 프로시저 변경 후 사용안함.
		 QueryStatement sql = new QueryStatement();
		 String procedure = " { CALL hp_EstimateRegist_bsh (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";
		 //StringBuffer sb = new StringBuffer(); 프로시저 변경 후 사용안함.
		 //Connection conn = null; 프로시저 변경 후 사용안함.
		//HashMap m = null; 프로시저 변경 후 사용안함.
		//boolean a = false; 프로시저 변경 후 사용안함.
		
		 sql.setSql(procedure); // 프로시져 명
		 sql.setString(estimateDto.getPROJECT_PK_CODE());
		 sql.setString(estimateDto.getPublic_no());
		 sql.setString(estimateDto.getP_public_no());
		 sql.setString(estimateDto.getEstimate_dt());
		 sql.setString(estimateDto.getComp_code());
		 sql.setString(estimateDto.getReceiver());
		 sql.setString(estimateDto.getTitle());
		 sql.setString(estimateDto.getSupply_price());
		 sql.setString(estimateDto.getVat());
		 sql.setString(estimateDto.getReg_id());
		 sql.setString(estimateDto.getSales_charge());
		 sql.setString(estimateDto.getEtc());
		 sql.setString(estimateDto.getE_comp_nm());
		 sql.setString(estimateDto.getProductno());
		 sql.setString(estimateDto.getD_public_yn());
		 sql.setString(estimateDto.getOrderble());
		 sql.setString(estimateDto.getEstimate_e_file());
		 sql.setString(estimateDto.getEstimate_p_file());
		 sql.setString(estimateDto.getContract_yn());
		 sql.setString(estimateDto.getSalescurrent_yn());
		 sql.setString(estimateDto.getESTIMATE_E_FILENM());
		 sql.setString(estimateDto.getESTIMATE_P_FILENM());
		 sql.setString(estimateDto.getCheckyn()); //수동입력 체크여부 추가.2013_05_07(화)shbyeon. (COMP_FLAG == checkyn)
		 sql.setString(estimateDto.getIndirectSalesYN());
		 sql.setString(estimateDto.getPurchase());
		 sql.setString(estimateDto.getSales_profit());
		 sql.setString(estimateDto.getProfit_percent());
		 sql.setString(estimateDto.getSalesSort());
			
			try {

				retVal = broker.executeProcedureUpdate(sql);

			} catch (Exception e) {
				e.printStackTrace();
				log.error(e.getMessage());
				throw new DAOException(e.getMessage());
			} finally {
			}
			return retVal;
		
	}
	
	/*
	 * 2013_03_26(화)shbyeon.
	 * 업체명 중복체크(견적서발행)
	 */
	public String compNameCheckEs(EstimateDTO esDto) throws DAOException{

		String procedure = " { CALL hp_CompanyNmDuplicateEs ( ? , ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setString("DUPLICATE");			//SP구분
		sql.setString(esDto.getE_comp_nm());		//업체명 아이디

		sql.setSql(procedure);

		try{

			ds=broker.executeProcedure(sql);
			
			if(ds.next()) {
				result=ds.getString("Result");
			}
		
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}finally{
			try{
		        if (ds != null) { ds.close(); ds = null; }
		    }catch (Exception ignore){
		    	log.error(ignore.getMessage());
		    }
		}		
		return result;			
	}
	
	/**
	 * 견적서 수정하기. 
	 * @param estimateDto 견적서 정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public int editEstimate(EstimateDTO estimateDto) throws DAOException{
		 int retVal = 0;
		
		 //StringBuffer sb = new StringBuffer();
		 //Connection conn = null;
		 //ResultDTO rsDto = null;
		 
		 String procedure = " { CALL hp_EstimateModify_bsh (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";
		
		 	QueryStatement sql = new QueryStatement();
		 	 sql.setSql(procedure);
		 	 sql.setString(estimateDto.getPROJECT_PK_CODE());
		 	 sql.setString(estimateDto.getPublic_no());
			 sql.setString(estimateDto.getP_public_no());
			 sql.setString(estimateDto.getEstimate_dt());
			 sql.setString(estimateDto.getComp_code());
			 sql.setString(estimateDto.getReceiver());
			 sql.setString(estimateDto.getTitle());
			 sql.setString(estimateDto.getSupply_price());
			 sql.setString(estimateDto.getVat());
			 sql.setString(estimateDto.getSales_charge());
			 sql.setString(estimateDto.getEtc());
			 sql.setString(estimateDto.getMod_id());
			 sql.setString(estimateDto.getE_comp_nm());
			 sql.setString(estimateDto.getProductno());
			 sql.setString(estimateDto.getD_public_yn());
			 sql.setString(estimateDto.getOrderble());
			 sql.setString(estimateDto.getEstimate_e_file());
			 sql.setString(estimateDto.getEstimate_p_file());
			 sql.setString(estimateDto.getContract_yn());
			 sql.setString(estimateDto.getSalescurrent_yn());
			 sql.setString(estimateDto.getESTIMATE_E_FILENM());
			 sql.setString(estimateDto.getESTIMATE_P_FILENM());
			 sql.setString(estimateDto.getCheckyn());
			 sql.setString(estimateDto.getIndirectSalesYN());
			 sql.setString(estimateDto.getPurchase());
			 sql.setString(estimateDto.getSales_profit());
			 sql.setString(estimateDto.getProfit_percent());
			 sql.setString(estimateDto.getSalesSort());

			 log.debug("[editEstimate]" + sql.toString());
			 try {

					retVal = broker.executeProcedureUpdate(sql);
					log.debug("retval:" + retVal);
				} catch (Exception e) {
					e.printStackTrace();
					log.error(e.getMessage());
					throw new DAOException(e.getMessage());
				} finally {
				}
				return retVal;

			}

	/**
	 * 견적서를 삭제한다.
	 * @param estimateDto 견적서 키
	 * @return ActionForward
	 * @throws DAOException
	 */	
	public int deleteEstimateOne(EstimateDTO estimateDto) throws DAOException{
		
		int retVal = 0;
		QueryStatement sql = new QueryStatement();
		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		
		sb.append(" UPDATE T_ESTIMATE  SET 	\n");
		sb.append(" USE_YN = 'N' ,MOD_ID=? ,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')	\n");
		sb.append("	WHERE PUBLIC_NO = ? \n");
		
		sql.setString(estimateDto.getMod_id());
		sql.setString(estimateDto.getPublic_no());
		sql.setSql(sb.toString());
		
		log.debug("[deleteEstimateOne]" + sql.toString());

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
	 * 견적서 리스트.   
	 * @param curpage  현재페이지
	 * @param searchGb  검색구분	
	 * @param searchtxt   검색키
	 * @param listScale  리스트 갯수
	 * @param pageScale  페이징 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO estimatePageList(int curpage,  String searchGb,  String contractGb, String searchtxt, String EsStartDate, String EsEndDate, int listScale, int pageScale , String type , String USERID) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;
		System.out.println("===========================================================================================================");
		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			
			sql.setAlias(" PUBLIC_NO,P_PUBLIC_NO,ESTIMATE_DT,COMP_CODE,COMP_NM,OWNER_NM,BUSINESS,B_ITEM,POST,ADDRESS,ADDR_DETAIL," +
					"RECEIVER,TITLE,SUPPLY_PRICE,VAT,REG_ID,REG_DT,SALES_CHARGE,E_COMP_NM,PRODUCTNO,D_PUBLIC_YN,ESTIMATE_E_FILE,ESTIMATE_P_FILE,CONTRACT_YN,ESTIMATE_E_FILENM,ESTIMATE_P_FILENM,PROJECT_PK_CODE");
//			sql.setSelect(" T2.PUBLIC_NO,T2.P_PUBLIC_NO,T2.ESTIMATE_DT,T2.COMP_CODE," +
//					"(SELECT MAX(T1.COMP_NM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as COMP_NM," +
//					"(SELECT MAX(T1.OWNER_NM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE )as OWNER_NM," +
//					"(SELECT MAX(T1.BUSINESS) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as BUSINESS," +
//					"(SELECT MAX(T1.B_ITEM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as B_ITEM," +
//					"(SELECT MAX(T1.POST) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as POST," +
//					"(SELECT MAX(T1.ADDRESS) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as ADDRESS," +
//					"(SELECT MAX(T1.ADDR_DETAIL) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE  ) as ADDR_DETAIL," +
//					"T2.RECEIVER,T2.TITLE,T2.SUPPLY_PRICE,T2.VAT,T2.REG_ID,T2.REG_DT,T2.SALES_CHARGE,T2.E_COMP_NM ,T2.PRODUCTNO,T2.D_PUBLIC_YN,T2.ESTIMATE_E_FILE,T2.ESTIMATE_P_FILE,T2.CONTRACT_YN,T2.ESTIMATE_E_FILENM,T2.ESTIMATE_P_FILENM,T2.PROJECT_PK_CODE ") ;
//			sql.setFrom	(" T_ESTIMATE T2 LEFT OUTER JOIN T_COMPANY T1 ON T2.COMP_CODE = T1.COMP_CODE \n");
			
			sql.setSelect(" T2.PUBLIC_NO,T2.P_PUBLIC_NO,T2.ESTIMATE_DT,T2.COMP_CODE," +
					"T1.COMP_NM," +
					"T1.OWNER_NM," +
					"T1.BUSINESS," +
					"T1.B_ITEM," +
					"T1.POST," +
					"T1.ADDRESS," +
					"T1.ADDR_DETAIL," +
					"T2.RECEIVER,T2.TITLE,T2.SUPPLY_PRICE,T2.VAT,T2.REG_ID,T2.REG_DT,T2.SALES_CHARGE,T2.E_COMP_NM ,T2.PRODUCTNO,T2.D_PUBLIC_YN,T2.ESTIMATE_E_FILE,T2.ESTIMATE_P_FILE,T2.CONTRACT_YN,T2.ESTIMATE_E_FILENM,T2.ESTIMATE_P_FILENM,T2.PROJECT_PK_CODE ") ;
			sql.setFrom	(" T_ESTIMATE T2 LEFT OUTER JOIN T_COMPANY T1 ON T2.COMP_CODE = T1.COMP_CODE \n");
			where += " T2.USE_YN='Y' \n ";
			
			if(type.equals("reg")){
				where += " AND (T2.REG_ID = ? OR T2.SALES_CHARGE = ?) ";
				sql.setString(USERID);
				sql.setString(USERID);
			}
			
			if(searchGb != null && !searchGb.equals(""))
			{
				if(searchGb.equals("A"))
				{
					where += " AND T2.RECEIVER LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("B"))
				{
					where += " AND T2.TITLE LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("C"))
				{
					where += " AND T2.P_PUBLIC_NO LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("D"))
				{
					where += " AND T2.PUBLIC_NO LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("E"))
				{
					where += " AND T1.COMP_NM LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
			}	
		
			if(contractGb != null && !contractGb.equals("ALL"))
			{
				
				if(contractGb.equals("Y"))
				{
					where += " AND CONTRACT_YN = ? ";
					sql.setString(contractGb);
				}
				if(contractGb.equals("N"))
				{
					where += " AND CONTRACT_YN = ? ";
					sql.setString(contractGb);
				}
				
			}
			//2013_05_28(화)shbyeon. 달력 검색 기능 추가.
			if(EsStartDate != null && !EsStartDate.equals("") && EsEndDate != null && !EsEndDate.equals(""))
			{
					where += " AND ESTIMATE_DT between ? and ? ";
					sql.setString(EsStartDate);
					sql.setString(EsEndDate);
			}

			sql.setWhere(where);
			sql.setOrderby(" ESTIMATE_DT DESC "); 
		
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
	 * 견적서 리스트(팝업창 발행번호리스트).   
	 * @param curpage  현재페이지
	 * @param searchGb  검색구분	
	 * @param searchtxt   검색키
	 * @param listScale  리스트 갯수
	 * @param pageScale  페이징 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO estimatePageListPop(int curpage,  String searchGb,  String contractGb, String searchtxt,  int listScale, int pageScale ,String type, String USERID) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;

		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			
			sql.setAlias(" PUBLIC_NO,P_PUBLIC_NO,ESTIMATE_DT,COMP_CODE,COMP_NM,OWNER_NM,BUSINESS,B_ITEM,POST,ADDRESS,ADDR_DETAIL," +
					"RECEIVER,TITLE,SUPPLY_PRICE,VAT,REG_ID,REG_DT,SALES_CHARGE,E_COMP_NM,PRODUCTNO,D_PUBLIC_YN,ESTIMATE_E_FILE,ESTIMATE_P_FILE,CONTRACT_YN,ESTIMATE_E_FILENM,ESTIMATE_P_FILENM,PERMIT_NO,PROJECT_PK_CODE,IndirectSalesYN,Purchase,Sales_profit,Profit_percent,SalesSort,Orderble");
			sql.setSelect(" T2.PUBLIC_NO,T2.P_PUBLIC_NO,T2.ESTIMATE_DT,T2.COMP_CODE," +
					"(SELECT MAX(T1.COMP_NM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as COMP_NM," +
					"(SELECT MAX(T1.OWNER_NM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE )as OWNER_NM," +
					"(SELECT MAX(T1.BUSINESS) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as BUSINESS," +
					"(SELECT MAX(T1.B_ITEM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as B_ITEM," +
					"(SELECT MAX(T1.POST) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as POST," +
					"(SELECT MAX(T1.ADDRESS) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as ADDRESS," +
					"(SELECT MAX(T1.ADDR_DETAIL) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE  ) as ADDR_DETAIL," +
					"(SELECT (T1.PERMIT_NO) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE and DELETED_YN = 'N') as PERMIT_NO," +
					"T2.RECEIVER,T2.TITLE,T2.SUPPLY_PRICE,T2.VAT,T2.REG_ID,T2.REG_DT,T2.SALES_CHARGE,T2.E_COMP_NM ,T2.PRODUCTNO,T2.D_PUBLIC_YN,T2.ESTIMATE_E_FILE,T2.ESTIMATE_P_FILE,T2.CONTRACT_YN,T2.ESTIMATE_E_FILENM,T2.ESTIMATE_P_FILENM,T2.PROJECT_PK_CODE,T2.IndirectSalesYN,T2.Purchase,T2.Sales_profit,T2.Profit_percent,T2.SalesSort,T2.Orderble ") ;
			sql.setFrom	(" T_ESTIMATE T2 \n");

			where += " USE_YN='Y'   \n ";
			
			if(type.equals("reg")){
				where += " AND (REG_ID = ? OR SALES_CHARGE = ?) ";
				sql.setString(USERID);
				sql.setString(USERID);
			}
			
			if(searchGb != null && !searchGb.equals(""))
			{
				if(searchGb.equals("A"))
				{
					where += " AND RECEIVER LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("B"))
				{
					where += " AND TITLE LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("C"))
				{
					where += " AND P_PUBLIC_NO LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("D"))
				{
					where += " AND PUBLIC_NO LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				
			}	
	
			if(contractGb != null && !contractGb.equals("ALL"))
			{
				
				if(contractGb.equals("Y"))
				{
					where += " AND CONTRACT_YN = ? ";
					sql.setString(contractGb);
				}
				if(contractGb.equals("N"))
				{
					where += " AND CONTRACT_YN = ? ";
					sql.setString(contractGb);
				}
				
			}	
	
			

			sql.setWhere(where);
			sql.setOrderby(" ESTIMATE_DT DESC ");  
		
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
	 * 견적서 리스트(팝업창 발행번호리스트  계약된 건수 만(세금계산서발행).   
	 * @param curpage  현재페이지
	 * @param searchGb  검색구분	
	 * @param searchtxt   검색키
	 * @param listScale  리스트 갯수
	 * @param pageScale  페이징 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO estimatePageListPopConY(int curpage,  String searchGb,  String contractGb, String searchtxt,  int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;

		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			
			sql.setAlias(" PUBLIC_NO,P_PUBLIC_NO,ESTIMATE_DT,COMP_CODE,COMP_NM,OWNER_NM,BUSINESS,B_ITEM,POST,ADDRESS,ADDR_DETAIL," +
					"RECEIVER,TITLE,SUPPLY_PRICE,VAT,REG_ID,REG_DT,SALES_CHARGE,E_COMP_NM,PRODUCTNO,D_PUBLIC_YN,ESTIMATE_E_FILE,ESTIMATE_P_FILE,CONTRACT_YN,ESTIMATE_E_FILENM,ESTIMATE_P_FILENM,PERMIT_NO");
			sql.setSelect(" T2.PUBLIC_NO,T2.P_PUBLIC_NO,T2.ESTIMATE_DT,T2.COMP_CODE," +
					"(SELECT MAX(T1.COMP_NM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as COMP_NM," +
					"(SELECT MAX(T1.OWNER_NM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE )as OWNER_NM," +
					"(SELECT MAX(T1.BUSINESS) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as BUSINESS," +
					"(SELECT MAX(T1.B_ITEM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as B_ITEM," +
					"(SELECT MAX(T1.POST) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as POST," +
					"(SELECT MAX(T1.ADDRESS) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as ADDRESS," +
					"(SELECT MAX(T1.ADDR_DETAIL) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE  ) as ADDR_DETAIL," +
					"(SELECT (T1.PERMIT_NO) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE and DELETED_YN = 'N') as PERMIT_NO," +
					"T2.RECEIVER,T2.TITLE,T2.SUPPLY_PRICE,T2.VAT,T2.REG_ID,T2.REG_DT,T2.SALES_CHARGE,T2.E_COMP_NM ,T2.PRODUCTNO,T2.D_PUBLIC_YN,T2.ESTIMATE_E_FILE,T2.ESTIMATE_P_FILE,T2.CONTRACT_YN,T2.ESTIMATE_E_FILENM,T2.ESTIMATE_P_FILENM ") ;
			sql.setFrom	(" T_ESTIMATE T2 \n");

			where += " USE_YN='Y' and CONTRACT_YN='Y' \n ";

			if(searchGb != null && !searchGb.equals(""))
			{
				if(searchGb.equals("A"))
				{
					where += " AND RECEIVER LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("B"))
				{
					where += " AND TITLE LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("C"))
				{
					where += " AND P_PUBLIC_NO LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("D"))
				{
					where += " AND PUBLIC_NO LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				
			}	
		/*
		 * 
			if(contractGb != null && !contractGb.equals("ALL"))
			{
				
				if(contractGb.equals("Y"))
				{
					where += " AND CONTRACT_YN = ? ";
					sql.setString(contractGb);
				}
				if(contractGb.equals("Y"))
				{
					where += " AND CONTRACT_YN = ? ";
					sql.setString(contractGb);
				}
				
			}	
		 */
			

			sql.setWhere(where);
			sql.setOrderby(" ESTIMATE_DT DESC ");  
		
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
	 * 견적서 리스트(팝업창 발행번호리스트  계약된 건수 만,계약관리에 등록되 있는 견적서 제외.(계약관리 용도 별도 팝업).   
	 * @param curpage  현재페이지
	 * @param searchGb  검색구분	
	 * @param searchtxt   검색키
	 * @param listScale  리스트 갯수
	 * @param pageScale  페이징 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO estimatePageListPopConY_CM(int curpage,  String searchGb,  String contractGb, String searchtxt,  int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;

		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			
			sql.setAlias(" PUBLIC_NO,P_PUBLIC_NO,ESTIMATE_DT,COMP_CODE,COMP_NM,OWNER_NM,BUSINESS,B_ITEM,POST,ADDRESS,ADDR_DETAIL," +
					"RECEIVER,TITLE,SUPPLY_PRICE,VAT,REG_ID,REG_DT,SALES_CHARGE,E_COMP_NM,PRODUCTNO,D_PUBLIC_YN,ESTIMATE_E_FILE,ESTIMATE_P_FILE,CONTRACT_YN,ESTIMATE_E_FILENM,ESTIMATE_P_FILENM,PERMIT_NO");
			sql.setSelect(" T2.PUBLIC_NO,T2.P_PUBLIC_NO,T2.ESTIMATE_DT,T2.COMP_CODE," +
					"(SELECT MAX(T1.COMP_NM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as COMP_NM," +
					"(SELECT MAX(T1.OWNER_NM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE )as OWNER_NM," +
					"(SELECT MAX(T1.BUSINESS) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as BUSINESS," +
					"(SELECT MAX(T1.B_ITEM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as B_ITEM," +
					"(SELECT MAX(T1.POST) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as POST," +
					"(SELECT MAX(T1.ADDRESS) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as ADDRESS," +
					"(SELECT MAX(T1.ADDR_DETAIL) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE  ) as ADDR_DETAIL," +
					"(SELECT (T1.PERMIT_NO) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE and DELETED_YN = 'N') as PERMIT_NO," +
					"T2.RECEIVER,T2.TITLE,T2.SUPPLY_PRICE,T2.VAT,T2.REG_ID,T2.REG_DT,T2.SALES_CHARGE,T2.E_COMP_NM ,T2.PRODUCTNO,T2.D_PUBLIC_YN,T2.ESTIMATE_E_FILE,T2.ESTIMATE_P_FILE,T2.CONTRACT_YN,T2.ESTIMATE_E_FILENM,T2.ESTIMATE_P_FILENM ") ;
			sql.setFrom	(" T_ESTIMATE T2 \n");

			where += " USE_YN='Y' and CONTRACT_YN='Y' and Not EXISTS (SELECT * FROM htContractManagement B  where B.Public_No = T2.PUBLIC_NO)  \n ";

			if(searchGb != null && !searchGb.equals(""))
			{
				if(searchGb.equals("A"))
				{
					where += " AND RECEIVER LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("B"))
				{
					where += " AND TITLE LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("C"))
				{
					where += " AND P_PUBLIC_NO LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("D"))
				{
					where += " AND PUBLIC_NO LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				
			}	
		/*
		 * 
			if(contractGb != null && !contractGb.equals("ALL"))
			{
				
				if(contractGb.equals("Y"))
				{
					where += " AND CONTRACT_YN = ? ";
					sql.setString(contractGb);
				}
				if(contractGb.equals("Y"))
				{
					where += " AND CONTRACT_YN = ? ";
					sql.setString(contractGb);
				}
				
			}	
		 */
			

			sql.setWhere(where);
			sql.setOrderby(" ESTIMATE_DT DESC ");  
		
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
	 * 견적서 리스트(팝업창 발행번호리스트  계약된 건수,프로젝트코드 등록 되있는 견적서 제외.(프로젝트 코드 관리 별도 팝업).   
	 * @param curpage  현재페이지
	 * @param searchGb  검색구분	
	 * @param searchtxt   검색키
	 * @param listScale  리스트 갯수
	 * @param pageScale  페이징 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO estimatePageListPopConY_PJ(int curpage,  String searchGb,  String contractGb, String searchtxt,  int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;

		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			
			sql.setAlias(" PUBLIC_NO,P_PUBLIC_NO,ESTIMATE_DT,COMP_CODE,COMP_NM,OWNER_NM,BUSINESS,B_ITEM,POST,ADDRESS,ADDR_DETAIL," +
					"RECEIVER,TITLE,SUPPLY_PRICE,VAT,REG_ID,REG_DT,SALES_CHARGE,E_COMP_NM,PRODUCTNO,D_PUBLIC_YN,ESTIMATE_E_FILE,ESTIMATE_P_FILE,CONTRACT_YN,ESTIMATE_E_FILENM,ESTIMATE_P_FILENM,PERMIT_NO");
			sql.setSelect(" T2.PUBLIC_NO,T2.P_PUBLIC_NO,T2.ESTIMATE_DT,T2.COMP_CODE," +
					"(SELECT MAX(T1.COMP_NM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as COMP_NM," +
					"(SELECT MAX(T1.OWNER_NM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE )as OWNER_NM," +
					"(SELECT MAX(T1.BUSINESS) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as BUSINESS," +
					"(SELECT MAX(T1.B_ITEM) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as B_ITEM," +
					"(SELECT MAX(T1.POST) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as POST," +
					"(SELECT MAX(T1.ADDRESS) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE ) as ADDRESS," +
					"(SELECT MAX(T1.ADDR_DETAIL) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE  ) as ADDR_DETAIL," +
					"(SELECT (T1.PERMIT_NO) FROM T_COMPANY T1 WHERE T1.COMP_CODE=T2.COMP_CODE and DELETED_YN = 'N') as PERMIT_NO," +
					"T2.RECEIVER,T2.TITLE,T2.SUPPLY_PRICE,T2.VAT,T2.REG_ID,T2.REG_DT,T2.SALES_CHARGE,T2.E_COMP_NM ,T2.PRODUCTNO,T2.D_PUBLIC_YN,T2.ESTIMATE_E_FILE,T2.ESTIMATE_P_FILE,T2.CONTRACT_YN,T2.ESTIMATE_E_FILENM,T2.ESTIMATE_P_FILENM ") ;
			sql.setFrom	(" T_ESTIMATE T2 \n");

			where += " USE_YN='Y' and CONTRACT_YN='Y' and Not EXISTS (SELECT * FROM htProjectCodeManagement B  where B.Public_No = T2.PUBLIC_NO)  \n ";

			if(searchGb != null && !searchGb.equals(""))
			{
				if(searchGb.equals("A"))
				{
					where += " AND RECEIVER LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("B"))
				{
					where += " AND TITLE LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("C"))
				{
					where += " AND P_PUBLIC_NO LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("D"))
				{
					where += " AND PUBLIC_NO LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				
			}	
		/*
		 * 
			if(contractGb != null && !contractGb.equals("ALL"))
			{
				
				if(contractGb.equals("Y"))
				{
					where += " AND CONTRACT_YN = ? ";
					sql.setString(contractGb);
				}
				if(contractGb.equals("Y"))
				{
					where += " AND CONTRACT_YN = ? ";
					sql.setString(contractGb);
				}
				
			}	
		 */
			

			sql.setWhere(where);
			sql.setOrderby(" ESTIMATE_DT DESC ");  
		
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
	 * 견적서 View 정보.
	 * @param pubNo  견적서 키
	 * @return ActionForward
	 * @throws DAOException
	 */
	public EstimateDTO getEstimateView( String pubNo) throws DAOException{
		
		EstimateDTO estimateDto = null;
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		
		sb.append("				SELECT T1.*,(SELECT COMP_NM FROM T_COMPANY WHERE COMP_CODE=T1.COMP_CODE) AS COMP_NM, \n");
		sb.append("				(SELECT UserName FROM ht10User WHERE UserID=T1.REG_ID) AS REG_NM,	\n");
		sb.append("				(SELECT UserName FROM ht10User WHERE UserID=T1.SALES_CHARGE) AS SALES_CHARGE_NM,(SELECT UserName FROM ht10User WHERE UserID=T1.SALES_CHARGE) AS SALES_CHARGE_NM,T1.CONTRACT_YN,T1.SALESCURRENT_YN FROM T_ESTIMATE T1	\n");
		sb.append("				WHERE T1.PUBLIC_NO=?	\n");
		
		
		log.debug(sb.toString());
		//param
		sql.setSql(sb.toString());
		sql.setString(pubNo);
	
		DataSet ds = null;
		try{
			ds = broker.executeQuery(sql);
			if(ds.next()){ 
			
			 estimateDto = new EstimateDTO();

			 estimateDto.setPublic_no(StringUtil.nvl(ds.getString("PUBLIC_NO"),""));
			 estimateDto.setP_public_no(StringUtil.nvl(ds.getString("P_PUBLIC_NO"),""));
			 estimateDto.setEstimate_dt(StringUtil.nvl(ds.getString("ESTIMATE_DT"),""));
			 estimateDto.setComp_code(StringUtil.nvl(ds.getString("COMP_CODE"),""));
			 estimateDto.setComp_nm(StringUtil.nvl(ds.getString("COMP_NM"),""));
			 estimateDto.setReceiver(StringUtil.nvl(ds.getString("RECEIVER"),""));
			 estimateDto.setTitle(StringUtil.nvl(ds.getString("TITLE"),""));
			 estimateDto.setSupply_price(StringUtil.nvl(ds.getString("SUPPLY_PRICE"),"0"));
			 estimateDto.setVat(StringUtil.nvl(ds.getString("VAT"),"0"));
			 estimateDto.setReg_id(StringUtil.nvl(ds.getString("REG_ID"),""));
			 estimateDto.setReg_nm(StringUtil.nvl(ds.getString("REG_NM"),""));
			 estimateDto.setReg_dt(StringUtil.nvl(ds.getString("REG_DT"),""));
			 estimateDto.setSales_charge(StringUtil.nvl(ds.getString("SALES_CHARGE"),""));
			 estimateDto.setSales_charge_nm(StringUtil.nvl(ds.getString("SALES_CHARGE_NM"),""));
			 estimateDto.setEtc(StringUtil.nvl(ds.getString("ETC"),""));
			 estimateDto.setE_comp_nm(StringUtil.nvl(ds.getString("E_COMP_NM"),""));
			 estimateDto.setD_public_yn(StringUtil.nvl(ds.getString("D_PUBLIC_YN"),""));
			 estimateDto.setProductno(StringUtil.nvl(ds.getString("PRODUCTNO"),""));
			 estimateDto.setOrderble(StringUtil.nvl(ds.getString("ORDERBLE"),""));
			 estimateDto.setEstimate_e_file(StringUtil.nvl(ds.getString("ESTIMATE_E_FILE"),""));
			 estimateDto.setEstimate_p_file(StringUtil.nvl(ds.getString("ESTIMATE_P_FILE"),""));
			 estimateDto.setContract_yn(StringUtil.nvl(ds.getString("CONTRACT_YN"),""));
			 estimateDto.setSalescurrent_yn(StringUtil.nvl(ds.getString("SALESCURRENT_YN"),""));
			 estimateDto.setESTIMATE_E_FILENM(StringUtil.nvl(ds.getString("ESTIMATE_E_FILENM"),""));
			 estimateDto.setESTIMATE_P_FILENM(StringUtil.nvl(ds.getString("ESTIMATE_P_FILENM"),""));
			 //2013_04_29(월) shbyeon.추가
			 estimateDto.setPROJECT_PK_CODE(StringUtil.nvl(ds.getString("PROJECT_PK_CODE"),""));
			 //2013_05_07(화) shbyeon.추가
			 estimateDto.setCheckyn(StringUtil.nvl(ds.getString("COMP_FLAG"),""));
			 //2013_11-19(화) shbyeon.추가
			 estimateDto.setIndirectSalesYN(StringUtil.nvl(ds.getString("IndirectSalesYN"),""));
			 estimateDto.setPurchase(StringUtil.nvl(ds.getString("Purchase"),""));
			 estimateDto.setSales_profit(StringUtil.nvl(ds.getString("Sales_profit"),""));
			 estimateDto.setProfit_percent(StringUtil.nvl(ds.getString("Profit_percent"),""));
			 estimateDto.setSalesSort(StringUtil.nvl(ds.getString("SalesSort"),""));
			 //2013 11-26(화) shbyeon.추가
			 estimateDto.setContractCode(StringUtil.nvl(ds.getString("ContractCode"),""));

			 
			}
		}catch(Exception e){
		    e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}
		
		return estimateDto;
	}
	
	/**
	 * 견적서 EXCEL 리스트.
	 * @param dto  견적서 키
	 * @return jsp
	 * @throws DAOException
	 */
	public ArrayList getEstimateListExcel(EstimateDTO dto) throws DAOException {
		QueryStatement sql = new QueryStatement();
		StringBuffer sbSql = new StringBuffer();
		EstimateDTO estimateDTO  =null;
		ArrayList<EstimateDTO> arrlist = new ArrayList<EstimateDTO>();
		try{			
			String searchGb=dto.getSearchGb();
			String contractGb=dto.getContract_yn();
			String EsStartDate=dto.getEsStartDate(); //액션에서 받은 달력 조회 값 꺼내와서 셀렉트 쿼리 조건을 위해 변수에 셋팅. 2013_05_29(수)shbyeon.
			String EsEndDate=dto.getEsEndDate(); //액션에서 받은 달력 조회 값 꺼내와서 셀렉트 쿼리 조건을 위해 변수에 셋팅. 2013_05_29(수)shbyeon.
			sbSql.append(" SELECT PUBLIC_NO,P_PUBLIC_NO,ESTIMATE_DT,COMP_CODE,RECEIVER,TITLE,SUPPLY_PRICE,VAT,REG_ID,REG_DT,SALES_CHARGE,E_COMP_NM,CONTRACT_YN ");
			sbSql.append(" FROM T_ESTIMATE ");
			sbSql.append(" WHERE USE_YN = 'Y' ");
			
			
			
			if(!("").equals(searchGb)){
				if( "A".equals(searchGb) && !("").equals(dto.getSearchTxt()) ){
					sbSql.append(" and RECEIVER like '%"+dto.getSearchTxt()+"%' ");
				} else if ("B".equals(searchGb)  && !("").equals(dto.getSearchTxt()) ){
					sbSql.append(" and TITLE like '%"+dto.getSearchTxt()+"%' ");
				} else if ("C".equals(searchGb)  && !("").equals(dto.getSearchTxt()) ){
					sbSql.append(" and P_PUBLIC_NO like '%"+dto.getSearchTxt()+"%' ");
				}else if ("D".equals(searchGb)  && !("").equals(dto.getSearchTxt()) ){
					sbSql.append(" and PUBLIC_NO like '%"+dto.getSearchTxt()+"%' ");
				}
				
			}
			if(contractGb != null && !contractGb.equals("ALL"))
			{
				
				if(contractGb.equals("Y"))
				{
					sbSql.append(" AND CONTRACT_YN = '"+dto.getContract_yn()+"' ");
				}
				if(contractGb.equals("N"))
				{
					sbSql.append(" AND CONTRACT_YN = '"+dto.getContract_yn()+"' ");
				}
				
			}
			
			//2013_05_29(수)shbyeon. 달력 검색 기능 추가.
			if(EsStartDate != null && !EsStartDate.equals("") && EsEndDate != null && !EsEndDate.equals(""))
			{
					sbSql.append(" AND ESTIMATE_DT between '"+EsStartDate+"'and'"+EsEndDate+"' ");
					//sql.setString(EsStartDate);
					//sql.setString(EsEndDate);
			}
			
			sbSql.append(" ORDER BY ESTIMATE_DT DESC ");
			
			sql.setSql(sbSql.toString());
			log.debug("getEstimateListExcel["+sbSql.toString()+"]");	
			
			 DataSet ds = null;
			 try{
				 ds = broker.executeQuery(sql);
			
				 while(ds.next()){ 
					 estimateDTO = new EstimateDTO();
					 estimateDTO.setPublic_no(ds.getString("PUBLIC_NO"));
					 estimateDTO.setP_public_no(ds.getString("P_PUBLIC_NO"));
					 estimateDTO.setEstimate_dt(ds.getString("ESTIMATE_DT"));
					 estimateDTO.setComp_code(ds.getString("COMP_CODE"));
					 estimateDTO.setReceiver(ds.getString("RECEIVER"));
					 estimateDTO.setTitle(ds.getString("TITLE"));
					 estimateDTO.setSupply_price(ds.getString("SUPPLY_PRICE"));
					 estimateDTO.setVat(ds.getString("VAT"));
					 estimateDTO.setReg_id(ds.getString("REG_ID"));
					 estimateDTO.setReg_dt(ds.getString("REG_DT"));
					 estimateDTO.setSales_charge(ds.getString("SALES_CHARGE"));
					 estimateDTO.setE_comp_nm(ds.getString("E_COMP_NM"));
					 estimateDTO.setContract_yn(ds.getString("CONTRACT_YN"));
					 
					 arrlist.add(estimateDTO);
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
	
	/*
	 * 2013_11_01(화) shbyeon.
	 * 영업지원 - > 영업진행현황 SalesCode 가져오기.
	 * Description:견적서 즉시발행시 영업진행현황에 등록 및 견적서 테이블에 등록 시켜 주기 위함.
	 */  
	public String addcurrentRegistCode(String SalesCode) throws DAOException{

		String procedure = " { CALL hp_CurrentStatusRegistCode () } ";
		String SC_Code="";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure);

		try{

			ds=broker.executeProcedure(sql);
			
			if(ds.next()) {
				SC_Code=ds.getString("PreSalesCode");
				log.debug("영업진행현황 SC_Code 새로 생성:"+SC_Code);
			}
		
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}finally{
			try{
		        if (ds != null) { ds.close(); ds = null; }
		    }catch (Exception ignore){
		    	log.error(ignore.getMessage());
		    }
		}		
		return SC_Code;			
	}
	
	/**
	 * CreateDate:2013-11-26(화) Writer:shbyeon.
	 * 계약관리 코드번호 생성하기(MAX 값으로 Select 해온다.) 
	 * @param cmDto
	 * @return retVal
	 * @throws DAOException
	
	public String addcontractRegistCode(String createCode_CQ) throws DAOException{

		String procedure = " { CALL hp_ContractMgCodeRegist () } ";
		String createCode_return="";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure);

		try{

			ds=broker.executeProcedure(sql);
			
			if(ds.next()) {
				createCode_return=ds.getString("ContractCode");
				log.debug("[견적서 계약발행 계약관리 CQ_Code(년/월/일MAX로 SELECT) => 새로 생성:"+createCode_return+" DAO..견적서 계약발행]");
			}
		
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}finally{
			try{
		        if (ds != null) { ds.close(); ds = null; }
		    }catch (Exception ignore){
		    	log.error(ignore.getMessage());
		    }
		}		
		return createCode_return;			
	}
	 */
	
	/**
	 * CreateDate:2013-11-26(화) Writer:shbyeon.
	 * 계약관리 코드번호 해당 견적서에 Update.
	 * @param cmDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int contractInsertCode(EstimateDTO esDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ContractMgModifyCode_EST (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(esDto.getPublic_no());
		sql.setString(esDto.getContractCode());

		try {

			retVal = broker.executeProcedureUpdate(sql);
			log.debug("retval:" + retVal);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		}
		return retVal;

	}
	
	/**
	 * CreateDate:2013-11-26(화) Writer:shbyeon.
	 * 계약관리 등록(하나의 견적서 계약으로 등록 성공 시 계약관리 테이블에 계약코드번호를 생성하면서 매핑 견적서 데이터를 등록한다.)  
	 * @param cmDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int contractInsertData(ContractManageDTO cmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ContractMgRegist_EST (?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(cmDto.getContractCode());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 계약코드번호:"+cmDto.getContractCode()+" DAO..]");
		sql.setString(cmDto.getPublic_No());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 견적번호:"+cmDto.getPublic_No()+" DAO..]");
		sql.setString(cmDto.getContractFile());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 계약서경로:"+cmDto.getContractFile()+" DAO..]");
		sql.setString(cmDto.getContractFileNm());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 계약서파일명:"+cmDto.getContractFileNm()+" DAO..]");
		sql.setString(cmDto.getPurchaseOrderFile());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 발주서 파일 경로:"+cmDto.getPurchaseOrderFile()+" DAO..]");
		sql.setString(cmDto.getPurchaseOrderFileNm());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 발주서 파일명:"+cmDto.getPurchaseOrderFileNm()+" DAO..]");
		sql.setString(cmDto.getEstimate_E_File());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 견적엑셀파일경로:"+cmDto.getEstimate_E_File()+" DAO..]");
		sql.setString(cmDto.getEstimate_E_FileNm());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 견적엑셀파일명:"+cmDto.getEstimate_E_FileNm()+" DAO..]");
		sql.setString(cmDto.getEstimate_P_File());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 견적엑셀pdf파일경로:"+cmDto.getEstimate_P_File()+" DAO..]");
		sql.setString(cmDto.getEstimate_P_FileNm());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 견적엑셀pdf파일명:"+cmDto.getEstimate_P_FileNm()+" DAO..]");
		sql.setString(cmDto.getOrdering_Organization());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 발주처:"+cmDto.getOrdering_Organization()+" DAO..]");
		sql.setString(cmDto.getContractName());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 계약명:"+cmDto.getContractName()+" DAO..]");
		sql.setString(cmDto.getContractStatus());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 계약종결 여부:"+cmDto.getContractStatus()+" DAO..]");
		sql.setString(cmDto.getContractCreateUser());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Insert 되는 데이터 최초등록자:"+cmDto.getContractCreateUser()+" DAO..]");
		
		try {

			retVal = broker.executeProcedureUpdate(sql);
			log.debug("retval:" + retVal);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		}
		return retVal;

	}
	
	/**
	 * CreateDate:2013-11-26(화) Writer:shbyeon.
	 * 계약관리 코드번호 해당 견적서에 Update.
	 * @param cmDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int contractDeleteCode(ContractManageDTO cmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ContractMgDeleteCode_EST (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(cmDto.getContractCode());
		sql.setString(cmDto.getPublic_No());
		try {

			retVal = broker.executeProcedureUpdate(sql);
			log.debug("retval:" + retVal);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		}
		return retVal;

	}
	
	/**
	 * CreateDate:2013-11-27(수) Writer:shbyeon.
	 * 계약관리 수정(계약관리에 견적서와 연동되어 등록 되 있는 계약관리 매핑 데이터를 최근 데이터로 수정한다.)  
	 * @param cmDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int contractUpdateData(ContractManageDTO cmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ContractMgModify_EST (?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(cmDto.getContractCode());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Update 되는 데이터 PK 계약코드번호:"+cmDto.getContractCode()+" DAO..]");
		sql.setString(cmDto.getPublic_No());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Update 되는 데이터 PK 견적번호:"+cmDto.getPublic_No()+" DAO..]");
		sql.setString(cmDto.getEstimate_E_File());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Update 되는 데이터 견적엑셀파일경로:"+cmDto.getEstimate_E_File()+" DAO..]");
		sql.setString(cmDto.getEstimate_E_FileNm());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Update 되는 데이터 견적엑셀파일명:"+cmDto.getEstimate_E_FileNm()+" DAO..]");
		sql.setString(cmDto.getEstimate_P_File());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Update 되는 데이터 견적엑셀pdf파일경로:"+cmDto.getEstimate_P_File()+" DAO..]");
		sql.setString(cmDto.getEstimate_P_FileNm());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Update 되는 데이터 견적엑셀pdf파일명:"+cmDto.getEstimate_P_FileNm()+" DAO..]");
		sql.setString(cmDto.getOrdering_Organization());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Update 되는 데이터 발주처:"+cmDto.getOrdering_Organization()+" DAO..]");
		sql.setString(cmDto.getContractName());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Update 되는 데이터 계약명:"+cmDto.getContractName()+" DAO..]");
		sql.setString(cmDto.getContractUpdateUser());
		log.debug("[견적서 계약발행으로 인한 계약관리 테이블에 Update 되는 데이터 최초등록자:"+cmDto.getContractUpdateUser()+" DAO..]");
		
		try {

			retVal = broker.executeProcedureUpdate(sql);
			log.debug("retval:" + retVal);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		}
		return retVal;

	}
	
	
	/**
	 * 계약번호 미발행 현황 리스트.   
	 * @param curpage  현재페이지
	 * @param searchGb  검색구분	
	 * @param searchtxt   검색키
	 * @param listScale  리스트 갯수
	 * @param pageScale  페이징 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO contractCodeUnissued(EstimateDTO estimateDto) throws DAOException {
		ListDTO retVal = null;
		Connection conn = null;

		String procedure = " { CALL hp_contractCodeUnissued (?,?,?,?,?) } ";	
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setString(estimateDto.getSearchGb());
		sql.setString(estimateDto.getSearchTxt());
		//sql.setString(EsStartDate);
		//sql.setString(EsEndDate);
		sql.setInteger(estimateDto.getnRow());
		sql.setInteger(estimateDto.getCurPage());
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
	 * 계약번호 미발행 현황 Excel 리스트.   
	 * @param curpage  현재페이지
	 * @param searchGb  검색구분	
	 * @param searchtxt   검색키
	 * @param listScale  리스트 갯수
	 * @param pageScale  페이징 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO contractCodeUnissuedExcelList(EstimateDTO estimateDto) throws DAOException {
		ListDTO retVal = null;

		String procedure = " { CALL hp_contractCodeUnissued (?,?,?,?,?) } ";	
		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setString(estimateDto.getSearchGb());
		sql.setString(estimateDto.getSearchTxt());
		//sql.setString(EsStartDate);
		//sql.setString(EsEndDate);
		sql.setInteger(estimateDto.getnRow());
		sql.setInteger(estimateDto.getCurPage());
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
