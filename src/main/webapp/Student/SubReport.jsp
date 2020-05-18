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
		    	alert("已经提交${title}");
		    	document.getElementById("text3").innerHTML = "";
		    	document.getElementById("text2").innerHTML = "<a href=\"#\" onClick=\"ShowReport()\">查看报告</a>";
		    }
		}
	</script>
	<script type='text/javascript' src='/dwr/engine.js'></script>
	<script type='text/javascript' src='/dwr/interface/StudentController.js'></script>
	<link rel="stylesheet" href="../layui/css/layui.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/css/bootstrap.min.css" />
	<script src="webjars/jquery/3.4.1/jquery.min.js"></script>
	<script src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin">
	<div class="layui-header">
		<div class="layui-logo" title="学生版">毕业论文选题系统</div>
		<!-- 头部区域（可配合layui已有的水平导航） -->
		<ul class="layui-nav layui-layout-left">
			<li class="layui-nav-item"><a href="/Student/StudentMain?id=${id}" title="刷新"><i class="layui-icon layui-icon-refresh-3"></i></a></li>
			<li class="layui-nav-item"><a href="javascript:" title="文件下载"><i class="layui-icon layui-icon layui-icon-download-circle"></i></a></li>
		</ul>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item"><a href="">个人中心</a></li>
			<li class="layui-nav-item"><a href="" title="学号">学生[${Student.studentId}]</a></li>
			<li class="layui-nav-item">
				<a href="javascript:;">
					<img src="../layui/images/face/18.gif" class="layui-nav-img">
					${Student.studentName}
				</a>
				<dl class="layui-nav-child">
					<dd><a href="/Student/StudentMain?id=3">基本资料</a></dd>
					<dd><a href="/Student/StudentMain?id=6">修改密码</a></dd>
				</dl>
			</li>
			<li class="layui-nav-item"><a href="">退出登录</a></li>
		</ul>
	</div>

	<div class="layui-side layui-bg-black">
		<div class="layui-side-scroll">
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<ul class="layui-nav layui-nav-tree" >
				<li class="layui-nav-item layui-nav-itemed">
					<a class="" href="/Student/StudentMain?id=1"><i class="layui-icon layui-icon layui-icon-home"></i>
						<cite>系统首页</cite></a></li>

				<li class="layui-nav-item layui-nav-itemed">
					<a class="" href="javascript:">课题管理<span class="layui-nav-child"></span></a>
					<dl class="layui-nav-child">
						<dd><a href="/Student/StudentMain?id=2">选择课题</a></dd>
						<dd><a href="/Student/StudentMain?id=5">申请课题</a></dd>
						<dd><a href="javascript:;">申请修改课题昵称</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item">
					<a href="javascript:;">提交文件</a>
					<dl class="layui-nav-child">
						<dd><a href="/Student/StudentMain?id=9">提交开题报告</a></dd>
						<dd><a href="/Student/StudentMain?id=10">中期检查报告</a></dd>
						<dd><a href="/Student/StudentMain?id=11">论文初稿</a></dd>
						<dd><a href="/Student/StudentMain?id=12">论文定稿</a></dd>
						<dd><a href="/Student/StudentMain?id=13">论文终稿</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item"><a href="/Student/StudentMain?id=4">留言中心</a></li>
				<li class="layui-nav-item"><a href="">其他功能</a></li>
			</ul>
		</div>
	</div>

	<div class="layui-body">
		<!-- 内容主体区域 -->
		<!-- 内容主体区域  测试区域-->
		<div class="container" align="center">
			<h2 align="center-left">提交${title}</h2>
			<form enctype="multipart/form-data" action="UploadFile" method="post">
			<table style="width: 1300px;" align="center" class="table table-striped table-hover table-bordered">
				<thead>
				<tr><input type="hidden" name="fileType" value=${type} ></tr>
				<tr>
					<th>课题编号</th>
					<th>课题名称</th>
					<th>学院</th>
					<th>专业</th>
					<th>班级</th>
					<th>指导教师</th>
					<th>教师编号</th>
					<th>选题学生学号</th>
					<th>选题学生</th>
					<th>状态</th>
					<th>查看详情</th>
					<th>选择文件</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody id="data">
				<p id="text">
					<tr>
						<td>${Topic.topicId}</td>
						<td>${Topic.topicName}</td>
						<td>${College.collegeName}</td>
						<td>${Major.majorName}</td>
						<td>${Classes.classId}</td>
						<td>${Teacher.teacherName}</td>
						<td>${Teacher.teacherId}</td>
						<td>${Student.studentId}</td>
						<td>${Student.studentName}</td>
						<td>${Status}</td>
						<td><a href="#" onClick="ShowTopic()">课题详情</a></td>
						<td id="text2"><input type="file" name="file"/></td>
						<td id="text3">
								<input  type="submit" value="  上传   "/>
						</td>
				</tr>
				</p>
				</tbody>
			</table></form>
		</div>
		<div id="fade" class="overplay"></div>
		<div id="showtopic" class="show_topic">
			<div style="text-align: right; cursor: default; height: 40px;">
				<a href="#" style="font-size: 16px;" onclick="closeTopic()">关闭</a>
			</div>
			<div class="box">
				<h2 align="center">课题详情</h2>
				<div style="margin-left: 100px; font-size: 20px"><strong>课题编号：</strong>${Topic.topicId}</div>
				<div style="margin-left: 100px; font-size: 20px"><strong>课题名称：</strong>${Topic.topicName}</div>
				<div style="margin-left: 100px; font-size: 20px"><strong>教师编号：</strong>${Teacher.teacherId}</div>
				<div style="margin-left: 100px; font-size: 20px"><strong>教师名称：</strong>${Teacher.teacherName}</div>
				<div style="margin-left: 100px; font-size: 20px"><strong>课题描述：</strong><span>${Topic.topicDesc}</span></div>
				<div style="margin-left: 100px; font-size: 20px"><strong>课题要求：</strong><span>${Topic.topicRequier}</span></div>
			</div>
		</div>
		<style>
			.box{
				margin: 20px 40px;
			}
			.overplay{
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
			.show_topic {
				display: none;
				position: absolute;
				top: 20%;
				left: 30%;
				width: 40%;
				height: 60%;
				border: 2px solid black;
				background-color: white;
				z-index:1002;
				overflow: auto;
			}
			.layui-body{
				background-color: #e2e2e2;
			}

			.layui-body div{
				background-color: white;
			}
			.container {
				width: 1500px;
				margin: 50px 100px 0 100px;
				padding-right: 15px;
				padding-left: 15px;
				margin-right: auto;
				margin-left: auto;
			}

		</style>

	</div>

	<div class="layui-footer">

	</div>
</div>
<script src="../layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
    //查看试题详情
    function ShowTopic(){
        document.getElementById("fade").style.display='block';
        document.getElementById("showtopic").style.display='block';
    }
    function closeTopic() {
        document.getElementById("fade").style.display='none';
        document.getElementById("showtopic").style.display='none';
	}
    //查看开题报告详情,下载报告
    function ShowReport(){
        <%--StudentController.downloadFile("${type}",${Student.studentId});--%>
        var path = "http://localhost:8080/UploadFile";
        if ("open"=="${type}"){
            path +="/OpenReport/";
        }else if ("mid"=="${type}"){
            path +="/MidReport/";
        }else if ("first"=="${type}"){
            path +="/ThesisFirst/";
        }else if ("second"=="${type}"){
            path +="/ThesisSecond/";
        }else if ("last"=="${type}"){
            path +="/ThesisLast/";
        }
        <%--alert(${Student.studentName});--%>
        var id = ${Student.studentId};
		var name = "${Student.studentName}";
        window.location.href=path+id+name+".docx";
    }
</script>


</body>
</html>