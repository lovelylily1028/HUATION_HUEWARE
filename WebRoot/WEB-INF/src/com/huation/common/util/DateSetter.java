package com.huation.common.util;

import java.util.Map;

/*********************************************************
 * ���α׷� : DateSetter.java
 * �� �� �� : 
 * ��    �� : 
 * �� �� �� :
 * �� �� �� : 
 * �� �� �� : 
 * �� �� �� :
 * �������� : 
 *********************************************************/
public class DateSetter {
    private String startDt = "";
    private String endDt = "";
    private String year1 = "";
    private String month1 = "";
    private String day1 = "";
    private String hour1 = "";
    private String min1 = ""; 
    private String sec1 = "";
    private String year2 = "";
    private String month2 = "";
    private String day2 = ""; 
    private String hour2 = "";
    private String min2 = "";
    private String sec2 = "";
    
    private String year3 = "";
    private String month3 = "";
    private String day3 = "";
    private String hour3 = "";
    private String min3 = ""; 
    private String sec3 = "";
    private String year4 = "";
    private String month4 = "";
    private String day4 = ""; 
    private String hour4 = "";
    private String min4 = "";
    private String sec4 = "";
    
    private String year5 = "";
    private String month5 = "";
    private String day5 = "";
    private String hour5 = "";
    private String min5 = ""; 
    private String sec5 = "";
    private String year6 = "";
    private String month6 = "";
    private String day6 = ""; 
    private String hour6 = "";
    private String min6 = "";
    private String sec6 = "";
    
    private String year7 = "";
    public String getYear7() {
		return year7;
	}

	public void setYear7(String year7) {
		this.year7 = year7;
	}

	public String getMonth7() {
		return month7;
	}

	public void setMonth7(String month7) {
		this.month7 = month7;
	}

	public String getDay7() {
		return day7;
	}

	public void setDay7(String day7) {
		this.day7 = day7;
	}

	public String getHour7() {
		return hour7;
	}

	public void setHour7(String hour7) {
		this.hour7 = hour7;
	}

	public String getMin7() {
		return min7;
	}

	public void setMin7(String min7) {
		this.min7 = min7;
	}

	public String getSec7() {
		return sec7;
	}

	public void setSec7(String sec7) {
		this.sec7 = sec7;
	}

	private String month7 = "";
    private String day7 = ""; 
    private String hour7 = "";
    private String min7 = "";
    private String sec7 = "";
    
    /**
     *  ��¥ Ÿ�� ���� 
     * 0 : YYYYMMDDHH
     * 1 : YYYYMMDD
     * 2 : YYYYMM
     * 3 : YYYY
     */
    public DateSetter() {
        super();
        // TODO Auto-generated constructor stub
    }

    public DateSetter(String startdt){
        if(startdt == null) startdt = "";
        setSpliteDate(startdt, "s");
    }
    
    public DateSetter(String startdt, String enddt) {
        if(startdt == null) startdt = "";
        if(enddt == null) enddt = "";
        setSpliteDate(startdt, "s");
        setSpliteDate(enddt, "e");
    }
    
    public DateSetter(String startdt, String enddt,String dual) {
        if(startdt == null) startdt = "";
        if(enddt == null) enddt = "";
        
        if(dual.equals("s1")){
        	setSpliteDate(startdt, "s1");
        }else if(dual.equals("e1")){
        	setSpliteDate(startdt, "s1");
        	setSpliteDate(enddt, "e1");
        }else if(dual.equals("s2")){
        	setSpliteDate(startdt, "s2");
        }else if(dual.equals("s3")){
        	setSpliteDate(startdt, "s3");	
        }else if(dual.equals("e2")){
        	setSpliteDate(startdt, "s2");
        	setSpliteDate(enddt, "e2");
        }
       
    }
    
  
    private void setSpliteDate(String date, String type){
        String imsi="";
        String ftype=type.substring(0,1);
        
        if(date.length() == 14){
            imsi += date.substring(0,4);
            imsi += date.substring(4,6);
            imsi += date.substring(6,8);
            imsi += date.substring(8,10);
            imsi += date.substring(10,12);
            imsi += date.substring(12,14);
        }else if(date.length() == 12){
            imsi += date.substring(0,4);
            imsi += date.substring(4,6);
            imsi += date.substring(6,8);
            imsi += date.substring(8,10);
            imsi += date.substring(10,12);
            if(ftype.equals("s")) imsi += "01";
            else imsi += "59";
        }else if(date.length() == 10){
            imsi += date.substring(0,4);
            imsi += date.substring(4,6);
            imsi += date.substring(6,8);
            imsi += date.substring(8,10);
            if(ftype.equals("s")) imsi += "0101";
            else imsi += "5959";
		}else if(date.length() == 8){		    
            imsi += date.substring(0,4);
            imsi += date.substring(4,6);
            imsi += date.substring(6,8);
            if(ftype.equals("s")) imsi += "010101";
            else imsi += "235959";
		}else if(date.length() == 6){
            imsi += date.substring(0,4);
            imsi += date.substring(4,6);
            if(ftype.equals("s")) imsi += "01010101";
            else imsi += "31235959";
		}else if(date.length() == 4){
            imsi += date.substring(0,4);
            if(ftype.equals("s")) imsi += "0101010101";
            else imsi += "1231235959";
		}
	   		
		setDate(imsi, type);
    }

