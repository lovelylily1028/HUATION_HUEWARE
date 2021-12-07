package com.huation.common.projectcodemanage;

public class ProjectCodeManageDTO {

	 
	//logid
    protected String logid;

    //�Ѿ�ٴϴ� �Ķ����(���ν��� ȣ�Ⱚ)
	protected String chUserID; 		//�α��� ���� ���ǰ�
	protected String vSearchType;	//�˻�����
	protected String vSearch;		//�˻���
	protected int nRow;				//����Ʈ ������ �Ѱ���(����)
	protected int nPage;			//���� ������
	protected String JobGb;			//����¡&����Ʈ ����
	protected String curPage;		//�Ѿ�� ���� ������ ��
	
	//������ DTO Get/Set
	protected int	 PjSeq;						//������Ʈ PK ������(index +1)�� �ڵ�����
	protected String ProjectCode; 				//������Ʈ �ڵ���� ��ȣ
	protected String ProjectDivision;			//������Ʈ ���� �ڵ� ����
	protected String PurchaseDivision;			//���ֻ� ����
	protected String P_ProjectCode;				//�� ������Ʈ �ڵ�
	protected String P_ProjectName;				//�� ������Ʈ ��
	protected String MoreCode; 					//�����ڵ�
	protected String Public_No; 				//������ȣ
	protected String Pub_ProjectName;			//���õ� ������ȣ ������Ʈ��
	protected String ContractCode;				//����ڵ��ȣ
	protected String Con_ProjectName;			//���õ� ����ڵ� ������Ʈ��
	protected String ProjectName;				//������Ʈ ��
	protected String CustomerName;				//�����
	protected String PurchaseName;				//���ֻ��
	protected String ProjectStartDate; 			//������Ʈ ���� ������
	protected String ProjectEndDate;			//������Ʈ ���� ������
	protected int ProjectProgressDate;			//������Ʈ ����Ⱓ
	protected String ChargeID;					//��翵��
	protected String ChargeNm;					//��翵�� ��
	protected String ChargePmNm;				//���PM ��
	protected String ChargeProjectManager;		//���PM
	protected String ChargeComent;				//���� �ڸ�Ʈ
	protected String ProjectCreateUser;			//������Ʈ �ڵ���� ���� ������
	protected String ProjectCreateDate;			//������Ʈ �ڵ���� ���� ������
	protected String ProjectUpdateUser;			//������Ʈ �ڵ���� ������ ������
	protected String ProjectUpdateDate;			//������Ʈ �ڵ���� ������ ������
	protected String DeletedYN;					//��������
	protected String ContractCodeYN;			//����ڵ� ��뿩��(Y,N)
	protected int ProgressPercent;				//�����
	protected String CheckSuccessYN;				//�˼��Ϸ� ����
	protected String CheckDocumentFile;			//�˼��������� ���
	protected String CheckDocumentFileNm;		//�˼��������� ��
	protected String ProjectEndYN;				//������Ʈ ���Ῡ��
	protected String ProjectProgressFile;		//������Ʈ ���๮�� ���
	protected String ProjectProgressFileNm;		//������Ʈ ���๮�� ��
	protected String FreeCostYN;				//������Ʈ ����(����,����)
	
	
	
	
	public String getFreeCostYN() {
		return FreeCostYN;
	}
	public void setFreeCostYN(String freeCostYN) {
		FreeCostYN = freeCostYN;
	}
	public String getProjectProgressFile() {
		return ProjectProgressFile;
	}
	public void setProjectProgressFile(String projectProgressFile) {
		ProjectProgressFile = projectProgressFile;
	}
	public String getProjectProgressFileNm() {
		return ProjectProgressFileNm;
	}
	public void setProjectProgressFileNm(String projectProgressFileNm) {
		ProjectProgressFileNm = projectProgressFileNm;
	}
	public int getProgressPercent() {
		return ProgressPercent;
	}
	public void setProgressPercent(int progressPercent) {
		ProgressPercent = progressPercent;
	}
	public String getCheckSuccessYN() {
		return CheckSuccessYN;
	}
	public void setCheckSuccessYN(String checkSuccessYN) {
		CheckSuccessYN = checkSuccessYN;
	}
	public String getCheckDocumentFile() {
		return CheckDocumentFile;
	}
	public void setCheckDocumentFile(String checkDocumentFile) {
		CheckDocumentFile = checkDocumentFile;
	}
	public String getCheckDocumentFileNm() {
		return CheckDocumentFileNm;
	}
	public void setCheckDocumentFileNm(String checkDocumentFileNm) {
		CheckDocumentFileNm = checkDocumentFileNm;
	}
	public String getProjectEndYN() {
		return ProjectEndYN;
	}
	public void setProjectEndYN(String projectEndYN) {
		ProjectEndYN = projectEndYN;
	}
	public String getProjectEndDocumentFile() {
		return ProjectEndDocumentFile;
	}
	public void setProjectEndDocumentFile(String projectEndDocumentFile) {
		ProjectEndDocumentFile = projectEndDocumentFile;
	}
	public String getProjectEndDocumentFileNm() {
		return ProjectEndDocumentFileNm;
	}
	public void setProjectEndDocumentFileNm(String projectEndDocumentFileNm) {
		ProjectEndDocumentFileNm = projectEndDocumentFileNm;
	}
	protected String ProjectEndDocumentFile;	//������Ʈ �������⹰ ���
	protected String ProjectEndDocumentFileNm;	//������Ʈ �������⹰ ��
	
	
	
	
	
