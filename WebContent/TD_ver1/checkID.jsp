<%@page import="wpjsp.service.JoinSer"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="wpjsp.model.Member"%>
<%@ page import="java.sql.*"%>



<%
	request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
<title>가입</title>

<script type="text/javascript">

function checkIdClose(fId){
	opener.document.getElementById("member_id").value = fId;
	opener.document.getElementById("result").value ="yes";
	window.close();
	
	//여기 동작안됨 창 닫고 커서두기, 버튼 사용가능으로 값 바꾸기
	opner.document.getElementById("member_pw").focus();
}
</script>
</head>
<body>

<jsp:useBean id="member" class="wpjsp.model.Member" scope="session" />

	<jsp:setProperty name="member" property="*" />
	<% 

	boolean ok = false;
	boolean lenFlag = false;
	boolean dupFlag = false;
	//가입하기 위한 서비스 객체 생성 후 초기화
	//JoinService joinservice = JoinService.getInstance();
	
	JoinSer joinservice = JoinSer.getInstance();
	
	//아이디 중복 확인 할 것
	String id = request.getParameter("member_id");
	

	%>
	
	<form method = "post" action="checkID.jsp" name = idcheck>
	
	
	
	<%
		if(id.length() > 12){
			%>
			<%=id %>너무 길어!
			<br> ID :
	<input type="text" name = "member_id"  />
	<input type = "submit" value ="중복확인" />
			<%
		}
		else{
				//영어, 숫자만 가능하도록 조건 추가
					//아이디 중복 검사 결과 중복이면
					if(joinservice.Check_join(id))
					{
						%>
	<%=id %> 중복이야!
	<br> ID :
	<input type="text" name = "member_id"  />
	<input type = "submit" value ="중복확인" />
	<%
					}else{
	%>
	<%=id %> 사용가능
	<input type="button" value="사용"
		onclick="javascript:checkIdClose('<%=id%>');">
	<%
					}
				}

	
%>



</form>

</body>
</html>
