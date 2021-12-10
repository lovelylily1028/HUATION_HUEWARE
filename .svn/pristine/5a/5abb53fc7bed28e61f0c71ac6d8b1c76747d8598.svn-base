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
	 * 프로젝트 지원 = 비정기점검 등록(한솔)
	 */
	public int addProject_Non_H(NonProject_H_DTO npjDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_pjNonRoutineRegist_H (?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
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
	 * 비정기점검 리스트.(한솔)
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO ProjectPageList_Non_H(NonProject_H_DTO npjDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_pjNonRoutineInquiry_H ( ?,?,?,?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(npjDto.getChUserID()); // 세션 아이디
		sql.setString(npjDto.getvSearchType()); // 검색구분
		sql.setString(npjDto.getvSearch()); // 검색어
		sql.setInteger(npjDto.getnRow()); // 리스트 갯수
		sql.setInteger(npjDto.getnPage()); // 현제 페이지
		sql.setString("PAGE"); // sp 구분
		sql.setString(npjDto.getFrDate());//시작일
		sql.setString(npjDto.getToDate());//완료일
		sql.setString(npjDto.getCompanyCode());//코드검색(사이트명)

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
	 * 비정기점검(사이트) 정보(한솔)
	 * 
	 * @param userid
	 * @return userDto 정기점검(사이트) 정보
	 * @throws DAOException
	 */
	public NonProject_H_DTO projectView_Non_H(NonProject_H_DTO npjDto) throws DAOException {

		String procedure = "{ CALL hp_pjNonRoutineSelect_H (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
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
	 * 비정기점검(사이트) 수정(한솔)
	 * 
	 * @param userid
	 * @return userDto 정기점검(사이트) 정보
	 * @throws DAOException
	 */
	public int editProject_Non_H(NonProject_H_DTO npjDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_pjNonRoutineModify_H (?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
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
	 * 프로젝트 지원 = 비정기점검 삭제(한솔)
	 */
	public int deleteProjectOne_Non_H(NonProject_H_DTO npjDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_pjNonRoutineDelete_H (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
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
	 * 비점검사이트 EXCEL 리스트 (한솔)
	 * @param pjDto
	 * @return ListDTO
	 * @throws DAOException
	 */	
	public ListDTO projectListExcel_Non_H(NonProject_H_DTO npjDTO) throws DAOException{
			
			String procedure = " { CALL hp_pjNonRoutineInquiry_H (?,?,?,?,?,?,?,?,?) } ";
			
			ListDTO retVal = null;

			QueryStatement sql = new QueryStatement();
			
			sql.setSql(procedure); // 프로시져 명
			sql.setString(npjDTO.getChUserID()); // 세션 아이디
			sql.setString(npjDTO.getvSearchType()); // 검색구분
			sql.setString(npjDTO.getvSearch()); // 검색어
			sql.setInteger(npjDTO.getnRow()); // 리스트 갯수
			sql.setInteger(npjDTO.getnPage()); // 현제 페이지
			sql.setString("LIST"); // sp 구분
			sql.setString(npjDTO.getFrDate());//시작일
			sql.setString(npjDTO.getToDate());//완료일
			sql.setString(npjDTO.getCompanyCode());//코드검색(사이트명)

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