<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生留言</title>
</head>
<body>
	
</body>
<script type="text/javascript">
	var ws = new WebSocket("ws:localhost:8080/TeacherMassage");
	
	ws.onopen = function(){
		appendHtml("连接成功")
	}
	ws.onerror = function(){
		appendHtml("连接失败")
	}
	ws.onclose = function(){
		appendHtml("连接关闭")
	}
	ws.onmessage = function(evt){
		appendHtml(evt.data)
	}
	function appendHtml(htm){
		($("#content")[0].innerHTML+=htm+"<br/>")
	}

</script>
</html>