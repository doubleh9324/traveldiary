<%@page import="wpjsp.model.Diary"%>
<%@page import="wpjsp.service.GetDiaryInfoSer"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="wpjsp.model.Days"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<script type="text/javascript">
//페이지가 로드되면 get방식으로 받아온 정보로 input에 저장후 불러와서 select 초기화 , 날짜 설정
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
</script>

</head>
<body>
<!-- start : page - modify diary -->

	<!-- start : Container -->
	<div id="modifydiary" class="container color yellow ppagebox">	
	
		<!-- start : navigation -->
		<%@include file="menu_top.html" %>	
		<!-- end : navigation -->
	
		<!-- start : Wrapper -->
		<div class="wrapper span12">
	
		<!-- start: Page Title -->
		<div id="page-title">

			<div id="page-title-inner">

				<h2><span>Modify Diary</span></h2>

			</div>

		</div>
		
<%
	int dvol = Integer.parseInt(request.getParameter("dvol"));
	int userNum = Integer.parseInt(request.getParameter("userNum"));
	
	String sday = null;
	String eday = null;
	
	SimpleDateFormat dateform = new SimpleDateFormat("dd/MM/yyyy");
	
	GetDiaryInfoSer diaryinfoSer = GetDiaryInfoSer.getInstance();
	Diary diaryinfo = diaryinfoSer.getDiaryInfo(dvol, userNum);
	
%>

	<div class="container write-wrap">
	<form action="writeDiary2.jsp" name="writeDiary" method="post" enctype="multipart/form-data">
	

	<table class="write" style="width: 100%;">
		<tr>
			<th>Title</th>
			<td><input class="d-title" type="text" name="diaryTitle" value="<%=diaryinfo.getDiary_title() %>" ><br></td>
		</tr>	
		<tr>	
			<th>Location</th>
			<td>
	<input type="hidden" id="location" value="<%=diaryinfo.getLocation() %>">
	<select class="selloc" name="location" onchange="checksel(this.value) ">
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
	</table>
	
	<br>
	<center>
	<button class="button btn-warning" onclick="javascript:checkform();">
	<span>Modify!</span></button>
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