<%@page import="wpjsp.service.DeleteDiarySer"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
function closeDiary(userNum){
	opener.location.href='mydiary.jsp?mnum='+userNum;
	window.close();
}

</script>
</head>
<body>
<%
	int dvol = Integer.parseInt(request.getParameter("dvol"));
	int userNum = Integer.parseInt(request.getParameter("userNum"));
	
	DeleteDiarySer deletediarySer = DeleteDiarySer.getInstance();
	deletediarySer.deleteDay(dvol, userNum);

%>

삭제 완료
<input type="button" value="확인" onclick="javascript:closeDiary(<%=userNum%>)">
</body>
</html>