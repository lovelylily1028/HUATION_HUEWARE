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
	 * CreateDate:2013-11-21(��) Writer:shbyeon.
	 * ������ ����Ʈ
	 * @param cmDto
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO contractMgPageList(ContractManageDTO cmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ContractMgInquiry_new2 ( ?,?,?,?,?,?,?,? ) } ";//20200605 new ���� new1���� ��ü

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
	    sql.setString(cmDto.getChUserID()); 		//�α��� ���� ID
		sql.setString(cmDto.getvSearchType()); 		// �˻�����
		sql.setString(cmDto.getSearchGb2());		// �˻�����(������� ����)
		sql.setString(cmDto.getSearchGb3());		// �˻�����(���ⱸ��, �ý��۸���, ��ǰ����, �뿪����)
		sql.setString(cmDto.getvSearch()); 			// �˻���
		sql.setInteger(cmDto.getnRow()); 			// ����Ʈ ����
		sql.setInteger(cmDto.getnPage()); 			// ���� ������
		sql.setString("PAGE"); 						// sp ����

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
	 * CreateDate:2013-11-21(��) Writer:shbyeon.
	 * ����� ����Ʈ
	 * @param cmDto
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO contractMgRegistList(ContractManageDTO cmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ContractMgRegistInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
	    sql.setString(cmDto.getChUserID()); 		//�α��� ���� ID
		sql.setString(cmDto.getvSearchType()); 		// �˻�����
		sql.setString(cmDto.getvSearch()); 			// �˻���
		sql.setInteger(cmDto.getnRow()); 			// ����Ʈ ����
		sql.setInteger(cmDto.getnPage()); 			// ���� ������
		sql.setString("PAGE"); 						// sp ����

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
	 * CreateDate:2013-11-21(��) Writer:shbyeon.
	 * ������ ����Ʈ(Excel-Down)
	 * @param cmDto
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO contractMgExcel(ContractManageDTO cmDto) throws DAOException {

		ListDTO retVal = null;
//		String procedure = " { CALL hp_ContractMgInquiry ( ?,?,?,?,?,? ) } ";
//
//		QueryStatement sql = new QueryStatement();

//		sql.setSql(procedure); // ���ν��� ��
//	    sql.setString(cmDto.getChUserID()); 		//�α��� ���� ID
//		sql.setString(cmDto.getvSearchType()); 		// �˻�����
//		sql.setString(cmDto.getvSearch()); 			// �˻���
//		sql.setInteger(cmDto.getnRow()); 			// ����Ʈ ����
//		sql.setInteger(cmDto.getnPage()); 			// ���� ������
//		sql.setString("LIST"); 						// sp ����

		String procedure = " { CALL hp_ContractMgInquiry_new2 ( ?,?,?,?,?,?,?,? ) } ";//20200605 new ���� new1���� ��ü

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
	    sql.setString(cmDto.getChUserID()); 		//�α��� ���� ID
		sql.setString(cmDto.getvSearchType()); 		// �˻�����
		sql.setString(cmDto.getSearchGb2());		// �˻�����(������� ����)
		sql.setString(cmDto.getSearchGb3());		// �˻�����(���ⱸ��, �ý��۸���, ��ǰ����, �뿪����)
		sql.setString(cmDto.getvSearch()); 			// �˻���
		sql.setInteger(cmDto.getnRow()); 			// ����Ʈ ����
		sql.setInteger(cmDto.getnPage()); 			// ���� ������
		sql.setString("PAGE"); 						// sp ����					// sp ����
		
		
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
	 * CreateDate:2013-11-26(ȭ) Writer:shbyeon.
	 * ������ �ڵ��ȣ �����ϱ�(MAX ������ Select �ؿ´�.) 
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
				log.debug("[������ ������ ��� CQ_Code(��/��/��MAX�� SELECT) => ���� ����:"+createCode_return+" DAO..������ ���]");
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
	 * CreateDate:2013-12-13(��) Writer:shbyeon.
	 * ������ ���(������ �޴� ����ϱ�.)  
	 * @param cmDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int contractInsertData(ContractManageDTO cmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ContractMgRegist (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(cmDto.getContractCode());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ PK ����ڵ��ȣ:"+cmDto.getContractCode()+" DAO..]");
		sql.setString(cmDto.getPublic_No());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ PK ������ȣ:"+cmDto.getPublic_No()+" DAO..]");
		sql.setString(cmDto.getContractFile());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ��༭ ���ϰ��:"+cmDto.getContractFile()+" DAO..]");
		sql.setString(cmDto.getContractFileNm());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ��༭ ���ϸ�:"+cmDto.getContractFileNm()+" DAO..]");
		sql.setString(cmDto.getPurchaseOrderFile());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ���ּ� ���ϰ��:"+cmDto.getPurchaseOrderFile()+" DAO..]");
		sql.setString(cmDto.getPurchaseOrderFileNm());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ���ּ� ���ϸ�:"+cmDto.getPurchaseOrderFileNm()+" DAO..]");
		sql.setString(cmDto.getContractName());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ����:"+cmDto.getContractName()+" DAO..]");
		sql.setString(cmDto.getContractCreateUser());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ���ʵ����:"+cmDto.getContractCreateUser()+" DAO..]");
		sql.setString(cmDto.getContractStatus());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ��� ���Ῡ��:"+cmDto.getContractStatus()+" DAO..]");
		sql.setString(cmDto.getContractReason());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ �������� ����:"+cmDto.getContractReason()+" DAO..]");
		sql.setString(cmDto.getOrdering_Organization());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ���ֻ�(��ü��):"+cmDto.getOrdering_Organization()+" DAO..]");
		sql.setString(cmDto.getCustomerName());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ������ڸ�:"+cmDto.getCustomerName()+" DAO..]");
		sql.setString(cmDto.getCustomerTel());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ �� ����� ����ó:"+cmDto.getCustomerTel()+" DAO..]");
		sql.setString(cmDto.getCustomerMobile());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ �� ����� �ڵ��� ��ȣ :"+cmDto.getCustomerMobile()+" DAO..]");
		sql.setString(cmDto.getContractEndDate());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ �������� :"+cmDto.getContractEndDate()+" DAO..]");
		sql.setString(cmDto.getContractDate());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ������� :"+cmDto.getContractDate()+" DAO..]");
		sql.setString(cmDto.getConChk());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ������� ��뿩�� :"+cmDto.getConChk()+" DAO..]");
		sql.setString(cmDto.getPurchaseDate());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ �������� :"+cmDto.getPurchaseDate()+" DAO..]");
		sql.setString(cmDto.getPurChk());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ �������� ��뿩�� :"+cmDto.getPurChk()+" DAO..]");
		
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
	 * CreateDate:2013-11-27(ȭ) Writer:shbyeon.
	 * ������ ������
	 * @param cmDto
	 * @return cmDto
	 * @throws DAOException
	 */
	public ContractManageDTO contractManageView(ContractManageDTO cmDto) throws DAOException {

		String procedure = "{ CALL hp_ContractMgSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * CreateDate:2013-11-27(��) Writer:shbyeon.
	 * ������ ����(������ �޴� �����ϱ�.)  
	 * @param cmDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int contractUpdateData(ContractManageDTO cmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ContractMgModify (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(cmDto.getContractCode());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ PK ����ڵ��ȣ:"+cmDto.getContractCode()+" DAO..]");
		sql.setString(cmDto.getPublic_No());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ PK ������ȣ:"+cmDto.getPublic_No()+" DAO..]");
		sql.setString(cmDto.getContractFile());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ ��༭ ���ϰ��:"+cmDto.getContractFile()+" DAO..]");
		sql.setString(cmDto.getContractFileNm());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ ��༭ ���ϸ�:"+cmDto.getContractFileNm()+" DAO..]");
		sql.setString(cmDto.getPurchaseOrderFile());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ ���ּ� ���ϰ��:"+cmDto.getPurchaseOrderFile()+" DAO..]");
		sql.setString(cmDto.getPurchaseOrderFileNm());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ ���ּ� ���ϸ�:"+cmDto.getPurchaseOrderFileNm()+" DAO..]");
		sql.setString(cmDto.getContractName());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ ����:"+cmDto.getContractName()+" DAO..]");
		sql.setString(cmDto.getContractUpdateUser());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ ���ʵ����:"+cmDto.getContractUpdateUser()+" DAO..]");
		sql.setString(cmDto.getContractStatus());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ ��� ���Ῡ��:"+cmDto.getContractStatus()+" DAO..]");
		sql.setString(cmDto.getContractReason());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ �������� ����:"+cmDto.getContractReason()+" DAO..]");
		sql.setString(cmDto.getOrdering_Organization());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ ���ֻ�(��ü��):"+cmDto.getOrdering_Organization()+" DAO..]");
		sql.setString(cmDto.getCustomerName());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ ������ڸ�:"+cmDto.getCustomerName()+" DAO..]");
		sql.setString(cmDto.getCustomerTel());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ �� ����� ����ó:"+cmDto.getCustomerTel()+" DAO..]");
		sql.setString(cmDto.getCustomerMobile());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ �� ����� �ڵ��� ��ȣ :"+cmDto.getCustomerMobile()+" DAO..]");
		sql.setString(cmDto.getContractEndDate());
		log.debug("[������ ���� ���̺� Update �Ǵ� ������ ��������:"+cmDto.getContractEndDate()+" DAO..]");
		sql.setString(cmDto.getContractDate());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ������� :"+cmDto.getContractDate()+" DAO..]");
		sql.setString(cmDto.getConChk());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ ������� ��뿩�� :"+cmDto.getConChk()+" DAO..]");
		sql.setString(cmDto.getPurchaseDate());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ �������� :"+cmDto.getPurchaseDate()+" DAO..]");
		sql.setString(cmDto.getPurChk());
		log.debug("[������ ��� ���̺� Insert �Ǵ� ������ �������� ��뿩�� :"+cmDto.getPurChk()+" DAO..]");
		
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
	 * CreateDate:2013-11-27(ȭ) Writer:shbyeon.
	 * ������ ������
	 * @param cmDto
	 * @return cmDto
	 * @throws DAOException
	 */
	public ListDTO invoiceDetailList(ContractManageDTO cmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = "{ CALL hp_InvoiceDetailList_CM (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * CreateDate:2013-12-27(��) Writer:shbyeon.
	 * ������ ����Ʈ(�������� �ǿ� ���ؼ���/������Ʈ �ڵ� ���� �˾� ��ȸ �뵵.)
	 * @param cmDto
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO contractMgPageList_Pop_Pj(ContractManageDTO cmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ContractMgInquiry ( ?,?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
	    sql.setString(cmDto.getChUserID()); 		//�α��� ���� ID
		sql.setString(cmDto.getvSearchType()); 		// �˻�����
		sql.setString(cmDto.getSearchGb2());
		sql.setString(cmDto.getvSearch()); 			// �˻���
		sql.setInteger(cmDto.getnRow()); 			// ����Ʈ ����
		sql.setInteger(cmDto.getnPage()); 			// ���� ������
		sql.setString("PAGE"); 						// sp ����

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
	 * CreateDate:2013-11-21(��) Writer:shbyeon.
	 * �̹���/�̼� ����Ʈ
	 * @param cmDto
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO UnissuedNoCollectList(ContractManageDTO cmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_UnissuedNoCollect } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
/*	    sql.setString(cmDto.getChUserID()); 		//�α��� ���� ID
		sql.setString(cmDto.getvSearchType()); 		// �˻�����
		sql.setString(cmDto.getvSearch()); 			// �˻���
		sql.setInteger(cmDto.getnRow()); 			// ����Ʈ ����
		sql.setInteger(cmDto.getnPage()); 			// ���� ������
		sql.setString("PAGE"); 						// sp ����

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
	 * ��������->�̹��� �̼� Excel����Ʈ.
	 * shbyeon. 2013_03_06(��)
	 * @param userDto
	 * ����� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO UnissuedNoCollectExcelList() throws DAOException{
		
		String procedure = " { CALL hp_UnissuedNoCollect } ";
		
		ListDTO retVal = null;

		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // ���ν��� ��
//		sql.setString("LIST"); // sp ����

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
