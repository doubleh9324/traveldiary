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
	var result = window.confirm('����?');
	
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
	
	//����(�α���)Ȯ�� �� ù �������� �̵�
	if(userId == null){
	//	response.sendRedirect("First.jsp");
		userId = "guest";
	}
	
	//id�� ��� ���� ��������
	GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberinfo.getMemberInfo(userId);
	
	//��� ��ȣ ����
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
	//��ư�� ������ pagecode�� home���� daylist�� �ٲ��ְ� include�ϱ�
	
	GetDayListSer getdaysSer = GetDayListSer.getInstance();
	DaysView viewData = getdaysSer.getDayList(1);
	
	GetReplyListSer getreplylistSer = GetReplyListSer.getInstance();
	int[][] dnum_rec = getreplylistSer.getReplyCount();
	

 	 if (viewData.isEmpty()) { %>
<center><b>��ϵ� �޽����� �����ϴ�.</b></center>
<% 	 } else { /* �޽��� �ִ� ��� ó�� ���� */ %>

		
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
				
				//pcode�� Ȯ���ϰ�
				String pcode = dayList.getP_code();
						
				//ǥ�ð� �ȵɶ� :pcode==2&&userNum!=diaryList.getMember_num()
				//pcode==1&&userNum==null;
				
				//ǥ�ð� ���� ���� ���� �ΰ�
				boolean p2 = (pcode.equals("2")&&userNum!=dayList.getMember_num());
				boolean p1 = (pcode.equals("1")&&userId=="guest");
				
				//p2�� ǥ�������ʰ�
				if(p2){
					continue;
				} else {
					//p1�̸� ǥ�ô� ������
					
				
%>				

			<tr>
				<td><%= dayList.getDay_num() %></td>
				<td style="text-align: left;">
<%
					//p1�϶� ���� ���ǥ���ϱ�
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
		}/* �޽��� �ִ� ��� ó�� �� */ 
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
		
<!-- ���ȭ�� �����̳� ���ʿ� ������ų�� -->

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
<input type="button" value="��������" onclick="javascript:modifyInfo(<%=memberInfo.getMember_num()%>)" >
<input type="button" value="ȸ��Ż��" onclick="javascript:delmember()">
<input type="button" value="���ϱ���" onclick="window.location='mydiary.jsp'">
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