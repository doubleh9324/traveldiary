<%@page import="wpjsp.service.GetReplyListSer"%>
<%@page import="wpjsp.service.ConvertNumToIdSer"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.service.GetDayListSer"%>
<%@page import="wpjsp.model.Days"%>
<%@page import="wpjsp.model.DaysView"%>
<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import = "java.net.URLDecoder"%>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "wpjsp.model.JournalListView" %>
<%@ page import = "wpjsp.model.Bulletin"%>
<%@ page import = "wpjsp.model.Member"%>

<%
	request.setCharacterEncoding("euc-kr");
%>
<!-- member, day�̶�� ��ü�� Ŭ������ �����Ͽ� ���� ������ �����ϰڴ�! -->
<jsp:useBean id="member" class="wpjsp.model.Member" scope="session" />
<jsp:useBean id="day" class="wpjsp.model.Bulletin" scope="session" />

<!-- member ��ü�� �Ѱܿ� ���� �޾Ƽ� ��� set -->
<jsp:setProperty name="member" property="*" />

<html>
<head>
<title>Main</title>

<script type="text/javascript">

function logout(){
	var result = window.confirm('����?');
	
	if(result){
		window.location='Logout.jsp';
	}else{}
}
</script>

<style type="text/css">

body{
	background-color:#3C5064;
	font-family:����;
	color:#E4E8EB;
	font-size:12px;
}

.table{
	margin-top: 200px;
	flaot:left;
	display: inline-block;
	border:solid #ffffff 1px;
}

