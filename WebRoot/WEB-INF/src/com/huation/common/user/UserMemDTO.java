package com.huation.common.user;

import java.io.Serializable;

public class UserMemDTO implements Serializable{
    protected String userId;
    protected String passwd;
    protected String userNm;
    protected String email;
    protected String phone;
    protected String faxno;
    protected String groupid;
    protected String groupnm;
    protected String authid;
    protected String position;
    
    
    
    public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	protected int loginseq;
        
    public int getLoginseq() {
		return loginseq;
	}
	public void setLoginseq(int loginseq) {
		this.loginseq = loginseq;
	}
	public String getFaxno() {
		return faxno;
	}
	public void setFaxno(String faxno) {
		this.faxno = faxno;
	}
	public String getGroupid() {
		return groupid;
	}
	public void setGroupid(String groupid) {
		this.groupid = groupid;
	}
	public String getAuthid() {
		return authid;
	}
	public void setAuthid(String authid) {
		this.authid = authid;
	}
	/**
	 * @return Returns the email.
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email The email to set.
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return Returns the userId.
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId The userId to set.
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return Returns the userNm.
	 */
	public String getUserNm() {
		return userNm;
	}
	/**
	 * @param userNm The userNm to set.
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	/**
	 * @return Returns the userNm.
	 */
	public String getPhone() {
		return phone;
	}
	/**
	 * @param userNm The userNm to set.
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getGroupnm() {
		return groupnm;
	}
	public void setGroupnm(String groupnm) {
		this.groupnm = groupnm;
	}
	
	
}
