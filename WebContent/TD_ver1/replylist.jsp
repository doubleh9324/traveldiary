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
	var result = window.confirm('���ش�?');

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

<!-- readjournal���� include�� ���Խ�Ű�� 
��� ����Ʈ ���� �����ְ�
����� �г���, �Է�â, ��� ��ư �����
�ڱ� ����϶��� ����, ���� ��ư ����� -->
<%
	int dnum = Integer.parseInt(request.getParameter("dnum"));
	int userNum = Integer.parseInt(request.getParameter("userNum"));

	//������ �ѹ� �Ѱܿ� �� �޾ƿ���
	String pageNumberStr = request.getParameter("page");
	
	int pageNumber = 1;
	
	//������ 1�������� ����
	if (pageNumberStr != null) {
		pageNumber = Integer.parseInt(pageNumberStr);
	}
	
	GetReplyListSer getreplylistser = GetReplyListSer.getInstance();
	ReplyListView viewData = getreplylistser.getReplyList(pageNumber, dnum);
	
	ConvertNumToIdSer connum = ConvertNumToIdSer.getInstance();
		
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat formatter2 = new SimpleDateFormat("HH:mm:ss");
	
	//���� ��¥�� today ������ ����
	Date date = new Date();
	String today = formatter.format(date);
	String reday = null;
	
	int renum;
	
	int re=0;
	if(viewData.isEmpty()){ %>
<table><tr><td>����� �����ϴ�.</td></tr></table> <br>
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
			//�� ��¥�� ���ؼ� ��� ��¥�� ���� ��¥�� ���� ���
			if(reday.compareTo(today)==0){
				//�ð����� ǥ��
		%>
		<%= formatter2.format(replyList.getTime())%> 
		<%
			} else {
				//��� �� ��¥�� ���ú��� ������ ���
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
<span>����</span></button>
<button class="button btn-success reply" onclick="modifyRp(<%= renum%>,<%=dnum%>, <%= userNum%>, <%=re%>)" id="modDone<%=re%>" style="display:none;">
<span>�Ϸ�</span></button>
<button class="button btn-success reply" onclick="deleteRp(<%= renum%>,<%=dnum%>, <%= userNum%>) ">
<span>����</span></button>
<button class="button btn-success reply" onclick="cancle(<%=re%>)" id="cancleBtn<%=re %>" style="display:none;">
<span>���</span></button>
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

<%  } /* �޽��� �ִ� ��� ó�� �� */ %>



</div>


</body>
</html>