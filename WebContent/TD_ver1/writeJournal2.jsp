<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="wpjsp.model.Bulletin" %>
<%@ page import="wpjsp.model.Member" %>
<%@ page import="wpjsp.service.WriteJournalService" %>
<%@ page import="wpjsp.service.GetMemberInfoService" %>

<%
	request.setCharacterEncoding("euc-kr");
%>

<jsp:useBean id="journal" class="wpjsp.model.Bulletin"  scope="session"/>
<jsp:setProperty name = "journal" property = "*" />
	

<% 
	String userId = (String)session.getAttribute("USERID");
	Member memberInfo = null;
	
	int userNum;
	
	GetMemberInfoService getmemberInfo = GetMemberInfoService.getInstance();
	memberInfo = getmemberInfo.getMemberInfo(userId);

	userNum = memberInfo.getMember_num();
	
	journal.setMember_snum(userNum);
	

	WriteJournalService JournalService = WriteJournalService.getInstance();
	JournalService.write(journal);
	
%>
<html>
<head>
	<title>새 이야기 남김</title>
</head>


<body>
새로운글을 남겼습니다.
<br/>
<a href="Main.jsp">[목록 보기]</a>
</body>
</html>