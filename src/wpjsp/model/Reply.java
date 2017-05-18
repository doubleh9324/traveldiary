package wpjsp.model;

import java.util.Date;

public class Reply {
	
	private String reply;
	private int day_reply;
	private int member_num;
	private Date time;
	private int reply_num;
	
	public void setReply(String reply){
		this.reply = reply;
	}
	
	public String getReply(){
		return this.reply;
	}
	
	public void setDay_num(int num){
		this.day_reply = num;
	}
	
	public int getDay_num(){
		return this.day_reply;
	}
	
	public void setMember_num(int num){
		this.member_num = num;
	}
	
	public int getMember_num(){
		return this.member_num;
	}
	
	public void setTime(Date time){
		this.time = time;
	}
	
	public Date getTime(){
		return this.time;
	}
	
	public void setReply_num(int renum){
		this.reply_num = renum;
	}

	public int getReply_num(){
		return this.reply_num;
	}
}
