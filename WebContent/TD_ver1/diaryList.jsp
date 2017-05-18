<%@page import="wpjsp.service.GetDiaryInfoSer"%>
<%@page import="java.util.Date"%>
<%@page import="wpjsp.service.ConvertNumToIdSer"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.model.Diary"%>
<%@page import="wpjsp.model.DiaryListView"%>
<%@page import="wpjsp.service.GetDiaryListSer"%>
<%@page import="wpjsp.model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page buffer = "10000kb" %>
    
<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>


<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

</head>
<body>

<!-- start : page - diary list -->

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
		
					<div id="filters">
				<ul class="option-set" data-option-key="filter">
					<li><a href="#filter" class="selected" data-option-value="*">All</a></li>
					<li>/</li>
					<li><a href="#filter" data-option-value=".internal">국내</a></li>
					<li>/</li>
					<li><a href="#filter" data-option-value=".foreign">해외</a></li>
					<li>/</li>
					<li><a href="#filter" data-option-value=".done">완성</a></li>
				</ul>
			</div>
		
<%
	String userId = (String)session.getAttribute("USERID");

	//세션(로그인)확인 후 첫 페이지로 이동
	if(userId == null){
		//	response.sendRedirect("First.jsp");
		userId = "guest";
	}

	Member memberInfo = null;
	int userNum;
	
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
		DiaryListView viewData = getdiarylist.getDiaryList(pageNumber);
		
		SimpleDateFormat dateform = new SimpleDateFormat("yyyy/MM/dd");
		
		GetDiaryInfoSer diaryinfoSer = GetDiaryInfoSer.getInstance();
		double pg;
		

%>
<%=userId %>
<%		
		if(viewData.isEmpty()){
%>
등록된 일기장이 없습니다. 
<% } else { 
		%>

	<!-- start : diary list -->
	<div id="diary-wrapper" class="row-fluid">
	
<%
		for(Diary diaryList : viewData.getDiaryList()){
		
			//pcode를 확인하고
			String pcode = diaryList.getP_code();
		
			//표시가 되지 않을 조건 두개
			boolean p2 = (pcode.equals("2")&&userNum!=diaryList.getMember_num());
			boolean p1 = (pcode.equals("1")&&userId=="guest");
			
			//p2면 표시하지않고
			if(p2){
				continue;
			} else {
				//p1이면 표시는 하지만
				
				
				//filter 적용을 위한 클래스 목록 설정
				pg = diaryinfoSer.getprogress(diaryList.getDiary_volum(), diaryList.getMember_num());
				
				String basicClass = "span4 diary-item html5 css3 responsive ";
				String className = null;
				//일기 진행률 따라 클래스 이름 추가
				if(pg == 100.0){
					basicClass = basicClass+"done ";
				}
				
				//지역에 따라 클래스 이름 추가
				if(diaryList.getLocation().contains("i")){
					className = basicClass+"internal";
				} else if(diaryList.getLocation().contains("o")){
					className = basicClass+"foreign";
				}
%>
		
			<div id="diary" class="<%=className%>">		
<%
					//p1일때 오버레이로  잠금표시하기
					if(p1){
%>
				<div id="<%=pageNumber%>" class="picture">
				<a href="#" onclick="javascript:reqLogin();">
				<% String path = "../upload/"+diaryList.getCover(); %>
				<img src=<%=path %> alt="" class="dcover"/>
				<div class="image-overlay-lock"></div></a>
					<div class="item-description alt">
						<h5><%=diaryList.getDiary_title() %></h5>
						<p>
						<%=dateform.format(diaryList.getStart_day()) %>-<%=dateform.format(diaryList.getEnd_day()) %><br>
						<b><%=connum.getMemberId(diaryList.getMember_num())%></b> 
						vol.<%=diaryList.getDiary_volum() %> 
						</p>
					</div>
				</div>
<%						
					} else {
%>
				<div id="<%=pageNumber%>" class="picture">
				<a href="diarydays.jsp?dvol=<%= diaryList.getDiary_volum() %>&mnum=<%= diaryList.getMember_num()%>" 
				title="Title">
				<% String path = "../upload/"+diaryList.getCover(); %>
				<img src=<%=path %> alt="" class="dcover"/>
				<div class="image-overlay-link"></div></a>
					<div class="item-description alt">
						<h5><a href="diarydays.jsp?dvol=<%= diaryList.getDiary_volum() %>&mnum=<%= diaryList.getMember_num()%>">
						<%=diaryList.getDiary_title() %></a></h5>
						<p>
						<%=dateform.format(diaryList.getStart_day()) %>-<%=dateform.format(diaryList.getEnd_day()) %><br>
						<a href="mydiary.jsp?mnum=<%= diaryList.getMember_num() %>">
						<b><%=connum.getMemberId(diaryList.getMember_num())%></b></a>
						vol.<%=diaryList.getDiary_volum() %> 
						</p>
					</div>
				</div>
<%
			}//else(p1)
%>
		</div>

<% 							}//else
				} //for
			
		for (int i=1; i<=viewData.getPageTotalCount(); i++) { 
%>
		<a href="diaryList.jsp?page=<%= i %>"><%= i %></a>
<%
		} 
%>

<%  } /* 메시지 있는 경우 처리 끝 */ %>

<br>

<button class="button btn-warning" onclick="javascript:window.location='writeDiary.jsp'">
<span>New Diary</span></button>

	</div>
	<!-- end : diary list -->
	
	<div id="loading"></div>
	
		</div>
		<!-- end : Wrapper -->
		
	</div>
	<!-- end : Container -->
	
<script type="text/javascript">
function reqLogin(){
	
	
	var re = false;
	re = window.confirm("로그인할랭?");
	
	
	if(re == true){
		location.href='First.jsp';
	}
}
</script> 


<script type="text/javascript">
//여기야 나중에 여기를 꼭 수정해줘

$(function () {
	

function getReadList() { 
	$('#loading').html('데이터 로딩중입니다.'); //ajax 
	
	$.post("diaryList.jsp?page="+$(".picture:last").attr("id")+1, 
			function(data){ if (data != "") { 
				$(".picture:last").after(data); } 
			$('#loading').empty(); 
			}); 
	}; 
			
	//무한 스크롤
	$(window).scroll(function(){ 
		if($(window).scrollTop()==$(document).height()-$(window).height()){
			getReadList(); 
		} 
	}); 
});

</script>
	
</body>
</html>