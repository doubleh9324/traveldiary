<%@page import="wpjsp.service.ReadJournalService"%>
<%@page import="wpjsp.model.JournalListView"%>
<%@page import="wpjsp.model.Bulletin"%>
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

<%
	int jnum = Integer.parseInt(request.getParameter("jnum"));

	Bulletin journal = new Bulletin();
	
	ReadJournalService readjournal = ReadJournalService.getInstance();
	journal = readjournal.read(jnum);
	
	

	
%>

<form action="modifyJournal2.jsp" method="post">
글번호 : 
<input type="text" value="<%= journal.getJournal_num() %>" name="journal_num" > 
글제목 : 
<input type="text" value="<%= journal.getJournal_title() %>" name="journal_title" >

<textarea name="journal" rows="" cols="">
<%= journal.getJournal() %>
</textarea>

<input type="submit" value="수정하기" >
</form>
</body>
</html>