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
	 * �Խ��� = > News&Magazine ���_2012_10_24(��)bsh
	 */
	public int addNewsRegist(NewsMagazineDTO nmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_News_MagazineRegist (?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(nmDto.getWriteUser());
		log.debug("����"+nmDto.getWriteUser());
		sql.setString(nmDto.getNewsFile());
		log.debug("���ϰ��1"+nmDto.getNewsFile());
		sql.setString(nmDto.getNewsFileNm());
		log.debug("�����̸�1"+nmDto.getNewsFileNm());
		sql.setString(nmDto.getTitle());
		log.debug("����1"+nmDto.getTitle());
		sql.setString(nmDto.getContents());
		log.debug("����1"+nmDto.getContents());
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
	 * News&Magazine ����Ʈ.
	 * 
	 * @param userDto
	 *            ����� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO dispNewsPageList(NewsMagazineDTO nmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_News_MagazineInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(nmDto.getChUserID()); // ���� ���̵�
		sql.setString(nmDto.getvSearchType()); // �˻�����
		sql.setString(nmDto.getvSearch()); // �˻���
		sql.setInteger(nmDto.getnRow()); // ����Ʈ ����
		sql.setInteger(nmDto.getnPage()); // ���� ������
		sql.setString("PAGE"); // sp ����

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
	 * News&Magazine ������
	 * 
	 */
	public NewsMagazineDTO newsMagazineView(NewsMagazineDTO nmDto) throws DAOException {

		String procedure = "{ CALL hp_News_MagazineSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
				//��ȸ�� �� ������Ű�� ���� ReadCount�� ���� ����Ʈ �ؿ´�.
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
	 * News&Magazine = > ����
	 */
	public int newsMagazineUpdate(NewsMagazineDTO nmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_News_MagazineModify (?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * News&Magazine => ����
	 */
	public int deleteNewsMagazineOne(NewsMagazineDTO nmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_News_MagazineDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * News&Magazine => ��ȸ������
	 */
	public int newsMagazineCount(NewsMagazineDTO nmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_News_MagazineReadCount (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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