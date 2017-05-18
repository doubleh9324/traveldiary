<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@page import="wpjsp.service.GetReplyListSer"%>
<%@page import="wpjsp.service.ConvertNumToIdSer"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.service.GetDayListSer"%>
<%@page import="wpjsp.model.Days"%>
<%@page import="wpjsp.model.DaysView"%>
<%@ page import = "wpjsp.model.Member"%>

<%@ page import = "java.net.URLDecoder"%>
<%@ page import = "java.sql.SQLException" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<%
	request.setCharacterEncoding("euc-kr");
%>
<title>Insert title here</title>
<link href="css/main.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 

<script type="text/javascript">
$(function(){
	  $('.cambtn').click(function(){
	    $('#cam').hasClass('open') ? $('#cam').removeClass('open'):$('#cam').addClass('open')
	  })
	});
</script>




<script type="text/javascript">

function logout(){
	var result = window.confirm('가니?');
	
	if(result){
		window.location='Logout.jsp';
	}else{}
}



</script>

<style type="text/css">

#day_table{
padding:0px;
margin-bottom: 5px;}

</style>
</head>

<body>

<!-- start : Home-->

		<!-- start : Container -->
		<div class="container pagebox" >
		
			<!-- start : navigation -->
			<%@include file="menu_top.html" %>
			<!-- end : navigation -->
			
			<!-- start : camera -->
			<div id="cam">
				<div id="camera">
					<div class="strip"></div>
					<div class="lens"></div>
					<div class="led"></div>
					<div class="cambtn"></div>
				</div>
				<div id="panel">
				  <div class="pic">
				  <img src="http://lorempixel.com/200/200/city"/>
				  </div>
				  <center>
				  <a href="#" class="lnk">Travel Diary</a>
				  </center>
				</div>
				<div class="shadow">
				</div>
			</div>
			<!-- end : camera -->
		</div>
		<!-- end : Container -->
<!-- end : Home -->
<!-- start : page info loading -->
<%
	String userId = (String)session.getAttribute("USERID");
	String page_code = (String)session.getAttribute("page_code");

	
	Member memberInfo = null;
	int userNum;
	
	//세션(로그인)확인 후 첫 페이지로 이동
	if(userId == null){
	//	response.sendRedirect("First.jsp");
		userId = "guest";
	}
	
	//id로 멤버 정보 가져오기
	GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberinfo.getMemberInfo(userId);
	
	//멤버 번호 저장
	userNum = memberInfo.getMember_num();
	ConvertNumToIdSer connum = ConvertNumToIdSer.getInstance();
%>
	<input type="hidden" id="userId" value="<%=userId %>">
<!-- end : page info loading -->

<!-- start : 1st Page - My Diary -->
<a id="mydiary"></a>

<div id="mydiary" class="color yellow pagebox">

	<!-- start : Container -->
	<div class="container">
	
		<!-- start : Wrapper -->
		<div class="wrapper span12">
	
		<!-- start: Page Title -->
		<div id="page-title">

			<div id="page-title-inner">

				<h2><span>My Diary</span></h2>

			</div>	

		</div>
		<!-- end: Page Title -->
		
		
	<%@include file="mydiary_design.jsp" %>
	
		</div>	
		<!-- end : Wrapper -->

	</div>	
	<!-- end : Container -->
</div>
<!-- end : 1st Page - My Diary -->
<!-- start: 2st Page - day list -->
<a id="days"></a>

	<div id="days" class="color white pagebox">
		
		<!--start: Container -->
		<div class="container">

			<!--start: Wrapper -->
			<div class="wrapper span12">
	
			<!-- start: Page Title -->
			<div id="page-title">

				<div id="page-title-inner">

					<h2><span>Days</span></h2>

				</div>	

			</div>
			<!-- end: Page Title -->
			

