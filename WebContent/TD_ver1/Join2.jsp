<%@page import="wpjsp.service.JoinSer"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="wpjsp.model.Member"%>
<%@ page import="java.sql.*"%>



<%
	request.setCharacterEncoding("euc-kr");
%>

<jsp:useBean id="member" class="wpjsp.model.Member" scope="session" />

<html>
<head>
<title>Traval Diary</title>

<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<link href="css/style.css" rel="stylesheet"> 

</head>
<body>
<jsp:setProperty name="member" property="*" />

<!-- start : page - join -->

	<!-- start : Container -->
	<div id="about" class="container color black ppagebox">
	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>	
		<!-- end : navigation -->
	
			<!-- start : Wrapper -->
			<div class="wrapper span12">
			
			<!-- start : Page Title -->
			<div id="page-title">
				<div id="page-title-inner">
				<h2><span>Join Us</span></h2>
				</div>				
			</div>
			<!-- end : Page Title -->
			
<%

	out.println("<script>alert('가입이 완료되었습니다.'); </script>");
	
	//받아온 정보 DB에 저장
//	JoinService joinservice = JoinService.getInstance();	
//	joinservice.Join(member);

	JoinSer joinservice = JoinSer.getInstance();	
	joinservice.Join(member);

//	response.sendRedirect("First.jsp");	
%>
<div class="container write-wrap" style="border:none;">
<table class="write" style="width:100%;">
		<tr>
			<th>NAME</th>
			<td colspan="2"><%= member.getMember_name() %></td>
		</tr>
		<tr>
			<th>ID</th>
			<td colspan="2"><%= member.getMember_id() %></td> 
		</tr>
		<tr>
			<th>질문</th>
			<td colspan="2"><%= member.getMember_pwinfo() %></td>
		</tr>
		<tr>
			<th>질문의 답</th>
			<td colspan="2"><%= member.getMember_pwan() %></td>
		</tr>
		<tr>
		<th>Email</th>
		<td colspan="2"><%= member.getMember_email() %>></td>
		</tr>
	</table>

<input type = "button" value = "Main" onclick = "location.href='LoginJudge.jsp';" >

</div>
</div>
</div>



</body>
</html>
