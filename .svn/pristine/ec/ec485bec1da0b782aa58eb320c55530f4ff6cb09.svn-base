/**
 * BaroService_SMSSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.baroservice.ws;

public interface BaroService_SMSSoap extends java.rmi.Remote {

    /**
     * SMS 전송 API
     */
    public java.lang.String sendSMSMessage(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String senderID, java.lang.String fromNumber, java.lang.String toName, java.lang.String toNumber, java.lang.String contents, java.lang.String sendDT, java.lang.String refKey) throws java.rmi.RemoteException;

    /**
     * SMS/LMS 전송 API
     */
    public java.lang.String sendMessage(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String senderID, java.lang.String fromNumber, java.lang.String toName, java.lang.String toNumber, java.lang.String contents, java.lang.String sendDT, java.lang.String refKey) throws java.rmi.RemoteException;

    /**
     * SMS/LMS 대량전송 API
     */
    public java.lang.String sendMessages(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String senderID, int sendCount, boolean cutToSMS, com.baroservice.ws.XMSMessage[] messages, java.lang.String sendDT) throws java.rmi.RemoteException;

    /**
     * LMS 전송 API
     */
    public java.lang.String sendLMSMessage(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String senderID, java.lang.String fromNumber, java.lang.String toName, java.lang.String toNumber, java.lang.String subject, java.lang.String contents, java.lang.String sendDT, java.lang.String refKey) throws java.rmi.RemoteException;

    /**
     * MMS 전송 API
     */
    public java.lang.String sendMMSMessage(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String senderID, java.lang.String fromNumber, java.lang.String toName, java.lang.String toNumber, java.lang.String TXTSubject, java.lang.String TXTMESSAGE, byte[] imageFile, java.lang.String sendDT, java.lang.String refKey) throws java.rmi.RemoteException;

    /**
     * MMS 전송 API from FTP
     */
    public java.lang.String sendMMSMessageFromFTP(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String senderID, java.lang.String fromNumber, java.lang.String toName, java.lang.String toNumber, java.lang.String TXTSubject, java.lang.String TXTMESSAGE, java.lang.String imageFileName, java.lang.String sendDT, java.lang.String refKey) throws java.rmi.RemoteException;

    /**
     * 예약 전송 문자 발송 취소
     */
    public int cancelReservedSMSMessage(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String sendKey) throws java.rmi.RemoteException;

    /**
     * 대량전송 접수번호로 관련 전송건들을 확인
     */
    public com.baroservice.ws.SMSMessage[] getMessagesByReceiptNum(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String receiptNum) throws java.rmi.RemoteException;

    /**
     * SMS 전송 상태확인
     */
    public int getSMSSendState(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String sendKey) throws java.rmi.RemoteException;

    /**
     * SMS 전송 메시지 확인
     */
    public com.baroservice.ws.SMSMessage getSMSSendMessage(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String sendKey) throws java.rmi.RemoteException;

    /**
     * SMS 전송 메시지 대량확인(100건까지)
     */
    public com.baroservice.ws.SMSMessage[] getSMSSendMessages(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String[] sendKeyList) throws java.rmi.RemoteException;

    /**
     * 참조키에 의한 관련 메시지 확인
     */
    public com.baroservice.ws.SMSMessage[] getSMSSendMessagesByRefKey(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String refKey) throws java.rmi.RemoteException;

    /**
     * 페이징에 의한 관련 메시지 확인
     */
    public com.baroservice.ws.PagedSMSMessages getSMSSendMessagesByPaging(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String fromDate, java.lang.String toDate, int countPerPage, int currentPage) throws java.rmi.RemoteException;

    /**
     * SMS 전송내역 조회 URL
     */
    public java.lang.String getSMSHistoryURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException;

    /**
     * Ping~ Pong
     */
    public void ping() throws java.rmi.RemoteException;

    /**
     * 바로빌회원사 여부 확인
     */
    public int checkCorpIsMember(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String checkCorpNum) throws java.rmi.RemoteException;

    /**
     * 바로빌회원사의 담당자 목록확인
     */
    public com.baroservice.ws.Contact[] getCorpMemberContacts(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String checkCorpNum) throws java.rmi.RemoteException;

    /**
     * 과금가능 여부 확인[과금관련]
     */
    public int checkChargeable(java.lang.String CERTKEY, java.lang.String corpNum, int CType, int docType) throws java.rmi.RemoteException;

    /**
     * 충전잔액 확인
     */
    public long getBalanceCostAmount(java.lang.String CERTKEY, java.lang.String corpNum) throws java.rmi.RemoteException;

    /**
     * 연동사 충전잔액 확인
     */
    public long getBalanceCostAmountOfInterOP(java.lang.String CERTKEY) throws java.rmi.RemoteException;

    /**
     * SSO지원을 위한 로그인 URL 확인
     */
    public java.lang.String getLoginURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException;

    /**
     * 회원사가입 API
     */
    public int registCorp(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String corpName, java.lang.String CEOName, java.lang.String bizType, java.lang.String bizClass, java.lang.String postNum, java.lang.String addr1, java.lang.String addr2, java.lang.String memberName, java.lang.String juminNum, java.lang.String ID, java.lang.String PWD, java.lang.String grade, java.lang.String TEL, java.lang.String HP, java.lang.String email) throws java.rmi.RemoteException;

    /**
     * 회원사에 사용자 추가
     */
    public int addUserToCorp(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String memberName, java.lang.String juminNum, java.lang.String ID, java.lang.String PWD, java.lang.String grade, java.lang.String TEL, java.lang.String HP, java.lang.String email) throws java.rmi.RemoteException;

    /**
     * 회원사 정보 수정
     */
    public int updateCorpInfo(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String corpName, java.lang.String CEOName, java.lang.String bizType, java.lang.String bizClass, java.lang.String postNum, java.lang.String addr1, java.lang.String addr2) throws java.rmi.RemoteException;

    /**
     * 회원사용자 정보 수정
     */
    public int updateUserInfo(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String memberName, java.lang.String juminNum, java.lang.String TEL, java.lang.String HP, java.lang.String email, java.lang.String grade) throws java.rmi.RemoteException;

    /**
     * 회원사용자 암호 변경
     */
    public int updateUserPWD(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String newPWD) throws java.rmi.RemoteException;

    /**
     * 회원사 관리자 변경
     */
    public int changeCorpManager(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String newManagerID) throws java.rmi.RemoteException;

    /**
     * 오류코드의 상세설명문자열을 반환.
     */
    public java.lang.String getErrString(java.lang.String CERTKEY, int errCode) throws java.rmi.RemoteException;

    /**
     * 발행단가 확인
     */
    public int getChargeUnitCost(java.lang.String CERTKEY, java.lang.String corpNum, int chargeCode) throws java.rmi.RemoteException;

    /**
     * 정액충전 URL 확인
     */
    public java.lang.String getCashChargeURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException;
}
