package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.BulletinDao;
import wpjsp.dao.DiaryDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Bulletin;
import wpjsp.model.Diary;

public class WriteDiarySer {
	private static WriteDiarySer instance = new WriteDiarySer();

	public static WriteDiarySer getInstance() {
		return instance;
	}

	private WriteDiarySer() {	}

	public int write(Diary diary) 
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
			int dvol = diaryDao.new_diary(conn, diary);
			return dvol;
		} catch (SQLException e) {
			throw new Exception("writeDiaryService error: " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
