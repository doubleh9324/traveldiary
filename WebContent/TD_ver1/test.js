var start = 0;
var list = 5;

function append_list(){
	$.post("scrolltest.jsp", {start:start, list:list}, function(data){
		$("diary").append(data);
		start += list;
	});
}