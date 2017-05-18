package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.DaysDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Days;

public class ReadDaySer {
	private static ReadDaySer instance = new ReadDaySer();

	public static ReadDaySer getInstance() {
		return instance;
	}

	private ReadDaySer() {	}

	public Days read(int dnum, int userNum) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
		
		try {		
			
			DaysDao daysDao = DaysDao.getInstance();
			daysDao.plusHitsCount(conn, dnum, userNum);
			Days day = new Days();
			day = daysDao.read_day(conn, dnum);
			
			return day;
			
			
		} catch (SQLException e) {
			throw new Exception("ReadDaySer error: " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
			
		}
		

}

}
