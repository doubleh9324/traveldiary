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

<!-- 스크랩 하는 경우 member의 scrap_list와
bulletin의 scrap_count 업데이트 -->



<%
	int userNum = Integer.parseInt(request.getParameter("userNum"));
	int dnum = Integer.parseInt(request.getParameter("dnum"));
	
	ScrapSer scrapser = ScrapSer.getInstance();
	
	//이미 스크랩을 한 글이라면
	if(scrapser.scrapDay(userNum, dnum)==-1){
%>
이미 해써 돌아가
<input type="button" value="확인" onclick="javascript:scrapClose()">
<% 
	}else{
%>
스크랩 완료
<input type="button" value="확인" onclick="javascript:scrapClose()">


<% }
	
%>

<input type="button" value="스크랩 목록보기" onclick="javascript:goscrapList()">

</body>
</html>