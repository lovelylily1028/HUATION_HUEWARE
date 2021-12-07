package com.huation.common.currentstatus;

public class CurrentStatusDTO {

	/*
	 * shbyeon. 2013_02_27(수) DTO  
	 */
	
	// SalesCurrentStatus Table 참조.
	protected String PreSalesCode; //Pk
	protected int Quarter; //분기
	protected String EnterpriseCode; //영업주관사 (업체코드)
	protected String PermitNo;      //영업주관사(업체명 사업자등록번호)
	protected String EnterpriseNm; //영업주관사 명
	protected String OperatingCompany; //고객사
	protected String SalesMan; //고객사 담당자
	protected String SalesManTel; //고객사 담당자 전화번호
	protected String ProjectName; //프로젝트명
	protected String SalesProjections; //예상매출액
	protected String PublicNo; //견적번호
	protected String P_PublicNo; //모발행번호
	protected String SalesFile_Xls; //첨부파일경로_엑셀
	protected String SalesFileNm_Xls; //첨부파일명_엑셀
	protected String SalesFile_Pdf; //첨부파일경로_PDF
	protected String SalesFileNm_Pdf; //첨부파일명_PDF
	protected String Orderble; //수주가능성
	protected String OrderbleNm; //수주가능성 이름(영업진행현황 상세보기에서 계약됫을때 사용할 DTO)
	protected String ChargeID; //담당영업(정)
	protected String ChargeNm; //담당영업(정)이름명
	protected String ChargeSecondID; //담당영업(부)
	protected String ChargeSeNm; //담당영업(부)이름명
	protected String Note; //비고
	protected String AssignPerson; //배정인력
	protected String DateProjections; //예상시기
	protected String OrderStatus; //수주상태(계약여부) 견적서 발행 계약여부 UPDATE 받는 DTO
	protected String DeletedYN; // 삭제여부
	protected String WriteUser; //작성자
	protected String UpdateUser; //수정한사람.
	
	protected String CompName_Dup; //업체명 중복체크(공통)
	
	//Product Table 참조.
	protected String ProductPk; //상품코드pk == 프로젝트pk
	protected String ProductCode; //(자사/비자사)&(내수/외수)상품코드 배치테이블 사용.
	//T_CODE 의 CD_NM(ProductCode)에 관련된 이름명을 가져오기 위해사용.
	protected String ProductName;
	
	//Comment Table 참조.
	protected String ProjectPkCo; //ProjectPk == ProjectPkCo (영업진행현황 글 매핑 pk)
	protected int ComentPk;  //Pk(댓글 코멘트 PK)
	protected String SalesMan_co; //고객사 
	protected String ChargeID_co; //담당영업
	protected String Contents;	  //코멘트내용	
	protected String SalesFile;	  //코멘트 파일경로
	protected String SalesFileNm; //코멘트 파일이름
	protected String CreateDataTime; //작성일자
	
	//sp 사용DTO
	protected String LoginID; //로그인아이디
	protected String vSearchYear; //검색구분(년도)
	protected String vSearchType; //검색구분(영업상태)
	protected String vSearchType2; //검색구분(목록)
	protected String vSearch; //검색명
	protected int nRow; //총 로우 데이터길이
	protected int nPage; //총 페이지 수
	protected String JobGb; //PAGE&LIST
	protected int nTotRow;	//총 데이터 갯수
	protected int chkCount;
	
	
	//업체 수정할때 수동입력 check여부로 새로운 업체코드를 생성 
	protected String checkyn;
	
	public String getCheckyn() {
		return checkyn;
	}
	public void setCheckyn(String checkyn) {
		this.checkyn = checkyn;
	}
	
	public String getPreSalesCode() {
		return PreSalesCode;
	}
	public void setPreSalesCode(String preSalesCode) {
		PreSalesCode = preSalesCode;
	}
	public int getQuarter() {
		return Quarter;
	}
	public void setQuarter(int quarter) {
		Quarter = quarter;
	}
	public String getEnterpriseCode() {
		return EnterpriseCode;
	}
	public void setEnterpriseCode(String enterpriseCode) {
		EnterpriseCode = enterpriseCode;
	}
	public String getPermitNo() {
		return PermitNo;
	}
	public void setPermitNo(String permitNo) {
		PermitNo = permitNo;
	}
	public String getEnterpriseNm() {   
		return EnterpriseNm;
	}
	public void setEnterpriseNm(String enterpriseNm) {
		EnterpriseNm = enterpriseNm;
	}
	public String getOperatingCompany() {
		return OperatingCompany;
	}
	public void setOperatingCompany(String operatingCompany) {
		OperatingCompany = operatingCompany;
	}
	public String getSalesMan() {
		return SalesMan;
	}
	public void setSalesMan(String salesMan) {
		SalesMan = salesMan;
	}
	
	public String getSalesManTel() {
		return SalesManTel;
	}
	public void setSalesManTel(String salesManTel) {
		SalesManTel = salesManTel;
	}
	public String getProjectName() {
		return ProjectName;
	}
	public void setProjectName(String projectName) {
		ProjectName = projectName;
	}
	public String getSalesProjections() {
		return SalesProjections;
	}
	public void setSalesProjections(String salesProjections) {
		SalesProjections = salesProjections;
	}
	public String getPublicNo() {
		return PublicNo;
	}
	public void setPublicNo(String publicNo) {
		PublicNo = publicNo;
	}
	public String getP_PublicNo() {
		return P_PublicNo;
	}
	public void setP_PublicNo(String p_PublicNo) {
		P_PublicNo = p_PublicNo;
	}
	
