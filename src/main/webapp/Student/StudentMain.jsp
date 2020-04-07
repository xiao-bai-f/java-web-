<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生主页</title>
	<style>
		#nav{
			border: 1px solid #f00;
			padding: 0px;
			list-style: none;
			width: 200px ;
		}
		#nav li{
			border: 1px solid #f00;
		}
		#nav button{
			width: 150px;
			text-decoration: none;
			color: #FF0000;
			background-color: white;
			padding: 5px 10px;
			display: block;
			border-left: 5px pink solid;
		}
		#nav button:hover{
			background-color: #008800;
			color: #fff;
		}
	</style>
</head>
<body>
	<div id="head">
		<h1>毕业论文管理系统</h1>

	</div>
	<ul id="nav">
		<li><button id="1">个人信息</button></li>
		<li><button id="2">试题管理</button></li>
		<li><button id="3">个人管理</button></li>
		<li><button id="4">教师留言</button></li>
		<li><button id="5">学院信息</button></li>
		<li><button id="6">修改密码</button></li>
		<li><button id="7">修改信息</button></li>
		<li><button id="8">退出登录</button></li>
		<li><button id="9">开题报告</button></li>
		<li><button id="10">中期检查报告</button></li>
		<li><button id="11">论文初稿</button></li>
		<li><button id="12">论文</button></li>
		<li><button id="13">论文终稿</button></li>
	</ul>
	<script>
	window.onload = function(){
		var  tagName = document.getElementsByTagName("button");
		for (var i = 0; i < tagName.length; i++) {
			tagName[i].onclick = function(){
				//当点击到对应按钮是跳转
				window.location.href= "StudentMain?id="+this.id;
			}
		}
	} 
	</script>
	<h1>学生主页</h1>
	<!-- 菜单按钮 -->

	
	<p>学生编号:${Student.studentId }</p>
	<p>学生姓名:${Student.studentName }</p>
	<p>学生性别:${Student.studentSex }</p>
	<p>学生年龄:${Student.studentAge }</p>
	<p>学生专业:${Major.majorName }</p>
	<p>学生学历:${Student.studentEducation }</p>
	<p>学生邮箱:${Student.studentEmail }</p>
	<p>学生电话:${Student.studentTel }</p>
	<p>学生地址:${Student.studentAddress }</p>
	<p>学生班级:${Classes.classId}</p>
	<p>学生学院:${College.collegeName }</p>
</body>
</html>