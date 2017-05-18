<%@page import="wpjsp.model.Bulletin"%>
<%@page import="wpjsp.model.JournalListView"%>
<%@page import="wpjsp.model.Member"%>




<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<!-- member, journal이라는 객체를 각 클래스를 참조하여 세션 범위로 생성하겠다! -->
<jsp:useBean id="member" class="wpjsp.model.Member" scope="session" />
<jsp:useBean id="journal" class="wpjsp.model.Bulletin" scope="session" />

<!-- member 객체에 넘겨온 값을 받아서 모두 set -->
<jsp:setProperty name="member" property="*" />
<!-- include로 포함시키기 -->
내가 쓴거야
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

	GetMemberInfoService getmemberinfo = GetMemberInfoService.getInstance();
	memberInfo = getmemberinfo.getMemberInfo(userId);
	
	userNum = memberInfo.getMember_num();

	String pageNumberStr = request.getParameter("page");
	
	int pageNumber = 1;
	if (pageNumberStr != null) {
		pageNumber = Integer.parseInt(pageNumberStr);
	}

	ConvertNumToIdService connum = ConvertNumToIdService.getInstance();
	
	GetMemberJnListService memberjnlistservice = GetMemberJnListService.getInstance();
	JournalListView viewData = memberjnlistservice.getMemberJnList(pageNumber,userNum);
%>


<%= memberInfo.getMember_name() %> 님 앙영?

<jsp:setProperty name = "journal" property = "member_snum" param = "userNum" />

<% journal.setMember_snum(userNum); 


  if (viewData.isEmpty()) { %>
등록된 메시지가 없습니다.
<%  } else { /* 메시지 있는 경우 처리 시작 */ %>


<DIV>
<TABLE class=__se_tbl style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; COLOR: ; BORDER-LEFT: medium none" cellSpacing=0 cellPadding=0 border=0 _nWidth="660" _nHeight="134" _se2_tbl_template="14" _nResizedWidth="undefined" _nResizedHeight="undefined">
<TBODY>
<TR>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH:50px; BACKGROUND-COLOR: #6284ab">
<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: 굴림,gulim"><STRONG>NO</STRONG></SPAN></P></TD>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 500px; BACKGROUND-COLOR: #6284ab">
<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: 굴림,gulim"><STRONG>TITLE</STRONG></SPAN></P></TD>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 70px; BACKGROUND-COLOR: #6284ab">
<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: 굴림,gulim"><STRONG>Writer</STRONG></SPAN>&nbsp;</P></TD>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 40px; BACKGROUND-COLOR: #6284ab">
</TR>

<%
		for (Bulletin journalList : viewData.getJournalList()) {
%>

<TR>
<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; FONT-WEIGHT: normal; COLOR: #3d76ab; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 51px; BACKGROUND-COLOR: #ffffff">
<P>

<%= journalList.getJournal_num() %>

</P></TD>
<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 469px; BACKGROUND-COLOR: #ffffff">
<P>
<a href="readJournal.jsp?jnum=<%= journalList.getJournal_num() %>&mnum=<%= userNum%>">
<%= journalList.getJournal_title() %> </a> (댓글수)

</P></TD>
<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 45px; BACKGROUND-COLOR: #ffffff">

<!-- 회원 번호말고 ID가 뜨도록 수정, ID로 변환해주는 서비스 필요? -->
<P><%= connum.getMemberId(journalList.getMember_snum()) %></P></TD>

<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 45px; BACKGROUND-COLOR: #ffffff">
<P><%= journalList.getHits() %></P></TD>

</TR>


<%  	} %>
</table>



<%  	for (int i = 1 ; i <= viewData.getPageTotalCount() ; i++) { %>
<a href="memberJn.jsp?page=<%= i %>">[<%= i %>]</a> 
<%  	} %>

<%  } /* 메시지 있는 경우 처리 끝 */ %>

</DIV>


메뉴가 있어야겠는걸


</body>
</html>