package com.huation.common.newsmagazine;

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
import com.huation.common.newsmagazine.NewsMagazineDTO;
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

public class NewsMagazineDAO extends AbstractDAO {
 
	/*
	 * 게시판 = > News&Magazine 등록_2012_10_24(수)bsh
	 */
	public int addNewsRegist(NewsMagazineDTO nmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_News_MagazineRegist (?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(nmDto.getWriteUser());
		log.debug("유저"+nmDto.getWriteUser());
		sql.setString(nmDto.getNewsFile());
		log.debug("파일경로1"+nmDto.getNewsFile());
		sql.setString(nmDto.getNewsFileNm());
		log.debug("파일이름1"+nmDto.getNewsFileNm());
		sql.setString(nmDto.getTitle());
		log.debug("제목1"+nmDto.getTitle());
		sql.setString(nmDto.getContents());
		log.debug("내용1"+nmDto.getContents());
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
	 * News&Magazine 리스트.
	 * 
	 * @param userDto
	 *            사용자 정보
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO dispNewsPageList(NewsMagazineDTO nmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_News_MagazineInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(nmDto.getChUserID()); // 세션 아이디
		sql.setString(nmDto.getvSearchType()); // 검색구분
		sql.setString(nmDto.getvSearch()); // 검색어
		sql.setInteger(nmDto.getnRow()); // 리스트 갯수
		sql.setInteger(nmDto.getnPage()); // 현제 페이지
		sql.setString("PAGE"); // sp 구분

		try {
			retVal = broker.executePageProcedure(sql, nmDto.getnPage(),
					nmDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}

	/**
	 * News&Magazine 상세정보
	 * 
	 */
	public NewsMagazineDTO newsMagazineView(NewsMagazineDTO nmDto) throws DAOException {

		String procedure = "{ CALL hp_News_MagazineSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(nmDto.getSeq());

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				nmDto = new NewsMagazineDTO();
				nmDto.setSeq(ds.getInt("Seq"));
				nmDto.setWriteUser(ds.getString("WriteUser"));
				nmDto.setWriteUserName(ds.getString("WriteUserName"));
				nmDto.setNewsFile(ds.getString("NewsFile"));
				nmDto.setNewsFileNm(ds.getString("NewsFileNm"));
				nmDto.setTitle(ds.getString("Title"));
				nmDto.setContents(ds.getString("Contents"));
				//조회수 를 증가시키기 위해 ReadCount를 먼저 셀렉트 해온다.
				nmDto.setReadCount(ds.getInt("ReadCount"));
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

		return nmDto;
	}

	/*
	 * News&Magazine = > 수정
	 */
	public int newsMagazineUpdate(NewsMagazineDTO nmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_News_MagazineModify (?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(nmDto.getSeq());
		sql.setString(nmDto.getWriteUser());
		sql.setString(nmDto.getNewsFile());
		sql.setString(nmDto.getNewsFileNm());
		sql.setString(nmDto.getTitle());
		sql.setString(nmDto.getContents());
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
	 * News&Magazine => 삭제
	 */
	public int deleteNewsMagazineOne(NewsMagazineDTO nmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_News_MagazineDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(nmDto.getSeq());
		
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
	 * News&Magazine => 조회수증가
	 */
	public int newsMagazineCount(NewsMagazineDTO nmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_News_MagazineReadCount (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(nmDto.getSeq());
		sql.setInteger(nmDto.getReadCount());
		System.out.println("Readcount::"+nmDto.getReadCount());
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