<%@ page language="java" contentType="text/html; charset=UTF-8" 
     pageEncoding="UTF-8" isELIgnored="false"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看试题</title>
</head>
<body onload="ShowPage(1)">
	<script type="text/javascript">
		var topicId = new Array();
		var topicName= new Array();
		//var teacherId = new Array;
		//var teacherName = new Array;
		//var topicDesc = new Array;
		//var topicRequier = new Array;
		//var currentTime = new Array;
	</script>
	<c:forEach items ="${topicList}"  var = "topic"> 
		<script type="text/javascript">
			topicId.push("${topic.topicId}");
			topicName.push("${topic.topicName}"); 
			//${topic.teacherId }
			//${topic.teacherName}
			//${topic.topicDesc} 	
			//${topic.topicRequier}
			//${topic.currentTime}
		</script>
 	</c:forEach>
 	
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
					
					text +="<li>课题编号："+topicId[i]+"\t课题名称："+topicName[i]+"</li>";
				}
				text += "</ul>";
				
				document.getElementById("test").innerHTML = text;
			}else{//有多页
				text="<ul>";
				//判断当前页
				var currentLine = ((index-1)*PageSize);	//显示当前行
				if(lineCount%PageSize == 0){	//没有余数
					for(var i = currentLine;i<(index*PageSize);i++){
						text +="<li>课题编号："+topicId[i]+"\t课题名称："+topicName[i]+"</li>";
					}
				}else{	//有余数
					if((index == PageCount)){
						lastCount = lineCount - PageSize*(index-1);
						for(var i = currentLine;i<lineCount;i++){
							text +="<li>课题编号："+topicId[i]+"\t课题名称："+topicName[i]+"</li>";
						}
					}else{
						for(var i = currentLine; i<(index*PageSize) ;i++){
							text +="<li>课题编号："+topicId[i]+"\t课题名称："+topicName[i]+"</li>";
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
	
	<!-- 查看试题信息-->
	<h1>查看试题</h1>
	<form action="" method="post">
		<select name="selectName">
			<option id="1">试题名称</option>
			<option id="2">试题编号</option>
			<option id="3">教师编辑</option>
			<option id="4">学生申报</option>
		</select>
		<input type="text" name="selectName">
		<input type="submit" vlaue="搜索">
	</form>
	<p id="test"></p>
	<p id="PageBottom"></p>
	<p>
		<input type="text" id="pageSize" value="5">
		<button onclick="setPageSize()">确定</button>
	</p> 


 	 
	
	
	
	

</body>
</html>