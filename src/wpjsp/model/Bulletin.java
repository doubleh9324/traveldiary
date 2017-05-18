package wpjsp.model;

import java.util.Date;

//외래키는 클래스에 넣어야하나..?

public class Bulletin {

	private	int member_num;
	private int journal_num;
	private String journal_title;
	private String journal;
	private int scrap_count;
	private Date time;
	private int hits;


	//글을 작성한 회원번호. 
	public int getMember_snum() {
		return member_num;
	}

	public void setMember_snum(int num) {	//서비스에서 등록시 호출할때 회원 번호 같이 넘겨주는걸로하자
		this.member_num = num;
	}


	//글 번호
	public int getJournal_num() {
		return journal_num;
	}

	public void setJournal_num(int num) {
		this.journal_num = num;
	}

	//글 제목
	public String getJournal_title() {
		return journal_title;
	}

	public void setJournal_title(String jour_title) {
		this.journal_title = jour_title;
	}

	//글
	public String getJournal() {
		return journal;
	}

	public void setJournal(String jour) {
		this.journal = jour;
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
	
	//조회수
	public void setHits(int hits){
		this.hits = hits;
	}
	
	public int getHits(){
		return this.hits;
	}
}