	//������Ʈ�ڵ� Mapping Table ��� DTO(����ڵ� ����)
	protected String SortID;					//���� ����
	
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
	public int getPjSeq() {
		return PjSeq;
	}
	public void setPjSeq(int pjSeq) {
		PjSeq = pjSeq;
	}
	public String getProjectCode() {
		return ProjectCode;
	}
	public void setProjectCode(String projectCode) {
		ProjectCode = projectCode;
	}
	
	public String getP_ProjectName() {
		return P_ProjectName;
	}
	public void setP_ProjectName(String p_ProjectName) {
		P_ProjectName = p_ProjectName;
	}
	public String getProjectDivision() {
		return ProjectDivision;
	}
	public void setProjectDivision(String projectDivision) {
		ProjectDivision = projectDivision;
	}
	public String getPurchaseDivision() {
		return PurchaseDivision;
	}
	public void setPurchaseDivision(String purchaseDivision) {
		PurchaseDivision = purchaseDivision;
	}
	public String getP_ProjectCode() {
		return P_ProjectCode;
	}
	public void setP_ProjectCode(String p_ProjectCode) {
		P_ProjectCode = p_ProjectCode;
	}
	public String getMoreCode() {
		return MoreCode;
	}
	public void setMoreCode(String moreCode) {
		MoreCode = moreCode;
	}
	public String getPublic_No() {
		return Public_No;
	}
	public void setPublic_No(String public_No) {
		Public_No = public_No;
	}
	public String getContractCode() {
		return ContractCode;
	}
	public void setContractCode(String contractCode) {
		ContractCode = contractCode;
	}
	public String getProjectName() {
		return ProjectName;
	}
	public void setProjectName(String projectName) {
		ProjectName = projectName;
	}
	public String getCustomerName() {
		return CustomerName;
	}
	public void setCustomerName(String customerName) {
		CustomerName = customerName;
	}
	public String getPurchaseName() {
		return PurchaseName;
	}
	public void setPurchaseName(String purchaseName) {
		PurchaseName = purchaseName;
	}
	public String getProjectStartDate() {
		return ProjectStartDate;
	}
	public void setProjectStartDate(String projectStartDate) {
		ProjectStartDate = projectStartDate;
	}
	public String getProjectEndDate() {
		return ProjectEndDate;
	}
	public void setProjectEndDate(String projectEndDate) {
		ProjectEndDate = projectEndDate;
	}
	public int getProjectProgressDate() {
		return ProjectProgressDate;
	}
	public void setProjectProgressDate(int projectProgressDate) {
		ProjectProgressDate = projectProgressDate;
	}
	public String getChargeID() {
		return ChargeID;
	}
	public void setChargeID(String chargeID) {
		ChargeID = chargeID;
	}
	public String getChargeProjectManager() {
		return ChargeProjectManager;
	}
	public void setChargeProjectManager(String chargeProjectManager) {
		ChargeProjectManager = chargeProjectManager;
	}
	
	public String getChargeNm() {
		return ChargeNm;
	}
	public void setChargeNm(String chargeNm) {
		ChargeNm = chargeNm;
	}
	public String getChargePmNm() {
		return ChargePmNm;
	}
	public void setChargePmNm(String chargePmNm) {
		ChargePmNm = chargePmNm;
	}
	public String getChargeComent() {
		return ChargeComent;
	}
	public void setChargeComent(String chargeComent) {
		ChargeComent = chargeComent;
	}
	public String getProjectCreateUser() {
		return ProjectCreateUser;
	}
	public void setProjectCreateUser(String projectCreateUser) {
		ProjectCreateUser = projectCreateUser;
	}
	public String getProjectCreateDate() {
		return ProjectCreateDate;
	}
	public void setProjectCreateDate(String projectCreateDate) {
		ProjectCreateDate = projectCreateDate;
	}
	public String getProjectUpdateUser() {
		return ProjectUpdateUser;
	}
	public void setProjectUpdateUser(String projectUpdateUser) {
		ProjectUpdateUser = projectUpdateUser;
	}
	public String getProjectUpdateDate() {
		return ProjectUpdateDate;
	}
	public void setProjectUpdateDate(String projectUpdateDate) {
		ProjectUpdateDate = projectUpdateDate;
	}
	public String getDeletedYN() {
		return DeletedYN;
	}
	public void setDeletedYN(String deletedYN) {
		DeletedYN = deletedYN;
	}
	public String getPub_ProjectName() {
		return Pub_ProjectName;
	}
	public void setPub_ProjectName(String pub_ProjectName) {
		Pub_ProjectName = pub_ProjectName;
	}
	public String getCon_ProjectName() {
		return Con_ProjectName;
	}
	public void setCon_ProjectName(String con_ProjectName) {
		Con_ProjectName = con_ProjectName;
	}
	public String getContractCodeYN() {
		return ContractCodeYN;
	}
	public void setContractCodeYN(String contractCodeYN) {
		ContractCodeYN = contractCodeYN;
	}
	public String getSortID() {
		return SortID;
	}
	public void setSortID(String sortID) {
		SortID = sortID;
	}
	
	
	
}
