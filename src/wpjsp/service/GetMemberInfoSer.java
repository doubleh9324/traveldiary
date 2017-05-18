package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.MemberDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Member;

public class GetMemberInfoSer {
	private static GetMemberInfoSer instance = new GetMemberInfoSer();

	public static GetMemberInfoSer getInstance() {
		return instance;
	}

	private GetMemberInfoSer() {	}

	public Member getMemberInfo(String userid) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

			
		try {		
			MemberDao memberDao = null;
			Member memberInfo = null;
			
			memberDao = wpjsp.dao.MemberDao.getInstnace();
			memberInfo = memberDao.MemberInfo(conn, userid);
			
			return memberInfo;
			
		} catch (SQLException e) {
			throw new Exception("getmemberinfoser " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
