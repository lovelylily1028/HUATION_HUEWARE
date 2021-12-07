package com.huation.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;

import com.huation.common.CodeParam;
import com.huation.common.ComCodeDTO;
import com.huation.common.CommonDAO;
import com.huation.common.code.CodeDAO;
import com.huation.common.code.CodeDTO;
import com.huation.framework.configuration.Configuration;
import com.huation.framework.configuration.ConfigurationFactory;
import com.huation.framework.util.DateTimeUtil;
import com.huation.framework.util.MailUtil;
import com.huation.framework.util.StringUtil;

/*********************************************************
 * 프로그램 : CommonUtil.java
 * 모 듈 명  : 프로젝트내에서 사용하는 공통 유틸 정의 
 * 설    명   : 
 * 테 이 블  :
 * 작 성 자  : 
 * 작 성 일  : 
 * 수 정 일  :
 * 수정사항 : 
 *********************************************************/
public class CommonUtil {
    private static Configuration config = ConfigurationFactory.getInstance().getConfiguration();
	private static final boolean mon_ture = false;
    public static final String SERVERTYPE = config.getString("framework.system.server_type");
    public static final String SERVERURL = config.getString("framework.system.server_url");
    public static final String DATAURL = config.getString("framework.fileupload.datadir");
    public static final String FILESURL = config.getString("framework.fileupload.filedir");
    public static final String COMMUNITYURL = config.getString("framework.fileupload.communitydir");
    public static final String XMLENCODING = config.getString("framework.xml.encoding");
    public static final String SMSURL = config.getString("framework.sms.url");
	public static final boolean DB_MONITOR = mon_ture;
    public static String LOGIN_MSG = "로그인 정보가 없습니다. 로그인하시기 바랍니다.";
    public static String ERROR_URL = "/jsp/hueware/common/error.jsp";
    public static String LOGIN_FORM_FORWARD = "/B_Login.do?cmd=loginForm";
    
    private static CommonUtil commonUtilIns = null;

    /** 
     * 
     */
    public CommonUtil() {
        super();
        // TODO Auto-generated constructor stub
    }

    public static CommonUtil getInstance(){  
	    if(commonUtilIns == null) {
	        commonUtilIns = new CommonUtil();
	     }
	
	     return commonUtilIns;
    }
    
