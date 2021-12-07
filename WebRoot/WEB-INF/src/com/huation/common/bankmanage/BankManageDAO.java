package com.huation.common.bankmanage;

import java.sql.Connection;
import java.sql.SQLException;

import com.huation.common.bankmanage.BankManageDTO;
import com.huation.common.user.UserDTO;
import com.huation.framework.persist.AbstractDAO;
import com.huation.framework.data.DataSet;
import com.huation.framework.persist.DAOException;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.persist.ListStatement;
import com.huation.framework.persist.QueryStatement;
import com.mysql.jdbc.SQLError;
public class BankManageDAO extends AbstractDAO {

	/*
	 * 총무지원=> 법인통장관리 리스트
	 */
	public ListDTO bankmanagePageList(BankManageDTO bmDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_BankManageInquiry ( ?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(bmDto.getChUserID()); // 세션 아이디
		sql.setInteger(bmDto.getnRow()); // 리스트 갯수
		sql.setInteger(bmDto.getnPage()); // 현제 페이지
		sql.setString("PAGE"); // sp 구분
		sql.setString(bmDto.getBankCode());//코드검색(사이트명)

		try {
			retVal = broker.executePageProcedure(sql, bmDto.getnPage(),
					bmDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	
	/*
	 * 총무지원 => 법인통장관리 등록
	 */
	public int addBankManage(BankManageDTO bmDto) throws DAOException {

		int retVal = -1;

		String procedure = "{ CALL hp_BankManageRegist(?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시저명
		sql.setString(bmDto.getBankCode());
		sql.setString(bmDto.getAccountNumber());
		sql.setString(bmDto.getNewDate());
		sql.setString(bmDto.getReturnDate());
		sql.setString(bmDto.getBankBook());
		sql.setString(bmDto.getAccountManage());
		sql.setString(bmDto.getCustomerNum());
		sql.setString(bmDto.getRegistrationDate());
		sql.setString(bmDto.getRegistration());
		sql.setString(bmDto.getBankBookFile());
		sql.setString(bmDto.getBankBookFileNm());
		sql.setString(bmDto.getAccountIssue());

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
	 * 법인통장 계좌중복체크
	 */
	public String acnumberCheck(BankManageDTO bmDto) throws DAOException{

		String procedure = " { CALL hp_BankManageDuplicate ( ? , ? , ? ) } ";
		
		DataSet ds = null;
		String result="";

		QueryStatement sql = new QueryStatement();

		sql.setString(bmDto.getChUserID());		//세션아이디
		sql.setString("DUPLICATE");			//SP구분
		sql.setString(bmDto.getAccountNumber());		//사용자 아이디

		sql.setSql(procedure);

		try{

			ds=broker.executeProcedure(sql);
			
			if(ds.next()) {
				result=ds.getString("Result");
			}
		
		}catch(Exception e){
	      e.printStackTrace();
		  log.error(e.getMessage());
		  throw new DAOException(e.getMessage());
		}finally{
			try{
		        if (ds != null) { ds.close(); ds = null; }
		    }catch (Exception ignore){
		    	log.error(ignore.getMessage());
		    }
		}		
		return result;			
	}
	/*
	 * 법인통장관리 리스트(Excel)
	 */
	public ListDTO bankListExcel(BankManageDTO bmDto) throws DAOException{
		
		String procedure = " { CALL hp_BankManageInquiry ( ?,?,?,?,? ) } ";
		
		ListDTO retVal = null;

		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setString(bmDto.getChUserID()); // 세션 아이디
		sql.setInteger(bmDto.getnRow()); // 리스트 갯수
		sql.setInteger(bmDto.getnPage()); // 현제 페이지
		log.debug("Page3:"+bmDto.getnPage());
		sql.setString("LIST"); // sp 구분
		sql.setString(bmDto.getBankCode());//코드검색(사이트명)

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
	 * 법인통장관리 상세정보
	 */
	public BankManageDTO BankView(BankManageDTO bmDto) throws DAOException {

		String procedure = "{ CALL hp_BankManageSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(bmDto.getAccountNumber());//불러올 key값 sql.셋팅

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				bmDto = new BankManageDTO();
				bmDto.setSeq(ds.getInt("seq"));
				bmDto.setBankCode(ds.getString("BankCode"));
				bmDto.setAccountNumber(ds.getString("AccountNumber"));
				bmDto.setNewDate(ds.getString("NewDate"));
				bmDto.setReturnDate(ds.getString("ReturnDate"));
				bmDto.setBankBook(ds.getString("BankBook"));
				bmDto.setAccountManage(ds.getString("AccountManage"));
				bmDto.setCustomerNum(ds.getString("CustomerNum"));
				bmDto.setRegistrationDate(ds.getString("RegistrationDate"));
				bmDto.setRegistration(ds.getString("Registration"));
				bmDto.setRegistrationName(ds.getString("RegistrationName"));
				bmDto.setBankBookFile(ds.getString("BankBookFile"));
				bmDto.setBankBookFileNm(ds.getString("BankBookFileNm"));
				bmDto.setAccountIssue(ds.getString("AccountIssue"));
				bmDto.setDeleteYN(ds.getString("DeleteYN"));
				bmDto.setBankName(ds.getString("BankName"));
				bmDto.setCreateDateTime(ds.getString("CreateDateTime"));
				bmDto.setUpdateDateTime(ds.getString("UpdateDateTime"));
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

		return bmDto;
	}
	/*
	 * 총무지원 => 법인통장관리 수정
	 */
	public int updateBankManage(BankManageDTO bmDto) throws DAOException {

		int retVal = -1;

		String procedure = "{ CALL hp_BankManageModify(?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시저명
		sql.setString(bmDto.getBankCode());
		sql.setString(bmDto.getAccountNumber());
		sql.setString(bmDto.getNewDate());
		sql.setString(bmDto.getReturnDate());
		sql.setString(bmDto.getBankBook());
		sql.setString(bmDto.getAccountManage());
		sql.setString(bmDto.getCustomerNum());
		sql.setString(bmDto.getRegistrationDate());
		sql.setString(bmDto.getRegistration());
		sql.setString(bmDto.getBankBookFile());
		sql.setString(bmDto.getBankBookFileNm());
		sql.setString(bmDto.getAccountIssue());

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
	 * 총무지원 => 법인통장관리 삭제
	 */
	public int deleteBankManageOne(BankManageDTO bmDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_BankManageDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(bmDto.getAccountNumber());

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
