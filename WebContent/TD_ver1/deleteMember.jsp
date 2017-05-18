<%@page import="wpjsp.service.DeleteMemberSer"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>



<script type="text/javascript">
function finish(){
	
	opener.location.reload();
	window.close(); 
}


</script>
</head>
<body>



<jsp:useBean id="member" class="wpjsp.model.Member" scope="session" />
<jsp:setProperty name="member" property="*" />
그동안 고마워써~~
<%

	int userNum = Integer.parseInt(request.getParameter("userNum"));

	
	//회원 삭제
	DeleteMemberSer deletemember = DeleteMemberSer.getInstance();
	deletemember.deleteMember(userNum);
	
	if(session != null)
		session.invalidate();
	%>
	
<input type = "button" value = "확인" onclick = "javascript:finish()" >

	
	




</body>
</html>