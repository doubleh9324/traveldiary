<%@page import="wpjsp.model.Reply"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script type="text/javascript">
function closeRp(){
	opener.parent.location.reload();
	window.close();
}

</script>

</head>
<body>


<%
	int jnum = Integer.parseInt(request.getParameter("jnum"));
	int mnum = Integer.parseInt(request.getParameter("mnum"));
	int renum = Integer.parseInt(request.getParameter("renum"));
	String reply = request.getParameter("reply");
	
	
	//이게 여기있어도 되는건가..
	Reply Reply = new Reply();
	Reply.setMember_num(mnum);
	Reply.setJournal_reply(jnum);
	Reply.setReply(reply);
	Reply.setReply_num(renum);

	UpdateReplyService updatereply = UpdateReplyService.getInstance();
	updatereply.update(Reply);
	
%>

수정완료

<input type="button" value="확인" onclick="javascript:closeRp()">
	

</body>
</html>