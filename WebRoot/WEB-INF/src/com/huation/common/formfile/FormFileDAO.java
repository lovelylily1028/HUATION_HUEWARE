package com.huation.common.formfile;

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

public class FormFileDAO extends AbstractDAO {

	/* 
	 * �������� = ���
	 */
	public int addFormFileRegist(FormFileDTO ffDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FormFileRegist (?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(ffDto.getWriteUser());
		sql.setString(ffDto.getWriteFormUser());
		sql.setString(ffDto.getFormGroup());
		//log.debug("����"+ffDto.getWriteUser());
		sql.setString(ffDto.getFormFile());
		//log.debug("���ϰ��1"+ffDto.getNotifyFile());
		sql.setString(ffDto.getFormFileNm());
		//log.debug("�����̸�1"+ffDto.getNotifyFileNm());
		sql.setString(ffDto.getTitle());
		//log.debug("����1"+ffDto.getTitle());
		sql.setString(ffDto.getContents());
		//log.debug("����1"+ffDto.getContents());
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
	public ListDTO formFilePageList(FormFileDTO ffDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_FormFileInquiry ( ?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		// ���� ���̵� sql.setString(ffDto.getChUserID()); 
		sql.setString(ffDto.getvSearchType()); // �˻�����
		sql.setString(ffDto.getvSearch()); // �˻���
		sql.setInteger(ffDto.getnRow()); // ����Ʈ ����
		sql.setInteger(ffDto.getnPage()); // ���� ������
		sql.setString("PAGE"); // sp ����

		try {
			retVal = broker.executePageProcedure(sql, ffDto.getnPage(),
					ffDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}

	/**
	 * ��������(��) ����
	 * 
	 */
	public FormFileDTO formfileView(FormFileDTO ffDto) throws DAOException {

		String procedure = "{ CALL hp_FormFileSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(ffDto.getSeq());

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				ffDto = new FormFileDTO();
				ffDto.setSeq(ds.getInt("Seq"));
				ffDto.setWriteUser(ds.getString("WriteUser"));
				ffDto.setWriteUserName(ds.getString("WriteUserName"));
				ffDto.setWriteFormUser(ds.getString("WriteFormUser"));
				ffDto.setWriteFormUserNm(ds.getString("WriteFormUserNm"));
				ffDto.setFormGroup(ds.getString("FormGroup"));
				ffDto.setFormGroupNm(ds.getString("FormGroupNm"));
				ffDto.setFormFile(ds.getString("FormFile"));
				ffDto.setFormFileNm(ds.getString("FormFileNm"));
				ffDto.setTitle(ds.getString("Title"));
				ffDto.setContents(ds.getString("Contents"));
				//��ȸ�� �� ������Ű�� ���� ReadCount�� ���� ����Ʈ �ؿ´�.
				ffDto.setReadCount(ds.getInt("ReadCount"));
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

		return ffDto;
	}

	/*
	 * �������� => ��ȸ������
	 */
	public int formFileCount(FormFileDTO ffDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FormFileReadCount (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(ffDto.getSeq());
		sql.setInteger(ffDto.getReadCount());
		System.out.println("Readcount::"+ffDto.getReadCount());
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
	 * �������� = > ����
	 */
	public int FormFileUpdate(FormFileDTO ffDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FormFileModify (?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(ffDto.getSeq());
		sql.setString(ffDto.getWriteFormUser());
		sql.setString(ffDto.getFormGroup());
		sql.setString(ffDto.getFormFile());
		sql.setString(ffDto.getFormFileNm());
		sql.setString(ffDto.getTitle());
		sql.setString(ffDto.getContents());
		sql.setString(ffDto.getUpdateUser());
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
	 * �������� => ����
	 */
	public int deleteFormFileOne(FormFileDTO ffDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_FormFileDelete (?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(ffDto.getSeq()); //pk
		sql.setString(ffDto.getDeletedUser());

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