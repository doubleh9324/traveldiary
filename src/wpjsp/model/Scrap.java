package wpjsp.model;

import java.util.Date;

public class Scrap {
	
	private int member_num;
	private int journal_num;
	private Date scrap_date;

	public void setMember_num(int num){
		this.member_num = num;
	}
	
	public int getMember_num(){
		return this.member_num;
	}
	
	public void setJournal_num(int num){
		this.journal_num = num;
	}
	
	public int getJournal_num(){
		return this.journal_num;
	}
	
	public void setScrap_date(Date date){
		this.scrap_date = date;
	}
	
	public Date getScrap_date(){
		return this.scrap_date;
	}
	
}