    /**
     *  DB현재 날짜를 가져온다.
     * @return
     */
    public static String getCurrentDate(){
        String curDate = "";
        CommonDAO cd = new CommonDAO();
        try{
        	curDate = cd.getCurrentDate();
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return curDate;
    }

    /**
     * 달력 입력 창을 생성해 준다.
     * @param param
     * @param dateobj
     * @return
     */
    public static String getCalendar(DateParam param, DateSetter dateobj){
	    StringBuffer out = new StringBuffer();
	    String curyear1= "", curmonth1="",curyear2= "", curmonth2="";
	    String strReadonly = " readonly ";
    	if (dateobj.getYear1().equals("")){
    		curyear1=DateTimeUtil.getYear(); 
		}else{
			curyear1=dateobj.getYear1(); 
		}
	    if (dateobj.getMonth1().equals("")){
            curmonth1=DateTimeUtil.getMonth(); 
		}else{
			curmonth1=dateobj.getMonth1(); 
		}
	    
	    if(param.getReadonly().equals("false"))
	    	strReadonly = "";
		out.append("<input type=text class='in_txt' name=\""+param.getYear()+"1\" size=4 maxlength=4 value=\""+dateobj.getYear1()+"\" "+strReadonly+" >년 "); //2012.11.30(목)bsh. maxlength추가
		if (param.getDateType() < 3){
			out.append("<input type=text class='in_txt' name=\""+param.getMonth()+"1\" size=2  maxlength=2 value=\""+dateobj.getMonth1()+"\" "+strReadonly+">월 "); //2012.11.30(목)bsh. maxlength추가
		}else{
		    out.append("<input type=hidden name=\""+param.getMonth()+"1\" size=2  value=\""+dateobj.getMonth1()+"\" "+strReadonly+">");
		}
		if (param.getDateType() < 2){
			out.append("<input type=text class='in_txt' name=\""+param.getDay()+"1\" size=2 maxlength=2 value=\""+dateobj.getDay1()+"\" "+strReadonly+">일");  //2012.11.30(목)bsh. maxlength추가
		}else{
			out.append("<input type=hidden name=\""+param.getDay()+"1\" size=2 value=\""+dateobj.getDay1()+"\" "+strReadonly+">");
		}	
	    if (param.getDateType() < 1){
	    	out.append("<input type=text class='in_txt' name=\""+param.getHour()+"1\" size=2 value=\""+dateobj.getHour1()+"\">시");
	    	out.append("<input type=text class='in_txt' name=\""+param.getMinute()+"1\" size=2 value=\""+dateobj.getMin1()+"\">분"); 
	    }else{
	    	out.append("<input type=hidden name=\""+param.getHour()+"1\" size=2 value=\""+dateobj.getHour1()+"\">"); 
	    	out.append("<input type=hidden name=\""+param.getMinute()+"1\" size=2 value=\""+dateobj.getMin1()+"\">");
	    }	
		out.append("<input type=hidden name=\""+param.getDate()+"1\" value=\""+dateobj.getYear1()+dateobj.getMonth1()+dateobj.getDay1()+dateobj.getHour1()+dateobj.getMin1()+dateobj.getSec1()+"\">");
	    out.append("<input type=hidden name=\""+param.getDate()+"2\" value=\""+dateobj.getYear2()+dateobj.getMonth2()+dateobj.getDay2()+dateobj.getHour2()+dateobj.getMin2()+dateobj.getSec2()+"\">");
	    //out.append("[<a href=\"javascript:date_select('"+param.getForm()+"','"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"',"+curyear1+","+curmonth1+",'"+param.getDate()+"','1');\">달력</a>] \n");
	   		out.append("<input type=button value='달력' class=\"input_button_red\" onClick=\"new CalendarFrame.Calendar(this,'"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"','"+param.getDate()+"','1',"+param.getPosX()+","+param.getPosY()+"); \">");
	    
		if (param.getCount() > 1){
			out.append(" ~ ");
		    if(dateobj.getYear2().equals("")){ 
		    	curyear2=DateTimeUtil.getYear(); 
		    }else{
		    	curyear2=dateobj.getYear2(); 
		    }
		    if (dateobj.getMonth2().equals("")){ 
		    	curmonth2=DateTimeUtil.getMonth(); 
		    }else{
		    	curmonth2=dateobj.getMonth2(); 
		    }
			out.append("<input type=text class='in_txt' name=\""+param.getYear()+"2\" size=4 value=\""+dateobj.getYear2()+"\" "+strReadonly+">년");
			if (param.getDateType() < 3){
			     out.append("<input type=text class='in_txt' name=\""+param.getMonth()+"2\" size=2 value=\""+dateobj.getMonth2()+"\" "+strReadonly+">월");
			}else{
			    out.append("<input type=hidden name=\""+param.getMonth()+"2\" size=2 value=\""+dateobj.getMonth2()+"\" "+strReadonly+">");
			}
			if (param.getDateType() < 2){
				out.append("<input type=text class='in_txt' name=\""+param.getDay()+"2\" size=2 value=\""+dateobj.getDay2()+"\" "+strReadonly+">일 "); 
			}else{
				out.append("<input type=hidden name=\""+param.getDay()+"2\" size=2 value=\""+dateobj.getDay2()+"\" "+strReadonly+">");
			}	
		    if (param.getDateType() < 1){
		    	out.append("<input type=text class='in_txt' name=\""+param.getHour()+"2\" size=2 value=\""+dateobj.getHour2()+"\">시 ");
		    	out.append("<input type=text class='in_txt' name=\""+param.getMinute()+"2\" size=2 value=\""+dateobj.getMin2()+"\">분 "); 
		    }else{
		    	out.append("<input type=hidden name=\""+param.getHour()+"2\" size=2 value=\""+dateobj.getHour2()+"\">"); 
		    	out.append("<input type=hidden name=\""+param.getMinute()+"2\" size=2 value=\""+dateobj.getMin2()+"\">");
		    }
		    out.append("<input type=button value='달력'  class=\"input_button_red\" onClick=\"new CalendarFrame.Calendar(this,'"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"','"+param.getDate()+"','2',"+param.getPosX()+","+param.getPosY()+")\">");
		    //out.append("[<a href=\"javascript:date_select('"+param.getForm()+"','"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"',"+curyear2+","+curmonth2+",'"+param.getDate()+"','2');\">달력</a>] \n");
		}			
		
		return out.toString();
    }
    
    /**
     * 달력 입력 창을 생성해 준다. (별도 두번째 달력)
     * @param param
     * @param dateobj
     * @return
     */
    public static String getCalendar2(DateParam param, DateSetter dateobj){
	    StringBuffer out = new StringBuffer();
	    String curyear1= "", curmonth1="",curyear2= "", curmonth2="";
	    String strReadonly = " readonly ";
    	if (dateobj.getYear3().equals("")){
    		curyear1=DateTimeUtil.getYear(); 
		}else{
			curyear1=dateobj.getYear3(); 
		}
	    if (dateobj.getMonth3().equals("")){
            curmonth1=DateTimeUtil.getMonth(); 
		}else{
			curmonth1=dateobj.getMonth3(); 
		}
	    
	    if(param.getReadonly().equals("false"))
	    	strReadonly = "";
		out.append("<input type=text class='in_txt' name=\""+param.getYear()+"3\" size=4 maxlength=4  value=\""+dateobj.getYear3()+"\" "+strReadonly+">년 ");
		if (param.getDateType() < 3){
			out.append("<input type=text class='in_txt' name=\""+param.getMonth()+"3\" size=2 maxlength=2  value=\""+dateobj.getMonth3()+"\" "+strReadonly+">월 ");
		}else{
		    out.append("<input type=hidden name=\""+param.getMonth()+"3\" size=2 value=\""+dateobj.getMonth3()+"\" "+strReadonly+">");
		}
		if (param.getDateType() < 2){
			out.append("<input type=text class='in_txt' name=\""+param.getDay()+"3\" size=2 maxlength=2  value=\""+dateobj.getDay3()+"\" "+strReadonly+">일"); 
		}else{
			out.append("<input type=hidden name=\""+param.getDay()+"3\" size=2 value=\""+dateobj.getDay3()+"\" "+strReadonly+">");
		}	
	    if (param.getDateType() < 1){
	    	out.append("<input type=text class='in_txt' name=\""+param.getHour()+"3\" size=2 value=\""+dateobj.getHour3()+"\">시");
	    	out.append("<input type=text class='in_txt' name=\""+param.getMinute()+"3\" size=2 value=\""+dateobj.getMin3()+"\">분"); 
	    }else{
	    	out.append("<input type=hidden name=\""+param.getHour()+"3\" size=2 value=\""+dateobj.getHour3()+"\">"); 
	    	out.append("<input type=hidden name=\""+param.getMinute()+"3\" size=2 value=\""+dateobj.getMin3()+"\">");
	    }	
		out.append("<input type=hidden name=\""+param.getDate()+"3\" value=\""+dateobj.getYear3()+dateobj.getMonth3()+dateobj.getDay3()+dateobj.getHour3()+dateobj.getMin3()+dateobj.getSec3()+"\">");
	    out.append("<input type=hidden name=\""+param.getDate()+"4\" value=\""+dateobj.getYear4()+dateobj.getMonth4()+dateobj.getDay4()+dateobj.getHour4()+dateobj.getMin4()+dateobj.getSec4()+"\">");
	    //out.append("[<a href=\"javascript:date_select('"+param.getForm()+"','"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"',"+curyear1+","+curmonth1+",'"+param.getDate()+"','1');\">달력</a>] \n");
	    	out.append("<input type=button value='달력' class=\"input_button_red\" onClick=\"new CalendarFrame.Calendar(this,'"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"','"+param.getDate()+"','3',"+param.getPosX()+","+param.getPosY()+"); \">");
	    
		if (param.getCount() > 1){
			out.append(" ~ ");
		    if(dateobj.getYear4().equals("")){ 
		    	curyear2=DateTimeUtil.getYear(); 
		    }else{
		    	curyear2=dateobj.getYear4(); 
		    }
		    if (dateobj.getMonth4().equals("")){ 
		    	curmonth2=DateTimeUtil.getMonth(); 
		    }else{
		    	curmonth2=dateobj.getMonth4(); 
		    }
			out.append("<input type=text class='in_txt' name=\""+param.getYear()+"4\" size=4 value=\""+dateobj.getYear4()+"\" "+strReadonly+">년");
			if (param.getDateType() < 3){
			     out.append("<input type=text class='in_txt' name=\""+param.getMonth()+"4\" size=2 value=\""+dateobj.getMonth4()+"\" "+strReadonly+">월");
			}else{
			    out.append("<input type=hidden name=\""+param.getMonth()+"4\" size=2 value=\""+dateobj.getMonth4()+"\" "+strReadonly+">");
			}
			if (param.getDateType() < 2){
				out.append("<input type=text class='in_txt' name=\""+param.getDay()+"4\" size=2 value=\""+dateobj.getDay4()+"\" "+strReadonly+">일 "); 
			}else{
				out.append("<input type=hidden name=\""+param.getDay()+"4\" size=2 value=\""+dateobj.getDay4()+"\" "+strReadonly+">");
			}	
		    if (param.getDateType() < 1){
		    	out.append("<input type=text class='in_txt' name=\""+param.getHour()+"4\" size=2 value=\""+dateobj.getHour4()+"\">시 ");
		    	out.append("<input type=text class='in_txt' name=\""+param.getMinute()+"4\" size=2 value=\""+dateobj.getMin4()+"\">분 "); 
		    }else{
		    	out.append("<input type=hidden name=\""+param.getHour()+"4\" size=2 value=\""+dateobj.getHour4()+"\">"); 
		    	out.append("<input type=hidden name=\""+param.getMinute()+"4\" size=2 value=\""+dateobj.getMin4()+"\">");
		    }
		    out.append("<input type=button value='달력'  class=\"input_button_red\" onClick=\"new CalendarFrame.Calendar(this,'"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"','"+param.getDate()+"','4',"+param.getPosX()+","+param.getPosY()+")\">");
		    //out.append("[<a href=\"javascript:date_select('"+param.getForm()+"','"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"',"+curyear2+","+curmonth2+",'"+param.getDate()+"','2');\">달력</a>] \n");
		}			
		
		return out.toString();
    }
    /**
     * 달력 입력 창을 생성해 준다. (별도 세번째 달력)
     * @param param
     * @param dateobj
     * @return
     */
    public static String getCalendar3(DateParam param, DateSetter dateobj){
	    StringBuffer out = new StringBuffer();
	    String curyear1= "", curmonth1="",curyear2= "", curmonth2="";
	    String strReadonly = " readonly ";
    	if (dateobj.getYear5().equals("")){
    		curyear1=DateTimeUtil.getYear(); 
		}else{
			curyear1=dateobj.getYear5(); 
		}
	    if (dateobj.getMonth5().equals("")){
            curmonth1=DateTimeUtil.getMonth(); 
		}else{
			curmonth1=dateobj.getMonth5(); 
		}
	    
	    if(param.getReadonly().equals("false"))
	    	strReadonly = "";
		out.append("<input type=text class='in_txt' name=\""+param.getYear()+"5\" size=4 maxlength=4 value=\""+dateobj.getYear5()+"\" "+strReadonly+">년 ");
		if (param.getDateType() < 3){
			out.append("<input type=text class='in_txt' name=\""+param.getMonth()+"5\" size=2 maxlength=2 value=\""+dateobj.getMonth5()+"\" "+strReadonly+">월 ");
		}else{
		    out.append("<input type=hidden name=\""+param.getMonth()+"5\" size=2 value=\""+dateobj.getMonth5()+"\" "+strReadonly+">");
		}
		if (param.getDateType() < 2){
			out.append("<input type=text class='in_txt' name=\""+param.getDay()+"5\" size=2 maxlength=2 value=\""+dateobj.getDay5()+"\" "+strReadonly+">일"); 
		}else{
			out.append("<input type=hidden name=\""+param.getDay()+"5\" size=2 value=\""+dateobj.getDay5()+"\" "+strReadonly+">");
		}	
	    if (param.getDateType() < 1){
	    	out.append("<input type=text class='in_txt' name=\""+param.getHour()+"5\" size=2 value=\""+dateobj.getHour5()+"\">시");
	    	out.append("<input type=text class='in_txt' name=\""+param.getMinute()+"5\" size=2 value=\""+dateobj.getMin5()+"\">분"); 
	    }else{
	    	out.append("<input type=hidden name=\""+param.getHour()+"5\" size=2 value=\""+dateobj.getHour5()+"\">"); 
	    	out.append("<input type=hidden name=\""+param.getMinute()+"5\" size=2 value=\""+dateobj.getMin5()+"\">");
	    }	
		out.append("<input type=hidden name=\""+param.getDate()+"5\" value=\""+dateobj.getYear3()+dateobj.getMonth5()+dateobj.getDay5()+dateobj.getHour5()+dateobj.getMin5()+dateobj.getSec5()+"\">");
	    out.append("<input type=hidden name=\""+param.getDate()+"6\" value=\""+dateobj.getYear4()+dateobj.getMonth6()+dateobj.getDay6()+dateobj.getHour6()+dateobj.getMin6()+dateobj.getSec6()+"\">");
	    //out.append("[<a href=\"javascript:date_select('"+param.getForm()+"','"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"',"+curyear1+","+curmonth1+",'"+param.getDate()+"','1');\">달력</a>] \n");
	    	out.append("<input type=button value='달력' class=\"input_button_red\" onClick=\"new CalendarFrame.Calendar(this,'"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"','"+param.getDate()+"','5',"+param.getPosX()+","+param.getPosY()+"); \">");
	    
		if (param.getCount() > 1){
			out.append(" ~ ");
		    if(dateobj.getYear4().equals("")){ 
		    	curyear2=DateTimeUtil.getYear(); 
		    }else{
		    	curyear2=dateobj.getYear4(); 
		    }
		    if (dateobj.getMonth4().equals("")){ 
		    	curmonth2=DateTimeUtil.getMonth(); 
		    }else{
		    	curmonth2=dateobj.getMonth4(); 
		    }
			out.append("<input type=text class='in_txt' name=\""+param.getYear()+"6\" size=4 value=\""+dateobj.getYear6()+"\" "+strReadonly+">년");
			if (param.getDateType() < 3){
			     out.append("<input type=text class='in_txt' name=\""+param.getMonth()+"6\" size=2 value=\""+dateobj.getMonth6()+"\" "+strReadonly+">월");
			}else{
			    out.append("<input type=hidden name=\""+param.getMonth()+"6\" size=2 value=\""+dateobj.getMonth6()+"\" "+strReadonly+">");
			}
			if (param.getDateType() < 2){
				out.append("<input type=text class='in_txt' name=\""+param.getDay()+"6\" size=2 value=\""+dateobj.getDay6()+"\" "+strReadonly+">일 "); 
			}else{
				out.append("<input type=hidden name=\""+param.getDay()+"6\" size=2 value=\""+dateobj.getDay6()+"\" "+strReadonly+">");
			}	
		    if (param.getDateType() < 1){
		    	out.append("<input type=text class='in_txt' name=\""+param.getHour()+"6\" size=2 value=\""+dateobj.getHour6()+"\">시 ");
		    	out.append("<input type=text class='in_txt' name=\""+param.getMinute()+"6\" size=2 value=\""+dateobj.getMin6()+"\">분 "); 
		    }else{
		    	out.append("<input type=hidden name=\""+param.getHour()+"6\" size=2 value=\""+dateobj.getHour6()+"\">"); 
		    	out.append("<input type=hidden name=\""+param.getMinute()+"6\" size=2 value=\""+dateobj.getMin6()+"\">");
		    }
		    out.append("<input type=button value='달력'  class=\"input_button_red\" onClick=\"new CalendarFrame.Calendar(this,'"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"','"+param.getDate()+"','6',"+param.getPosX()+","+param.getPosY()+")\">");
		    //out.append("[<a href=\"javascript:date_select('"+param.getForm()+"','"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"',"+curyear2+","+curmonth2+",'"+param.getDate()+"','2');\">달력</a>] \n");
		}			
		
		return out.toString();
    }
    /**
     * 달력 입력 창을 생성해 준다. (별도 네번째 달력)(달력 편집 불가용도)
     * @param param
     * @param dateobj
     * @return
     */
    public static String getCalendar4(DateParam param, DateSetter dateobj){
	    StringBuffer out = new StringBuffer();
	    String curyear1= "", curmonth1="",curyear2= "", curmonth2="";
	    String strReadonly = " readonly ";
    	if (dateobj.getYear7().equals("")){
    		curyear1=DateTimeUtil.getYear(); 
		}else{
			curyear1=dateobj.getYear7(); 
		}
	    if (dateobj.getMonth7().equals("")){
            curmonth1=DateTimeUtil.getMonth(); 
		}else{
			curmonth1=dateobj.getMonth7(); 
		}
	    
	    if(param.getReadonly().equals("false"))
	    	strReadonly = "";
		out.append("<input type=text class='in_txt_off' name=\""+param.getYear()+"7\" size=4 value=\""+dateobj.getYear7()+"\" "+strReadonly+">년 ");
		if (param.getDateType() < 3){
			out.append("<input type=text class='in_txt_off' name=\""+param.getMonth()+"7\" size=2 value=\""+dateobj.getMonth7()+"\" "+strReadonly+">월 ");
		}else{
		    out.append("<input type=hidden name=\""+param.getMonth()+"7\" size=2 value=\""+dateobj.getMonth7()+"\" "+strReadonly+">");
		}
		if (param.getDateType() < 2){
			out.append("<input type=text class='in_txt_off' name=\""+param.getDay()+"7\" size=2 value=\""+dateobj.getDay7()+"\" "+strReadonly+">일"); 
		}else{
			out.append("<input type=hidden name=\""+param.getDay()+"7\" size=2 value=\""+dateobj.getDay7()+"\" "+strReadonly+">");
		}	
	    if (param.getDateType() < 1){
	    	out.append("<input type=text class='in_txt' name=\""+param.getHour()+"7\" size=2 value=\""+dateobj.getHour7()+"\">시");
	    	out.append("<input type=text class='in_txt' name=\""+param.getMinute()+"7\" size=2 value=\""+dateobj.getMin7()+"\">분"); 
	    }else{
	    	out.append("<input type=hidden name=\""+param.getHour()+"7\" size=2 value=\""+dateobj.getHour7()+"\">"); 
	    	out.append("<input type=hidden name=\""+param.getMinute()+"7\" size=2 value=\""+dateobj.getMin7()+"\">");
	    }	
		out.append("<input type=hidden name=\""+param.getDate()+"5\" value=\""+dateobj.getYear3()+dateobj.getMonth5()+dateobj.getDay5()+dateobj.getHour5()+dateobj.getMin5()+dateobj.getSec5()+"\">");
	    out.append("<input type=hidden name=\""+param.getDate()+"6\" value=\""+dateobj.getYear4()+dateobj.getMonth6()+dateobj.getDay6()+dateobj.getHour6()+dateobj.getMin6()+dateobj.getSec6()+"\">");
	    //out.append("[<a href=\"javascript:date_select('"+param.getForm()+"','"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"',"+curyear1+","+curmonth1+",'"+param.getDate()+"','1');\">달력</a>] \n");
	    	
	    
		if (param.getCount() > 1){
			out.append(" ~ ");
		    if(dateobj.getYear4().equals("")){ 
		    	curyear2=DateTimeUtil.getYear(); 
		    }else{
		    	curyear2=dateobj.getYear4(); 
		    }
		    if (dateobj.getMonth4().equals("")){ 
		    	curmonth2=DateTimeUtil.getMonth(); 
		    }else{
		    	curmonth2=dateobj.getMonth4(); 
		    }
			out.append("<input type=text class='in_txt' name=\""+param.getYear()+"6\" size=4 value=\""+dateobj.getYear6()+"\" "+strReadonly+">년");
			if (param.getDateType() < 3){
			     out.append("<input type=text class='in_txt' name=\""+param.getMonth()+"6\" size=2 value=\""+dateobj.getMonth6()+"\" "+strReadonly+">월");
			}else{
			    out.append("<input type=hidden name=\""+param.getMonth()+"6\" size=2 value=\""+dateobj.getMonth6()+"\" "+strReadonly+">");
			}
			if (param.getDateType() < 2){
				out.append("<input type=text class='in_txt' name=\""+param.getDay()+"6\" size=2 value=\""+dateobj.getDay6()+"\" "+strReadonly+">일 "); 
			}else{
				out.append("<input type=hidden name=\""+param.getDay()+"6\" size=2 value=\""+dateobj.getDay6()+"\" "+strReadonly+">");
			}	
		    if (param.getDateType() < 1){
		    	out.append("<input type=text class='in_txt' name=\""+param.getHour()+"6\" size=2 value=\""+dateobj.getHour6()+"\">시 ");
		    	out.append("<input type=text class='in_txt' name=\""+param.getMinute()+"6\" size=2 value=\""+dateobj.getMin6()+"\">분 "); 
		    }else{
		    	out.append("<input type=hidden name=\""+param.getHour()+"6\" size=2 value=\""+dateobj.getHour6()+"\">"); 
		    	out.append("<input type=hidden name=\""+param.getMinute()+"6\" size=2 value=\""+dateobj.getMin6()+"\">");
		    }
		    out.append("<input type=button value='달력'  class=\"input_button_red\" onClick=\"new CalendarFrame.Calendar(this,'"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"','"+param.getDate()+"','6',"+param.getPosX()+","+param.getPosY()+")\">");
		    //out.append("[<a href=\"javascript:date_select('"+param.getForm()+"','"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"',"+curyear2+","+curmonth2+",'"+param.getDate()+"','2');\">달력</a>] \n");
		}			
		
		return out.toString();
    }
    /**
     * 달력 입력 창을 생성해 준다. 다음 날짜로 생성 
     * @param param
     * @param dateobj
     * @return
     */
    public static String getCalendarNextDay(DateParam param, DateSetter dateobj){
    	StringBuffer out = new StringBuffer();
	    String curyear1= "", curmonth1="",curyear2= "", curmonth2="";
	    String strReadonly = " readonly ";
    	if (dateobj.getYear1().equals("")){
    		curyear1=DateTimeUtil.getYear(); 
		}else{
			curyear1=dateobj.getYear1(); 
		}
	    if (dateobj.getMonth1().equals("")){
            curmonth1=DateTimeUtil.getMonth(); 
		}else{
			curmonth1=dateobj.getMonth1(); 
		}
	    if(param.getReadonly().equals("false"))
	    	strReadonly = "";
		out.append("<input type=text name=\""+param.getYear()+"1\" size=4 value=\""+dateobj.getYear1()+"\" "+strReadonly+">년 ");
		if (param.getDateType() < 3){
			out.append("<input type=text name=\""+param.getMonth()+"1\" size=2 value=\""+dateobj.getMonth1()+"\" "+strReadonly+">월 ");
		}else{
		    out.append("<input type=hidden name=\""+param.getMonth()+"1\" size=2 value=\""+dateobj.getMonth1()+"\" "+strReadonly+">");
		}
		if (param.getDateType() < 2){
			out.append("<input type=text name=\""+param.getDay()+"1\" size=2 value=\""+dateobj.getDay1()+"\" "+strReadonly+">일");
		}else{
			out.append("<input type=hidden name=\""+param.getDay()+"1\" size=2 value=\""+dateobj.getDay1()+"\" "+strReadonly+">");
		}	
	    if (param.getDateType() < 1){
	    	out.append("<input type=text name=\""+param.getHour()+"1\" size=2 value=\""+dateobj.getHour1()+"\">시");
	    	out.append("<input type=text name=\""+param.getMinute()+"1\" size=2 value=\""+dateobj.getMin1()+"\">분"); 
	    }else{
	    	out.append("<input type=hidden name=\""+param.getHour()+"1\" size=2 value=\""+dateobj.getHour1()+"\">"); 
	    	out.append("<input type=hidden name=\""+param.getMinute()+"1\" size=2 value=\""+dateobj.getMin1()+"\">");
	    }	
		out.append("<input type=hidden name=\""+param.getDate()+"1\" value=\""+dateobj.getYear1()+dateobj.getMonth1()+dateobj.getDay1()+dateobj.getHour1()+dateobj.getMin1()+dateobj.getSec1()+"\">");
	    out.append("<input type=hidden name=\""+param.getDate()+"2\" value=\""+dateobj.getYear2()+dateobj.getMonth2()+dateobj.getDay2()+dateobj.getHour2()+dateobj.getMin2()+dateobj.getSec2()+"\">");
	    //out.append("[<a href=\"javascript:date_select('"+param.getForm()+"','"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"',"+curyear1+","+curmonth1+",'"+param.getDate()+"','1');\">달력</a>] \n");
	    out.append("<input type=button value='달력' class=\"cal_button\" onClick=\"new CalendarFrame.Calendar(this,'"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"','"+param.getDate()+"','1',"+param.getPosX()+","+param.getPosY()+"); \">");
	    
		if (param.getCount() > 1){
			out.append(" ~ ");
		    if(dateobj.getYear2().equals("")){ 
		    	curyear2=DateTimeUtil.getYear(); 
		    }else{
		    	curyear2=dateobj.getYear2(); 
		    }
		    if (dateobj.getMonth2().equals("")){ 
		    	curmonth2=DateTimeUtil.getMonth(); 
		    }else{
		    	curmonth2=dateobj.getMonth2(); 
		    }
			out.append("<input type=text name=\""+param.getYear()+"2\" size=4 value=\""+dateobj.getYear2()+"\" "+strReadonly+">년");
			if (param.getDateType() < 3){
			     out.append("<input type=text name=\""+param.getMonth()+"2\" size=2 value=\""+dateobj.getMonth2()+"\" "+strReadonly+">월");
			}else{
			    out.append("<input type=hidden name=\""+param.getMonth()+"2\" size=2 value=\""+dateobj.getMonth2()+"\" "+strReadonly+">");
			}
			if (param.getDateType() < 2){
				out.append("<input type=text name=\""+param.getDay()+"2\" size=2 value=\""+dateobj.getDay2()+"\" "+strReadonly+">일 ");
			}else{
				out.append("<input type=hidden name=\""+param.getDay()+"2\" size=2 value=\""+dateobj.getDay2()+"\" "+strReadonly+">");
			}	
		    if (param.getDateType() < 1){
		    	out.append("<input type=text name=\""+param.getHour()+"2\" size=2 value=\""+dateobj.getHour2()+"\">시 ");
		    	out.append("<input type=text name=\""+param.getMinute()+"2\" size=2 value=\""+dateobj.getMin2()+"\">분 "); 
		    }else{
		    	out.append("<input type=hidden name=\""+param.getHour()+"2\" size=2 value=\""+dateobj.getHour2()+"\">"); 
		    	out.append("<input type=hidden name=\""+param.getMinute()+"2\" size=2 value=\""+dateobj.getMin2()+"\">");
		    }
		    out.append("<input type=button value='달력'  class=\"cal_button\" onClick=\"new CalendarFrame.Calendar(this,'"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"','"+param.getDate()+"','2',"+param.getPosX()+","+param.getPosY()+")\">");
		    //out.append("[<a href=\"javascript:date_select('"+param.getForm()+"','"+param.getYear()+"','"+param.getMonth()+"','"+param.getDay()+"','"+param.getHour()+"','"+param.getMinute()+"',"+curyear2+","+curmonth2+",'"+param.getDate()+"','2');\">달력</a>] \n");
		}			
		
		return out.toString();
    }

    /**
     * 코드 박스를 생성해 준다.
     * @param param
     * @param list
     * @return
     */    
    public static String getCodeBox(CodeParam param, ArrayList list){
    	StringBuffer out = new StringBuffer();
    	ComCodeDTO code = null;
	    if (param.getType().equals("select")){
			out.append("<select name=\""+param.getName()+"\"  style=\"margin:1 0 0 0;"+param.getStyle()+"\" ");
            if(!StringUtil.nvl(param.getStyleClass(),"").equals("")) out.append("class=\""+param.getStyleClass()+"\" ");
			if(param.getEtc() != null) out.append(" "+param.getEtc()+" ");
			if (param.getEvent() != null && !param.getEvent().equals("")) out.append("onChange=\""+param.getEvent()+"\" ");
			    out.append(" > \n "); 
				if (param.getFirst() != null && !param.getFirst().equals("")) out.append("<option value=\"\">"+param.getFirst()+"</option> \n");
				if (list != null && list.size() > 0)
				    for(int i = 0; i < list.size(); i++){		  
				    	code = (ComCodeDTO)list.get(i);
				    	out.append("<option value=\""+code.getCode()+"\" ");
				    	if (code.getCode().equals(param.getSelected())) out.append("selected");
				    	out.append(" >"+code.getName()+"</option>\n");
				    }
			out.append("</select>\n");
	    }else if(param.getType().equals("check")){
				if (list != null && list.size() > 0)
					for(int i = 0; i < list.size(); i++){		  
				    	code = (ComCodeDTO)list.get(i);				
						out.append("<INPUT type=checkbox name=\""+param.getName()+"\" ");
			            if(!StringUtil.nvl(param.getStyleClass(),"").equals("")){ out.append("class=\""+param.getStyleClass()+"\" ");}else{out.append("class=\"no\" ");}
			            out.append(" value=\""+code.getCode()+"\"");
						if (param.getSelected().indexOf(code.getCode()) > -1) out.append(" checked "); 
						if (param.getEvent() != null && !param.getEvent().equals("")) out.append(" onclick=\""+param.getEvent()+"\" ");
						out.append(">"+code.getName()+"&nbsp; \n");
					}
	    }else if(param.getType().equals("radio")) {
	    		if (param.getFirst() != null && !param.getFirst().equals("")) {
	    			out.append("<INPUT type=radio name=\""+param.getName()+"\" class=no value=\"\"");
	    			if("".equals(param.getSelected())) out.append(" checked ");
	    			out.append(">"+param.getFirst()+" ");
	    		}
				if (list != null && list.size() > 0)
					for(int i = 0; i < list.size(); i++){
						code = (ComCodeDTO)list.get(i);
						out.append("<INPUT type=radio name=\""+param.getName()+"\" class=no value=\""+code.getCode()+"\" ");
						if (param.getSelected().indexOf(code.getCode()) > -1) out.append(" checked ");
						//if (code.getCode().equals(param.getSelected())) out.append(" checked ");
						if (param.getEvent() != null && !param.getEvent().equals("")) out.append(" onclick=\""+param.getEvent()+"\" ");
						out.append(">"+code.getName()+"&nbsp;");
					}
	    }
	    
	    return out.toString();
   }

    /**
     * 코드 박스를 생성해 준다.(CodeName2 2개의 데이터를 한개의 Select Option 으로 꺼내기위해 사용.)
     * @param param
     * @param list
     * @return
     */    
    public static String getCodeBox2(CodeParam param, ArrayList list){
    	StringBuffer out = new StringBuffer();
    	ComCodeDTO code = null;
	    if (param.getType().equals("select")){
			out.append("<select name=\""+param.getName()+"\"  style=\"margin:1 0 0 0;"+param.getStyle()+"\" ");
            if(!StringUtil.nvl(param.getStyleClass(),"").equals("")) out.append("class=\""+param.getStyleClass()+"\" ");
			if(param.getEtc() != null) out.append(" "+param.getEtc()+" ");
			if (param.getEvent() != null && !param.getEvent().equals("")) out.append("onChange=\""+param.getEvent()+"\" ");
			    out.append(" > \n "); 
				if (param.getFirst() != null && !param.getFirst().equals("")) out.append("<option value=\"\">"+param.getFirst()+"</option> \n");
				if (list != null && list.size() > 0)
				    for(int i = 0; i < list.size(); i++){		  
				    	code = (ComCodeDTO)list.get(i);
				    	out.append("<option value=\""+code.getCode()+code.getCode2()+"\" ");
				    	String codeSum = "";
				    		codeSum += code.getCode()+code.getCode2();
				    	if (codeSum.equals(param.getSelected())) out.append("selected");
				    	out.append(" >"+code.getName()+"-"+code.getName2()+"</option>\n");
				    }
			out.append("</select>\n");
	    }else if(param.getType().equals("check")){
				if (list != null && list.size() > 0)
					for(int i = 0; i < list.size(); i++){		  
				    	code = (ComCodeDTO)list.get(i);				
						out.append("<INPUT type=checkbox name=\""+param.getName()+"\" ");
			            if(!StringUtil.nvl(param.getStyleClass(),"").equals("")){ out.append("class=\""+param.getStyleClass()+"\" ");}else{out.append("class=\"no\" ");}
			            out.append(" value=\""+code.getCode()+"\"");
						if (param.getSelected().indexOf(code.getCode()) > -1) out.append(" checked "); 
						if (param.getEvent() != null && !param.getEvent().equals("")) out.append(" onclick=\""+param.getEvent()+"\" ");
						out.append(">"+code.getName()+"&nbsp; \n");
					}
	    }else if(param.getType().equals("radio")) {
	    		if (param.getFirst() != null && !param.getFirst().equals("")) {
	    			out.append("<INPUT type=radio name=\""+param.getName()+"\" class=no value=\"\"");
	    			if("".equals(param.getSelected())) out.append(" checked ");
	    			out.append(">"+param.getFirst()+" ");
	    		}
				if (list != null && list.size() > 0)
					for(int i = 0; i < list.size(); i++){
						code = (ComCodeDTO)list.get(i);
						out.append("<INPUT type=radio name=\""+param.getName()+"\" class=no value=\""+code.getCode()+"\" ");
						if (param.getSelected().indexOf(code.getCode()) > -1) out.append(" checked ");
						//if (code.getCode().equals(param.getSelected())) out.append(" checked ");
						if (param.getEvent() != null && !param.getEvent().equals("")) out.append(" onclick=\""+param.getEvent()+"\" ");
						out.append(">"+code.getName()+code.getName2()+"&nbsp;");
					}
	    }
	    
	    return out.toString();
   }
    
    /**
     * 코드 박스를 생성해 준다.(UserID,UserName 1개의 Select Option 으로 꺼내기위해 사용.)
     * 2013_03_13(수) shbyeon.현재 셀렉트 옵션 건에 대해서만 변경 되어있음.
     * 현재 영업지원팀의 ID값만 콤보박스로 불러와서 사용중.
     * @param param
     * @param list
     * @return
     */    
    public static String getUserBox2(CodeParam param, ArrayList list){
    	StringBuffer out = new StringBuffer();
    	ComCodeDTO code = null;
	    if (param.getType().equals("select")){
			out.append("<select name=\""+param.getName()+"\"  style=\"margin:1 0 0 0;"+param.getStyle()+"\" ");
            if(!StringUtil.nvl(param.getStyleClass(),"").equals("")) out.append("class=\""+param.getStyleClass()+"\" ");
			if(param.getEtc() != null) out.append(" "+param.getEtc()+" ");
			if (param.getEvent() != null && !param.getEvent().equals("")) out.append("onChange=\""+param.getEvent()+"\" ");
			    out.append(" > \n "); 
				if (param.getFirst() != null && !param.getFirst().equals("")) out.append("<option value=\"\">"+param.getFirst()+"</option> \n");
				if (list != null && list.size() > 0)
				    for(int i = 0; i < list.size(); i++){		  
				    	code = (ComCodeDTO)list.get(i);
				    	out.append("<option value=\""+code.getUserID()+"\" ");
				    		System.out.println("UserID:"+code.getUserID());
				    	if (code.getUserID().equals(param.getSelected())) out.append("selected");
				    	out.append(" >"+code.getUserName()+"</option>\n");
				    }
			out.append("</select>\n");
	    }else if(param.getType().equals("check")){
				if (list != null && list.size() > 0)
					for(int i = 0; i < list.size(); i++){		  
				    	code = (ComCodeDTO)list.get(i);				
						out.append("<INPUT type=checkbox name=\""+param.getName()+"\" ");
			            if(!StringUtil.nvl(param.getStyleClass(),"").equals("")){ out.append("class=\""+param.getStyleClass()+"\" ");}else{out.append("class=\"no\" ");}
			            out.append(" value=\""+code.getCode()+"\"");
						if (param.getSelected().indexOf(code.getCode()) > -1) out.append(" checked "); 
						if (param.getEvent() != null && !param.getEvent().equals("")) out.append(" onclick=\""+param.getEvent()+"\" ");
						out.append(">"+code.getName()+"&nbsp; \n");
					}
	    }else if(param.getType().equals("radio")) {
	    		if (param.getFirst() != null && !param.getFirst().equals("")) {
	    			out.append("<INPUT type=radio name=\""+param.getName()+"\" class=no value=\"\"");
	    			if("".equals(param.getSelected())) out.append(" checked ");
	    			out.append(">"+param.getFirst()+" ");
	    		}
				if (list != null && list.size() > 0)
					for(int i = 0; i < list.size(); i++){
						code = (ComCodeDTO)list.get(i);
						out.append("<INPUT type=radio name=\""+param.getName()+"\" class=no value=\""+code.getCode()+"\" ");
						if (param.getSelected().indexOf(code.getCode()) > -1) out.append(" checked ");
						//if (code.getCode().equals(param.getSelected())) out.append(" checked ");
						if (param.getEvent() != null && !param.getEvent().equals("")) out.append(" onclick=\""+param.getEvent()+"\" ");
						out.append(">"+code.getName()+code.getName2()+"&nbsp;");
					}
	    }
	    
	    return out.toString();
   }

   /**
    * 기본 메일 폼을 가지고 메일을 전송해준다.
    * @param subject
    * @param addr
    * @param username
    * @param msg
    */
   public static void defaultMailSend(String subject, String addr, String username,String msg){
	StringBuffer sb = new StringBuffer();
	sb.append("<html>");
	sb.append("<head>");
	sb.append("<title>Audien</title>");
	sb.append("</head>");
	sb.append("<body>");
	sb.append("<TABLE id=\"Table1\" cellSpacing=\"1\" cellPadding=\"1\" width=\"300\" border=\"1\">");
	sb.append("<TR>");
	sb.append("<TD style=\"HEIGHT: 60px;BACKGROUND-COLOR: #ccffcc\">");
	sb.append("<P align=\"center\"><FONT face=\"굴림\"><STRONG>"+subject+"</STRONG> </FONT>");
	sb.append("</P>");
	sb.append("</TD>");
	sb.append("</TR>");
	sb.append("<TR>");
	sb.append("<TD style=\"HEIGHT: 47px\"><FONT face=\"굴림\">"+msg+"</FONT></TD>");
	sb.append("</TR>");
	sb.append("</TABLE>");
	sb.append("</body>");
	sb.append("</html>");
    
	MailUtil.sendDirectMail(addr, username, subject, sb.toString()); 
  }

   /**
    * 코드명을 가져온다.
    * @param bigcd
    * @param smlcd
    * @return
    */
   public static String getCodeNm(String bigcd, String smlcd){
   	CodeDAO codeDao = new CodeDAO();
   	CodeDTO codeDto = null;
   	try{
   		codeDto = codeDao.getCodeInfo(bigcd, smlcd);
   	}catch(Exception e){
   	}
   	
   	return codeDto.getCdNm();
   }

   /**
    * 코드명을 가져온다.
    * @param String[] bigcd
    * @param String smlcd
    * @return
    */
   public static String[] getCodeNm(String[] bigcd, String smlcd){
   	CodeDAO codeDao = new CodeDAO();
   	CodeDTO codeDto = null;
   	String[] cdNms = null;
   	if(bigcd == null) {
   		return null;
   	} else {
   		cdNms = new String[bigcd.length];
   	   	try{
   	   		for(int i=0; i<bigcd.length; i++) {
   	   			codeDto = codeDao.getCodeInfo(bigcd[i], smlcd);
   	   			cdNms[i] = codeDto.getCdNm();
   	   		}
   	   	}catch(Exception e){
   	   	}
   	   	return cdNms;
   	}
   	
   }
   /**
    * 코드 리스트를 가져온다.
    * @param param
    * @param smlcode
    * @return
    */
   public static String getCodeList(CodeParam param, String smlcode){
   	CommonDAO common = new CommonDAO();
   	ArrayList codeList = null;
   	try{
   		codeList = common.getCodeList(smlcode);
   	}catch(Exception e){
   	}
   	
   	return getCodeBox(param, codeList);
   }
   
   /**
    * 코드 리스트를(가나다순) 가져온다.
    * @param param
    * @param smlcode
    * @return
    */
   public static String getCodeListHanSeq(CodeParam param, String smlcode){
   	CommonDAO common = new CommonDAO();
   	ArrayList codeList = null;
   	try{
   		codeList = common.getCodeListHanSeq(smlcode);
   	}catch(Exception e){
   	}
   	
   	return getCodeBox(param, codeList);
   }
   /**
    * 코드 리스트를(가나다순)그룹에 따른 이름명으로 가져온다. 2013_03_11_(월) shbyeon
    * @param param
    * @param smlcode
    * @return
    */
   public static String getCodeListHanSeq2(CodeParam param){
   	CommonDAO common = new CommonDAO();
   	ArrayList userList = null;
   	try{
   		userList = common.getCodeListHanSeqq2();
   		System.out.println("UserLIST:"+userList);
   	}catch(Exception e){
   	}
   	
   	return getUserBox2(param, userList);
   }
   /**
    * 코드 리스트를(가나다순) 가져온다.(코드리스트 code값 코드네임 name2값 2개 필요시 사용)
    * @param param
    * @param smlcode
    * @return
    */
   public static String getCodeListHanSeqq(CodeParam param, String smlcode){
   	CommonDAO common = new CommonDAO();
   	ArrayList codeList = null;
   	try{
   		codeList = common.getCodeListHanSeqq(smlcode);
   	}catch(Exception e){
   	}
   	
   	return getCodeBox2(param, codeList);
   }
   /**
    * 코드 리스트를 가져온다.
    * @param smlcode
    * @return
    */
   public static ArrayList getCodeList(String smlcode){
   	CommonDAO common = new CommonDAO();
   	ArrayList codeList = null;
   	try{
   		codeList = common.getCodeList(smlcode);
   	}catch(Exception e){
   	}
   	
   	return codeList;
   }

   
   public static String getPackageCodeList(CodeParam param, String smlcode){
	   CommonDAO common = new CommonDAO();
	   	ArrayList codeList = null;
	   	try{
	   		codeList = common.getCodeList(smlcode , "A" );
	   	}catch(Exception e){
	   	}
	   	
	   	return getCodeBox(param, codeList);
   }
  
   /**
	 * -------------------------------------------------------- URL에 대한 페이지를 실행한 결과를 리턴한다.
	 * @param String 호출할 url
	 * @return String ----------------------------------------------------------
	 */
	public static String getHtml(String url) {
		String content = "";
		String param = "";
		param = url.substring(url.indexOf("?") + 1,url.length());
		url = url.substring(0,url.indexOf("?"));
		try {
			URL source = new URL(url);
			URLConnection sconnection = source.openConnection();
			sconnection.setDoOutput(true);
			//sconnection.setRequestProperty("Content-Type","application/octet-stream");
			/**
			BufferedReader in = new BufferedReader(new InputStreamReader(sconnection.getInputStream(), "cp949"));
			String inputLine = null;
			while ((inputLine = in.readLine()) != null)
				content += inputLine;
			in.close();
			*/
			PrintWriter out = new PrintWriter(
                    sconnection.getOutputStream());
		    out.println(param);
		    out.close();
		
		    BufferedReader in = new BufferedReader(new InputStreamReader(sconnection.getInputStream(), "MS949"));
		    String inputLine = null;
		    while ((inputLine = in.readLine()) != null)
		        content += inputLine + "\n";
		    in.close();
		} catch (MalformedURLException me) {
			me.printStackTrace();
			return "*";
		} catch (IOException ioe) {
			ioe.printStackTrace();
			return "*";
		} catch (Exception e) {
			e.printStackTrace();
			return "*";
		}
		//log.debug("내용:" + content + "끝");
		return content;
	}
	
	public static String getDateDropDownListWithExpdate(String frmObj, String endDate, String selectedDate, String expCnt){
	//function getDateDropDownListWithExpdate( frmObj , endDate , selectedDate , expCnt)
	/*
		DATE date = new Date();
		var year = date.getYear();
		var month = date.getMonth() + 1;
		
		var endYear = endDate.substring(0 , 4 );
		var endMonth = endDate.substring( 4 , 6 );
		var monthDiff;
				
		if ( year > parseInt( endYear ) ){			
			monthDiff = month + ( ( year - parseInt( endYear ) - 1 ) * 12 + ( 12 - parseInt( endMonth ) ) );
		}else{
			monthDiff = month - parseInt( endMonth );
		}

		frmObj.length = monthDiff + 1 - expCnt ;

		var cnt = 1;
		var cnt1 = 12;
		var selectedCnt = 0;

		if ( monthDiff <= month )
		{
			for ( var i = 0 ; i < ( month - parseInt( endMonth ) )  ; i++ ){

				if ( ( month - i ) < 10  )
				{
					if ( (year + "0" + ( month - i ) ) ==  selectedDate )
					{
						selectedCnt = cnt;
					}
					
					
					if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
					{						
						frmObj.options[cnt].value = year + "0" + ( month - i );
						frmObj.options[cnt++].text = year + "년 0" + ( month - i ) + "월";
					}
				}
				else
				{
					if ( (year + "" + ( month - i ) ) ==  selectedDate )
					{
						selectedCnt = cnt;
					}

					if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
					{						
						frmObj.options[cnt].value = year + "" + ( month - i ) ;
						frmObj.options[cnt++].text = year + "년 " + ( month - i ) + "월";
					}
				}
			}
		}
		else
		{
			for( var i = 0 ; i < monthDiff ; i++ )
			{
				if ( i < month )
				{
					if ( ( month - i ) < 10  )
					{
						if ( (year + "0" + ( month - i ) ) ==  selectedDate )
						{
							selectedCnt = cnt;
						}

						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
						{						
							frmObj.options[cnt].value = year + "0" + ( month - i );
							frmObj.options[cnt++].text = year + "년 0" + ( month - i ) + "월";
						}
					}
					else
					{
						if ( (year + "" + ( month - i ) ) ==  selectedDate )
						{
							selectedCnt = cnt;
						}
						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
						{						
							frmObj.options[cnt].value = year + "" + ( month - i );
							frmObj.options[cnt++].text = year + "년 " + ( month - i ) + "월";
						}
					}
				}
				else
				{
					if ( cnt1 == 12 )
					{
						year--;
					}

					if ( cnt1 < 10 )
					{
						if ( ( year + "0" + cnt1 ) ==  selectedDate ){
							selectedCnt = cnt;
						}
						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
						{						
							frmObj.options[cnt].value = year + "0" + cnt1;
							frmObj.options[cnt++].text = year + "년 0" + cnt1 + "월";
						}
					}
					else
					{
						if ( ( year + "" + cnt1 ) ==  selectedDate )
						{
							selectedCnt = cnt;
						}
						
						if ((month-i) != "1" && (month-i)!="2"&& (month-i)!="3")
						{						

							frmObj.options[cnt].value = year + "" + cnt1;
							frmObj.options[cnt++].text = year + "년 " + cnt1 + "월";
						}
					}

					if ( cnt1 == 1 )
					{
						cnt1 = 12;
					}
					else
					{
						cnt1--;
					}
				}
			}
		}

		frmObj.selectedIndex = selectedCnt;*/
		return "";
	}	

}
