<%@ page language="java" contentType="text/html; charset=UTF-8" 
     pageEncoding="UTF-8" isELIgnored="false"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>留言系统</title>
	<script type='text/javascript' src='/dwr/engine.js'></script>
	<script type='text/javascript' src='dwr/util.js'></script>
	<script type='text/javascript' src='/dwr/interface/StudentMessage.js'></script>
	<script type='text/javascript' src='/dwr/interface/TeacherController.js'></script>
	<script type='text/javascript' src='/dwr/interface/StudentController.js'></script>
	<link rel="stylesheet" href="../layui/css/layui.css">
	<link href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
	<script src="webjars/jquery/3.4.1/jquery.min.js"></script>
	<script src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<div class="layui-header">
		<div class="layui-logo" title="教师版">毕业论文选题系统</div>
		<!-- 头部区域（可配合layui已有的水平导航） -->
		<ul class="layui-nav layui-layout-left">
			<li class="layui-nav-item"><a href="/Teacher/TeacherMain?id=1" title="刷新"><i class="layui-icon layui-icon-refresh-3"></i></a></li>
			<li class="layui-nav-item"><a href="/Teacher/DownloadFile" title="文件下载"><i class="layui-icon layui-icon layui-icon-download-circle"></i></a></li>
		</ul>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item"><a href="" title="编号">教师[${Teacher.teacherId}]</a></li>
			<li class="layui-nav-item">
				<a href="javascript:;">
					<img src="../layui/images/face/18.gif" class="layui-nav-img">
					${Teacher.teacherName}
				</a>
				<dl class="layui-nav-child">
					<dd><a href="/Teacher/ChangeInfo">修改资料</a></dd>
					<dd><a href="/Teacher/ChangePwd">修改密码</a></dd>
				</dl>
			</li>
			<li class="layui-nav-item"><a href="/Teacher/TeacherMain?id=6">退出登录</a></li>
		</ul>
	</div>

	<div class="layui-side layui-bg-black">
		<div class="layui-side-scroll">
			<ul class="layui-nav layui-nav-tree"  lay-filter="test">
				<li class="layui-nav-item layui-nav-itemed">
					<a class="" href="/Teacher/TeacherMain?id=1"><i class="layui-icon layui-icon layui-icon-home"></i>
						<cite>教师首页</cite></a></li>
				<li class="layui-nav-item layui-nav-itemed">
					<a class="" href="javascript:;">课题管理</a>
					<dl class="layui-nav-child">
						<dd><a href="/Teacher/TeacherMain?id=2">发布课题</a></dd>
						<dd><a href="/Teacher/TeacherMain?id=7">查看修改课题</a></dd>
						<dd><a href="/Teacher/TeacherMain?id=13">审批课题</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item">
					<a href="javascript:;">审批过程</a>
					<dl class="layui-nav-child">
						<dd><a href="/Teacher/TeacherMain?id=8">审批开题报告</a></dd>
						<dd><a href="/Teacher/TeacherMain?id=9">审批中期检查报告</a></dd>
						<dd><a href="/Teacher/TeacherMain?id=10">审批论文初稿</a></dd>
						<dd><a href="/Teacher/TeacherMain?id=11">审批论文定稿</a></dd>
						<dd><a href="/Teacher/TeacherMain?id=12">审批论文终稿</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item">
					<a href="javascript:;">学生管理</a>
					<dl class="layui-nav-child">
						<dd><a href="/Teacher/TeacherMain?id=3">查看学生</a></dd>
						<dd><a href="/Teacher/TeacherMain?id=4">留言中心</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item">
					<a href="javascript:;">评分中心</a>
					<dl class="layui-nav-child">
						<dd><a href="/Teacher/Scoring">论文评分</a></dd>
						<dd><a href="/Teacher/CheckScoring">查看评分</a></dd>
					</dl>
				</li>
			</ul>
		</div>
	</div>

	<div class="layui-body" style="background-color: #e2e2e2">
		<!-- 内容主体区域 -->
		<div class="box">
			<div class="left">
				<div style="margin: 20px 10px; font-size: 20px" >
					<form action="TeacherMain?id=4" method="post">
						<input type="text" style="border-radius:10px;" name="selectName"  placeholder="  编号或姓名">
					</form>
				</div>
				<div style="margin: 20px 10px; font-size: 20px; height: 300px;" >
					<table style="width: 200px;" class="table table-striped table-hover table-bordered">
						<tbody id="test"></tbody>
					</table>
				</div >
				<div style="margin: 20px 10px; font-size: 20px">
					<p id="PageBottom" style="margin-top:30px" class="PageBottom"></p>
				</div>
			</div>

			<div class="mid"></div>
			<div class="right" >
				<div style="background-color: #c0c4cc; font-size: 20px">
					<div align="center" id="object"></div>
				</div>
				<div style="font-size: 20px">
					<div class="lt" id="historyMessage" ></div>
				</div>

				<div style="border:1px solid black">
					<div  style="margin-left: 10px;" align="right">
						<span><button>发送文件</button></span>
						<span><button>历史记录</button></span>
					</div>
				</div>
				<div style="font-size: 20px;border: 3px solid black">
					<textarea rows="6" cols="100" id="message"></textarea>
				</div>
				<button onClick="sendMessage()">发送</button>
			</div>
		</div>

	</div>
	<style>
		.layui-body{
			background-color: #D0D0D0;
		}

		.box{
			display: flex;
			flex-direction: row;
			margin: 80px 100px;
		}

		.mid{
			width: 20px	;
			height: 500px;
		}
		.p1{
			background-color: white;
			font-size: 20px;
		}

		.p1 td{
			border-radius:10px;
			border: 2px solid black;
			padding: 5px 10px;
			text-decoration: none;
			display: block;
			height: 20px;
			width: 220px;
		}

		.p1 td:hover{
			background-color: #e2e2e2;
			color: #fff;
		}

		.lt{
			width: 1025px;
			height: 450px;
			border: 1px solid #666;
			overflow: auto;

		}

	</style>
	<div class="layui-footer">
		<!-- 底部固定区域 -->
		© layui.com - 底部固定区域
	</div>
