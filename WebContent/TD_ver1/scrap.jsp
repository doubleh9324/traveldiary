<%@page import="wpjsp.service.ScrapSer"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script type="text/javascript">
function scrapClose(){
	window.close();
}

function goscrapList(){
	opener.location.href='Main_design.jsp#mypage';
	window.close();
}

</script>

</head>
<body>

<!-- ��ũ�� �ϴ� ��� member�� scrap_list��
bulletin�� scrap_count ������Ʈ -->



<%
	int userNum = Integer.parseInt(request.getParameter("userNum"));
	int dnum = Integer.parseInt(request.getParameter("dnum"));
	
	ScrapSer scrapser = ScrapSer.getInstance();
	
	//�̹� ��ũ���� �� ���̶��
	if(scrapser.scrapDay(userNum, dnum)==-1){
%>
�̹� �ؽ� ���ư�
<input type="button" value="Ȯ��" onclick="javascript:scrapClose()">
<% 
	}else{
%>
��ũ�� �Ϸ�
<input type="button" value="Ȯ��" onclick="javascript:scrapClose()">


<% }
	
%>

<input type="button" value="��ũ�� ��Ϻ���" onclick="javascript:goscrapList()">

</body>
</html>