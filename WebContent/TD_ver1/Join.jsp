
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="wpjsp.model.Member"%>
<%@ page import="java.sql.*"%>



<%
	request.setCharacterEncoding("euc-kr");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Travel Diary</title>
<script type="text/javascript">
function formCheck(){
	
	//null check
	if(document.joinForm.member_name.value=="") window.alert("이름!")
	else if(document.joinForm.member_pwinfo.value=="") window.alert("질문작성")
	else if(document.joinForm.member_pwan.value=="") window.alert("답해죠")
	//중복 check
	else if(document.joinForm.result.value !="yes") window.alert("중복화깅~")
	//일치 check
	
	//비밀번호, 확인 창 비워주기
	else if(document.joinForm.ok.value != "~일치~") window.alert("비밀번호 다시~")
	else document.joinForm.submit()
	
}

function checkId(){
	var sid = document.joinForm.member_id.value
	window.open("checkID.jsp?member_id="+sid, "", "width=400 height=150")
}

function JoinPwC(){
	var pw = document.joinForm.member_pw.value
	var pwc =document.joinForm.PWC.value
	
	if(pw == pwc)
		document.getElementById("ok").value = "~일치~"
}
</script>

<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<link href="css/style.css" rel="stylesheet"> 

<style type="text/css">
.write-wrap{
	padding: 10px 10px 10px 10px;
}

.write-wrap .button{
	right:0;
}

table th{
padding : 0 0 0 10px;
width:20%}

table td{
padding : 0 0 0 10px;}

#write{
width : 80%;}

</style>
</head>

<body>
<!-- start : page - join -->

	<!-- start : Container -->
	<div id="about" class="container color black ppagebox">
	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>	
		<!-- end : navigation -->
	
			<!-- start : Wrapper -->
			<div class="wrapper span12">
			
			<!-- start : Page Title -->
			<div id="page-title">
				<div id="page-title-inner">
				<h2><span>Join Us</span></h2>
				</div>				
			</div>
			<!-- end : Page Title -->
			
<div class="container write-wrap" style="border:none;">
	<form action="Join2.jsp" method="post" name = "joinForm" autocomplete="off">
	<table class="write" style="width:100%;">
		<tr>
			<th>NAME</th>
			<td colspan="2"><input type="text" name="member_name" size="20"></td>
		</tr>
		<tr>
			<th>ID</th>
			<td><input type="text" id = "member_id" name="member_id" size="20"></td> 
			<td><input type="button" id = "idcheck" name="idcheck" value="아이디 중복 확인 " onclick="javascript:checkId();"><br>
			<input type ="hidden" id = result value ="no"></td>
		</tr>
		<tr>
			<th scope="row">PW</th>
			<td colspan="2"><input type="password" name="member_pw" size="20"></td>
		</tr>
		<tr>
			<th scope="row">PW확인</th>
			<td><input type="password" name="PWC" onKeyUp="JoinPwC()"size="20"></td>
			<td><input type="text" id="ok" value="같은 비밀번호 입력" readonly style="border: 0px;"></td> 
		</tr>
		<tr>
			<th scope="row">질문</th>
			<td colspan="2"><input type="text" name="member_pwinfo" size="20"></td>
		</tr>
		<tr>
			<th scope="row">질문의 답</th>
			<td colspan="2"><input type="text" name="member_pwan" size="20"></td>
		</tr>
		<tr>
		<th scope="row">Email</th>
		<td colspan="2"><input type="text" name="member_email" size="20"></td>
		</tr>
	</table>	
	<center><input type="button" value="회원가입" onClick="javascript:formCheck()"></center>
</form>
</div>
</div>
</div>




</body>
</html>
