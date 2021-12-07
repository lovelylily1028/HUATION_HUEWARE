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
	 * 2013_03_12(ȭ) shbyeon.
	 * �������� - > ����������Ȳ SalesCode ��������.
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
				log.debug("����������Ȳ SC_Code ���� ����:"+SC_Code);
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
	 * 2013_03_12(ȭ) shbyeon.
	 * �������� - > ����������Ȳ ��� 
	 */  
	public int addcurrentRegist(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;
 
		String procedure = " { CALL hp_CurrentStatusRegist (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * 2013_11_04(��) shbyeon.
	 * �������� - > ����������Ȳ ��� (������ ��ù��� �뵵)
	 */  
	public int addcurrentRegist_EST(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;
 
		String procedure = " { CALL hp_CurrentStatusRegist_EST (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * 2013_03_14(��) shbyeon.
	 * ��������->����������Ȳ ��ǰ�ڵ� ���(��ġ ���)
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


				batch.add(ProductCode[i]); //����� ���̵�
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
	 * 2013_03_14(��) shbyeon.
	 * ��������->����������Ȳ ��ǰ�ڵ� ���(��ġ ����)
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

				
				batch.add(ProductPk);/*����������Ȳ�ڵ�*/
				batch.add(ProductCode[i]);/*��ǰ�ڵ�*/
				batch.add(ProductMappingPk);/*�����������ȣ*/
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
	 * 2013_03_14(��) shbyeon.
	 * ��������->������ ���� �������� ��ǰ�ڵ� ���
	 * Description : ������ ���ʹ���,�����,����������Ȳ ���ʹ���,��ù��� ������ ��.
	 * @throws DAOException
	 */	
	public int addproductCode_EST(String[] ProductCode, String ProductPk, String ProductPkMapping) throws DAOException{
		
		System.out.println("=============================================������ ���� ����� ���� ");
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
	 * 2013_03_26(ȭ)shbyeon.
	 * ��ü�� �ߺ�üũ(����������Ȳ)
	 */
	public String compNameCheck(CurrentStatusDTO csDto) throws DAOException{

		String procedure = " { CALL hp_CompanyNmDuplicateCs ( ? , ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setString("DUPLICATE");			//SP����
		sql.setString(csDto.getEnterpriseNm());		//��ü�� ���̵�

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
	 * 2013_04_07(��)
	 * ����������Ȳ = > �̽��ڸ�Ʈ ���ó��.
	 */
	public int addCommentRegist(CurrentStatusDTO csDto) throws DAOException {

		int commentpk = 0;
		DataSet ds = null;
 
		String procedure = " { CALL hp_CurrentComentRegist (?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(csDto.getProjectPkCo()); //�ڸ�Ʈ pk
		System.out.println("ProjectPkComent:"+csDto.getProjectPkCo());
		sql.setString(csDto.getSalesMan_co());  //����
		sql.setString(csDto.getChargeID_co());  //��翵��
		sql.setString(csDto.getContents()); 	//�ڸ�Ʈ����
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
	 * ��������->����������Ȳ ����Ʈ.
	 * shbyeon. 2013_02_27(��)
	 * @param userDto
	 * ����� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO CurrentStatusList(CurrentStatusDTO csDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_CurrentStatusInquiry ( ?,?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(csDto.getvSearchYear()); // �˻�����(�⵵)
		sql.setString(csDto.getvSearchType()); // �˻�����(��������)
		sql.setString(csDto.getvSearchType2()); // �˻�����(���)
		sql.setString(csDto.getvSearch()); // �˻���
		sql.setInteger(csDto.getnRow()); // ����Ʈ ���� ���x
		sql.setInteger(csDto.getnPage()); // ���� ������ ���x
		sql.setString("LIST"); // sp ����

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
	 * ��������->����������Ȳ Excel����Ʈ.
	 * shbyeon. 2013_03_06(��)
	 * @param userDto
	 * ����� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO currentListExcel(CurrentStatusDTO csDto) throws DAOException{
		
		String procedure = " { CALL hp_CurrentStatusInquiry ( ?,?,?,?,?,?,? ) } ";
		
		ListDTO retVal = null;

		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // ���ν��� ��
		sql.setString(csDto.getvSearchYear()); // �˻�����(�⵵)
		sql.setString(csDto.getvSearchType()); // �˻�����(��������)
		sql.setString(csDto.getvSearchType2()); // �˻�����(���)
		sql.setString(csDto.getvSearch()); // �˻���
		sql.setInteger(csDto.getnRow()); // ����Ʈ ���� ���x
		sql.setInteger(csDto.getnPage()); // ���� ������ ���x
		sql.setString("LIST"); // sp ����

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
	 * ��������->����������Ȳ ��ǰ�ڵ� ����Ʈ.
	 * 2013_04_06(��) shbyeon.
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
		 log.debug("[����������Ȳ ������  SC_CODE=SQL_SET("+csDtoPro.getPreSalesCode()+") DAO..");
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
				 log.debug("[����������Ȳ ������ ���õ� PRODUCT_CODE=RS_GET ProductList=("+rs.getString("ProductCode")+") �´� ��ǰ�ڵ� Batch List ������. DAO..");
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
	 * ��������->(����������) ��ǰ�ڵ� ����Ʈ.
	 * 2013_04_29(��) shbyeon.
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
		 sql.setString(estimateDto.getPublic_no()); //������ ������ PreSalesCode ����.
		 log.debug("[������ ���� ������  PUBLIC_NO=SQL_SET("+estimateDto.getPublic_no()+") DAO..");
		 sb.append(" order by CreateDateTime asc ");
		 sql.setSql(sb.toString());
	

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 productList = new ArrayList();
			 while(rs.next()){
				 CurrentStatusDTO  csDtoPro = new CurrentStatusDTO(); //������ ���࿡ �������� ��ǰ�ڵ带 ������ �뵵�� ����� DTO
				 csDtoPro.setProductPk(rs.getString("ProductMappingPk"));    //����������Ȳ DTO����� ��. ������ DTO������ ���̱� ����.
				 //dto ���� �°Բ� ���� �Ұ� ���� PK DTO �������ֱ�!
				 csDtoPro.setProductCode(rs.getString("ProductCode")); //��ǰ �ڵ�
				 log.debug("[������ ���� ������ ���õ� PRODUCT_CODE=RS_GET ProductList=("+rs.getString("ProductCode")+") �´� ��ǰ�ڵ� Batch List ������. DAO..");
				 csDtoPro.setProductName(rs.getString("ProductName")); //��ǰ ��
				 productList.add(csDtoPro);
				 System.out.println("���������� ��ǰ����Ʈ2");
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
	 * ��������->(����������==����������Ȳ) ��ǰ�ڵ� ����Ʈ.
	 * 2013_11_11(��) shbyeon.
	 * description:���� ó���κ� �����.
	 * �������� ������ ��ǰ�ڵ� ������ , ����������Ȳ ��ǰ�ڵ� ������ ������ �����Ͽ� �����Ͽ�����,
	 * ����������Ȳ���� ������ ���� �Ͽ��� ��� �� ��ù����Ͽ��� ��� ����� ����Ǿ��� ���
	 * ��ǰ�ڵ带 �������� �����ϰ� ���� ������� �ϹǷ� �߰���.
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
		 sql.setString(csDtoPro.getPreSalesCode()); //������ ������ PreSalesCode ����.
		 sql.setString(csDtoPro.getPublicNo()); //������ ������ PublicNo ����.
		 sb.append(" order by CreateDateTime asc ");
		 sql.setSql(sb.toString());
	

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 productList = new ArrayList();
			 while(rs.next()){
				 csDtoPro = new CurrentStatusDTO(); //������ ���࿡ �������� ��ǰ�ڵ带 ������ �뵵�� ����� DTO
				 csDtoPro.setProductPk(rs.getString("ProductMappingPk"));    //����������Ȳ DTO����� ��. ������ DTO������ ���̱� ����.
				 //dto ���� �°Բ� ���� �Ұ� ���� PK DTO �������ֱ�!
				 csDtoPro.setProductCode(rs.getString("ProductCode")); //��ǰ �ڵ�
				 //System.out.println("DAO PRO:"+rs.getString("ProductCode"));
				 csDtoPro.setProductName(rs.getString("ProductName")); //��ǰ ��
				 productList.add(csDtoPro);
				 System.out.println("����������Ȳ ��ȸ�� ������ �����Ͽ��� ����� ��ǰ�ڵ� ����Ʈ");
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
	 * ��������->����������Ȳ ��ȸ ��ǰ�ڵ� ����Ʈ(������ ���� ���༭ ��)
	 * ����������Ȳ ��ȸ�� ���ʹ����� ����������Ȳ pk�� ���� ��ǰ�ڵ� ��������. �ڵ��
	 * ������ ���� �� ����������Ȳ���� �ʱ⿡ ��ȸ �Ͽ��� ��� ������ ��ǰ�ڵ�
	 * 2013_04_24(��)shbyeon.
	 *
	 */
	public String getproductViewListEsT_pop(CurrentStatusDTO csDtoPro) throws DAOException{
	     String  productStr = ""; //��ǰ�ڵ� String ���ļ� ������(|,+)�༭ ���� ����
	     int x = 1; //��ǰ�ڵ� ++ ���� ����
		 QueryStatement sql = new QueryStatement();
		 StringBuffer sb = new StringBuffer();
		 sb.append(" select A.ProductCode, B.CD_NM as ProductName "); 
		 sb.append(" from htSalesProductCode A");
		 sb.append(" left join T_CODE B on B.BIG_CD = A.ProductCode ");
		 sb.append(" where ProductPk = ? and ProductMappingPk = ? ");
		 sql.setString(csDtoPro.getProductPk());
		 log.debug("[������ ���࿡�� ����������Ȳ ��ȸ Start DAO..");
		 log.debug("[����������Ȳ ��ȸ �˾����� ������ SC_CODE["+csDtoPro.getProductPk()+"] DAO..������ => ����������Ȳ ��ȸ");
		 sql.setString(csDtoPro.getPublicNo());
		 log.debug("[����������Ȳ ��ȸ �˾����� ������ PUBLIC_NO["+csDtoPro.getPublicNo()+"] DAO..������ => ����������Ȳ ��ȸ");
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
					 //��ǰ�ڵ尡 �ϳ��϶� ProductCode �� join���� ������ ProductName �� String ���� ��ģ��.
					 //jsp�ܿ��� split���� ������(|)�� �߶� ���ϱ�����.
					 //DB�� ������ �������� ProductCode�ְ� JSP WEB�ܿ��� ���������� ProductName ������������ 
					 //String ���� �����ڸ� �־ �����ش�.
					 productStr += rs.getString("ProductCode")+"|"+rs.getString("ProductName");
					 //System.out.println(productStr);
					 //System.out.println("�Ѱ��϶� ��ģ��:"+productStr);
				 }else{
					 //��ǰ�ڵ尡 �ϳ��̻��϶� ProductCode �� join���� ������ ProductName �� String ��ģ��.
					 //jsp�ܿ��� split���� ������(+,|)�� �߶� ���ϱ�����.
					 //DB�� ������ �������� ProductCode�ְ� JSP WEB�ܿ��� ���������� ProductName ������������ 
					 //String ���� �����ڸ� �־ �����ش�.�� �Ѱ� �̻��϶��� ������(+)�� �ѹ��� ������ �ش�.
					 productStr += "+"+rs.getString("ProductCode")+"|"+rs.getString("ProductName");
					 //System.out.println("�ΰ��϶� ��ģ��:"+productStr);
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
		 //productStr = "HUEFAX|0001+HUERES|0002"; //��ǰ�ڵ� ������ 1�� �̻��� 2���� ��츦 ��Ÿ���� ���� ǥ���� �ּ�.
		 //System.out.println("productstr Sum:"+productStr);
		 return productStr;   
	}
	
	
	
	
	/**
	 * ��������->����������Ȳ ��ǰ�ڵ� ����Ʈ(������ ������)
	 * ����������Ȳ ��ȸ�� ���ʹ����� ����������Ȳ pk�� ���� ��ǰ�ڵ� ��������. �ڵ��
	 * ���������࿡�� ������ȣ�� �������� �������̸鼭 , ����������Ȳ���� ������ �����Ͽ��� ������ȣ ��ǰ�ڵ� �������� �ڵ��.
	 * 2013_04_24(��)shbyeon.
	 *
	 */
	public String getproductViewListEsT_pop2(CurrentStatusDTO csDtoPro) throws DAOException{
	     String  productStr = ""; //��ǰ�ڵ� String ���ļ� ������(|,+)�༭ ���� ����
	     int x = 1; //��ǰ�ڵ� ++ ���� ����
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
		 System.out.println("���������࿡�� ����������Ȳ ��ȸ �Ҷ����Ǵ� ��ǰ�ڵ帮��Ʈ2");
	

		 DataSet rs = null;
		 try{
			 rs = broker.executeQuery(sql);
			 while(rs.next()){
				 
				 //csDtoPro = new CurrentStatusDTO();
				 //csDtoPro.setProductPk(rs.getString("ProductPk"));
				 //csDtoPro.setProductCode(rs.getString("ProductCode"));
				 //System.out.println("DAO PRO:"+rs.getString("ProductCode"));
				if(x == 1){
					 //��ǰ�ڵ尡 �ϳ��϶� ProductCode �� join���� ������ ProductName �� String ���� ��ģ��.
					 //jsp�ܿ��� split���� ������(|)�� �߶� ���ϱ�����.
					 //DB�� ������ �������� ProductCode�ְ� JSP WEB�ܿ��� ���������� ProductName ������������ 
					 //String ���� �����ڸ� �־ �����ش�.
					 productStr += rs.getString("ProductCode")+"|"+rs.getString("ProductName");
					 //System.out.println("�Ѱ��϶� ��ģ��:"+productStr);
				 }else{
					 //��ǰ�ڵ尡 �ϳ��̻��϶� ProductCode �� join���� ������ ProductName �� String ��ģ��.
					 //jsp�ܿ��� split���� ������(+,|)�� �߶� ���ϱ�����.
					 //DB�� ������ �������� ProductCode�ְ� JSP WEB�ܿ��� ���������� ProductName ������������ 
					 //String ���� �����ڸ� �־ �����ش�.�� �Ѱ� �̻��϶��� ������(+)�� �ѹ��� ������ �ش�.
					 productStr += "+"+rs.getString("ProductCode")+"|"+rs.getString("ProductName");
					 //System.out.println("�ΰ��϶� ��ģ��:"+productStr);
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
		 //productStr = "HUEFAX|0001+HUERES|0002"; //��ǰ�ڵ� ������ 1�� �̻��� 2���� ��츦 ��Ÿ���� ���� ǥ���� �ּ�.
		 //System.out.println("productstr Sum:"+productStr);
		 return productStr;   
	}
	
	/**
	 * ��������->����������Ȳ ��ǰ�ڵ� ����Ʈ(������ ������)
	 * ����������Ȳ ��ȸ�� ���ʹ����� ����������Ȳ pk�� ���� ��ǰ�ڵ� ��������. �̸���
	 * 2013_04_24(��)shbyeon.
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
					// System.out.println("��ģ��1:"+productStr);
				 }else{
					 productStrNm += "|"+rs.getString("ProductName");
					// System.out.println("��ģ��2:"+productStr);
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
	 * 2013_04_08(��) shbyeon.
	 * ����������Ȳ �ڸ�Ʈ ����Ʈ.
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO currentListComment(CurrentStatusDTO csDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_CurrentComentInquiry ( ?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(csDto.getProjectPkCo());
		sql.setInteger(csDto.getnRow()); // ����Ʈ ����
		sql.setInteger(csDto.getnPage()); // ���� ������
		sql.setString("LIST"); // sp ����

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
	 * 2013_04_06(��)shbyeon.
	 * ����������Ȳ �󼼺���.
	 */
	public CurrentStatusDTO currentView(CurrentStatusDTO csDto) throws DAOException {

		String procedure = "{ CALL hp_CurrentStatusSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * ����������Ȳ �����ϱ�
	 * 2013_04_06(��) shbyeon.
	 */
	public int currentUpdate(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CurrentStatusModify (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * �������������� ���� ����������Ȳ (������ȣ,������ȣ,���ְ��ɼ�,���ֻ���)DATA UPDATE
	 * 2013_04_26(��) shbyeon.
	 */
	public int currentUpdate_EST(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CurrentStatusModify_EST (?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * �������������� ���� ����������Ȳ (������ȣ,������ȣ,���ְ��ɼ�,���ֻ���)DATA UPDATE
	 * 2013_04_26(��) shbyeon.
	 */
	public int currentUpdate_EST2(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CurrentStatusModify_EST2 (?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * 2013_04_08(��) shbyeon.
	 * ����������Ȳ => ��ǰ�ڵ� ����(���� ó���� ���Ǵ� DAO)
	 * Description:(
	 * ����������Ȳ ��ǰ�ڵ�� ���� ��ġ ���·� ������ ���̺�(htProductCode)�� ����̵Ǹ�
	 * ��ǰ�ڵ带 ���� �� �ÿ��� Pk�� �������ִ� �����͸� �ѹ� ������Ű�� �ٽ� Insert��Ű�� ���·� �Ǿ��ִ�.)
	 */
	public int deleteProductAll(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_productCodeDelete (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * 2013_04_29(��) shbyeon.
	 * ����������Ȳ == ���������� ��ǰ�ڵ� ����(���� ó���� ���Ǵ� DAO)
	 * Description:(
	 * ����������Ȳ==���������� ��ǰ�ڵ�� ���� ��ġ ���·� ������ ���� ���̺�(htSalesProductCode)�� ����̵Ǹ�
	 * ��ǰ�ڵ带 ���� �� �ÿ��� Pk�� �������ִ� �����͸� �ѹ� ������Ű�� �ٽ� Insert��Ű�� ���·� �Ǿ��ִ�.)
	 */
	public int deleteProductAll_EST(EstimateDTO estimateDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_productCodeDelete_EST (?,?) } "; //����������Ȳ,���������� ��ǰ�ڵ���� ���� ���ν��� ���.

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * 2013_04_29(��) shbyeon.
	 * ����������Ȳ == ���������� ��ǰ�ڵ� ����(���� ó���� ���Ǵ� DAO)
	 * Description:(
	 * ����������Ȳ==���������� ��ǰ�ڵ�� ���� ��ġ ���·� ������ ���� ���̺�(htSalesProductCode)�� ����̵Ǹ�
	 * ��ǰ�ڵ带 ���� �� �ÿ��� Pk�� �������ִ� �����͸� �ѹ� ������Ű�� �ٽ� Insert��Ű�� ���·� �Ǿ��ִ�.)
	 */
	public int deleteProductAll_EST2(EstimateDTO estimateDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_productCodeDelete_EST2 (?) } "; //����������Ȳ,���������� ��ǰ�ڵ���� ���� ���ν��� ���.

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * �ڸ�Ʈ ����.
	 */
	public int CommentUpdate(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CurrentComentModify (?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * 2013_04_08(��) shbyeon.
	 * ����������Ȳ ��� => ����
	 */
	public int deleteCurrentOne(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CurrentStatusDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * �ڸ�Ʈ ����
	 */
	public int deleteOneComent(CurrentStatusDTO csDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_CurrentComentDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * 2013_11_14(��) shbyeon.
	 * ������ ��� �������� ��ǰ�ڵ� ���
	 * Description : ������ ���ʹ��� �� ����������Ȳ ���� ��ϵ�(��ǰ�ڵ�)
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