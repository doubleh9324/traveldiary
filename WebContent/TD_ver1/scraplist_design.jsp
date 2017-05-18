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
	
	//���õǸ�
	if(isAllch == true)
	{	//��ü �����ϱ�
		for(var i =0; i<size; i++){
			checkbox[i].checked = true;
		}	
	} else {
		//��ü���� �����ϱ�
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
	var result = window.confirm("�����Ѵ�?");
	
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

	
	//��ũ�� �� ��ȣ ��� ��������
	GetScrapListSer scrapListSer = GetScrapListSer.getInstance();
	//���ο��� pageNumber�� ������. ���߿� �����ϱ�
	DaysView sviewData = scrapListSer.getScrapList(1, userNum);
	

  if (sviewData.isEmpty()) { %>
<center><b>��ũ���� �ϱⰡ �����ϴ�</b></center>
<%  } else { /* �޽��� �ִ� ��� ó�� ���� */ %>


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
		} /* �޽��� �ִ� ��� ó�� �� */ 
%>


<div class="container" >
<div style="float:right">
<button class="button btn-inverse" onclick="javascript:selectNone()">
<span>��������</span></button>
<button class="button btn-inverse" onclick="javascript:unscrap()">
<span>��ũ�� ����</span></button>
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