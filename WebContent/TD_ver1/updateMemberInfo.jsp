<%@page import="wpjsp.service.UpdateMemberInfoSer"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="wpjsp.model.Member"%>
<%@ page import="java.sql.*"%>



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

<jsp:useBean id="modmem" class="wpjsp.model.Member" scope="session" />
<jsp:setProperty name="modmem" property="*" />


<%= modmem.getMember_name() %> ��  <br>
ID : <%= modmem.getMember_id() %> <br>
EMAIl : <%= modmem.getMember_email() %> <br>
��й�ȣ ã�� ���� : <%= modmem.getMember_pwinfo() %> <br>
��й�ȣ ã�� �亯 : <%= modmem.getMember_pwan() %> <br>

<input type = "button" value = "Ȯ��" onclick = "window.close()" >

<% 
//�޾ƿ� ���� DB�� ����
UpdateMemberInfoSer updatememberinfo = UpdateMemberInfoSer.getInstance();	
updatememberinfo.UpdateMemberInfo(modmem);


%>



</body>
</html>


</body>
</html>