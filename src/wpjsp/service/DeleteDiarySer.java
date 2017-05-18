package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;

import wpjsp.dao.DaysDao;
import wpjsp.dao.DiaryDao;
import wpjsp.jdbc.JdbcUtil;

public class DeleteDiarySer {
	private static DeleteDiarySer instance = new DeleteDiarySer();

	public static DeleteDiarySer getInstance() {
		return instance;
	}

	private DeleteDiarySer() {	}

	public void deleteDay(int dvol, int mnum) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
		try {		
			DiaryDao diaryDao = DiaryDao.getInstance();
			diaryDao.deletediary(conn, dvol, mnum);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}
