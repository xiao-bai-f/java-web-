<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看并选择试题</title>
</head>
<body>
	<script>
		var topicId = new Array();
		var topicName = new Array();
		var isSelected = new Array();
	</script>
	<h2>选择论文</h2>
	<c:forEach items="${TopicList}" var="topic">
		<script>
			topicId.push("${topic.topicId}");
			topicName.push("${topic.topicName}");
			isSelected.push("${topic.isSelected}");
		</script>
	</c:forEach>
	<p id="text">所在学院没有教书提供试题</p>
	
	<script type="text/javascript">
		window.onload = function (){
			var topicText = "<ul>";
			
			for (var i = 0; i < topicId.length; i++) {
				topicText +="<li>课题编号："+topicId[i]+"课题名称：<a href=\"#\" onClick=\"ShowTopic()\">"+topicName[i]+"</a>";
				if(isSelected[i] == 'no'){
					if(${IsTopic} == 0){
						topicText+="<button onClick=\"selectTopic("+topicId[i]+")\">确实选择</button></li>";
					}
				}else{
					topicText+="</li>";
				}
			}
			
			topicText +="</ul>";
			document.getElementById("text").innerHTML = topicText;
		}
		//显示试题的详细信息
		function ShowTopic(){
			//var window2 = new window();
			//window.open('','_blank','width=400,height=100,menubar=no,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=yes')
			//window.showModalDialog("StudentMain",,"dialogWidth=200px;dialogHeight=100px");  
		}
		//确认选择
		function selectTopic(id){
			window.location.href="selectTopic?topicId="+id;
		}
	</script>
</body>
</html>