package wpjsp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Bulletin;
import wpjsp.model.Days;

public class ScrapDao {
	
private static ScrapDao instance = new ScrapDao();
	
	public static ScrapDao getInstance() {
		return instance;
	}
	private ScrapDao() {}
	
	public boolean checkScrap(Connection conn, int mum, int dnum) 
			throws SQLException
		{
			PreparedStatement pstmt = null;	
			ResultSet rs = null;
			
			try{
				pstmt = conn.prepareStatement(
						"select * from scrap where member_num = ? and day_num = ?");
				pstmt.setInt(1, mum);
				pstmt.setInt(2, dnum);
				rs = pstmt.executeQuery();
				
				return rs.next();
			} finally {
				JdbcUtil.close(pstmt);
			}
		}
	
	public int scrap(Connection conn, int memNum, int jourNum) 
			throws SQLException 
		{
			PreparedStatement pstmt = null;
			boolean duple = false;
			
			
			try {
				//duple값이 false이면 중복없음
				duple = checkScrap(conn, memNum, jourNum);
				
				if(duple)
					return -1;
				
				pstmt = conn.prepareStatement( 
						"insert into scrap " +
						"(member_num, day_num) values (?, ?);");
				pstmt.setInt(1, memNum);
				pstmt.setInt(2, jourNum);
				
				return pstmt.executeUpdate();
				
			} finally {
				JdbcUtil.close(pstmt);
			}
		}
	
	public int unscrap(Connection conn, int mnum, int[] dnum)
		throws SQLException{
		PreparedStatement pstmt = null;
		int count =0;
		try{
			for(int i=0; i<dnum.length; i++){
				pstmt = conn.prepareStatement(
						"delete from scrap where member_num = ? and day_num = ?");
				pstmt.setInt(1, mnum);
				pstmt.setInt(2, dnum[i]);
				pstmt.executeUpdate();
				count++;
			}
			//몇개의 스크랩을 해제했는가 리턴
			return count;
		} finally {
			JdbcUtil.close(pstmt);
		}
	}
	
	//특정 멤버의 스크랩 글 목록 가져오기
			//스크랩 시간 순서대로 정렬해야함
			public List<Days> scrapSelectList(Connection conn, int mnum, int firstRow, int endRow) 
					throws SQLException 
				{
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						pstmt = conn.prepareStatement(
								"select * from days "+
								"where day_num in "+
								"(select day_num from scrap where member_num = ? ) " +
								"order by day_num desc limit ?, ?");
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

					return day;
				}
			
			//스크랩한 글 갯수
			public int sselectCount(Connection conn, int mnum)
					throws SQLException
				{
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						pstmt = conn.prepareStatement(
								"select count(*) from days "+
								"where day_num in "+
								"(select day_num from scrap where member_num = ? ) " );
						pstmt.setInt(1,  mnum);
						rs = pstmt.executeQuery();
						rs.next();
						return rs.getInt(1);
					} finally {
						JdbcUtil.close(rs);
						JdbcUtil.close(pstmt);
					}
				}
}
