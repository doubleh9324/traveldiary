<%@page import="wpjsp.model.DaysView"%>
<%@page import="wpjsp.service.GetScrapListSer"%>
<%@page import="wpjsp.model.Days"%>
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
<title>Insert title here</title>

<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
<title>ScrapList</title>

<script type="text/javascript">

function selectAll(obj){
	var isAllch = document.getElementById('allcheck').checked;
	var checkbox = document.getElementsByName('chscrap');
	var size = checkbox.length;
	
	//선택되면
	if(isAllch == true)
	{	//전체 선택하기
		for(var i =0; i<size; i++){
			checkbox[i].checked = true;
		}	
	} else {
		//전체선택 해제하기
		for(var i=0; i<size; i++){
			checkbox[i].checked = false;
		}
	}
	
}


function selectNone(){
	var checkbox = document.getElementsByName('chscrap');
	var checkall = document.getElementById('allcheck');
	for(var i=0; i<checkbox.length; i++){
		checkbox[i].checked = false;
	}
	checkall.checked = false;
	
	
}

function unscrap(){
	var result = window.confirm("해제한당?");
	
	if(result){
		window.open("", "unscrap", "width=300 height=200");
		
		var chform = document.chform;
		chform.target = "unscrap";
		chform.action="unscrap.jsp";
		
		chform.submit();
	}
}


</script>




</head>

<body>

<% 

	
	//스크랩 글 번호 목록 가져오기
	GetScrapListSer scrapListSer = GetScrapListSer.getInstance();
	//메인에서 pageNumber를 삭제함. 나중에 수정하기
	DaysView sviewData = scrapListSer.getScrapList(1, userNum);
	

  if (sviewData.isEmpty()) { %>
<center><b>스크랩한 일기가 없습니다</b></center>
<%  } else { /* 메시지 있는 경우 처리 시작 */ %>


<form name="chform" method="post" >
<input type="hidden" name="mnum" value="<%= userNum%>">

	<!-- start : scrap table -->
	<div class="table-wrap" id="fixNextTag">
	
	<table class="table table-striped table-hover" id="day_table" style="table-layout:fixed;">
		<colgroup>
			<col width="5%">
			<col width="10%">
			<col width="50%">
			<col width="10%">
			<col width="10%">
		</colgroup>
	<thead>
		<tr>
			<th><input type="checkbox" id="allcheck" onclick="selectAll(this);"></th>
			<th>NO</th>
			<th>TITLE</th>
			<th>WITTER</th>
			<th>HITS</th>
		</tr>
	</thead>
	<tbody>
<%
		int chnum=0;
		for (Days dayList : sviewData.getDayList()) {
%>

		<tr>
			<td>
			<input type="checkbox" id="chscrap" name="chscrap" value="<%= dayList.getDay_num() %>">
			</td>
			<td><%= dayList.getDay_num() %></td>
			<td style="text-align: left;">
			<a href="readDay.jsp?dnum=<%= dayList.getDay_num() %>">
				<%= dayList.getDay_title() %> </a>
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
			<td><%= connum.getMemberId(dayList.getMember_num()) %></td>
			<td><%= dayList.getHits() %></td>
		</tr>
<%
				} 
%>
	</tbody>
</table>
<!-- end : scrap table -->
</div>


<%  	
			for (int i = 1 ; i <= sviewData.getPageTotalCount() ; i++) { 
%>
			<center><a href="Main_design.jsp?spage=<%= i %>"><%= i %></a></center> 
<%  		}
		chnum++; 
		} /* 메시지 있는 경우 처리 끝 */ 
%>


<div class="container" >
<div style="float:right">
<button class="button btn-inverse" onclick="javascript:selectNone()">
<span>선택해제</span></button>
<button class="button btn-inverse" onclick="javascript:unscrap()">
<span>스크랩 해제</span></button>
</div>
</div>
</form> 



<form name="form" method="post">

<!-- 
<input type="button" value="New diary" onclick="javascript:window.location='writeDay.jsp'">
<input type="button" value="Logout" onclick="javascript:logout()">
<input type="button" value="Mypage" onclick="avascript:window.location='mypage.jsp'">
<input type="button" value="Main" onclick="javascript:window.location='Main.jsp'">
 -->

</form>




</body>
</html>