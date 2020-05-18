<%@ page language="java" contentType="text/html; charset=UTF-8" 
     pageEncoding="UTF-8" isELIgnored="false"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看课题</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/css/bootstrap.min.css" />
	<script src="webjars/jquery/3.4.1/jquery.min.js"></script>
	<script src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="../layui/css/layui.css">
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
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
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
					<a href="javascript:;">其他设置</a>
					<dl class="layui-nav-child">
						<dd><a href="javascript:;">评分中心</a></dd>
					</dl>
				</li>

			</ul>
		</div>
	</div>

	<div class="layui-body" style="background-color: #e2e2e2">
		<!-- 查看试题信息-->
		<div class="container" align="left">
		<h1 align="center">查看课题</h1>

			<div class="select" align="left">
				<form action="CheckTopic "method="post">
			<select name="selectId">
				<option value="1">课题名称</option>
				<option value="2">课题编号</option>
			</select>
			<input type="text" name="selectName">
				<input type="submit" value="搜索">
			</form>
			</div>

			<table style="width: 1300px;" align="center" class="table table-striped table-hover table-bordered">
				<thead>
					<th>序号</th>
					<th>课题编号</th>
					<th>课题名称</th>
					<th>课题描述</th>
					<th>课题要求</th>
					<th>发布时间</th>
					<th>选择学生学号</th>
					<th>选择学生姓名</th>
					<th>修改课题</th>
				</thead>
				<tbody id="test">
				</tbody>
		</table>
		<div id="PageBottom" class="bottom" align="center"></div>
		</div>

	<!--弹出层背景-->
	<div class="black_overplay" id="fade"></div>
	<!-- 弹出层 -->
	<div class="white_content" id="showdiv">
		<div style="text-align: right; cursor: default; height: 40px;">
		<span style="font-size: 16px;" onclick="CloseDisplay('showdiv','fade')">X</span>
	</div>
		<form action="ChangeTopic" method="post"><div class="head">
			<%--<div class="ele" ><strong>课题编号</strong></div>--%>
			<div id="Id"></div>
				<div class="ele" ><strong>课题名称</strong><label id="name"></label></div>
			<div class="ele" ><strong>课题要求</strong></div>
				<div id="requier"></div>
			<div class="ele" ><strong>课题描述</strong></div>
				<div id="desc"></div>
			<div><input type="submit" class="ele" style="margin-left: 155px" name="action" value="修改课题">
				 <input type="submit" class="ele" style="margin-left: 155px" name="action" value= "删除课题">
			</div>
		</div></form>


	</div>

		<style>
			.ele2{
				margin-left: 20px;
				font-size: 15px;
			}
			.ele{
				margin-left: 20px;
				font-size: 25px;
			}
			.head{
				margin: 30px 15px;
			}
			.container {
				background-color: white;
				width: 1500px;
				margin: 50px 100px 0 100px;
				padding-right: 15px;
				padding-left: 15px;
				padding-top: 15px;
				padding-bottom: auto;
				margin-right: auto;
				margin-left: auto;
			}
			.select{
				margin-left: 85px;
				width: 350px;
			}

			.black_overplay{
				display: none;
				position: absolute;
				top: 0%;
				left: 0%;
				width: 100%;
				height: 100%;
				background-color: #e2e2e2;
				z-index:1001;
				-moz-opacity: 0.8;
				opacity:.80;
				filter: alpha(opacity=80);
			}
			.white_content {
				display: none;
				position: absolute;
				top: 5%;
				left: 30%;
				width: 40%;
				height: 70%;
				border: 5px solid white;
				background-color: white;
				z-index:1002;
				overflow: auto;
			}
			.white_content_small {
				display: none;
				position: absolute;
				top: 20%;
				left: 30%;
				width: 40%;
				height: 50%;
				border: 16px solid lightblue;
				background-color: white;
				z-index:1002;
				overflow: auto;
			}

		</style>
	</div>

	<div class="layui-footer">
		<!-- 底部固定区域 -->
		© layui.com - 底部固定区域
	</div>
</div>
<script src="../layui/layui.js"></script>
<script>
    var topicId = new Array();
    var topicName= new Array();
    var topicDesc = new Array;
    var topicRequier = new Array;
    var studentId  = new Array();
    var studentName  = new Array();
    var publishTime = new Array;
    //JavaScript代码区域
    window.onload = function(){
        if(${lineCount} > 0){
            ShowPage(1);
        }else{
            alert("无匹配结果");
            window.location.href="TeacherMain?id=7";
        }

    }

    layui.use('element', function(){
        var element = layui.element;

    });

    function ChangeTopic(id,name,requier,desc){
        document.getElementById("showdiv").style.display='block';
        document.getElementById("fade").style.display='block' ;
		document.getElementById("Id").innerHTML = "<div class='ele' ><strong>课题编号:</strong><lable>"+id+"</lable><input type='hidden' name=\"id\" value=\""+id+"\"></div>"
   		document.getElementById("name").innerHTML ="<input class=\"ele2\" name=\"name\" value=\""+name+"\">";
   		document.getElementById("requier").innerHTML ="<textarea rows=\"6\" cols=\"60\" class=\"ele2\" name=\"requier\">"+requier+"</textarea>";
   		document.getElementById("desc").innerHTML ="<textarea rows=\"6\" cols=\"60\" class=\"ele2\"  name=\"desc\">"+desc+"</textarea>";
    }

    function CloseDisplay(show_div,bg_div) {
        document.getElementById(show_div).style.display='none';
        document.getElementById(bg_div).style.display='none';
    }

