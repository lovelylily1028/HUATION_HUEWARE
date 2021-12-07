package com.huation.common.recruit;

import com.huation.framework.util.StringUtil;

public class DefaultDTO{

	protected String  type = "";
	protected String  apply_code = "";
	protected String  email = "";
	protected String  passwd = "";
	protected String  user_nm = "";
	protected String  national_gb = "";
	protected String  jumin_no = "";
	protected String  recruit_no ="";
	protected String  career = "";
	protected String  c_year = "";
	long wish_sal = 0;
	long current_sal = 0;
	protected String  position = "";
	protected String  recruit_field = "";
	protected String  creed = "";
	protected String  h_user_nm = "";
	protected String  e_user_nm = "";
	protected String  english_nm = "";
	protected String  nationality = "";
	protected String  hand_phone = "";
	protected String  home_phone = "";
	protected String  etc_phone = "";
	protected String  rriage_yn = "";
	protected String  birth_day = "";
	protected String  military = "";
	protected String  exemption = "";
	protected String  photo = "";
	protected String  j_post = "";
	protected String  j_address = "";
	protected String  j_addr_detail = "";
	protected String  c_post = "";
	protected String  c_address = "";
	protected String  c_addr_detail = "";
	protected String  veterans_yn = "";
	protected String  veterans_no = "";
	protected String  disabled_yn = "";
	protected String  disabled_grade = "";
	protected String  apply_state = "";
	protected String  result_state = "";
	
	protected String searchGb;
	protected String searchtxt;
	
	protected String mod_id;

	public String getMod_id() {
		return mod_id;
	}
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
	public String getSearchGb() {
		return searchGb;
	}
	public void setSearchGb(String searchGb) {
		this.searchGb = searchGb;
	}
	public String getSearchtxt() {
		return searchtxt;
	}
	public void setSearchtxt(String searchtxt) {
		this.searchtxt = searchtxt;
	}
	public String getApply_state() {
		return apply_state;
	}
	public void setApply_state(String apply_state) {
		this.apply_state = apply_state;
	}
	public String getResult_state() {
		return result_state;
	}
	public void setResult_state(String result_state) {
		this.result_state = result_state;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getC_year() {
		return c_year;
	}
	public void setC_year(String c_year) {
		this.c_year = c_year;
	}
	public String getApply_code() {
		return apply_code;
	}
	public void setApply_code(String apply_code) {
		this.apply_code = apply_code;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getNational_gb() {
		return national_gb;
	}
	public void setNational_gb(String national_gb) {
		this.national_gb = national_gb;
	}
	public String getJumin_no() {
		return jumin_no;
	}
	public void setJumin_no(String jumin_no) {
		this.jumin_no = jumin_no;
	}
	public String getRecruit_no() {
		return recruit_no;
	}
	public void setRecruit_no(String recruit_no) {
		this.recruit_no = recruit_no;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	public long getWish_sal() {
		return wish_sal;
	}
	public void setWish_sal(long wish_sal) {
		this.wish_sal = wish_sal;
	}
	public long getCurrent_sal() {
		return current_sal;
	}
	public void setCurrent_sal(long current_sal) {
		this.current_sal = current_sal;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getRecruit_field() {
		return recruit_field;
	}
	public void setRecruit_field(String recruit_field) {
		this.recruit_field = recruit_field;
	}
	public String getCreed() {
		return creed;
	}
	public void setCreed(String creed) {
		this.creed = creed;
	}
	public String getH_user_nm() {
		return h_user_nm;
	}
	public void setH_user_nm(String h_user_nm) {
		this.h_user_nm = h_user_nm;
	}
	public String getE_user_nm() {
		return e_user_nm;
	}
	public void setE_user_nm(String e_user_nm) {
		this.e_user_nm = e_user_nm;
	}
	public String getEnglish_nm() {
		return english_nm;
	}
	public void setEnglish_nm(String english_nm) {
		this.english_nm = english_nm;
	}
	public String getNationality() {
		return nationality;
	}
	public void setNationality(String nationality) {
		this.nationality = nationality;
	}
	public String getHand_phone() {
		return hand_phone;
	}
	public void setHand_phone(String hand_phone) {
		this.hand_phone = hand_phone;
	}
	public String getHome_phone() {
		return home_phone;
	}
	public void setHome_phone(String home_phone) {
		this.home_phone = home_phone;
	}
	public String getEtc_phone() {
		return etc_phone;
	}
	public void setEtc_phone(String etc_phone) {
		this.etc_phone = etc_phone;
	}
	public String getRriage_yn() {
		return rriage_yn;
	}
	public void setRriage_yn(String rriage_yn) {
		this.rriage_yn = rriage_yn;
	}
	public String getBirth_day() {
		return birth_day;
	}
	public void setBirth_day(String birth_day) {
		this.birth_day = birth_day;
	}
	public String getMilitary() {
		return military;
	}
	public void setMilitary(String military) {
		this.military = military;
	}
	public String getExemption() {
		return exemption;
	}
	public void setExemption(String exemption) {
		this.exemption = exemption;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getJ_post() {
		return j_post;
	}
	public void setJ_post(String j_post) {
		this.j_post = j_post;
	}
	public String getJ_address() {
		return j_address;
	}
	public void setJ_address(String j_address) {
		this.j_address = j_address;
	}
	public String getJ_addr_detail() {
		return j_addr_detail;
	}
	public void setJ_addr_detail(String j_addr_detail) {
		this.j_addr_detail = j_addr_detail;
	}
	public String getC_post() {
		return c_post;
	}
	public void setC_post(String c_post) {
		this.c_post = c_post;
	}
	public String getC_address() {
		return c_address;
	}
	public void setC_address(String c_address) {
		this.c_address = c_address;
	}
	public String getC_addr_detail() {
		return c_addr_detail;
	}
	public void setC_addr_detail(String c_addr_detail) {
		this.c_addr_detail = c_addr_detail;
	}
	public String getVeterans_yn() {
		return veterans_yn;
	}
	public void setVeterans_yn(String veterans_yn) {
		this.veterans_yn = veterans_yn;
	}
	public String getVeterans_no() {
		return veterans_no;
	}
	public void setVeterans_no(String veterans_no) {
		this.veterans_no = veterans_no;
	}
	public String getDisabled_yn() {
		return disabled_yn;
	}
	public void setDisabled_yn(String disabled_yn) {
		this.disabled_yn = disabled_yn;
	}
	public String getDisabled_grade() {
		return disabled_grade;
	}
	public void setDisabled_grade(String disabled_grade) {
		this.disabled_grade = disabled_grade;
	}
	
	
}
