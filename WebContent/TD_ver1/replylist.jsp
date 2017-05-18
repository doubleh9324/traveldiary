<%@page import="wpjsp.service.ConvertNumToIdSer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="wpjsp.service.GetReplyListSer"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="wpjsp.model.Reply"%>
<%@page import="wpjsp.model.ReplyListView"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
function deleteRp(renum, dnum, userNum){
	var result = window.confirm('없앤다?');

	if(result){
		window.open("deleteReply.jsp?renum="+renum+"&dnum="+dnum+"&userNum="+userNum, "", "width=200 height=200")
	}else{}
}

function modifyRp(renum, dnum, userNum, renum){
		window.open("modifyReply.jsp?renum="+renum+"&dnum="+dnum+
				"&userNum="+userNum+"&reply="+document.getElementById("re"+renum).value, "", "width=200 height=200")
}
function cancle(renum){
	document.getElementById("re"+renum).readOnly = true;
	document.getElementById("mod"+renum).style.display="block";
	document.getElementById("modDone"+renum).style.display="none";
	document.getElementById("cancleBtn"+renum).style.display="none";
}

function modifyBtn(renum){
	document.getElementById("re"+renum).readOnly = false;
	document.getElementById("mod"+renum).style.display="none";
	document.getElementById("modDone"+renum).style.display="block";
	document.getElementById("cancleBtn"+renum).style.display="block";
}
</script>
<style type="text/css">
.reply{
padding: 0px;
background-color: transparent;}
</style>
</head>
<body>

<!-- readjournal에서 include로 포함시키기 
댓글 리스트 먼저 보여주고
사용자 닉네임, 입력창, 등록 버튼 만들기
자기 댓글일때만 수정, 삭제 버튼 만들기 -->
<%
	int dnum = Integer.parseInt(request.getParameter("dnum"));
	int userNum = Integer.parseInt(request.getParameter("userNum"));

	//페이지 넘버 넘겨온 값 받아오기
	String pageNumberStr = request.getParameter("page");
	
	int pageNumber = 1;
	
	//없으면 1페이지로 설정
	if (pageNumberStr != null) {
		pageNumber = Integer.parseInt(pageNumberStr);
	}
	
	GetReplyListSer getreplylistser = GetReplyListSer.getInstance();
	ReplyListView viewData = getreplylistser.getReplyList(pageNumber, dnum);
	
	ConvertNumToIdSer connum = ConvertNumToIdSer.getInstance();
		
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat formatter2 = new SimpleDateFormat("HH:mm:ss");
	
	//오늘 날짜를 today 변수에 저장
	Date date = new Date();
	String today = formatter.format(date);
	String reday = null;
	
	int renum;
	
	int re=0;
	if(viewData.isEmpty()){ %>
<table><tr><td>댓글이 없습니다.</td></tr></table> <br>
<% } else { %>
<div>
<table>
<%
	for(Reply replyList : viewData.getReplyList()){
		re=replyList.getReply_num();
%>
	<tr>
		<td> <b><%= connum.getMemberId(replyList.getMember_num()) %></b> </td>
		<td> <input class="reply" type="text" readonly="readonly" style="border:none;"
		value="<%= replyList.getReply() %>" id="re<%=re%>"> 
		</td>
		<td> 
		<%
			reday = formatter.format(replyList.getTime());
			//두 날짜를 비교해서 댓글 날짜가 오늘 날짜와 같을 경우
			if(reday.compareTo(today)==0){
				//시간으로 표시
		%>
		<%= formatter2.format(replyList.getTime())%> 
		<%
			} else {
				//댓글 쓴 날짜가 오늘보다 예전일 경우
		%>
		<%= formatter.format(replyList.getTime()) %>
		<% } %>		
		</td>
		<td> 
		<% 
			if(userNum == replyList.getMember_num()){
				renum = replyList.getReply_num();
		%>
		<div class="reply_button">
<button class="button btn-success reply" onclick="modifyBtn(<%=re%>)" id="mod<%=re%>">
<span>수정</span></button>
<button class="button btn-success reply" onclick="modifyRp(<%= renum%>,<%=dnum%>, <%= userNum%>, <%=re%>)" id="modDone<%=re%>" style="display:none;">
<span>완료</span></button>
<button class="button btn-success reply" onclick="deleteRp(<%= renum%>,<%=dnum%>, <%= userNum%>) ">
<span>삭제</span></button>
<button class="button btn-success reply" onclick="cancle(<%=re%>)" id="cancleBtn<%=re %>" style="display:none;">
<span>취소</span></button>
		</div>
		<%
			} else {}
		%> 
		
		
		</td>
	</tr>
	
<% } %>
</table>
<br>


<% // 	for (int i = 1 ; i <= viewData.getPageTotalCount() ; i++) { %>
<!-- <a href="replylist.jsp?page=">[]</a> -->
<% // 	} %>

<%  } /* 메시지 있는 경우 처리 끝 */ %>



</div>


</body>
</html>