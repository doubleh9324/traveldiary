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
<!-- member, day이라는 객체를 클래스를 참조하여 세션 범위로 생성하겠다! -->
<jsp:useBean id="member" class="wpjsp.model.Member" scope="session" />
<jsp:useBean id="day" class="wpjsp.model.Bulletin" scope="session" />

<!-- member 객체에 넘겨온 값을 받아서 모두 set -->
<jsp:setProperty name="member" property="*" />

<html>
<head>
<title>Main</title>

<script type="text/javascript">

function logout(){
	var result = window.confirm('가니?');
	
	if(result){
		window.location='Logout.jsp';
	}else{}
}
</script>

<style type="text/css">

body{
	background-color:#3C5064;
	font-family:돋움;
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
로그아웃 모듈로 다시 짤 것
고정페이지에 ()님 앙영? + 버튼(로그아웃, 새로운 이야기, 정보수정+회원탈퇴, 글 수정, 글 삭제) 모듈로 고정
모든 창에서 세션 만료될 경우 로그인 창으로 넘기기
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
	
	//세션(로그인)확인 후 첫 페이지로 이동
	if(userId == null){
		response.sendRedirect("First.jsp");
	}

	//id로 멤버 정보 가져오기
	GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberinfo.getMemberInfo(userId);
	
	//멤버 번호 저장
	userNum = memberInfo.getMember_num();

	//페이지 수 저장
	String pageNumberStr = request.getParameter("page");
	
	int pageNumber = 1;
	
	//넘어온 페이지 값이 없으면 1로 설정
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


<%= memberInfo.getMember_name() %> 님 앙영?

<jsp:setProperty name = "day" property = "member_snum" param = "userNum" />

<% 

	day.setMember_snum(userNum); 


  if (viewData.isEmpty()) { %>
등록된 메시지가 없습니다.
<%  } else { /* 메시지 있는 경우 처리 시작 */ %>


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
				<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: 굴림,gulim">
				<STRONG>NO</STRONG></SPAN></P></TD>
			<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 500px; BACKGROUND-COLOR: #6284ab">
				<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: 굴림,gulim"><STRONG>TITLE</STRONG></SPAN></P></TD>
			<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 70px; BACKGROUND-COLOR: #6284ab">
				<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: 굴림,gulim"><STRONG>Writer</STRONG></SPAN>&nbsp;</P></TD>
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
		
		<!-- 회원 번호말고 ID가 뜨도록 수정, ID로 변환해주는 서비스 필요? -->
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
	
	<%  } /* 메시지 있는 경우 처리 끝 */ %>

</DIV>






</body>
</html>
