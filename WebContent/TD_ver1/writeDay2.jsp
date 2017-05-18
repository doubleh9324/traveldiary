<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="wpjsp.model.Days"%>
<%@page import="wpjsp.service.WriteDaySer"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="wpjsp.model.Bulletin" %>
<%@ page import="wpjsp.model.Member" %>

<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
	<title>새 이야기 남김</title>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
	
</head>


<body>

<!-- start : page - write day2 -->

	<!-- start : Container -->
	<div id="diarylist" class="container color yellow ppagebox">
	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>	
		<!-- end : navigation -->

	
		<!-- start : Wrapper -->
		<div class="wrapper span12">
	
		<!-- start: Page Title -->
		<div id="page-title">

			<div id="page-title-inner">

				<h2><span>New Diary</span></h2>

			</div>	

		</div>
<% 
	String userId = (String)session.getAttribute("USERID");
	Member memberInfo = null;
	
	int userNum;
	
	GetMemberInfoSer getmemberInfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberInfo.getMemberInfo(userId);

	userNum = memberInfo.getMember_num();
	System.out.println(request.getParameter("day_time"));
	int dvol = Integer.parseInt(request.getParameter("dvol"));
	SimpleDateFormat format= new SimpleDateFormat("dd/MM/yyyy");
	Date dday = format.parse(request.getParameter("day_time"));
	
	String pcode = request.getParameter("privacy");
	
	Days day = new Days();
	day.setDay(request.getParameter("day"));
	day.setDay_title(request.getParameter("day_title"));
	day.setMember_num(userNum);
	day.setDiary_volum(dvol);
	day.setDay_time(dday);
	day.setP_code(pcode);

	WriteDaySer writedaySer = WriteDaySer.getInstance();
	writedaySer.write(day);
	
%>
<center><b>새 일기를 썼당!</b></center><br>

	<center>
	<button class="button btn-warning" onclick="window.location='diarydays.jsp?dvol=<%=dvol%>&mnum=<%=userNum%>'">
	<span>목록</span></button>
	</center>
	
		</div>
		<!-- end : Wrapper -->
		
	</div>
	<!-- end : Container -->
	
<!-- end : page - write day2 -->
</body>
</html>