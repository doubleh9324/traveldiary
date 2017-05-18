package wpjsp.model;

public class Member {

	private int member_num;
	private String member_name;
	private String member_id;
	private String member_pw;
	private String member_pwinfo;
	private String member_pwan;
	private String member_email;
	
	//회원 번호
	public int getMember_num() {
		return member_num;
	}

	public void setMember_num(int num) {
		this.member_num = num;
	}


	//회원 아이디
	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String id) {
		this.member_id = id;
	}

	//회원 이름
	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String name) {
		this.member_name = name;
	}

	//회원 비밀번호
	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String password) {
		this.member_pw = password;
	}

	//회원 비밀번호 정보
	public String getMember_pwinfo() {
		return member_pwinfo;
	}

	public void setMember_pwinfo(String pwinfo) {
		this.member_pwinfo = pwinfo;
	}
	
	//회원 비밀번호 답
	public String getMember_pwan() {
		return member_pwan;
	}

	public void setMember_pwan(String pwan) {
		this.member_pwan = pwan;
	}
	
	//회원 이메일 주소
	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String email) {
		this.member_email = email;
	}
}
