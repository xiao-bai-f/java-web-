<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生登录</title>
	<link rel="stylesheet" href="assert/css/bootstrap.min.css">

</head>
<body>
	<script type="text/javascript">
		//var register = document.getElementsById("register");
		function register(){
			window.location.href="StudentRegisterBefore";
		}
	</script>
	<style>
		div{
			color:palevioletred;
		}
		.title{
			color: orangered;
		}
		#title{
			color:indianred;
		}
		.box{
			display: flex;
		}
	</style>
	<div id="box"></div>
	<div id="title" class = "title">
		<p>学生登录</p>
	</div>

	<form action="StudentLogin" method="post">
	<table>
		<p>账号：<input type="text" name="studentId"></p>
		<p>密码：<input type="password" name="studentPwd"></p>
		<p><input type="submit" value="登录"></p>
	</table></form>
	<button id="register" onclick="register()">注册</button>

</body>
</html>