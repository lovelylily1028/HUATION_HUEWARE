package com.huation.common.invoice;

import com.huation.framework.util.StringUtil;

public class InvoiceDTO {
	
	protected String MGTKEY;
	protected String invoice_code;
	protected String public_no;
	protected String gun;
	protected String ho;
	protected String manage_no;
	protected String approve_no;
	protected String invoice_gb;
	protected String issuetype;
	protected String TELL;
	protected String E_MAIL;
	protected String CONTRACT_CODE;
	protected String INVOICE_FILE;
	protected String INVOICE_FILENM;
	

	protected String receiver;
	protected String public_dt;
	protected String public_org;
	protected String item;
	protected String comp_code;
	protected String permit_no;
	protected String comp_nm;
	protected String owner_nm;
	protected String Business;
	protected String B_item;
	protected String Address;
	protected String Addr_detail;
	protected String Post;
	
	protected String supply_price;
	protected String vat;
	protected long supply_price_i; //long 추출 하기 위해 선언.
	protected long vat_i; //long 추출 하기 위해 선언.
	protected String deposit_amt;
	protected String deposit_dt;
	protected String state;
	protected String reference;
	protected String TITLE;
	protected String reg_id;
	protected String mod_id;
	protected String t_estiamt;
	protected String t_deposiamt;
	protected String productno;
	protected String pre_deposit_dt;
	protected String pre_deposit_an;
	protected String modifyFlag;
	protected String DELETED_YN;
	
	//품목
	protected String MGT_KEY;
	protected String WHITE_DT;
	protected String ITEM_NAME;
	protected String SPEC;
	protected String QTY;
	protected String UNIT_COSE;
	protected String AMOUNT;
	protected String TAX;
	protected String ETC;
	
	protected String depositFinish;	// 발행금액보다 적은 돈이 입금되었어도 못받은 나머지 금액은 그냥 안받는걸로 하기 위한 체크확인을 위한 값 추가(2014-11-06)
	
	protected String totalAmt;
	protected long totalAmt_i;
	
	
	
	
	
	
	
	public String getDepositFinish() {
		return depositFinish;
	}
	public void setDepositFinish(String depositFinish) {
		this.depositFinish = depositFinish;
	}
	public String getDELETED_YN() {
		return DELETED_YN;
	}
	public void setDELETED_YN(String dELETED_YN) {
		DELETED_YN = dELETED_YN;
	}
	public String getModifyFlag() {
		return modifyFlag;
	}
	public void setModifyFlag(String modifyFlag) {
		this.modifyFlag = modifyFlag;
	}
	public String getINVOICE_FILE() {
		return INVOICE_FILE;
	}
	public void setINVOICE_FILE(String iNVOICE_FILE) {
		INVOICE_FILE = iNVOICE_FILE;
	}
	public String getINVOICE_FILENM() {
		return INVOICE_FILENM;
	}
	public void setINVOICE_FILENM(String iNVOICE_FILENM) {
		INVOICE_FILENM = iNVOICE_FILENM;
	}
	public String getMGT_KEY() {
		return MGT_KEY;
	}
	public void setMGT_KEY(String mGT_KEY) {
		MGT_KEY = mGT_KEY;
	}
	public String getWHITE_DT() {
		return WHITE_DT;
	}
	public void setWHITE_DT(String wHITE_DT) {
		WHITE_DT = wHITE_DT;
	}
	public String getITEM_NAME() {
		return ITEM_NAME;
	}
	public void setITEM_NAME(String iTEM_NAME) {
		ITEM_NAME = iTEM_NAME;
	}
	public String getSPEC() {
		return SPEC;
	}
	public void setSPEC(String sPEC) {
		SPEC = sPEC;
	}
	public String getQTY() {
		return QTY;
	}
	public void setQTY(String qTY) {
		QTY = qTY;
	}
	public String getUNIT_COSE() {
		return UNIT_COSE;
	}
	public void setUNIT_COSE(String uNIT_COSE) {
		UNIT_COSE = uNIT_COSE;
	}
	public String getAMOUNT() {
		return AMOUNT;
	}
	public void setAMOUNT(String aMOUNT) {
		AMOUNT = aMOUNT;
	}
	public String getTAX() {
		return TAX;
	}
	public void setTAX(String tAX) {
		TAX = tAX;
	}
	public String getETC() {
		return ETC;
	}
	public void setETC(String eTC) {
		ETC = eTC;
	}
	public String getCONTRACT_CODE() {
		return CONTRACT_CODE;
	}
	public void setCONTRACT_CODE(String cONTRACT_CODE) {
		CONTRACT_CODE = cONTRACT_CODE;
	}
	public String getTELL() {
		return TELL;
	}
	public void setTELL(String tELL) {
		TELL = tELL;
	}
	public String getE_MAIL() {
		return E_MAIL;
	}
	public void setE_MAIL(String e_MAIL) {
		E_MAIL = e_MAIL;
	}
	public String getIssuetype() {
		return issuetype;
	}
	public void setIssuetype(String issuetype) {
		this.issuetype = issuetype;
	}
	public String getMGTKEY() {
		return MGTKEY;
	}
	public void setMGTKEY(String mGTKEY) {
		MGTKEY = mGTKEY;
	}
	public String getPre_deposit_an() {
		return pre_deposit_an;
	}
	public void setPre_deposit_an(String pre_deposit_an) {
		this.pre_deposit_an = pre_deposit_an;
	}
	public String getTITLE() {
		return TITLE;
	}
	public void setTITLE(String tITLE) {
		TITLE = tITLE;
	}

