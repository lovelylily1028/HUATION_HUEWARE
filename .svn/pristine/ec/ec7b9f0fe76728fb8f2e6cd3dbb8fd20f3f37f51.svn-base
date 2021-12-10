package com.huation.common.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.huation.common.util.CommonUtil;
import com.huation.framework.Constants;
import com.huation.framework.util.StringUtil;

public class UserBroker implements Constants {
    private static UserBroker userBrokerins = null;
    /**
     *   
     */
    public UserBroker() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public static UserBroker getInstance(){  
	    if(userBrokerins == null) {
	        userBrokerins = new UserBroker();
	     }
	
	     return userBrokerins;
    }

    /**
     * 사용자 캐쉬 정보를 가져온다.
     * @param req
     * @return
     */
    public static final UserMemDTO getUserInfo(HttpServletRequest req){
		UserMemDTO user = null;
        HttpSession session = req.getSession();
        user = (UserMemDTO)session.getAttribute("USERINFO");
		
		return user;
    }
    
    /**
     * req를 해석해서 현재 로그인한 고객 UserId를 반환한다.
     * 
     * @return 로그인한 고객 UserId, 로그인 하지 않았다면 null을 반환
     */
    public static final String getUserId(HttpServletRequest req) {
        HttpSession session = req.getSession();
        String userId = (String)session.getAttribute(LOGIN_USERID);
        
        if(userId == null) return "";         
                
        return StringUtil.nvl(userId);
    }

    /**
     * 사용자 구분을 가져온다.
     * @param systemcode
     * @param userid
     * @param usertype
     */
    public static final String getUserGb(HttpServletRequest req){
    	String userType = "";
        HttpSession session = req.getSession();
        userType = (String)session.getAttribute(LOGIN_USERGUBUN);
 
        return StringUtil.nvl(userType);
    }
    
    /**
     * 사용자 이름을 가져온다.
     * @param req
     * @return
     */
    public static final String getUserNm(HttpServletRequest req){
    	String userName = "";
        HttpSession session = req.getSession();
        userName = (String)session.getAttribute(LOGIN_USERNAME);
 
        return StringUtil.nvl(userName);
    }    

    /**
     * Email을 가져온다.
     * @param req
     * @return
     */
    public static final String getEmail(HttpServletRequest req){
    	String email = "";
        HttpSession session = req.getSession();
        email = (String)session.getAttribute("EMAIL");

        return StringUtil.nvl(email);
    }
    
//    /**
//     * 등급을 가져온다.
//     * @param req
//     * @return
//     */
//    public static final String getUserGrade(HttpServletRequest req){
//    	String userGrade = "";
//        HttpSession session = req.getSession();
//        userGrade = (String)session.getAttribute("USER_GRADE");
// 
//        return StringUtil.nvl(userGrade);
//    }    
//
//    /**
//     * 나이를 가져온다.
//     * @param req
//     * @return
//     */
//    public static final String getUserAge(HttpServletRequest req){
//    	String userAge = "";
//        HttpSession session = req.getSession();
//        userAge = (String)session.getAttribute("USER_AGE");
// 
//        return StringUtil.nvl(userAge);
//    } 
//
//    /**
//     * 결제가능여부를 가져온다.
//     * @param req
//     * @return
//     */
//    public static final String getPayAgreeYn(HttpServletRequest req){
//    	String payAgreeYn = "";
//        HttpSession session = req.getSession();
//        payAgreeYn = (String)session.getAttribute("PAY_AGREE_YN");
// 
//        return StringUtil.nvl(payAgreeYn);
//    }
}
