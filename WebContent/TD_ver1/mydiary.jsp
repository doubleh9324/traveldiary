<%@page import="wpjsp.service.ConvertNumToIdSer"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.model.Diary"%>
<%@page import="wpjsp.model.DiaryListView"%>
<%@page import="wpjsp.service.GetDiaryListSer"%>
<%@page import="wpjsp.model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script type="text/javascript">

function logout(){
	var result = window.confirm('가니?');
	
	if(result){
		window.location='Logout.jsp';
	}else{}
}
</script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
</head>
<body>

<!-- start : page - my diary list -->

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

				<h2><span>Diarys</span></h2>

			</div>	

		</div>
		<!-- end: Page Title -->
		

		
<%

	String userId = (String)session.getAttribute("USERID");

	//세션(로그인)확인 후 첫 페이지로 이동
	if(userId == null){
		response.sendRedirect("First.jsp");
	}

	Member memberInfo = null;
	int userNum;
	int mnum = Integer.parseInt(request.getParameter("mnum"));


	
	//id로 멤버 정보 가져오기
	GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberinfo.getMemberInfo(userId);
	
	ConvertNumToIdSer connum = ConvertNumToIdSer.getInstance();
		
	//멤버 번호 저장
	userNum = memberInfo.getMember_num();
	
	//페이지 수 저장
		String pageNumberStr = request.getParameter("page");
		
		int pageNumber = 1;
		
		//넘어온 페이지 값이 없으면 1로 설정
		if (pageNumberStr != null) {
			pageNumber = Integer.parseInt(pageNumberStr);
		}
		

		GetDiaryListSer getdiarylist = GetDiaryListSer.getInstance();
		DiaryListView viewData = getdiarylist.getmDiaryList(pageNumber, mnum);
		
		SimpleDateFormat dateform = new SimpleDateFormat("yyyy/MM/dd");
		
%>
<center>~<%= connum.getMemberId(mnum)  %>님의 일기장~</center>
		<div id="filters">
				<ul class="option-set" data-option-key="filter">
					<li><a href="#filter" class="selected" data-option-value="*">All</a></li>
					<li>/</li>
					<li><a href="#filter" data-option-value=".internal">국내</a></li>
					<li>/</li>
					<li><a href="#filter" data-option-value=".foreign">해외</a></li>
					<li>/</li>
					<li><a href="#filter" data-option-value=".full">완성</a></li>
				</ul>
			</div>

<%		
		if(viewData.isEmpty()){
%>
등록된 일기가 없습니다.
<% } else { 
		%>

	<!-- start : diary list -->
	<div id="diary-wrapper" class="row-fluid">
	
<%
	Diary diaryList = new Diary();
	for(int i=0 ;i<viewData.getDiaryTotalCount();i++){
		diaryList = viewData.getDiaryList().get(i);
		
		//pcode를 확인하고
		String pcode = diaryList.getP_code();
		
		//표시가 되지 않을 조건 두개
		boolean p2 = (pcode.equals("2")&&userNum!=diaryList.getMember_num());
		boolean p1 = (pcode.equals("1")&&userId=="guest");
		
		//두 조건중 하나라도 만족이 된다면 표시하지 않음
		if(p1||p2){
			continue;
		} else {
		
		String basicClass = "span4 diary-item html5 css3 responsive ";
		String className = null;
		if(diaryList.getLocation().contains("i")){
			className = basicClass+"internal";
		} else if(diaryList.getLocation().contains("o")){
			className = basicClass+"foreign";
		}
%>
		
		<div id="diary" class="<%=className%>">
			<div class="picture">
			<a href="diarydays.jsp?dvol=<%= diaryList.getDiary_volum() %>&mnum=<%=mnum %>" 
			title="Title">
		<% String path = "../upload/"+diaryList.getCover(); %>
			<img src=<%= path%> alt="" class="dcover"/>
			<div class="image-overlay-link"></div></a>
				<div class="item-description alt">
					<h5><a href="diarydays.jsp?dvol=<%= diaryList.getDiary_volum() %>">
					<%=diaryList.getDiary_title() %></a></h5>
					<p>
					<%=dateform.format(diaryList.getStart_day()) %>-<%=dateform.format(diaryList.getEnd_day()) %><br>
					<b><%=connum.getMemberId(diaryList.getMember_num())%></b> 
					vol.<%=diaryList.getDiary_volum() %> 
					</p>
				</div>
			</div>
		</div>

<% }} %>
	</div>
	<!-- end : diary list -->

<br>
<%  } /* 메시지 있는 경우 처리 끝 */ %>

	

	
	<center>
		<button class="button btn-warning" onclick="javascript:window.location='writeDiary.jsp'">
		<span>New diary</span></button>
		<button class="button btn-warning" onclick="javascript:window.location='diaryList.jsp'">
		<span>Other's diary</span></button>
	</center>
		</div>
		<!-- end : Wrapper -->
		
	</div>
	<!-- end : Container -->
	
	
	<!-- start : button set -->

<!-- end : Page - my diary list -->
</body>
</html>