package com.huation.common.util;

import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.text.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Locale;
import org.apache.log4j.Logger;

import com.huation.common.util.DateParam;
import com.huation.common.code.CodeDTO;
import com.huation.common.util.DateSetter;


// Referenced classes of package com.audien.common.util:
//            LogUtil

public class StringUtil
{
	private static final String DATE_GUBUN = ".";
	private static final String TIME_GUBUN = ":";
    
    public StringUtil()
    {
    }

    public static String null2DefaultString(String s, String defaultValue)
    {
        if(s == null ||"".equals(s) )
            s = defaultValue; 
        return s;
    }
    
    public static int null2DefaultInt(String s, int defaultValue)
    {
        if(s == null ||"".equals(s) )
        	return defaultValue; 
        return Integer.parseInt(s);
    }

    public static String null2String(String s)
    {
        if(s == null)
            s = "";
        return s;
    }

    public static String null2Zero(String s)
    {
        if(s == null || "".equals(s.trim()))
            s = "0";
        return s;
    }

    public static String han2uni(String s)
    {
        if(s == null)
            return "";
        try
        {
            s = new String(s.trim().getBytes("euc-kr"), "euc-kr");
        }
        catch(UnsupportedEncodingException uee)
        {
            logger.error("StringUtil@han2uni UnsupportedEncodingException : " + uee.getMessage(), uee);
        }
        return s;
    }

    public static String uni2han(String s)
    {
        if(s == null)
            return "";
        try
        {
            s = new String(s.trim().getBytes("KSC5601"), "8859_1");
        }
        catch(UnsupportedEncodingException uee)
        {
            logger.error("StringUtil@han2uni UnsupportedEncodingException : " + uee.getMessage(), uee);
        }
        return s;
    }

    public static short parseShort(String s)
    {
        short result = 0;
        try
        {
            if(s != null && !s.trim().equals(""))
                result = Short.parseShort(s.trim());
        }
        catch(NumberFormatException numberformatexception) { }
        return result;
    }

    public static int parseInt(String s)
    {
        int result = 0;
        try
        {
            if(s != null && !s.trim().equals(""))
                result = Integer.parseInt(s.trim());
        }
        catch(NumberFormatException numberformatexception) { }
        return result;
    }

    public static String replaceAll(String text, int start, String src, String dest)
    {
        if(text == null)
            return null;
        if(src == null || dest == null)
            return text;
        int textlen = text.length();
        int srclen = src.length();
        int diff = dest.length() - srclen;
        int d = 0;
        StringBuffer t = new StringBuffer(text);
        while(start < textlen)
        {
            start = text.indexOf(src, start);
            if(start < 0)
                break;
            t.replace(start + d, start + d + srclen, dest);
            start += srclen;
            d += diff;
        }
        return t.toString();
    }

    public static String fFormat(short input, int cnt)
    {
        return fFormat((new StringBuffer(String.valueOf(input))).toString(), cnt);
    }

    public static String fFormat(int input, int cnt)
    {
        return fFormat((new StringBuffer(String.valueOf(input))).toString(), cnt);
    }

    public static String fFormat(long input, int cnt)
    {
        return fFormat((new StringBuffer(String.valueOf(input))).toString(), cnt);
    }

    public static String fFormat(float input, int cnt)
    {
        return fFormat((new StringBuffer(String.valueOf(input))).toString(), cnt);
    }

    public static String fFormat(double input, int cnt)
    {
        return fFormat((new StringBuffer(String.valueOf(input))).toString(), cnt);
    }

    public static String fFormat(String str, int cnt)
    {
        if(str == null)
            return "";
        if(str.length() == 0)
            return "";
        StringBuffer sb_format = new StringBuffer("#,###,###,##0.");
        if(cnt <= 0)
        {
            sb_format.deleteCharAt(13);
        } else
        {
            for(int i = 0; i < cnt; i++)
                sb_format.append("0");

        }
        DecimalFormat df = new DecimalFormat(sb_format.toString());
        String retstr = null;
        try
        {
            retstr = df.format(Long.parseLong(str));
            return retstr;
        }
        catch(NumberFormatException nfe) { }
        catch(Exception e)
        {
            return "0";
        }
        try
        {
            retstr = df.format(Double.valueOf(str).doubleValue());
            return retstr;
        }
        catch(Exception ee)
        {
            return "0";
        }
    }

