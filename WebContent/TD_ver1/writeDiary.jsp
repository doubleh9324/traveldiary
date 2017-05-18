<%@page import="java.util.Calendar"%>
<%@page import="wpjsp.service.GetMemberInfoSer"%>
<%@page import="wpjsp.model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>



<script type="text/javascript">
function checksel(val){
	var form = document.writeDiary;
	
	document.getElementById("ectloc_over").style.display="none";
	document.getElementById("ectloc_in").style.display="none";
	
	if(val == 1){
		form.location_over.style.display="none";
		form.location_in.style.display=""; 
	} else if(val == 2){
		form.location_in.style.display="none";
		form.location_over.style.display="";
	}
}

function showect(val){
	var form = document.writeDiary;
	
	if(val=='oect'){
		document.getElementById("ectloc_over").style.display="";
		document.getElementById("ectloc_in").style.display="none";
	} else if(val=='iect'){
		document.getElementById("ectloc_in").style.display="";
		document.getElementById("ectloc_over").style.display="none";
	} else {
		document.getElementById("ectloc_over").style.display="none";
		document.getElementById("ectloc_in").style.display="none";
	}
}

function checkform(){
	var form = document.writeDiary;
	
	if(form.diaryTitle.value == ""){
		window.alert("제목을 입력해주세요");
	} else
		form.submit();
}

$(function() {
	

	    $( "#start_day" ).datepicker({
	    	dateFormat: 'dd/mm/yy',
	    	onClose: function( selectedDate ) {    
               $("#end_day").datepicker( "option", "minDate", selectedDate );
	    	}
	    });
	
	    $( "#end_day" ).datepicker({
	    	dateFormat: 'dd/mm/yy',
	    	onClose: function( selectedDate ) {    
               $("#start_day").datepicker( "option", "maxDate", selectedDate );
	    	}
	    });
	
});

function pickdate(obj){
	$(obj).datepicker().datepicker("show");
}

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

</style>
	
</head>
<body>
<!-- start : page - diary list -->
<div id="diarylist" class="container color yellow ppagebox">
	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>
		<!-- end : navigation -->
	
		<!-- start : Wrapper -->
		<div class="wrapper span12">
	
		<!-- start: Page Title -->
		<div id="page-title">

			<div id="page-title-inner">

				<h2><span>New Diary</span></h2>

			</div>	

		</div>

<% 
	String userId = (String)session.getAttribute("USERID");
	Member memberInfo = null;
	int userNum;
	
	//세션(로그인)확인 후 첫 페이지로 이동
	if(userId == null){
		response.sendRedirect("First.jsp");
	}
	
	//id로 멤버 정보 가져오기
	GetMemberInfoSer getmemberinfo = GetMemberInfoSer.getInstance();
	memberInfo = getmemberinfo.getMemberInfo(userId);
	
	//멤버 번호 저장
	userNum = memberInfo.getMember_num();
	
	
%>

<!-- start : Page - new diary -->

	<div class="container write-wrap">
	<form action="writeDiary2.jsp" name="writeDiary" method="post" enctype="multipart/form-data" autocomplete="off">
	
	<table class="write" style="width: 100%;">
		<tr>
			<th>Title</th>
			<td><input class="d-title" type="text" name="diaryTitle" ><br></td>
		</tr>	
		<tr>	
			<th>Location</th>
			<td>
	<select class="selloc" name="location" onchange="checksel(this.value)">
		<option value=0>선택</option>
		<option value=1>국내</option>
		<option value=2>해외</option>
	</select>
			
	<select class="selloca" name="location_in" style="display:none" onchange="showect(this.value)" >
		<option value=0>선택</option>
		<option value=i1>서울</option>
		<option value=i2>인천/경기</option>
		<option value=i3>부산</option>
		<option value=i4>강원</option>
		<option value=i5>제주</option>
		<option value=i6>경상</option>
		<option value=i7>전라/충청</option>
		<option value=iect>기타</option>
	</select>
	
	
	<select class="selloca" name="location_over" style="display:none;" onchange="showect(this.value)">
		<option value=0>선택</option>
		<option value=o1>일본</option>
		<option value=o2>중국</option>
		<option value=o3>동남아</option>
		<option value=o4>미주</option>
		<option value=o5>대양주</option>
		<option value=o6>유럽</option>
		<option value=oect>기타</option>
	</select>
	

		
	<input type="text" id="ectloc_in" value="in장소를 입력해주세요" style="display:none;" onclick="this.value=''">
	<input type="text" id="ectloc_over" value="over장소를 입력해주세요" style="display:none;" onclick="this.value=''">
	<br>
				</td>
		</tr>
		<tr>
			<th>Duration</th>
			<td>
			<input class="daypick" type="text" id="start_day" readOnly name="start_day" value="시작" onclick="javascript:pickdate(this)" >
			<input class="daypick" type="text" id="end_day" readOnly name="end_day" value="끝" >
			</td>
		</tr>
		<tr>
			<th>Cover</th>
			<td><input type="file" name="cover"></td>
		</tr>
		<tr>
			<th>PRIVACY</th>
			<td>
				<input type="radio" id="privacy_0" name="privacy" value="0" />
				<label for="privacy_0">Anyone</label>
				<input type="radio" id="privacy_1" name="privacy" value="1"/>
				<label for="privacy_1">Member</label>
				<input type="radio" id="privacy_2" name="privacy" value="2"/>
				<label for="privacy_2">Owner</label>
			</td>
		</tr>
	</table>
	
	<br>
	<center>
	<button class="button btn-warning" onclick="javascript:checkform();">
	<span>New!</span></button>
	</center>
	
	</form>
	</div>
		</div>
		<!-- end : Wrapper -->
		
	</div>
	<!-- end : Container -->
	
<!-- end : page - diary list -->
</body>
</html>