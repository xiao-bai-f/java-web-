<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>教师登陆</title>
</head>
<body>
	<form method="post" action="TeacherLogin">
		<p><input type="text" name="teacherId"/></p>
		<p><input type="password" name="teacherPwd"/></p>
		<input type="hidden" name="websocket" value="websocket">
		<p><input type="submit" value="登陆"></p>
	</form>  
</body>
</html>