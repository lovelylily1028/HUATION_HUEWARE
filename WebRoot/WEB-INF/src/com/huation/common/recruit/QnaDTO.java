package com.huation.common.recruit;

import com.huation.framework.util.StringUtil;

public class QnaDTO {
	
	protected String qna_no;
	protected String qna_gb;
	protected String question;
	protected String answer;
	protected String subject;
	protected String email;
	protected String qna_file;
	protected String reg_id;
	protected String reg_dt;
	protected String mod_id;
	protected String mod_dt;
	
	protected String searchGb;
	protected String searchtxt;
	
	
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
	public String getQna_no() {
		return qna_no;
	}
	public void setQna_no(String qna_no) {
		this.qna_no = qna_no;
	}
	public String getQna_gb() {
		return qna_gb;
	}
	public void setQna_gb(String qna_gb) {
		this.qna_gb = qna_gb;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getQna_file() {
		return qna_file;
	}
	public void setQna_file(String qna_file) {
		this.qna_file = qna_file;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getMod_id() {
		return mod_id;
	}
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
	public String getMod_dt() {
		return mod_dt;
	}
	public void setMod_dt(String mod_dt) {
		this.mod_dt = mod_dt;
	}
	
	
}
