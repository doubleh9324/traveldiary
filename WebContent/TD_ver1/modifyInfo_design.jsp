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
	
	if(pw == pwc){
		document.getElementById("ok").value = "~일치~"
		}
}


function onSubmit(){
	
	var form = document.modifyInfo;
	var result = window.confirm("수정한당?");
	
	if(result){
		window.open("", "modifyInfo", "width=300 height=200");
		
		form.target = "modifyInfo";
		form.action="updateMemberInfo.jsp";
		
		form.submit();
	}
}

function onSubmit2(mnum){
	
	var result = window.confirm("정말?????");
	
	if(result){
		window.open("deleteMember.jsp?userNum="+mnum,"","width=200 height=200");
	}
}
</script>

<style type="text/css">
/*Custom*/

table th{
padding : 0 0 0 10px;
width:20%}

table td{
padding : 0 0 0 10px;}

#write{
width : 80%;
}

</style>

</head>
<body>

<!-- start : info table -->
<div class="container wirte-wrap">
<form method="post" name = "modifyInfo">
<table class="wrtie" style="width:60%; margin:auto; ">
	<tr>
		<th><input type = "hidden" name = "member_num" value = "<%= memberInfo.getMember_num() %>">
			ID</th>
		<td><input type = "text" name = "member_id" size="20" value = "<%= memberInfo.getMember_id() %>" readonly></td>
	</tr>
	<tr>
		<th>이름</th>
		<td><input type = "text" name="member_name" size="20" value = "<%= memberInfo.getMember_name()%>" readonly></td>
	</tr>
	<tr>
		<th>PW</th>
		<td><input type="password" name="member_pw" size="20"></td>
	</tr>
	<tr>
		<th>PW 확인</th>
		<td ><input type="password" name="PWC" onKeyUp="JoinPwC()"size="20">
			<input type="text" id="ok" value="X" readonly 
				style="text-align:center; 0px;background-color: transparent; width:15%; border:none;"></td>
	</tr>
	<tr> 
		<th>질문</th>
		<td><input type="text" name="member_pwinfo" value="<%= memberInfo.getMember_pwinfo() %>" size="20"></td>
	</tr>
	<tr>	
		<th>질문의 답</th>
		<td><input type="text" name="member_pwan" value="<%= memberInfo.getMember_pwan()%>" size="20"></td>
	</tr>
	<tr>
		<th>Email</th>
		<td><input type="text" name="member_email" value="<%= memberInfo.getMember_email() %>" size="20"></td>
	</tr>
</table>

</form>
</div>
<!-- end : info table -->
<div class="container">
<center>
<button class="button btn-inverse" onclick="javascript:onSubmit()">
<span>정보수정</span></button>


<button class="button btn-inverse" onclick="javascript:onSubmit2(<%=userNum%>)">
<span>회원탈퇴</span></button>
</center>
</div>




</body>
</html>