<%@page import="wpjsp.service.DeleteJournalService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>


<script type="text/javascript">
function closeJn(){
	opener.location.href='Main.jsp';
	window.close();
}

</script>
</head>
<body>


<%
	int jnum = Integer.parseInt(request.getParameter("jnum"));

	DeleteJournalService deletejournal = DeleteJournalService.getInstance();
	deletejournal.deleteJournal(jnum);
	
	
	
%>
삭제 완료
<input type="button" value="확인" onclick="javascript:closeJn()">

</body>
</html>