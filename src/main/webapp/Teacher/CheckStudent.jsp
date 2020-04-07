<%@ page language="java" contentType="text/html; charset=UTF-8" 
     pageEncoding="UTF-8" isELIgnored="false"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--
	教师对学生管理界面 
	前端界面：
		搜索栏：搜索范围：教师所在院系
			默认按查找本系所有学生，按学号查找，按专业查找、按姓名查找、按是否已选试题查找、按班级查找
			
		列表显示：学生信息，
	
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看试题</title>
</head>
<body> 
	<h1>学生管理</h1>
	<!-- 搜索栏-->
	<form action="CheckStudent" method="post">
		<select name="selectId">
			<option value="1" >学号</option>
			<option value="2" >专业</option>
			<option value="3" >姓名</option>
			<option value="4" >班级</option>
			<option value="5" >试题</option>
		</select>
		<input type="text" name="selectName">
		<input type="submit" value="搜索">
	</form> 
	
	<!-- 显示学生信息 -->
	<p id="test"></p>
	
	<!-- 显示分页 -->
	<p id="PageBottom"></p>
	
	<!-- 设置显示列表页面大小 -->
	<p>
		<input type="text" id="pageSize" value="4">
		<button onclick="setPageSize()">确定</button>
	</p> 

	<script type="text/javascript">
		window.onload = function(){
			ShowPage(1);
		}
		var studentId = new Array();
		var studentName= new Array();
		//var topicDesc = new Array;
		//var topicRequier = new Array;
		//var currentTime = new Array;
	</script>
	
	<!-- 遍历学生信息 -->
	<c:forEach items ="${studentList}"  var = "student"> 
		<script type="text/javascript">
			studentId.push("${student.studentId}");
			studentName.push("${student.studentName}"); 
			//${topic.teacherId }
			//${topic.teacherName}
			//${topic.topicDesc} 	
			//${topic.topicRequier}
			//${topic.currentTime}
		</script>
		
 	</c:forEach>
 	<!-- 留言跳转函数 -->
 	<script type="text/javascript">
 	function SetMessage(studentId){
 		window.location.href="webSocketTest.jsp?studentId="+studentId;
 	}
 	</script>
 	<!-- showPage函数：将学生信息以列表的形式显示 -->
	<script type="text/javascript">
		var pageSize = 2;//每页显示行数 
		var lineCount = ${lineCount};//总行数
		var index = 1;	//默认当前页数
		function setPageSize(){//手动设置Page大小
			var page = document.getElementById("pageSize").value;
			this.pageSize= page;
			ShowPage(1);	//刷新显示界面
		}
		
		function getPageSize(){	//获取设置的页大小
			return this.pageSize;
		}
		
		function ShowPage(index){
			PageSize = getPageSize();
			//计算总页数
			PageCount =  Math.ceil(lineCount/PageSize);
			//只有一页
			
			if(PageCount == 1){
				text="<ul>";
				for(var i = 0; i<lineCount; i++){
					text +="<li>学生编号："+studentId[i]+"\t学生名称："+studentName[i]+"<button  id=\""+studentId[i]+"\">学生留言</button></li>";
				}
				text += "</ul>";
				document.getElementById("test").innerHTML = text;
				
			}else{//有多页
				text="<ul>";
				//判断当前页
				var currentLine = ((index-1)*PageSize);	//显示当前行
				if(lineCount%PageSize == 0){	//没有余数
					for(var i = currentLine;i<(index*PageSize);i++){
						text +="<li>学生编号："+studentId[i]+"\t学生名称："+studentName[i]+"<button onclick=\"SetMessage("+studentId[i]+")\" id=\""+studentId[i]+"\">学生留言</button></li>";
					}
				}else{	//有余数
					if((index == PageCount)){
						lastCount = lineCount - PageSize*(index-1);
						
						for(var i = currentLine;i<lineCount;i++){
							
							text +="<li>学生编号："+studentId[i]+"\t学生名称："+studentName[i]+"<button id=\""+studentId[i]+"\">学生留言</button></li>";
						}
					}else{
						for(var i = currentLine; i<(index*PageSize) ;i++){
							text +="<li>学生编号："+studentId[i]+"\t学生名称："+studentName[i]+"<button id=\""+studentId[i]+"\">学生留言</button></li>";
						}
					}
				}
				text += "</ul>";
				document.getElementById("test").innerHTML = text;			
			}
			var Pagebottom = "共"+lineCount+"条记录 分"+PageCount+"页 当前是第"+index+"页 ";
			if(index > 1){
				Pagebottom += "<a href= \"#\" onClick=\"ShowPage(1)\">首页</a>";
				Pagebottom +="<a href=\"#\" onClick=\"ShowPage("+(index-1)+")\">上一页</a>"
			}else{
				
				Pagebottom += "首页 ";
				Pagebottom += " 上一页";
			}
			if(index < PageCount){
				Pagebottom +="<a href=\"#\" onClick=\"ShowPage("+(index+1)+")\">下一页</a>";
				Pagebottom += "<a href= \"#\" onClick=\"ShowPage("+PageCount+")\">尾页</a>";
			}else{
				Pagebottom += "下一页";
				Pagebottom += "尾页";
			}	
			document.getElementById("PageBottom").innerHTML = Pagebottom;
		}
	</script>

</body>
</html>