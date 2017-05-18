<%@page import="wpjsp.service.UpdateJournalService"%>
<%@page import="wpjsp.model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<jsp:useBean id="member" class="wpjsp.model.Member" scope="session"/>
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
	
	UpdateJournalService updatejournal = UpdateJournalService.getInstance();
	updatejournal.update(journal);

%>
수정완료

<input type="button" value="확인" 
onclick="javascript:window.location='readJournal.jsp?jnum=<%= journal.getJournal_num() %>&mnum=<%= userNum %>'">

</body>
</html>