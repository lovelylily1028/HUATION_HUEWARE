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
	 * CreateDate:2013-12-24(ȭ) Writer:shbyeon.
	 * ������Ʈ ��ȸ ����Ʈ
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public ListDTO projectCodeMgPageList_Search(ProjectCodeManageDTO pjMgDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ProjectCodeMgInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
	    sql.setString(pjMgDto.getChUserID()); 		//�α��� ���� ID
		sql.setString(pjMgDto.getvSearchType()); 	// �˻�����
		sql.setString(pjMgDto.getvSearch()); 		// �˻���
		sql.setInteger(pjMgDto.getnRow()); 			// ����Ʈ ����
		sql.setInteger(pjMgDto.getnPage()); 		// ���� ������
		sql.setString("PAGE"); 						// sp ����

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
	 * CreateDate:2014-01-26(��) Writer:shbyeon.
	 * ������Ʈ ������� ����Ʈ
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public ListDTO projectCodeMgPageList_Progress(ProjectCodeManageDTO pjMgDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ProjectCodeMgInquiry_Pg ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
	    sql.setString(pjMgDto.getChUserID()); 		//�α��� ���� ID
		sql.setString(pjMgDto.getvSearchType()); 	// �˻�����
		sql.setString(pjMgDto.getvSearch()); 		// �˻���
		sql.setInteger(pjMgDto.getnRow()); 			// ����Ʈ ����
		sql.setInteger(pjMgDto.getnPage()); 		// ���� ������
		sql.setString("PAGE"); 						// sp ����

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
	 * CreateDate:2013-12-24(ȭ) Writer:shbyeon.
	 * ������Ʈ ��ȸ ����Ʈ(Excel-Down)
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public ListDTO projectCodeMgPageList_Search_Excel(ProjectCodeManageDTO pjMgDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ProjectCodeMgInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
	    sql.setString(pjMgDto.getChUserID()); 		//�α��� ���� ID
		sql.setString(pjMgDto.getvSearchType()); 	// �˻�����
		sql.setString(pjMgDto.getvSearch()); 		// �˻���
		sql.setInteger(pjMgDto.getnRow()); 			// ����Ʈ ����
		sql.setInteger(pjMgDto.getnPage()); 		// ���� ������
		sql.setString("LIST"); 						// sp ����

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
	 * CreateDate:2013-12-24(ȭ) Writer:shbyeon.
	 * ������Ʈ ��ȸ ����Ʈ(Excel-Down)
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public ListDTO projectCodeMgPageList_Progress_Excel(ProjectCodeManageDTO pjMgDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ProjectCodeMgInquiry_Pg ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
	    sql.setString(pjMgDto.getChUserID()); 		//�α��� ���� ID
		sql.setString(pjMgDto.getvSearchType()); 	// �˻�����
		sql.setString(pjMgDto.getvSearch()); 		// �˻���
		sql.setInteger(pjMgDto.getnRow()); 			// ����Ʈ ����
		sql.setInteger(pjMgDto.getnPage()); 		// ���� ������
		sql.setString("LIST"); 						// sp ����

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
	 * CreateDate:2014-01-07(ȭ) Writer:shbyeon.
	 * �� ������Ʈ ��ȸ ����Ʈ
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public ListDTO p_ProjectCodeList(ProjectCodeManageDTO pjMgDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_ProjectCodeMgInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
	    sql.setString(pjMgDto.getChUserID()); 		//�α��� ���� ID
		sql.setString(pjMgDto.getvSearchType()); 	// �˻�����
		sql.setString(pjMgDto.getvSearch()); 		// �˻���
		sql.setInteger(pjMgDto.getnRow()); 			// ����Ʈ ����
		sql.setInteger(pjMgDto.getnPage()); 		// ���� ������
		sql.setString("PAGE"); 						// sp ����

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
	 * CreateDate:2013-12-26(��) Writer:shbyeon.
	 * ������Ʈ �ڵ� �����ϱ�(MAX ������ Select �� �ӽ÷� DB�� Insert(����)���ѵд�.) 
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
				log.debug("[������Ʈ �ڵ� �ӽõ�� ProjectCode(PJ--000000 MAX SELECT) => ���� ����:"+ProjectCode_Return+" DAO..������Ʈ �ڵ� �ӽõ��]");
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
	 * CreateDate:2014-01-08(��) Writer:shbyeon.
	 * ������Ʈ �����ڵ� �����ϱ�
	 * @param project_code
	 * @return MoreCode_return
	 * @throws DAOException
	 */
	public String projectMoreCodeMgCreate(String project_code) throws DAOException{

		String procedure = " { CALL hp_ProjectMoreCodeMgCreate_Sel (?) } ";

		DataSet ds = null;
		String MoreCode_return = "";	//�����Ͽ� Action���� ������ �����ڵ� ��.
		QueryStatement sql = new QueryStatement();
		sql.setString(project_code);	//���� �� �� ������Ʈ �ڵ�
		sql.setSql(procedure);

		try{

			ds=broker.executeProcedure(sql);
			
			if(ds.next()) {
				MoreCode_return=ds.getString("MoreCode");	//�ش� ��������Ʈ�ڵ忡 ���� �����ڵ� ��������.
				log.debug("[�� ������Ʈ �ڵ� �������� ���� MoreCode(0001���� +1 MAX SELECT ��, ���� ������Ʈ �ߺ�üũ�Ͽ� ����������.) => ���� ����:"+MoreCode_return+" DAO..�� ������Ʈ �ڵ� ����]");
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
	 * CreateDate:2013-12-26(��) Writer:shbyeon.
	 * ������Ʈ �ڵ� ���(������Ʈ �ڵ� �޴� ����ϱ�.)  
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int projectCodeInsertData(ProjectCodeManageDTO pjMgDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ProjectCodeMgRegist (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(pjMgDto.getProjectCode());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ �ڵ�:"+pjMgDto.getProjectCode()+" DAO..]");
		sql.setString(pjMgDto.getProjectDivision());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ ����:"+pjMgDto.getProjectDivision()+" DAO..]");
		sql.setString(pjMgDto.getPurchaseDivision());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ���ֻ� ����:"+pjMgDto.getPurchaseDivision()+" DAO..]");
		sql.setString(pjMgDto.getP_ProjectCode());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ �� ������Ʈ �ڵ�:"+pjMgDto.getP_ProjectCode()+" DAO..]");
		sql.setString(pjMgDto.getP_ProjectName());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ �� ������Ʈ ��:"+pjMgDto.getP_ProjectName()+" DAO..]");
		sql.setString(pjMgDto.getMoreCode());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ �����ڵ�:"+pjMgDto.getMoreCode()+" DAO..]");
		sql.setString(pjMgDto.getPublic_No());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������ȣ:"+pjMgDto.getPublic_No()+" DAO..]");
		sql.setString(pjMgDto.getPub_ProjectName());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ���õ� ������ȣ ������Ʈ��:"+pjMgDto.getPub_ProjectName()+" DAO..]");
		sql.setString(pjMgDto.getProjectName());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ ��:"+pjMgDto.getProjectName()+" DAO..]");
		sql.setString(pjMgDto.getCustomerName());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ���� ��:"+pjMgDto.getCustomerName()+" DAO..]");
		sql.setString(pjMgDto.getPurchaseName());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ���ֻ� ��:"+pjMgDto.getPurchaseName()+" DAO..]");
		sql.setString(pjMgDto.getProjectStartDate());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ ���� ������:"+pjMgDto.getProjectStartDate()+" DAO..]");
		sql.setString(pjMgDto.getProjectEndDate());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ ���� ������:"+pjMgDto.getProjectEndDate()+" DAO..]");
		sql.setInteger(pjMgDto.getProjectProgressDate());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ ����Ⱓ:"+pjMgDto.getProjectProgressDate()+" DAO..]");
		sql.setString(pjMgDto.getChargeID());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ��翵��:"+pjMgDto.getChargeID()+" DAO..]");
		sql.setString(pjMgDto.getChargeProjectManager());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ���PM :"+pjMgDto.getChargeProjectManager()+" DAO..]");
		sql.setString(pjMgDto.getChargeComent());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ���� Comments :"+pjMgDto.getChargeComent()+" DAO..]");
		sql.setString(pjMgDto.getProjectCreateUser());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ �ڵ� ���� ������ :"+pjMgDto.getProjectCreateUser()+" DAO..]");
		sql.setString(pjMgDto.getContractCodeYN());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ �ڵ� ����ڵ� ��뿩�� :"+pjMgDto.getContractCodeYN()+" DAO..]");
		sql.setString(pjMgDto.getProjectProgressFile());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ �ڵ� ������Ʈ ���๮�� ��� :"+pjMgDto.getProjectProgressFile()+" DAO..]");
		sql.setString(pjMgDto.getProjectProgressFileNm());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ �ڵ� ������Ʈ ���๮�� �� :"+pjMgDto.getProjectProgressFileNm()+" DAO..]");
		sql.setString(pjMgDto.getChargeNm());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ �ڵ� ��翵�� �� :"+pjMgDto.getChargeNm()+" DAO..]");
		sql.setString(pjMgDto.getChargePmNm());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ �ڵ� ���PM �� :"+pjMgDto.getChargePmNm()+" DAO..]");
		sql.setString(pjMgDto.getFreeCostYN());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Insert �Ǵ� ������ ������Ʈ ���� ����,����(Y,N) :"+pjMgDto.getFreeCostYN()+" DAO..]");
		
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
	 * CreateDate:2014-01-17(��) Writer:shbyeon.
	 * ������Ʈ �ڵ� ���(����ڵ� ���� ����ڵ� ����Ÿ ��ġ ���̺� ����ϱ�.)  
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
	 * CreateDate:2014-01-25(��) Writer:shbyeon.
	 * ������Ʈ �ڵ� ���(����ڵ� ���� �� ����ڵ� ����Ÿ ��ġ ���̺� �� ����ϱ�.)  
	 * @param PjSeq_Mp,ProjectCode_Mp,ContractCode,Con_ProjectName,SortID
	 * @return retVal
	 * @throws DAOException
	 *
	 */
	public int projectCodeBatchDeleteData(ProjectCodeManageDTO PjMgDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ProjectCodeMpDelete_Cm (?) } "; //����������Ȳ,���������� ��ǰ�ڵ���� ���� ���ν��� ���.

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * CreateDate:2014-01-25(��) Writer:shbyeon.
	 * ������Ʈ �ڵ� ���(����ڵ� ���� �� ����ڵ� ����Ÿ ��ġ ���̺� �� ����ϱ�.)  
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
	 * CreateDate:2014-01-19(��) Writer:shbyeon.
	 * ������Ʈ�ڵ� ������
	 * @param pjMgDto
	 * @return pjMgDto
	 * @throws DAOException
	 */
	public ProjectCodeManageDTO projectCodeMgView(ProjectCodeManageDTO pjMgDto) throws DAOException {

		String procedure = "{ CALL hp_ProjectCodeMgSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * CreateDate:2014-01-19(��) Writer:shbyeon.
	 * ������Ʈ�ڵ� ������(����ڵ� ��� �� ���� ���̺� �ִ� ����ڵ� ����Ÿ Select �ؿ�)
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
				 log.debug("����ڵ� ���� Select While Start.. DAO");
				 ProjectCodeManageDTO pjMgDto_Cm = new ProjectCodeManageDTO();		//����ڵ� ������ DTO
				 pjMgDto_Cm.setPjSeq(rs.getInt("PjSeq"));							//������Ʈ(����ڵ�) PK ������
				 pjMgDto_Cm.setProjectCode(rs.getString("ProjectCode"));    		//������Ʈ �ڵ�
				 pjMgDto_Cm.setContractCode(rs.getString("ContractCode")); 			//����ڵ�
				 pjMgDto_Cm.setCon_ProjectName(rs.getString("Con_ProjectName")); 	//���õ� ����ڵ� ������Ʈ��
				 pjMgDto_Cm.setSortID(rs.getString("SortID")); 						//����ڵ� ���ļ���

				 log.debug("[������Ʈ �ڵ� ������  ContractCode=("+rs.getString("ContractCode")+")Data List Count..DAO");
				 arrDataList.add(pjMgDto_Cm);
				 log.debug("����ڵ� ���� Select While End.. DAO");
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
	 * CreateDate:2013-12-26(��) Writer:shbyeon.
	 * ������Ʈ �ڵ� ���(������Ʈ �ڵ� �޴� ����ϱ�.)  
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int projectCodeUpdateData(ProjectCodeManageDTO pjMgDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ProjectCodeMgModify (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(pjMgDto.getPjSeq());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ PK ������Ʈ ������ PK:"+pjMgDto.getPjSeq()+" DAO..]");
		sql.setString(pjMgDto.getProjectCode());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ �ڵ�:"+pjMgDto.getProjectCode()+" DAO..]");
		sql.setString(pjMgDto.getProjectDivision());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ ����:"+pjMgDto.getProjectDivision()+" DAO..]");
		sql.setString(pjMgDto.getPurchaseDivision());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ���ֻ� ����:"+pjMgDto.getPurchaseDivision()+" DAO..]");
		sql.setString(pjMgDto.getP_ProjectCode());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ �� ������Ʈ �ڵ�:"+pjMgDto.getP_ProjectCode()+" DAO..]");
		sql.setString(pjMgDto.getP_ProjectName());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ �� ������Ʈ ��:"+pjMgDto.getP_ProjectName()+" DAO..]");
		sql.setString(pjMgDto.getMoreCode());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ �����ڵ�:"+pjMgDto.getMoreCode()+" DAO..]");
		sql.setString(pjMgDto.getPublic_No());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������ȣ:"+pjMgDto.getPublic_No()+" DAO..]");
		sql.setString(pjMgDto.getPub_ProjectName());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ���õ� ������ȣ ������Ʈ��:"+pjMgDto.getPub_ProjectName()+" DAO..]");
		sql.setString(pjMgDto.getProjectName());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ ��:"+pjMgDto.getProjectName()+" DAO..]");
		sql.setString(pjMgDto.getCustomerName());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ���� ��:"+pjMgDto.getCustomerName()+" DAO..]");
		sql.setString(pjMgDto.getPurchaseName());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ���ֻ� ��:"+pjMgDto.getPurchaseName()+" DAO..]");
		sql.setString(pjMgDto.getProjectStartDate());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ ���� ������:"+pjMgDto.getProjectStartDate()+" DAO..]");
		sql.setString(pjMgDto.getProjectEndDate());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ ���� ������:"+pjMgDto.getProjectEndDate()+" DAO..]");
		sql.setInteger(pjMgDto.getProjectProgressDate());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ ����Ⱓ:"+pjMgDto.getProjectProgressDate()+" DAO..]");
		sql.setString(pjMgDto.getChargeID());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ��翵��:"+pjMgDto.getChargeID()+" DAO..]");
		sql.setString(pjMgDto.getChargeProjectManager());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ���PM :"+pjMgDto.getChargeProjectManager()+" DAO..]");
		sql.setString(pjMgDto.getChargeComent());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ���� Comments :"+pjMgDto.getChargeComent()+" DAO..]");
		sql.setString(pjMgDto.getProjectUpdateUser());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ �ڵ� ���� ������ :"+pjMgDto.getProjectUpdateUser()+" DAO..]");
		sql.setString(pjMgDto.getContractCodeYN());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ �ڵ� ����ڵ� ��뿩�� :"+pjMgDto.getContractCodeYN()+" DAO..]");
		sql.setString(pjMgDto.getProjectProgressFile());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ ���๮����� :"+pjMgDto.getProjectProgressFile()+" DAO..]");
		sql.setString(pjMgDto.getProjectProgressFileNm());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ ���๮�� �� :"+pjMgDto.getProjectProgressFileNm()+" DAO..]");
		sql.setString(pjMgDto.getChargeNm());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Update �Ǵ� ������ ������Ʈ �ڵ� ��翵�� �� :"+pjMgDto.getChargeNm()+" DAO..]");
		sql.setString(pjMgDto.getChargePmNm());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Update �Ǵ� ������ ������Ʈ �ڵ� ���PM �� :"+pjMgDto.getChargePmNm()+" DAO..]");
		sql.setString(pjMgDto.getFreeCostYN());
		log.debug("[������Ʈ �ڵ� ��� ���̺� Update �Ǵ� ������ ������Ʈ ���� (����,����)���� :"+pjMgDto.getFreeCostYN()+" DAO..]");
		
		
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
	 * CreateDate:2013-12-26(��) Writer:shbyeon.
	 * ������Ʈ �ڵ� ���(������Ʈ �ڵ� �޴� ����ϱ�.)  
	 * @param pjMgDto
	 * @return retVal
	 * @throws DAOException
	 */
	public int projectProgressUpdateData(ProjectCodeManageDTO pjMgDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_ProjectCodeMgModify_Pg (?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(pjMgDto.getPjSeq());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ PK ������Ʈ ������ PK:"+pjMgDto.getPjSeq()+" DAO..]");
		sql.setString(pjMgDto.getProjectEndDate());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ ���� ������:"+pjMgDto.getProjectEndDate()+" DAO..]");
		sql.setInteger(pjMgDto.getProjectProgressDate());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ ����Ⱓ:"+pjMgDto.getProjectProgressDate()+" DAO..]");
		sql.setString(pjMgDto.getChargeProjectManager());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ���PM :"+pjMgDto.getChargeProjectManager()+" DAO..]");
		sql.setString(pjMgDto.getProjectUpdateUser());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ �ڵ� ���� ������ :"+pjMgDto.getProjectUpdateUser()+" DAO..]");
		sql.setInteger(pjMgDto.getProgressPercent());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ ����� :"+pjMgDto.getProgressPercent()+" DAO..]");
		sql.setString(pjMgDto.getCheckSuccessYN());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ �˼��ϷῩ�� :"+pjMgDto.getCheckSuccessYN()+" DAO..]");
		sql.setString(pjMgDto.getCheckDocumentFile());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ �˼������������ :"+pjMgDto.getCheckDocumentFile()+" DAO..]");
		sql.setString(pjMgDto.getCheckDocumentFileNm());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ �˼����������� :"+pjMgDto.getCheckDocumentFileNm()+" DAO..]");
		sql.setString(pjMgDto.getProjectEndYN());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ���Ῡ�� :"+pjMgDto.getProjectEndYN()+" DAO..]");
		sql.setString(pjMgDto.getProjectEndDocumentFile());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ �������⹰ ��� :"+pjMgDto.getProjectEndDocumentFile()+" DAO..]");
		sql.setString(pjMgDto.getProjectEndDocumentFileNm());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ �������⹰ �� :"+pjMgDto.getProjectEndDocumentFileNm()+" DAO..]");
		sql.setString(pjMgDto.getChargePmNm());
		log.debug("[������Ʈ �ڵ� ���� ���̺� Update �Ǵ� ������ ������Ʈ ���PM�� :"+pjMgDto.getChargePmNm()+" DAO..]");
		
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
