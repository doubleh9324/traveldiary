package wpjsp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Days;

public class DaysDao {
	
private static DaysDao instance = new DaysDao();
	
	public static DaysDao getInstance() {
		return instance;
	}
	private DaysDao() {}

	//새로운 글 작성 시
	public int new_day(Connection conn, Days days) 
		throws SQLException 
	{
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement( 
					"insert into days " +
					"(member_num, day_title, day, diary_volum, day_time, p_code) " +
					"values (?, ?, ?, ?, ?, ?);");
			pstmt.setInt(1, days.getMember_num());
			pstmt.setString(2, days.getDay_title());
			pstmt.setString(3, days.getDay());
			pstmt.setInt(4, days.getDiary_volum());
			pstmt.setDate(5, new java.sql.Date(days.getDay_time().getTime()));
			pstmt.setString(6, days.getP_code());
			
			return pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(pstmt);
		}
	}
	
	//글 수정
	//게시판의 글번호의 작성자랑 멤버가 동일할 때
	public int update_day(Connection conn, Days days) 
			throws SQLException 
		{
			PreparedStatement pstmt = null;

			try {
				pstmt = conn.prepareStatement( 
						"update days set day_title= ?, day= ?, day_time=?, p_code=? "
						+ "where day_num = ?");
				pstmt.setString(1, days.getDay_title());
				pstmt.setString(2, days.getDay());
				pstmt.setDate(3, new java.sql.Date(days.getDay_time().getTime()));
				pstmt.setString(4, days.getP_code());
				pstmt.setInt(5, days.getDay_num());
				
				return pstmt.executeUpdate();
			} finally {
				JdbcUtil.close(pstmt);
			}
		}

	//select했을때 나온 총 튜플의 수
	public int selectCount(Connection conn)
		throws SQLException
	{
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select count(*) from days");
			rs.next();
			return rs.getInt(1);
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}


	//글 목록에 필요한 항목만 줄일 필요가 있어 굳이 내용은 먼저 가져오지 않아도 될 것 같다
	public List<Days> daySelectList(Connection conn, int firstRow, int endRow) 
		throws SQLException 
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(
					"select * from days " + 
					"order by day_num desc limit ?, ?");
			pstmt.setInt(1, firstRow - 1);
			pstmt.setInt(2, endRow - firstRow + 1);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				List<Days> dayList = new ArrayList<Days>();
				do {
					dayList.add(this.makeDayFromResultSet(rs));
				} while (rs.next());
				return dayList;
			} else {
				return Collections.emptyList();
			}
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	//특정 멤버의 글 목록 가져오기
	public List<Days> mdaySelectList(Connection conn, int mnum, int firstRow, int endRow) 
			throws SQLException 
		{
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(
						"select * from days "+
						"where member_num = ? order by day_num desc limit ?, ?");
				pstmt.setInt(1, mnum);
				pstmt.setInt(2, firstRow - 1);
				pstmt.setInt(3, endRow - firstRow + 1);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					List<Days> dayList = new ArrayList<Days>();
					do {
						dayList.add(this.makeDayFromResultSet(rs));
					} while (rs.next());
					return dayList;
				} else {
					return Collections.emptyList();
				}
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
		}
	
	//특정 멤버의 글 selectCount
	public int mselectCount(Connection conn, int mnum)
			throws SQLException
		{
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(
						"select count(*) from days "+
						"where member_num = ?");
				pstmt.setInt(1,  mnum);
				rs = pstmt.executeQuery();
				rs.next();
				return rs.getInt(1);
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
		}
	
	//특정 일기장의 글 selectCount
	public int dselectCount(Connection conn, int mnum, int dvol)
			throws SQLException
		{
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(
						"select count(*) from days "+
						"where member_num = ? and diary_volum = ?");
				pstmt.setInt(1,  mnum);
				pstmt.setInt(2, dvol);
				rs = pstmt.executeQuery();
				rs.next();
				return rs.getInt(1);
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
		}
		
	protected Days makeDayFromResultSet(ResultSet rs)
			throws SQLException
		{
			Days day = new Days();
			day.setDay_num(rs.getInt("day_num"));
			day.setDay_title(rs.getString("day_title"));
			day.setDay(rs.getString("day"));
			day.setMember_num(rs.getInt("member_num"));
			day.setScrap_count(rs.getInt("scrap_count"));
			day.setTime(rs.getTimestamp("time"));
			day.setHits(rs.getInt("hits"));
			day.setDay_time(rs.getTimestamp("day_time"));
			day.setDiary_volum(rs.getInt("diary_volum"));
			day.setP_code(rs.getString("p_code"));
			
			return day;
		}
	
	//특정 일기장의 일기 목록 가져오기
	public List<Days> ddaySelectList(Connection conn, int mnum, int dvol, int firstRow, int endRow) 
			throws SQLException 
		{
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(
						"select * from days "+
						"where member_num = ? and diary_volum = ? order by day_num desc limit ?, ?");
				pstmt.setInt(1, mnum);
				pstmt.setInt(2, dvol);
				pstmt.setInt(3, firstRow - 1);
				pstmt.setInt(4, endRow - firstRow + 1);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					List<Days> dayList = new ArrayList<Days>();
					do {
						dayList.add(this.makeDayFromResultSet(rs));
					} while (rs.next());
					return dayList;
				} else {
					return Collections.emptyList();
				}
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
		}
	
	/*
	protected Scrap makeScrapJnFromResultSet(ResultSet rs)
			throws SQLException
		{
			Scrap scrap = new Scrap();
			scrap.setDay_num(rs.getInt("day_num"));
			scrap.setMember_num(rs.getInt("member_num"));

			return scrap;
		}
*/
	
	//on delete member_num cascade : 따로 글 삭제 필요없음
	
	//게시글 읽기
	public Days read_day(Connection conn, int dayNum)
		throws SQLException
		{
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		Days day = new Days();
		
		try {
			pstmt = conn.prepareStatement(
					"select * from days where day_num = ?;");
			pstmt.setInt(1, dayNum);
			rs = pstmt.executeQuery();
			
			
			if(rs.next())
			{
				 day = makeDayFromResultSet(rs);
			}
				 return day;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		
		}
	
	//글 삭제
	public int delete_day(Connection conn, int dayNum)
		throws SQLException
	{
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(
					"delete from days where day_num = ?");
			pstmt.setInt(1, dayNum);
			return pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(conn);
		}
		
	}
	
	//스크랩 횟수 증가
	public void plusScrapCount(Connection conn, int dayNum)
		throws SQLException
	{
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(
					"update days set scrap_count = scrap_count + 1 "
					+ "where day_num = ?");
			pstmt.setInt(1, dayNum);
			pstmt.executeUpdate();
		} finally {
		}
		
	}
	
	//스크랩 횟수 감소
	
	
	//조회수 증가
	public void plusHitsCount(Connection conn, int dnum, int userNum)
		throws SQLException
	{	
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(
					"update days set hits = hits + 1 "+
					"where day_num = ? and member_num != ?");
			pstmt.setInt(1, dnum);
			pstmt.setInt(2, userNum);
			pstmt.executeUpdate();
		} finally {
		}
	}

}
