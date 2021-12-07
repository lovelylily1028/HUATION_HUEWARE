package com.baroservice.ws;

public class SMSSendMessagesByPaging {

	private int CurrentPage;
	private int MaxIndex;
	private int CountPerPage;
	private int MaxPageNum;
	private SMSMessage[] SMSmessage;
	
	public int getCurrentPage() {
		return CurrentPage;
	}
	public void setCurrentPage(int currentPage) {
		CurrentPage = currentPage;
	}
	public int getMaxIndex() {
		return MaxIndex;
	}
	public void setMaxIndex(int maxIndex) {
		MaxIndex = maxIndex;
	}
	public int getCountPerPage() {
		return CountPerPage;
	}
	public void setCountPerPage(int countPerPage) {
		CountPerPage = countPerPage;
	}
	public int getMaxPageNum() {
		return MaxPageNum;
	}
	public void setMaxPageNum(int maxPageNum) {
		MaxPageNum = maxPageNum;
	}
	public SMSMessage[] getSMSmessage() {
		return SMSmessage;
	}
	public SMSMessage getSMSmessage(int i) {
		return SMSmessage[i];
	}
	public void setSMSmessage(SMSMessage[] sMSmessage) {
		SMSmessage = sMSmessage;
	}	
	
}
