package com.huation.common.huebookmanage;

import java.sql.Connection;
import java.sql.SQLException;

import com.huation.common.huebookmanage.HueBookManageDTO;
import com.huation.common.user.UserDTO;
import com.huation.framework.persist.AbstractDAO;
import com.huation.framework.data.DataSet;
import com.huation.framework.persist.DAOException;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.persist.ListStatement;
import com.huation.framework.persist.QueryStatement;
import com.mysql.jdbc.SQLError;
public class HueBookManageDAO extends AbstractDAO {

	/*
	 * 2012.11.21(��) bsh
	 * HueBook���� = > ������û ����Ʈ
	 */
	public ListDTO hbManageRePageList(HueBookManageDTO hbDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_HueBookManageInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(hbDto.getRequestUser()); // ���� ���̵�
		sql.setString(hbDto.getvSearchType()); // �˻�����
		sql.setString(hbDto.getvSearch()); // �˻���
		sql.setInteger(hbDto.getnRow()); // ����Ʈ ����
		sql.setInteger(hbDto.getnPage()); // ���� ������
		sql.setString("PAGE"); // sp ����

		try {
			retVal = broker.executePageProcedure(sql, hbDto.getnPage(),
					hbDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	
	/*
	 * 2012.11.21(��) bsh
	 * HueBook����  => ���ó��
	 */
	public int addReHueBookManage(HueBookManageDTO hbDto) throws DAOException {

		int retVal = -1;

		String procedure = "{ CALL hp_HueBookRequestRE(?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν�����
		sql.setString(hbDto.getRequestUser());
		sql.setString(hbDto.getRequestName());
		sql.setString(hbDto.getBookName());
		sql.setString(hbDto.getWriter());
		sql.setInteger(hbDto.getPrice());
		sql.setString(hbDto.getBranchCode());
		sql.setString(hbDto.getPublisher());
		sql.setString(hbDto.getTranslator());
		sql.setString(hbDto.getRequestBookCount());
		sql.setString(hbDto.getContents());
		sql.setString(hbDto.getStatus());
		sql.setString(hbDto.getRequestDate());
		System.out.println("sql : "+sql);

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

	/*
	 * 2012-11-23(��) bsh.
	 * HueBook����=> ������û(Excel)
	 */
	public ListDTO bookListExcel(HueBookManageDTO hbDto) throws DAOException{
		
		String procedure = " { CALL hp_HueBookManageInquiry ( ?,?,?,?,?,? ) } ";
		
		ListDTO retVal = null;

		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // ���ν��� ��
		sql.setString(hbDto.getRequestUser()); // ���� ���̵�
		sql.setString(hbDto.getvSearchType()); // �˻�����
		sql.setString(hbDto.getvSearch()); // �˻���
		sql.setInteger(hbDto.getnRow()); // ����Ʈ ����
		sql.setInteger(hbDto.getnPage()); // ���� ������
		sql.setString("LIST"); // sp ����

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
	/*
	 * 2012-11-22(��) bsh
	 * HueBook���� = > ������û �󼼺���
	 */
	public HueBookManageDTO hueBookReView(HueBookManageDTO hbDto) throws DAOException {

		String procedure = "{ CALL hp_HueBookManageSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(hbDto.getSeqPk());//�ҷ��� pk�� sql.����

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				hbDto = new HueBookManageDTO();
				hbDto.setSeqPk(ds.getInt("SeqPk")); //pk��
				hbDto.setRequestUser(ds.getString("requestUser")); //��û��ID(���Ǻ񱳸����� ����.)
				hbDto.setRequestName(ds.getString("requestName")); //��û�ڸ�
				hbDto.setBookName(ds.getString("bookName")); //������
				hbDto.setWriter(ds.getString("writer")); //����
				hbDto.setPrice(ds.getInt("price")); //����
				hbDto.setRequestDate(ds.getString("requestDate")); //��û����
				hbDto.setBranchCode(ds.getString("branchCode")); //�о�
				hbDto.setBranchCodeNm(ds.getString("branchCodeNm")); //�о߸�
				hbDto.setPublisher(ds.getString("publisher")); //���ǻ�
				hbDto.setTranslator(ds.getString("translator")); //����
				hbDto.setRequestBookCount(ds.getString("requestBookCount")); //��û�Ǽ�
				hbDto.setContents(ds.getString("contents")); //����
				hbDto.setApprovalAndReturn(ds.getString("approvalAndReturn")); //����/�ݷ�����
				hbDto.setStatus(ds.getString("status")); //�������(������°� �񱳷� 3.���ſϷ� �ÿ��� ����/���� �Ұ����ϰ� �ϱ�����.)
				hbDto.setClearDate(ds.getString("clearDate")); //����Ϸ�����
				hbDto.setApprovalName(ds.getString("approvalName")); //�����ڸ�
				hbDto.setApprovalUser(ds.getString("approvalUser")); //������ID
				hbDto.setBuyDate(ds.getString("buyDate"));//��������
				hbDto.setBuyPrice(ds.getInt("buyPrice")); //���Ű���
				hbDto.setPurchasingOffice(ds.getString("purchasingOffice"));
				
				
				
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

		return hbDto;
	}
	/*
	 * 2012-11-23(��) bsh.
	 * HueBook���� = > ������û(����)
	 */
	public int updateBookManage(HueBookManageDTO hbDto) throws DAOException {

		int retVal = -1;

		String procedure = "{ CALL hp_HueBookModifyRE(?,?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν�����
		sql.setInteger(hbDto.getSeqPk());
		sql.setString(hbDto.getRequestUser());
		sql.setString(hbDto.getRequestName());
		sql.setString(hbDto.getBookName());
		sql.setString(hbDto.getWriter());
		sql.setString(hbDto.getRequestDate());
		sql.setInteger(hbDto.getPrice());
		sql.setString(hbDto.getBranchCode());
		sql.setString(hbDto.getPublisher());
		sql.setString(hbDto.getTranslator());
		sql.setString(hbDto.getRequestBookCount());
		sql.setString(hbDto.getContents());
		sql.setString(hbDto.getStatus());
		sql.setString(hbDto.getUpdateUser());

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
	/*
	 * 2012-11-23(��) bsh.
	 * HueBook���� = >������û(����)
	 */
	public int deleteBookManageOne(HueBookManageDTO hbDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_HueBookManageDeleteRE (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(hbDto.getSeqPk());

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
	 * 2012.11.23(��) bsh
	 * HueBook���� = > �������� ����Ʈ
	 */
	public ListDTO hbManageAppPageList(HueBookManageDTO hbDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_HueBookManageInquiryAPP ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setString(hbDto.getApprovalUser()); // ���� ���̵�
		sql.setString(hbDto.getvSearchType()); // �˻�����
		sql.setString(hbDto.getvSearch()); // �˻���
		sql.setInteger(hbDto.getnRow()); // ����Ʈ ����
		sql.setInteger(hbDto.getnPage()); // ���� ������
		sql.setString("PAGE"); // sp ����

		try {
			retVal = broker.executePageProcedure(sql, hbDto.getnPage(),
					hbDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	/*
	 * 2012-11-23(��) bsh
	 * HueBook���� = > �������� �󼼺���
	 */
	public HueBookManageDTO hueBookAppView(HueBookManageDTO hbDto) throws DAOException {

		String procedure = "{ CALL hp_HueBookManageSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν��� ��
		sql.setInteger(hbDto.getSeqPk());//�ҷ��� pk�� sql.����

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				hbDto = new HueBookManageDTO();
				hbDto.setSeqPk(ds.getInt("SeqPk")); //pk��
				hbDto.setRequestUser(ds.getString("requestUser")); //��û��ID(���Ǻ񱳸����� ����.)
				hbDto.setRequestName(ds.getString("requestName")); //��û�ڸ�
				hbDto.setBookName(ds.getString("bookName")); //������
				hbDto.setWriter(ds.getString("writer")); //����
				hbDto.setPrice(ds.getInt("price")); //����
				hbDto.setRequestDate(ds.getString("requestDate")); //��û����
				hbDto.setBranchCode(ds.getString("branchCode")); //�о�
				hbDto.setBranchCodeNm(ds.getString("branchCodeNm")); //�о߸�
				hbDto.setPublisher(ds.getString("publisher")); //���ǻ�
				hbDto.setTranslator(ds.getString("translator")); //����
				hbDto.setRequestBookCount(ds.getString("requestBookCount")); //��û�Ǽ�
				hbDto.setContents(ds.getString("contents")); //����
				hbDto.setApprovalAndReturn(ds.getString("approvalAndReturn")); //����/�ݷ�����
				hbDto.setStatus(ds.getString("status")); //�������(������°� �񱳷� 3.���ſϷ� �ÿ��� ����/���� �Ұ����ϰ� �ϱ�����.)
				hbDto.setBuyDate(ds.getString("buyDate")); //��������
				hbDto.setApprovalUser(ds.getString("approvalUser")); //�����ھ��̵�
				hbDto.setApprovalName(ds.getString("approvalName")); //�����ڸ�
				hbDto.setClearDate(ds.getString("clearDate")); //��������
				hbDto.setBuyPrice(ds.getInt("buyPrice")); //���Ű���
				hbDto.setPurchasingOffice(ds.getString("purchasingOffice")); //����ó
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

		return hbDto;
	}
	
	/*
	 * 2012-11-23(��) bsh.
	 * HueBook���� = > ��������Ϸ�(Update)
	 */
	public int updateBookManageApp(HueBookManageDTO hbDto) throws DAOException {

		int retVal = -1;

		String procedure = "{ CALL hp_HueBookModifyAPP(?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν�����
		sql.setInteger(hbDto.getSeqPk()); //pk��
		sql.setString(hbDto.getStatus()); //������°�
		sql.setString(hbDto.getApprovalAndReturn()); //����/�ݷ�����
		sql.setString(hbDto.getClearDate()); //����Ϸ���
		sql.setString(hbDto.getApprovalUser()); //������
		System.out.println("sql : "+sql);
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
	/*
	 * 2012-11-28(��) bsh.
	 * HueBook���� = > �������ſϷ�(Update)
	 */
	public int updateBookManageBuy(HueBookManageDTO hbDto) throws DAOException {

		int retVal = -1;

		String procedure = "{ CALL hp_HueBookModifyBuy(?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν�����
		sql.setInteger(hbDto.getSeqPk()); //pk��
		sql.setString(hbDto.getStatus()); //������°�
		sql.setString(hbDto.getBuyDate()); //����/�ݷ�����
		sql.setInteger(hbDto.getBuyPrice()); //����Ϸ���
		sql.setString(hbDto.getPurchasingOffice());//����ó
		sql.setString(hbDto.getApprovalUser()); // ����������Ʈ(���ſϷ��� ������)

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
	
	/*
	 * 2012-11-28(��) bsh.
	 * HueBook���� = > �����ݷ�(Update)
	 */
	public int updateBookManageRT(HueBookManageDTO hbDto) throws DAOException {

		int retVal = -1;

		String procedure = "{ CALL hp_HueBookModifyRT(?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // ���ν�����
		sql.setInteger(hbDto.getSeqPk()); //pk��
		sql.setString(hbDto.getStatus()); //������°�
		sql.setString(hbDto.getApprovalUser()); //������(�α����� ������ڷ� �ݷ�(����Update��.)
		sql.setString(hbDto.getApprovalAndReturn()); //����/�ݷ�����

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
	
	/*
	 * 2012-11-28(��) bsh.
	 * HueBook����=> ��������(Excel)
	 */
	public ListDTO bookListExcelAPP(HueBookManageDTO hbDto) throws DAOException{
		
		String procedure = " { CALL hp_HueBookManageInquiryAPP ( ?,?,?,?,?,? ) } ";
		
		ListDTO retVal = null;

		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // ���ν��� ��
		sql.setString(hbDto.getRequestUser()); // ���� ���̵�
		sql.setString(hbDto.getvSearchType()); // �˻�����
		sql.setString(hbDto.getvSearch()); // �˻���
		sql.setInteger(hbDto.getnRow()); // ����Ʈ ����
		sql.setInteger(hbDto.getnPage()); // ���� ������
		sql.setString("LIST"); // sp ����

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
