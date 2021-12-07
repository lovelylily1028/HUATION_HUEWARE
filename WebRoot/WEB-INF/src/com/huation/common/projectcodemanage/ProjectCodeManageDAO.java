package com.huation.common.projectcodemanage;

import java.sql.Connection;

import java.sql.SQLException;
import java.sql.ResultSet;

import java.io.Writer;
import java.io.BufferedWriter;
import java.sql.CallableStatement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Vector;
import java.util.concurrent.ExecutionException;

import sun.util.logging.resources.logging;

import com.huation.common.BaseDAO;
import com.huation.common.contractmanage.ContractManageDTO;
import com.huation.common.currentstatus.CurrentStatusDTO;
import com.huation.common.estimate.EstimateDTO;
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

public class ProjectCodeManageDAO extends AbstractDAO {

	/**
	 * CreateDate:2013-12-24(화) Writer:shbyeon.
	 * 프로젝트 조회 리스트
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public ListDTO projectCodeMgPageList_Search(ProjectCodeManageDTO pjMgDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ProjectCodeMgInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
	    sql.setString(pjMgDto.getChUserID()); 		//로그인 세션 ID
		sql.setString(pjMgDto.getvSearchType()); 	// 검색구분
		sql.setString(pjMgDto.getvSearch()); 		// 검색어
		sql.setInteger(pjMgDto.getnRow()); 			// 리스트 갯수
		sql.setInteger(pjMgDto.getnPage()); 		// 현제 페이지
		sql.setString("PAGE"); 						// sp 구분

		try {
			retVal = broker.executePageProcedure(sql, pjMgDto.getnPage(),
					pjMgDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	/**
	 * CreateDate:2014-01-26(일) Writer:shbyeon.
	 * 프로젝트 진행관리 리스트
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public ListDTO projectCodeMgPageList_Progress(ProjectCodeManageDTO pjMgDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ProjectCodeMgInquiry_Pg ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
	    sql.setString(pjMgDto.getChUserID()); 		//로그인 세션 ID
		sql.setString(pjMgDto.getvSearchType()); 	// 검색구분
		sql.setString(pjMgDto.getvSearch()); 		// 검색어
		sql.setInteger(pjMgDto.getnRow()); 			// 리스트 갯수
		sql.setInteger(pjMgDto.getnPage()); 		// 현제 페이지
		sql.setString("PAGE"); 						// sp 구분

		try {
			retVal = broker.executePageProcedure(sql, pjMgDto.getnPage(),
					pjMgDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	/**
	 * CreateDate:2013-12-24(화) Writer:shbyeon.
	 * 프로젝트 조회 리스트(Excel-Down)
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public ListDTO projectCodeMgPageList_Search_Excel(ProjectCodeManageDTO pjMgDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ProjectCodeMgInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
	    sql.setString(pjMgDto.getChUserID()); 		//로그인 세션 ID
		sql.setString(pjMgDto.getvSearchType()); 	// 검색구분
		sql.setString(pjMgDto.getvSearch()); 		// 검색어
		sql.setInteger(pjMgDto.getnRow()); 			// 리스트 갯수
		sql.setInteger(pjMgDto.getnPage()); 		// 현제 페이지
		sql.setString("LIST"); 						// sp 구분

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
	 * CreateDate:2013-12-24(화) Writer:shbyeon.
	 * 프로젝트 조회 리스트(Excel-Down)
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public ListDTO projectCodeMgPageList_Progress_Excel(ProjectCodeManageDTO pjMgDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ProjectCodeMgInquiry_Pg ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
	    sql.setString(pjMgDto.getChUserID()); 		//로그인 세션 ID
		sql.setString(pjMgDto.getvSearchType()); 	// 검색구분
		sql.setString(pjMgDto.getvSearch()); 		// 검색어
		sql.setInteger(pjMgDto.getnRow()); 			// 리스트 갯수
		sql.setInteger(pjMgDto.getnPage()); 		// 현제 페이지
		sql.setString("LIST"); 						// sp 구분

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
	 * CreateDate:2014-01-07(화) Writer:shbyeon.
	 * 모 프로젝트 조회 리스트
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public ListDTO p_ProjectCodeList(ProjectCodeManageDTO pjMgDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ProjectCodeMgInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
	    sql.setString(pjMgDto.getChUserID()); 		//로그인 세션 ID
		sql.setString(pjMgDto.getvSearchType()); 	// 검색구분
		sql.setString(pjMgDto.getvSearch()); 		// 검색어
		sql.setInteger(pjMgDto.getnRow()); 			// 리스트 갯수
		sql.setInteger(pjMgDto.getnPage()); 		// 현제 페이지
		sql.setString("PAGE"); 						// sp 구분

		try {
			retVal = broker.executePageProcedure(sql, pjMgDto.getnPage(),
					pjMgDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	/**
	 * CreateDate:2013-12-26(목) Writer:shbyeon.
	 * 프로젝트 코드 생성하기(MAX 값으로 Select 후 임시로 DB에 Insert(저장)시켜둔다.) 
	 * @param ProjectCode_CQ,UserID
	 * @return ProjectCode_Return
	 * @throws DAOException
	 */
	public String ProjectCodeCreate(String ProjectCode_CQ,String UserID) throws DAOException{

		String procedure = " { CALL hp_ProjectCodeMgCreate_Sel () } ";
		String ProjectCode_Return="";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();
		sql.setSql(procedure);

		try{

			ds=broker.executeProcedure(sql);
			
			if(ds.next()) {
				ProjectCode_Return=ds.getString("ProjectCode");
				log.debug("[프로젝트 코드 임시등록 ProjectCode(PJ--000000 MAX SELECT) => 새로 생성:"+ProjectCode_Return+" DAO..프로젝트 코드 임시등록]");
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
		return ProjectCode_Return;			
	}
	
	/**
	 * CreateDate:2014-01-08(수) Writer:shbyeon.
	 * 프로젝트 증설코드 생성하기
	 * @param project_code
	 * @return MoreCode_return
	 * @throws DAOException
	 */
	public String projectMoreCodeMgCreate(String project_code) throws DAOException{

		String procedure = " { CALL hp_ProjectMoreCodeMgCreate_Sel (?) } ";

		DataSet ds = null;
		String MoreCode_return = "";	//리턴하여 Action으로 보내줄 증설코드 값.
		QueryStatement sql = new QueryStatement();
		sql.setString(project_code);	//선택 한 모 프로젝트 코드
		sql.setSql(procedure);

		try{

			ds=broker.executeProcedure(sql);
			
			if(ds.next()) {
				MoreCode_return=ds.getString("MoreCode");	//해당 모프로젝트코드에 대한 증설코드 가져오기.
				log.debug("[모 프로젝트 코드 선택으로 인한 MoreCode(0001부터 +1 MAX SELECT 단, 동일 프로젝트 중복체크하여 증가시켜줌.) => 새로 생성:"+MoreCode_return+" DAO..모 프로젝트 코드 선택]");
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
		return MoreCode_return;			
	}

	/**
	 * CreateDate:2013-12-26(목) Writer:shbyeon.
	 * 프로젝트 코드 등록(프로젝트 코드 메뉴 등록하기.)  
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int projectCodeInsertData(ProjectCodeManageDTO pjMgDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ProjectCodeMgRegist (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(pjMgDto.getProjectCode());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 코드:"+pjMgDto.getProjectCode()+" DAO..]");
		sql.setString(pjMgDto.getProjectDivision());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 구분:"+pjMgDto.getProjectDivision()+" DAO..]");
		sql.setString(pjMgDto.getPurchaseDivision());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 발주사 구분:"+pjMgDto.getPurchaseDivision()+" DAO..]");
		sql.setString(pjMgDto.getP_ProjectCode());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 모 프로젝트 코드:"+pjMgDto.getP_ProjectCode()+" DAO..]");
		sql.setString(pjMgDto.getP_ProjectName());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 모 프로젝트 명:"+pjMgDto.getP_ProjectName()+" DAO..]");
		sql.setString(pjMgDto.getMoreCode());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 증설코드:"+pjMgDto.getMoreCode()+" DAO..]");
		sql.setString(pjMgDto.getPublic_No());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 견적번호:"+pjMgDto.getPublic_No()+" DAO..]");
		sql.setString(pjMgDto.getPub_ProjectName());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 선택된 견적번호 프로젝트명:"+pjMgDto.getPub_ProjectName()+" DAO..]");
		sql.setString(pjMgDto.getProjectName());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 명:"+pjMgDto.getProjectName()+" DAO..]");
		sql.setString(pjMgDto.getCustomerName());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 고객사 명:"+pjMgDto.getCustomerName()+" DAO..]");
		sql.setString(pjMgDto.getPurchaseName());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 발주사 명:"+pjMgDto.getPurchaseName()+" DAO..]");
		sql.setString(pjMgDto.getProjectStartDate());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 시작 예정일:"+pjMgDto.getProjectStartDate()+" DAO..]");
		sql.setString(pjMgDto.getProjectEndDate());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 종료 예정일:"+pjMgDto.getProjectEndDate()+" DAO..]");
		sql.setInteger(pjMgDto.getProjectProgressDate());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 진행기간:"+pjMgDto.getProjectProgressDate()+" DAO..]");
		sql.setString(pjMgDto.getChargeID());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 담당영업:"+pjMgDto.getChargeID()+" DAO..]");
		sql.setString(pjMgDto.getChargeProjectManager());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 담당PM :"+pjMgDto.getChargeProjectManager()+" DAO..]");
		sql.setString(pjMgDto.getChargeComent());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 영업 Comments :"+pjMgDto.getChargeComent()+" DAO..]");
		sql.setString(pjMgDto.getProjectCreateUser());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 코드 최초 생성자 :"+pjMgDto.getProjectCreateUser()+" DAO..]");
		sql.setString(pjMgDto.getContractCodeYN());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 코드 계약코드 사용여부 :"+pjMgDto.getContractCodeYN()+" DAO..]");
		sql.setString(pjMgDto.getProjectProgressFile());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 코드 프로젝트 진행문서 경로 :"+pjMgDto.getProjectProgressFile()+" DAO..]");
		sql.setString(pjMgDto.getProjectProgressFileNm());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 코드 프로젝트 진행문서 명 :"+pjMgDto.getProjectProgressFileNm()+" DAO..]");
		sql.setString(pjMgDto.getChargeNm());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 코드 담당영업 명 :"+pjMgDto.getChargeNm()+" DAO..]");
		sql.setString(pjMgDto.getChargePmNm());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 코드 담당PM 명 :"+pjMgDto.getChargePmNm()+" DAO..]");
		sql.setString(pjMgDto.getFreeCostYN());
		log.debug("[프로젝트 코드 등록 테이블에 Insert 되는 데이터 프로젝트 구분 유상,무상(Y,N) :"+pjMgDto.getFreeCostYN()+" DAO..]");
		
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
	 * CreateDate:2014-01-17(금) Writer:shbyeon.
	 * 프로젝트 코드 등록(계약코드 사용시 계약코드 데이타 배치 테이블에 등록하기.)  
	 * @param ProjectCode_Mp,ContractCode,Con_ProjectName,SortID
	 * @return retVal
	 * @throws DAOException
	 */
	public int projectCodeBatchInsertData(String ProjectCode_Mp, String[] ContractCode, String[] Con_ProjectName, String[] SortID) throws DAOException{
		
		String procedure = " { CALL hp_ProjectCodeMpRegist_Cm ( ?,?,?,? ) } ";
		
		int retVal = 0;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; ContractCode != null && i<ContractCode.length; i++){ 
				
				List batch=new Vector();

				batch.add(ProjectCode_Mp);
				batch.add(ContractCode[i]);
				batch.add(Con_ProjectName[i]);
				batch.add(SortID[i]);
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
	 * CreateDate:2014-01-25(토) Writer:shbyeon.
	 * 프로젝트 코드 등록(계약코드 수정 시 계약코드 데이타 배치 테이블에 재 등록하기.)  
	 * @param PjSeq_Mp,ProjectCode_Mp,ContractCode,Con_ProjectName,SortID
	 * @return retVal
	 * @throws DAOException
	 *
	 */
	public int projectCodeBatchDeleteData(ProjectCodeManageDTO PjMgDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ProjectCodeMpDelete_Cm (?) } "; //영업진행현황,견적서발행 상품코드삭제 공통 프로시저 사용.

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(PjMgDto.getPjSeq());

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
	 * CreateDate:2014-01-25(토) Writer:shbyeon.
	 * 프로젝트 코드 등록(계약코드 수정 시 계약코드 데이타 배치 테이블에 재 등록하기.)  
	 * @param PjSeq_Mp,ProjectCode_Mp,ContractCode,Con_ProjectName,SortID
	 * @return retVal
	 * @throws DAOException
	 */
	public int projectCodeBatchUpdateData(int PjSeq_Mp,String ProjectCode_Mp, String[] ContractCode, String[] Con_ProjectName, String[] SortID) throws DAOException{
		
		String procedure = " { CALL hp_ProjectCodeMpUpdate_Cm (?,?,?,?,? ) } ";
		
		int retVal = 0;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; ContractCode != null && i<ContractCode.length; i++){ 
				
				List batch=new Vector();
				batch.add(PjSeq_Mp);
				batch.add(ProjectCode_Mp);
				batch.add(ContractCode[i]);
				batch.add(Con_ProjectName[i]);
				batch.add(SortID[i]);
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
	 * CreateDate:2014-01-19(목) Writer:shbyeon.
	 * 프로젝트코드 상세정보
	 * @param pjMgDto
	 * @return pjMgDto
	 * @throws DAOException
	 */
	public ProjectCodeManageDTO projectCodeMgView(ProjectCodeManageDTO pjMgDto) throws DAOException {

		String procedure = "{ CALL hp_ProjectCodeMgSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(pjMgDto.getPjSeq());

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				pjMgDto = new ProjectCodeManageDTO();
				pjMgDto.setPjSeq(ds.getInt("PjSeq"));
				pjMgDto.setProjectCode(ds.getString("ProjectCode"));
				pjMgDto.setProjectDivision(ds.getString("ProjectDivision"));
				pjMgDto.setPurchaseDivision(ds.getString("PurchaseDivision"));
				pjMgDto.setP_ProjectCode(ds.getString("P_ProjectCode"));
				pjMgDto.setP_ProjectName(ds.getString("P_ProjectName"));
				pjMgDto.setMoreCode(ds.getString("MoreCode"));
				pjMgDto.setPublic_No(ds.getString("Public_No"));
				pjMgDto.setPub_ProjectName(ds.getString("Pub_ProjectName"));
				pjMgDto.setProjectName(ds.getString("ProjectName"));
				pjMgDto.setCustomerName(ds.getString("CustomerName"));
				pjMgDto.setPurchaseName(ds.getString("PurchaseName"));
				pjMgDto.setProjectStartDate(ds.getString("ProjectStartDate"));
				pjMgDto.setProjectEndDate(ds.getString("ProjectEndDate"));
				pjMgDto.setProjectProgressDate(ds.getInt("ProjectProgressDate"));
				pjMgDto.setChargeID(ds.getString("ChargeID"));
				pjMgDto.setChargeNm(ds.getString("ChargeNm"));
				pjMgDto.setChargeProjectManager(ds.getString("ChargeProjectManager"));
				pjMgDto.setChargePmNm(ds.getString("ChargePmNm"));
				pjMgDto.setChargeComent(ds.getString("ChargeComent"));
				pjMgDto.setContractCodeYN(ds.getString("ContractCodeYN"));
				pjMgDto.setProgressPercent(ds.getInt("ProgressPercent"));
				pjMgDto.setCheckSuccessYN(ds.getString("CheckSuccessYN"));
				pjMgDto.setCheckDocumentFile(ds.getString("CheckDocumentFile"));
				pjMgDto.setCheckDocumentFileNm(ds.getString("CheckDocumentFileNm"));
				pjMgDto.setProjectEndYN(ds.getString("ProjectEndYN"));
				pjMgDto.setProjectEndDocumentFile(ds.getString("ProjectEndDocumentFile"));
				pjMgDto.setProjectEndDocumentFileNm(ds.getString("ProjectEndDocumentFileNm"));
				pjMgDto.setProjectProgressFile(ds.getString("ProjectProgressFile"));
				pjMgDto.setProjectProgressFileNm(ds.getString("ProjectProgressFileNm"));
				pjMgDto.setChargeNm(ds.getString("ChargeNm"));
				pjMgDto.setChargePmNm(ds.getString("ChargePmNm"));
				pjMgDto.setFreeCostYN(ds.getString("FreeCostYN"));
				

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

		return pjMgDto; 
	}
	
	/**
	 * CreateDate:2014-01-19(목) Writer:shbyeon.
	 * 프로젝트코드 상세정보(계약코드 사용 시 매핑 테이블에 있는 계약코드 데이타 Select 해옴)
	 * @param pjMgDto,pjMgDto_Cm
	 * @return arrDataList
	 * @throws DAOException
	 */
	public ArrayList getArrDataList(ProjectCodeManageDTO pjMgDto) throws DAOException{
		
		 String procedure = "{ CALL hp_ProjectCodeMpSelect_Cm (?) }";
	     ArrayList  arrDataList = null;
	     DataSet rs = null;
		 QueryStatement sql = new QueryStatement();
		 
		 sql.setSql(procedure);
		 sql.setInteger(pjMgDto.getPjSeq());
	
		 try{
			 rs = broker.executeQuery(sql);
			 arrDataList = new ArrayList();
			 while(rs.next()){
				 log.debug("계약코드 정보 Select While Start.. DAO");
				 ProjectCodeManageDTO pjMgDto_Cm = new ProjectCodeManageDTO();		//계약코드 가져올 DTO
				 pjMgDto_Cm.setPjSeq(rs.getInt("PjSeq"));							//프로젝트(계약코드) PK 시퀀스
				 pjMgDto_Cm.setProjectCode(rs.getString("ProjectCode"));    		//프로젝트 코드
				 pjMgDto_Cm.setContractCode(rs.getString("ContractCode")); 			//계약코드
				 pjMgDto_Cm.setCon_ProjectName(rs.getString("Con_ProjectName")); 	//선택된 계약코드 프로젝트명
				 pjMgDto_Cm.setSortID(rs.getString("SortID")); 						//계약코드 정렬순서

				 log.debug("[프로젝트 코드 상세정보  ContractCode=("+rs.getString("ContractCode")+")Data List Count..DAO");
				 arrDataList.add(pjMgDto_Cm);
				 log.debug("계약코드 정보 Select While End.. DAO");
			 }
			 rs.close();
		 }catch(Exception e){
			 throw new DAOException(e.getMessage());
		 }finally{
			 try{ 
			  if(rs != null) rs.close();
			 }catch(Exception e){
				throw new DAOException(e.getMessage());
			 }
		 }	

		 return arrDataList;   
	}
	
	/**
	 * CreateDate:2013-12-26(목) Writer:shbyeon.
	 * 프로젝트 코드 등록(프로젝트 코드 메뉴 등록하기.)  
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int projectCodeUpdateData(ProjectCodeManageDTO pjMgDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ProjectCodeMgModify (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(pjMgDto.getPjSeq());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 PK 프로젝트 시퀀스 PK:"+pjMgDto.getPjSeq()+" DAO..]");
		sql.setString(pjMgDto.getProjectCode());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 코드:"+pjMgDto.getProjectCode()+" DAO..]");
		sql.setString(pjMgDto.getProjectDivision());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 구분:"+pjMgDto.getProjectDivision()+" DAO..]");
		sql.setString(pjMgDto.getPurchaseDivision());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 발주사 구분:"+pjMgDto.getPurchaseDivision()+" DAO..]");
		sql.setString(pjMgDto.getP_ProjectCode());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 모 프로젝트 코드:"+pjMgDto.getP_ProjectCode()+" DAO..]");
		sql.setString(pjMgDto.getP_ProjectName());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 모 프로젝트 명:"+pjMgDto.getP_ProjectName()+" DAO..]");
		sql.setString(pjMgDto.getMoreCode());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 증설코드:"+pjMgDto.getMoreCode()+" DAO..]");
		sql.setString(pjMgDto.getPublic_No());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 견적번호:"+pjMgDto.getPublic_No()+" DAO..]");
		sql.setString(pjMgDto.getPub_ProjectName());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 선택된 견적번호 프로젝트명:"+pjMgDto.getPub_ProjectName()+" DAO..]");
		sql.setString(pjMgDto.getProjectName());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 명:"+pjMgDto.getProjectName()+" DAO..]");
		sql.setString(pjMgDto.getCustomerName());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 고객사 명:"+pjMgDto.getCustomerName()+" DAO..]");
		sql.setString(pjMgDto.getPurchaseName());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 발주사 명:"+pjMgDto.getPurchaseName()+" DAO..]");
		sql.setString(pjMgDto.getProjectStartDate());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 시작 예정일:"+pjMgDto.getProjectStartDate()+" DAO..]");
		sql.setString(pjMgDto.getProjectEndDate());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 종료 예정일:"+pjMgDto.getProjectEndDate()+" DAO..]");
		sql.setInteger(pjMgDto.getProjectProgressDate());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 진행기간:"+pjMgDto.getProjectProgressDate()+" DAO..]");
		sql.setString(pjMgDto.getChargeID());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 담당영업:"+pjMgDto.getChargeID()+" DAO..]");
		sql.setString(pjMgDto.getChargeProjectManager());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 담당PM :"+pjMgDto.getChargeProjectManager()+" DAO..]");
		sql.setString(pjMgDto.getChargeComent());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 영업 Comments :"+pjMgDto.getChargeComent()+" DAO..]");
		sql.setString(pjMgDto.getProjectUpdateUser());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 코드 최초 생성자 :"+pjMgDto.getProjectUpdateUser()+" DAO..]");
		sql.setString(pjMgDto.getContractCodeYN());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 코드 계약코드 사용여부 :"+pjMgDto.getContractCodeYN()+" DAO..]");
		sql.setString(pjMgDto.getProjectProgressFile());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 진행문서경로 :"+pjMgDto.getProjectProgressFile()+" DAO..]");
		sql.setString(pjMgDto.getProjectProgressFileNm());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 진행문서 명 :"+pjMgDto.getProjectProgressFileNm()+" DAO..]");
		sql.setString(pjMgDto.getChargeNm());
		log.debug("[프로젝트 코드 등록 테이블에 Update 되는 데이터 프로젝트 코드 담당영업 명 :"+pjMgDto.getChargeNm()+" DAO..]");
		sql.setString(pjMgDto.getChargePmNm());
		log.debug("[프로젝트 코드 등록 테이블에 Update 되는 데이터 프로젝트 코드 담당PM 명 :"+pjMgDto.getChargePmNm()+" DAO..]");
		sql.setString(pjMgDto.getFreeCostYN());
		log.debug("[프로젝트 코드 등록 테이블에 Update 되는 데이터 프로젝트 구분 (유상,무상)여부 :"+pjMgDto.getFreeCostYN()+" DAO..]");
		
		
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
	 * CreateDate:2013-12-26(목) Writer:shbyeon.
	 * 프로젝트 코드 등록(프로젝트 코드 메뉴 등록하기.)  
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int projectProgressUpdateData(ProjectCodeManageDTO pjMgDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ProjectCodeMgModify_Pg (?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(pjMgDto.getPjSeq());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 PK 프로젝트 시퀀스 PK:"+pjMgDto.getPjSeq()+" DAO..]");
		sql.setString(pjMgDto.getProjectEndDate());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 종료 예정일:"+pjMgDto.getProjectEndDate()+" DAO..]");
		sql.setInteger(pjMgDto.getProjectProgressDate());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 진행기간:"+pjMgDto.getProjectProgressDate()+" DAO..]");
		sql.setString(pjMgDto.getChargeProjectManager());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 담당PM :"+pjMgDto.getChargeProjectManager()+" DAO..]");
		sql.setString(pjMgDto.getProjectUpdateUser());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 코드 최초 생성자 :"+pjMgDto.getProjectUpdateUser()+" DAO..]");
		sql.setInteger(pjMgDto.getProgressPercent());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 진행률 :"+pjMgDto.getProgressPercent()+" DAO..]");
		sql.setString(pjMgDto.getCheckSuccessYN());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 검수완료여부 :"+pjMgDto.getCheckSuccessYN()+" DAO..]");
		sql.setString(pjMgDto.getCheckDocumentFile());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 검수증빙문서경로 :"+pjMgDto.getCheckDocumentFile()+" DAO..]");
		sql.setString(pjMgDto.getCheckDocumentFileNm());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 검수증빙문서명 :"+pjMgDto.getCheckDocumentFileNm()+" DAO..]");
		sql.setString(pjMgDto.getProjectEndYN());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트종료여부 :"+pjMgDto.getProjectEndYN()+" DAO..]");
		sql.setString(pjMgDto.getProjectEndDocumentFile());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 최종산출물 경로 :"+pjMgDto.getProjectEndDocumentFile()+" DAO..]");
		sql.setString(pjMgDto.getProjectEndDocumentFileNm());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 최종산출물 명 :"+pjMgDto.getProjectEndDocumentFileNm()+" DAO..]");
		sql.setString(pjMgDto.getChargePmNm());
		log.debug("[프로젝트 코드 수정 테이블에 Update 되는 데이터 프로젝트 담당PM명 :"+pjMgDto.getChargePmNm()+" DAO..]");
		
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
}
