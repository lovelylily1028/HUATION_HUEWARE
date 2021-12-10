package com.huation.common.company;  

import java.sql.*;
import java.util.*;

import com.huation.common.*;
import com.huation.common.user.*;
import com.huation.framework.data.*;
import com.huation.framework.persist.*;
import com.huation.framework.util.*;


/**
 * @author 
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CompanyDAO extends AbstractDAO {
	
	/**
	 * 업체 MAX카운트 구하기.
	 * @param 
	 * @return ActionForward
	 * @throws DAOException 
	 */
	
	public String getCompCntNext() throws DAOException{
		
		String compCnt = null;
		QueryStatement sql = new QueryStatement();
		sql.setSql("SELECT (ISNULL(MAX(COMP_CODE),0)+1) COMP_CNT FROM T_COMPANY ");
		 
		log.debug("[getCompCodeNext]" + sql.toString());

		DataSet ds = null;
		try{
			 ds = broker.executeQuery(sql);
			 if(ds.next()) {
			 	compCnt = ds.getString("COMP_CNT");
			 }
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			 throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}			
		
		return compCnt;
	}

	/**
	 * 업체코드 구하기.
	 * @param compCnt 업테 MAX 카운트
	 * @return ActionForward
	 * @throws DAOException
	 */
	public String getCompCode(String compCnt) throws DAOException{
		
		String compCode = null;
		int comp_code =0;
		
        comp_code = NumberUtil.parseInt(compCnt,0);

        compCode = String.valueOf(comp_code);
        if(compCode.length()==1){
        	compCode = "000000"+ compCode;	
        }else if(compCode.length()==2){
        	compCode = "00000"+ compCode;
        }else if(compCode.length()==3){
        	compCode = "0000"+ compCode;
        }else if(compCode.length()==4){
        	compCode = "000"+ compCode;
        }else if(compCode.length()==5){
        	compCode = "00"+ compCode;
        }else if(compCode.length()==6){
        	compCode = "0"+ compCode;
        }
 
		return compCode;
	}	
	
	/**
	 * 업체 등록하기. 
	 * @param compDto 업체정보
	 * @return ActionForward
	 * @throws DAOException
	 * 2013_03_18(월) shbyeon. SP변경
	 */
	public int addCompany(CompanyDTO compDto) throws Exception{
		
		int retVal = 0;
		//HashMap rtnMap = new HashMap(); 프로시저 변경 후 사용안함.
		//BaseDAO dao = null; 프로시저 변경 후 사용안함.
		
		String procedure = " { CALL hp_CompanyRegist (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";
		 QueryStatement sql = new QueryStatement();
		 //StringBuffer sb = new StringBuffer(); 프로시저 변경 후 사용안함.
		 //Connection conn = null; 프로시저 변경 후 사용안함.
		//HashMap m = null; 프로시저 변경 후 사용안함.
		//boolean a = false; 프로시저 변경 후 사용안함.
		
		 sql.setSql(procedure); // 프로시져 명
			sql.setString(compDto.getComp_code()); //업체코드 ID 업체관리를 위한 CODE값
			sql.setString(compDto.getPermit_no()); //기존 comp_code 값.
			sql.setString(compDto.getComp_nm());	
			sql.setString(compDto.getComp_no());	
			sql.setString(compDto.getOwner_nm());	
			sql.setString(compDto.getBusiness());	
			sql.setString(compDto.getB_item());		
			sql.setString(compDto.getAddress());		
			sql.setString(compDto.getAddr_detail());		
			sql.setString(compDto.getPost());			
			sql.setString(compDto.getReg_id());		
			sql.setString(compDto.getOpen_dt());		
			sql.setString(compDto.getCharge_nm());		
			sql.setString(compDto.getCharge_email());	
			sql.setString(compDto.getComp_file());		
			sql.setString(compDto.getCOMPANY_FILENM());	
			sql.setString(compDto.getAccount_copy1());	
			sql.setString(compDto.getAccount_copy2());	
			sql.setString(compDto.getAccount_copy3());	
			sql.setString(compDto.getAccount_copy4());	
			sql.setString(compDto.getAccount_copy5());	
			sql.setString(compDto.getACCOUNT_COPYNM1());	
			sql.setString(compDto.getCOMPANYEVALUATION());
			
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
	
	/**
	 * 업체 수정하기. 
	 * @param compDto 업체정보
	 * @return ActionForward
	 * @throws Exception 
	 */
	public int editCompany(CompanyDTO compDto) throws Exception{
		 int retVal = 0;
		 BaseDAO dao = null;
		 
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 Connection conn = null;
		 ResultDTO rsDto = null;
		 
		 try{
			 dao = new BaseDAO(this.getClass());
			 dao.startTransaction();
			 sql = new QueryStatement(); 
			 sb.append(" UPDATE T_COMPANY SET					 ");
			 sb.append(" PERMIT_NO=?, COMP_NM=?,COMP_NO=?, OWNER_NM=?, BUSINESS=?, B_ITEM=?,ADDRESS=?,ADDR_DETAIL=?,POST=?,MOD_ID=?,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':',''),OPENYMD=?,CHARGE_NM=?,CHARGE_EMAIL=?, ");
			 sb.append(" COMP_FILE=?,ACCOUNT_COPY1=?,ACCOUNT_COPY2=?,ACCOUNT_COPY3=?,ACCOUNT_COPY4=?,ACCOUNT_COPY5=?,COMPANY_FILENM=?,ACCOUNT_COPYNM1=?,COMPANYEVALUATION=?,UNFIT_REASON=?,BUSINESS_CHECK=?,DATE=?,UNFIT_ID=? \n");			 
			 sb.append(" WHERE COMP_CODE = ?					 ");
			
	         sql.setSql(sb.toString());
	         sql.setString(compDto.getPermit_no()); //업체관리 코드 추가.2013_03_18(월) shbyeon.
			 sql.setString(compDto.getComp_nm());
			 sql.setString(compDto.getComp_no());
			 sql.setString(compDto.getOwner_nm());
			 sql.setString(compDto.getBusiness());
			 sql.setString(compDto.getB_item());
			 sql.setString(compDto.getAddress());
			 sql.setString(compDto.getAddr_detail());
			 sql.setString(compDto.getPost());
			 sql.setString(compDto.getMod_id());
			 sql.setString(compDto.getOpen_dt());
			 sql.setString(compDto.getCharge_nm());
			 sql.setString(compDto.getCharge_email());
			 
			 sql.setString(compDto.getComp_file());
			 sql.setString(compDto.getAccount_copy1());
			 sql.setString(compDto.getAccount_copy2());
			 sql.setString(compDto.getAccount_copy3());
			 sql.setString(compDto.getAccount_copy4());
			 sql.setString(compDto.getAccount_copy5());
			 
			 sql.setString(compDto.getCOMPANY_FILENM());
			 sql.setString(compDto.getACCOUNT_COPYNM1());
			 sql.setString(compDto.getCOMPANYEVALUATION());
			 sql.setString(compDto.getUnfit_reason());
			 sql.setString(compDto.getBusiness_check());
			 sql.setString(compDto.getDate());
			 sql.setString(compDto.getUnfit_id());
			 
			 
			 
			 sql.setString(compDto.getComp_code());
			 
			 
			 if(dao.executeQuery(sql)>0){
				 retVal = 1;
				 
			 }else{
				 retVal = 0;
			 }
			 dao.commitTransaction();
		 } catch (Exception e) {
			 	log.error(e.getMessage(), e);
			} finally {
				dao.endTransaction();
			}
			 /*
			  * 
			 log.debug("[editCompany]" + sql.toString());
			 conn = broker.getConnection();
			 conn.setAutoCommit(false);		 
			 
			 retVal = broker.executeUpdate(sql, conn);
			 log.debug("[retVal]" +retVal);
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
			  */
	 
	 return retVal; 
	 
	}
	
	/**
	 * 업체명 수정하기.
	 * @info 수동입력시 기존 업체코드PK는 가지고있고 업체명만 변경하기위해. 
	 * @param compDto 업체정보
	 * @return ActionForward
	 * @throws DAOException
	 * 2013_03_18(월) shbyeon. SP변경
	 */
	public int updateCompany(CompanyDTO compDto) throws Exception{
		
		int retVal = 0;
			
		String procedure = " { CALL hp_CompanyNameModify (?,?,?) } ";
		 QueryStatement sql = new QueryStatement();
		 sql.setSql(procedure); // 프로시져 명
			sql.setString(compDto.getComp_code()); //업체코드 ID 업체관리를 위한 CODE값
			sql.setString(compDto.getComp_nm());	
			sql.setString(compDto.getMod_id());
			
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
	
	/**
	 * 업체를  삭제한다.(다건)
	 * @param commNos 업체키 배열
	 * @return ActionForward
	 * @throws DAOException
	 */	
	public int deleteCompany(String[] commNos) throws DAOException{
		
		int retVal = 0;
		QueryStatement sql = new QueryStatement();
		StringBuffer sb = new StringBuffer();
		String data ="";
		Connection conn = null;
		
		sb.append(" UPDATE T_COMPANY  SET 	\n");
		sb.append(" USE_YN = 'N' 	\n");
		sb.append("	WHERE COMP_CODE IN ( \n");
	
		for(int i=0; commNos != null && i<commNos.length; i++) {
			if(i==0){	
				sb.append("?");
			}else{ 
				sb.append(",").append("?");
			
			}
		}
		sb.append(")");
		sql.setSql(sb.toString());
		
		
		for(int i=0; commNos != null && i<commNos.length; i++){ 
			data = StringUtil.ReplaceAll(commNos[i],"/","");
			data = data.trim();
			sql.setString(data);	
		}
		
		log.debug("[deleteCompany]" + sql.toString());

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
	 * 업체를 삭제한다.(단건)
	 * @param compDto 업체키
	 * @return ActionForward
	 * @throws DAOException
	 */	
	public int deleteCompanyOne(CompanyDTO compDto) throws DAOException{
		
		int retVal = 0;
		QueryStatement sql = new QueryStatement();
		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		
		sb.append(" UPDATE T_COMPANY  SET 	\n");
		sb.append(" USE_YN = 'N'  ,MOD_ID=? ,MOD_DT=Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(8),Getdate(),108),':','')	\n");
		sb.append("	WHERE COMP_CODE = ? \n");
		
		sql.setString(compDto.getMod_id());
		sql.setString(compDto.getComp_code());
		sql.setSql(sb.toString());
		
		log.debug("[deleteCompanyOne]" + sql.toString());

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
	 * 업체를 완전히 삭제한다.(단건)
	 * @param compDto 업체키
	 * @return ActionForward
	 * @throws DAOException
	 */	
	public int deleteCompanyOne2(String searchtxt) throws DAOException{
		
		int retVal = 0;
		QueryStatement sql = new QueryStatement();
		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		
		sb.append("				DELETE FROM T_COMPANY   \n");
		sb.append("				WHERE PERMIT_NO like '%"+searchtxt+"%'	\n");
		
		sql.setSql(sb.toString());
		
		log.debug("[deleteCompanyOne2]" + sql.toString());
		
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
	 * 업체 리스트.(permit_no업체관리 코드 추가)
	 * 2013_03_20(수) shbyeon. 
	 * @param curpage   현재 페이지 카운트
	 * @param searchGb   검색구분
	 * @param searchtxt   검색키
	 * @param useyn   사용대상건여부
	 * @param listScale   list 갯수
	 * @param pageScale   page 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO companyPageList(int curpage, String search,  String searchGb, String searchtxt, String useyn, String deleted_yn, int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;
		try{
			//---- List Sql 문생성
			ListStatement sql = new ListStatement();
			
			sql.setAlias(" COMP_CODE,PERMIT_NO,COMP_NM,COMP_NO, OWNER_NM, BUSINESS, B_ITEM,ADDRESS,ADDR_DETAIL,POST,REG_DT,OPENYMD,CHARGE_NM,CHARGE_EMAIL,COMP_FILE,ACCOUNT_COPY1,COMPANY_FILENM,ACCOUNT_COPYNM1,DATE ,UNFIT_ID,UNFIT_REASON ");
			sql.setSelect(" COMP_CODE,PERMIT_NO,COMP_NM,COMP_NO, OWNER_NM, BUSINESS, B_ITEM,ADDRESS,ADDR_DETAIL,POST,REG_DT,OPENYMD,CHARGE_NM,CHARGE_EMAIL,COMP_FILE,ACCOUNT_COPY1,COMPANY_FILENM,ACCOUNT_COPYNM1,DATE,UNFIT_ID,UNFIT_REASON ");
			sql.setFrom	(" T_COMPANY \n");
			
			if(search.equals("S")){
				where +=" PERMIT_NO = '' and USE_YN = 'Y' and DELETED_YN = 'N' ";
			}else if(useyn.equals("Y") && deleted_yn.equals("Y")){
				where += " USE_YN = 'Y' and DELETED_YN = 'N' and PERMIT_NO != '' \n  " ; //2012.11.27(화)shbyeon. DELETED_YN(추가) 2013_03_18(월)shbyeon. PERMIT_NO추가)
			}else{
				where += " 1=1  \n ";
			}

			if(searchGb != null && !searchGb.equals(""))
			{
				if(searchGb.equals("A"))
				{
					where += " AND COMP_NM LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("B"))
				{
					where += " AND PERMIT_NO LIKE ? "; //사업자 등록번호 기존 COMP_CODE = > PERMIT_NO 로 DB 칼럼명 변경됨. COMP_CODE는 업체관리코드 PERMIT_NO 가 사업자등록번호.(2013_05_13(월)shbyeon.)
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("C"))
				{
					where += " AND OWNER_NM LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				
			}
		

			sql.setWhere(where);
			sql.setOrderby(" REG_DT DESC "); 
		
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
	 * 사업자 업체 리스트 조회.
	 * 2013_03_20(수) shbyeon.   
	 * @param curpage   현재 페이지 카운트
	 * @param searchGb   검색구분
	 * @param searchtxt   검색키
	 * @param useyn   사용대상건여부
	 * @param listScale   list 갯수
	 * @param pageScale   page 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO companyPageListPop(int curpage, String searchGb, String searchtxt, String useyn, String deleted_yn, int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;

		try{
			ListStatement sql = new ListStatement();
			sql.setAlias(" COMP_CODE,PERMIT_NO,COMP_NM,COMP_NO, OWNER_NM, BUSINESS, B_ITEM,ADDRESS,ADDR_DETAIL,POST,REG_DT,OPENYMD,CHARGE_NM,CHARGE_EMAIL,COMP_FILE,ACCOUNT_COPY1,COMPANY_FILENM,ACCOUNT_COPYNM1,DATE ");
			sql.setSelect(" COMP_CODE,PERMIT_NO,COMP_NM,COMP_NO, OWNER_NM, BUSINESS, B_ITEM,ADDRESS,ADDR_DETAIL,POST,REG_DT,OPENYMD,CHARGE_NM,CHARGE_EMAIL,COMP_FILE,ACCOUNT_COPY1,COMPANY_FILENM,ACCOUNT_COPYNM1,DATE ");
			sql.setFrom	(" T_COMPANY \n");
			
			
			if(useyn.equals("Y") && deleted_yn.equals("Y")){
				where += " USE_YN = 'Y' and DELETED_YN = 'N' and PERMIT_NO != '' \n  " ; //2012.11.27(화)shbyeon. DELETED_YN(추가) 2013_03_18(월)shbyeon. PERMIT_NO추가
			}else{
				where += " 1=1  \n ";
			}
			if(searchGb != null && !searchGb.equals(""))
			{
				if(searchGb.equals("A"))
				{
					where += " AND COMP_NM LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("B"))
				{
					where += " AND PERMIT_NO LIKE ? "; //사업자 등록번호 기존 COMP_CODE => PERMIT_NO 로 변경됨 COMP_CODE는 업체관리코드로 PK로 사용됨.
					sql.setString("%" + searchtxt + "%"); // 기존PK변경.단 사업자등록번호는 중복되면 안됨.
				}
				if(searchGb.equals("C"))
				{
					where += " AND OWNER_NM LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
			}

			sql.setWhere(where);
			sql.setOrderby(" REG_DT DESC "); 
		
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
	 * 사업자 업체 리스트 조회.(부적격 업체는 리스트에서 제외)
	 * 2013_03_20(수) shbyeon.   
	 * @param curpage   현재 페이지 카운트
	 * @param searchGb   검색구분
	 * @param searchtxt   검색키
	 * @param useyn   사용대상건여부
	 * @param listScale   list 갯수
	 * @param pageScale   page 갯수
	 * @return ActionForward
	 * @throws DAOException
	 */
	public ListDTO companyPageListPop(int curpage, String searchGb, String searchtxt, String useyn, String deleted_yn, String UNFIT_ID, int listScale, int pageScale) throws DAOException {
		ListDTO retVal = null;
		String where = "";
		Connection conn = null;

		try{
			ListStatement sql = new ListStatement();
			sql.setAlias(" COMP_CODE,PERMIT_NO,COMP_NM,COMP_NO, OWNER_NM, BUSINESS, B_ITEM,ADDRESS,ADDR_DETAIL,POST,REG_DT,OPENYMD,CHARGE_NM,CHARGE_EMAIL,COMP_FILE,ACCOUNT_COPY1,COMPANY_FILENM,ACCOUNT_COPYNM1,UNFIT_ID ");
			sql.setSelect(" COMP_CODE,PERMIT_NO,COMP_NM,COMP_NO, OWNER_NM, BUSINESS, B_ITEM,ADDRESS,ADDR_DETAIL,POST,REG_DT,OPENYMD,CHARGE_NM,CHARGE_EMAIL,COMP_FILE,ACCOUNT_COPY1,COMPANY_FILENM,ACCOUNT_COPYNM1,UNFIT_ID ");
			sql.setFrom	(" T_COMPANY \n");
			
			
			if(useyn.equals("Y") && deleted_yn.equals("Y") && !UNFIT_ID.isEmpty()){
				where += " USE_YN = 'Y' and DELETED_YN = 'N' and PERMIT_NO != ''  \n  " ; //2012.11.27(화)shbyeon. DELETED_YN(추가) 2013_03_18(월)shbyeon. PERMIT_NO추가
			}else{
				where += " 1=1  \n ";
			}
			if(searchGb != null && !searchGb.equals(""))
			{
				if(searchGb.equals("A"))
				{
					where += " AND COMP_NM LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
				if(searchGb.equals("B"))
				{
					where += " AND PERMIT_NO LIKE ? "; //사업자 등록번호 기존 COMP_CODE => PERMIT_NO 로 변경됨 COMP_CODE는 업체관리코드로 PK로 사용됨.
					sql.setString("%" + searchtxt + "%"); // 기존PK변경.단 사업자등록번호는 중복되면 안됨.
				}
				if(searchGb.equals("C"))
				{
					where += " AND OWNER_NM LIKE ? ";
					sql.setString("%" + searchtxt + "%");
				}
			}

			sql.setWhere(where);
			sql.setOrderby(" COMP_NM ASC "); 
		
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
	 * 업체 View 정보.
	 * @param compCode 업체정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	public CompanyDTO getCompanyView( String compCode) throws DAOException{
		
		CompanyDTO compDto = null;
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		
		sb.append("				SELECT * FROM T_COMPANY   \n");
		sb.append("				WHERE USE_YN='Y' AND COMP_CODE=?	\n");
		
		
		log.debug(sb.toString());
		sql.setSql(sb.toString());
		sql.setString(compCode);
	
		DataSet ds = null;
		try{
			ds = broker.executeQuery(sql);
			if(ds.next()){ 
				compDto = new CompanyDTO();
				
				compDto.setComp_code(StringUtil.nvl(ds.getString("COMP_CODE"),"")); //2013_03_18(월)테스트완료 후 부터는 코드관리 키값으로변경함.
				compDto.setPermit_no(StringUtil.nvl(ds.getString("PERMIT_NO"),"")); //업체관리코드 추가 2013_03_18(월)shbyeon. 기존COMP_CODE = >PERMIT_NO변경.
				compDto.setComp_nm(StringUtil.nvl(ds.getString("COMP_NM"),""));
				compDto.setComp_no(StringUtil.nvl(ds.getString("COMP_NO"),""));
				compDto.setOwner_nm(StringUtil.nvl(ds.getString("OWNER_NM"),""));
				compDto.setBusiness(StringUtil.nvl(ds.getString("BUSINESS"),""));
				compDto.setB_item(StringUtil.nvl(ds.getString("B_ITEM"),""));
				compDto.setAddress(StringUtil.nvl(ds.getString("ADDRESS"),""));
				compDto.setAddr_detail(StringUtil.nvl(ds.getString("ADDR_DETAIL"),""));
				compDto.setPost(StringUtil.nvl(ds.getString("POST"),""));
				compDto.setOpen_dt(StringUtil.nvl(ds.getString("OPENYMD"),""));
				compDto.setCharge_nm(StringUtil.nvl(ds.getString("CHARGE_NM"),""));
				compDto.setCharge_email(StringUtil.nvl(ds.getString("CHARGE_EMAIL"),""));
				compDto.setComp_file(StringUtil.nvl(ds.getString("COMP_FILE"),""));
				compDto.setAccount_copy1(StringUtil.nvl(ds.getString("ACCOUNT_COPY1"),""));
				compDto.setAccount_copy2(StringUtil.nvl(ds.getString("ACCOUNT_COPY2"),""));
				compDto.setAccount_copy3(StringUtil.nvl(ds.getString("ACCOUNT_COPY3"),""));
				compDto.setAccount_copy4(StringUtil.nvl(ds.getString("ACCOUNT_COPY4"),""));
				compDto.setAccount_copy5(StringUtil.nvl(ds.getString("ACCOUNT_COPY5"),""));
				compDto.setCOMPANY_FILENM(StringUtil.nvl(ds.getString("COMPANY_FILENM"),""));
				compDto.setACCOUNT_COPYNM1(StringUtil.nvl(ds.getString("ACCOUNT_COPYNM1"),""));
				compDto.setCOMPANYEVALUATION(StringUtil.nvl(ds.getString("COMPANYEVALUATION"),""));
				
				compDto.setUnfit_reason(StringUtil.nvl(ds.getString("UNFIT_REASON"),""));
				compDto.setBusiness_check(StringUtil.nvl(ds.getString("BUSINESS_CHECK"),""));
				compDto.setDate(StringUtil.nvl(ds.getString("DATE"),""));
				compDto.setUnfit_id(StringUtil.nvl(ds.getString("UNFIT_ID"),""));
			
				
			}
		}catch(Exception e){
		    e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}
		
		return compDto;
	}
	
	
	/**
	 * 업체 View 정보2.
	 * @param 사업번호로 찾기 업체정보
	 * @return ActionForward
	 * @throws DAOException
	 * 20200602 김진동 기존 로직  추가
	 */
	public CompanyDTO getCompanyView2( String searchtxt) throws DAOException{
		
		CompanyDTO compDto = null;
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		
		sb.append("				SELECT * FROM T_COMPANY   \n");
		sb.append("				WHERE PERMIT_NO like '%"+searchtxt+"%'	\n");
		log.debug(sb.toString());
		sql.setSql(sb.toString());
		
		DataSet ds = null;
		try{
			ds = broker.executeQuery(sql);
			if(ds.next()){ 
				compDto = new CompanyDTO();
				
				compDto.setComp_code(StringUtil.nvl(ds.getString("COMP_CODE"),"")); //2013_03_18(월)테스트완료 후 부터는 코드관리 키값으로변경함.
				compDto.setPermit_no(StringUtil.nvl(ds.getString("PERMIT_NO"),"")); //업체관리코드 추가 2013_03_18(월)shbyeon. 기존COMP_CODE = >PERMIT_NO변경.
				compDto.setComp_nm(StringUtil.nvl(ds.getString("COMP_NM"),""));
				compDto.setComp_no(StringUtil.nvl(ds.getString("COMP_NO"),""));
				compDto.setOwner_nm(StringUtil.nvl(ds.getString("OWNER_NM"),""));
				compDto.setBusiness(StringUtil.nvl(ds.getString("BUSINESS"),""));
				compDto.setB_item(StringUtil.nvl(ds.getString("B_ITEM"),""));
				compDto.setAddress(StringUtil.nvl(ds.getString("ADDRESS"),""));
				compDto.setAddr_detail(StringUtil.nvl(ds.getString("ADDR_DETAIL"),""));
				compDto.setPost(StringUtil.nvl(ds.getString("POST"),""));
				compDto.setOpen_dt(StringUtil.nvl(ds.getString("OPENYMD"),""));
				compDto.setCharge_nm(StringUtil.nvl(ds.getString("CHARGE_NM"),""));
				compDto.setCharge_email(StringUtil.nvl(ds.getString("CHARGE_EMAIL"),""));
				compDto.setComp_file(StringUtil.nvl(ds.getString("COMP_FILE"),""));
				compDto.setAccount_copy1(StringUtil.nvl(ds.getString("ACCOUNT_COPY1"),""));
				compDto.setAccount_copy2(StringUtil.nvl(ds.getString("ACCOUNT_COPY2"),""));
				compDto.setAccount_copy3(StringUtil.nvl(ds.getString("ACCOUNT_COPY3"),""));
				compDto.setAccount_copy4(StringUtil.nvl(ds.getString("ACCOUNT_COPY4"),""));
				compDto.setAccount_copy5(StringUtil.nvl(ds.getString("ACCOUNT_COPY5"),""));
				compDto.setCOMPANY_FILENM(StringUtil.nvl(ds.getString("COMPANY_FILENM"),""));
				compDto.setACCOUNT_COPYNM1(StringUtil.nvl(ds.getString("ACCOUNT_COPYNM1"),""));
				compDto.setCOMPANYEVALUATION(StringUtil.nvl(ds.getString("COMPANYEVALUATION"),""));
				
				compDto.setUnfit_reason(StringUtil.nvl(ds.getString("UNFIT_REASON"),""));
				compDto.setBusiness_check(StringUtil.nvl(ds.getString("BUSINESS_CHECK"),""));
				compDto.setDate(StringUtil.nvl(ds.getString("DATE"),""));
				compDto.setUnfit_id(StringUtil.nvl(ds.getString("UNFIT_ID"),""));
				compDto.setDeleted_yn(StringUtil.nvl(ds.getString("DELETED_YN"),""));
				
				
			}
		}catch(Exception e){
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}
		
		return compDto;
	}
	
	
	
	/**
	 * 업체 EXCEL 리스트
	 * @param dto 업체정보
	 * @return jsp
	 * @throws DAOException
	 */
	public ArrayList getCompanyListExcel(CompanyDTO dto) throws DAOException {
		QueryStatement sql = new QueryStatement();
		StringBuffer sbSql = new StringBuffer();
		CompanyDTO companyDto  =null;
		ArrayList<CompanyDTO> arrlist = new ArrayList<CompanyDTO>();
		try{			
			String searchGb=dto.getSearchGb();
			
			sbSql.append(" SELECT COMP_CODE,COMP_NM,COMP_NO, OWNER_NM, BUSINESS, B_ITEM, B_ITEM,ADDRESS,ADDR_DETAIL,POST,REG_DT,OPENYMD,CHARGE_NM,CHARGE_EMAIL ");
			sbSql.append(" FROM T_COMPANY ");
			sbSql.append(" WHERE USE_YN='Y' ");
			
			if(!("").equals(searchGb)){
				if( "A".equals(searchGb) && !("").equals(dto.getSearchTxt()) ){
					sbSql.append(" and COMP_NM like '%"+dto.getSearchTxt()+"%' ");
				} else if ("B".equals(searchGb)  && !("").equals(dto.getSearchTxt()) ){
					sbSql.append(" and COMP_CODE like '%"+dto.getSearchTxt()+"%' ");
				} else if ("C".equals(searchGb)  && !("").equals(dto.getSearchTxt()) ){
					sbSql.append(" and OWNER_NM like '%"+dto.getSearchTxt()+"%' ");
				}
			}
			//sbSql.append(" ORDER BY REG_DT DESC ");
			
			sql.setSql(sbSql.toString());
			log.debug("getCompanyListExcel["+sbSql.toString()+"]");	
			
			 DataSet ds = null;
			 try{
				 ds = broker.executeQuery(sql);
			
				 while(ds.next()){ 
					 companyDto = new CompanyDTO();
					 companyDto.setComp_code(ds.getString("COMP_CODE"));
					 companyDto.setComp_nm(ds.getString("COMP_NM"));
					 companyDto.setComp_no(ds.getString("COMP_NO"));
					 companyDto.setOwner_nm(ds.getString("OWNER_NM"));
					 companyDto.setBusiness(ds.getString("BUSINESS"));
					 companyDto.setB_item(ds.getString("B_ITEM"));
					 companyDto.setOpen_dt(ds.getString("OPENYMD"));
					 companyDto.setCharge_nm(ds.getString("CHARGE_NM"));
					 
					 arrlist.add(companyDto);
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
	 * 2012.11.27(화) bsh.
	 * 업체관리 = > 삭제
	 * 
	 * @param actionMapping
	 * @param actionForm
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public int deleteCompanyOne1(CompanyDTO compDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CompanyDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(compDto.getComp_code());

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
	
	
	
	
	public CompanyDTO getCompanyUnfitView(CompanyDTO compDto) throws DAOException{

		
		  UserDTO userDto = new UserDTO();
		  
		String procedure = "{ CALL hp_CompanyUnfitView ( ? , ? ) }";

		DataSet ds = null;
		
		QueryStatement sql = new QueryStatement();
		
		sql.setKey(userDto.getLogid()); 
		sql.setSql(procedure); // 프로시져 명
		sql.setString(compDto.getComp_code());
		sql.setString(compDto.getUnfit_id());
		try{
			
			 ds = broker.executeProcedure(sql);
			
			 
			 while(ds.next()){ 
				
					
					compDto.setComp_code(StringUtil.nvl(ds.getString("COMP_CODE"),"")); //2013_03_18(월)테스트완료 후 부터는 코드관리 키값으로변경함.
					compDto.setPermit_no(StringUtil.nvl(ds.getString("PERMIT_NO"),"")); //업체관리코드 추가 2013_03_18(월)shbyeon. 기존COMP_CODE = >PERMIT_NO변경.
					compDto.setComp_nm(StringUtil.nvl(ds.getString("COMP_NM"),""));
					compDto.setComp_no(StringUtil.nvl(ds.getString("COMP_NO"),""));
					compDto.setOwner_nm(StringUtil.nvl(ds.getString("OWNER_NM"),""));
					compDto.setBusiness(StringUtil.nvl(ds.getString("BUSINESS"),""));
					compDto.setB_item(StringUtil.nvl(ds.getString("B_ITEM"),""));
					compDto.setAddress(StringUtil.nvl(ds.getString("ADDRESS"),""));
					compDto.setAddr_detail(StringUtil.nvl(ds.getString("ADDR_DETAIL"),""));
					compDto.setPost(StringUtil.nvl(ds.getString("POST"),""));
					compDto.setOpen_dt(StringUtil.nvl(ds.getString("OPENYMD"),""));
					compDto.setCharge_nm(StringUtil.nvl(ds.getString("CHARGE_NM"),""));
					compDto.setCharge_email(StringUtil.nvl(ds.getString("CHARGE_EMAIL"),""));
					compDto.setComp_file(StringUtil.nvl(ds.getString("COMP_FILE"),""));
					compDto.setAccount_copy1(StringUtil.nvl(ds.getString("ACCOUNT_COPY1"),""));
					compDto.setAccount_copy2(StringUtil.nvl(ds.getString("ACCOUNT_COPY2"),""));
					compDto.setAccount_copy3(StringUtil.nvl(ds.getString("ACCOUNT_COPY3"),""));
					compDto.setAccount_copy4(StringUtil.nvl(ds.getString("ACCOUNT_COPY4"),""));
					compDto.setAccount_copy5(StringUtil.nvl(ds.getString("ACCOUNT_COPY5"),""));
					compDto.setCOMPANY_FILENM(StringUtil.nvl(ds.getString("COMPANY_FILENM"),""));
					compDto.setACCOUNT_COPYNM1(StringUtil.nvl(ds.getString("ACCOUNT_COPYNM1"),""));
					compDto.setCOMPANYEVALUATION(StringUtil.nvl(ds.getString("COMPANYEVALUATION"),""));
					
					compDto.setUnfit_reason(StringUtil.nvl(ds.getString("UNFIT_REASON"),""));
					compDto.setBusiness_check(StringUtil.nvl(ds.getString("BUSINESS_CHECK"),""));
					compDto.setDate(StringUtil.nvl(ds.getString("DATE"),""));
					compDto.setUnfit_id(StringUtil.nvl(ds.getString("UNFIT_ID"),""));
					System.out.println("DAO==============================================DAO" + compDto.getUnfit_id());
			 }
			 
		}catch(Exception e){
		      e.printStackTrace();
			  log.error(e.getMessage());
			  throw new DAOException(e.getMessage());
		}finally
		{
			try
		    {
		        if (ds != null) { ds.close(); ds = null; }
		    } 
		    catch (Exception ignore)
		    {
		    	log.error(ignore.getMessage());
		    }
		}
		
		return compDto;
	}

	
	/**
	 * 부적격 업체 View 정보.
	 * @param compCode 업체정보
	 * @return ActionForward
	 * @throws DAOException
	 */
	/*public CompanyDTO getCompanyUnfitView( String compCode) throws DAOException{
		
		CompanyDTO compDto = null;
		StringBuffer sb = new StringBuffer();
		QueryStatement sql = new QueryStatement();
		
		sb.append("				SELECT * FROM T_COMPANY   \n");
		sb.append("				WHERE USE_YN='Y' AND COMP_CODE=?	\n");
		
		
		log.debug(sb.toString());
		sql.setSql(sb.toString());
		sql.setString(compCode);
		
		String procedure = " { CALL hp_CompanyUnfitView (?) } ";


		sql.setSql(procedure); // 프로시져 명
		sql.setString(compDto.getComp_code());
	
		
		
		
		DataSet ds = null;
		try{
			ds = broker.executeQuery(sql);
			if(ds.next()){ 
				compDto = new CompanyDTO();
				
				compDto.setComp_code(StringUtil.nvl(ds.getString("COMP_CODE"),"")); //2013_03_18(월)테스트완료 후 부터는 코드관리 키값으로변경함.
				compDto.setPermit_no(StringUtil.nvl(ds.getString("PERMIT_NO"),"")); //업체관리코드 추가 2013_03_18(월)shbyeon. 기존COMP_CODE = >PERMIT_NO변경.
				compDto.setComp_nm(StringUtil.nvl(ds.getString("COMP_NM"),""));
				compDto.setComp_no(StringUtil.nvl(ds.getString("COMP_NO"),""));
				compDto.setOwner_nm(StringUtil.nvl(ds.getString("OWNER_NM"),""));
				compDto.setBusiness(StringUtil.nvl(ds.getString("BUSINESS"),""));
				compDto.setB_item(StringUtil.nvl(ds.getString("B_ITEM"),""));
				compDto.setAddress(StringUtil.nvl(ds.getString("ADDRESS"),""));
				compDto.setAddr_detail(StringUtil.nvl(ds.getString("ADDR_DETAIL"),""));
				compDto.setPost(StringUtil.nvl(ds.getString("POST"),""));
				compDto.setOpen_dt(StringUtil.nvl(ds.getString("OPENYMD"),""));
				compDto.setCharge_nm(StringUtil.nvl(ds.getString("CHARGE_NM"),""));
				compDto.setCharge_email(StringUtil.nvl(ds.getString("CHARGE_EMAIL"),""));
				compDto.setComp_file(StringUtil.nvl(ds.getString("COMP_FILE"),""));
				compDto.setAccount_copy1(StringUtil.nvl(ds.getString("ACCOUNT_COPY1"),""));
				compDto.setAccount_copy2(StringUtil.nvl(ds.getString("ACCOUNT_COPY2"),""));
				compDto.setAccount_copy3(StringUtil.nvl(ds.getString("ACCOUNT_COPY3"),""));
				compDto.setAccount_copy4(StringUtil.nvl(ds.getString("ACCOUNT_COPY4"),""));
				compDto.setAccount_copy5(StringUtil.nvl(ds.getString("ACCOUNT_COPY5"),""));
				compDto.setCOMPANY_FILENM(StringUtil.nvl(ds.getString("COMPANY_FILENM"),""));
				compDto.setACCOUNT_COPYNM1(StringUtil.nvl(ds.getString("ACCOUNT_COPYNM1"),""));
				compDto.setCOMPANYEVALUATION(StringUtil.nvl(ds.getString("COMPANYEVALUATION"),""));
				
				compDto.setUnfit_reason(StringUtil.nvl(ds.getString("UNFIT_REASON"),""));
				compDto.setBusiness_check(StringUtil.nvl(ds.getString("BUSINESS_CHECK"),""));
				compDto.setDate(StringUtil.nvl(ds.getString("DATE"),""));
				compDto.setUnfit_id(StringUtil.nvl(ds.getString("UNFIT_ID"),""));

			}
		}catch(Exception e){
		    e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}finally{
			if(ds!=null) { ds.close(); ds = null; }
		}
		
		return compDto;
	}*/
	
 }
