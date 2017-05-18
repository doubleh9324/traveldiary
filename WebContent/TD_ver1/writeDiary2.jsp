<%@page import="java.io.File"%>
<%@page import="wpjsp.service.GetDiaryInfoSer"%>
<%@page import="wpjsp.service.WriteDiarySer"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="wpjsp.model.Diary"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
<!-- start: CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="css/slider1.css" rel="stylesheet">
	<link href="css/slider2.css" rel="stylesheet">
	<link href="css/slider3.css" rel="stylesheet">
	<link href="css/tab.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Droid+Sans:400,700">
	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Droid+Serif">
	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Boogaloo">
	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Economica:700,400italic">
	
<style type="text/css">
*{margin:0px; padding:0px;}
html, body{height: 100%;  background-color:#3C5064;}

.background{
height: 100%; }
</style>
	
	<!-- end: CSS -->
	
</head>
<body>

<!-- start : page - writediary2 -->


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
		<!-- end : Page Title -->
<% 
	String userId = (String)session.getAttribute("USERID");
	Member memberInfo = null;
	
	int userNum;
	
	GetMemberInfoSer getmemberInfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberInfo.getMemberInfo(userId);

	userNum = memberInfo.getMember_num();
	
	Diary diary = new Diary();
	diary.setMember_num(userNum);
	
	//파일 업로드 부분 test1 이클립스까지는 가능
	
	String path = application.getRealPath("upload");
	MultipartRequest re = new MultipartRequest(request, path, 1024*1024*5, "UTF-8",
			new DefaultFileRenamePolicy());
	
	File cover = re.getFile("cover");
	
	
	String title = re.getParameter("diaryTitle");
	String sub = re.getParameter("location");
	String location=null;
	
	if(sub.equals("1"))
	{	location = re.getParameter("location_in");
	
	}	
	else if(sub.equals("2")){
		location = re.getParameter("location_over");
	}
	
	String privacy = re.getParameter("privacy");
	SimpleDateFormat format= new SimpleDateFormat("dd/MM/yyyy");
	Date sday = format.parse(re.getParameter("start_day"));
	Date eday = format.parse(re.getParameter("end_day"));
	
	diary.setDiary_title(title);
	diary.setStart_day(sday);
	diary.setEnd_day(eday);
	diary.setLocation(location);
	
	if(cover != null)
		diary.setCover(cover.getName());

	
	diary.setP_code(privacy);
	
	WriteDiarySer writediarySer = WriteDiarySer.getInstance();
	int dvol = writediarySer.write(diary);
	
	
	
	

%>

<center><b>새 일기장 완성!</b></center><br>

	<center>
	<button class="button btn-warning" onclick="window.location='writeDay.jsp?dvol=<%=dvol%>'">
	<span>일기쓰기</span></button>
	<button class="button btn-warning" onclick="window.location='mydiary.jsp?mnum=<%=userNum%>'">
	<span>일기장 목록</span></button>
	</center>

		</div>
		<!-- end : Wrapper -->
		
	</div>
	<!-- end : Container -->
	
<!-- end : Page - writediary2 -->
</body>
</html>