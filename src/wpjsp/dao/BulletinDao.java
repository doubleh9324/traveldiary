package wpjsp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.List;
import java.util.ArrayList;
import java.util.Collections;

import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Bulletin;

//Bulletin 테이블 데이터 접근
public class BulletinDao {

	private static BulletinDao instance = new BulletinDao();
	
	public static BulletinDao getInstnace() {
		return instance;
	}
	private BulletinDao() {}

	//새로운 글 작성 시
	public int New_journal(Connection conn, Bulletin bulletin) 
		throws SQLException 
	{
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement( 
					"insert into bulletin " +
					"(member_num, journal_title, journal, scrap_count) values (?, ?, ?, ?);");
			pstmt.setInt(1, bulletin.getMember_snum());
			pstmt.setString(2, bulletin.getJournal_title());
			pstmt.setString(3, bulletin.getJournal());
			pstmt.setInt(4, bulletin.getScrap_count());
			
			return pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(pstmt);
		}
	}
	
	//글 수정
	//게시판의 글번호의 작성자랑 멤버가 동일할 때
	public int Journal_update(Connection conn, Bulletin bulletin) 
			throws SQLException 
		{
			PreparedStatement pstmt = null;

			try {
				pstmt = conn.prepareStatement( 
						"update bulletin set journal_title= ?, journal= ? where journal_num = ?");
				pstmt.setString(1, bulletin.getJournal_title());
				pstmt.setString(2, bulletin.getJournal());
				pstmt.setInt(3, bulletin.getJournal_num());
				
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
			rs = stmt.executeQuery("select count(*) from bulletin");
			rs.next();
			return rs.getInt(1);
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}


	//글 목록에 필요한 항목만 줄일 필요가 있어 굳이 내용은 먼저 가져오지 않아도 될 것 같다
	public List<Bulletin> journalSelectList(Connection conn, int firstRow, int endRow) 
		throws SQLException 
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(
					"select * from bulletin " + 
					"order by journal_num desc limit ?, ?");
			pstmt.setInt(1, firstRow - 1);
			pstmt.setInt(2, endRow - firstRow + 1);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				List<Bulletin> journalList = new ArrayList<Bulletin>();
				do {
					journalList.add(this.makeJournalFromResultSet(rs));
				} while (rs.next());
				return journalList;
			} else {
				return Collections.emptyList();
			}
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	//특정 멤버의 글 목록 가져오기
	public List<Bulletin> mjournalSelectList(Connection conn, int idnum, int firstRow, int endRow) 
			throws SQLException 
		{
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(
						"select * from bulletin "+
						"where member_num = ? order by journal_num desc limit ?, ?");
				pstmt.setInt(1, idnum);
				pstmt.setInt(2, firstRow - 1);
				pstmt.setInt(3, endRow - firstRow + 1);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					List<Bulletin> journalList = new ArrayList<Bulletin>();
					do {
						journalList.add(this.makeJournalFromResultSet(rs));
					} while (rs.next());
					return journalList;
				} else {
					return Collections.emptyList();
				}
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
		}
	
	//특정 멤버의 글 selectCount
	public int mselectCount(Connection conn, int idnum)
			throws SQLException
		{
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(
						"select count(*) from bulletin "+
						"where member_num = ?");
				pstmt.setInt(1,  idnum);
				rs = pstmt.executeQuery();
				rs.next();
				return rs.getInt(1);
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
		}
		
	protected Bulletin makeJournalFromResultSet(ResultSet rs)
			throws SQLException
		{
			Bulletin journal = new Bulletin();
			journal.setJournal_num(rs.getInt("journal_num"));
			journal.setJournal_title(rs.getString("journal_title"));
			journal.setJournal(rs.getString("journal"));
			journal.setMember_snum(rs.getInt("member_num"));
			journal.setScrap_count(rs.getInt("scrap_count"));
			journal.setTime(rs.getTimestamp("time"));
			journal.setHits(rs.getInt("hits"));

			return journal;
		}
	
	/*
	protected Scrap makeScrapJnFromResultSet(ResultSet rs)
			throws SQLException
		{
			Scrap scrap = new Scrap();
			scrap.setJournal_num(rs.getInt("journal_num"));
			scrap.setMember_num(rs.getInt("member_num"));

			return scrap;
		}
*/
	
	//on delete member_num cascade : 따로 글 삭제 필요없음
	
	//게시글 읽기
	public Bulletin readJournal(Connection conn, int journalNum)
		throws SQLException
		{
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		Bulletin journal = new Bulletin();
		
		try {
			pstmt = conn.prepareStatement(
					"select * from bulletin where journal_num = ?;");
			pstmt.setInt(1, journalNum);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				 journal.setJournal_num(rs.getInt("journal_num"));
				 journal.setJournal_title(rs.getString("journal_title"));
				 journal.setJournal(rs.getString("journal"));
				 journal.setMember_snum(rs.getInt("member_num"));
				 journal.setScrap_count(rs.getInt("scrap_count"));
				 journal.setTime(rs.getTimestamp("time"));
				 journal.setHits(rs.getInt("hits"));
			}
				 return journal;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		
		}
	
	//글 삭제
	public int deleteJournal(Connection conn, int journalNum)
		throws SQLException
	{
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(
					"delete from bulletin where journal_num = ?");
			pstmt.setInt(1, journalNum);
			return pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(conn);
		}
		
	}
	
	//스크랩 횟수 증가
	public void plusScrapCount(Connection conn, int journalNum)
		throws SQLException
	{
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(
					"update bulletin set scrap_count = scrap_count + 1 "
					+ "where journal_num = ?");
			pstmt.setInt(1, journalNum);
			pstmt.executeUpdate();
		} finally {
		}
		
	}
	
	//스크랩 횟수 감소
	
	
	//조회수 증가
	public void plusHitsCount(Connection conn, int journalNum)
		throws SQLException
	{	
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement(
					"update bulletin set hits = hits + 1 "+
					"where journal_num = ?");
			pstmt.setInt(1, journalNum);
			pstmt.executeUpdate();
		} finally {
		}
	}
}
	
	
	

