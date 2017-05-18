<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import = "java.net.URLDecoder"%>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "wpjsp.model.JournalListView" %>
<%@ page import = "wpjsp.model.Bulletin"%>
<%@ page import = "wpjsp.model.Member"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script type="text/javascript">

function JoinPwC(){
	var pw = document.modifyInfo.member_pw.value
	var pwc =document.modifyInfo.PWC.value
	
	if(pw == pwc)
		document.getElementById("ok").value = "~일치~"
}

/*
function modifyInfoClose(){
	alert('변경완료');
	window.close();
}
*/

</script>

<style type="text/css">

 body{
background-color:#3C5064;
font-family:돋움;
color:#E4E8EB;
font-size:12px;
}


input[type=submit]{
border:0px; 
background-color:transparent;
font-family:돋움;
color:#E4E8EB;
font-size:12px;
margin:5px; 
left:50%
}

input[type=text], input[type=password]{
border:1px solid #E4E8EB;
background-color:transparent;
font-family:돋움;
color:#E4E8EB;
font-size:12px;
text-align:center;
}

p{
text-align:center;
}

img{
display:block;
margin-left:auto;
margin-right:auto;
top:50%;
margin-top: 160px;
}
 

</style>

</head>
<body>
비밀번호 변경안하고 수정완료하는 경우/특정 항목만 수정하는 경우 ? = 따로 분리해줄 필요 없음 값 다 받아서 넘기고 업데이트
<form action="updateMemberInfo.jsp" method="post" name = "modifyInfo">

<% 
	String userId = (String)session.getAttribute("USERID");
	Member memberInfo = null;

	GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberinfo.getMemberInfo(userId);
	

%>
<input type = "text" name = "member_num" hidden value = "<%= memberInfo.getMember_num() %>"><br>
ID <input type = "text" name = "member_id" size="20" value = "<%= memberInfo.getMember_id() %>" readonly> <br>
이름  <input type = "text" name="member_name" size="20" value = "<%= memberInfo.getMember_name()%>" readonly><br>
PW <input type="password" name="member_pw" size="20"><br>
PW 확인 <input type="password" name="PWC" onKeyUp="JoinPwC()"size="20">
		<input type="text" id="ok" value="같은 비밀번호 입력" readonly style="border: 0px;"><br> 
질문 <input type="text" name="member_pwinfo" value="<%= memberInfo.getMember_pwinfo() %>" size="20"><br>
질문의 답 <input type="text" name="member_pwan" value="<%= memberInfo.getMember_pwan()%>" size="20"><br>
Email <input type="text" name="member_email" value="<%= memberInfo.getMember_email() %>" size="20"><br>

<input type="submit" value="정보수정"> <br>
</form>

<form action="deleteMember.jsp" method="post" name="deleteMember">
<input type="submit" value="회원탈퇴">
</form>






</body>
</html>