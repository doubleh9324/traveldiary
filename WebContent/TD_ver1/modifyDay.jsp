<%@page import="wpjsp.service.GetDiaryInfoSer"%>
<%@page import="wpjsp.model.Diary"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="wpjsp.service.ReadDaySer"%>
<%@page import="wpjsp.model.Days"%>
<%@page import="wpjsp.model.JournalListView"%>
<%@page import="wpjsp.model.Bulletin"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
 <%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<script type="text/javascript">
	function checkF(){
		var title = document.getElementById("title").value;
		var day = document.getElementById("day").value;
		
		if(title == ""){
			window.alert("제목을 입력해주세요");
		} else if(day == ""){
			window.alert("내용을 입력해주세요");
		} else
			document.moform.submit();
	}
	
	//페이지가 로드되면 get방식으로 받아온 dvol을 input dvol에 저장후 불러와서 select 초기화 , 날짜 설정
	$(document).ready(function(){
		var dvol = $("#dvol").val();
		
	    $("#seldiary").val(dvol).prop("selected", true);
	    
	    $("#day_time").datepicker({
	    	dateFormat: 'dd/mm/yy',
	    	//input sday에 저장된 값으로 최소 ,최대 날짜 지정
	    	minDate : new Date(document.getElementById("sday").value),
	    	maxDate : new Date(document.getElementById("eday").value)
	    });
	});
	
function pickdate(obj){
	
	$(obj).datepicker().datepicker("show");
}	
</script>

<script type="text/javascript">
//페이지가 로드되면 privacy
$(document).ready(function(){
	
    //set pcode
    var p_diary = document.getElementById("pcode").value;

	//뭘어쩌라는거지
   // $("input:radio[name='privacy']:radio[value=+p_diary+]").attr("checked", true);
	//초기화
	if(p_diary == 0){
		$("input:radio[name='privacy']:radio[value=0]").attr("checked", true);
	} else if(p_diary == 1){
		$("input:radio[name='privacy']:radio[value=1]").attr("checked", true);
	} else if(p_diary == 2){
		$("input:radio[name='privacy']:radio[value=2]").attr("checked", true);
	}
	
	//radio change
	$("input:radio[name='privacy']").click(function(){
		var rval = $(this).val();
		
		//2: 멤버, 게스트에게 아예표시하지 않음
		//1: 게스트에게 일기장은 제목만 표시(잠금표시), 일기목록은 표시하지않음, 일기는 제목만 표시(잠금표시)
		
		//일기장이 보안단계가 더 낮으면 (개인 - 멤버, 전체 : 허용안함),(멤버 - 전체 : )
		if(p_diary=="2" && (rval=="1"||rval=="0")){
			window.alert("일기장은 숨겨놓고 왜 보여조 앙대");
			$("input:radio[name='privacy']:radio[value=2]").attr("checked", true);
		} else if(p_diary==1 && rval=="0"){
			window.alert("일기장은 멤버공개야");
		}
	});
});
</script>

<style type="text/css">
/*Custom*/
.d-title {
	width: 80%;
}

.selloc{
	width: 15%;
}

.selloca{
	width: 25%;
}

.write-wrap{
	padding: 10px 10px 10px 10px;
}

.write-wrap .button{
	right:0;
}


.daypick{
	width:30%;
}

table th{
padding : 0 0 0 10px;
width:20%}

table td{
padding : 0 0 0 10px;}

#write{
width : 80%;}

textarea {

}

</style>

</head>
<body>
<!-- start : page - modify day -->

	<!-- start : Container -->
	<div id="modifyday" class="container color white ppagebox">	
	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>	
		<!-- end : navigation -->
	
		<!-- start : Wrapper -->
		<div class="wrapper span12">
	
		<!-- start: Page Title -->
		<div id="page-title">

			<div id="page-title-inner">

				<h2><span>Modify Day</span></h2>

			</div>

		</div>
		
<%
	int dnum = Integer.parseInt(request.getParameter("dnum"));
	int dvol = Integer.parseInt(request.getParameter("dvol"));
	int userNum = Integer.parseInt(request.getParameter("userNum"));
	Days day = new Days();
	String sday = null;
	String eday = null;
	
	SimpleDateFormat dateform = new SimpleDateFormat("dd/MM/yyyy");
	
	GetDiaryInfoSer diaryinfoSer = GetDiaryInfoSer.getInstance();
	Diary diaryinfo = diaryinfoSer.getDiaryInfo(dvol, userNum);
	
	ReadDaySer readdaySer = ReadDaySer.getInstance();
	day = readdaySer.read(dnum, userNum);
	
	String pcode = day.getP_code();
	
	
%>


<div class="container write-wrap" style="border:none;">
<form action="modifyDay2.jsp" method="post" name = "moform">

	<input type="hidden" value="<%= day.getDay_num() %>" id="dnum" name="dnum">
	<input id="dvol" type="hidden" value="<%=dvol %>" name="dvol">
	<input id="pcode" type="hidden" value="<%= pcode %>">
	
	<table class="write" style="width:100%;">

		<tr>
			<th>Diary</th>
			<td>
				<select id="seldiary" name="dvol" style="width:100%" disabled>
						<option value=1><%= diaryinfo.getDiary_title() %></option>
				</select>
			</td>
			<td colspan="2">
				<input id="sday" type="hidden" value="<%= diaryinfo.getStart_day() %>">
				<input id="eday" type="hidden" value="<%= diaryinfo.getEnd_day() %>">
				<input type="text" value="<%= dateform.format(day.getDay_time()) %>" name="day_time" id="day_time"
				style="width:30%; height:100%; text-align: center" onClick="javascript:pickdate(this)"><br>
			</td>
		</tr>
		<tr>
			<th>Title</th>
			<td colspan="3">
				<input type="text" value="<%= day.getDay_title() %>" 
				name="day_title" id="title"  style="width:100%; size: 20">
			</td>
		</tr>
		<tr>
			<th>Privacy</th>
			<td>
				<label for="privacy_0">
				<input type="radio" id="privacy_0" name="privacy" value="0" checked="checked">
				Anyone</label>
			</td>
			<td>
				<label for="privacy_1">
				<input type="radio" id="privacy_1" name="privacy" value="1">
				Member</label>
			</td>
			<td>
				<label for="privacy_2">
				<input type="radio" id="privacy_2" name="privacy" value="2">
				Owner</label>
			</td>
		</tr>
		<tr>
			<th>Text</th>
			<td colspan="3">
			<textarea rows="" cols="" name="day" id="day" style="width:100%;height:300px;"><%= day.getDay() %></textarea></td>
		</tr>
		</table>

<center><button class="button btn-danger" onclick="javascript:checkF();"><span>Modify!</span></button></center>
</form>
</div>

		</div>
		<!-- end : Wrapper -->
		
	</div>
	<!-- end : Container -->
	
<!--  end : page - modify day -->
</body>
</html>