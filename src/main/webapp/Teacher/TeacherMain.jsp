<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>教师主页-</title>
</head>
	<script type="text/javascript">
		window.onload = function(){
			var  tagName = document.getElementsByTagName("button");
			for (var i = 0; i < tagName.length; i++) {
				tagName[i].onclick = function(){
					//当点击到对应按钮是跳转
					window.location.href= "TeacherMain?id="+this.id;
				}
			}
		} 
	</script>
	
<body>
	<!-- 菜单按钮 -->
	<button id="1">个人信息</button>
	<button id="2">试题管理</button>
	<button id="7">查看试题</button>
	<button id="8">审批开题报告</button>
	<button id="9">审批中期检查报告</button>
	<button id="10">审批论文初稿</button>
	<button id="11">审批论文</button>
	<button id="12">审批论文终稿</button>
	<button id="3">学生管理</button>
	<button id="4">学生留言</button>
	<button id="5">学院信息</button>
	<button id="6">退出登录</button>
	<!-- 教师主页 -->
	<p>教师主页 </p>
	<p>教师编号:${Teacher.teacherId}</p>
	<p>教师姓名:${Teacher.teacherName}</p>
	<p>教师性别:${Teacher.teacherSex}</p>
	<p>教师年龄:${Teacher.teacherAge}</p>
	<p>教师电话:${Teacher.teacherTel}</p>
	<p>教师邮箱:${Teacher.teacherEmail}</p>
	<p>教师所属学院:
		<c:forEach items="${collegeList }" var="college">
			${college.collegeName}
		</c:forEach>
	</p>
</body>                     
</html>