package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.MemberDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Member;

public class UpdateMemberInfoSer {
	private static UpdateMemberInfoSer instance = new UpdateMemberInfoSer();

	public static UpdateMemberInfoSer getInstance() {
		return instance;
	}

	private UpdateMemberInfoSer() {	}

	public void UpdateMemberInfo(Member member) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
		try {		
			MemberDao MemberDao = null;
			
			MemberDao = wpjsp.dao.MemberDao.getInstnace();
			MemberDao.Member_update(conn, member);
			
		} catch (SQLException e) {
			throw new Exception("UpdateMemberInfoSer error " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}