    //넘어다니는 파라미터
    protected int curPage;
    protected String searchGb;
    protected String searchTxt;
    protected String IvStartDate;
    protected String IvEndDate;
	protected int nRow;				//리스트 데이터 총갯수(길이)
	protected int nPage;
    
    
    
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
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public String getPre_deposit_dt() {
		return pre_deposit_dt;
	}
	public void setPre_deposit_dt(String pre_deposit_dt) {
		this.pre_deposit_dt = pre_deposit_dt;
	}
	public String getProductno() {
		return productno;
	}
	public void setProductno(String productno) {
		this.productno = productno;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public String getMod_id() {
		return mod_id;
	}
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
	public String getBusiness() {
		return Business;
	}
	public void setBusiness(String business) {
		Business = business;
	}
	public String getB_item() {
		return B_item;
	}
	public void setB_item(String b_item) {
		B_item = b_item;
	}
	public String getAddress() {
		return Address;
	}
	public void setAddress(String address) {
		Address = address;
	}
	public String getAddr_detail() {
		return Addr_detail;
	}
	public void setAddr_detail(String addr_detail) {
		Addr_detail = addr_detail;
	}
	public String getPost() {
		return Post;
	}
	public void setPost(String post) {
		Post = post;
	}
	public String getDeposit_amt() {
		return deposit_amt;
	}
	public void setDeposit_amt(String deposit_amt) {
		this.deposit_amt = deposit_amt;
	}
	public String getOwner_nm() {
		return owner_nm;
	}
	public void setOwner_nm(String owner_nm) {
		this.owner_nm = owner_nm;
	}
	public String getT_estiamt() {
		return t_estiamt;
	}
	public void setT_estiamt(String t_estiamt) {
		this.t_estiamt = t_estiamt;
	}
	public String getT_deposiamt() {
		return t_deposiamt;
	}
	public void setT_deposiamt(String t_deposiamt) {
		this.t_deposiamt = t_deposiamt;
	}
	public String getInvoice_code() {
		return invoice_code;
	}
	public void setInvoice_code(String invoice_code) {
		this.invoice_code = invoice_code;
	}
	public String getPublic_no() {
		return public_no;
	}
	public void setPublic_no(String public_no) {
		this.public_no = public_no;
	}
	public String getGun() {
		return gun;
	}
	public void setGun(String gun) {
		this.gun = gun;
	}
	public String getHo() {
		return ho;
	}
	public void setHo(String ho) {
		this.ho = ho;
	}
	public String getManage_no() {
		return manage_no;
	}
	public void setManage_no(String manage_no) {
		this.manage_no = manage_no;
	}
	public String getApprove_no() {
		return approve_no;
	}
	public void setApprove_no(String approve_no) {
		this.approve_no = approve_no;
	}
	public String getInvoice_gb() {
		return invoice_gb;
	}
	public void setInvoice_gb(String invoice_gb) {
		this.invoice_gb = invoice_gb;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getPublic_dt() {
		return public_dt;
	}
	public void setPublic_dt(String public_dt) {
		this.public_dt = public_dt;
	}
	public String getPublic_org() {
		return public_org;
	}
	public void setPublic_org(String public_org) {
		this.public_org = public_org;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getComp_code() {
		return comp_code;
	}
	public void setComp_code(String comp_code) {
		this.comp_code = comp_code;
	}
	
	public String getComp_nm() {
		return comp_nm;
	}
	public void setComp_nm(String comp_nm) {
		this.comp_nm = comp_nm;
	}
	public String getSupply_price() {
		return supply_price;
	}
	public void setSupply_price(String supply_price) {
		this.supply_price = supply_price;
	}
	public String getVat() {
		return vat;
	}
	public void setVat(String vat) {
		this.vat = vat;
	}
	public String getDeposit_dt() {
		return deposit_dt;
	}
	public void setDeposit_dt(String deposit_dt) {
		this.deposit_dt = deposit_dt;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getReference() {
		return reference;
	}
	public void setReference(String reference) {
		this.reference = reference;
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
	public long getSupply_price_i() {
		return supply_price_i;
	}
	public void setSupply_price_i(long supply_price_i) {
		this.supply_price_i = supply_price_i;
	}
	public long getVat_i() {
		return vat_i;
	}
	public void setVat_i(long vat_i) {
		this.vat_i = vat_i;
	}
	public String getPermit_no() {
		return permit_no;
	}
	public void setPermit_no(String permit_no) {
		this.permit_no = permit_no;
	}
	public String getIvStartDate() {
		return IvStartDate;
	}
	public void setIvStartDate(String ivStartDate) {
		IvStartDate = ivStartDate;
	}
	public String getIvEndDate() {
		return IvEndDate;
	}
	public void setIvEndDate(String ivEndDate) {
		IvEndDate = ivEndDate;
	}
	public String getTotalAmt() {
		return totalAmt;
	}
	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}
	public long getTotalAmt_i() {
		return totalAmt_i;
	}
	public void setTotalAmt_i(long totalAmt_i) {
		this.totalAmt_i = totalAmt_i;
	}
	
	
}
