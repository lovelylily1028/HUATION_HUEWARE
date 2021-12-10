package com.huation.common.huebooklist;

import java.sql.Connection;
import java.sql.SQLException;

import com.huation.common.huebooklist.HueBookListDTO;
import com.huation.common.user.UserDTO;
import com.huation.framework.persist.AbstractDAO;
import com.huation.framework.data.DataSet;
import com.huation.framework.persist.DAOException;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.persist.ListStatement;
import com.huation.framework.persist.QueryStatement;
import com.mysql.jdbc.SQLError;

import com.huation.framework.util.FileUtil;
public class HueBookListDAO extends AbstractDAO {

	/*
	 * 2012.11.28(수) bsh
	 * HueBook관리 = > 휴북목록 리스트
	 */
	public ListDTO hbManagePageList(HueBookListDTO hlDto) throws DAOException {
		ListDTO retVal = null;
		String procedure = " { CALL hp_HueBookListInquiry ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(hlDto.getRequestUser()); // 세션 아이디
		sql.setString(hlDto.getvSearchType()); // 검색구분
		sql.setString(hlDto.getvSearch()); // 검색어
		sql.setInteger(hlDto.getnRow()); // 리스트 갯수
		sql.setInteger(hlDto.getnPage()); // 현제 페이지
		sql.setString("PAGE"); // sp 구분

		try {
			retVal = broker.executePageProcedure(sql, hlDto.getnPage(),
					hlDto.getnRow());

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DAOException(e.getMessage());
		}

		return retVal;

	}
	
	
	/*
	 * 2012.11.29(목) bsh
	 * HueBook관리  => 휴북목록 등록처리
	 */
	public int insertBookList(HueBookListDTO hlDto) throws DAOException {

		int retVal = -1;

		String procedure = "{ CALL hp_HueBookListRegist(?,?,?,?,?,?,?,?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시저명
		sql.setString(hlDto.getHueBookCode()); //현재 프로시저에 값 셋팅이 구성되있음.(log상 null값 맞음)
		sql.setString(hlDto.getBranchCode());
		sql.setString(hlDto.getBookName());
		sql.setString(hlDto.getPublisher());
		sql.setString(hlDto.getWriter());
		sql.setString(hlDto.getPurchasingOffice());
		sql.setString(hlDto.getRequestUser());
		sql.setString(hlDto.getRequestDate());
		sql.setString(hlDto.getApprovalUser());
		sql.setString(hlDto.getClearDate());
		sql.setInteger(hlDto.getBuyPrice());
		sql.setString(hlDto.getBuyDate());
//업데이트 유무 축.
//		sql.setString(hlDto.getUpdateYN());
		sql.setString("N");

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
	 * 2012-11-29(목) bsh.
	 * HueBook관리 = > 휴북도서목록 상세보기
	 */
	public HueBookListDTO hueBookView(HueBookListDTO hlDto) throws DAOException {

		String procedure = "{ CALL hp_HueBookListSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(hlDto.getHueBookCode());//불러올 pk값 sql.셋팅

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				hlDto = new HueBookListDTO();
				hlDto.setHueBookCode(ds.getString("hueBookCode")); //pk값
				hlDto.setRequestUser(ds.getString("requestUser")); //신청자ID(세션비교를위해 꺼냄.)
				hlDto.setBookName(ds.getString("bookName")); //도서명
				hlDto.setWriter(ds.getString("writer")); //저자
				hlDto.setPurchasingOffice(ds.getString("purchasingOffice")); //구매처
				hlDto.setRequestName(ds.getString("requestName")); //신청자명
				hlDto.setRequestDate(ds.getString("requestDate")); //신청자명
				hlDto.setApprovalName(ds.getString("approvalName")); //결재자명
				hlDto.setClearDate(ds.getString("clearDate")); //결재일자
				hlDto.setBuyPrice(ds.getInt("buyPrice"));  //구매가격
				hlDto.setBuyDate(ds.getString("buyDate")); //구매일자
				hlDto.setBranchCode(ds.getString("branchCode")); //분야
				hlDto.setBranchCodeNm(ds.getString("branchCodeNm")); //분야명
				hlDto.setPublisher(ds.getString("publisher")); //출판사
				
				hlDto.setUseYN(ds.getString("useYn")); //사용유무
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

		return hlDto;
	}
	/*
	 * 2012-11-29(목) bsh.
	 * HueBook관리 = > 휴북목록(수정)
	 */
	public int updateBookList(HueBookListDTO hlDto) throws DAOException {

		int retVal = -1;

//		String procedure = "{ CALL hp_HueBookListModify(?,?,?,?,?) } ";
		String procedure = "{ CALL hp_HueBookListModify(?,?,?,?,? ,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시저명
		sql.setString(hlDto.getHueBookCode());
		sql.setString(hlDto.getBranchCode());
		sql.setString(hlDto.getBookName());
		sql.setString(hlDto.getPublisher());
		sql.setString(hlDto.getWriter());
		
		sql.setString(hlDto.getUseYN());
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
	 * 2012-11-29(목) bsh.
	 * HueBook관리 = >휴북목록(삭제)
	 */
	public int deleteBookListOne(HueBookListDTO hlDto) throws DAOException {

		int retVal = -1;

		String procedure = " { CALL hp_HueBookListDelete (?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(hlDto.getHueBookCode());

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
	 * 2012.11.23(금) bsh
	 * HueBook관리 = > 도서결재 리스트
	public ListDTO hbManageAppPageList(HueBookManageDTO hbDto) throws DAOException {

		ListDTO retVal = null;
		String procedure = " { CALL hp_HueBookManageInquiryAPP ( ?,?,?,?,?,? ) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setString(hbDto.getApprovalUser()); // 세션 아이디
		sql.setString(hbDto.getvSearchType()); // 검색구분
		sql.setString(hbDto.getvSearch()); // 검색어
		sql.setInteger(hbDto.getnRow()); // 리스트 갯수
		sql.setInteger(hbDto.getnPage()); // 현제 페이지
		sql.setString("PAGE"); // sp 구분

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
	
	 */
	/*
	 * 2012-11-23(금) bsh
	 * HueBook관리 = > 도서결재 상세보기
	public HueBookManageDTO hueBookAppView(HueBookManageDTO hbDto) throws DAOException {

		String procedure = "{ CALL hp_HueBookManageSelect (?) }";
		DataSet ds = null;

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시져 명
		sql.setInteger(hbDto.getSeqPk());//불러올 pk값 sql.셋팅

		try {

			ds = broker.executeProcedure(sql);

			while (ds.next()) {
				hbDto = new HueBookManageDTO();
				hbDto.setSeqPk(ds.getInt("SeqPk")); //pk값
				hbDto.setRequestUser(ds.getString("requestUser")); //신청자ID(세션비교를위해 꺼냄.)
				hbDto.setRequestName(ds.getString("requestName")); //신청자명
				hbDto.setBookName(ds.getString("bookName")); //도서명
				hbDto.setWriter(ds.getString("writer")); //저자
				hbDto.setPrice(ds.getInt("price")); //가격
				hbDto.setRequestDate(ds.getString("requestDate")); //신청일자
				System.out.println("DATE:DAO::"+ds.getString("requestDate"));
				hbDto.setBranchCode(ds.getString("branchCode")); //분야
				hbDto.setBranchCodeNm(ds.getString("branchCodeNm")); //분야명
				hbDto.setPublisher(ds.getString("publisher")); //출판사
				hbDto.setTranslator(ds.getString("translator")); //역자
				hbDto.setRequestBookCount(ds.getString("requestBookCount")); //신청권수
				hbDto.setContents(ds.getString("contents")); //내용
				hbDto.setApprovalAndReturn(ds.getString("approvalAndReturn")); //승인/반려사유
				hbDto.setStatus(ds.getString("status")); //진행상태(진행상태값 비교로 3.구매완료 시에는 수정/삭제 불가능하게 하기위해.)
				hbDto.setBuyDate(ds.getString("buyDate")); //구매일자
				hbDto.setApprovalUser(ds.getString("approvalUser")); //결재자아이디
				hbDto.setApprovalName(ds.getString("approvalName")); //결재자명
				hbDto.setClearDate(ds.getString("clearDate")); //결재일자
				System.out.println("결재일자:::DAO::"+ds.getString("clearDate"));
				hbDto.setBuyPrice(ds.getInt("buyPrice")); //구매가격
				hbDto.setPurchasingOffice(ds.getString("purchasingOffice")); //구매처
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
	
	 */
	/*
	 * 2012-11-23(금) bsh.
	 * HueBook관리 = > 도서결재완료(Update)
	public int updateBookManageApp(HueBookManageDTO hbDto) throws DAOException {

		int retVal = -1;

		String procedure = "{ CALL hp_HueBookModifyAPP(?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시저명
		sql.setInteger(hbDto.getSeqPk()); //pk값
		sql.setString(hbDto.getStatus()); //진행상태값
		sql.setString(hbDto.getApprovalAndReturn()); //승인/반려사유
		sql.setString(hbDto.getClearDate()); //결재완료일
		sql.setString(hbDto.getApprovalUser()); //결재자
		sql.setString(hbDto.getUpdateUser()); //최종수정자

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
	 */
	/*
	 * 2012-11-28(수) bsh.
	 * HueBook관리 = > 도서구매완료(Update)
	public int updateBookManageBuy(HueBookManageDTO hbDto) throws DAOException {

		int retVal = -1;

		String procedure = "{ CALL hp_HueBookModifyBuy(?,?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시저명
		sql.setInteger(hbDto.getSeqPk()); //pk값
		sql.setString(hbDto.getStatus()); //진행상태값
		sql.setString(hbDto.getBuyDate()); //승인/반려사유
		sql.setInteger(hbDto.getBuyPrice()); //결재완료일
		sql.setString(hbDto.getPurchasingOffice());//구매처
		sql.setString(hbDto.getUpdateUser()); //최종수정자

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
	
	 */
	/*
	 * 2012-11-28(수) bsh.
	 * HueBook관리 = > 도서반려(Update)
	public int updateBookManageRT(HueBookManageDTO hbDto) throws DAOException {

		int retVal = -1;

		String procedure = "{ CALL hp_HueBookModifyRT(?,?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure); // 프로시저명
		sql.setInteger(hbDto.getSeqPk()); //pk값
		sql.setString(hbDto.getStatus()); //진행상태값
		sql.setString(hbDto.getApprovalUser()); //결재자(반려권한o)
		sql.setString(hbDto.getApprovalAndReturn()); //승인/반려사유
		sql.setString(hbDto.getUpdateUser()); //최종수정자

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
	
	 */
	/*
	 * 2012-11-28(수) bsh.
	 * HueBook관리=> 휴북목록(Excel)
	 */
	public ListDTO bookListExcel(HueBookListDTO hlDto) throws DAOException{
		
		String procedure = " { CALL hp_HueBookListInquiry ( ?,?,?,?,?,? ) } ";
		
		ListDTO retVal = null;

		QueryStatement sql = new QueryStatement();
		
		sql.setSql(procedure); // 프로시져 명
		sql.setString(hlDto.getRequestUser()); // 세션 아이디
		sql.setString(hlDto.getvSearchType()); // 검색구분
		sql.setString(hlDto.getvSearch()); // 검색어
		sql.setInteger(hlDto.getnRow()); // 리스트 갯수
		sql.setInteger(hlDto.getnPage()); // 현제 페이지
		sql.setString("LIST"); // sp 구분

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
