package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import wpjsp.dao.DaysDao;
import wpjsp.dao.ReplyDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Days;
import wpjsp.model.Reply;
import wpjsp.model.ReplyListView;

public class GetReplyListSer {
	
	private static GetReplyListSer instance =	new GetReplyListSer();

	public static GetReplyListSer getInstance() {
		return instance;
	}

	private GetReplyListSer() {}

	private static final int MESSAGE_COUNT_PER_PAGE = 10	;
	
	//댓글 목록 가져오기
	public ReplyListView getReplyList(int pageNumber, int dnum)
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
				ReplyDao replyDao = ReplyDao.getInstnace();
				int replyTotalCount = replyDao.rselectCount(conn, dnum);
				
				List<Reply> replyList = null;
				int firstRow = 0;
				int endRow = 0;
				if(replyTotalCount > 0){
					firstRow = (pageNumber - 1) * MESSAGE_COUNT_PER_PAGE + 1;
					endRow = firstRow + MESSAGE_COUNT_PER_PAGE - 1;
					replyList = replyDao.replySelectList(conn, dnum,firstRow, endRow);
				} else {
					currentPageNumber = 0;
					replyList = Collections.emptyList();
				}
				return new ReplyListView(replyList,
						replyTotalCount, currentPageNumber,
						MESSAGE_COUNT_PER_PAGE, firstRow, endRow);
			} catch (SQLException e) {
				throw new Exception("GetReplyListService error : " + e.getMessage(), e);
			} finally {
				JdbcUtil.close(conn);
			}	
	}
	
	public Reply getReply(int dnum, int renum)
			throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		try{
			ReplyDao replyDao = ReplyDao.getInstnace();
			
			Reply reply = new Reply();
			reply = replyDao.getReply(conn, dnum, renum);
			return reply;
		} catch (SQLException e) {
			throw new Exception("GetReplyListService error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}	

	}
	
	public int[][] getReplyCount() throws Exception{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		int[][] dnum_reCount ;
		
		try{
			DaysDao daysDao = DaysDao.getInstance();
			int dnum = daysDao.selectCount(conn);
			dnum_reCount = new int[dnum][2];
			
			ReplyDao replyDao = ReplyDao.getInstnace();
			dnum_reCount = replyDao.getReplyCount(conn);
			return dnum_reCount;
		} catch (SQLException e) {
			throw new Exception("GetReplyListService error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}	
	}

}
