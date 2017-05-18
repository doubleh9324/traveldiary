<%@page import="wpjsp.model.JournalListView"%>
<%@page import="wpjsp.service.GetJournalListService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
	String pageNumberString = request.getParameter("p");
	int pageNumber = 1;
	
	if(pageNumberString != null &&  pageNumberString.length()>0){
		pageNumber = Integer.parseInt(pageNumberString);
	}
	
	GetJournalListService journalListService = GetJournalListService.getInstance();
	JournalListView viewData = journalListService.getJournalList(pageNumber);
	
	

%>

</body>
</html>