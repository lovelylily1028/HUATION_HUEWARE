package com.huation.common.familyevent;

public class FamilyEventDTO {

	 
	 //log id
    protected String logid;
    
    protected int loginSeq;

	public String getLogid() {
		return logid;
	}
	public void setLogid(String logid) {
		this.logid = logid;
	}
	public int getLoginSeq() {
		return loginSeq;
	}
	public void setLoginSeq(int loginSeq) {
		this.loginSeq = loginSeq;
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
	public String getWriteUser() {
		return WriteUser;
	}
	public void setWriteUser(String writeUser) {
		WriteUser = writeUser;
	}
	public String getEventFile() {
		return EventFile;
	}
	public void setEventFile(String eventFile) {
		EventFile = eventFile;
	}
	public String getEventFileNm() {
		return EventFileNm;
	}
	public void setEventFileNm(String eventFileNm) {
		EventFileNm = eventFileNm;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getContents() {
		return Contents;
	}
	public void setContents(String contents) {
		Contents = contents;
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
	public String getDeletedYN() {
		return DeletedYN;
	}
	public void setDeletedYN(String deletedYN) {
		DeletedYN = deletedYN;
	}
	public String getDeletedUser() {
		return DeletedUser;
	}
	public void setDeletedUser(String deletedUser) {
		DeletedUser = deletedUser;
	}
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
	// sp ����
	protected String chUserID;
	protected String vSearchType;
	protected String vSearch;
	protected int nRow;
	protected int nPage;
	protected String JobGb;

	/*
	 * �Խ���->�������
	 */
	protected int Seq; //pk
	
	public int getSeq() {
		return Seq;
	}
	public void setSeq(int seq) {
		Seq = seq;
	}
	protected String WriteUser; // �����
	protected String EventFile; // ���ϰ��
	protected String EventFileNm; // ���ϸ�
	protected String Title; // ����
	protected String Contents; //  ����
	protected String CreateDateTime; // �ۼ�����
	protected String UpdateDateTime; // ��������
	
	protected String DeletedYN; // ��������
	protected String DeletedUser; // �����ѻ��
	
	protected int ReadCount;

	public int getReadCount() {
		return ReadCount;
	}
	public void setReadCount(int readCount) {
		ReadCount = readCount;
	}
	// �Ѿ�ٴϴ� �Ķ����(���ν��� ȣ�Ⱚ)
	protected String curPage;
	protected String searchGb;
	protected String searchTxt;
	protected String WriteUserName;

	public String getWriteUserName() {
		return WriteUserName;
	}
	public void setWriteUserName(String writeUserName) {
		WriteUserName = writeUserName;
	}
	

}
