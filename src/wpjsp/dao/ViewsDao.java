package wpjsp.dao;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.v_diaryProg;

public class ViewsDao {
	
	private static ViewsDao instance = new ViewsDao();
	
	public static ViewsDao getInstance(){
		return instance;
	}
	
	private ViewsDao(){}
	
	//v_diaryProg
	//member_num, member_id, diary_volum, period, progress
	
	public v_diaryProg getprogInfo(Connection conn)
		throws SQLException
	{
		Statement stmt= null;
		ResultSet rs = null;
		
		v_diaryProg progView = new v_diaryProg();
		
		try{
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from v_diaryProg");
			if(rs.next()){
				progView.setMember_num(rs.getInt("membet_num"));
				progView.setMember_id(rs.getString("member_id"));
				progView.setDiary_volum(rs.getInt("diary_volum"));
				progView.setPeriod(rs.getInt("period"));
				progView.setProgress(rs.getInt("progress"));
			}
			
			return progView;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(conn);
		}
		
	}

}
