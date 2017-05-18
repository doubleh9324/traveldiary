<%@page import="java.text.SimpleDateFormat"%>
<%@page import="wpjsp.service.UpdateDaySer"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.model.Days"%>
<%@page import="wpjsp.model.Member"%>
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
<!-- start : page - modify day2 -->

	<!-- start : Container -->
	<div id="modifyday" class="container color white ppagebox">
	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>	
		<!-- end : navigation -->

	
		<!-- start : Wrapper -->
		<div class="wrapper span12">
	
		<!-- start: Page Title -->
		<div id="page-title">

			<div id="page-title-inner">

				<h2><span>Modify Day</span></h2>

			</div>	

		</div>
<%
	String userId = (String)session.getAttribute("USERID");
	Member memberInfo = null;

	int userNum;
	int dnum = Integer.parseInt(request.getParameter("dnum"));
	int dvol = Integer.parseInt(request.getParameter("dvol"));
	String title = request.getParameter("day_title");
	String uday = request.getParameter("day");
	String day_time = request.getParameter("day_time");
	String pcode = request.getParameter("privacy");
	
	GetMemberInfoSer getmemberInfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberInfo.getMemberInfo(userId);

	userNum = memberInfo.getMember_num();
	
	SimpleDateFormat dateform = new SimpleDateFormat("dd/MM/yyyy");
	
	//usebean으로 바꿀수 있는지 확인
	Days day = new Days();
	day.setDay(uday);
	day.setDay_title(title);
	day.setMember_num(userNum);
	day.setDay_num(dnum);
	day.setDiary_volum(dvol);
	day.setDay_time(dateform.parse(day_time));
	day.setP_code(pcode);
	UpdateDaySer updatedaySer = UpdateDaySer.getInstance();
	updatedaySer.update(day);

%>
<center><b>~수정완료~</b></center>

<center>
<a onclick="window.location='readDay.jsp?dnum=<%=dnum%>'" class="button btn-warning">
<span>확인</span>
</a>
</center>
		</div>
		<!-- end : Wrapper -->
		
	</div>
	<!-- end : Container -->
	
<!-- end : page - modify day2 -->
</body>
</html>