<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="wpjsp.model.Bulletin" %>
<%@ page import="wpjsp.service.WriteJournalService" %>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
	<title>새 이야기 남김</title>
</head>

<body>


<form action = "writeJournal2.jsp" method = "post">
글제목  <input type="text" name="journal_title" size="20"><br>

글내용
<textarea rows="" cols="" name="journal"></textarea>

<input type="submit" value="작성">

</form>


<!-- 목록으로 돌아갈때 작성한 내용이 있으면 취소여부 확인받기 -->
<a href="Main.jsp">[목록 보기]</a>
</body>
</html>