</script>

	<c:forEach items ="${topicList}"  var = "topic">
		<script type="text/javascript">
			topicId.push("${topic.topicId}");
			topicName.push("${topic.topicName}");
			topicDesc.push("${topic.topicDesc}");
			topicRequier.push("${topic.topicRequier}");
            publishTime.push("${topic.publishTime}");
		</script>
 	</c:forEach>

	<c:forEach items ="${studentList}"  var = "student">
		<script type="text/javascript">
			studentId.push("${student.studentId}");
			studentName.push("${student.studentName}");
		</script>
	</c:forEach>
 	
	<script type="text/javascript">
		var pageSize = 10;//每页显示行数
		var lineCount = ${lineCount};//总行数
		var index = 1;	//默认当前页数

		function ShowPage(index){
			PageSize = this.pageSize;
			//计算总页数
			PageCount =  Math.ceil(lineCount/PageSize);
			//只有一页
			if(PageCount == 1){
				text="";
				for(var i = 0; i<lineCount; i++){
                    text +="<tr><td>"+(i+1)+"</td>" +
                        "<td>"+topicId[i]+"</td>" +
                        "<td>"+topicName[i]+"</td>" +
                        "<td>"+topicDesc[i]+"</td>" +
                        "<td>"+topicRequier[i]+"</td>" +
                        "<td>"+publishTime[i]+"</td>" +
                        "<td>"+studentId[i]+"</td>" +
                        "<td>"+studentName[i]+"</td>"+
                        "<td><a href='#' onclick='ChangeTopic(\""+topicId[i]+"\",\""+topicName[i]+"\",\""+topicRequier[i]+"\",\""+topicDesc[i]+"\")'>修改课题</a></td></tr>";
				}
				
				document.getElementById("test").innerHTML = text;
			}else{//有多页
				text="";
				//判断当前页
				var currentLine = ((index-1)*PageSize);	//显示当前行
				if(lineCount%PageSize == 0){	//没有余数
					for(var i = currentLine;i<(index*PageSize);i++){
                        text +="<tr><td>"+(i+1)+"</td>" +
                            "<td>"+topicId[i]+"</td>" +
                            "<td>"+topicName[i]+"</td>" +
                            "<td>"+topicDesc[i]+"</td>" +
                            "<td>"+topicRequier[i]+"</td>" +
                            "<td>"+publishTime[i]+"</td>" +
                            "<td>"+studentId[i]+"</td>" +
                            "<td>"+studentName[i]+"</td>"+
                            "<td><a href='#' onclick='ChangeTopic(\""+topicId[i]+"\",\""+topicName[i]+"\",\""+topicRequier[i]+"\",\""+topicDesc[i]+"\")'>修改课题</a></td></tr>";
                    }
				}else{	//有余数
					if((index == PageCount)){
						lastCount = lineCount - PageSize*(index-1);
						for(var i = currentLine;i<lineCount;i++){
                            text +="<tr><td>"+(i+1)+"</td>" +
                                "<td>"+topicId[i]+"</td>" +
                                "<td>"+topicName[i]+"</td>" +
                                "<td>"+topicDesc[i]+"</td>" +
                                "<td>"+topicRequier[i]+"</td>" +
                                "<td>"+publishTime[i]+"</td>" +
                                "<td>"+studentId[i]+"</td>" +
                                "<td>"+studentName[i]+"</td>"+
                                "<td><a href='#' onclick='ChangeTopic(\""+topicId[i]+"\",\""+topicName[i]+"\",\""+topicRequier[i]+"\",\""+topicDesc[i]+"\")'>修改课题</a></td></tr>";
                        }
					}else{
						for(var i = currentLine; i<(index*PageSize) ;i++){
                            text +="<tr><td>"+(i+1)+"</td>" +
                                "<td>"+topicId[i]+"</td>" +
                                "<td>"+topicName[i]+"</td>" +
                                "<td>"+topicDesc[i]+"</td>" +
                                "<td>"+topicRequier[i]+"</td>" +
                                "<td>"+publishTime[i]+"</td>" +
                                "<td>"+studentId[i]+"</td>" +
                                "<td>"+studentName[i]+"</td>"+
                                "<td><a href='#' onclick='ChangeTopic(\""+topicId[i]+"\",\""+topicName[i]+"\",\""+topicRequier[i]+"\",\""+topicDesc[i]+"\")'>修改课题</a></td></tr>";
                        }
					}
				}
				document.getElementById("test").innerHTML = text;			
			}
			var Pagebottom = "<strong>共"+lineCount+"条记录 分"+PageCount+"页 当前是第"+index+"页 ";
			if(index > 1){
				Pagebottom += "<a href= \"#\" onClick=\"ShowPage(1)\">首页</a>";
				Pagebottom +="<a href=\"#\" onClick=\"ShowPage("+(index-1)+")\">上一页</a>"
			}else{
				Pagebottom += "首页";
				Pagebottom += " 上一页";
			}
			if(index < PageCount){
				Pagebottom +="<a href=\"#\" onClick=\"ShowPage("+(index+1)+")\">下一页</a>";
				Pagebottom += "<a href= \"#\" onClick=\"ShowPage("+PageCount+")\">尾页</a></strong>";
			}else{
				Pagebottom += "下一页";
				Pagebottom += "尾页</strong>";
			}	
			document.getElementById("PageBottom").innerHTML = Pagebottom;
		}
	</script>

</body>
</html>