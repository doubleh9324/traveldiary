package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.ReplyDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Reply;

public class UpdateReplySer {
private static UpdateReplySer instance = new UpdateReplySer();
	
	public static UpdateReplySer getInstance(){
		return instance;
	}
	
	private UpdateReplySer() {}
	
	public void update(Reply reply)
		throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		try{
			ReplyDao replydao = ReplyDao.getInstnace();
			replydao.update_reply(conn, reply);
		} catch (SQLException e) {
			throw new Exception("updateReplySer error : " + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
		
	}
}