    public static String dFormat(String str)
    {
        if(str == null)
            return "";
        if(str.trim().length() == 0)
            return "";
        NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);
        Number num = null;
        String ret = "";
        try
        {
            num = nf.parse(str);
        }
        catch(ParseException parseexception) { }
        ret = dFormat(num.longValue());
        return ret;
    }

    public static String dFormat(int num)
    {
        NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);
        String tempStr = nf.format(num);
        return tempStr;
    }

    public static String dFormat(long num)
    {
        NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);
        String tempStr = nf.format(num);
        return tempStr;
    }

    public static String dFormat(double num)
    {
        NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);
        String tempStr = nf.format(num);
        return tempStr;
    }

    /**
     * @deprecated Method getProductName is deprecated
     */

    public static String getProductName(String str, int length)
    {
        if(str == null)
            return "";
        if(str.trim().length() <= length)
            return str;
        byte bytes[] = str.trim().getBytes();
        if(length * 2 > bytes.length - 3)
            return new String(bytes);
        else
            return new String(bytes, 0, length * 2) + "...";
    }

    /**
     * @deprecated Method substring is deprecated
     */

    public static String substring(String str, int length)
    {
        return getProductName(str, length);
    }

    public static String getSplitDate(String strDate)
    {
        if(strDate == null)
            return "";
        if(strDate.length() == 8)
            return strDate.substring(0, 4) + "-" + strDate.substring(4, 6) + "-" + strDate.substring(6);
        if(strDate.length() == 6)
            return strDate.substring(0, 4) + "-" + strDate.substring(4, 6);
        else
            return strDate;
    }

    public static String getSplitTime(String strTime)
    {
        if(strTime == null)
            return "";
        if(strTime.length() == 6)
            return strTime.substring(0, 2) + ":" + strTime.substring(2, 4) + ":" + strTime.substring(4);
        if(strTime.length() == 4)
            return strTime.substring(0, 2) + ":" + strTime.substring(2, 4);
        else
            return strTime;
    }

    public static String getSocialid2Birthday(String socialid)
    {
        String result = "";
        if(socialid == null)
            return "";
        if(socialid.length() >= 13)
        {
            result = socialid.substring(0, 6);
            if(socialid.charAt(6) == '1' || socialid.charAt(6) == '2')
                result = "19" + result;
            else
                result = "20" + result;
            return getSplitDate(result);
        } else
        {
            return result;
        }
    }

    public static String pad(String str, int width)
    {
        return pad(str, width, " ");
    }

    public static String pad(int input, int width, String specChar)
    {
        return pad((new StringBuffer(String.valueOf(input))).toString(), width, specChar);
    }

    public static String pad(String str, int width, String specChar)
    {
        if(str == null)
            str = "";
        StringBuffer buf = new StringBuffer();
        for(int space = width - str.length(); space-- > 0;)
            buf.append(specChar);

        buf.append(str);
        return buf.toString();
    }

    public static String Rpad(String str, int width, String specChar)
    {
        if(str == null)
            str = "";
        StringBuffer buf = new StringBuffer(width);
        int space = 0;
        buf.append(str);
        for(; buf.length() < width; buf.append(specChar));
        return buf.toString();
    }

    public static String Rpad(int str, int width, String specChar)
    {
        return Rpad((new StringBuffer(String.valueOf(str))).toString(), width, specChar);
    }

    public static String getSocialId(String socialId)
    {
        if(socialId == null)
            return "";
        if(socialId.length() < 6)
            return socialId;
        if(socialId.charAt(6) == '-')
            return socialId;
        else
            return (new StringBuffer(socialId)).insert(6, '-').toString();
    }

    public static String getSocialId(String socialId, boolean isFirst)
    {
        if(isFirst)
            return socialId.substring(0, 6);
        else
            return socialId.substring(6);
    }

    public static int string2int(String str)
    {
        int result = 0;
        if(str == null)
            return result;
        str = str.trim();
        if("".equals(str))
            return result;
        else
            return result = Integer.parseInt(str);
    }

    public static long string2long(String str)
    {
        long result = 0L;
        if(str == null)
            return result;
        str = str.trim();
        if("".equals(str))
            return result;
        else
            return result = Long.parseLong(str);
    }

    public static float string2float(String str)
    {
        float result = 0.0F;
        if(str == null)
            return result;
        str = str.trim();
        if("".equals(str))
            return result;
        else
            return result = Float.parseFloat(str);
    }

    public static double string2double(String str)
    {
        double result = 0.0D;
        if(str == null)
            return result;
        str = str.trim();
        if("".equals(str))
            return result;
        else
            return result = Double.parseDouble(str);
    }

    public static long string2seconds(String str)
    {
        long seconds = 0L;
        if(str == null)
            return seconds;
        if(str.indexOf(":") > -1)
            seconds = string2int(str.substring(0, str.indexOf(":"))) * 60 + string2int(str.substring(str.indexOf(":") + 1));
        else
            seconds = string2int(str.substring(str.indexOf(":") + 1));
        return seconds;
    }

    public static String seconds1time(long seconds)
    {
        String result = "00:00";
        int hour = 0;
        int min = 0;
        int sec = 0;
        hour = (int)(seconds / 3600L);
        min = (int)((seconds % 3600L) / 60L);
        sec = (int)(seconds % 3600L % 60L);
        if(hour == 0)
            result = pad(min, 2, "0") + ":" + pad(sec, 2, "0");
        else
            result = pad(hour, 2, "0") + ":" + pad(min, 2, "0") + ":" + pad(sec, 2, "0");
        return result;
    }

    public static String seconds2time(long seconds)
    {
        String result = "00:00:00";
        int hour = 0;
        int min = 0;
        int sec = 0;
        hour = (int)(seconds / 3600L);
        min = (int)((seconds % 3600L) / 60L);
        sec = (int)(seconds % 3600L % 60L);
        result = pad(hour, 2, "0") + ":" + pad(min, 2, "0") + ":" + pad(sec, 2, "0");
        return result;
    }

    public static String minute2time(String minute)
    {
        String result = "00:00";
        String strMinute = "";
        String strSecond = "";
        String tmpMinute = "";
        int minuteLength = 0;
        int hour = 0;
        int min = 0;
        int sec = 0;
        int intMinute = 0;
        tmpMinute = minute.trim().replaceAll(":", "");
        minuteLength = tmpMinute.length();
        if(minuteLength < 3)
            return minute;
        strSecond = tmpMinute.substring(minuteLength - 2, minuteLength);
        strMinute = tmpMinute.substring(0, minuteLength - 2);
        intMinute = Integer.parseInt(strMinute);
        hour = intMinute / 60;
        min = intMinute % 60;
        sec = Integer.parseInt(strSecond);
        if(hour > 0)
            result = hour + ":" + pad(min, 2, "0") + ":" + pad(sec, 2, "0");
        else
            result = pad(min, 2, "0") + ":" + pad(sec, 2, "0");
        return result;
    }

    public static int minute2second(String minute)
    {
        int result = 0;
        String strMinute = "";
        String strSecond = "";
        String tmpMinute = "";
        int minuteLength = 0;
        int hour = 0;
        int min = 0;
        int sec = 0;
        int intMinute = 0;
        tmpMinute = minute.trim().replaceAll(":", "");
        minuteLength = tmpMinute.length();
        if(minuteLength < 3)
        {
            return 0;
        } else
        {
            strSecond = tmpMinute.substring(minuteLength - 2, minuteLength);
            strMinute = tmpMinute.substring(0, minuteLength - 2);
            intMinute = Integer.parseInt(strMinute);
            min = intMinute * 60;
            sec = Integer.parseInt(strSecond);
            result = min + sec;
            return result;
        }
    }

    public static String seconds2timeNoSplit(long seconds)
    {
        String result = "00:00";
        int hour = 0;
        int min = 0;
        int sec = 0;
        hour = (int)(seconds / 3600L);
        min = (int)((seconds % 3600L) / 60L);
        sec = (int)(seconds % 3600L % 60L);
        if(hour > 0)
            result = hour + pad(min, 2, "0") + pad(sec, 2, "0");
        else
            result = pad(min, 2, "0") + pad(sec, 2, "0");
        return result;
    }

    public static String hhmmNoSplit(long seconds)
    {
        String result = "00:00";
        int hour = 0;
        int min = 0;
        hour = (int)(seconds / 3600L);
        min = (int)((seconds % 3600L) / 60L);
        if(hour > 0)
            result = hour + pad(hour, 2, "0") + pad(min, 2, "0");
        else
            result = pad(hour, 2, "0") + pad(min, 2, "0");
        return result;
    }

    static Logger logger = LogUtil.getLogger("consoleLogger");

    static
    {
        LogUtil.instance();
    }

    public static String getCodeBox( ArrayList list,String selected){
    	StringBuffer out = new StringBuffer();
    	CodeDTO code;
	    for(int i = 0; i < list.size(); i++){
	    	code = (CodeDTO)list.get(i);
	    	out.append("<option value=\""+code.getSmlCd()+"\" ");
	    	if (code.getSmlCd().equals(selected)) out.append("selected");
	    	out.append(" >"+code.getCdNm()+"</option>\n");
	    }
	    return out.toString();
   }
    
    /**
     * 현재 년도를 돌려준다.
     * @return
     */
	public static String getYear(){
	    String ym = getYearMonth();
	    
	    return ym.substring(0,4);
	} 

	/**
	 * 현재 달을 돌려준다.
	 * @return
	 */
	public static String getMonth(){
	    String ym = getYearMonth();
	    
	    return ym.substring(4,6);
	}
	
	/**
	 * 현재 년월을 돌려준다 - YYYYMM 
	 */
	public static String getYearMonth(){
		String month;

 		Calendar cal = Calendar.getInstance(Locale.getDefault());

 		StringBuffer buf = new StringBuffer();

 		buf.append(Integer.toString(cal.get(Calendar.YEAR)));
 		month = Integer.toString(cal.get(Calendar.MONTH)+1);
 		if(month.length() == 1) month = "0" + month;
 		
 		buf.append(month);
 		
		return buf.toString();
	}
	
	   public static String getDate()
	    {
	        Calendar cal = Calendar.getInstance(Locale.getDefault());
	        
	        StringBuffer buf = new StringBuffer();
	        buf.append(Integer.toString(cal.get(1)));
	        String month = Integer.toString(cal.get(2) + 1);
	        if(month.length() == 1)
	            month = "0" + month;
	        String day = Integer.toString(cal.get(5));
	        if(day.length() == 1)
	            day = "0" + day;
	        buf.append(month);
	        buf.append(day);
	        return buf.toString();
	    }
	   
	   
	   public static String getAddDate( int amount )
	    {
	        Calendar cal = Calendar.getInstance(Locale.getDefault());
	        		 cal.add(Calendar.DATE, amount);
	        StringBuffer buf = new StringBuffer();
	        buf.append(Integer.toString(cal.get(1)));
	        String month = Integer.toString(cal.get(2) + 1);
	        if(month.length() == 1)
	            month = "0" + month;
	        String day = Integer.toString(cal.get(5));
	        if(day.length() == 1)
	            day = "0" + day;
	        buf.append(month);
	        buf.append(day);
	        return buf.toString();
	    }
	   
	   /**
	    * TimeMillis값을 Date형식으로 바꾸어 준다.
	    * @param time
	    * @return
	    */
	   public static String getTimeMillisDate(long time){
		return getTimeMillisDate(time, DATE_GUBUN);
       }

	   public static String getTimeMillisDate(long time, String delimeter){
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(time);
   
			return getDate(cal, delimeter);
	   }
	   
		/**
		 * 해당 날짜의 년월일을 돌려준다. - YYYYMMDD
		 * @param cal - 해당날짜의 Calendar 객체 
		 */
		public static String getDate(Calendar cal, String delimeter){
			String month, day;

	 		StringBuffer buf = new StringBuffer();

	 		buf.append(Integer.toString(cal.get(Calendar.YEAR)));
	 		if(!delimeter.equals("")) buf.append(delimeter);
	 		month = Integer.toString(cal.get(Calendar.MONTH)+1);
	 		if(month.length() == 1) month = "0" + month;
	 		day = Integer.toString(cal.get(Calendar.DATE));
	 		if(day.length() == 1) day = "0" + day;

	 		buf.append(month);
	 		if(!delimeter.equals("")) buf.append(delimeter);
	 		buf.append(day);
	 		
			return buf.toString();
		}
        
        /**
         *  2006.03.22 추가 (ajelier)
        *   날짜 포맷, 지정한 구분자로 날짜 포멧을 만들어준다
        *   @param 날짜(ex,20020202101010)
        *   @retutn  날짜(ex,2002/02/02,2002.02.02,2002-02-02)
        */
        public static String getDateFormat(String m_sDate, String gubun){
            if ( m_sDate == null )
                return "";
            else if ( m_sDate.length() < 8 )
                return m_sDate;
            else
                return m_sDate.substring(0,4) + gubun + m_sDate.substring(4,6) + gubun + m_sDate.substring(6,8);
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
        		curyear1=getYear(); 
        		  System.out.println("[getYear==>]=>"+curyear1);
    		}else{
    			curyear1=dateobj.getYear1(); 
    			  System.out.println("[getYear1==>]=>"+curyear1);
    		}
    	    if (dateobj.getMonth1().equals("")){
                curmonth1=getMonth(); 
                System.out.println("[getMonth==>]=>"+curmonth1);
    		}else{
    			curmonth1=dateobj.getMonth1(); 
    			  System.out.println("[getMonth1==>]=>"+curmonth1);
    		}
    	    
    	    System.out.println("[curyear1==>]=>"+curyear1);
    	    
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
    		    	curyear2=getYear(); 
    		    }else{
    		    	curyear2=dateobj.getYear2(); 
    		    }
    		    if (dateobj.getMonth2().equals("")){ 
    		    	curmonth2=getMonth(); 
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
}
