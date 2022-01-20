package com.huation.common.corpState;

import java.sql.Connection;
import java.sql.SQLException;

import com.baroservice.ws.BaroService_CORPSTATESoap;
import com.baroservice.ws.BaroService_CORPSTATESoapProxy;
import com.baroservice.ws.CorpState;
import com.huation.framework.data.DataSet;
import com.huation.framework.persist.AbstractDAO;
import com.huation.framework.persist.ListDTO;
import com.huation.framework.persist.ListStatement;
import com.huation.framework.persist.QueryStatement;

public class CorpStateDAO extends AbstractDAO {

	private BaroService_CORPSTATESoap soap = new BaroService_CORPSTATESoapProxy();

	/* 1. Get CheckCorpNum list */
	public ListDTO GetCorpNumList() {

		ListDTO retVal = new ListDTO();
		Connection conn = null;

		try {
			ListStatement sql = new ListStatement();
			sql.setAlias(
					" COMP_CODE,PERMIT_NO,COMP_TAXTYPE,COMP_STATE,COMP_NM,COMP_NO, OWNER_NM, BUSINESS, B_ITEM,ADDRESS,ADDR_DETAIL,POST,REG_DT,OPENYMD,CHARGE_NM,CHARGE_EMAIL,COMP_FILE,ACCOUNT_COPY1,COMPANY_FILENM,ACCOUNT_COPYNM1,DATE ,UNFIT_ID,UNFIT_REASON ");
			sql.setSelect(
					" COMP_CODE,PERMIT_NO,COMP_TAXTYPE,COMP_STATE,COMP_NM,COMP_NO, OWNER_NM, BUSINESS, B_ITEM,ADDRESS,ADDR_DETAIL,POST,REG_DT,OPENYMD,CHARGE_NM,CHARGE_EMAIL,COMP_FILE,ACCOUNT_COPY1,COMPANY_FILENM,ACCOUNT_COPYNM1,DATE,UNFIT_ID,UNFIT_REASON ");
			sql.setFrom(" T_COMPANY \n");

			conn = broker.getConnection();
			conn.setAutoCommit(false);

			retVal = broker.executeListProcedure(sql);

		} catch (Exception e) {
			try {
				if (conn != null)
					conn.rollback();
			} catch (SQLException ignore) {
				log.error(ignore.getMessage(), ignore);
			}
			log.error(e.getMessage());
		} finally {
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
		}

		return retVal;
	}

	/* 2. Search CorpNum list */
	public int getCorpStates(ListDTO dto, String CRET_KEY, String Huation_key) {

		int retVal = 0;

		int count = dto.getTotalItemCount();
		DataSet ds = (DataSet) dto.getItemList();

		String[] Corplist = new String[count];
		String temp = "";

		/*
		 * 검색할 사업자 번호만 빼내서 리스트에 담음
		 * ===========================================================================
		 */
		if (count > 0) {
			try {
				int i = 0;
				while (ds.next()) {
					temp = ds.getString("PERMIT_NO");
					temp = temp.replace("-", ""); /* 조회부분에 - 이 있으면 오류 발생하기에 공백으로 변경 */
					Corplist[i] = temp;
					i++;
				}
			} catch (Exception e) {
				log.error("[사업자 번호 변경 오류]" + e.getMessage());
			}
		} else {
			log.error("[ 사업자 번호 DB 조회 NULL ]");
		}

		/*
		 * 사업자 구분, 상태 값 조회
		 * ===========================================================================
		 */

		/* 다중검색은 100개까지만 가능 */
		int len = Corplist.length;
		double size = Math.floor(len / 100) + (Math.floor(len % 100) > 0 ? 1 : 0); // 100개 단위로 나눈다.
		String[] templist;
		int lastNum = (int) Math.floor(len % 100);

		/* 100개씩 담아서 조회하기 */
		for (int start = 0; start < size; start++) {

			if (start + 1 == size) {

				templist = new String[lastNum];

				for (int j = 0; j < lastNum; j++) {
					templist[j] = Corplist[start * 100 + j];
				}

			} else {

				templist = new String[100];

				for (int j = 0; j < 100; j++) {
					templist[j] = Corplist[start * 100 + j];
				}

			}

			/* 바로빌 조회 및 DB 업로드 */
			try {
				CorpState[] result = new CorpState[100];
				result = soap.getCorpStates(CRET_KEY, Huation_key, templist);

				for (int i = 0; i < result.length; i++) {

					if (result[i].getCorpNum().equals("") || result[i].getState() == 0)	continue; /* 사업자 번호가 없는 경우 건너뜀 */
					
					try {

						CorpStateDTO cdto = parsingDTO(result[i]);
						retVal = updateCorpStates(cdto);

					} catch (Exception e) {

						log.error("[휴폐업 상태 업데이트 ERROR]" + e.getMessage());

					}

				}

			} catch (Exception e) {
				log.error("[바로빌 사업자 조회 오류]" + e.getMessage());
			}

		}

		return retVal;
	}

