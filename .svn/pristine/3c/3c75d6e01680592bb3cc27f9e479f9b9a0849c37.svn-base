package com.huation.common.contractmanage;

import java.sql.Connection;

import java.sql.SQLException;
import java.sql.ResultSet;

import java.io.Writer;
import java.io.BufferedWriter;
import java.sql.CallableStatement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.ExecutionException;

import sun.util.logging.resources.logging;

import com.huation.common.BaseDAO;
import com.huation.common.contractmanage.ContractManageDTO;
import com.huation.common.currentstatus.CurrentStatusDTO;
import com.huation.common.formfile.FormFileDTO;
import com.huation.common.user.UserDTO;

import com.huation.framework.persist.QueryStatement;
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
import com.mysql.jdbc.SQLError;

public class ContractManageDAO extends AbstractDAO {

	/**
	 * CreateDate:2013-11-21(목) Writer:shbyeon.
	 * 계약관리 리스트
	 * @param cmDto
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO contractMgPageList(ContractManageDTO cmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ContractMgInquiry_new2 ( ?,?,?,?,?,?,?,? ) } ";//20200605 new 에서 new1으로 교체

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
	    sql.setString(cmDto.getChUserID()); 		//로그인 세션 ID
		sql.setString(cmDto.getvSearchType()); 		// 검색구분
		sql.setString(cmDto.getSearchGb2());		// 검색구분(계약종결 여부)
		sql.setString(cmDto.getSearchGb3());		// 검색구분(매출구분, 시스템매출, 상품매출, 용역매출)
		sql.setString(cmDto.getvSearch()); 			// 검색어
		sql.setInteger(cmDto.getnRow()); 			// 리스트 갯수
		sql.setInteger(cmDto.getnPage()); 			// 현제 페이지
		sql.setString("PAGE"); 						// sp 구분

		try {
			retVal = broker.executePageProcedure(sql, cmDto.getnPage(),
					cmDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	/**
	 * CreateDate:2013-11-21(목) Writer:shbyeon.
	 * 계약등록 리스트
	 * @param cmDto
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO contractMgRegistList(ContractManageDTO cmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ContractMgRegistInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
	    sql.setString(cmDto.getChUserID()); 		//로그인 세션 ID
		sql.setString(cmDto.getvSearchType()); 		// 검색구분
		sql.setString(cmDto.getvSearch()); 			// 검색어
		sql.setInteger(cmDto.getnRow()); 			// 리스트 갯수
		sql.setInteger(cmDto.getnPage()); 			// 현제 페이지
		sql.setString("PAGE"); 						// sp 구분

		try {
			retVal = broker.executePageProcedure(sql, cmDto.getnPage(),
					cmDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	/**
	 * CreateDate:2013-11-21(목) Writer:shbyeon.
	 * 계약관리 리스트(Excel-Down)
	 * @param cmDto
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO contractMgExcel(ContractManageDTO cmDto) throws DAOException {

		ListDTO retVal = null;
//		String procedure = " { CALL hp_ContractMgInquiry ( ?,?,?,?,?,? ) } ";
//
//		QueryStatement sql = new QueryStatement();

//		sql.setSql(procedure); // 프로시져 명
//	    sql.setString(cmDto.getChUserID()); 		//로그인 세션 ID
//		sql.setString(cmDto.getvSearchType()); 		// 검색구분
//		sql.setString(cmDto.getvSearch()); 			// 검색어
//		sql.setInteger(cmDto.getnRow()); 			// 리스트 갯수
//		sql.setInteger(cmDto.getnPage()); 			// 현제 페이지
//		sql.setString("LIST"); 						// sp 구분

		String procedure = " { CALL hp_ContractMgInquiry_new2 ( ?,?,?,?,?,?,?,? ) } ";//20200605 new 에서 new1으로 교체

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
	    sql.setString(cmDto.getChUserID()); 		//로그인 세션 ID
		sql.setString(cmDto.getvSearchType()); 		// 검색구분
		sql.setString(cmDto.getSearchGb2());		// 검색구분(계약종결 여부)
		sql.setString(cmDto.getSearchGb3());		// 검색구분(매출구분, 시스템매출, 상품매출, 용역매출)
		sql.setString(cmDto.getvSearch()); 			// 검색어
		sql.setInteger(cmDto.getnRow()); 			// 리스트 갯수
		sql.setInteger(cmDto.getnPage()); 			// 현제 페이지
		sql.setString("PAGE"); 						// sp 구분					// sp 구분
		
		
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
	 * CreateDate:2013-11-26(화) Writer:shbyeon.
	 * 계약관리 코드번호 생성하기(MAX 값으로 Select 해온다.) 
	 * @param cmDto
	 * @return retVal
	 * @throws DAOException
	 */
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
				log.debug("[견적서 계약관리 등록 CQ_Code(년/월/일MAX로 SELECT) => 새로 생성:"+createCode_return+" DAO..계약관리 등록]");
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

