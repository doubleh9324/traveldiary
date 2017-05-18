package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;

import wpjsp.dao.DaysDao;
import wpjsp.jdbc.JdbcUtil;

public class DeleteDaySer {
	private static DeleteDaySer instance = new DeleteDaySer();

	public static DeleteDaySer getInstance() {
		return instance;
	}

	private DeleteDaySer() {	}

	public void deleteDay(int dnum) 
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
			daysDao.delete_day(conn, dnum);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}
