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

<!-- member, journal�̶�� ��ü�� �� Ŭ������ �����Ͽ� ���� ������ �����ϰڴ�! -->
<jsp:useBean id="member" class="wpjsp.model.Member" scope="session" />
<jsp:useBean id="journal" class="wpjsp.model.Bulletin" scope="session" />

<!-- member ��ü�� �Ѱܿ� ���� �޾Ƽ� ��� set -->
<jsp:setProperty name="member" property="*" />
<!-- include�� ���Խ�Ű�� -->
���� ���ž�
<% 
	
	String userId = (String)session.getAttribute("USERID");
	Member memberInfo = null;
	int userNum;
	
	//����(�α���)Ȯ�� �� ù �������� �̵�
	if(userId == null){
	// ���� �˸�â�� ��� �� �ʿ䰡 �������� �ٷ� �α���â���� �̵��ϴ°͵� �������Ͱ���
	//	out.println("<script> alert('�α�������'); ");
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


<%= memberInfo.getMember_name() %> �� �ӿ�?

<jsp:setProperty name = "journal" property = "member_snum" param = "userNum" />

<% journal.setMember_snum(userNum); 


  if (viewData.isEmpty()) { %>
��ϵ� �޽����� �����ϴ�.
<%  } else { /* �޽��� �ִ� ��� ó�� ���� */ %>


<DIV>
<TABLE class=__se_tbl style="BORDER-TOP: medium none; BORDER-RIGHT: medium none; BORDER-BOTTOM: medium none; COLOR: ; BORDER-LEFT: medium none" cellSpacing=0 cellPadding=0 border=0 _nWidth="660" _nHeight="134" _se2_tbl_template="14" _nResizedWidth="undefined" _nResizedHeight="undefined">
<TBODY>
<TR>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH:50px; BACKGROUND-COLOR: #6284ab">
<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: ����,gulim"><STRONG>NO</STRONG></SPAN></P></TD>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 500px; BACKGROUND-COLOR: #6284ab">
<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: ����,gulim"><STRONG>TITLE</STRONG></SPAN></P></TD>
<TD style="BORDER-TOP: #466997 1px solid; HEIGHT: 5px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #466997 1px solid; FONT-WEIGHT: normal; COLOR: #ffffff; PADDING-BOTTOM: 2px; TEXT-ALIGN: left; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 70px; BACKGROUND-COLOR: #6284ab">
<P style="TEXT-ALIGN: center; MARGIN-LEFT: 0px" align=center><SPAN style="FONT-FAMILY: ����,gulim"><STRONG>Writer</STRONG></SPAN>&nbsp;</P></TD>
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
<%= journalList.getJournal_title() %> </a> (��ۼ�)

</P></TD>
<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 45px; BACKGROUND-COLOR: #ffffff">

<!-- ȸ�� ��ȣ���� ID�� �ߵ��� ����, ID�� ��ȯ���ִ� ���� �ʿ�? -->
<P><%= connum.getMemberId(journalList.getMember_snum()) %></P></TD>

<TD style="BORDER-TOP: medium none; HEIGHT: 18px; BORDER-RIGHT: medium none; BORDER-BOTTOM: #ebebeb 1px solid; COLOR: #3d76ab; PADDING-BOTTOM: 2px; PADDING-TOP: 3px; PADDING-LEFT: 4px; BORDER-LEFT: medium none; PADDING-RIGHT: 4px; WIDTH: 45px; BACKGROUND-COLOR: #ffffff">
<P><%= journalList.getHits() %></P></TD>

</TR>


<%  	} %>
</table>



<%  	for (int i = 1 ; i <= viewData.getPageTotalCount() ; i++) { %>
<a href="memberJn.jsp?page=<%= i %>">[<%= i %>]</a> 
<%  	} %>

<%  } /* �޽��� �ִ� ��� ó�� �� */ %>

</DIV>


�޴��� �־�߰ڴ°�


</body>
</html>