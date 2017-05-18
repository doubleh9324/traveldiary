package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.BulletinDao;
import wpjsp.dao.DaysDao;
import wpjsp.dao.ScrapDao;
import wpjsp.jdbc.JdbcUtil;

public class ScrapSer {
	private static ScrapSer instance = new ScrapSer();

	public static ScrapSer getInstance() {
		return instance;
	}

	private ScrapSer() {	}
	
	//새로운 스크랩 실행
	public int scrapDay(int mnum, int dnum) throws Exception{
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
					+"useUnicode=true&characterEncoding=euckr";
			String dbUser = "root";
			String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		int re = 0;
		try {	
			DaysDao daysDao = DaysDao.getInstance();
			daysDao.plusScrapCount(conn, dnum);
			
			ScrapDao scrapdao = ScrapDao.getInstance();
			re = scrapdao.scrap(conn, mnum, dnum);
			
			return re;
		} catch (SQLException e) {
			throw new Exception("error scrapDay" + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	
	public void unscrapDay(int mnum, int[] dnum) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		try {		
			ScrapDao scrapdao = ScrapDao.getInstance();
			scrapdao.unscrap(conn, mnum, dnum);
		} catch (SQLException e) {
			throw new Exception("error unscrapDay" + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
