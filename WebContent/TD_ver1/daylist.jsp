<%@page import="wpjsp.service.ConvertNumToIdSer"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.model.Member"%>
<%@page import="wpjsp.model.Days"%>
<%@page import="wpjsp.service.GetReplyListSer"%>
<%@page import="wpjsp.model.DaysView"%>
<%@page import="wpjsp.service.GetDayListSer"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 

</head>
<body>

<!-- start : page - day list -->
	<!-- start : Container -->
	<div id="days" class="container color white ppagebox">
	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>	
		<!-- end : navigation -->
		
			<!-- start : Wrapper -->
			<div class="wrapper span12">
			
			<!-- start : Page Title -->
			<div id="page-title">
				<div id="page-title-inner">
				<h2><span>Days</span></h2>
				</div>				
			</div>
			<!-- end : Page Title -->
			
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

//��ư�� ������ pagecode�� home���� daylist�� �ٲ��ְ� include�ϱ�
	//������ �ڵ� ���ǿ��� �޾ƿͼ�
	String pcode_daylist = (String)session.getAttribute("page_code");
	String pageNumberStr;
	int pageNumber;
	

	pageNumberStr = request.getParameter("page");

	pageNumber = 1;
	
	//�Ѿ�� ������ ���� ������ 1�� ����
	if (pageNumberStr != null) {
		pageNumber = Integer.parseInt(pageNumberStr);
	}


	
	GetDayListSer getdaysSer = GetDayListSer.getInstance();
	DaysView viewData = getdaysSer.getDayList(pageNumber);
	
	GetReplyListSer getreplylistSer = GetReplyListSer.getInstance();
	int[][] dnum_rec = getreplylistSer.getReplyCount();
	
	if (viewData.isEmpty()) { 
 %>
��ϵ� �ϱⰡ �����ϴ�.
<%  
	} else { /* �޽��� �ִ� ��� ó�� ���� */ 
%>
<div class="table-wrap" id="fixNextTag">
	<table class="table table-striped table-hover " id="day_table">
	<colgroup>
		<col width="10%">
		<col width="40%">
		<col width="10%">
		<col width="10%">
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
			}} 
%>
		</tbody>
	</table>
</div>
<center>
<%
				for (int i = 1 ; i <= viewData.getPageTotalCount() ; i++) { 
%>
			<a href="daylist.jsp?page=<%= i %>"><%= i %></a>
<%
			}
		
%>
</center>
<%  
	}/* �޽��� �ִ� ��� ó�� �� else1 */ 
%>
<br>
<center>
	<button class="button btn-danger" onclick="javascript:window.location='writeDay.jsp?dvol=0'">
	<span>New Day</span></button>
	<button class="button btn-danger" onclick="javascript:window.location='mydiary.jsp?mnum=<%=userNum%>'">
	<span>My Diary</span></button>
	<button class="button btn-danger" onclick="javascript:window.location='writeDiary.jsp'">
	<span>New Diary</span></button>
</center>
		</div>
		<!-- end : Wrapper -->
	
	</div>
	<!-- end : Container -->
	
<!-- end : Page -day list -->

</body>
</html>