</div>
<script src="../layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
        //判断当前浏览器是否支持WebSocket
        if('WebSocket' in window){
            websocket = new WebSocket("ws://localhost:8080/websocket/${teacherId}");
        }
        else{
            alert('Not support websocket');
        }

        //连接成功建立的回调方法
        websocket.onopen = function(event){
            //连接成功
        }
        websocket.onclose = function (event) {
            //关闭连接
        }

        //接收到消息的回调方法
        websocket.onmessage = function(event){
            receMessage(event.data);
        }

        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function(){
            websocket.close();
        }
	</script>

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
		var lastindex;
		var currentId;
        var MessageHead = "";
        var MessageId = "";
        var MessageBody = "";
        var sendhistory =document.getElementById("historyMessage");

        function setindex(index) {
            if (lastindex != undefined){
                document.getElementById(studentId[lastindex]).innerHTML="<td><a href='#' onclick='openChat("+lastindex+")'>"+studentId[lastindex]+studentName[lastindex]+"</a></td>";
            }
            lastindex = index;
            document.getElementById(studentId[index]).innerHTML="<td>"+studentId[index]+studentName[index]+"</td>";
        }

        function openChat(index){
            setindex(index);
            currentId = index;
            document.getElementById("object").innerHTML = studentId[index]+studentName[index];
            MessageId = studentId[index];
            MessageHead = MessageId+"://";	//消息头：标识id和分隔符
            //自动加载5条聊天记录,增加版本号，按顺序添加记录
            TeacherController.updateIsRead(${teacherId},MessageId);
            document.getElementById("historyMessage").innerHTML="";
            StudentMessage.get5Message(MessageId,${teacherId},10,function (array) {
                for(var i = 0; i<array.length ; i++){
                    sendhistory.innerHTML = sendhistory.innerHTML+array[array.length-i-1];
                    sendhistory.scrollTop = sendhistory.scrollHeight;
                }
            });

		}
		
		function sendMessage(){
            if(MessageHead != ""){
                MessageBody = document.getElementById("message").value;
                var sendMessage = MessageHead +MessageBody;
                //发送信息StudentController.addMessage();
                TeacherController.addMessage(${teacherId},this.MessageId,MessageBody);
                StudentMessage.setMessage(${teacherId},this.MessageId,MessageBody);
                websocket.send(sendMessage);
                var myDate = new Date();
                var sd = "<div style='color: green; padding-left:10px;'><div style='margin-left:400px;'>"+ myDate.toLocaleString()+"</div>"+MessageBody+"</div>";
                sendhistory.innerHTML = sendhistory.innerHTML+sd;
                sendhistory.scrollTop = sendhistory.scrollHeight;
                document.getElementById("message").value="";
            }
		}
		
		//接收信息
        //接收信息
        function receMessage(rmessage){
            if(MessageHead != ""){
                ShowPage(indexs);
                openChat(currentId);
                var messages = new Array();
                messages = rmessage.split("://");
                if (messages[0] == studentId[currentId]) {
					StudentMessage.getMessage(messages[0],${teacherId},function(value){
						var sd = "<div>"+value+"</div>";
						sendhistory.innerHTML = sendhistory.innerHTML+sd;
						sendhistory.scrollTop = sendhistory.scrollHeight;
					});
				}
            }
        }
 	</script>
 	
 	<!-- showPage函数：将学生信息以列表的形式显示 -->
	<script type="text/javascript">
        window.onload = function (){
            if(${lineCount} != 0){
                ShowPage(1);
            }else{
                alter("没有选择教师");
            }
        }
		var pageSize = 10;//每页显示行数 
		var lineCount = ${lineCount};//总行数
		var indexs;	//默认当前页数
		var noread;
		function ShowPage(index){
			//计算总页数
			indexs = index;
			var PageSize = this.pageSize;
			PageCount =  Math.ceil(lineCount/PageSize);
			//只有一页
			if(PageCount == 1){
				var text="";
				for(var i = 0; i<lineCount; i++){
                    dwr.engine.setAsync(false);
                    TeacherController.getNoReadCount(studentId[i],${teacherId},function (value) {
                        noread = value;
                    });
                    dwr.engine.setAsync(true);
                    if (noread == 0){
                        text +="<tr class=\"p1\" id=\""+studentId[i]+"\"><td><a href=\"#\" onClick='openChat("+i+")'><div style='float: left'>"+studentId[i]+studentName[i]+"</div><div style='float: right'></div></a></td></tr>";
                    }else{
                        text +="<tr class=\"p1\" id=\""+studentId[i]+"\"><td><a href=\"#\" onClick='openChat("+i+")'><div style='float: left'>"+studentId[i]+studentName[i]+"</div><div style='float: right'><strong style='color:red;'>"+noread+"</strong></div></a></td></tr>";
                    }

                }
				document.getElementById("test").innerHTML = text;
				
			}else{//有多页
				var text="";
				//判断当前页
				var currentLine = ((index-1)*PageSize);	//显示当前行
				if(lineCount%PageSize == 0){	//没有余数
					for(var i = currentLine;i<(index*PageSize);i++){
                        dwr.engine.setAsync(false);
                        TeacherController.getNoReadCount(studentId[i],${teacherId},function (value) {
                            noread = value;
                        });
                        dwr.engine.setAsync(true);
                        if (noread == 0){
                            text +="<tr class=\"p1\" id=\""+studentId[i]+"\"><td><a href=\"#\" onClick='openChat("+i+")'><div style='float: left'>"+studentId[i]+studentName[i]+"</div><div style='float: right'></div></a></td></tr>";
                        }else{
                            text +="<tr class=\"p1\" id=\""+studentId[i]+"\"><td><a href=\"#\" onClick='openChat("+i+")'><div style='float: left'>"+studentId[i]+studentName[i]+"</div><div style='float: right'><strong style='color:red;'>"+noread+"</strong></div></a></td></tr>";
                        }					}
				}else{	//有余数
					if((index == PageCount)){
						var lastCount = lineCount - PageSize*(index-1);
						for(var i = currentLine;i<lineCount;i++){
                            dwr.engine.setAsync(false);
                            TeacherController.getNoReadCount(studentId[i],${teacherId},function (value) {
                                noread = value;
                            });
                            dwr.engine.setAsync(true);
                            if (noread == 0){
                                text +="<tr class=\"p1\" id=\""+studentId[i]+"\"><td><a href=\"#\" onClick='openChat("+i+")'><div style='float: left'>"+studentId[i]+studentName[i]+"</div><div style='float: right'></div></a></td></tr>";
                            }else{
                                text +="<tr class=\"p1\" id=\""+studentId[i]+"\"><td><a href=\"#\" onClick='openChat("+i+")'><div style='float: left'>"+studentId[i]+studentName[i]+"</div><div style='float: right'><strong style='color:red;'>"+noread+"</strong></div></a></td></tr>";
                            }						}
					}else{
						for(var i = currentLine; i<(index*PageSize) ;i++){
                            dwr.engine.setAsync(false);
                            TeacherController.getNoReadCount(studentId[i],${teacherId},function (value) {
                                noread = value;
                            });
                            dwr.engine.setAsync(true);
                            if (noread == 0){
                                text +="<tr class=\"p1\" id=\""+studentId[i]+"\"><td><a href=\"#\" onClick='openChat("+i+")'><div style='float: left'>"+studentId[i]+studentName[i]+"</div><div style='float: right'></div></a></td></tr>";
                            }else{
                                text +="<tr class=\"p1\" id=\""+studentId[i]+"\"><td><a href=\"#\" onClick='openChat("+i+")'><div style='float: left'>"+studentId[i]+studentName[i]+"</div><div style='float: right'><strong style='color:red;'>"+noread+"</strong></div></a></td></tr>";
                            }						}
					}
				}
				document.getElementById("test").innerHTML = text;
			}
			var Pagebottom = "";
			if(index > 1){
				Pagebottom += "<a href= \"#\" onClick=\"ShowPage(1)\">首页</a>";
				Pagebottom +="<a href=\"#\" onClick=\"ShowPage("+(index-1)+")\">上一页</a>"
			}else{
				// Pagebottom += "首页 ";
				// Pagebottom += " 上一页";
			}
			if(index < PageCount){
				Pagebottom +="<a href=\"#\" onClick=\"ShowPage("+(index+1)+")\">下一页</a>";
				Pagebottom += "<a href= \"#\" onClick=\"ShowPage("+PageCount+")\">尾页</a>";
			}else{
				// Pagebottom += "下一页";
				// Pagebottom += "尾页";
			}	
			document.getElementById("PageBottom").innerHTML = Pagebottom;
		}
	</script>

</body>
</html>