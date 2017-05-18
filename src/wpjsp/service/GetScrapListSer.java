package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import wpjsp.dao.ScrapDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Bulletin;
import wpjsp.model.Days;
import wpjsp.model.DaysView;
import wpjsp.model.JournalListView;

public class GetScrapListSer {
	private static GetScrapListSer instance =	new GetScrapListSer();

	public static GetScrapListSer getInstance() {
		return instance;
	}

	private GetScrapListSer() {}

	private static final int MESSAGE_COUNT_PER_PAGE = 10	;
	
	//개인 스크랩 목록 가져오기
	public DaysView getScrapList(int pageNumber, int mnum)
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
			
			ScrapDao scrapDao =	ScrapDao.getInstance();
			int dayTotalCount = scrapDao.sselectCount(conn, mnum);

			List<Days> dayList = null;
			int firstRow = 0;
			int endRow = 0;
			if (dayTotalCount > 0) {
				firstRow = (pageNumber - 1) * MESSAGE_COUNT_PER_PAGE + 1;
				endRow = firstRow + MESSAGE_COUNT_PER_PAGE - 1;
				dayList = scrapDao.scrapSelectList(conn, mnum,firstRow, endRow);
			} else {
				currentPageNumber = 0;
				dayList = Collections.emptyList();
			}
			return new DaysView(dayList,
					dayTotalCount, currentPageNumber,
					MESSAGE_COUNT_PER_PAGE, firstRow, endRow);
		} catch (SQLException e) {
			throw new Exception("GetScrapListService error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}
