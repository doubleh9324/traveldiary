<%@page import="wpjsp.service.WriteReplySer"%>
<%@page import="wpjsp.model.Reply"%>
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

	int dnum = Integer.parseInt(request.getParameter("dnum"));
	int userNum = Integer.parseInt(request.getParameter("userNum"));
	String reply = request.getParameter("reply");
	
	Reply Reply = new Reply();
	
	Reply.setDay_num(dnum);
	Reply.setMember_num(userNum);
	Reply.setReply(reply);
	
	WriteReplySer writereplyser = WriteReplySer.getInstance();
	writereplyser.write(Reply);
	
	response.sendRedirect("readDay.jsp?dnum="+dnum+"&userNum="+userNum);
	
%>


</body>
</html>