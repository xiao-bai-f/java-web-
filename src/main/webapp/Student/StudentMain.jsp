<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生主页</title>
	<link rel="stylesheet" href="../layui/css/layui.css">
</head>

<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin">
	<div class="layui-header">
		<div class="layui-logo" title="学生版">毕业论文选题系统</div>
		<!-- 头部区域（可配合layui已有的水平导航） -->
		<ul class="layui-nav layui-layout-left">
			<li class="layui-nav-item"><a href="/Student/StudentMain?id=1" title="刷新"><i class="layui-icon layui-icon-refresh-3"></i></a></li>
			<li class="layui-nav-item"><a href="/Student/DownloadFile" title="文件下载"><i class="layui-icon layui-icon layui-icon-download-circle"></i></a></li>
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
					<dd><a href="/Student/StudentMain?id=3">修改资料</a></dd>
					<dd><a href="/Student/StudentMain?id=6">修改密码</a></dd>
				</dl>
			</li>
			<li class="layui-nav-item"><a href="/Student/StudentMain?id=8">退出登录</a></li>
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

	<div class="layui-body" style="background-color: #e2e2e2">
		<!-- 内容主体区域 -->
		<div class="body-head"></div>
		<div class="p1">
			<h2 align="center">个人信息</h2>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes22t "><strong>学号:</strong><span>${Student.studentId }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes22t "><strong>姓名:</strong><span>${Student.studentName }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes22t "><strong>性别:</strong><span>${Student.studentSex }	</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes22t "><strong>年龄:</strong><span>${Student.studentAge }	</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes22t "><strong>专业:</strong><span>${Major.majorName }	</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes22t "><strong>学历:</strong><span>${Student.studentEducation }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes22t "><strong>邮箱:</strong><span>${Student.studentEmail }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes22t "><strong>电话:</strong><span>${Student.studentTel }</span></div>
			<%--<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes22t "><strong>地址:</strong><span>${Student.studentAddress }</span></div>--%>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes22t "><strong>班级:</strong><span>${Classes.classId}</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes22t "><strong>学院:</strong><span>${College.collegeName }</span></div>
		</div>

		<div class="p2">
			<h2 align="center" <strong>提交状态</strong></h2>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes21t "><strong>是否选择课题:</strong><span>${Student.isTopic }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes21t "><strong>是否提交开题报告:</strong><span>${Student.isOpenReport }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes21t "><strong>是否提交中期检查报告:</strong><span>${Student.isMidReport }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes21t "><strong>是否提交论文初稿:</strong><span>${Student.isThesisFirst }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes21t "><strong>是否提交论文定稿:</strong><span>${Student.isThesisSecond }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes21t "><strong>是否提交论文终稿:</strong><span>${Student.isThesisLast }</span></div>
		</div>

		<div class="p3">
			<h2 align="center">答辩信息</h2>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes23t "><strong>答辩时间:</strong><span>${pleadTime}</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes23t "><strong>答辩地址:</strong><span>${pleadAddress}</span></div>
		</div>
		<div class="p4">
			<h2 align="center">总评信息</h2>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes23t "><strong>评分时间:</strong><span>${scoring.subtime}</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes23t "><strong>内容分数(40):</strong><span>${scoring.content}</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes23t "><strong>思路分数(10):</strong><span>${scoring.think}</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes23t "><strong>表达分数(10):</strong><span>${scoring.express}</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes23t "><strong>回答分数(40):</strong><span>${scoring.answer}</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes23t "><strong>总评分数(100):</strong><span>${scoring.grade}</span></div>
		</div>
		<%--完成进度--%>
		<div class="p5">
		<h2 align="center">完成进度</h2>
			<br>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes24t "><strong>提交报告:</strong><span>${isStartOpenReport }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes24t "><strong>提交中期检查报告:</strong><span>${isStartMidReport }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes24t "><strong>提交论文初稿:</strong><span>${isStartThesisFirst }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes24t "><strong>提交论文定稿:</strong><span>${isStartThesisSecond }</span></div>
			<div class="layui-col-xs12 layui-col-sm4 layui-col-md2 tes24t "><strong>提交论文终稿:</strong><span>${isStartThesisLast }</span></div>
		</div>
	</div>

	<style>
		.tes22t{
			/*border:1px solid red;*/
			padding: 3px 3px 10px 5px;
			/*外边距 标签与标签的距离*/
			margin: 10px 5px 10px 5px;
			font-size:15px ;
			text-align: left;

		}
		.tes21t{
			width: 180px;
			/*border:1px solid red;*/
			padding: 3px 3px 10px 5px;
			/*外边距 标签与标签的距离*/
			margin: 10px 10px 10px 10px;
			font-size:15px ;
			text-align: left;

		}
		.tes23t{
			 width: 180px;
			 /*border:1px solid red;*/
			 padding: 3px 3px 10px 5px;
			 /*外边距 标签与标签的距离*/
			 margin: 5px 10px 10px 10px;
			 font-size:15px ;
			 text-align: left;

		 }
		.tes24t{
			width: 290px;
			/*border:1px solid red;*/
			padding: 0px 10px 10px 5px;
			/*外边距 标签与标签的距离*/
			margin: 5px 10px 10px 10px;
			font-size:15px ;
			text-align: left;

		}
		.body-head{
			width: 1600px;
			height: 30px;
		}
		.p3{
			/*外边框*/
			/*border:1px solid red;*/
			/*内边距*/
			padding: 10px 10px 10px 10px;
			/*外边距 标签与标签的距离*/
			margin: 20px 40px ;
			background-color: white;
			width: 1600px;
			height: 80px;
		}
		.p4{
			 /*外边框*/
			 /*border:1px solid red;*/
			 /*内边距*/
			 padding: 10px 10px 10px 10px;
			 /*外边距 标签与标签的距离*/
			margin: 20px 40px ;
			 background-color: white;
			 width: 1600px;
			 height: 100px;
		 }
		.p5{
			/*外边框*/
			/*border:1px solid red;*/
			/*内边距*/
			padding: 10px 10px 10px 10px;
			/*外边距 标签与标签的距离*/
			margin: 20px 40px ;
			background-color: white;
			width: 1600px;
			height: 90px;
		}
		.flow{
			background-color: #0000FF;
			width: 1600px;
			height: 100px;
		}
		.p1{
			/*外边框*/
			/*border:1px solid red;*/
			/*内边距*/
			padding: 10px 10px 10px 10px;
			/*外边距 标签与标签的距离*/
			margin: 20px 40px ;
			background-color: white;
			width: 1600px;
			height: 150px;

		}
		.p2{
			/*外边框*/
			/*border:1px solid red;*/
			/*内边距*/
			padding: 10px 10px 10px 10px;
			/*外边距 标签与标签的距离*/
			margin: 20px 40px ;
			background-color: white;
			width: 1600px;
			height: 100px;
		}
		.element{
			/*外边框*/
			/*border:1px solid red;*/
			/*内边距*/
			padding: 3px 3px 3px 3px;
			/*外边距 标签与标签的距离*/
			margin: 5px 5px 5px 5px;
		}
		.bottom{
			background-color: black;
		}
	</style>

	<div class="layui-footer">
		</div>
</div>
<script src="../layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
</script>
</body>
</html>