<%
	//버튼을 누르면 pagecode를 home에서 daylist로 바꿔주고 include하기
	
	GetDayListSer getdaysSer = GetDayListSer.getInstance();
	DaysView viewData = getdaysSer.getDayList(1);
	
	GetReplyListSer getreplylistSer = GetReplyListSer.getInstance();
	int[][] dnum_rec = getreplylistSer.getReplyCount();
	

 	 if (viewData.isEmpty()) { %>
<center><b>등록된 메시지가 없습니다.</b></center>
<% 	 } else { /* 메시지 있는 경우 처리 시작 */ %>

		
		<!-- start : days table -->
		<div class="table-wrap" id="fixNextTag">
		<table class="table table-striped table-hover " id="day_table" >
		<colgroup>
			<col width="5%">
			<col width="50%">
			<col width="5%">
			<col width="5%">
		</colgroup>
		<thead>
			<tr>
				<th>NO</th>
				<th>TITLE</th>
				<th>WITTER</th>
				<th>HITS</th>
			</tr>
		</thead>
		<tbody>
<%
			int i=0;
			for (Days dayList : viewData.getDayList()) {
				
				//pcode를 확인하고
				String pcode = dayList.getP_code();
						
				//표시가 안될때 :pcode==2&&userNum!=diaryList.getMember_num()
				//pcode==1&&userNum==null;
				
				//표시가 되지 않을 조건 두개
				boolean p2 = (pcode.equals("2")&&userNum!=dayList.getMember_num());
				boolean p1 = (pcode.equals("1")&&userId=="guest");
				
				//p2면 표시하지않고
				if(p2){
					continue;
				} else {
					//p1이면 표시는 하지만
					
				
%>				

			<tr>
				<td><%= dayList.getDay_num() %></td>
				<td style="text-align: left;">
<%
					//p1일때 제목에 잠금표시하기
					if(p1){
%>
					<%= dayList.getDay_title() %> 
					<span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
<%						
					} else {
%>
					<a href="readDay.jsp?dnum=<%= dayList.getDay_num() %>">
					<%= dayList.getDay_title() %>  </a> 
<%
					}

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
			i++;
			if(i==20)
				break;} 
			}

%>
		</tbody>
	</table>
	</div>
	<!-- end : days table -->
	
			<!-- start : Read more  -->
			<center>
			<button class="button btn-danger" onclick="javascript:window.location='daylist.jsp'">
			<span>Read More </span></button>
			</center>
			<!-- end : Read more -->
<%  
		}/* 메시지 있는 경우 처리 끝 */ 
%>
		</div>
		<!-- end : Wrapper -->

	</div>		
	<!-- end : Container -->

</div>	
<!-- end: 2st Page - Days -->


<!-- start : 3st Page - My Page -->
<a id="mypage"></a>

<div id="mypage" class="color black pagebox">

	<!-- start : Container -->
	<div class="container">
		
		<!-- start : Wrapper -->
		<div class="wrapper span12">
		
		<!-- start : Page Title -->
		<div id="page-title">
			<div id="page-title-inner">
				<h2><span>My Page</span></h2>			
			</div>
		</div>
		<!-- end : Page Title -->
		
<!-- 모듈화로 위쪽이나 왼쪽에 고정시킬것 -->

<br>
			<!-- start : tabs -->
			<div class="tabs_container">
			<ul class="tabs">
				<li class="active" rel="tab1">Scrap</li>
        		<li rel="tab2">My Info</li>
    		</ul>
    		
   				<div class="tab_container" style="padding:30px 0 0 0">
       		 		<div id="tab1" class="tab_content">
					<%@include file="scraplist_design.jsp"  %>
					</div>
			        <div id="tab2" class="tab_content">
					<%@include file="modifyInfo_design.jsp" %>
					</div>
			    </div>
			</div>

			<!-- end : tabs -->
			    <br>
			    
<!-- 			    
<input type="button" value="Scrap" onclick="window.location='scraplist.jsp'">
<input type="button" value="정보수정" onclick="javascript:modifyInfo(<%=memberInfo.getMember_num()%>)" >
<input type="button" value="회원탈퇴" onclick="javascript:delmember()">
<input type="button" value="내일기장" onclick="window.location='mydiary.jsp'">
<input type="button" value="Main" onclick="javascript:window.location='Main.jsp'">
-->		</div> 
		<!-- end : Wrapper -->

	</div>
	<!-- end : Container -->

</div>
<!-- end : 3st Page - My Page -->



<script type="text/javascript">
$(function () {

    $(".tab_content").hide();
    $(".tab_content:first").show();

    $("ul.tabs li").click(function () {
        $("ul.tabs li").removeClass("active").css("color", "#FFF");
        //$(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
        $(this).addClass("active").css("color", "darkred");
        $(".tab_content").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn()
    });
});


</script>


</body>
</html>