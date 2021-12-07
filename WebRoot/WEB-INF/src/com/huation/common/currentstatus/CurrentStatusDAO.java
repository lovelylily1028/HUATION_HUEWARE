package com.huation.common.currentstatus;

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
import com.huation.common.ComCodeDTO;
import com.huation.common.bankmanage.BankManageDTO;
import com.huation.common.config.AuthDTO;
import com.huation.common.config.MenuDTO;
import com.huation.common.estimate.EstimateDTO;
import com.huation.common.freeboard.FreeBoardDTO;
import com.huation.common.huebooklist.HueBookListDTO;
import com.huation.common.currentstatus.CurrentStatusDTO;
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
import com.sun.org.apache.bcel.internal.generic.GETSTATIC;

import org.apache.log4j.Logger;

public class CurrentStatusDAO extends AbstractDAO {

	
	
	/*
	 * 2013_03_12(화) shbyeon.
	 * 영업지원 - > 영업진행현황 SalesCode 가져오기.
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
	
	
	/*
	 * 2013_03_12(화) shbyeon.
	 * 영업지원 - > 영업진행현황 등록 
	 */  
	public int addcurrentRegist(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;
 
		String procedure = " { CALL hp_CurrentStatusRegist (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(csDto.getPreSalesCode());
		sql.setInteger(csDto.getQuarter());
		sql.setString(csDto.getEnterpriseCode());
		sql.setString(csDto.getPermitNo());
		sql.setString(csDto.getEnterpriseNm());
		sql.setString(csDto.getOperatingCompany());
		sql.setString(csDto.getSalesMan());
		sql.setString(csDto.getSalesManTel());
		sql.setString(csDto.getProjectName());
		sql.setString(csDto.getSalesProjections());
		sql.setString(csDto.getOrderble());
		sql.setString(csDto.getChargeID());
		sql.setString(csDto.getChargeSecondID());
		sql.setString(csDto.getAssignPerson());
		sql.setString(csDto.getDateProjections());
		sql.setString(csDto.getWriteUser());
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
	 * 2013_11_04(월) shbyeon.
	 * 영업지원 - > 영업진행현황 등록 (견적서 즉시발행 용도)
	 */  
	public int addcurrentRegist_EST(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;
 
		String procedure = " { CALL hp_CurrentStatusRegist_EST (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(csDto.getPreSalesCode());
		sql.setInteger(csDto.getQuarter());
		sql.setString(csDto.getEnterpriseCode());
		sql.setString(csDto.getPermitNo());
		sql.setString(csDto.getEnterpriseNm());
		sql.setString(csDto.getOperatingCompany());
		sql.setString(csDto.getSalesMan());
		sql.setString(csDto.getSalesManTel());
		sql.setString(csDto.getProjectName());
		sql.setString(csDto.getSalesProjections());
		sql.setString(csDto.getOrderble());
		sql.setString(csDto.getChargeID());
		sql.setString(csDto.getChargeSecondID());
		sql.setString(csDto.getAssignPerson());
		sql.setString(csDto.getDateProjections());
		sql.setString(csDto.getWriteUser());
		sql.setString(csDto.getPublicNo());
		sql.setString(csDto.getSalesFile_Xls());
		sql.setString(csDto.getSalesFileNm_Xls());
		sql.setString(csDto.getSalesFile_Pdf());
		sql.setString(csDto.getSalesFileNm_Pdf());
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
	 * 2013_03_14(목) shbyeon.
	 * 영업지원->영업진행현황 상품코드 등록(배치 등록)
	 * @throws DAOException
	 */	
	public int addproductCode(String[] ProductCode) throws DAOException{
		
		String procedure = " { CALL hp_productCodeRegist ( ? ) } ";
		
		int retVal = 0;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; ProductCode != null && i<ProductCode.length; i++){ 
				
				List batch=new Vector();


				batch.add(ProductCode[i]); //사용자 아이디
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
	 * 2013_03_14(목) shbyeon.
	 * 영업지원->영업진행현황 상품코드 등록(배치 수정)
	 * @throws DAOException
	 */	
	public int upDateproductCode(String[] ProductCode, String ProductPk, String ProductMappingPk) throws DAOException{
		
		String procedure = " { CALL hp_productCodeUpdate ( ?,?,? ) } ";
		
		int retVal = 0;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; ProductCode != null && i<ProductCode.length; i++){ 
				
				List batch=new Vector();

				
				batch.add(ProductPk);/*영업진행현황코드*/
				batch.add(ProductCode[i]);/*상품코드*/
				batch.add(ProductMappingPk);/*견적서발행번호*/
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
	 * 2013_03_14(목) shbyeon.
	 * 영업지원->견적서 최초 발행으로 상품코드 등록
	 * Description : 견적서 최초발행,모발행,영업진행현황 최초발행,즉시발행 공통사용 됨.
	 * @throws DAOException
	 */	
	public int addproductCode_EST(String[] ProductCode, String ProductPk, String ProductPkMapping) throws DAOException{
		
		System.out.println("=============================================견적서 발행 여기로 들어옴 ");
		String procedure = " { CALL hp_productCodeUpdate_EST ( ?,?,? ) } ";
		
		int retVal = 0;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; ProductCode != null && i<ProductCode.length; i++){ 
				
				List batch=new Vector();

				
				batch.add(ProductPk);
				batch.add(ProductCode[i]);
				batch.add(ProductPkMapping);
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
	
	/*
	 * 2013_03_26(화)shbyeon.
	 * 업체명 중복체크(영업진행현황)
	 */
	public String compNameCheck(CurrentStatusDTO csDto) throws DAOException{

		String procedure = " { CALL hp_CompanyNmDuplicateCs ( ? , ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setString("DUPLICATE");			//SP구분
		sql.setString(csDto.getEnterpriseNm());		//업체명 아이디

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
	
	/*
	 * 2013_04_07(토)
	 * 영업진행현황 = > 이슈코멘트 등록처리.
	 */
	public int addCommentRegist(CurrentStatusDTO csDto) throws DAOException {

		int commentpk = 0;
		DataSet ds = null;
 
		String procedure = " { CALL hp_CurrentComentRegist (?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(csDto.getProjectPkCo()); //코멘트 pk
		System.out.println("ProjectPkComent:"+csDto.getProjectPkCo());
		sql.setString(csDto.getSalesMan_co());  //고객사
		sql.setString(csDto.getChargeID_co());  //담당영업
		sql.setString(csDto.getContents()); 	//코멘트내용
		sql.setString(csDto.getSalesFile()); 	//
		sql.setString(csDto.getSalesFileNm()); 	//
		try {

			ds = broker.executeProcedure(sql);
			 
			if (ds.next()) {
				commentpk =  ds.getInt("ComentPk");
			}

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		} finally {
		}
		return commentpk;

	}

	/**
	 * 영업지원->영업진행현황 리스트.
	 * shbyeon. 2013_02_27(수)
	 * @param userDto
	 * 사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO CurrentStatusList(CurrentStatusDTO csDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_CurrentStatusInquiry ( ?,?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(csDto.getvSearchYear()); // 검색구분(년도)
		sql.setString(csDto.getvSearchType()); // 검색구분(영업상태)
		sql.setString(csDto.getvSearchType2()); // 검색구분(목록)
		sql.setString(csDto.getvSearch()); // 검색어
		sql.setInteger(csDto.getnRow()); // 리스트 갯수 사용x
		sql.setInteger(csDto.getnPage()); // 현제 페이지 사용x
		sql.setString("LIST"); // sp 구분

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
	 * 영업지원->영업진행현황 Excel리스트.
	 * shbyeon. 2013_03_06(수)
	 * @param userDto
	 * 사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO currentListExcel(CurrentStatusDTO csDto) throws DAOException{
		
		String procedure = " { CALL hp_CurrentStatusInquiry ( ?,?,?,?,?,?,? ) } ";
		
		ListDTO retVal = null;

		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setString(csDto.getvSearchYear()); // 검색구분(년도)
		sql.setString(csDto.getvSearchType()); // 검색구분(영업상태)
		sql.setString(csDto.getvSearchType2()); // 검색구분(목록)
		sql.setString(csDto.getvSearch()); // 검색어
		sql.setInteger(csDto.getnRow()); // 리스트 갯수 사용x
		sql.setInteger(csDto.getnPage()); // 현제 페이지 사용x
		sql.setString("LIST"); // sp 구분

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
	 * 영업지원->영업진행현황 상품코드 리스트.
	 * 2013_04_06(금) shbyeon.
	 *
	 */
	public ArrayList getproductViewList(CurrentStatusDTO csDtoPro) throws DAOException{
	     ArrayList  productList = null;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select A.ProductCode,B.CD_NM as ProductName "); 
		 sb.append(" from htSalesProductCode A  ");
		 sb.append(" left join T_CODE B on B.BIG_CD = A.ProductCode ");
		 sb.append(" where ProductPk = ? and EstimateUpdate = 'N' ");
		 sql.setString(csDtoPro.getPreSalesCode());
		 log.debug("[영업진행현황 상세정보  SC_CODE=SQL_SET("+csDtoPro.getPreSalesCode()+") DAO..");
		 sb.append(" order by CreateDateTime asc ");
		 sql.setSql(sb.toString());
	
		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 productList = new ArrayList();
			 while(rs.next()){
				 csDtoPro = new CurrentStatusDTO();
				 csDtoPro.setProductPk(rs.getString("ProductPk"));
				 csDtoPro.setProductCode(rs.getString("ProductCode"));
				 csDtoPro.setProductName(rs.getString("ProductName"));
				 log.debug("[영업진행현황 상세정보 선택된 PRODUCT_CODE=RS_GET ProductList=("+rs.getString("ProductCode")+") 맞는 상품코드 Batch List 가져옴. DAO..");
				 productList.add(csDtoPro);
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

		 return productList;   
	}
	
	/**
	 * 영업지원->(견적서발행) 상품코드 리스트.
	 * 2013_04_29(월) shbyeon.
	 *
	 */
	public ArrayList getproductViewList_EST(EstimateDTO estimateDto) throws DAOException{
	     ArrayList  productList = null;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select A.ProductCode, B.CD_NM as ProductName "); 
		 sb.append(" from htSalesProductCode A ");
		 sb.append(" left join T_CODE B on B.BIG_CD = A.ProductCode ");
		 sb.append(" where ProductMappingPk = ? and EstimateUpdate = 'Y' ");
		 sql.setString(estimateDto.getPublic_no()); //견적서 발행의 PreSalesCode 셋팅.
		 log.debug("[견적서 발행 상세정보  PUBLIC_NO=SQL_SET("+estimateDto.getPublic_no()+") DAO..");
		 sb.append(" order by CreateDateTime asc ");
		 sql.setSql(sb.toString());
	

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 productList = new ArrayList();
			 while(rs.next()){
				 CurrentStatusDTO  csDtoPro = new CurrentStatusDTO(); //견적서 발행에 상세정보의 상품코드를 꺼내올 용도로 사용한 DTO
				 csDtoPro.setProductPk(rs.getString("ProductMappingPk"));    //영업진행현황 DTO사용한 것. 별도의 DTO생성을 줄이기 위함.
				 //dto 내일 맞게끔 변경 할것 매핑 PK DTO 생성해주기!
				 csDtoPro.setProductCode(rs.getString("ProductCode")); //상품 코드
				 log.debug("[견적서 발행 상세정보 선택된 PRODUCT_CODE=RS_GET ProductList=("+rs.getString("ProductCode")+") 맞는 상품코드 Batch List 가져옴. DAO..");
				 csDtoPro.setProductName(rs.getString("ProductName")); //상품 명
				 productList.add(csDtoPro);
				 System.out.println("견적서발행 상품리스트2");
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

		 return productList;   
	}
	
	/**
	 * 영업지원->(견적서발행==영업진행현황) 상품코드 리스트.
	 * 2013_11_11(월) shbyeon.
	 * description:연동 처리부분 변경됨.
	 * 기존에는 견적서 상품코드 데이터 , 영업진행현황 상품코드 데이터 별도로 구분하여 관리하였으나,
	 * 영업진행현황으로 견적서 발행 하였을 경우 및 즉시발행하였을 경우 계약이 성사되었을 경우
	 * 상품코드를 견적서와 동일하게 매핑 시켜줘야 하므로 추가됨.
	 *
	 */
	public ArrayList getproductViewList_EST_SC(CurrentStatusDTO csDtoPro) throws DAOException{
	     ArrayList  productList = null;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select A.ProductCode, B.CD_NM as ProductName "); 
		 sb.append(" from htSalesProductCode A ");
		 sb.append(" left join T_CODE B on B.BIG_CD = A.ProductCode ");
		 sb.append(" where productPk=? and ProductMappingPk = ? and EstimateUpdate = 'Y' ");
		 log.debug("test::::"+csDtoPro.getPreSalesCode());
		 sql.setString(csDtoPro.getPreSalesCode()); //견적서 발행의 PreSalesCode 셋팅.
		 sql.setString(csDtoPro.getPublicNo()); //견적서 발행의 PublicNo 셋팅.
		 sb.append(" order by CreateDateTime asc ");
		 sql.setSql(sb.toString());
	

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 productList = new ArrayList();
			 while(rs.next()){
				 csDtoPro = new CurrentStatusDTO(); //견적서 발행에 상세정보의 상품코드를 꺼내올 용도로 사용한 DTO
				 csDtoPro.setProductPk(rs.getString("ProductMappingPk"));    //영업진행현황 DTO사용한 것. 별도의 DTO생성을 줄이기 위함.
				 //dto 내일 맞게끔 변경 할것 매핑 PK DTO 생성해주기!
				 csDtoPro.setProductCode(rs.getString("ProductCode")); //상품 코드
				 //System.out.println("DAO PRO:"+rs.getString("ProductCode"));
				 csDtoPro.setProductName(rs.getString("ProductName")); //상품 명
				 productList.add(csDtoPro);
				 System.out.println("영업진행현황 조회로 견적서 발행하였을 경우의 상품코드 리스트");
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

		 return productList;   
	}
	
	/**
	 * 영업지원->영업진행현황 조회 상품코드 리스트(견적서 최초 발행서 용)
	 * 영업진행현황 조회로 최초발행할 영업진행현황 pk에 대한 상품코드 가져오기. 코드명
	 * 견적서 발행 때 영업진행현황으로 초기에 조회 하였을 경우 가져올 상품코드
	 * 2013_04_24(수)shbyeon.
	 *
	 */
	public String getproductViewListEsT_pop(CurrentStatusDTO csDtoPro) throws DAOException{
	     String  productStr = ""; //상품코드 String 합쳐서 구분자(|,+)줘서 담을 변수
	     int x = 1; //상품코드 ++ 갯수 변수
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select A.ProductCode, B.CD_NM as ProductName "); 
		 sb.append(" from htSalesProductCode A");
		 sb.append(" left join T_CODE B on B.BIG_CD = A.ProductCode ");
		 sb.append(" where ProductPk = ? and ProductMappingPk = ? ");
		 sql.setString(csDtoPro.getProductPk());
		 log.debug("[견적서 발행에서 영업진행현황 조회 Start DAO..");
		 log.debug("[영업진행현황 조회 팝업으로 선택한 SC_CODE["+csDtoPro.getProductPk()+"] DAO..견적서 => 영업진행현황 조회");
		 sql.setString(csDtoPro.getPublicNo());
		 log.debug("[영업진행현황 조회 팝업으로 선택한 PUBLIC_NO["+csDtoPro.getPublicNo()+"] DAO..견적서 => 영업진행현황 조회");
		 sb.append(" order by CreateDateTime asc ");
		 sql.setSql(sb.toString());
	

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 while(rs.next()){
				 
				 //csDtoPro = new CurrentStatusDTO();
				 //csDtoPro.setProductPk(rs.getString("ProductPk"));
				 //csDtoPro.setProductCode(rs.getString("ProductCode"));
				 //System.out.println("DAO PRO:"+rs.getString("ProductCode"));
				if(x == 1){
					 //상품코드가 하나일때 ProductCode 와 join으로 가져온 ProductName 을 String 으로 합친다.
					 //jsp단에서 split으로 구분자(|)로 잘라서 비교하기위해.
					 //DB에 데이터 넣을때는 ProductCode넣고 JSP WEB단에서 보여질때는 ProductName 보여지기위해 
					 //String 으로 구분자를 넣어서 합쳐준다.
					 productStr += rs.getString("ProductCode")+"|"+rs.getString("ProductName");
					 //System.out.println(productStr);
					 //System.out.println("한개일때 합친거:"+productStr);
				 }else{
					 //상품코드가 하나이상일때 ProductCode 와 join으로 가져온 ProductName 을 String 합친다.
					 //jsp단에서 split으로 구분자(+,|)로 잘라서 비교하기위해.
					 //DB에 데이터 넣을때는 ProductCode넣고 JSP WEB단에서 보여질때는 ProductName 보여지기위해 
					 //String 으로 구분자를 넣어서 합쳐준다.단 한개 이상일때는 구분자(+)로 한번더 구분해 준다.
					 productStr += "+"+rs.getString("ProductCode")+"|"+rs.getString("ProductName");
					 //System.out.println("두개일때 합친거:"+productStr);
					 //System.out.println(productStr);
				 }
				 x++;
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
		 //productStr = "HUEFAX|0001+HUERES|0002"; //상품코드 데이터 1개 이상인 2개인 경우를 나타내기 위해 표현한 주석.
		 //System.out.println("productstr Sum:"+productStr);
		 return productStr;   
	}
	
	
	
	
	/**
	 * 영업지원->영업진행현황 상품코드 리스트(견적서 발행사용)
	 * 영업진행현황 조회로 최초발행할 영업진행현황 pk에 대한 상품코드 가져오기. 코드명
	 * 견적서발행에서 모발행번호로 가져오는 견적서이면서 , 영업진행현황으로 견적서 발행하였던 모발행번호 상품코드 가져오기 코드명.
	 * 2013_04_24(수)shbyeon.
	 *
	 */
	public String getproductViewListEsT_pop2(CurrentStatusDTO csDtoPro) throws DAOException{
	     String  productStr = ""; //상품코드 String 합쳐서 구분자(|,+)줘서 담을 변수
	     int x = 1; //상품코드 ++ 갯수 변수
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select A.ProductCode, B.CD_NM as ProductName "); 
		 sb.append(" from htSalesProductCode A");
		 sb.append(" left join T_CODE B on B.BIG_CD = A.ProductCode ");
		 sb.append(" where ProductMappingPk = ? and EstimateUpdate = 'Y' ");
		 sql.setString(csDtoPro.getProductPk());
		 System.out.println("DAO_PK:"+csDtoPro.getProductPk());
		 sb.append(" order by CreateDateTime asc ");
		 sql.setSql(sb.toString());
		 System.out.println("견적서발행에서 영업진행현황 조회 할때사용되는 상품코드리스트2");
	

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 while(rs.next()){
				 
				 //csDtoPro = new CurrentStatusDTO();
				 //csDtoPro.setProductPk(rs.getString("ProductPk"));
				 //csDtoPro.setProductCode(rs.getString("ProductCode"));
				 //System.out.println("DAO PRO:"+rs.getString("ProductCode"));
				if(x == 1){
					 //상품코드가 하나일때 ProductCode 와 join으로 가져온 ProductName 을 String 으로 합친다.
					 //jsp단에서 split으로 구분자(|)로 잘라서 비교하기위해.
					 //DB에 데이터 넣을때는 ProductCode넣고 JSP WEB단에서 보여질때는 ProductName 보여지기위해 
					 //String 으로 구분자를 넣어서 합쳐준다.
					 productStr += rs.getString("ProductCode")+"|"+rs.getString("ProductName");
					 //System.out.println("한개일때 합친거:"+productStr);
				 }else{
					 //상품코드가 하나이상일때 ProductCode 와 join으로 가져온 ProductName 을 String 합친다.
					 //jsp단에서 split으로 구분자(+,|)로 잘라서 비교하기위해.
					 //DB에 데이터 넣을때는 ProductCode넣고 JSP WEB단에서 보여질때는 ProductName 보여지기위해 
					 //String 으로 구분자를 넣어서 합쳐준다.단 한개 이상일때는 구분자(+)로 한번더 구분해 준다.
					 productStr += "+"+rs.getString("ProductCode")+"|"+rs.getString("ProductName");
					 //System.out.println("두개일때 합친거:"+productStr);
				 }
				 x++;
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
		 //productStr = "HUEFAX|0001+HUERES|0002"; //상품코드 데이터 1개 이상인 2개인 경우를 나타내기 위해 표현한 주석.
		 //System.out.println("productstr Sum:"+productStr);
		 return productStr;   
	}
	
	/**
	 * 영업지원->영업진행현황 상품코드 리스트(견적서 발행사용)
	 * 영업진행현황 조회로 최초발행할 영업진행현황 pk에 대한 상품코드 가져오기. 이름명
	 * 2013_04_24(수)shbyeon.
	 *
	public String getproductViewListEsT_pop_Nm(CurrentStatusDTO csDtoPro) throws DAOException{
	     String  productStrNm = "";
	     int x = 1;
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select A.ProductCode,B.CD_NM as ProductName "); 
		 sb.append(" from htSalesProductCode A");
		 sb.append(" left join T_CODE B on B.BIG_CD = A.ProductCode ");
		 sb.append(" where ProductPk = ? ");
		 sql.setString(csDtoPro.getProductPk());
		 //System.out.println("DAO_PK:"+csDtoPro.getProductPk());
		 sb.append(" order by CreateDateTime desc ");
		 sql.setSql(sb.toString());
	

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 while(rs.next()){
				 
				 //csDtoPro = new CurrentStatusDTO();
				 //csDtoPro.setProductPk(rs.getString("ProductPk"));
				 //csDtoPro.setProductCode(rs.getString("ProductCode"));
				 //System.out.println("DAO PRO:"+rs.getString("ProductCode"));
				if(x == 1){
					 productStrNm += rs.getString("ProductName");
					// System.out.println("합친거1:"+productStr);
				 }else{
					 productStrNm += "|"+rs.getString("ProductName");
					// System.out.println("합친거2:"+productStr);
				 }
				 x++;
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

		 return productStrNm;   
	}
	 */
	
	
	/**
	 * 2013_04_08(월) shbyeon.
	 * 영업진행현황 코멘트 리스트.
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO currentListComment(CurrentStatusDTO csDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_CurrentComentInquiry ( ?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(csDto.getProjectPkCo());
		sql.setInteger(csDto.getnRow()); // 리스트 갯수
		sql.setInteger(csDto.getnPage()); // 현제 페이지
		sql.setString("LIST"); // sp 구분

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
	 * 2013_04_06(금)shbyeon.
	 * 영업진행현황 상세보기.
	 */
	public CurrentStatusDTO currentView(CurrentStatusDTO csDto) throws DAOException {

		String procedure = "{ CALL hp_CurrentStatusSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(csDto.getPreSalesCode());
		 
		try {

			ds = broker.executeProcedure(sql);
 
			while (ds.next()) {
				csDto = new CurrentStatusDTO();
				csDto.setPreSalesCode(ds.getString("PreSalesCode"));
				csDto.setEnterpriseCode(ds.getString("EnterpriseCode"));
				csDto.setPermitNo(ds.getString("PermitNo"));
				csDto.setEnterpriseNm(ds.getString("EnterpriseNm"));
				csDto.setOperatingCompany(ds.getString("OperatingCompany"));
				csDto.setSalesMan(ds.getString("SalesMan"));
				csDto.setSalesManTel(ds.getString("SalesManTel"));
				csDto.setProjectName(ds.getString("ProjectName"));
				csDto.setSalesProjections(ds.getString("SalesProjections"));
				csDto.setOrderble(ds.getString("Orderble"));
				csDto.setOrderbleNm(ds.getString("OrderbleNm"));
				csDto.setChargeID(ds.getString("ChargeID"));
				csDto.setChargeNm(ds.getString("ChargeNm"));
				csDto.setChargeSecondID(ds.getString("ChargeSecondID"));
				csDto.setChargeSeNm(ds.getString("ChargeSeNm"));
				csDto.setAssignPerson(ds.getString("AssignPerson"));
				csDto.setDateProjections(ds.getString("DateProjections"));
				csDto.setOrderStatus(ds.getString("OrderStatus"));
				csDto.setComentPk(ds.getInt("ComentPk"));
				csDto.setProjectPkCo(ds.getString("ProjectPkCo"));
				csDto.setPublicNo(ds.getString("PublicNo"));
				csDto.setP_PublicNo(ds.getString("P_PublicNo"));
				csDto.setSalesFile_Xls(ds.getString("SalesFile_Xls"));
				csDto.setSalesFileNm_Xls(ds.getString("SalesFileNm_Xls"));
				csDto.setSalesFile_Pdf(ds.getString("SalesFile_Pdf"));
				csDto.setSalesFileNm_Pdf(ds.getString("SalesFileNm_Pdf"));
				

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

		return csDto;
	}
	/*
	 * 영업진행현황 수정하기
	 * 2013_04_06(금) shbyeon.
	 */
	public int currentUpdate(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CurrentStatusModify (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(csDto.getPreSalesCode());
		sql.setInteger(csDto.getQuarter());
		sql.setString(csDto.getEnterpriseCode());
		sql.setString(csDto.getPermitNo());
		sql.setString(csDto.getEnterpriseNm());
		sql.setString(csDto.getOperatingCompany());
		sql.setString(csDto.getSalesMan());
		sql.setString(csDto.getSalesManTel());
		sql.setString(csDto.getProjectName());
		sql.setString(csDto.getSalesProjections());
		sql.setString(csDto.getOrderble());
		sql.setString(csDto.getChargeID());
		sql.setString(csDto.getChargeSecondID());
		sql.setString(csDto.getAssignPerson());
		sql.setString(csDto.getDateProjections());
		sql.setString(csDto.getUpdateUser());
		sql.setString(csDto.getCheckyn());
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
	
	/*
	 * 견적서발행으로 인한 영업진행현황 (견적번호,모발행번호,수주가능성,수주상태)DATA UPDATE
	 * 2013_04_26(금) shbyeon.
	 */
	public int currentUpdate_EST(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CurrentStatusModify_EST (?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(csDto.getPreSalesCode());
		sql.setString(csDto.getPublicNo());
		sql.setString(csDto.getP_PublicNo());
		sql.setString(csDto.getOrderble());
		sql.setString(csDto.getChargeID());
		sql.setString(csDto.getSalesFile_Xls());
		sql.setString(csDto.getSalesFileNm_Xls());
		sql.setString(csDto.getSalesFile_Pdf());
		sql.setString(csDto.getSalesFileNm_Pdf());
		sql.setString(csDto.getOrderStatus());
		System.out.println("tlqkf:"+csDto.getOrderStatus());
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
	
	/*
	 * 견적서발행으로 인한 영업진행현황 (견적번호,모발행번호,수주가능성,수주상태)DATA UPDATE
	 * 2013_04_26(금) shbyeon.
	 */
	public int currentUpdate_EST2(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CurrentStatusModify_EST2 (?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(csDto.getPreSalesCode());
		sql.setString(csDto.getPublicNo());
		sql.setString(csDto.getP_PublicNo());
		sql.setString(csDto.getSalesFile_Xls());
		sql.setString(csDto.getSalesFileNm_Xls());
		sql.setString(csDto.getSalesFile_Pdf());
		sql.setString(csDto.getSalesFileNm_Pdf());
		sql.setString(csDto.getOrderStatus());
		System.out.println("tlqkf:"+csDto.getOrderStatus());
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
	
	/*
	 * 2013_04_08(월) shbyeon.
	 * 영업진행현황 => 상품코드 삭제(수정 처리시 사용되는 DAO)
	 * Description:(
	 * 영업진행현황 상품코드는 현재 배치 형태로 별도의 테이블(htProductCode)에 등록이되며
	 * 상품코드를 수정 할 시에는 Pk가 가지고있는 데이터를 한번 삭제시키고 다시 Insert시키는 형태로 되어있다.)
	 */
	public int deleteProductAll(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_productCodeDelete (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(csDto.getPreSalesCode());
		sql.setString(csDto.getPublicNo());

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
	 * 2013_04_29(월) shbyeon.
	 * 영업진행현황 == 견적서발행 상품코드 삭제(수정 처리시 사용되는 DAO)
	 * Description:(
	 * 영업진행현황==견적서발행 상품코드는 현재 배치 형태로 별도의 매핑 테이블(htSalesProductCode)에 등록이되며
	 * 상품코드를 수정 할 시에는 Pk가 가지고있는 데이터를 한번 삭제시키고 다시 Insert시키는 형태로 되어있다.)
	 */
	public int deleteProductAll_EST(EstimateDTO estimateDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_productCodeDelete_EST (?,?) } "; //영업진행현황,견적서발행 상품코드삭제 공통 프로시저 사용.

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(estimateDto.getProductPk());
		System.out.println(estimateDto.getProductPk());
		sql.setString(estimateDto.getPROJECT_PK_CODE());
		System.out.println(estimateDto.getPROJECT_PK_CODE());

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
	
	/*
	 * 2013_04_29(월) shbyeon.
	 * 영업진행현황 == 견적서발행 상품코드 삭제(수정 처리시 사용되는 DAO)
	 * Description:(
	 * 영업진행현황==견적서발행 상품코드는 현재 배치 형태로 별도의 매핑 테이블(htSalesProductCode)에 등록이되며
	 * 상품코드를 수정 할 시에는 Pk가 가지고있는 데이터를 한번 삭제시키고 다시 Insert시키는 형태로 되어있다.)
	 */
	public int deleteProductAll_EST2(EstimateDTO estimateDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_productCodeDelete_EST2 (?) } "; //영업진행현황,견적서발행 상품코드삭제 공통 프로시저 사용.

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(estimateDto.getPublic_no());

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
	 * 코멘트 수정.
	 */
	public int CommentUpdate(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CurrentComentModify (?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(csDto.getComentPk());
		sql.setString(csDto.getProjectPkCo());
		sql.setString(csDto.getChargeID_co());
		sql.setString(csDto.getSalesMan_co());
		sql.setString(csDto.getContents());
		sql.setString(csDto.getSalesFile());
		sql.setString(csDto.getSalesFileNm());
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

	/*
	 * 2013_04_08(월) shbyeon.
	 * 영업진행현황 목록 => 삭제
	 */
	public int deleteCurrentOne(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CurrentStatusDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(csDto.getPreSalesCode());

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

	/*
	 * 코멘트 삭제
	 */
	public int deleteOneComent(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CurrentComentDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(csDto.getComentPk());

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
	 * 2013_11_14(목) shbyeon.
	 * 견적서 즉시 발행으로 상품코드 등록
	 * Description : 견적서 최초발행 및 영업진행현황 최초 등록됨(상품코드)
	 * @throws DAOException
	 */	
	public int addproductCode_now(String[] ProductCode, String ProductPk) throws DAOException{
		
		String procedure = " { CALL hp_productCodeRegist_EST_NOW ( ?,? ) } ";
		
		int retVal = 0;	
		int[] resultVal=null;
		
		QueryStatement sql = new QueryStatement();
		sql.setBatchMode(true);
		sql.setSql(procedure);
		
		List batchList=new Vector();
		
		try{
			
			for(int i=0; ProductCode != null && i<ProductCode.length; i++){ 
				
				List batch=new Vector();

				
				batch.add(ProductPk);
				batch.add(ProductCode[i]);
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

}