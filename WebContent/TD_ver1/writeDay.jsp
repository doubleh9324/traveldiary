<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="wpjsp.model.Member"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.model.Diary"%>
<%@page import="wpjsp.model.DiaryListView"%>
<%@page import="wpjsp.service.GetDiaryListSer"%>
<%@ page contentType="text/html; charset=euc-kr" %>

<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

		
	<title>새 이야기 남김</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>



<script type="text/javascript">
function checkF(){
	var title = document.getElementById("title").value;
	var day = documant.getElementById("day").value;
	
	if(title == ""){
		window.alert('제목을 입력해주세요');
		return false;
	} else if(day == ""){
		window.alert('내용을 입력해주세요');
		return false;
	} else
		return true;
}

function setday() {

	//select된 dvol 찾아와서 day구간 재설정
	var dvol = $("dvol").val();
	var ndvol = $("#seldiary option:selected").val();
	
	var re = window.confirm("입력한 내용이 지워질거야 그래도 바꿀꼬야?");
	
	if(re==true){
		if(dvol != ndvol){
			window.location = "writeDay.jsp?dvol="+ndvol;
		}
	}
}



function pickdate(obj){
	
	$(obj).datepicker().datepicker("show");

}
	
//페이지가 로드되면 dvol 날짜관련
$(document).ready(function(){
	//get방식으로 받아온 dvol을 input dvol에 저장했으니 불러와서 select 초기화, setday 
	var dvol = $("#dvol").val();
	
    $("#seldiary").val(dvol).prop("selected", true);
    
    $("#day_time").datepicker({
    	dateFormat: 'dd/mm/yy',
    	//input sday에 저장된 값으로 최소 ,최대 날짜 지정
    	minDate : new Date(document.getElementById("sday").value),
    	maxDate : new Date(document.getElementById("eday").value)
    });
    /*
    //set pcode
    var p_diary = document.getElementById("pcode").value;

	//뭘어쩌라는거지
   // $("input:radio[name='privacy']:radio[value=+p_diary+]").attr("checked", true);
	
	if(p_diary == 0){
		$("input:radio[name='privacy']:radio[value=0]").attr("checked", true);
	} else if(p_diary == 1){
		$("input:radio[name='privacy']:radio[value=1]").attr("checked", true);
	} else if(p_diary == 2){
		$("input:radio[name='privacy']:radio[value=2]").attr("checked", true);
	}
    */
});

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
<!-- start : page - write day -->

	<!-- start : Container -->
	<div id="diarylist" class="container color white ppagebox">

	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>	
		<!-- end : navigation -->
	
		<!-- start : Wrapper -->
		<div class="wrapper span12">
	
		<!-- start: Page Title -->
		<div id="page-title">

			<div id="page-title-inner">

				<h2><span>New Day</span></h2>

			</div>	

		</div>
<div class="container write-wrap" style="border:none;">
<form action = "writeDay2.jsp" method = "post" onsubmit="return checkF();" autocomplete="off">
<table class="write" style="width:100%;">


	<tr>
		<th>Diary</th>
		<td>
<%
		String userId = (String)session.getAttribute("USERID");

		//세션(로그인)확인 후 첫 페이지로 이동
		if(userId == null){
			//알림창 띄우기
			response.sendRedirect("First.jsp");
		}
		int dvol = Integer.parseInt(request.getParameter("dvol"));
		int ndvol = 0;
		//id로 멤버 정보 가져오기
		GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
		Member memberInfo = getmemberinfo.getMemberInfo(userId);
		
		int userNum = memberInfo.getMember_num();
		
		GetDiaryListSer diarylistSer = GetDiaryListSer.getInstance();
		DiaryListView viewdata = diarylistSer.getmDiaryList(1, userNum);
		
		SimpleDateFormat dateform = new SimpleDateFormat("yyyy, MM, dd");
		
%>
			<input id="dvol" type="hidden" value="<%=dvol %>">
			<input id="ndvol" type="hidden">
			
			
<%
		String sday = null;
		String eday = null;
		String pcode = null;
		
		//지정된 다이어리가 있으면
		if(dvol!=0){
			for(Diary diaryList : viewdata.getDiaryList()){
				if(diaryList.getDiary_volum()==dvol){
					sday = dateform.format(diaryList.getStart_day());
					eday = dateform.format(diaryList.getEnd_day());
					pcode = diaryList.getP_code();
				}
			}
		}
%>
			<select id="seldiary" name="dvol" onchange="javascript:setday();" style="width:100%">
				<option value=0>선택</option>
<%				
				for(Diary diaryList : viewdata.getDiaryList()){
%>
					<option value=<%=diaryList.getDiary_volum()%>><%=diaryList.getDiary_title()%></option>

<% 					
				}
%>
					</select>
		</td>
		<td colspan="2">
		<input id="pcode" type="hidden" value="<%= pcode %>">
		<input id="sday" type="hidden" value="<%= sday %>">
		<input id="eday" type="hidden" value="<%= eday %>">
		<input type="text" value="날짜" name="day_time" id="day_time" 
		style="width:30%; height:100%; text-align: center" onClick="javascript:pickdate(this)"><br>
		</td>
	</tr>
	<tr>
		<th>Title</th>
		<td colspan="3">
			<input type="text" name="day_title" id="title" style="width:100%; size: 20">
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
		<textarea rows="" cols="" name="day" id="day" style="width:100%;height:300px;"></textarea></td>
	</tr>
</table>
<center><span><input class="button btn-warning" type="submit" value="New!"></span></center>

</form>
</div>


		</div>
		<!-- end : Wrapper -->
		
	</div>
	<!-- end : Container -->
	
<!-- end : page - write day -->
</body>
</html>