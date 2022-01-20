package com.huation.common.corpState;

import com.huation.framework.persist.AbstractDAO;

public class CorpStateDTO extends AbstractDAO{

		private String corpNum;		/*  사업자 번호  */
	    private String taxType;		/*	구분       */
	    private String state; 		/*  상태       */
	    private String stateDate;	/*	폐업일자	 */
	    private String baseDate;	/*	조회기준일자 */
	    
		public String getCorpNum() {
			return corpNum;
		}
		public void setCorpNum(String corpNum) {
			this.corpNum = corpNum;
		}
		public String getTaxType() {
			return taxType;
		}
		public void setTaxType(String taxType) {
			this.taxType = taxType;
		}
		public String getState() {
			return state;
		}
		public void setState(String state) {
			this.state = state;
		}
		public String getStateDate() {
			return stateDate;
		}
		public void setStateDate(String stateDate) {
			this.stateDate = stateDate;
		}
		public String getBaseDate() {
			return baseDate;
		}
		public void setBaseDate(String baseDate) {
			this.baseDate = baseDate;
		}


	    
}
