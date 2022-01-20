package com.baroservice.ws;

public class BaroService_CORPSTATESoapProxy implements com.baroservice.ws.BaroService_CORPSTATESoap {
  private String _endpoint = null;
  private com.baroservice.ws.BaroService_CORPSTATESoap baroService_CORPSTATESoap = null;
  
  public BaroService_CORPSTATESoapProxy() {
    _initBaroService_CORPSTATESoapProxy();
  }
  
  public BaroService_CORPSTATESoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initBaroService_CORPSTATESoapProxy();
  }
  
  private void _initBaroService_CORPSTATESoapProxy() {
    try {
      baroService_CORPSTATESoap = (new com.baroservice.ws.BaroService_CORPSTATELocator()).getBaroService_CORPSTATESoap();
      if (baroService_CORPSTATESoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)baroService_CORPSTATESoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)baroService_CORPSTATESoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (baroService_CORPSTATESoap != null)
      ((javax.xml.rpc.Stub)baroService_CORPSTATESoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.baroservice.ws.BaroService_CORPSTATESoap getBaroService_CORPSTATESoap() {
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap;
  }
  
  public com.baroservice.ws.CorpState getCorpState(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String checkCorpNum) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getCorpState(CERTKEY, corpNum, checkCorpNum);
  }
  
  public com.baroservice.ws.CorpState[] getCorpStates(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String[] checkCorpNumList) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getCorpStates(CERTKEY, corpNum, checkCorpNumList);
  }
  
  public java.lang.String getCorpStateScrapRequestURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getCorpStateScrapRequestURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public int checkCorpIsMember(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String checkCorpNum) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.checkCorpIsMember(CERTKEY, corpNum, checkCorpNum);
  }
  
  public int registCorp(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String corpName, java.lang.String CEOName, java.lang.String bizType, java.lang.String bizClass, java.lang.String postNum, java.lang.String addr1, java.lang.String addr2, java.lang.String memberName, java.lang.String juminNum, java.lang.String ID, java.lang.String PWD, java.lang.String grade, java.lang.String TEL, java.lang.String HP, java.lang.String email) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.registCorp(CERTKEY, corpNum, corpName, CEOName, bizType, bizClass, postNum, addr1, addr2, memberName, juminNum, ID, PWD, grade, TEL, HP, email);
  }
  
  public int addUserToCorp(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String memberName, java.lang.String juminNum, java.lang.String ID, java.lang.String PWD, java.lang.String grade, java.lang.String TEL, java.lang.String HP, java.lang.String email) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.addUserToCorp(CERTKEY, corpNum, memberName, juminNum, ID, PWD, grade, TEL, HP, email);
  }
  
  public int updateCorpInfo(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String corpName, java.lang.String CEOName, java.lang.String bizType, java.lang.String bizClass, java.lang.String postNum, java.lang.String addr1, java.lang.String addr2) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.updateCorpInfo(CERTKEY, corpNum, corpName, CEOName, bizType, bizClass, postNum, addr1, addr2);
  }
  
  public int updateUserInfo(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String memberName, java.lang.String juminNum, java.lang.String TEL, java.lang.String HP, java.lang.String email, java.lang.String grade) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.updateUserInfo(CERTKEY, corpNum, ID, memberName, juminNum, TEL, HP, email, grade);
  }
  
  public int updateUserPWD(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String newPWD) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.updateUserPWD(CERTKEY, corpNum, ID, newPWD);
  }
  
  public int changeCorpManager(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String newManagerID) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.changeCorpManager(CERTKEY, corpNum, newManagerID);
  }
  
  public com.baroservice.ws.Contact[] getCorpMemberContacts(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String checkCorpNum) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getCorpMemberContacts(CERTKEY, corpNum, checkCorpNum);
  }
  
  public long getBalanceCostAmount(java.lang.String CERTKEY, java.lang.String corpNum) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getBalanceCostAmount(CERTKEY, corpNum);
  }
  
  public long getBalanceCostAmountOfInterOP(java.lang.String CERTKEY) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getBalanceCostAmountOfInterOP(CERTKEY);
  }
  
  public int checkChargeable(java.lang.String CERTKEY, java.lang.String corpNum, int CType, int docType) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.checkChargeable(CERTKEY, corpNum, CType, docType);
  }
  
  public int getChargeUnitCost(java.lang.String CERTKEY, java.lang.String corpNum, int chargeCode) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getChargeUnitCost(CERTKEY, corpNum, chargeCode);
  }
  
  public java.lang.String getCertificateRegistDate(java.lang.String CERTKEY, java.lang.String corpNum) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getCertificateRegistDate(CERTKEY, corpNum);
  }
  
  public java.lang.String getCertificateExpireDate(java.lang.String CERTKEY, java.lang.String corpNum) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getCertificateExpireDate(CERTKEY, corpNum);
  }
  
  public int checkCERTIsValid(java.lang.String CERTKEY, java.lang.String corpNum) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.checkCERTIsValid(CERTKEY, corpNum);
  }
  
  public java.lang.String getCertificateRegistURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getCertificateRegistURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public java.lang.String getBaroBillURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD, java.lang.String TOGO) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getBaroBillURL(CERTKEY, corpNum, ID, PWD, TOGO);
  }
  
  public java.lang.String getLoginURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getLoginURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public java.lang.String getCashChargeURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getCashChargeURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public int registSMSFromNumber(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String fromNumber) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.registSMSFromNumber(CERTKEY, corpNum, fromNumber);
  }
  
  public int checkSMSFromNumber(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String fromNumber) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.checkSMSFromNumber(CERTKEY, corpNum, fromNumber);
  }
  
  public com.baroservice.ws.FromNumber[] getSMSFromNumbers(java.lang.String CERTKEY, java.lang.String corpNum) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getSMSFromNumbers(CERTKEY, corpNum);
  }
  
  public java.lang.String getSMSFromNumberURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getSMSFromNumberURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public int checkFaxFromNumber(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String fromNumber) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.checkFaxFromNumber(CERTKEY, corpNum, fromNumber);
  }
  
  public com.baroservice.ws.FromNumber[] getFaxFromNumbers(java.lang.String CERTKEY, java.lang.String corpNum) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getFaxFromNumbers(CERTKEY, corpNum);
  }
  
  public java.lang.String getFaxFromNumberURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getFaxFromNumberURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public java.lang.String getErrString(java.lang.String CERTKEY, int errCode) throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    return baroService_CORPSTATESoap.getErrString(CERTKEY, errCode);
  }
  
  public void ping() throws java.rmi.RemoteException{
    if (baroService_CORPSTATESoap == null)
      _initBaroService_CORPSTATESoapProxy();
    baroService_CORPSTATESoap.ping();
  }
  
  
}