package com.huation.common;

/**
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class ComCodeDTO {
	 String code="";
	 String code2="";
	 String name="";
	 String name2="";
	 String UserID = "";
	 String UserName = "";
	 
	public String getUserID() {
		return UserID;
	}

	public void setUserID(String userID) {
		UserID = userID;
	}

	public String getUserName() {
		return UserName;
	}

	public void setUserName(String userName) {
		UserName = userName;
	}
	 
	 public String getCode2() {
		return code2;
	}

	public void setCode2(String code2) {
		this.code2 = code2;
	}
	 
	 public String getName2() {
		return name2;
	}

	public void setName2(String name2) {
		this.name2 = name2;
	}

	/**
	 * 
	 */
	public ComCodeDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @return Returns the code.
	 */
	public String getCode() {
		return code;
	}
	/**
	 * @param code The code to set.
	 */
	public void setCode(String code) {
		this.code = code;
	}
	/**
	 * @return Returns the codeName.
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param codeName The codeName to set.
	 */
	public void setName(String codeName) {
		this.name = codeName;
	}
}
