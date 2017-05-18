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
					<li><a href="#filter" data-option-value=".internal">����</a></li>
					<li>/</li>
					<li><a href="#filter" data-option-value=".foreign">�ؿ�</a></li>
					<li>/</li>
					<li><a href="#filter" data-option-value=".done">�ϼ�</a></li>
				</ul>
			</div>
		
<%
	String userId = (String)session.getAttribute("USERID");

	//����(�α���)Ȯ�� �� ù �������� �̵�
	if(userId == null){
		//	response.sendRedirect("First.jsp");
		userId = "guest";
	}

	Member memberInfo = null;
	int userNum;
	
	//id�� ��� ���� ��������
	GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberinfo.getMemberInfo(userId);
	
	ConvertNumToIdSer connum = ConvertNumToIdSer.getInstance();
		
	//��� ��ȣ ����
	userNum = memberInfo.getMember_num();
	
	//������ �� ����
		String pageNumberStr = request.getParameter("page");
		
		int pageNumber = 1;
		
		//�Ѿ�� ������ ���� ������ 1�� ����
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
��ϵ� �ϱ����� �����ϴ�. 
<% } else { 
		%>

	<!-- start : diary list -->
	<div id="diary-wrapper" class="row-fluid">
	
<%
		for(Diary diaryList : viewData.getDiaryList()){
		
			//pcode�� Ȯ���ϰ�
			String pcode = diaryList.getP_code();
		
			//ǥ�ð� ���� ���� ���� �ΰ�
			boolean p2 = (pcode.equals("2")&&userNum!=diaryList.getMember_num());
			boolean p1 = (pcode.equals("1")&&userId=="guest");
			
			//p2�� ǥ�������ʰ�
			if(p2){
				continue;
			} else {
				//p1�̸� ǥ�ô� ������
				
				
				//filter ������ ���� Ŭ���� ��� ����
				pg = diaryinfoSer.getprogress(diaryList.getDiary_volum(), diaryList.getMember_num());
				
				String basicClass = "span4 diary-item html5 css3 responsive ";
				String className = null;
				//�ϱ� ����� ���� Ŭ���� �̸� �߰�
				if(pg == 100.0){
					basicClass = basicClass+"done ";
				}
				
				//������ ���� Ŭ���� �̸� �߰�
				if(diaryList.getLocation().contains("i")){
					className = basicClass+"internal";
				} else if(diaryList.getLocation().contains("o")){
					className = basicClass+"foreign";
				}
%>
		
			<div id="diary" class="<%=className%>">		
<%
					//p1�϶� �������̷�  ���ǥ���ϱ�
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

<%  } /* �޽��� �ִ� ��� ó�� �� */ %>

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
	re = window.confirm("�α����ҷ�?");
	
	
	if(re == true){
		location.href='First.jsp';
	}
}
</script> 


<script type="text/javascript">
//����� ���߿� ���⸦ �� ��������

$(function () {
	

function getReadList() { 
	$('#loading').html('������ �ε����Դϴ�.'); //ajax 
	
	$.post("diaryList.jsp?page="+$(".picture:last").attr("id")+1, 
			function(data){ if (data != "") { 
				$(".picture:last").after(data); } 
			$('#loading').empty(); 
			}); 
	}; 
			
	//���� ��ũ��
	$(window).scroll(function(){ 
		if($(window).scrollTop()==$(document).height()-$(window).height()){
			getReadList(); 
		} 
	}); 
});

</script>
	
</body>
</html>