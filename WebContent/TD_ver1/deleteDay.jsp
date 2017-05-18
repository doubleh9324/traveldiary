<%@page import="wpjsp.service.DeleteDaySer"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>


<script type="text/javascript">
function closeDay(){
	opener.location.href='Main.jsp';
	window.close();
}

</script>
</head>
<body>


<%
	int dnum = Integer.parseInt(request.getParameter("dnum"));

	DeleteDaySer deleteday = DeleteDaySer.getInstance();
	deleteday.deleteDay(dnum);
	
	
	
%>
삭제 완료
<input type="button" value="확인" onclick="javascript:closeDay()">

</body>
</html>