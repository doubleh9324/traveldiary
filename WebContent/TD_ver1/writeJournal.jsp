<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="wpjsp.model.Bulletin" %>
<%@ page import="wpjsp.service.WriteJournalService" %>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
	<title>�� �̾߱� ����</title>
</head>

<body>


<form action = "writeJournal2.jsp" method = "post">
������  <input type="text" name="journal_title" size="20"><br>

�۳���
<textarea rows="" cols="" name="journal"></textarea>

<input type="submit" value="�ۼ�">

</form>


<!-- ������� ���ư��� �ۼ��� ������ ������ ��ҿ��� Ȯ�ιޱ� -->
<a href="Main.jsp">[��� ����]</a>
</body>
</html>