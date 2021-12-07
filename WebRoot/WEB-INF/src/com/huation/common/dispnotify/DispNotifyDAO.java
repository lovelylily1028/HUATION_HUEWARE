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
	 * �Խ��� = > ������� ���
	 */
	public int addNotifyRegist(DispNotifyDTO disDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_DispNotifyRegist (?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(disDto.getWriteUser());
		log.debug("����"+disDto.getWriteUser());
		sql.setString(disDto.getNotifyFile());
		log.debug("���ϰ��1"+disDto.getNotifyFile());
		sql.setString(disDto.getNotifyFileNm());
		log.debug("�����̸�1"+disDto.getNotifyFileNm());
		sql.setString(disDto.getTitle());
		log.debug("����1"+disDto.getTitle());
		sql.setString(disDto.getContents());
		log.debug("����1"+disDto.getContents());
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
	 * ������� ����Ʈ.
	 * 
	 * @param userDto
	 *            ����� ����
	 * @return ListDTO
	 * @throws DAOException
	 */
	public ListDTO dispNotifyPageList(DispNotifyDTO disDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_DispNotifyInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(disDto.getChUserID()); // ���� ���̵�
		sql.setString(disDto.getvSearchType()); // �˻�����
		sql.setString(disDto.getvSearch()); // �˻���
		sql.setInteger(disDto.getnRow()); // ����Ʈ ����
		sql.setInteger(disDto.getnPage()); // ���� ������
		sql.setString("PAGE"); // sp ����

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
	 * �������(��) ����
	 * 
	 */
	public DispNotifyDTO dispNotifyView(DispNotifyDTO disDto) throws DAOException {

		String procedure = "{ CALL hp_DispNotifySelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
				//��ȸ�� �� ������Ű�� ���� ReadCount�� ���� ����Ʈ �ؿ´�.
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
	 * ������� = > ����
	 */
	public int NotifyUpdate(DispNotifyDTO disDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_DispNotifyModify (?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * ������� => ����
	 */
	public int deletedispNotifyOne(DispNotifyDTO disDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_DispNotifyDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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
	 * ������� => ��ȸ������
	 */
	public int dispNotifyCount(DispNotifyDTO disDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_DispNotifyReadCount (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
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