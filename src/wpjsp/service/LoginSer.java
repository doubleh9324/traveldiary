package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.MemberDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Member;

public class LoginSer {
	private static LoginSer instance = new LoginSer();

	public static LoginSer getInstance() {
		return instance;
	}

	private LoginSer() {	}

	public boolean Login(Member member) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		String rs;
			
		try {		
			MemberDao MemberDao = null;
			boolean PW;
			
			MemberDao = wpjsp.dao.MemberDao.getInstnace();
			
			String id = member.getMember_id();
			rs = MemberDao.MemberId_check(conn, id);

			PW = (member.getMember_pw()).equals(rs);
				
			if(PW)
			{	return true;	}
			else
			{	return false;	}

		} catch (SQLException e) {
			throw new Exception("error loginser " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
