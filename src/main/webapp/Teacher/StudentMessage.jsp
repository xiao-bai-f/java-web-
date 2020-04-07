<%@ page language="java" contentType="text/html; charset=UTF-8" 
     pageEncoding="UTF-8" isELIgnored="false"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>留言系统</title>
</head>
<body onload="ShowPage(1)"> 
	<h1>留言系统</h1>
	<!-- 搜索栏 -->
		<!-- 显示学生信息 -->
	<p id="test"></p>
	<!-- 显示分页 -->
	<p id="PageBottom"></p>
	<form action="TeacherMain?id=4" method="post">
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
	<lable id="studentId"></lable>
	<lable id="studentName"></lable>
	<br>
	<label>聊天记录文本区</label><br>
	<p id="historyMessage"></p>
	<textarea rows="10" cols="100" id="message"></textarea></br>
	<button onClick="sendMessage()">发送</button>
	<button onClick="receMessage(121)">接收</button>
	<button>返回</button>
	
	<script type="text/javascript">
		var studentId = new Array();
		var studentName= new Array();
	</script>
	
	<!-- 遍历学生信息 -->
	<c:forEach items ="${studentList}"  var = "student"> 
		<script type="text/javascript">
			studentId.push("${student.studentId}");
			studentName.push("${student.studentName}"); 
		</script>
 	</c:forEach>
 	
 	<!-- 发起聊天函数 -->
 	<script type="text/javascript">
 		var MessageHead = ""; 
 		var MessageBody = "";
 		document.getElementById("historyMessage").value="";	
 		
		function openChat(MessageId,MessageName){
			document.getElementById("studentId").innerHTML = MessageId;
			document.getElementById("studentName").innerHTML = MessageName;
			MessageHead = MessageId+"://";	//消息头：标识id和分隔符
		}
		
		function sendMessage(){
			if(MessageHead != ""){
				MessageBody = document.getElementById("message").value;
				if(MessageBody == ""){
					alter("null");
				}
				var sendMessage = MessageHead + MessageBody;
				//发送信息
				alert(sendMessage);
				var sendhistory = document.getElementById("historyMessage").value;
				var Mhistory = sendhistory + "&emsp;&emsp;&emsp;"+MessageBody+"<br>";
				document.getElementById("historyMessage").value= Mhistory ;
				//显示消息
				document.getElementById("historyMessage").innerHTML =  Mhistory;
				//清空文本框
				document.getElementById("message").value="";
			}
		}
		
		//接收信息
		function receMessage(rmessage){
			var recehistory = document.getElementById("historyMessage").value;
			document.getElementById("historyMessage").value = recehistory + rmessage+"<br>";
			document.getElementById("historyMessage").innerHTML = recehistory + rmessage+"<br>";
		}
 	</script>
 	
 	<!-- showPage函数：将学生信息以列表的形式显示 -->
	<script type="text/javascript">

		var pageSize = 10;//每页显示行数 
		var lineCount = ${lineCount};//总行数
		var index = 1;	//默认当前页数
		
		function ShowPage(index){
			//计算总页数
			var PageSize = this.pageSize;
			PageCount =  Math.ceil(lineCount/PageSize);
			//只有一页
			if(PageCount == 1){
				text="<ul>";
				for(var i = 0; i<lineCount; i++){
					text +="<li>学生编号："+studentId[i]+"\t学生名称：<a href=\"#\" onClick=\'openChat(\""+studentId[i]+"\",\""+studentName[i]+"\")\'>"+studentName[i]+"</a></li>";
				}
				text += "</ul>";
				document.getElementById("test").innerHTML = text;
				
			}else{//有多页
				text="<ul>";
				//判断当前页
				var currentLine = ((index-1)*PageSize);	//显示当前行
				if(lineCount%PageSize == 0){	//没有余数
					for(var i = currentLine;i<(index*PageSize);i++){
						text +="<li>学生编号："+studentId[i]+"\t学生名称："+studentName[i]+"</li>";
					}
				}else{	//有余数
					if((index == PageCount)){
						var lastCount = lineCount - PageSize*(index-1);
						for(var i = currentLine;i<lineCount;i++){
							text +="<li>学生编号："+studentId[i]+"\t学生名称："+studentName[i]+"</li>";
						}
					}else{
						for(var i = currentLine; i<(index*PageSize) ;i++){
							text +="<li>学生编号："+studentId[i]+"\t学生名称："+studentName[i]+"</li>";
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