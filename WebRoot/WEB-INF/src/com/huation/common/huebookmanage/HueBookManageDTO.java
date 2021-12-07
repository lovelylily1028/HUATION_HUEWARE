package com.huation.common.huebookmanage;

public class HueBookManageDTO {

	//도서신청 및 도서결재 DTO(2012.11.21(수) bsh)
	protected int SeqPk; //도서관리 pk값
	protected String requestUser; //도서 신청자
	protected String bookName; //도서 명(책이름)
	protected String writer; //저자
	protected int price; //책 가격
	protected String requestDateTime; //신청일자(생성일자)
	protected String AccountManage; //계좌관리점
	protected String branchCode; //분야(코드북)
	protected String branchCodeNm; //분야명(코드북)
	protected String publisher; //출판사
	protected String translator; //역자
	protected String requestBookCount; //신청권수
	protected String purchasingOffice; //구매처
	protected String approvalUser; //결재자
	protected String approvalName; //결재자명
	protected String contents; //내용
	protected String approvalAndReturn; //승인 반려사유
	protected String status; //진행상태(1.신청중,2.결재완료,3.구매완료)
	protected String updateDateTime; //수정일자
	protected String updateUser; //최종 수정자
	protected String deleteDateTime; //삭제일자
	protected String deleteUser; //최종 삭제자
	protected String deleteYN; //삭제여부
	protected String clearDate; //결재일자
	protected String buyDate; //구매일자
	protected int buyPrice; //구매가격
	
	//넘어다니는 파라미터(페이징 및 검색 기능사용)
	protected String curPage;
	protected int nRow;
	protected int nPage;
	protected String JobGb;
	protected String vSearchType;
	protected String vSearch;
	
	//도서신청 (상세보기)에서 as 명으로 가져올 DTO
	protected String requestName; //신청자명
	protected String requestDate; //신청일자
	
	
	public String getRequestName() {
		return requestName;
	}
	public void setRequestName(String requestName) {
		this.requestName = requestName;
	}
	public String getRequestDate() {
		return requestDate;
	}
	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
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
	public int getSeqPk() {
		return SeqPk;
	}
	public void setSeqPk(int seqPk) {
		SeqPk = seqPk;
	}
	public String getRequestUser() {
		return requestUser;
	}
	public void setRequestUser(String requestUser) {
		this.requestUser = requestUser;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getRequestDateTime() {
		return requestDateTime;
	}
	public void setRequestDateTime(String requestDateTime) {
		this.requestDateTime = requestDateTime;
	}
	public String getAccountManage() {
		return AccountManage;
	}
	public void setAccountManage(String accountManage) {
		AccountManage = accountManage;
	}
	public String getBranchCode() {
		return branchCode;
	}
	public void setBranchCode(String branchCode) {
		this.branchCode = branchCode;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getTranslator() {
		return translator;
	}
	public void setTranslator(String translator) {
		this.translator = translator;
	}
	public String getRequestBookCount() {
		return requestBookCount;
	}
	public void setRequestBookCount(String requestBookCount) {
		this.requestBookCount = requestBookCount;
	}
	public String getPurchasingOffice() {
		return purchasingOffice;
	}
	public void setPurchasingOffice(String purchasingOffice) {
		this.purchasingOffice = purchasingOffice;
	}
	public String getApprovalUser() {
		return approvalUser;
	}
	public void setApprovalUser(String approvalUser) {
		this.approvalUser = approvalUser;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getApprovalAndReturn() {
		return approvalAndReturn;
	}
	public void setApprovalAndReturn(String approvalAndReturn) {
		this.approvalAndReturn = approvalAndReturn;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUpdateDateTime() {
		return updateDateTime;
	}
	public void setUpdateDateTime(String updateDateTime) {
		this.updateDateTime = updateDateTime;
	}
	public String getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}
	public String getDeleteDateTime() {
		return deleteDateTime;
	}
	public void setDeleteDateTime(String deleteDateTime) {
		this.deleteDateTime = deleteDateTime;
	}
	public String getDeleteUser() {
		return deleteUser;
	}
	public void setDeleteUser(String deleteUser) {
		this.deleteUser = deleteUser;
	}
	public String getDeleteYN() {
		return deleteYN;
	}
	public void setDeleteYN(String deleteYN) {
		this.deleteYN = deleteYN;
	}
	public String getClearDate() {
		return clearDate;
	}
	public void setClearDate(String clearDate) {
		this.clearDate = clearDate;
	}
	public String getBuyDate() {
		return buyDate;
	}
	public void setBuyDate(String buyDate) {
		this.buyDate = buyDate;
	}
	public int getBuyPrice() {
		return buyPrice;
	}
	public void setBuyPrice(int buyPrice) {
		this.buyPrice = buyPrice;
	}
	public String getCurPage() {
		return curPage;
	}
	public void setCurPage(String curPage) {
		this.curPage = curPage;
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
	public String getBranchCodeNm() {
		return branchCodeNm;
	}
	public void setBranchCodeNm(String branchCodeNm) {
		this.branchCodeNm = branchCodeNm;
	}
	public String getApprovalName() {
		return approvalName;
	}
	public void setApprovalName(String approvalName) {
		this.approvalName = approvalName;
	}


}
