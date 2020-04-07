<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>开题报告</title>
	<script type="text/javascript">
	window.onload = function(){
			if(${isTopic} == 0){
				alert("请先选择试题");
				window.location.href="StudentMain?id=2";
			}
		    if(${isReport} == 1){
		    	alert("已经提交相关报告");
		    	document.getElementById("text3").innerHTML = "";
		    	document.getElementById("text2").innerHTML = "<a href=\"#\" onClick=\"ShowReport()\">查看报告</a>";
		    }
		}
		//查看试题详情
		function ShowTopic(){
			alert("试题详情");
		}
		//查看开题报告详情
		function ShowReport(){
			alert("开题报告详情");
			document.getElementById("fileName").innerHTML = "${Report}";
		}
	</script>
</head>
<body>
	<p id="fileName"></p>
	<form enctype="multipart/form-data" action="../Student/UploadFile" method="post"><table>
	<tr><input type="hidden" name="fileType" value=${type} ></tr>
	<tr>
		<td>课题名称</td>
		<td>学院</td>
		<td>专业</td>
		<td>班级</td>
		<td>指导教师</td>
		<td>教师编号</td>
		<td>状态</td>
		<td>课题详情</td>
		<td>操作</td>
	</tr>
	<p id="text">
		<tr>
			<td>${Topic.topicName}</td>
			<td>${College.collegeName}</td>
			<td>${Major.majorName}</td>
			<td>${Classes.classId}</td>
			<td>${Teacher.teacherName}</td>
			<td>${Teacher.teacherId}</td>
			<td>${Status}</td>
			<td><a href="#" onClick="ShowTopic()">试题详情</a></td>
			<td><p id="text2"><input type="file" name="file" value="选择文件"/></p></td>
		</tr>
		<tr>
			<td colspan="5" align="center">
				<p id="text3">
				<input  type="submit" value="  上传   "/>
				</p>
			</td>	
		</tr>
	</p>
	</table></form>

</body>
</html>