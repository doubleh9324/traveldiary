<%@page import="wpjsp.service.GetDiaryInfoSer"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.model.Diary"%>
<%@page import="wpjsp.model.DiaryListView"%>
<%@page import="wpjsp.service.GetDiaryListSer"%>
<%@page import="wpjsp.model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Travel Diary</title>

<%
	request.setCharacterEncoding("euc-kr");
%>
<script type="text/javascript">

function logout(){
	var result = window.confirm('가니?');
	
	if(result){
		window.location='Logout.jsp';
	}else{}
}

$(function(){
	//var h = window.alert($(".dcover").css('height'));
	//if(h != $(".dcover").css('height'));
	{}
	});
</script>

</head>
<body>
	

<%
//페이지 수 저장 -- 메인에서  include할때 변수 수정해주기
		if(userId == "guest"){
%>
		<center>Travel Diary에서 새로운 여행 일기를 남겨봐 :D<br>
		<button class="button btn-warning" onclick="window.location='diaryList.jsp'">
		<span>여행일기 맛보기:)</span></button>
		<button class="button btn-warning" onclick="window.location='Join.jsp'">
		<span>Join</span></button>
		<button class="button btn-warning" onclick="window.location='First.jsp'">
		<span>Login</span></button>
		</center>
<%		
		} else {
		GetDiaryListSer getdiarylist = GetDiaryListSer.getInstance();
		DiaryListView viewDatad = getdiarylist.getmDiaryList(1, userNum);
		
		GetDiaryInfoSer diaryinfoSer = GetDiaryInfoSer.getInstance();
		double pg;
		SimpleDateFormat dateform = new SimpleDateFormat("yyyy/MM/dd");
%>
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
		if(viewDatad.isEmpty()){
%>
<div style="width: 100%; height: 400px">
등록된 일기장이 없습니다.
</div>
<% } else { 
		%>

	<!-- start : diary list -->
	<div id="diary-wrapper" class="row-fluid">

<%
	Diary diaryList = new Diary();
	for(int i=0 ;i<viewDatad.getDiaryTotalCount();i++){
		diaryList = viewDatad.getDiaryList().get(i);
		
		
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
			<div class="picture">
			<a href="diarydays.jsp?dvol=<%= diaryList.getDiary_volum()%>&mnum=<%= userNum %>" >
			<% String path = "../upload/"+diaryList.getCover(); %>
			<img src=<%=path %> alt="" class="dcover"/>
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

<% 					
		}//for 끝
		
		} //else 끝
		
%>
	</div>
	<!-- end : diary list -->

<center>
<button class="button btn-warning" onclick="window.location='diaryList.jsp'">
<span>Other's Diary</span></button>
<button class="button btn-warning" onclick="window.location='writeDiary.jsp'">
<span>New Diary</span></button>
</center>

<%}//else(userId)끝 %>

	

</body>
</html>