	public String getSalesFile_Xls() {
		return SalesFile_Xls;
	}
	public void setSalesFile_Xls(String salesFile_Xls) {
		SalesFile_Xls = salesFile_Xls;
	}
	public String getSalesFileNm_Xls() {
		return SalesFileNm_Xls;
	}
	public void setSalesFileNm_Xls(String salesFileNm_Xls) {
		SalesFileNm_Xls = salesFileNm_Xls;
	}
	public String getSalesFile_Pdf() {
		return SalesFile_Pdf;
	}
	public void setSalesFile_Pdf(String salesFile_Pdf) {
		SalesFile_Pdf = salesFile_Pdf;
	}
	public String getSalesFileNm_Pdf() {
		return SalesFileNm_Pdf;
	}
	public void setSalesFileNm_Pdf(String salesFileNm_Pdf) {
		SalesFileNm_Pdf = salesFileNm_Pdf;
	}
	public String getOrderble() {
		return Orderble;
	}
	public void setOrderble(String orderble) {
		Orderble = orderble;
	}
	
	public String getOrderbleNm() {
		return OrderbleNm;
	}
	public void setOrderbleNm(String orderbleNm) {
		OrderbleNm = orderbleNm;
	}
	public String getChargeID() {
		return ChargeID;
	}
	public void setChargeID(String chargeID) {
		ChargeID = chargeID;
	}
	public String getChargeSecondID() {
		return ChargeSecondID;
	}
	public String getChargeNm() {
		return ChargeNm;
	}
	public void setChargeNm(String chargeNm) {
		ChargeNm = chargeNm;
	}
	public void setChargeSecondID(String chargeSecondID) {
		ChargeSecondID = chargeSecondID;
	}
	public String getChargeSeNm() {
		return ChargeSeNm;
	}
	public void setChargeSeNm(String chargeSeNm) {
		ChargeSeNm = chargeSeNm;
	}
	public String getNote() {
		return Note;
	}
	public void setNote(String note) {
		Note = note;
	}
	public String getAssignPerson() {
		return AssignPerson;
	}
	public void setAssignPerson(String assignPerson) {
		AssignPerson = assignPerson;
	}
	public String getDateProjections() {
		return DateProjections;
	}
	public void setDateProjections(String dateProjections) {
		DateProjections = dateProjections;
	}
	public String getOrderStatus() {
		return OrderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		OrderStatus = orderStatus;
	}
	public String getDeletedYN() {
		return DeletedYN;
	}
	public void setDeletedYN(String deletedYN) {
		DeletedYN = deletedYN;
	}
	public String getWriteUser() {
		return WriteUser;
	}
	public void setWriteUser(String writeUser) {
		WriteUser = writeUser;
	}
	
	public String getLoginID() {
		return LoginID;
	}
	public void setLoginID(String loginID) {
		LoginID = loginID;
	}
	public String getvSearchYear() {
		return vSearchYear;
	}
	public void setvSearchYear(String vSearchYear) {
		this.vSearchYear = vSearchYear;
	}
	public String getvSearchType() {
		return vSearchType;
	}
	public void setvSearchType(String vSearchType) {
		this.vSearchType = vSearchType;
	}
	public String getvSearchType2() {
		return vSearchType2;
	}
	public void setvSearchType2(String vSearchType2) {
		this.vSearchType2 = vSearchType2;
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
	public int getnTotRow() {
		return nTotRow;
	}
	public void setnTotRow(int nTotRow) {
		this.nTotRow = nTotRow;
	}
	
	
	
	public String getProductPk() {
		return ProductPk;
	}
	public void setProductPk(String productPk) {
		ProductPk = productPk;
	}
	public String getProductCode() {
		return ProductCode;
	}
	public void setProductCode(String productCode) {
		ProductCode = productCode;
	}
	
	public String getProductName() {
		return ProductName;
	}
	public void setProductName(String productName) {
		ProductName = productName;
	}
	public int getChkCount() {
		return chkCount;
	}
	public void setChkCount(int chkCount) {
		this.chkCount = chkCount;
	}
	public String getCompName_Dup() {
		return CompName_Dup;
	}
	public void setCompName_Dup(String compName_Dup) {
		CompName_Dup = compName_Dup;
	}
	public String getUpdateUser() {
		return UpdateUser;
	}
	public void setUpdateUser(String updateUser) {
		UpdateUser = updateUser;
	}
	public String getProjectPkCo() {
		return ProjectPkCo;
	}
	public void setProjectPkCo(String projectPkCo) {
		ProjectPkCo = projectPkCo;
	}
	public int getComentPk() {
		return ComentPk;
	}
	public void setComentPk(int comentPk) {
		ComentPk = comentPk;
	}
	public String getSalesMan_co() {
		return SalesMan_co;
	}
	public void setSalesMan_co(String salesMan_co) {
		SalesMan_co = salesMan_co;
	}
	public String getChargeID_co() {
		return ChargeID_co;
	}
	public void setChargeID_co(String chargeID_co) {
		ChargeID_co = chargeID_co;
	}
	public String getContents() {
		return Contents;
	}
	public void setContents(String contents) {
		Contents = contents;
	}
	public String getSalesFile() {
		return SalesFile;
	}
	public void setSalesFile(String salesFile) {
		SalesFile = salesFile;
	}
	public String getSalesFileNm() {
		return SalesFileNm;
	}
	public void setSalesFileNm(String salesFileNm) {
		SalesFileNm = salesFileNm;
	}
	public String getCreateDataTime() {
		return CreateDataTime;
	}
	public void setCreateDataTime(String createDataTime) {
		CreateDataTime = createDataTime;
	}
	

}
