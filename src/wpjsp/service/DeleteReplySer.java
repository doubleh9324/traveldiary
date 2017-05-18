package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;

import wpjsp.dao.ReplyDao;
import wpjsp.jdbc.JdbcUtil;

public class DeleteReplySer {
	private static DeleteReplySer instance = new DeleteReplySer();

	public static DeleteReplySer getInstance() {
		return instance;
	}

	private DeleteReplySer() {	}

	public void deleteReply(int mnum, int dnum, int renum) 
		throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
		try {		
			ReplyDao replydao = ReplyDao.getInstnace();
			replydao.delete_reply(conn, mnum, dnum, renum);
		} finally {
			JdbcUtil.close(conn);
		}
	}

}
