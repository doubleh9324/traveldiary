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
	opener.parent.location.reload();
	window.close();
}

</script>
</head>
<body>

<%
	String[] checked = request.getParameterValues("chscrap");
	int mnum = Integer.parseInt(request.getParameter("mnum"));
	int[] dnum = new int[checked.length];
	for(int i=0; i<checked.length; i++){
		dnum[i] = Integer.parseInt(checked[i]);
	}
	
	ScrapSer scrapSer = ScrapSer.getInstance();
	scrapSer.unscrapDay(mnum, dnum);

%>

~해제완료~

<input type="button" value="확인" onclick="javascript:scrapClose()">

</body>
</html>