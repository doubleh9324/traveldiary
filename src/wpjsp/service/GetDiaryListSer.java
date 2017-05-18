package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import wpjsp.dao.BulletinDao;
import wpjsp.dao.DaysDao;
import wpjsp.dao.DiaryDao;
import wpjsp.dao.ReplyDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Diary;
import wpjsp.model.DiaryListView;

public class GetDiaryListSer {
	private static GetDiaryListSer instance = new GetDiaryListSer();

	public static GetDiaryListSer getInstance() {
		return instance;
	}

	private GetDiaryListSer() {	}
	
private static final int DIARY_COUNT_PER_PAGE = 9;
private static final int mDIARY_COUNT_PER_PAGE = 30;
	
	//전체 일기장 목록 불러오기
	public DiaryListView getDiaryList(int pageNumber)
			throws Exception
	{
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
					+"useUnicode=true&characterEncoding=euckr";
			String dbUser = "root";
			String dbPass = "121524";
			Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		int currentPageNumber = pageNumber;
		try {
			
			
			DiaryDao diaryDao = DiaryDao.getInstance();
			int diaryTotalCount = diaryDao.selectCount(conn);
			
			List<Diary> diaryList = null;
			int firstRow = 0;
			int endRow = 0;
			
			if (diaryTotalCount > 0) {
				firstRow = (pageNumber - 1) * DIARY_COUNT_PER_PAGE + 1;
				endRow = firstRow + DIARY_COUNT_PER_PAGE - 1;
				diaryList = diaryDao.diarySelectList(conn, firstRow, endRow);
				
			} else {
				currentPageNumber = 0;
				diaryList = Collections.emptyList();
			}
			return new DiaryListView(diaryList,
					diaryTotalCount, currentPageNumber,
					DIARY_COUNT_PER_PAGE, firstRow, endRow);
		} catch (SQLException e) {
			throw new Exception("GetDiaryListService error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	public DiaryListView getmDiaryList(int pageNumber, int mnum)
			throws Exception
	{
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
					+"useUnicode=true&characterEncoding=euckr";
			String dbUser = "root";
			String dbPass = "121524";
			Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		int currentPageNumber = pageNumber;
		try {
			
			
			DiaryDao diaryDao = DiaryDao.getInstance();
			int diaryTotalCount = diaryDao.selectmCount(conn, mnum);
			
			List<Diary> diaryList = null;
			int firstRow = 0;
			int endRow = 0;
			
			if (diaryTotalCount > 0) {
				firstRow = (pageNumber - 1) * mDIARY_COUNT_PER_PAGE + 1;
				endRow = firstRow + mDIARY_COUNT_PER_PAGE - 1;
				diaryList = diaryDao.mdiarySelectList(conn, mnum, firstRow, endRow);
				
			} else {
				currentPageNumber = 0;
				diaryList = Collections.emptyList();
			}
			return new DiaryListView(diaryList,
					diaryTotalCount, currentPageNumber,
					mDIARY_COUNT_PER_PAGE, firstRow, endRow);
		} catch (SQLException e) {
			throw new Exception("GetDiaryListService error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
