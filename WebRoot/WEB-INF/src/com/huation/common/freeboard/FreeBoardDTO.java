package com.huation.common.freeboard;

public class FreeBoardDTO {

	  
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
	public String getBoardFile() {
		return BoardFile;
	}
	public void setBoardFile(String boardFile) {
		BoardFile = boardFile;
	}
	public String getBoardFileNm() {
		return BoardFileNm;
	}
	public void setBoardFileNm(String boardFileNm) {
		BoardFileNm = boardFileNm;
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
	protected int nnRow;
	public int getNnRow() {
		return nnRow;
	}
	public void setNnRow(int nnRow) {
		this.nnRow = nnRow;
	}
	protected int nPage;
	protected String JobGb;
	protected int nTotRow;
	protected int nn;

	public int getNn() {
		return nn;
	}
	public void setNn(int nn) {
		this.nn = nn;
	}
	public int getnTotRow() {
		return nTotRow;
	}
	public void setnTotRow(int nTotRow) {
		this.nTotRow = nTotRow;
	}
	/*
	 * 게시판->자유게시판
	 */
	protected int Seq; //pk
	
	public int getSeq() {
		return Seq;
	}
	public void setSeq(int seq) {
		Seq = seq;
	}
	protected String WriteUser; // 등록자
	protected String BoardFile; // 파일경로
	protected String BoardFileNm; // 파일명
	protected String Title; // 제목
	protected String Contents; //  내용
	protected String CreateDateTime; // 작성일자
	protected String UpdateDateTime; // 변경일자
	
	protected String DeletedYN; // 삭제여부
	protected String DeletedUser; // 삭제한사람

	// 넘어다니는 파라미터(프로시저 호출값)
	protected String curPage;
	protected String searchGb;
	protected String searchTxt;
	protected String WriteUserName;
	protected int ReadCount; //조회수
	protected int ReplyCount; //총댓글수
	protected int ReplyCountt; //총댓글수
	protected int ReplyCounttt; //총댓글수
	
	public int getReplyCounttt() {
		return ReplyCounttt;   
	}
	public void setReplyCounttt(int replyCounttt) {
		ReplyCounttt = replyCounttt;
	}
	public int getReplyCountt() {
		return ReplyCountt;
	}
	public void setReplyCountt(int replyCountt) {
		ReplyCountt = replyCountt;
	}
	public int getReplyCount() {
		return ReplyCount;
	}
	public void setReplyCount(int replyCount) {
		ReplyCount = replyCount;
	}
	//게시판 ->자유게시판 댓글달기
	protected int SeqRep; //댓글 등록 pk
	protected int SeqBoard; //자유게시판 글목록 pk 값 Join해서 자유게시판 글에대한 댓글을 비교하기위해 가져올 값
	protected String RepWriteUser; //댓글등록자ID
	protected String RepUserName; // 댓글등록자Name
	protected String TitleBoard; //자유게시판 글 제목 값
	
	public String getWriteUserBoard() {
		return WriteUserBoard;
	}
	public void setWriteUserBoard(String writeUserBoard) {
		WriteUserBoard = writeUserBoard;
	}
	protected String WriteUserBoard; //자유게시판 글쓴이
	public String getTitleBoard() {
		return TitleBoard;
	}
	public void setTitleBoard(String titleBoard) {
		TitleBoard = titleBoard;
	}
	protected String ContentsRep; // 댓글내용
	protected String CreateDateTimeRep; //댓글단시간
	protected String UpdateDateTimeRep; //댓글수정한시간
	protected String DeleteYNRep; //댓글삭제여부
	protected String DeleteUserRep; //댓글삭제한사람
	
	public int getSeqRep() {
		return SeqRep;
	}
	public void setSeqRep(int seqRep) {
		SeqRep = seqRep;
	}
	public int getSeqBoard() {
		return SeqBoard;
	}
	public void setSeqBoard(int seqBoard) {
		SeqBoard = seqBoard;
	}
	public String getRepWriteUser() {
		return RepWriteUser;
	}
	public void setRepWriteUser(String repWriteUser) {
		RepWriteUser = repWriteUser;
	}
	public String getRepUserName() {
		return RepUserName;
	}
	public void setRepUserName(String repUserName) {
		RepUserName = repUserName;
	}
	public String getContentsRep() {
		return ContentsRep;
	}
	public void setContentsRep(String contentsRep) {
		ContentsRep = contentsRep;
	}
	public String getCreateDateTimeRep() {
		return CreateDateTimeRep;
	}
	public void setCreateDateTimeRep(String createDateTimeRep) {
		CreateDateTimeRep = createDateTimeRep;
	}
	public String getUpdateDateTimeRep() {
		return UpdateDateTimeRep;
	}
	public void setUpdateDateTimeRep(String updateDateTimeRep) {
		UpdateDateTimeRep = updateDateTimeRep;
	}
	public String getDeleteYNRep() {
		return DeleteYNRep;
	}
	public void setDeleteYNRep(String deleteYNRep) {
		DeleteYNRep = deleteYNRep;
	}
	public String getDeleteUserRep() {
		return DeleteUserRep;
	}
	public void setDeleteUserRep(String deleteUserRep) {
		DeleteUserRep = deleteUserRep;
	}

	public int getReadCount() {
		return ReadCount;
	}
	public void setReadCount(int readCount) {
		ReadCount = readCount;
	}
	public String getWriteUserName() {
		return WriteUserName;
	}
	public void setWriteUserName(String writeUserName) {
		WriteUserName = writeUserName;
	}
	

}
