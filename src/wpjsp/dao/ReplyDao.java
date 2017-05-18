package wpjsp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import wpjsp.jdbc.JdbcUtil;
import wpjsp.model.Reply;

public class ReplyDao {
private static ReplyDao instance = new ReplyDao();
	
	public static ReplyDao getInstnace() {
		return instance;
	}
	private ReplyDao() {}
	
	//새 댓글 달기
	public int newReply(Connection conn, Reply reply) 
			throws SQLException {
		PreparedStatement pstmt = null;
		java.util.Date utildate = new java.util.Date();
		int renum = 0;
		
		try{
			renum = renumCount(conn, reply.getDay_num())+1;
			
			pstmt = conn.prepareStatement("insert into reply "+
					"(reply, day_num, member_num, time, reply_num) "+
					"values(?, ?, ?, ?, ?)");
			pstmt.setString(1, reply.getReply());
			pstmt.setInt(2, reply.getDay_num());
			pstmt.setInt(3, reply.getMember_num());
			pstmt.setTimestamp(4, new java.sql.Timestamp(utildate.getTime()));
			pstmt.setInt(5, renum);
			
			return pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(conn);
		}
		
	}
	
	//해당하는 jnum의 댓글들 가져오기
		public List<Reply> replySelectList(Connection conn, int dnum, int firstRow, int endRow)
				throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try{
				pstmt = conn.prepareStatement("select * from reply "+
						"where day_num = ? order by time asc limit ?,?");
				pstmt.setInt(1, dnum);
				pstmt.setInt(2, firstRow-1);
				pstmt.setInt(3, endRow-firstRow +1);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					List<Reply> replyList = new ArrayList<Reply>();
					do{
						replyList.add(this.makeReplyFromResultSet(rs));
					}while (rs.next());
					return replyList;
				} else {
					return Collections.emptyList();
				}
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(conn);
			}
			
		}
		
		protected Reply makeReplyFromResultSet (ResultSet rs)
				throws SQLException
			{
				Reply reply = new Reply();
				reply.setDay_num(rs.getInt("day_num"));
				reply.setMember_num(rs.getInt("member_num"));
				reply.setReply(rs.getString("reply"));
				reply.setTime(rs.getTimestamp("time"));
				reply.setReply_num(rs.getInt("reply_num"));
				
				return reply;
			}
	
	
	//댓글 삭제하기
	public void delete_reply(Connection conn, int mnum, int dnum, int renum)
			throws SQLException {
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement("delete from reply "+
					"where member_num = ? and day_num = ? and reply_num = ?");
			pstmt.setInt(1, mnum);
			pstmt.setInt(2, dnum);
			pstmt.setInt(3, renum);
			
			pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	//댓글 수정하기
	public int update_reply(Connection conn, Reply reply)
			throws SQLException{
		PreparedStatement pstmt = null;
		
		try{
			pstmt = conn.prepareStatement("update reply set " +
					"reply = ? " +
					"where reply_num =? and day_num = ? ");
			pstmt.setString(1, reply.getReply());
			pstmt.setInt(2, reply.getReply_num());
			pstmt.setInt(3, reply.getDay_num());
			return pstmt.executeUpdate();
					
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	//댓글 갯수 세기
	public int rselectCount(Connection conn, int dnum)
			throws SQLException
		{
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try{
				pstmt = conn.prepareStatement("select count(*) from reply "+
						"where day_num = ? ");
				pstmt.setInt(1, dnum);
				rs = pstmt.executeQuery();
				rs.next();
				return rs.getInt(1);
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
		}
	
	public int renumCount(Connection conn, int dnum)
			throws SQLException
		{
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try{
				pstmt = conn.prepareStatement("select max(reply_num) "+
							"from reply where day_num = ?");
				pstmt.setInt(1, dnum);
				rs = pstmt.executeQuery();
				rs.next();
				return rs.getInt(1);
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
		}

	public Reply getReply(Connection conn, int dnum, int renum) throws SQLException
		{
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Reply reply = new Reply();
			
			try{
				pstmt = conn.prepareStatement("select * from reply "+
							"where day_num = ? and reply_num = ?");
				pstmt.setInt(1, dnum);
				pstmt.setInt(2, renum);
				rs = pstmt.executeQuery();
			
				if(rs.next()){
					
					reply = this.makeReplyFromResultSet(rs);
				}
				return reply;
					
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(conn);
			}
		}
	
	public int[][] getReplyCount(Connection conn) throws SQLException
		{
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int[][] dnum_recount;
			
			try{
				pstmt = conn.prepareStatement("select day_num, count(*) as recount "
						+ "from reply group by day_num ");
				rs = pstmt.executeQuery();
				
				rs.last();
				int row = rs.getRow();
				dnum_recount = new int[row][2];
				rs.beforeFirst();
				
				for(int i=0; i<row; i++){
						rs.next();
						dnum_recount[i][0] = rs.getInt("day_num");
						dnum_recount[i][1] = rs.getInt("recount");
				}
				return dnum_recount;
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(conn);
			}
		}
		
}
