package com.huation.common.currentstatus;

public class CurrentStatusDTO {

	/*
	 * shbyeon. 2013_02_27(��) DTO  
	 */
	
	// SalesCurrentStatus Table ����.
	protected String PreSalesCode; //Pk
	protected int Quarter; //�б�
	protected String EnterpriseCode; //�����ְ��� (��ü�ڵ�)
	protected String PermitNo;      //�����ְ���(��ü�� ����ڵ�Ϲ�ȣ)
	protected String EnterpriseNm; //�����ְ��� ��
	protected String OperatingCompany; //����
	protected String SalesMan; //���� �����
	protected String SalesManTel; //���� ����� ��ȭ��ȣ
	protected String ProjectName; //������Ʈ��
	protected String SalesProjections; //��������
	protected String PublicNo; //������ȣ
	protected String P_PublicNo; //������ȣ
	protected String SalesFile_Xls; //÷�����ϰ��_����
	protected String SalesFileNm_Xls; //÷�����ϸ�_����
	protected String SalesFile_Pdf; //÷�����ϰ��_PDF
	protected String SalesFileNm_Pdf; //÷�����ϸ�_PDF
	protected String Orderble; //���ְ��ɼ�
	protected String OrderbleNm; //���ְ��ɼ� �̸�(����������Ȳ �󼼺��⿡�� �������� ����� DTO)
	protected String ChargeID; //��翵��(��)
	protected String ChargeNm; //��翵��(��)�̸���
	protected String ChargeSecondID; //��翵��(��)
	protected String ChargeSeNm; //��翵��(��)�̸���
	protected String Note; //���
	protected String AssignPerson; //�����η�
	protected String DateProjections; //����ñ�
	protected String OrderStatus; //���ֻ���(��࿩��) ������ ���� ��࿩�� UPDATE �޴� DTO
	protected String DeletedYN; // ��������
	protected String WriteUser; //�ۼ���
	protected String UpdateUser; //�����ѻ��.
	
	protected String CompName_Dup; //��ü�� �ߺ�üũ(����)
	
	//Product Table ����.
	protected String ProductPk; //��ǰ�ڵ�pk == ������Ʈpk
	protected String ProductCode; //(�ڻ�/���ڻ�)&(����/�ܼ�)��ǰ�ڵ� ��ġ���̺� ���.
	//T_CODE �� CD_NM(ProductCode)�� ���õ� �̸����� �������� ���ػ��.
	protected String ProductName;
	
	//Comment Table ����.
	protected String ProjectPkCo; //ProjectPk == ProjectPkCo (����������Ȳ �� ���� pk)
	protected int ComentPk;  //Pk(��� �ڸ�Ʈ PK)
	protected String SalesMan_co; //���� 
	protected String ChargeID_co; //��翵��
	protected String Contents;	  //�ڸ�Ʈ����	
	protected String SalesFile;	  //�ڸ�Ʈ ���ϰ��
	protected String SalesFileNm; //�ڸ�Ʈ �����̸�
	protected String CreateDataTime; //�ۼ�����
	
	//sp ���DTO
	protected String LoginID; //�α��ξ��̵�
	protected String vSearchYear; //�˻�����(�⵵)
	protected String vSearchType; //�˻�����(��������)
	protected String vSearchType2; //�˻�����(���)
	protected String vSearch; //�˻���
	protected int nRow; //�� �ο� �����ͱ���
	protected int nPage; //�� ������ ��
	protected String JobGb; //PAGE&LIST
	protected int nTotRow;	//�� ������ ����
	protected int chkCount;
	
	
	//��ü �����Ҷ� �����Է� check���η� ���ο� ��ü�ڵ带 ���� 
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
