package com.huation.common.project;

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
import com.huation.common.company.CompanyDTO;
import com.huation.common.project.ProjectDTO;
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

public class ProjectDAO extends AbstractDAO {

	/*
	 * ������Ʈ ���� = ���
	 */
	public int addProject(ProjectDTO hsDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_pjRoutineRegist (?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(hsDto.getCompanyCode());
		sql.setString(hsDto.getStartDateTime());
		sql.setString(hsDto.getEndDateTime());
		sql.setString(hsDto.getTargetMonth());
		sql.setString(hsDto.getChargeID());
		sql.setString(hsDto.getCustChargeNm());
		sql.setString(hsDto.getWorkSite());
		sql.setString(hsDto.getWorkContents());
		sql.setString(hsDto.getIssueReport());
		sql.setString(hsDto.getReportFile());
		sql.setString(hsDto.getFileNm());
		sql.setString(hsDto.getChUserID());
		//System.out.println("dao, sql : "+sql);
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
	 * �������� ����Ʈ.
	 * 
	 * @param userDto
	 *            ����� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO ProjectPageList(ProjectDTO pjDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_pjRoutineInquiry ( ?,?,?,?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(pjDto.getChUserID()); // ���� ���̵�
		sql.setString(pjDto.getvSearchType()); // �˻�����
		sql.setString(pjDto.getvSearch()); // �˻���
		sql.setInteger(pjDto.getnRow()); // ����Ʈ ����
		sql.setInteger(pjDto.getnPage()); // ���� ������
		sql.setString("PAGE"); // sp ����
		sql.setString(pjDto.getFrDate());//������
		sql.setString(pjDto.getToDate());//�Ϸ���
		sql.setString(pjDto.getCompanyCode());//�ڵ�˻�(����Ʈ��)

		try {
			retVal = broker.executePageProcedure(sql, pjDto.getnPage(),
					pjDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	/**
	 * �������� ����Ʈ(����).
	 * 
	 * @param userDto
	 *            ����� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO ProjectPageListAll(ProjectDTO pjDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_pjRoutineInquiry_all ( ?,?,?,?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(pjDto.getChUserID()); // ���� ���̵�
		sql.setString(pjDto.getvSearchType()); // �˻�����
		sql.setString(pjDto.getvSearch()); // �˻���
		sql.setInteger(pjDto.getnRow()); // ����Ʈ ����
		sql.setInteger(pjDto.getnPage()); // ���� ������
		sql.setString("PAGE"); // sp ����
		sql.setString(pjDto.getFrDate());//������
		sql.setString(pjDto.getToDate());//�Ϸ���
		sql.setString(pjDto.getCompanyCode());//�ڵ�˻�(����Ʈ��)

		try {
			retVal = broker.executePageProcedure(sql, pjDto.getnPage(),
					pjDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;
	}
	

	/**
	 * ��������(����Ʈ) ����
	 * 
	 * @param userid
	 * @return userDto ��������(����Ʈ) ����
	 * @throws DAOException
	 */
	public ProjectDTO projectView(ProjectDTO pjDto) throws DAOException {

		String procedure = "{ CALL hp_pjRoutineSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(pjDto.getSeq());

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				pjDto = new ProjectDTO();
				pjDto.setSeq(ds.getInt("Seq"));
				pjDto.setCompanyCode(ds.getString("CompanyCode"));
				pjDto.setStartDateTime(ds.getString("StartDateTime"));
				pjDto.setStartDate(ds.getString("StartDate"));
				pjDto.setStartTime(ds.getString("StartTime"));
				pjDto.setEndDateTime(ds.getString("EndDateTime"));
				pjDto.setEndDate(ds.getString("EndDate"));
				pjDto.setEndTime(ds.getString("EndTime"));
				pjDto.setTargetMonth(ds.getString("TargetMonth"));
				pjDto.setChargeID(ds.getString("ChargeID"));
				pjDto.setChargeName(ds.getString("ChargeName"));
				pjDto.setCustChargeNm(ds.getString("CustChargeNm"));
				pjDto.setWorkSite(ds.getString("WorkSite"));
				pjDto.setWorkContents(ds.getString("WorkContents"));
				pjDto.setIssueReport(ds.getString("IssueReport"));
				pjDto.setCreateDateTime(ds.getString("CreateDateTime"));
				pjDto.setUpdateDateTime(ds.getString("UpdateDateTime"));
				pjDto.setReportFile(ds.getString("ReportFile"));
				pjDto.setDeletedYN(ds.getString("DeletedYN"));
				pjDto.setFileNm(ds.getString("FileNm"));
				pjDto.setCreateUserID(ds.getString("CreateUserID"));
				pjDto.setChUserID(ds.getString("chUserID"));
				pjDto.setCreateUserName(ds.getString("CreateUserName"));
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

		return pjDto;
	}

	/*
	 * ������Ʈ ���� = ����
	 */
	public int editProject(ProjectDTO pjDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_pjRoutineModify (?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(pjDto.getSeq());
		sql.setString(pjDto.getCompanyCode());
		sql.setString(pjDto.getStartDateTime());
		sql.setString(pjDto.getEndDateTime());
		sql.setString(pjDto.getTargetMonth());
		sql.setString(pjDto.getChargeID());
		sql.setString(pjDto.getCustChargeNm());
		sql.setString(pjDto.getWorkSite());
		sql.setString(pjDto.getWorkContents());
		sql.setString(pjDto.getIssueReport());
		sql.setString(pjDto.getReportFile());
		sql.setString(pjDto.getFileNm());
		log.debug("FileNm2:"+pjDto.getFileNm());
		sql.setString(pjDto.getChUserID());
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
	 * ������Ʈ ���� = ����
	 */
	public int deleteProjectOne(ProjectDTO pjDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_pjRoutineDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(pjDto.getSeq());

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
	 * ���˻���Ʈ EXCEL ����Ʈ 
	 * @param pjDto
	 * @return ListDTO
	 * @throws DAOException
	 */	
	public ListDTO projectListExcel(ProjectDTO pjDTO) throws DAOException{
			
			String procedure = "";
			if ("A".equals(pjDTO.getListType()) ) {
				procedure = " { CALL hp_pjRoutineInquiry_all (?,?,?,?,?,?,?,?,?) } ";
			} else {
				procedure = " { CALL hp_pjRoutineInquiry (?,?,?,?,?,?,?,?,?) } ";
			}
			
			ListDTO retVal = null;

			QueryStatement sql = new QueryStatement();
			
			sql.setSql(procedure); // ���ν��� ��
			sql.setString(pjDTO.getChUserID()); // ���� ���̵�
			sql.setString(pjDTO.getvSearchType()); // �˻�����
			sql.setString(pjDTO.getvSearch()); // �˻���
			sql.setInteger(pjDTO.getnRow()); // ����Ʈ ����
			sql.setInteger(pjDTO.getnPage()); // ���� ������
			log.debug("Page3:"+pjDTO.getnPage());
			sql.setString("LIST"); // sp ����
			sql.setString(pjDTO.getFrDate());//������
			sql.setString(pjDTO.getToDate());//�Ϸ���
			sql.setString(pjDTO.getCompanyCode());//�ڵ�˻�(����Ʈ��)

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
	
}