<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>试题管理</title>
</head>
<body>
	<!-- 试题管理
		教师发布试题
	
	
	 -->
	 <form action="TopicManage" method="post">
	<p><lable>试题编号：		</lable><input type="text" name="TopicId"></p>
	<p><lable>课题名：		</lable><input type="text" name="TopicName"></p>
	<p><lable>课题教师编号：	</lable><input type="text" name=""></p>
	<p><lable>课题教师姓名:	</lable><input type="text" name=""></p>
	<p><lable>课题描述：		</lable><textarea  name="TopicDesc"></textarea></p>
	<p><lable>课题要求：		</lable><input type="text" name="TopicRequier"></p>
	<p><lable>学校编号：		</lable><input type="text" name=""></p>
	<input type="submit" value="提交">
	</form>
</body>
</html>