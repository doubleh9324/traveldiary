package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.DaysDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Days;

public class UpdateDaySer {
	private static UpdateDaySer instance = new UpdateDaySer();
	
	public static UpdateDaySer getInstance(){
		return instance;
	}
	
	private UpdateDaySer() {}
	
	public void update(Days day)
		throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		try{
			DaysDao daysDao = DaysDao.getInstance();
			daysDao.update_day(conn, day);
		} catch (SQLException e) {
			throw new Exception("updateDaySer error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
		
	}
}
