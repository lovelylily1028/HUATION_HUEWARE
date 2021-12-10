package com.huation.common.dispnotify;

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
import com.huation.common.dispnotify.DispNotifyDTO;
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

public class DispNotifyDAO extends AbstractDAO {
 
	/*
	 * 게시판 = > 전사공지 등록
	 */
	public int addNotifyRegist(DispNotifyDTO disDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_DispNotifyRegist (?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(disDto.getWriteUser());
		log.debug("유저"+disDto.getWriteUser());
		sql.setString(disDto.getNotifyFile());
		log.debug("파일경로1"+disDto.getNotifyFile());
		sql.setString(disDto.getNotifyFileNm());
		log.debug("파일이름1"+disDto.getNotifyFileNm());
		sql.setString(disDto.getTitle());
		log.debug("제목1"+disDto.getTitle());
		sql.setString(disDto.getContents());
		log.debug("내용1"+disDto.getContents());
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
	public ListDTO dispNotifyPageList(DispNotifyDTO disDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_DispNotifyInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(disDto.getChUserID()); // 세션 아이디
		sql.setString(disDto.getvSearchType()); // 검색구분
		sql.setString(disDto.getvSearch()); // 검색어
		sql.setInteger(disDto.getnRow()); // 리스트 갯수
		sql.setInteger(disDto.getnPage()); // 현제 페이지
		sql.setString("PAGE"); // sp 구분

		try {
			retVal = broker.executePageProcedure(sql, disDto.getnPage(),
					disDto.getnRow());

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
	public DispNotifyDTO dispNotifyView(DispNotifyDTO disDto) throws DAOException {

		String procedure = "{ CALL hp_DispNotifySelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(disDto.getSeq());

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				disDto = new DispNotifyDTO();
				disDto.setSeq(ds.getInt("Seq"));
				disDto.setWriteUser(ds.getString("WriteUser"));
				disDto.setWriteUserName(ds.getString("WriteUserName"));
				disDto.setNotifyFile(ds.getString("NotifyFile"));
				disDto.setNotifyFileNm(ds.getString("NotifyFileNm"));
				disDto.setTitle(ds.getString("Title"));
				disDto.setContents(ds.getString("Contents"));
				//조회수 를 증가시키기 위해 ReadCount를 먼저 셀렉트 해온다.
				disDto.setReadCount(ds.getInt("ReadCount"));
					System.out.println("ViewREADCOUNT::"+ds.getInt("ReadCount"));
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

		return disDto;
	}

	/*
	 * 전사공지 = > 수정
	 */
	public int NotifyUpdate(DispNotifyDTO disDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_DispNotifyModify (?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(disDto.getSeq());
		sql.setString(disDto.getWriteUser());
		sql.setString(disDto.getNotifyFile());
		sql.setString(disDto.getNotifyFileNm());
		sql.setString(disDto.getTitle());
		sql.setString(disDto.getContents());
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
	 * 전사공지 => 삭제
	 */
	public int deletedispNotifyOne(DispNotifyDTO disDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_DispNotifyDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(disDto.getSeq());
		
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
	 * 전사공지 => 조회수증가
	 */
	public int dispNotifyCount(DispNotifyDTO disDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_DispNotifyReadCount (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(disDto.getSeq());
		sql.setInteger(disDto.getReadCount());
		System.out.println("Readcount::"+disDto.getReadCount());
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