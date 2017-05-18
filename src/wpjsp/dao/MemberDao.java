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
import wpjsp.model.Member;

public class MemberDao {

	private static MemberDao instance = new MemberDao();
	
	public static MemberDao getInstnace() {
		return instance;
	}
	private MemberDao() {}

	//db에 새로운 member insert
	public int Member_insert(Connection conn, Member member) 
		throws SQLException 
	{
		PreparedStatement pstmt = null;
		int mCount;

		try {
			mCount = mCount(conn) + 1;
			pstmt = conn.prepareStatement( 
					"insert into member " +
					"(member_name, member_id, member_pw, member_pwinfo, member_pwan, member_email, member_num) values (?, ?, ?, ?, ?, ?, ?);");
			pstmt.setString(1, member.getMember_name());
			pstmt.setString(2, member.getMember_id());
			pstmt.setString(3, member.getMember_pw());
			pstmt.setString(4, member.getMember_pwinfo());
			pstmt.setString(5, member.getMember_pwan());
			pstmt.setString(6, member.getMember_email());
			pstmt.setInt(7, mCount);
			
			return pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(pstmt);
		}
	}
	
	public int mCount(Connection conn) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement("select max(member_num) from member");
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	
	//회원정보 수정 후 업데이트
	public int Member_update(Connection conn, Member member) 
			throws SQLException 
		{
			PreparedStatement pstmt = null;

			try {
				if(member.getMember_pw() != null){
					pstmt = conn.prepareStatement( 
							"update member set member_pw = ?, member_pwinfo = ?, member_pwan = ?, member_email = ? where member_num = ? ");
					pstmt.setString(1, member.getMember_pw());
					pstmt.setString(2, member.getMember_pwinfo());
					pstmt.setString(3, member.getMember_pwan());
					pstmt.setString(4, member.getMember_email());
					pstmt.setInt(5, member.getMember_num());
				}
				else{
					pstmt = conn.prepareStatement( 
							"update member set member_pwinfo = ?, member_pwan = ?, member_email = ? where member_num = ? ");
					pstmt.setString(1, member.getMember_pwinfo());
					pstmt.setString(2, member.getMember_pwan());
					pstmt.setString(3, member.getMember_email());
					pstmt.setInt(4, member.getMember_num());
				}
				return pstmt.executeUpdate();
			} finally {
				JdbcUtil.close(pstmt); 
			}
		}
	
//������ �޼��� ���̵�� ���� ��� �о���� �޼ҵ�. ���� �� ����� �ۼ��� ��� �� ��ƺ���� �ٲ���
//ȸ�� ���̵�(�� ��ȣ�� �����ؼ� �޾ƿ�)�� ������ ��ȣ�� ���� ��ϵ� ��� �ۼ��� �������� _ ���� Ŭ������ �ű���
/*
	public Member select(Connection conn, int messageId)
		throws SQLException
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement("select * from member where member_num = ?");
			pstmt.setInt(1, messageId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return makeMessageFromResultSet(rs);
			} else {
				return null;
			}
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	*/

	//���� �޼ҵ忡�� select ������ rs�� ����� �� ���� �޼ҵ�
	/*
	protected Message makeMessageFromResultSet(ResultSet rs)
		throws SQLException
	{
		Message message = new Message();
		message.setId(rs.getInt("message_id"));
		message.setGuestName(rs.getString("guest_name"));
		message.setPassword(rs.getString("password"));
		message.setMessage(rs.getString("message"));
		return message;
	}
*/

	//������ select������ ���� �� Ʃ���� ��
	/*
	public int selectCount(Connection conn)
		throws SQLException
	{
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select count(*) from guestbook_message");
			rs.next();
			return rs.getInt(1);
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}
	*/

	//���̰� ���ϴ°��� �� �𸣰ڴ�.
	/*
	public List<Message> selectList(Connection conn, int firstRow, int endRow) 
		throws SQLException 
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(
					"select * from guestbook_message " + 
					"order by message_id desc limit ?, ?");
			pstmt.setInt(1, firstRow - 1);
			pstmt.setInt(2, endRow - firstRow + 1);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				List<Message> messageList = new ArrayList<Message>();
				do {
					messageList.add(this.makeMessageFromResultSet(rs));
				} while (rs.next());
				return messageList;
			} else {
				return Collections.emptyList();
			}
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
*/
	
	//회원 탈퇴 시 member 튜플 삭제
	public int deleteMember(Connection conn, int memberNum)
		throws SQLException
	{
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(
					"delete from member where member_num = ?");
			pstmt.setInt(1, memberNum);
			return pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(pstmt);
		}
	}



//ID & PW 일치여부 확인
public String MemberId_check(Connection conn, String id)
		throws SQLException
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String res = null;

		//특정 id값을 가진 member를 찾기
		try {
			pstmt = conn.prepareStatement(
					"select * from member where member_id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				res = rs.getString("member_pw");

		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		return res;
	}



//특정 id를가진 member 정보를 불러오기
public Member MemberInfo(Connection conn, String userId)
		throws SQLException
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Member Remem = new Member();
		try {
			pstmt = conn.prepareStatement(
					"select * from member where member_id = ?");
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				 Remem.setMember_num(rs.getInt("member_num"));
				 Remem.setMember_id(rs.getString("member_id"));
				 Remem.setMember_name(rs.getString("member_name"));
				 Remem.setMember_pw(rs.getString("member_pw"));
				 Remem.setMember_pwinfo(rs.getString("member_pwinfo"));
				 Remem.setMember_pwan(rs.getString("member_pwan"));
				 Remem.setMember_email(rs.getString("member_email"));
			}
			return Remem;

		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}

//회원 번호를 받아서 ID 넘겨주기
public String getMemberId(Connection conn, int num) throws SQLException
	{
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String reId = null;
	
	try {
		pstmt = conn.prepareStatement(
				"select member_id from member where member_num = ?");
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			 reId = rs.getString("member_id");
		}
		return reId;

	} finally {
		JdbcUtil.close(rs);
		JdbcUtil.close(pstmt);
	}
	}
}


