package com.huation.common;

/**
 * T_POSTCODE 테이블 Dto 클래스.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * . . .        Initial Release
 ************************************************
 *
 * @author       
 * @version     1.0
 * @since       
 */
public class PostCodeDTO {

    protected int postId;
    protected String postCode;
    protected String sido;
    protected String gugun;
    protected String dong;
    protected String ri;
    protected String bunji;
    protected String addr;
    protected String fullAddr;
    
    //Sp 공통 사용
    
    protected String ChUserID; 		//로그인 세션아이디
    protected String vSearchType; 	//검색구분
    protected String vSearch; 		//검색명

    public String getChUserID() {
		return ChUserID;
	}

	public void setChUserID(String chUserID) {
		ChUserID = chUserID;
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

	/**
     * get postId.
     *
     * @return      postId
     */
    public int getPostId() {
        return  this.postId;
    }

    /**
     * set postId.
     *
     * @param       postId
     */
    public void setPostId(int postId) {
        this.postId = postId;
    }

    /**
     * get postCode.
     *
     * @return      postCode
     */
    public String getPostCode() {
        return  this.postCode;
    }

    /**
     * set postCode.
     *
     * @param       postCode
     */
    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    /**
     * get sido.
     *
     * @return      sido
     */
    public String getSido() {
        return  this.sido;
    }

    /**
     * set sido.
     *
     * @param       sido
     */
    public void setSido(String sido) {
        this.sido = sido;
    }

    /**
     * get gugun.
     *
     * @return      gugun
     */
    public String getGugun() {
        return  this.gugun;
    }

    /**
     * set gugun.
     *
     * @param       gugun
     */
    public void setGugun(String gugun) {
        this.gugun = gugun;
    }

    /**
     * get dong.
     *
     * @return      dong
     */
    public String getDong() {
        return  this.dong;
    }

    /**
     * set dong.
     *
     * @param       dong
     */
    public void setDong(String dong) {
        this.dong = dong;
    }

    /**
     * get ri.
     *
     * @return      ri
     */
    public String getRi() {
        return  this.ri;
    }

    /**
     * set ri.
     *
     * @param       ri
     */
    public void setRi(String ri) {
        this.ri = ri;
    }

    /**
     * get bunji.
     *
     * @return      bunji
     */
    public String getBunji() {
        return  this.bunji;
    }

    /**
     * set bunji.
     *
     * @param       bunji
     */
    public void setBunji(String bunji) {
        this.bunji = bunji;
    }

	/**
	 * @return Returns the addr.
	 */
	public String getAddr() {
		return addr;
	}
	/**
	 * @param addr The addr to set.
	 */
	public void setAddr(String addr) {
		this.addr = addr;
	}
	/**
	 * @return Returns the fullAddr.
	 */
	public String getFullAddr() {
		return fullAddr;
	}
	/**
	 * @param fullAddr The fullAddr to set.
	 */
	public void setFullAddr(String fullAddr) {
		this.fullAddr = fullAddr;
	}
    
    
    /**
     * toString 
     *
     * @return  String 
     */
    public String toString() {
        return  "postId="+postId+",postCode="+postCode+",sido="+sido+",gugun="+gugun+",dong="+dong
               +",ri="+ri+",bunji="+bunji;
    }

    }
