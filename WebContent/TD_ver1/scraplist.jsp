<%@page import="wpjsp.service.ConvertNumToIdSer"%>
<%@page import="wpjsp.model.Days"%>
<%@page import="wpjsp.service.GetScrapListSer"%>
<%@page import="wpjsp.model.DaysView"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>

<%@ page import = "java.net.URLDecoder"%>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "wpjsp.service.GetDayListSer" %>
<%@ page import = "wpjsp.model.DaysView" %>
<%@ page import = "wpjsp.model.Bulletin"%>
<%@ page import = "wpjsp.model.Member"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
<title>ScrapList</title>

<script type="text/javascript">

function logout(){
	var result = window.confirm('가니?');
	
	if(result){
		window.location='Logout.jsp';
	}else{}
}

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
	
	for(var i=0; i<checkbox.length; i++){
		checkbox[i].checked = false;
	}
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

<!--
로그아웃 모듈로 다시 짤 것
고정페이지에 ()님 앙영? + 버튼(로그아웃, 새로운 이야기, 정보수정+회원탈퇴, 글 수정, 글 삭제) 모듈로 고정
모든 창에서 세션 만료될 경우 로그인 창으로 넘기기
-->
내가 스크랩을 해따<br>
<% 
	
	String userId = (String)session.getAttribute("USERID");
	Member memberInfo = null;
	int userNum;
	
	//세션(로그인)확인 후 첫 페이지로 이동
	if(userId == null){
	// 굳이 알림창을 띄워 줄 필요가 있으려나 바로 로그인창으로 이동하는것도 괜찮은것같아
	//	out.println("<script> alert('로그인해줘'); ");
		response.sendRedirect("First.jsp");
	}

	GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberinfo.getMemberInfo(userId);
	
	userNum = memberInfo.getMember_num();
	
	String spageNumberStr = request.getParameter("page");
	
	int spageNumber = 1;
	if (spageNumberStr != null) {
		spageNumber = Integer.parseInt(spageNumberStr);
	}
	
	//스크랩 글 번호 목록 가져오기
	GetScrapListSer scrapListSer = GetScrapListSer.getInstance();
	DaysView sviewData = scrapListSer.getScrapList(spageNumber, userNum);
	
	ConvertNumToIdSer connum = ConvertNumToIdSer.getInstance();
	
%>




<% 


  if (sviewData.isEmpty()) { %>
???
<%  } else { /* 메시지 있는 경우 처리 시작 */ %>


<form name="chform" method="post" >
<input type="hidden" name="mnum" value="<%= userNum%>">
<DIV>
<TABLE class=__se_tbl style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; COLOR: ; BORDER-LEFT: medium none" cellSpacing=0 cellPadding=0 border=0 _nWidth="660" _nHeight="134" _se2_tbl_template="14" _nResizedWidth="undefined" _nResizedHeight="undefined">
<TBODY>
<TR>
<td>
<input type="checkbox" id="allcheck" onclick="selectAll(this);">
</td>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH:50px; BACKGROUND-COLOR: #6284ab">
<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: 굴림,gulim"><STRONG>NO</STRONG></SPAN></P></TD>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 500px; BACKGROUND-COLOR: #6284ab">
<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: 굴림,gulim"><STRONG>TITLE</STRONG></SPAN></P></TD>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 70px; BACKGROUND-COLOR: #6284ab">
<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: 굴림,gulim"><STRONG>Writer</STRONG></SPAN>&nbsp;</P></TD>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 40px; BACKGROUND-COLOR: #6284ab">
</TR>

<%
		int chnum=0;
		for (Days dayList : sviewData.getDayList()) {
%>

<TR>
<td>
<input type="checkbox" id="chscrap" name="chscrap" value="<%= dayList.getDay_num() %>">

</td>
<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; FONT-WEIGHT: normal; COLOR: #3d76ab; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 51px; BACKGROUND-COLOR: #ffffff">
<P>

<%= dayList.getDay_num() %>

</P></TD>
<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 469px; BACKGROUND-COLOR: #ffffff">
<P>
<a href="readDay.jsp?dnum=<%= dayList.getDay_num() %>&mnum=<%= userNum %>">
<%= dayList.getDay_title() %> </a>(댓글수)

</P></TD>
<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 45px; BACKGROUND-COLOR: #ffffff">

<!-- 회원 번호말고 ID가 뜨도록 수정, ID로 변환해주는 서비스 필요? -->
<P><%= connum.getMemberId(dayList.getMember_num()) %></P></TD>
<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 45px; BACKGROUND-COLOR: #ffffff">
<P><%= dayList.getHits() %></P></TD>

</TR>


<%  	} %>
</table>



<%  	for (int i = 1 ; i <= sviewData.getPageTotalCount() ; i++) { %>
<a href="scraplist.jsp?page=<%= i %>">[<%= i %>]</a> 
<%  	} %>

<%  chnum++; } /* 메시지 있는 경우 처리 끝 */ %>

</DIV>

<input type="button" value="선택해제" onclick="javascript:selectNone()">
<input type="button" value="스크랩 해제" onclick="javascript:unscrap()">
</form> 



<form name="form" method="post">

<input type="button" value="New diary" onclick="javascript:window.location='writeDay.jsp'">
<input type="button" value="Logout" onclick="javascript:logout()">
<input type="button" value="Mypage" onclick="avascript:window.location='mypage.jsp'">
<input type="button" value="Main" onclick="javascript:window.location='Main.jsp'">


</form>




</body>
</html>
