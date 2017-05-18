package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.MemberDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Member;

public class JoinSer {
	private static JoinSer instance = new JoinSer();

	public static JoinSer getInstance() {
		return instance;
	}

	private JoinSer() {	}
	
	//ID 중복확인
	public boolean Check_join(String id) throws Exception{
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
					+"useUnicode=true&characterEncoding=euckr";
			String dbUser = "root";
			String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		String rs = null;
		
		//정보가 타당한지 확인할 것
		//duple값이 true이면 중복 값 존재
		try {		
			MemberDao MemberDao = null;
			boolean duple=false;
			
			MemberDao = wpjsp.dao.MemberDao.getInstnace();
			rs = MemberDao.MemberId_check(conn, id);

			//memberId_check 리턴값이 해당 아이디의 pw
			//pw가 존재하지 않으면 id도 존재하지 않음
			if (rs != null)
				duple = true;
			
			return duple;
		} catch (SQLException e) {
			throw new Exception("error checkjoin " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
		
	}

	public void Join(Member member) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		//member 정보 받아서 dao로 넘겨주기
		try {
			MemberDao MemberDao = null;
			
			MemberDao = wpjsp.dao.MemberDao.getInstnace();
			MemberDao.Member_insert(conn, member);
			
		} catch (SQLException e) {
			throw new Exception("error join " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	

}
