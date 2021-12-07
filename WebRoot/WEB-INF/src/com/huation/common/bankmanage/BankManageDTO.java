package com.huation.common.bankmanage;

public class BankManageDTO {

	
	protected int seq; //키값
	protected String BankCode; //은행코드번호
	protected String AccountNumber; //계좌번호 유니크값고유번호
	protected String NewDate; //신규개설일
	protected String ReturnDate; //재발행일
	protected String BankBook; //재발행점
	protected String AccountManage; //계좌관리점
	protected String CustomerNum; //고객번호
	protected String RegistrationDate; //등록일자
	protected String Registration; //등록자
	protected String BankBookFile; //실파일경로
	protected String BankBookFileNm; //실파일명
	protected String AccountIssue; //계좌특이사항
	protected String DeleteYN; //삭제여부
	
	
	//프로시저 넘어다니는 파라미터
	
	protected String chUserID; //세션값
	protected String BankName; //가져올 은행명
	protected String RegistrationName; //가져올 등록자명
	
	public String getRegistrationName() {
		return RegistrationName;
	}
	public void setRegistrationName(String registrationName) {
		RegistrationName = registrationName;
	}
	public String getChUserID() {
		return chUserID;
	}
	public void setChUserID(String chUserID) {
		this.chUserID = chUserID;
	}
	protected int nRow;
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
	protected int nPage;
	protected String JobGb;
	
	public String getBankName() {
		return BankName;
	}
	public void setBankName(String bankName) {
		BankName = bankName;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getBankCode() {
		return BankCode;
	}
	public void setBankCode(String bankCode) {
		BankCode = bankCode;
	}
	public String getAccountNumber() {
		return AccountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		AccountNumber = accountNumber;
	}
	public String getNewDate() {
		return NewDate;
	}
	public void setNewDate(String newDate) {
		NewDate = newDate;
	}
	public String getReturnDate() {
		return ReturnDate;
	}
	public void setReturnDate(String returnDate) {
		ReturnDate = returnDate;
	}
	public String getBankBook() {
		return BankBook;
	}
	public void setBankBook(String bankBook) {
		BankBook = bankBook;
	}
	public String getAccountManage() {
		return AccountManage;
	}
	public void setAccountManage(String accountManage) {
		AccountManage = accountManage;
	}
	public String getCustomerNum() {
		return CustomerNum;
	}
	public void setCustomerNum(String customerNum) {
		CustomerNum = customerNum;
	}
	public String getRegistrationDate() {
		return RegistrationDate;
	}
	public void setRegistrationDate(String registrationDate) {
		RegistrationDate = registrationDate;
	}
	public String getRegistration() {
		return Registration;
	}
	public void setRegistration(String registration) {
		Registration = registration;
	}
	public String getBankBookFile() {
		return BankBookFile;
	}
	public void setBankBookFile(String bankBookFile) {
		BankBookFile = bankBookFile;
	}
	public String getBankBookFileNm() {
		return BankBookFileNm;
	}
	public void setBankBookFileNm(String bankBookFileNm) {
		BankBookFileNm = bankBookFileNm;
	}
	public String getAccountIssue() {
		return AccountIssue;
	}
	public void setAccountIssue(String accountIssue) {
		AccountIssue = accountIssue;
	}
	public String getDeleteYN() {
		return DeleteYN;
	}
	public void setDeleteYN(String deleteYN) {
		DeleteYN = deleteYN;
	}
	public String getCreateDateTime() {
		return CreateDateTime;
	}
	public void setCreateDateTime(String createDateTime) {
		CreateDateTime = createDateTime;
	}
	public String getUpdateDateTime() {
		return UpdateDateTime;
	}
	public void setUpdateDateTime(String updateDateTime) {
		UpdateDateTime = updateDateTime;
	}
	protected String CreateDateTime; //작성일자
	protected String UpdateDateTime; //변경일자
	//넘어다니는 파라미터
    protected String curPage;
	protected String searchGb;
    protected String searchTxt;
    public String getCurPage() {
		return curPage;
	}
	public void setCurPage(String curPage) {
		this.curPage = curPage;
	}
	public String getSearchGb() {
		return searchGb;
	}
	public void setSearchGb(String searchGb) {
		this.searchGb = searchGb;
	}
	public String getSearchTxt() {
		return searchTxt;
	}
	public void setSearchTxt(String searchTxt) {
		this.searchTxt = searchTxt;
	}

}
