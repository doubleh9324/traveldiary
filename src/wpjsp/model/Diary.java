package wpjsp.model;

import java.util.Date;

public class Diary {
	
	private int member_num;
	private int diary_volum;
	private String diary_title;
	private Date time;
	private Date start_day;
	private Date end_day;
	private String location;
	private String cover;
	private String p_code;

	
	
	public void setMember_num(int mnum){
		this.member_num = mnum;
	}
	
	public int getMember_num(){
		return this.member_num;
	}
	
	public void setDiary_volum(int dvol){
		this.diary_volum = dvol;
	}
	
	public int getDiary_volum(){
		return this.diary_volum;
	}
	
	public void setDiary_title(String title){
		this.diary_title = title;
	}
	
	public String getDiary_title(){
		return this.diary_title;
	}
	
	public void setDate(Date time){
		this.time = time;
	}
	
	public Date getDate(){
		return this.time;
	}
	
	public void setStart_day(Date sday){
		this.start_day = sday;
	}
	
	public Date getStart_day(){
		return this.start_day;
	}
	
	public void setEnd_day(Date eday){
		this.end_day = eday;
	}
	
	public Date getEnd_day(){
		return this.end_day;
	}
	
	public void setLocation(String loc){
		this.location = loc;
	}
	
	public String getLocation(){
		return this.location;
	}
	
	public void setCover(String cov){
		this.cover = cov;
	}
	
	public String getCover(){
		return this.cover;
	}
	
	public void setP_code(String pcode){
		this.p_code = pcode;
	}
	
	public String getP_code(){
		return this.p_code;
	}
}
