<%@page import="wpjsp.service.GetMemberInfoService"%>
<%@page import="wpjsp.model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script type="text/javascript">

function modifyInfo(){
	window.open("modifyInfo.jsp","", "width=500 height=800")
}

function delmember(){
	var result = window.confirm('진짜 ?');

	if(result){
		window.open("deleteMember.jsp","", "width=300 height=200")
	} else {}
}

function scraplist(){
	
}
</script>
</head>
<body>

<% 



	String userId = (String)session.getAttribute("USERID");
	Member memberInfo = null;

	GetMemberInfoService getmemberinfo = GetMemberInfoService.getInstance();
	memberInfo = getmemberinfo.getMemberInfo(userId);
	
	//세션(로그인)확인 후 첫 페이지로 이동
	if(userId == null){
	// 굳이 알림창을 띄워 줄 필요가 있으려나 바로 로그인창으로 이동하는것도 괜찮은것같아
	//	out.println("<script> alert('로그인해줘'); ");
		response.sendRedirect("First.jsp");
	}
	
%>

<!-- 모듈화로 위쪽이나 왼쪽에 고정시킬것 -->
<input type="button" value="Scrap" onclick="window.location='scraplist.jsp'">
<input type="button" value="정보수정" onclick="javascript:modifyInfo(<%=memberInfo.getMember_num()%>)" >
<input type="button" value="회원탈퇴" onclick="javascript:delmember()">
<input type="button" value="내일기장" onclick="window.location='mydiary.jsp'">
<input type="button" value="Main" onclick="javascript:window.location='Main.jsp'">


</body>
</html>