package com.huation.common.bankmanage;

public class BankManageDTO {

	
	protected int seq; //Ű��
	protected String BankCode; //�����ڵ��ȣ
	protected String AccountNumber; //���¹�ȣ ����ũ��������ȣ
	protected String NewDate; //�ű԰�����
	protected String ReturnDate; //�������
	protected String BankBook; //�������
	protected String AccountManage; //���°�����
	protected String CustomerNum; //����ȣ
	protected String RegistrationDate; //�������
	protected String Registration; //�����
	protected String BankBookFile; //�����ϰ��
	protected String BankBookFileNm; //�����ϸ�
	protected String AccountIssue; //����Ư�̻���
	protected String DeleteYN; //��������
	
	
	//���ν��� �Ѿ�ٴϴ� �Ķ����
	
	protected String chUserID; //���ǰ�
	protected String BankName; //������ �����
	protected String RegistrationName; //������ ����ڸ�
	
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
	protected String CreateDateTime; //�ۼ�����
	protected String UpdateDateTime; //��������
	//�Ѿ�ٴϴ� �Ķ����
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
