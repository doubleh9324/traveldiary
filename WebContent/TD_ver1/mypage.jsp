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
	var result = window.confirm('��¥ ?');

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
	
	//����(�α���)Ȯ�� �� ù �������� �̵�
	if(userId == null){
	// ���� �˸�â�� ��� �� �ʿ䰡 �������� �ٷ� �α���â���� �̵��ϴ°͵� �������Ͱ���
	//	out.println("<script> alert('�α�������'); ");
		response.sendRedirect("First.jsp");
	}
	
%>

<!-- ���ȭ�� �����̳� ���ʿ� ������ų�� -->
<input type="button" value="Scrap" onclick="window.location='scraplist.jsp'">
<input type="button" value="��������" onclick="javascript:modifyInfo(<%=memberInfo.getMember_num()%>)" >
<input type="button" value="ȸ��Ż��" onclick="javascript:delmember()">
<input type="button" value="���ϱ���" onclick="window.location='mydiary.jsp'">
<input type="button" value="Main" onclick="javascript:window.location='Main.jsp'">


</body>
</html>