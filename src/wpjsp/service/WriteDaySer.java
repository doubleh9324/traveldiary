package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.DaysDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Days;

public class WriteDaySer {
	private static WriteDaySer instance = new WriteDaySer();

	public static WriteDaySer getInstance() {
		return instance;
	}

	private WriteDaySer() {	}

	public void write(Days day) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
		try {		
			
			DaysDao dayDao = DaysDao.getInstance();
			dayDao.new_day(conn, day);
			
		} catch (SQLException e) {
			throw new Exception("writeDayService error: " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
