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
import wpjsp.model.Diary;

public class DiaryDao {
	private static DiaryDao instance = new DiaryDao();
		
		public static DiaryDao getInstance() {
			return instance;
		}
		private DiaryDao() {}
	
		//새로운 일기 작성 시
		public int new_diary(Connection conn, Diary diary) 
			throws SQLException 
		{
			PreparedStatement pstmt = null;
			int vCount;
			try {
				vCount = vCount(conn, diary.getMember_num())+1;
				pstmt = conn.prepareStatement( 
						"insert into diary " +
						"(member_num, diary_volum, diary_title, start_day, end_day, location_code, p_code, diary_cover) " +
						"values (?, ?, ?, ?, ?, ?, ?, ?);");
				pstmt.setInt(1, diary.getMember_num());
				pstmt.setInt(2, vCount);
				pstmt.setString(3, diary.getDiary_title());
				pstmt.setDate(4,new java.sql.Date(diary.getStart_day().getTime()));
				pstmt.setDate(5,new java.sql.Date(diary.getEnd_day().getTime()));
				pstmt.setString(6, diary.getLocation());
				
				if(diary.getCover()!=null)
					pstmt.setString(8, diary.getCover());
				else{
					pstmt.setString(8, "default.jpg");
				}
				pstmt.setString(7, diary.getP_code());
				
				pstmt.executeUpdate();
				
				return vCount;
			} finally {
				JdbcUtil.close(pstmt);
			}
		}
		
		//회원당 일기장 갯수 카운트
		public int vCount(Connection conn, int mnum) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try{
				pstmt = conn.prepareStatement("select max(diary_volum) from diary "
						+ "where member_num = ?");
				pstmt.setInt(1, mnum);
				rs = pstmt.executeQuery();
				rs.next();
				return rs.getInt(1);
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
		}
		
		public int selectCount(Connection conn) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				pstmt = conn.prepareStatement("select count(*) from diary ");
				rs=pstmt.executeQuery();
				rs.next();
				return rs.getInt(1);
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
		}
		
		public int selectmCount(Connection conn, int mnum) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				pstmt = conn.prepareStatement("select count(*) from diary " +
						"where member_num = ?");
				pstmt.setInt(1, mnum);
				rs=pstmt.executeQuery();
				rs.next();
				return rs.getInt(1);
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
		}
		
		public List<Diary> diarySelectList(Connection conn, int firstRow, int endRow)
			throws SQLException
		{
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(
						"select * from diary " + 
						"order by diary_volum desc limit ?, ?");
				pstmt.setInt(1, firstRow - 1);
				pstmt.setInt(2, endRow - firstRow + 1);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					List<Diary> diaryList = new ArrayList<Diary>();
					do {
						diaryList.add(this.makeDiaryFromResultSet(rs));
					} while (rs.next());

					return diaryList;
				} else {
					return Collections.emptyList();
				}
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
		}
		
		public List<Diary> mdiarySelectList(Connection conn, int mnum, int firstRow, int endRow)
				throws SQLException
			{
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try {
					pstmt = conn.prepareStatement(
							"select * from diary " + 
							"where member_num = ? " +
							"order by diary_volum desc limit ?, ?");
					pstmt.setInt(1,  mnum);
					pstmt.setInt(2, firstRow - 1);
					pstmt.setInt(3, endRow - firstRow + 1);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						List<Diary> diaryList = new ArrayList<Diary>();
						do {
							diaryList.add(this.makeDiaryFromResultSet(rs));
						} while (rs.next());

						return diaryList;
					} else {
						return Collections.emptyList();
					}
				} finally {
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
				}
			}
		
		protected Diary makeDiaryFromResultSet(ResultSet rs)
				throws SQLException
			{
				Diary diary = new Diary();
				diary.setMember_num(rs.getInt("member_num"));
				diary.setDiary_volum(rs.getInt("diary_volum"));
				diary.setDiary_title(rs.getString("diary_title"));
				diary.setDate(rs.getTimestamp("time"));
				diary.setStart_day(rs.getTimestamp("start_day"));
				diary.setEnd_day(rs.getTimestamp("end_day"));
				diary.setLocation(rs.getString("location_code"));
				diary.setCover(rs.getString("diary_cover"));
				diary.setP_code(rs.getString("p_code"));

				return diary;
			}
		
		public Diary diaryInfo(Connection conn, int dvol, int mnum) throws SQLException {
				
			Diary diary = new Diary();
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				pstmt = conn.prepareStatement("select * from diary "+
						"where diary_volum = ? and member_num = ?");
				pstmt.setInt(1, dvol);
				pstmt.setInt(2, mnum);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					diary = makeDiaryFromResultSet(rs);
				}
				return diary;
			} finally {
				JdbcUtil.close(conn);
			}
		}
		
		public String dpInfo(Connection conn, int dnum) throws SQLException {
			
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			String dpcode= null;
			
			try {
				pstmt = conn.prepareStatement("select a.p_code "
						+ "from diary a inner join days b "
						+ "where b.day_num = ? and a.diary_volum=b.diary_volum "
						+ "and a.member_num = b.member_num;");
				pstmt.setInt(1, dnum);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					dpcode = rs.getString("p_code");
				}
				return dpcode;
			} finally {
				JdbcUtil.close(conn);
			}
		}
		
		public void deletediary(Connection conn, int dvol, int mnum) throws SQLException {
			PreparedStatement pstmt = null;
			
			try{
				pstmt = conn.prepareStatement("delete from diary "
						+ "where member_num = ? and diary_volum = ?");
				pstmt.setInt(1, mnum);
				pstmt.setInt(2, dvol);
				
				pstmt.executeUpdate();
			} finally {
				JdbcUtil.close(conn);
			}
		}
		
		public double progress(Connection conn, int dvol, int mnum) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			double pg;
			try {
				pstmt = conn.prepareStatement("select percent from v_progress "
						+ "where member_num = ? and diary_volum = ?");
				pstmt.setInt(1, mnum);
				pstmt.setInt(2, dvol);
				rs = pstmt.executeQuery();
				
				if(!rs.next())
					pg = 0;
				else
					pg = rs.getDouble(1);
				return pg;
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(conn);
			}
		}
		

}
