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
<title>����</title>

<script type="text/javascript">

function checkIdClose(fId){
	opener.document.getElementById("member_id").value = fId;
	opener.document.getElementById("result").value ="yes";
	window.close();
	
	//���� ���۾ȵ� â �ݰ� Ŀ���α�, ��ư ��밡������ �� �ٲٱ�
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
	//�����ϱ� ���� ���� ��ü ���� �� �ʱ�ȭ
	//JoinService joinservice = JoinService.getInstance();
	
	JoinSer joinservice = JoinSer.getInstance();
	
	//���̵� �ߺ� Ȯ�� �� ��
	String id = request.getParameter("member_id");
	

	%>
	
	<form method = "post" action="checkID.jsp" name = idcheck>
	
	
	
	<%
		if(id.length() > 12){
			%>
			<%=id %>�ʹ� ���!
			<br> ID :
	<input type="text" name = "member_id"  />
	<input type = "submit" value ="�ߺ�Ȯ��" />
			<%
		}
		else{
				//����, ���ڸ� �����ϵ��� ���� �߰�
					//���̵� �ߺ� �˻� ��� �ߺ��̸�
					if(joinservice.Check_join(id))
					{
						%>
	<%=id %> �ߺ��̾�!
	<br> ID :
	<input type="text" name = "member_id"  />
	<input type = "submit" value ="�ߺ�Ȯ��" />
	<%
					}else{
	%>
	<%=id %> ��밡��
	<input type="button" value="���"
		onclick="javascript:checkIdClose('<%=id%>');">
	<%
					}
				}

	
%>



</form>

</body>
</html>
