package com.huation.common.project_h;

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
import com.huation.common.project_h.NonProject_H_DTO;
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

public class NonProject_H_DAO extends AbstractDAO {

	/*
	 * ������Ʈ ���� = ���������� ���(�Ѽ�)
	 */
	public int addProject_Non_H(NonProject_H_DTO npjDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_pjNonRoutineRegist_H (?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(npjDto.getCompanyCode());
		sql.setString(npjDto.getCheckReason());
		sql.setString(npjDto.getStartDateTime());
		sql.setString(npjDto.getEndDateTime());
		sql.setString(npjDto.getChargeID());
		sql.setString(npjDto.getRequestNm());
		sql.setString(npjDto.getWorkSite());
		sql.setString(npjDto.getWorkContents());
		sql.setString(npjDto.getIssueReport());
		sql.setString(npjDto.getReportFile());
		sql.setString(npjDto.getFileNm());
		sql.setString(npjDto.getChUserID());

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
	 * ���������� ����Ʈ.(�Ѽ�)
	 * 
	 * @param userDto
	 *            ����� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO ProjectPageList_Non_H(NonProject_H_DTO npjDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_pjNonRoutineInquiry_H ( ?,?,?,?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(npjDto.getChUserID()); // ���� ���̵�
		sql.setString(npjDto.getvSearchType()); // �˻�����
		sql.setString(npjDto.getvSearch()); // �˻���
		sql.setInteger(npjDto.getnRow()); // ����Ʈ ����
		sql.setInteger(npjDto.getnPage()); // ���� ������
		sql.setString("PAGE"); // sp ����
		sql.setString(npjDto.getFrDate());//������
		sql.setString(npjDto.getToDate());//�Ϸ���
		sql.setString(npjDto.getCompanyCode());//�ڵ�˻�(����Ʈ��)

		try {
			retVal = broker.executePageProcedure(sql, npjDto.getnPage(),
					npjDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}

	/**
	 * ����������(����Ʈ) ����(�Ѽ�)
	 * 
	 * @param userid
	 * @return userDto ��������(����Ʈ) ����
	 * @throws DAOException
	 */
	public NonProject_H_DTO projectView_Non_H(NonProject_H_DTO npjDto) throws DAOException {

		String procedure = "{ CALL hp_pjNonRoutineSelect_H (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(npjDto.getSeq());

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				npjDto = new NonProject_H_DTO();
				npjDto.setSeq(ds.getInt("Seq"));
				npjDto.setCompanyCode(ds.getString("CompanyCode"));
				npjDto.setCheckReason(ds.getString("CheckReason"));
				npjDto.setStartDateTime(ds.getString("StartDateTime"));
				npjDto.setStartDate(ds.getString("StartDate"));
				npjDto.setStartTime(ds.getString("StartTime"));
				npjDto.setEndDateTime(ds.getString("EndDateTime"));
				npjDto.setEndDate(ds.getString("EndDate"));
				npjDto.setEndTime(ds.getString("EndTime"));
				npjDto.setChargeID(ds.getString("ChargeID"));
				npjDto.setChargeName(ds.getString("ChargeName"));
				npjDto.setRequestNm(ds.getString("RequestNm"));
				npjDto.setWorkSite(ds.getString("WorkSite"));
				npjDto.setWorkContents(ds.getString("WorkContents"));
				npjDto.setIssueReport(ds.getString("IssueReport"));
				npjDto.setCreateDateTime(ds.getString("CreateDateTime"));
				npjDto.setUpdateDateTime(ds.getString("UpdateDateTime"));
				npjDto.setReportFile(ds.getString("ReportFile"));
				npjDto.setDeletedYN(ds.getString("DeletedYN"));
				npjDto.setFileNm(ds.getString("FileNm"));
				npjDto.setCreateUserID(ds.getString("CreateUserID"));
				npjDto.setChUserID(ds.getString("chUserID"));
				npjDto.setCreateUserName(ds.getString("CreateUserName"));
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

		return npjDto;
	}

	/**
	 * ����������(����Ʈ) ����(�Ѽ�)
	 * 
	 * @param userid
	 * @return userDto ��������(����Ʈ) ����
	 * @throws DAOException
	 */
	public int editProject_Non_H(NonProject_H_DTO npjDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_pjNonRoutineModify_H (?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(npjDto.getSeq());
		sql.setString(npjDto.getCompanyCode());
		sql.setString(npjDto.getCheckReason());
		sql.setString(npjDto.getStartDateTime());
		sql.setString(npjDto.getEndDateTime());
		sql.setString(npjDto.getChargeID());
		sql.setString(npjDto.getRequestNm());
		sql.setString(npjDto.getWorkSite());
		sql.setString(npjDto.getWorkContents());
		sql.setString(npjDto.getIssueReport());
		sql.setString(npjDto.getReportFile());
		sql.setString(npjDto.getFileNm());
		sql.setString(npjDto.getChUserID());

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
	 * ������Ʈ ���� = ���������� ����(�Ѽ�)
	 */
	public int deleteProjectOne_Non_H(NonProject_H_DTO npjDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_pjNonRoutineDelete_H (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(npjDto.getSeq());

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
	 * �����˻���Ʈ EXCEL ����Ʈ (�Ѽ�)
	 * @param pjDto
	 * @return ListDTO
	 * @throws DAOException
	 */	
	public ListDTO projectListExcel_Non_H(NonProject_H_DTO npjDTO) throws DAOException{
			
			String procedure = " { CALL hp_pjNonRoutineInquiry_H (?,?,?,?,?,?,?,?,?) } ";
			
			ListDTO retVal = null;

			QueryStatement sql = new QueryStatement();
			
			sql.setSql(procedure); // ���ν��� ��
			sql.setString(npjDTO.getChUserID()); // ���� ���̵�
			sql.setString(npjDTO.getvSearchType()); // �˻�����
			sql.setString(npjDTO.getvSearch()); // �˻���
			sql.setInteger(npjDTO.getnRow()); // ����Ʈ ����
			sql.setInteger(npjDTO.getnPage()); // ���� ������
			sql.setString("LIST"); // sp ����
			sql.setString(npjDTO.getFrDate());//������
			sql.setString(npjDTO.getToDate());//�Ϸ���
			sql.setString(npjDTO.getCompanyCode());//�ڵ�˻�(����Ʈ��)

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