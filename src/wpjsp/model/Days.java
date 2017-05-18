package wpjsp.model;

import java.util.Date;

public class Days {

	private	int member_num;
	private int diary_volum;
	private int day_num;
	private String day_title;
	private String day;
	private int scrap_count;
	private Date time;
	private int hits;
	private Date day_time;
	private String p_code;


	//글을 작성한 회원번호. 
	public int getMember_num() {
		return member_num;
	}

	public void setMember_num(int num) {	//서비스에서 등록시 호출할때 회원 번호 같이 넘겨주는걸로하자
		this.member_num = num;
	}
	
	//일기장 번호
	public void setDiary_volum(int dvol){
		this.diary_volum = dvol;
	}
	
	public int getDiary_volum(){
		return this.diary_volum;
	}

	//글 번호
	public int getDay_num() {
		return day_num;
	}

	public void setDay_num(int dnum) {
		this.day_num = dnum;
	}

	//글 제목
	public String getDay_title() {
		return day_title;
	}

	public void setDay_title(String dtitle) {
		this.day_title = dtitle;
	}

	//글
	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	
	//스크랩한 회원수
	public int getScrap_count() {
		return scrap_count;
	}

	
	public void setScrap_count(int scount) {
		this.scrap_count = scount;
	}

	//글 작성한 시간
	public void setTime(Date time){
		this.time = time;
		
	}
	
	public Date getTime(){
		return this.time;
	}
	
	//여행 날짜
	public void setDay_time(Date dtime){
		this.day_time = dtime;
	}
	
	public Date getDay_time(){
		return this.day_time;
	}
	
	//조회수
	public void setHits(int hits){
		this.hits = hits;
	}
	
	public int getHits(){
		return this.hits;
	}
	
	public void setP_code(String pcode){
		this.p_code = pcode;
	}
	
	public String getP_code(){
		return this.p_code;
	}
}
