package com.huation.common.recruit;

import com.huation.framework.util.StringUtil;

public class TrainDTO{

	protected String  apply_code = "";
	protected String  history_code = "";
	protected String  start_ymd = "";
	protected String  end_ymd = "";
	protected String  stay_natinal = "";
	protected String  stay_object = "";
	protected String  major_activety = "";
	
	public String getApply_code() {
		return apply_code;
	}
	public void setApply_code(String apply_code) {
		this.apply_code = apply_code;
	}
	public String getHistory_code() {
		return history_code;
	}
	public void setHistory_code(String history_code) {
		this.history_code = history_code;
	}
	public String getStart_ymd() {
		return start_ymd;
	}
	public void setStart_ymd(String start_ymd) {
		this.start_ymd = start_ymd;
	}
	public String getEnd_ymd() {
		return end_ymd;
	}
	public void setEnd_ymd(String end_ymd) {
		this.end_ymd = end_ymd;
	}
	public String getStay_natinal() {
		return stay_natinal;
	}
	public void setStay_natinal(String stay_natinal) {
		this.stay_natinal = stay_natinal;
	}
	public String getStay_object() {
		return stay_object;
	}
	public void setStay_object(String stay_object) {
		this.stay_object = stay_object;
	}
	public String getMajor_activety() {
		return major_activety;
	}
	public void setMajor_activety(String major_activety) {
		this.major_activety = major_activety;
	}
}
