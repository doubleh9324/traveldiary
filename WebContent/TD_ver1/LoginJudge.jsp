<%@page import="wpjsp.service.LoginSer"%>
<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import = "java.net.URLDecoder"%>
<%@ page import = "java.sql.SQLException" %>

<%@ page import="wpjsp.model.Member" %>
<%@ page import="java.sql.*" %>


<%
	request.setCharacterEncoding("euc-kr");
%>

<jsp:useBean id="member" class="wpjsp.model.Member" scope="session" />
<jsp:setProperty name="member" property="*" />

<html>
<body>

<% 
	session.setAttribute("USERID", member.getMember_id());
	session.setAttribute("page_code", "main");

	boolean rs;

	LoginSer loginservice = LoginSer.getInstance();
	rs = loginservice.Login(member);
	
	if(!rs)//���߿� �յڹٲٱ�
	{	out.println("<script>alert('ID&PW�� Ȯ�����ּ���.'); history.back(-1); </script>");	}
	else
	{	
%>
	<script language = "javascript">
	window.alert("�α��� �Ǿ����ϴ�")</script>
<% 	 
	response.sendRedirect("Main_design.jsp");	}
%>
	









</body>
</html>