.menu-wrap { 
	width:1200px; 
	margin:0 auto; 
	border:solid #ffffff 1px; }
.menu { 
	float:left; 
	text-align:center; }
.menu li { 
	display:inline-block; 
	text-align:center;}
.list { 
	text-align:center;
	list-sryle:none; 
	float:left; 
	display:inline; }
.list li { 
	float:left;
	display:inline;
	vertical-align:middle; }
.list li a { 
	display:-moz-inline-stack;
	display:inline-block;
	vertical-align:top;
	float:left; 
	padding:4px; 
	margin-right:3px; 
	width:15px;
	color:#000; 
	font:bold 12px tahoma; 
	border:1px solid #eee;
	text-align:center; 
	text-decoration:none; 
	width:26px;}

ul li a:hover, ul li a:focus {
	color:#fff; 
	border:1px solid #f40; 
	background-color:#f40;}

list li a.now{
	coloe:#fff;
	background-color:#f40;
	border:1px solid #f40;}
	
.Btn {
	font-family: Georgia;
	color: #fe786B;
	font-size: 20px;
	padding: 10px 20px 10px 20px;
	border-top: solid #fe786B 1px;
	border-bottom: solid #fe786B 1px;
	text-decoration: none;
	background-color:transparent;
	border-left: none;
	border-right:none;
	margin-right:10px;
	margin-left:10px;
}

.Btn:hover {
	background-color:transparent;
	text-decoration: none;
	border-top: solid #fe786B 3px;
	border-bottom: solid #fe786B 3px; 
}

</style>

</head>

<body>

<!--
�α׾ƿ� ���� �ٽ� © ��
������������ ()�� �ӿ�? + ��ư(�α׾ƿ�, ���ο� �̾߱�, ��������+ȸ��Ż��, �� ����, �� ����) ���� ����
��� â���� ���� ����� ��� �α��� â���� �ѱ��
-->

<div class="menu-wrap">
	<form name="form" method="post" name = mainform>
	<ul class="menu">
	<li><input class="Btn" type="button" value="My Diary" onclick="javascript:window.location='mydiary.jsp'"></li>
	<li><input class="Btn" type="button" value="New Diary" onclick="javascript:window.location='writeDiary.jsp'"></li>
	<li><input class="Btn" type="button" value="Logout" onclick="javascript:logout()"></li>
	<li><input class="Btn" type="button" value="Mypage" onclick="javascript:window.location='mypage.jsp'"></li>
	</ul>
	</form>
</div>

<% 
	
	String userId = (String)session.getAttribute("USERID");
	Member memberInfo = null;
	int userNum;
	
	//����(�α���)Ȯ�� �� ù �������� �̵�
	if(userId == null){
		response.sendRedirect("First.jsp");
	}

	//id�� ��� ���� ��������
	GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberinfo.getMemberInfo(userId);
	
	//��� ��ȣ ����
	userNum = memberInfo.getMember_num();

	//������ �� ����
	String pageNumberStr = request.getParameter("page");
	
	int pageNumber = 1;
	
	//�Ѿ�� ������ ���� ������ 1�� ����
	if (pageNumberStr != null) {
		pageNumber = Integer.parseInt(pageNumberStr);
	}

	ConvertNumToIdSer connum = ConvertNumToIdSer.getInstance();
	
//	GetJournalListService dayListService = GetJournalListService.getInstance();
//	JournalListView viewData = dayListService.getJournalList(pageNumber);
	GetDayListSer getdaysSer = GetDayListSer.getInstance();
	DaysView viewData = getdaysSer.getDayList(pageNumber);
	
	GetReplyListSer getreplylistSer = GetReplyListSer.getInstance();
	int[][] dnum_rec = getreplylistSer.getReplyCount();
	
%>


<%= memberInfo.getMember_name() %> �� �ӿ�?

<jsp:setProperty name = "day" property = "member_snum" param = "userNum" />

<% 

	day.setMember_snum(userNum); 


  if (viewData.isEmpty()) { %>
��ϵ� �޽����� �����ϴ�.
<%  } else { /* �޽��� �ִ� ��� ó�� ���� */ %>


<DIV class="table">
	<TABLE class=__se_tbl style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; 
	BORDER-BOTTOM: medium none; COLOR: ; BORDER-LEFT: medium none" cellSpacing=0 cellPadding=0 border=0 
	_nWidth="660" _nHeight="134" _se2_tbl_template="14" _nResizedWidth="undefined" 
	_nResizedHeight="undefined">
		<TBODY>
		<TR>
			<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; 
			BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; 
			TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; 
			WIDTH:50px; BACKGROUND-COLOR: #6284ab">
				<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: ����,gulim">
				<STRONG>NO</STRONG></SPAN></P></TD>
			<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 500px; BACKGROUND-COLOR: #6284ab">
				<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: ����,gulim"><STRONG>TITLE</STRONG></SPAN></P></TD>
			<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 70px; BACKGROUND-COLOR: #6284ab">
				<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: ����,gulim"><STRONG>Writer</STRONG></SPAN>&nbsp;</P></TD>
			<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 40px; BACKGROUND-COLOR: #6284ab">
		</TR>
	
	<%
		//	for (Bulletin journalList : viewData.getJournalList()) {
			
			for (Days dayList : viewData.getDayList()) {
				
			
	%>
	
	<TR>
		<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; FONT-WEIGHT: normal; COLOR: #3d76ab; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 51px; BACKGROUND-COLOR: #ffffff">
		<P>
		
		<%= dayList.getDay_num() %>
		
		</P></TD>
		<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 469px; BACKGROUND-COLOR: #ffffff">
		<P>
		<a href="readDay.jsp?dnum=<%= dayList.getDay_num() %>&mnum=<%= userNum %>">
		<%= dayList.getDay_title() %>  </a>
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
		<% } %>
		</P></TD>
		<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 45px; BACKGROUND-COLOR: #ffffff">
		
		<!-- ȸ�� ��ȣ���� ID�� �ߵ��� ����, ID�� ��ȯ���ִ� ���� �ʿ�? -->
		<P><%= connum.getMemberId(dayList.getMember_num()) %></P></TD>
		
		<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 45px; BACKGROUND-COLOR: #ffffff">
		<P><%= dayList.getHits() %></P></TD>
	</TR>
	<%  	} %>
	</table>
	
	
	<%  	for (int i = 1 ; i <= viewData.getPageTotalCount() ; i++) { %>
	<ul class="list">
		<li><a href="Main.jsp?page=<%= i %>"><%= i %></a><li>
	</ul> 
	<%  	} %>
	
	<%  } /* �޽��� �ִ� ��� ó�� �� */ %>

</DIV>






</body>
</html>
