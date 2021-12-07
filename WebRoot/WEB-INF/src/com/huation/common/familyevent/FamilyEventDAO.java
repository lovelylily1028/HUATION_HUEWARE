package com.huation.common.familyevent;

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
import com.huation.common.familyevent.FamilyEventDTO;
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

public class FamilyEventDAO extends AbstractDAO {
 
	/*
	 * 게시판 = > 경조사 등록
	 */
	public int addEventRegist(FamilyEventDTO feDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FamilyEventRegist (?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(feDto.getWriteUser());
		log.debug("유저"+feDto.getWriteUser());
		sql.setString(feDto.getEventFile());
		log.debug("파일경로1"+feDto.getEventFile());
		sql.setString(feDto.getEventFileNm());
		log.debug("파일이름1"+feDto.getEventFileNm());
		sql.setString(feDto.getTitle());
		log.debug("제목1"+feDto.getTitle());
		sql.setString(feDto.getContents());
		log.debug("내용1"+feDto.getContents());
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
	 * 전사공지 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO dispEventPageList(FamilyEventDTO feDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_FamilyEventInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(feDto.getChUserID()); // 세션 아이디
		sql.setString(feDto.getvSearchType()); // 검색구분
		sql.setString(feDto.getvSearch()); // 검색어
		sql.setInteger(feDto.getnRow()); // 리스트 갯수
		sql.setInteger(feDto.getnPage()); // 현제 페이지
		sql.setString("PAGE"); // sp 구분

		try {
			retVal = broker.executePageProcedure(sql, feDto.getnPage(),
					feDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}

	/**
	 * 전사공지(상세) 정보
	 * 
	 */
	public FamilyEventDTO dispEventView(FamilyEventDTO feDto) throws DAOException {

		String procedure = "{ CALL hp_FamilyEventSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(feDto.getSeq());

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				feDto = new FamilyEventDTO();
				feDto.setSeq(ds.getInt("Seq"));
				feDto.setWriteUser(ds.getString("WriteUser"));
				feDto.setWriteUserName(ds.getString("WriteUserName"));
				feDto.setEventFile(ds.getString("EventFile"));
				feDto.setEventFileNm(ds.getString("EventFileNm"));
				feDto.setTitle(ds.getString("Title"));
				feDto.setContents(ds.getString("Contents"));
				//조회수 를 증가시키기 위해 ReadCount를 먼저 셀렉트 해온다.
				feDto.setReadCount(ds.getInt("ReadCount"));
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

		return feDto;
	}
	/*
	 * 경조사 => 조회수증가
	 */
	public int familyEventCount(FamilyEventDTO feDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FamilyEventReadCount (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(feDto.getSeq());
		sql.setInteger(feDto.getReadCount());
		System.out.println("Readcount::"+feDto.getReadCount());
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
	 * 경조사 = > 수정
	 */
	public int EventUpdate(FamilyEventDTO feDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FamilyEventModify (?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(feDto.getSeq());
		sql.setString(feDto.getWriteUser());
		sql.setString(feDto.getEventFile());
		sql.setString(feDto.getEventFileNm());
		sql.setString(feDto.getTitle());
		sql.setString(feDto.getContents());
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
	 * 경조사 => 삭제
	 */
	public int deleteEventOne(FamilyEventDTO feDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FamilyEventDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(feDto.getSeq());

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