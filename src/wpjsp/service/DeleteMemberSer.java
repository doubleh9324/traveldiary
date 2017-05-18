package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.MemberDao;
import wpjsp.jdbc.JdbcUtil;

public class DeleteMemberSer {
	private static DeleteMemberSer instance = new DeleteMemberSer();

	public static DeleteMemberSer getInstance() {
		return instance;
	}

	private DeleteMemberSer() {	}

	public void deleteMember(int mnum) 
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
			MemberDao.deleteMember(conn, mnum);
			
		} catch (SQLException e) {
			throw new Exception("DeleteMemberInfoSer error " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}