    private void setDate(String date, String type){ 
       if(date != null && !date.equals(""))
    	if(type.equals("s")){
             year1 = date.substring(0,4);
             month1 = date.substring(4,6);
             day1 = date.substring(6,8);
             hour1 = date.substring(8,10);
             min1 = date.substring(10,12);
             sec1 = date.substring(12,14);
         }else if(type.equals("e")){
        	 year2 = date.substring(0,4);
             month2 = date.substring(4,6);
             day2 = date.substring(6,8);
             hour2 = date.substring(8,10);
             min2 = date.substring(10,12);
             sec2 = date.substring(12,14);
         }else if(type.equals("s1")){
             year3 = date.substring(0,4);
             month3 = date.substring(4,6);
             day3 = date.substring(6,8);
             hour3 = date.substring(8,10);
             min3 = date.substring(10,12);
             sec3 = date.substring(12,14);
         }else if(type.equals("e1")){
             year4 = date.substring(0,4);
             month4 = date.substring(4,6);
             day4 = date.substring(6,8);
             hour4 = date.substring(8,10);
             min4 = date.substring(10,12);
             sec4 = date.substring(12,14);
         }else if(type.equals("s2")){
             year5 = date.substring(0,4);
             month5 = date.substring(4,6);
             day5 = date.substring(6,8);
             hour5 = date.substring(8,10);
             min5 = date.substring(10,12);
             sec5 = date.substring(12,14);
         }else if(type.equals("e2")){
             year6 = date.substring(0,4);
             month6 = date.substring(4,6);
             day6 = date.substring(6,8);
             hour6 = date.substring(8,10);
             min6 = date.substring(10,12);
             sec6 = date.substring(12,14);
         }else if(type.equals("s3")){
             year7 = date.substring(0,4);
             month7 = date.substring(4,6);
             day7 = date.substring(6,8);
             hour7 = date.substring(8,10);
             min7 = date.substring(10,12);
             sec7 = date.substring(12,14);
         }
         
    }
    
    /**
     * @return Returns the endDt.
     */
    public String getEndDt() {
        return endDt;
    }
    /**
     * @param endDt The endDt to set.
     */
    public void setEndDt(String endDt) {
        this.endDt = endDt;
    }
    /**
     * @return Returns the startDt.
     */
    public String getStartDt() {
        return startDt;
    }
    /**
     * @param startDt The startDt to set.
     */
    public void setStartDt(String startDt) {
        this.startDt = startDt;
    }
    /**
     * @return Returns the day1.
     */
    public String getDay1() {
        return day1;
    }
    /**
     * @param day1 The day1 to set.
     */
    public void setDay1(String day1) {
        this.day1 = day1;
    }
    /**
     * @return Returns the day2.
     */
    public String getDay2() {
        return day2;
    }
    /**
     * @param day2 The day2 to set.
     */
    public void setDay2(String day2) {
        this.day2 = day2;
    }
    /**
     * @return Returns the month1.
     */
    public String getMonth1() {
        return month1;
    }
    /**
     * @param month1 The month1 to set.
     */
    public void setMonth1(String month1) {
        this.month1 = month1;
    }
    /**
     * @return Returns the month2.
     */
    public String getMonth2() {
        return month2;
    }
    /**
     * @param month2 The month2 to set.
     */
    public void setMonth2(String month2) {
        this.month2 = month2;
    }

    /**
     * @return Returns the year1.
     */
    public String getYear1() {
        return year1;
    }
    /**
     * @param year1 The year1 to set.
     */
    public void setYear1(String year1) {
        this.year1 = year1;
    }
    /**
     * @return Returns the year2.
     */
    public String getYear2() {
        return year2;
    }
    /**
     * @param year2 The year2 to set.
     */
    public void setYear2(String year2) {
        this.year2 = year2;
    }
    
