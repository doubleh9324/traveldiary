package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import wpjsp.dao.DaysDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Days;
import wpjsp.model.DaysView;

public class GetDayListSer {
	private static GetDayListSer instance =	new GetDayListSer();

	public static GetDayListSer getInstance() {
		return instance;
	}

	private GetDayListSer() {}

	private static final int MESSAGE_COUNT_PER_PAGE = 18	;
	
	//일기 목록 가져오기(회원 전체 일기)
	public DaysView getDayList(int pageNumber)
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
			
			DaysDao daysDao =	DaysDao.getInstance();
			int dayTotalCount = daysDao.selectCount(conn);

			List<Days> dayList = null;
			int firstRow = 0;
			int endRow = 0;
			if (dayTotalCount > 0) {
				firstRow = (pageNumber - 1) * MESSAGE_COUNT_PER_PAGE + 1;
				endRow = firstRow + MESSAGE_COUNT_PER_PAGE - 1;
				dayList = daysDao.daySelectList(conn, firstRow, endRow);
			} else {
				currentPageNumber = 0;
				dayList = Collections.emptyList();
			}
			return new DaysView(dayList,
					dayTotalCount, currentPageNumber,
					MESSAGE_COUNT_PER_PAGE, firstRow, endRow);
		} catch (SQLException e) {
			throw new Exception("GetDaysSer error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	//특정 일기장의 일기 목록 가져오기
	public DaysView getDDayList(int pageNumber, int dvol, int mnum) throws Exception
	{
		
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	
		int currentPageNumber = pageNumber;
		try {
			
			DaysDao daysDao =	DaysDao.getInstance();
			int dayTotalCount = daysDao.dselectCount(conn, mnum, dvol);

			List<Days> dayList = null;
			int firstRow = 0;
			int endRow = 0;
			if (dayTotalCount > 0) {
				firstRow = (pageNumber - 1) * MESSAGE_COUNT_PER_PAGE + 1;
				endRow = firstRow + MESSAGE_COUNT_PER_PAGE - 1;
				dayList = daysDao.ddaySelectList(conn, mnum, dvol, firstRow, endRow);
			} else {
				currentPageNumber = 0;
				dayList = Collections.emptyList();
			}
			return new DaysView(dayList,
					dayTotalCount, currentPageNumber,
					MESSAGE_COUNT_PER_PAGE, firstRow, endRow);
		} catch (SQLException e) {
			throw new Exception("GetDaysSer error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
		
	}
}
