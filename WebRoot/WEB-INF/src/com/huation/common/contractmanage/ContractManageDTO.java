package com.huation.common.contractmanage;

public class ContractManageDTO {

	 
	//logid
    protected String logid;

    //넘어다니는 파라미터(프로시저 호출값)
	protected String chUserID; 		//로그인 유저 세션값
	protected String vSearchType;	//검색구분
	protected String SearchGb2;	//검색구분(계약 종결 여부)
	protected String SearchGb3;	//검색구분(매출구분, 시스템매출, 상품매출, 용역매출)
	protected String vSearch;		//검색명
	protected int nRow;				//리스트 데이터 총갯수(길이)
	protected int nPage;			//현재 페이지
	protected String JobGb;			//페이징&리스트 구분
	protected String curPage;		//넘어가는 현재 페이지 값
	protected String ConChk;		//계약일자 체크 여부(등록 SP 사용)
	protected String PurChk;		//발주일자 체크 여부(등록 SP 사용)
	
	//계약관리 DTO Get/Set
	protected String ContractCode; 		//계약 코드번호
	protected String Public_No;			//견적번호
	protected String ContractFile;		//계약서 파일경로
	protected String ContractFileNm;	//계약서 파일명
	protected String PurchaseOrderFile; //발주서 파일경로
	protected String PurchaseOrderFileNm; //발주서 파일명
	protected String Estimate_E_File;	//견적서 엑셀 파일경로
	protected String Estimate_E_FileNm;	//견적서 엑셀 파일명
	protected String Estimate_P_File;	//견적서 PDF 파일경로
	protected String Estimate_P_FileNm;	//견적서 PDF 파일명
	protected String Ordering_Organization; //발주처 = 업체명
	protected String ContractName;			//계약명 = 견적서 프로젝트명
	protected String CustomerName;			//고객 담당자명
	protected String CustomerTel;			//고객 담당자 연락처
	protected String CustomerMobile;		//고객 담당자 핸드폰 번호
	protected String ContractStatus;		//계약종결 여부
	protected String ContractReason;		//계약 조기종료 시 입력되는 Remark
	protected String ContractCreateUser;	//최초 등록자
	protected String ContractCreateDate;	//최초 등록일
	protected String ContractUpdateUser;	//최근 수정자
	protected String ContractEndDate;		//종료일시
	protected String ContractDate;			//계약종료
	protected String PurchaseDate;			//발주일자
	
	
	public String getSearchGb2() {
		return SearchGb2;
	}
	public void setSearchGb2(String searchGb2) {
		SearchGb2 = searchGb2;
	}
	public String getLogid() {
		return logid;
	}
	public void setLogid(String logid) {
		this.logid = logid;
	}
	public String getChUserID() {
		return chUserID;
	}
	public void setChUserID(String chUserID) {
		this.chUserID = chUserID;
	}
	public String getvSearchType() {
		return vSearchType;
	}
	public void setvSearchType(String vSearchType) {
		this.vSearchType = vSearchType;
	}
	public String getvSearch() {
		return vSearch;
	}
	public void setvSearch(String vSearch) {
		this.vSearch = vSearch;
	}
	public int getnRow() {
		return nRow;
	}
	public void setnRow(int nRow) {
		this.nRow = nRow;
	}
	public int getnPage() {
		return nPage;
	}
	public void setnPage(int nPage) {
		this.nPage = nPage;
	}
	public String getJobGb() {
		return JobGb;
	}
	public void setJobGb(String jobGb) {
		JobGb = jobGb;
	}
	public String getCurPage() {
		return curPage;
	}
	public void setCurPage(String curPage) {
		this.curPage = curPage;
	}
	public String getContractCode() {
		return ContractCode;
	}
	public void setContractCode(String contractCode) {
		ContractCode = contractCode;
	}
	public String getPublic_No() {
		return Public_No;
	}
	public void setPublic_No(String public_No) {
		Public_No = public_No;
	}
	public String getContractFile() {
		return ContractFile;
	}
	public void setContractFile(String contractFile) {
		ContractFile = contractFile;
	}
	public String getContractFileNm() {
		return ContractFileNm;
	}
	public void setContractFileNm(String contractFileNm) {
		ContractFileNm = contractFileNm;
	}
	public String getEstimate_E_File() {
		return Estimate_E_File;
	}
	public void setEstimate_E_File(String estimate_E_File) {
		Estimate_E_File = estimate_E_File;
	}
	public String getEstimate_E_FileNm() {
		return Estimate_E_FileNm;
	}
	public void setEstimate_E_FileNm(String estimate_E_FileNm) {
		Estimate_E_FileNm = estimate_E_FileNm;
	}
	public String getEstimate_P_File() {
		return Estimate_P_File;
	}
	public void setEstimate_P_File(String estimate_P_File) {
		Estimate_P_File = estimate_P_File;
	}
	public String getEstimate_P_FileNm() {
		return Estimate_P_FileNm;
	}
	public void setEstimate_P_FileNm(String estimate_P_FileNm) {
		Estimate_P_FileNm = estimate_P_FileNm;
	}
	public String getOrdering_Organization() {
		return Ordering_Organization;
	}
	public void setOrdering_Organization(String ordering_Organization) {
		Ordering_Organization = ordering_Organization;
	}
	public String getContractName() {
		return ContractName;
	}
	public void setContractName(String contractName) {
		ContractName = contractName;
	}
	public String getContractStatus() {
		return ContractStatus;
	}
	public void setContractStatus(String contractStatus) {
		ContractStatus = contractStatus;
	}
	public String getContractCreateUser() {
		return ContractCreateUser;
	}
	public void setContractCreateUser(String contractCreateUser) {
		ContractCreateUser = contractCreateUser;
	}
	public String getContractCreateDate() {
		return ContractCreateDate;
	}
	public void setContractCreateDate(String contractCreateDate) {
		ContractCreateDate = contractCreateDate;
	}
	public String getContractUpdateUser() {
		return ContractUpdateUser;
	}
	public void setContractUpdateUser(String contractUpdateUser) {
		ContractUpdateUser = contractUpdateUser;
	}
	public String getContractEndDate() {
		return ContractEndDate;
	}
	public void setContractEndDate(String contractEndDate) {
		ContractEndDate = contractEndDate;
	}
	public String getPurchaseOrderFile() {
		return PurchaseOrderFile;
	}
	public void setPurchaseOrderFile(String purchaseOrderFile) {
		PurchaseOrderFile = purchaseOrderFile;
	}
	public String getPurchaseOrderFileNm() {
		return PurchaseOrderFileNm;
	}
	public void setPurchaseOrderFileNm(String purchaseOrderFileNm) {
		PurchaseOrderFileNm = purchaseOrderFileNm;
	}
	public String getCustomerName() {
		return CustomerName;
	}
	public void setCustomerName(String customerName) {
		CustomerName = customerName;
	}
	public String getCustomerTel() {
		return CustomerTel;
	}
	public void setCustomerTel(String customerTel) {
		CustomerTel = customerTel;
	}
	public String getContractReason() {
		return ContractReason;
	}
	public void setContractReason(String contractReason) {
		ContractReason = contractReason;
	}
	public String getCustomerMobile() {
		return CustomerMobile;
	}
	public void setCustomerMobile(String customerMobile) {
		CustomerMobile = customerMobile;
	}
	public String getContractDate() {
		return ContractDate;
	}
	public void setContractDate(String contractDate) {
		ContractDate = contractDate;
	}
	public String getPurchaseDate() {
		return PurchaseDate;
	}
	public void setPurchaseDate(String purchaseDate) {
		PurchaseDate = purchaseDate;
	}
	public String getConChk() {
		return ConChk;
	}
	public void setConChk(String conChk) {
		ConChk = conChk;
	}
	public String getPurChk() {
		return PurChk;
	}
	public void setPurChk(String purChk) {
		PurChk = purChk;
	}
	public String getSearchGb3() {
		return SearchGb3;
	}
	public void setSearchGb3(String searchGb3) {
		SearchGb3 = searchGb3;
	}
	


}