	/* 3. parsing work for DB Update */
	public CorpStateDTO parsingDTO(CorpState dto) {

		CorpStateDTO Cdto = new CorpStateDTO();

		String CorpNum = "";

		
		CorpNum = dto.getCorpNum().substring(0, 3) + "-" + dto.getCorpNum().substring(3, 5) + "-"
				+ dto.getCorpNum().substring(5, 10);

		Cdto.setCorpNum(CorpNum);
		Cdto.setTaxType(TaxTypeToString(dto.getTaxType()));
		Cdto.setState(StateToString(dto.getState()));
		Cdto.setStateDate(dto.getStateDate());
		Cdto.setBaseDate(dto.getBaseDate());

		return Cdto;
	}

	/* 4. Update T_COMPANY.COMP_TAXTYPE, T_COMPANY.COMP_STATE */
	public int updateCorpStates(CorpStateDTO dto) {

		int retVal = 0;

		String procedure = " { CALL hp_CompanyStateModify (?,?,?,?) } ";

		QueryStatement sql = new QueryStatement();

		sql.setSql(procedure);
		sql.setString(dto.getCorpNum());
		sql.setString(dto.getTaxType());
		sql.setString(dto.getState());
		sql.setString(dto.getStateDate());

		try {

			retVal = broker.executeProcedureUpdate(sql);

		} catch (Exception e) {
			e.printStackTrace();
			log.error("[ T_COMPANY UDPATE ERROR ]" + e.getMessage());
		} finally {

		}
		return retVal;
	}

	public String TaxTypeToString(int inTaxType) {

		String outTaxType = "";

		switch (inTaxType) {
		case 0:
			outTaxType = "-";
			break;
		case 1:
			outTaxType = "일반";
			break;
		case 2:
			outTaxType = "간이";
			break;
		case 3:
			outTaxType = "법인";
			break;
		case 4:
			outTaxType = "면세";
			break;
		case 5:
			outTaxType = "과특";
			break;
		case 6:
			outTaxType = "비영리";
			break;
		case 7:
			outTaxType = "간이";
			break;
		}

		return outTaxType;
	}

	public String StateToString(int inState) {

		String outState = "";

		switch (inState) {
		case 0:
			outState = "확인요";
			break;
		case 1:
			outState = "정상";
			break;
		case 2:
			outState = "휴업";
			break;
		case 3:
			outState = "폐업";
			break;
		}

		return outState;

	}

	public String TaxTypeToLongString(CorpState dto) {
		String output = "";
		
		switch (dto.getTaxType()) {
		
		case 0:
			output = "없는 사업자 번호 입니다.";
			break;
		case 1:
			output = "일반 사업자";
			break;
		case 2:
			output = "간이 과세자";
			break;
		case 3:
			output = "법인 사업자";
			break;
		case 4:
			output = "면세 사업자";
			break;
		case 5:
			output = "과특 사업자";
			break;
		case 6:
			output = "비영리 법인";
			break;
		case 7:
			output = "간이과세자 (세금계산서 발급사업자)";
			break;
		}
		
		return output;
	}
	
	
	
	
}
