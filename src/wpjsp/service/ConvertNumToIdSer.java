package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.MemberDao;
import wpjsp.jdbc.JdbcUtil;

public class ConvertNumToIdSer {
	private static ConvertNumToIdSer instance = new ConvertNumToIdSer();

	public static ConvertNumToIdSer getInstance() {
		return instance;
	}

	private ConvertNumToIdSer() {	}

	public String getMemberId(int mnum) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

			
		try {		
			String reId = null;
			MemberDao memberDao = null;
			
			memberDao = MemberDao.getInstnace();
			reId = memberDao.getMemberId(conn, mnum);
				
			return reId;
			
		} catch (SQLException e) {
			throw new Exception("ConvertNumToIdSer" + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