    /**
     * @return Returns the hour1.
     */
    public String getHour1() {
        return hour1;
    }
    /**
     * @param hour1 The hour1 to set.
     */
    public void setHour1(String hour1) {
        this.hour1 = hour1;
    }
    /**
     * @return Returns the hour2.
     */
    public String getHour2() {
        return hour2;
    }
    /**
     * @param hour2 The hour2 to set.
     */
    public void setHour2(String hour2) {
        this.hour2 = hour2;
    }
    /**
     * @return Returns the min1.
     */
    public String getMin1() {
        return min1;
    }
    /**
     * @param min1 The min1 to set.
     */
    public void setMin1(String min1) {
        this.min1 = min1;
    }
    /**
     * @return Returns the min2.
     */
    public String getMin2() {
        return min2;
    }
    /**
     * @param min2 The min2 to set.
     */
    public void setMin2(String min2) {
        this.min2 = min2;
    }

    /**
     * @return Returns the sec1.
     */
    public String getSec1() {
        return sec1;
    }
    /**
     * @param sec1 The sec1 to set.
     */
    public void setSec1(String sec1) {
        this.sec1 = sec1;
    }
    /**
     * @return Returns the sec2.
     */
    public String getSec2() {
        return sec2;
    }
    /**
     * @param sec2 The sec2 to set.
     */
    public void setSec2(String sec2) {
        this.sec2 = sec2;
    }
    
	public DateSetter link(Map model) {
		model.put("dateyn", "Y");
		return this;
	}

	public String getYear3() {
		return year3;
	}

	public void setYear3(String year3) {
		this.year3 = year3;
	}

	public String getMonth3() {
		return month3;
	}

	public void setMonth3(String month3) {
		this.month3 = month3;
	}

	public String getDay3() {
		return day3;
	}

	public void setDay3(String day3) {
		this.day3 = day3;
	}

	public String getHour3() {
		return hour3;
	}

	public void setHour3(String hour3) {
		this.hour3 = hour3;
	}

	public String getMin3() {
		return min3;
	}

	public void setMin3(String min3) {
		this.min3 = min3;
	}

	public String getSec3() {
		return sec3;
	}

	public void setSec3(String sec3) {
		this.sec3 = sec3;
	}

	public String getYear4() {
		return year4;
	}

	public void setYear4(String year4) {
		this.year4 = year4;
	}

	public String getMonth4() {
		return month4;
	}

	public void setMonth4(String month4) {
		this.month4 = month4;
	}

	public String getDay4() {
		return day4;
	}

	public void setDay4(String day4) {
		this.day4 = day4;
	}

	public String getHour4() {
		return hour4;
	}

	public void setHour4(String hour4) {
		this.hour4 = hour4;
	}

	public String getMin4() {
		return min4;
	}

	public void setMin4(String min4) {
		this.min4 = min4;
	}

	public String getSec4() {
		return sec4;
	}

	public void setSec4(String sec4) {
		this.sec4 = sec4;
	}

	public String getYear5() {
		return year5;
	}

	public void setYear5(String year5) {
		this.year5 = year5;
	}

	public String getMonth5() {
		return month5;
	}

	public void setMonth5(String month5) {
		this.month5 = month5;
	}

	public String getDay5() {
		return day5;
	}

	public void setDay5(String day5) {
		this.day5 = day5;
	}

	public String getHour5() {
		return hour5;
	}

	public void setHour5(String hour5) {
		this.hour5 = hour5;
	}

	public String getMin5() {
		return min5;
	}

	public void setMin5(String min5) {
		this.min5 = min5;
	}

	public String getSec5() {
		return sec5;
	}

	public void setSec5(String sec5) {
		this.sec5 = sec5;
	}

	public String getYear6() {
		return year6;
	}

	public void setYear6(String year6) {
		this.year6 = year6;
	}

	public String getMonth6() {
		return month6;
	}

	public void setMonth6(String month6) {
		this.month6 = month6;
	}

	public String getDay6() {
		return day6;
	}

	public void setDay6(String day6) {
		this.day6 = day6;
	}

	public String getHour6() {
		return hour6;
	}

	public void setHour6(String hour6) {
		this.hour6 = hour6;
	}

	public String getMin6() {
		return min6;
	}

	public void setMin6(String min6) {
		this.min6 = min6;
	}

	public String getSec6() {
		return sec6;
	}

	public void setSec6(String sec6) {
		this.sec6 = sec6;
	}
	
}
