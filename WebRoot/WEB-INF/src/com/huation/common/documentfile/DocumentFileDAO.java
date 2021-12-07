package com.huation.common.documentfile;

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
import com.huation.common.documentfile.DocumentFileDTO;
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

public class DocumentFileDAO extends AbstractDAO {

	/* 
	 * 업무 문서파일 = 등록_2012_10_24(수)bsh
	 */
	public int addDocumentFileRegist(DocumentFileDTO dfDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_DocumentFileRegist (?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(dfDto.getWriteUser());
		sql.setString(dfDto.getWriteFormUser());
		sql.setString(dfDto.getFormGroup());
		//log.debug("유저"+ffDto.getWriteUser());
		sql.setString(dfDto.getDocumentFile());
		//log.debug("파일경로1"+ffDto.getNotifyFile());
		sql.setString(dfDto.getDocumentFileNm());
		//log.debug("파일이름1"+ffDto.getNotifyFileNm());
		sql.setString(dfDto.getTitle());
		//log.debug("제목1"+ffDto.getTitle());
		sql.setString(dfDto.getContents());
		//log.debug("내용1"+ffDto.getContents());
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
	 * 업무 문서파일 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO documentFilePageList(DocumentFileDTO dfDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_DocumentFileInquiry ( ?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		// 세션 아이디 sql.setString(ffDto.getChUserID()); 
		sql.setString(dfDto.getvSearchType()); // 검색구분
		sql.setString(dfDto.getvSearch()); // 검색어
		sql.setInteger(dfDto.getnRow()); // 리스트 갯수
		sql.setInteger(dfDto.getnPage()); // 현제 페이지
		sql.setString("PAGE"); // sp 구분

		try {
			retVal = broker.executePageProcedure(sql, dfDto.getnPage(),
					dfDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}

	/**
	 * 업무 문서파일(상세) 정보
	 * 
	 */
	public DocumentFileDTO documentfileView(DocumentFileDTO dfDto) throws DAOException {

		String procedure = "{ CALL hp_DocumentFileSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(dfDto.getSeq());

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				dfDto = new DocumentFileDTO();
				dfDto.setSeq(ds.getInt("Seq"));
				dfDto.setWriteUser(ds.getString("WriteUser"));
				dfDto.setWriteUserName(ds.getString("WriteUserName"));
				dfDto.setWriteFormUser(ds.getString("WriteFormUser"));
				dfDto.setWriteFormUserNm(ds.getString("WriteFormUserNm"));
				dfDto.setFormGroup(ds.getString("FormGroup"));
				dfDto.setFormGroupNm(ds.getString("FormGroupNm"));
				dfDto.setDocumentFile(ds.getString("DocumentFile"));
				dfDto.setDocumentFileNm(ds.getString("DocumentFileNm"));
				dfDto.setTitle(ds.getString("Title"));
				dfDto.setContents(ds.getString("Contents"));
				//조회수 를 증가시키기 위해 ReadCount를 먼저 셀렉트 해온다.
				dfDto.setReadCount(ds.getInt("ReadCount"));
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

		return dfDto;
	}

	/*
	 * 업무 문서파일 => 조회수증가
	 */
	public int documentFileCount(DocumentFileDTO dfDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_DocumentFileReadCount (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(dfDto.getSeq());
		sql.setInteger(dfDto.getReadCount());
		System.out.println("Readcount::"+dfDto.getReadCount());
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
	 * 업무 문서파일 = > 수정
	 */
	public int documentFileUpdate(DocumentFileDTO dfDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_DocumentFileModify (?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(dfDto.getSeq());
		sql.setString(dfDto.getWriteFormUser());
		sql.setString(dfDto.getFormGroup());
		sql.setString(dfDto.getDocumentFile());
		sql.setString(dfDto.getDocumentFileNm());
		sql.setString(dfDto.getTitle());
		sql.setString(dfDto.getContents());
		sql.setString(dfDto.getUpdateUser());
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
	 * 업무 문서파일 => 삭제
	 */ 
	public int deleteDocumentFileOne(DocumentFileDTO dfDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_DocumentFileDelete (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(dfDto.getSeq()); //pk
		sql.setString(dfDto.getDeletedUser());

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