package wpjsp.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import wpjsp.dao.ViewsDao;
import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.v_diaryProg;

public class GetViewSer {
	
	private static GetViewSer instance = new GetViewSer();
	
	public static GetViewSer getInstance()
	{
		return instance;
	}
	
	private GetViewSer(){}
	
	//다이어리 완성도 점검
	/*view v_diaryProg
	 * member_num, member_id, diary_volum, period, progress
	 */
	
	private v_diaryProg progView;
	
	//progView 받아오기
	//private 전환 ???
	public void getprogView() throws Exception{
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/test?"
				+"useUnicode=true&characterEncoding=euckr";
		String dbUser = "root";
		String dbPass = "121524";
		Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		try {
			ViewsDao viewsdao = ViewsDao.getInstance();
			progView = viewsdao.getprogInfo(conn);
		} catch (SQLException e){
			throw new Exception ("getviewser" + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	public double getdiaryProg(int mnum, int dvol) throws Exception{
		for(int i=0; )
	}
	
	

}
