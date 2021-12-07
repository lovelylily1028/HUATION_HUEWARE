package com.huation.common.formfile;

public class FormFileDTO {

	 
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
	public String getFormFile() {
		return FormFile;
	}
	public void setFormFile(String formFile) {
		FormFile = formFile;
	}
	public String getFormFileNm() {
		return FormFileNm;
	}
	public void setFormFileNm(String formFileNm) {
		FormFileNm = formFileNm;
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
	// sp 변경
	protected String chUserID;
	protected String vSearchType;
	protected String vSearch;
	protected int nRow;
	protected int nPage;
	protected String JobGb;

	/*
	 * 게시판->전사공지
	 */
	protected int Seq; //pk
	
	public int getSeq() {
		return Seq;
	}
	public void setSeq(int seq) {
		Seq = seq;
	}
	protected String WriteUser; // 등록자
	protected String WriteFormUser; //서식자
	protected String WriteFormUserNm; //서식자명
	public String getWriteFormUserNm() {
		return WriteFormUserNm;
	}
	public void setWriteFormUserNm(String writeFormUserNm) {
		WriteFormUserNm = writeFormUserNm;
	}
	protected String FormGroup; //서식분류코드
	protected String FormGroupNm; //서식분류코드이름
	public String getFormGroupNm() {
		return FormGroupNm;
	}
	public void setFormGroupNm(String formGroupNm) {
		FormGroupNm = formGroupNm;
	}
	protected String FormFile; // 파일경로
	protected String FormFileNm; // 파일명
	protected String Title; // 제목
	protected String Contents; //  내용
	protected int ReadCount; //조회수
	public int getReadCount() {
		return ReadCount;
	}
	public void setReadCount(int readCount) {
		ReadCount = readCount;
	}
	public String getWriteFormUser() {
		return WriteFormUser;
	}
	public void setWriteFormUser(String writeFormUser) {
		WriteFormUser = writeFormUser;
	}
	public String getFormGroup() {
		return FormGroup;
	}
	public void setFormGroup(String formGroup) {
		FormGroup = formGroup;
	}
	public String getUpdateUser() {
		return UpdateUser;
	}
	public void setUpdateUser(String updateUser) {
		UpdateUser = updateUser;
	}
	protected String CreateDateTime; // 작성일자
	protected String UpdateDateTime; // 변경일자
	protected String UpdateUser; // 최종수정한사람
	protected String DeletedYN; // 삭제여부
	protected String DeletedUser; // 삭제한사람

	// 넘어다니는 파라미터(프로시저 호출값)
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
