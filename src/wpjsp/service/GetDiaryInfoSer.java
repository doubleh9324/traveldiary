package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.DiaryDao;
import wpjsp.dao.MemberDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Diary;
import wpjsp.model.Member;

public class GetDiaryInfoSer {
	private static GetDiaryInfoSer instance = new GetDiaryInfoSer();

	public static GetDiaryInfoSer getInstance() {
		return instance;
	}

	private GetDiaryInfoSer() {	}
	
	public Diary getDiaryInfo(int dvol, int userNum) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

			
		try {		
			
			DiaryDao diarydao = DiaryDao.getInstance();
			Diary diary = new Diary();
			diary = diarydao.diaryInfo(conn, dvol, userNum);
			
			return diary;
			
		} catch (SQLException e) {
			throw new Exception("getmemberinfoser " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	public String getDiarypcode(int dnum) 
			throws Exception 
		{
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
					+"useUnicode=true&characterEncoding=euckr";
			String dbUser = "root";
			String dbPass = "121524";
			Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

				
			try {		
				
				DiaryDao diarydao = DiaryDao.getInstance();
				String dpcode = diarydao.dpInfo(conn, dnum);
				
				return dpcode;
				
			} catch (SQLException e) {
				throw new Exception("getmemberinfoser " + e.getMessage(), e);
			} finally {
				JdbcUtil.close(conn);
			}
		}
	
	public double getprogress(int dvol, int mnum) throws Exception{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		try {
			DiaryDao diaryprog = DiaryDao.getInstance();
			
			return  diaryprog.progress(conn, dvol, mnum);
		} catch (SQLException e) {
			throw new Exception("getmemberinfoser " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
			

}
