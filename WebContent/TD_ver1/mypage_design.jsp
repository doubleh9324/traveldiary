<%@page import="wpjsp.service.GetMemberInfoService"%>
<%@page import="wpjsp.model.Member"%>
<%@page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<html>
<head>
<title>Insert title here</title>

<script type="text/javascript">

function modifyInfo(){
	window.open("modifyInfo.jsp","", "width=500 height=800")
}

function delmember(){
	var result = window.confirm('��¥ ?');

	if(result){
		window.open("deleteMember.jsp","", "width=300 height=200")
	} else {}
}

function scraplist(){
	
}
</script>
<link href="css/tab.css" rel="stylesheet">
</head>
<body>
<input class="Btn" type="button" value="Logout" onclick="javascript:logout()">
<div id="mypage" class="color black">

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
       			<li rel="tab3">My Memories</li>
    		</ul>
    		
   				<div class="tab_container">
       		 		<div id="tab1" class="tab_content">
					<%@include file="scraplist_design.jsp" %>
				</div>
			        <div id="tab2" class="tab_content">���������ϱ�</div>
			        <div id="tab3" class="tab_content">���, ���� ��ƺ���</div>
			    </div>
			</div>

			<!-- end : tabs -->
			    <br>
			    	</div> 
		<!-- end : Wrapper -->

	</div>
	<!-- end : Container -->

</div>

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
<script defer="defer" src="js/custom.js"></script>
</body>
</html>