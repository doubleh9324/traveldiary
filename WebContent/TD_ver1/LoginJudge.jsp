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
	
	if(!rs)//나중에 앞뒤바꾸기
	{	out.println("<script>alert('ID&PW를 확인해주세요.'); history.back(-1); </script>");	}
	else
	{	
%>
	<script language = "javascript">
	window.alert("로그인 되었습니다")</script>
<% 	 
	response.sendRedirect("Main_design.jsp");	}
%>
	









</body>
</html>
