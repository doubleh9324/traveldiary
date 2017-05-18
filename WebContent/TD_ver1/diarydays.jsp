<%@page import="java.util.Date"%>
<%@page import="wpjsp.service.ConvertNumToIdSer"%>
<%@page import="wpjsp.service.GetReplyListSer"%>
<%@page import="wpjsp.model.Diary"%>
<%@page import="wpjsp.dao.DiaryDao"%>
<%@page import="wpjsp.service.GetDiaryInfoSer"%>
<%@page import="wpjsp.model.Days"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="wpjsp.model.DaysView"%>
<%@page import="wpjsp.service.GetDayListSer"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Travel Diary</title>
<script type="text/javascript">
function deleteDiary(dvol, userNum){
	var result = window.confirm('없앤다?');
	
	if(result){
		window.open("deleteDiary.jsp?dvol="+dvol+"&userNum="+userNum, "", "width=200 height=200")
	}else{}
}
</script>

<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
</head>
<body>
<!-- start : page - day list -->

	<!-- start : Container -->
	<div id="about" class="container color yellow ppagebox">
	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>	
		<!-- end : navigation -->
	
			<!-- start : Wrapper -->
			<div class="wrapper span12">
			
			<!-- start : Page Title -->
			<div id="page-title">
				<div id="page-title-inner">
				<h2><span>My Days</span></h2>
				</div>				
			</div>
			<!-- end : Page Title -->
			
			
<%
	String userId = (String)session.getAttribute("USERID");

	//세션(로그인)확인 후 첫 페이지로 이동
	if(userId == null){
		//response.sendRedirect("First.jsp");
		userId = "guest";
	}

	Member memberInfo = null;
	int dvol = Integer.parseInt(request.getParameter("dvol"));
	int mnum = Integer.parseInt(request.getParameter("mnum"));
	
	

	
	//id로 멤버 정보 가져오기
	GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberinfo.getMemberInfo(userId);
	int userNum = memberInfo.getMember_num();
	
	//페이지 수 저장
	String pageNumberStr = request.getParameter("page");
	
	int pageNumber = 1;

	if (pageNumberStr != null) {
		pageNumber = Integer.parseInt(pageNumberStr);
	}
	
	GetDayListSer getdaysSer = GetDayListSer.getInstance();
	DaysView viewData = getdaysSer.getDDayList(pageNumber, dvol, mnum);

	GetDiaryInfoSer getdiaryinfoSer = GetDiaryInfoSer.getInstance();
	Diary diaryinfo = new Diary();
	diaryinfo = getdiaryinfoSer.getDiaryInfo(dvol, mnum);
	double pg = getdiaryinfoSer.getprogress(dvol, mnum);
	
	SimpleDateFormat dateform = new SimpleDateFormat("yyyy/MM/dd");
	
	ConvertNumToIdSer connum = ConvertNumToIdSer.getInstance();
	
	GetReplyListSer getreplylistSer = GetReplyListSer.getInstance();
	int[][] dnum_rec = getreplylistSer.getReplyCount();
	
	

%>

			<!-- start: Row -->
			<div class="row-fluid">
					
				<!-- 확인하고 지우기 -->
				<div class="span12">
					
					<!-- start: Skills -->
			       	<h3>Achievement</h3>
			       	<ul class="progress-bar-stripes">
			        	<li>
			            	<div class="meter"><p>여행완성  <%= pg%>% </p><span style="width: <%= pg%>%"></span></div>
			          	</li>
			      	</ul>
			      	<!-- end: Skills -->
		      	</div>
		      	
    	  	</div>
      		<!-- end : Row -->
      		
      		
      		
      		
			<!-- start: Row -->
			<div class="row-fluid">		
				<!-- 확인하고 지우기 -->
				<div class="span12">
			      	
난<%=userId %><br>
<%= connum.getMemberId(diaryinfo.getMember_num()) %>의 일기장  <%= diaryinfo.getDiary_title() %><br>
<%		
		if(viewData.isEmpty()){
%>
<center><b>등록된 일기가 없습니다.</b></center><br>
<% } else { 
		%>
	
<div class="table-wrap" id="fixNextTag">
	<table class="table table-striped table-hover ">
		<thead>
			<tr>
				<th>NO</th>
				<th>TITLE</th>
				<th>DATE</th>
				<th>TIME</th>
				<th>HITS</th>
			</tr>
		</thead>
		<tbody>
<%
	for(Days dayList : viewData.getDayList()){
%>
	<tr>
		<td><%= dayList.getDay_num() %></td>
		<td><a href="readDay.jsp?dnum=<%=dayList.getDay_num()%>">
			<%= dayList.getDay_title() %></a>
<%
					int c=0;
					int recount=0;
					while(c<dnum_rec.length){
						if(dnum_rec[c][0]==dayList.getDay_num())
							recount = dnum_rec[c][1];
						c++;
					}
					
					if(recount != 0){
%>					
					(<%= recount %>)
<%
					} 
%>
				</td>
			<td><%= dateform.format(dayList.getDay_time()) %>
			<td><%= dateform.format(dayList.getTime())%></td>
			<td><%= dayList.getHits()%></td>
	</tr>
<%  	} %>
</table>

<center>
<%  	for (int i = 1 ; i <= viewData.getPageTotalCount() ; i++) { %>
<a href="diarydays.jsp?page=<%= i %>"><%= i %></a> 
<%  	} %>
</center>
<%  } /* 메시지 있는 경우 처리 끝 */ %>

</DIV>

<%
	if(userNum == diaryinfo.getMember_num()){
%>
	<div class="btn-wrap" style="margin: 0 0 20px 0;">
		<center>
		<button class="button btn-warning" onclick="javascript:window.location='writeDay.jsp?dvol=<%=dvol%>'">
		<span>일기쓰기</span></button>
		<button class="button btn-warning" onclick="javascript:window.location='modifyDiary.jsp?dvol=<%=dvol%>&userNum=<%=userNum%>'">
		<span>일기장 수정</span></button>
		<button class="button btn-warning" onclick="javascript:deleteDiary(<%=dvol%>, <%=userNum%>)">
		<span>일기장 삭제</span></button>
<% 
	} else { }
%>
<center>
<button class="button btn-warning" onclick="javascript:window.location='diaryList.jsp'">
<span>일기장 목록</span></button>
<button class="button btn-warning" onclick="javascript:window.location='mydiary.jsp?mnum=<%=userNum%>'">
<span>내 일기장 목록</span></button>
</center>
		</center>
		</div>
			</div></div>
		</div>
		<!-- end : Wrapper -->
		
	</div>
	<!-- end : Container -->
	
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
		
</body>
</html>