	/**
	 * CreateDate:2013-12-13(수) Writer:shbyeon.
	 * 계약관리 등록(계약관리 메뉴 등록하기.)  
	 * @param cmDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int contractInsertData(ContractManageDTO cmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ContractMgRegist (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(cmDto.getContractCode());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 PK 계약코드번호:"+cmDto.getContractCode()+" DAO..]");
		sql.setString(cmDto.getPublic_No());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 PK 견적번호:"+cmDto.getPublic_No()+" DAO..]");
		sql.setString(cmDto.getContractFile());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 계약서 파일경로:"+cmDto.getContractFile()+" DAO..]");
		sql.setString(cmDto.getContractFileNm());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 계약서 파일명:"+cmDto.getContractFileNm()+" DAO..]");
		sql.setString(cmDto.getPurchaseOrderFile());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 발주서 파일경로:"+cmDto.getPurchaseOrderFile()+" DAO..]");
		sql.setString(cmDto.getPurchaseOrderFileNm());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 발주서 파일명:"+cmDto.getPurchaseOrderFileNm()+" DAO..]");
		sql.setString(cmDto.getContractName());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 계약명:"+cmDto.getContractName()+" DAO..]");
		sql.setString(cmDto.getContractCreateUser());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 최초등록자:"+cmDto.getContractCreateUser()+" DAO..]");
		sql.setString(cmDto.getContractStatus());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 계약 종결여부:"+cmDto.getContractStatus()+" DAO..]");
		sql.setString(cmDto.getContractReason());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 조기종료 사유:"+cmDto.getContractReason()+" DAO..]");
		sql.setString(cmDto.getOrdering_Organization());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 발주사(업체명):"+cmDto.getOrdering_Organization()+" DAO..]");
		sql.setString(cmDto.getCustomerName());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 고객담당자명:"+cmDto.getCustomerName()+" DAO..]");
		sql.setString(cmDto.getCustomerTel());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 고객 담당자 연락처:"+cmDto.getCustomerTel()+" DAO..]");
		sql.setString(cmDto.getCustomerMobile());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 고객 담당자 핸드폰 번호 :"+cmDto.getCustomerMobile()+" DAO..]");
		sql.setString(cmDto.getContractEndDate());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 종료일자 :"+cmDto.getContractEndDate()+" DAO..]");
		sql.setString(cmDto.getContractDate());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 계약일자 :"+cmDto.getContractDate()+" DAO..]");
		sql.setString(cmDto.getConChk());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 계약일자 사용여부 :"+cmDto.getConChk()+" DAO..]");
		sql.setString(cmDto.getPurchaseDate());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 발주일자 :"+cmDto.getPurchaseDate()+" DAO..]");
		sql.setString(cmDto.getPurChk());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 발주일자 사용여부 :"+cmDto.getPurChk()+" DAO..]");
		
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
	 * CreateDate:2013-11-27(화) Writer:shbyeon.
	 * 계약관리 상세정보
	 * @param cmDto
	 * @return cmDto
	 * @throws DAOException
	 */
	public ContractManageDTO contractManageView(ContractManageDTO cmDto) throws DAOException {

		String procedure = "{ CALL hp_ContractMgSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(cmDto.getContractCode());

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				cmDto = new ContractManageDTO();
				cmDto.setContractCode(ds.getString("ContractCode"));
				cmDto.setPublic_No(ds.getString("Public_No"));
				cmDto.setContractName(ds.getString("ContractName"));
				cmDto.setContractFile(ds.getString("ContractFile"));
				cmDto.setContractFileNm(ds.getString("ContractFileNm"));
				cmDto.setPurchaseOrderFile(ds.getString("PurchaseOrderFile"));
				cmDto.setPurchaseOrderFileNm(ds.getString("PurchaseOrderFileNm"));
				cmDto.setContractStatus(ds.getString("ContractStatus"));
				cmDto.setContractReason(ds.getString("ContractReason"));
				cmDto.setCustomerName(ds.getString("CustomerName"));
				cmDto.setCustomerTel(ds.getString("CustomerTel"));
				cmDto.setCustomerMobile(ds.getString("CustomerMobile"));
				cmDto.setContractEndDate(ds.getString("ContractEndDate"));
				cmDto.setOrdering_Organization(ds.getString("Ordering_Organization"));
				cmDto.setContractDate(ds.getString("ContractDate"));
				cmDto.setPurchaseDate(ds.getString("PurchaseDate"));
			}

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
			try {
				if (ds != null) {
					ds.close();
					ds = null;
				}
			} catch (Exception ignore) {
				log.error(ignore.getMessage());
			}
		}

		return cmDto; 
	}
	
	/**
	 * CreateDate:2013-11-27(수) Writer:shbyeon.
	 * 계약관리 수정(계약관리 메뉴 수정하기.)  
	 * @param cmDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int contractUpdateData(ContractManageDTO cmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ContractMgModify (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(cmDto.getContractCode());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 PK 계약코드번호:"+cmDto.getContractCode()+" DAO..]");
		sql.setString(cmDto.getPublic_No());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 PK 견적번호:"+cmDto.getPublic_No()+" DAO..]");
		sql.setString(cmDto.getContractFile());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 계약서 파일경로:"+cmDto.getContractFile()+" DAO..]");
		sql.setString(cmDto.getContractFileNm());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 계약서 파일명:"+cmDto.getContractFileNm()+" DAO..]");
		sql.setString(cmDto.getPurchaseOrderFile());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 발주서 파일경로:"+cmDto.getPurchaseOrderFile()+" DAO..]");
		sql.setString(cmDto.getPurchaseOrderFileNm());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 발주서 파일명:"+cmDto.getPurchaseOrderFileNm()+" DAO..]");
		sql.setString(cmDto.getContractName());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 계약명:"+cmDto.getContractName()+" DAO..]");
		sql.setString(cmDto.getContractUpdateUser());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 최초등록자:"+cmDto.getContractUpdateUser()+" DAO..]");
		sql.setString(cmDto.getContractStatus());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 계약 종결여부:"+cmDto.getContractStatus()+" DAO..]");
		sql.setString(cmDto.getContractReason());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 조기종료 사유:"+cmDto.getContractReason()+" DAO..]");
		sql.setString(cmDto.getOrdering_Organization());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 발주사(업체명):"+cmDto.getOrdering_Organization()+" DAO..]");
		sql.setString(cmDto.getCustomerName());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 고객담당자명:"+cmDto.getCustomerName()+" DAO..]");
		sql.setString(cmDto.getCustomerTel());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 고객 담당자 연락처:"+cmDto.getCustomerTel()+" DAO..]");
		sql.setString(cmDto.getCustomerMobile());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 고객 담당자 핸드폰 번호 :"+cmDto.getCustomerMobile()+" DAO..]");
		sql.setString(cmDto.getContractEndDate());
		log.debug("[계약관리 수정 테이블에 Update 되는 데이터 종료일자:"+cmDto.getContractEndDate()+" DAO..]");
		sql.setString(cmDto.getContractDate());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 계약일자 :"+cmDto.getContractDate()+" DAO..]");
		sql.setString(cmDto.getConChk());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 계약일자 사용여부 :"+cmDto.getConChk()+" DAO..]");
		sql.setString(cmDto.getPurchaseDate());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 발주일자 :"+cmDto.getPurchaseDate()+" DAO..]");
		sql.setString(cmDto.getPurChk());
		log.debug("[계약관리 등록 테이블에 Insert 되는 데이터 발주일자 사용여부 :"+cmDto.getPurChk()+" DAO..]");
		
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
	 * CreateDate:2013-11-27(화) Writer:shbyeon.
	 * 계약관리 상세정보
	 * @param cmDto
	 * @return cmDto
	 * @throws DAOException
	 */
	public ListDTO invoiceDetailList(ContractManageDTO cmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = "{ CALL hp_InvoiceDetailList_CM (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(cmDto.getContractCode());

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
	 * CreateDate:2013-12-27(금) Writer:shbyeon.
	 * 계약관리 리스트(진행중인 건에 대해서만/프로젝트 코드 관리 팝업 조회 용도.)
	 * @param cmDto
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO contractMgPageList_Pop_Pj(ContractManageDTO cmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ContractMgInquiry ( ?,?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
	    sql.setString(cmDto.getChUserID()); 		//로그인 세션 ID
		sql.setString(cmDto.getvSearchType()); 		// 검색구분
		sql.setString(cmDto.getSearchGb2());
		sql.setString(cmDto.getvSearch()); 			// 검색어
		sql.setInteger(cmDto.getnRow()); 			// 리스트 갯수
		sql.setInteger(cmDto.getnPage()); 			// 현제 페이지
		sql.setString("PAGE"); 						// sp 구분

		try {
			retVal = broker.executePageProcedure(sql, cmDto.getnPage(),
					cmDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	
	
	/**
	 * CreateDate:2013-11-21(목) Writer:shbyeon.
	 * 미발행/미수 리스트
	 * @param cmDto
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO UnissuedNoCollectList(ContractManageDTO cmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_UnissuedNoCollect } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
/*	    sql.setString(cmDto.getChUserID()); 		//로그인 세션 ID
		sql.setString(cmDto.getvSearchType()); 		// 검색구분
		sql.setString(cmDto.getvSearch()); 			// 검색어
		sql.setInteger(cmDto.getnRow()); 			// 리스트 갯수
		sql.setInteger(cmDto.getnPage()); 			// 현제 페이지
		sql.setString("PAGE"); 						// sp 구분

		sql.setString(cmDto.ContractCode);
	*/	
		
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
	 * 영업지원->미발행 미수 Excel리스트.
	 * shbyeon. 2013_03_06(수)
	 * @param userDto
	 * 사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO UnissuedNoCollectExcelList() throws DAOException{
		
		String procedure = " { CALL hp_UnissuedNoCollect } ";
		
		ListDTO retVal = null;

		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
//		sql.setString("LIST"); // sp 구분

		sql.setSql(procedure);
		
		try{
			retVal=broker.executeListProcedure(sql);
			System.out.println("===============================dao]=============================================================");
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}			
		return retVal;
	}
	
}
