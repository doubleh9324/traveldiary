<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import = "java.net.URLDecoder"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "wpjsp.service.GetJournalListService" %>
<%@ page import = "wpjsp.service.GetMemberInfoService" %>
<%@ page import = "wpjsp.service.ReadJournalService" %>
<%@ page import = "wpjsp.model.JournalListView" %>
<%@ page import = "wpjsp.model.Bulletin"%>
<%@ page import = "wpjsp.model.Member"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "wpjsp.dao.BulletinDao"%>
<%@ page import = "wpjsp.model.Bulletin"%>
<%@ page import = "wpjsp.jdbc.JdbcUtil"%>


<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
<title>Main</title>

<script type="text/javascript">
function logout(){
	var result = window.confirm('����?');
	
	if(result){
		window.location='Logout.jsp';
	}else{}
	
}

function scrap(memNum, jourNum){
	window.open("scrap.jsp?memNum="+memNum+"&jourNum="+jourNum,"", "width=200 height=200")
}

function deleteJn(jnum){
	var result = window.confirm('���ش�?');
	
	if(result){
		window.open("deleteJournal.jsp?jnum="+jnum, "", "width=200 height=200")
	}else{}
	
	
}
</script>
</head>
 <body>
 <jsp:useBean id="member" class="wpjsp.model.Member" scope="session" />
 <!-- member ��ü�� �Ѱܿ� ���� �޾Ƽ� ��� set -->
<jsp:setProperty name="member" property="*" />


<!-- �ۼ����� ��� ����, ���� ��� �߰� -->
<% 
	
	
	Bulletin journal = new Bulletin();
	int jnum;
	int mnum;
	
	jnum = Integer.parseInt(request.getParameter("jnum"));
	mnum = Integer.parseInt(request.getParameter("mnum"));
	
	ReadJournalService readjournalservice = ReadJournalService.getInstance();
	journal = readjournalservice.read(jnum);
	
	
%>


(<%= mnum %>) �� �ӿ�? / 
�ۼ��� ��ȣ
<%= journal.getMember_snum() %>


<DIV>
<TABLE class=__se_tbl style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; COLOR: ; BORDER-LEFT: medium none" cellSpacing=0 cellPadding=0 border=0 _nWidth="547" _nHeight="244" _se2_tbl_template="14">
<TBODY>
<TR>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 57px; BACKGROUND-COLOR: #6284ab">
<P align=center><STRONG><SPAN style="FONT-FAMILY: ����,gulim">&nbsp;<%= journal.getJournal_num() %></SPAN></STRONG></P></TD>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 487px; BACKGROUND-COLOR: #6284ab" colSpan=3>
<P align=center><STRONG><SPAN style="FONT-FAMILY: ����,gulim">&nbsp;<%= journal.getJournal_title() %></SPAN></STRONG></P></TD></TR>
<TR>
<TD style="BORDER-TOP: medium none; HEIGHT: 213px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 544px; BACKGROUND-COLOR: #ffffff" colSpan=4>
<P style="TEXT-ALIGN: center" align=center><STRONG><SPAN style="FONT-FAMILY: ����,gulim">&nbsp;<%= journal.getJournal() %></SPAN></STRONG></P></TD></TR></TBODY></TABLE>
<P></P></TD><TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 45px; BACKGROUND-COLOR: #f6f8fa">
<P>&nbsp;</P></TD><TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 34px; BACKGROUND-COLOR: #f6f8fa" colSpan="2"></TD></TR></TD><TD style="BORDER-TOP: medium none; HEIGHT: 37px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 45px; BACKGROUND-COLOR: #ffffff">
<P>&nbsp;</P></TD><TD style="BORDER-TOP: medium none; HEIGHT: 37px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 34px; BACKGROUND-COLOR: #ffffff" colSpan="2"></TD></TR></TBODY></TABLE></DIV>

<input type="button" value="��ũ��" onclick="javascript:window.scrap(<%= mnum %>, <%= journal.getJournal_num() %>)">
<!-- ��� �����ֱ� -->
<jsp:include page="replylist.jsp" flush="false" >
	<jsp:param name = "jnum" value = "<%= jnum %>" />
	<jsp:param name = "mnum" value = "<%= mnum %>" />
</jsp:include>

<!-- ��� �ۼ��ϱ� -->

<form action="writereply.jsp" id="writeReply" name="writeReply" method="post">
<input type="hidden" name="jnum" value="<%= jnum %>" >
<input type="hidden" name="mnum" value="<%= mnum %>" >
<input type="text" name="reply" >
<input type="submit" value="���">
</form>	


<form name="form" method="post">

<% if(journal.getMember_snum() == mnum){ %>
<input type="button" value="����" onclick="javascript:window.location='modifyJournal.jsp?jnum=<%=jnum%>'">
<input type="button" value="����" onclick="javascript:deleteJn(<%=jnum%>)">
<% } else {}%>





<input type="button" value="���ο� �̾߱�" onclick="javascript:window.location='writeJournal.jsp?jnum=<%=jnum%>'">

<input type="button" value="�α׾ƿ�" onclick="javascript:logout()">

<input type="button" value="��������" onclick="javascript:window.location='modifyForm.jsp'">

<input type="button" value="Main" onclick="javascript:window.location='Main.jsp'">



</form>



</body>
</html>
