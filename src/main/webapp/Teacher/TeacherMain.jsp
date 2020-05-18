<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>${Teacher.teacherId}教师主页</title>
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
		<!-- 菜单按钮 -->
		<div class="container" align="center">
			<h2 align="left">个人信息</h2>
				<table style="width: 1000px;" align="left" class="table table-striped table-hover table-bordered">
					<thead>
					<tr>
						<th><strong>编号:</strong></th>
						<th><strong>姓名:</strong></th>
						<th><strong>性别:</strong></th>
						<th><strong>年龄:</strong></th>
						<th><strong>邮箱:</strong></th>
						<th><strong>电话:</strong></th>
						<th><strong>学院:</strong></th>
					</tr>
					</thead>
					<tbody>
						<td>${Teacher.teacherId } </td>
						<td>${Teacher.teacherName }</td>
						<td>${Teacher.teacherSex }</td>
						<td>${Teacher.teacherAge }</td>
						<td>${Teacher.teacherEmail}</td>
						<td>${Teacher.teacherTel }</td>
						<td><c:forEach items="${collegeList }" var="college">
							${college.collegeName}
						</c:forEach></td>
					</tbody>
				</table>
		</div>

		<div class="container" align="center">
			<h2 align="left">提交报告时间设置</h2>
			<form action="SetSubTime" method="post">
			<table style="width: 1000px;" align="left" class="table table-striped table-hover table-bordered">
				<thead>
				<tr>
					<th>选择课题</th>
					<th>开题报告</th>
					<th>中期检查报告</th>
					<th>论文初稿</th>
					<th>论文定稿</th>
					<th>论文终稿</th>
					<th>设置</th>
				</tr>
				</thead>
				<tbody id="subTime">
				<td><input type="date" name="topic" value="${SubTime.subTopic}"></td>
				<td><input type="date" name="open" value="${SubTime.subOpenReport}"></td>
				<td><input type="date" name="mid" value="${SubTime.subMidCheck}"></td>
				<td><input type="date" name="first" value="${SubTime.subThesisFirst}"></td>
				<td><input type="date" name="second" value="${SubTime.subThesisSecond}"></td>
				<td><input type="date" name="last" value="${SubTime.subThesisLast}"></td>
				<td><input type="submit" value="设置"></td>
				</tbody>
			</table></form>
		</div>

		<div class="container" align="center">
			<h2 align="left">设置答辩信息</h2>
			<form action="SetPlead" method="post">
			<table style="width: 500px;" align="left" class="table table-striped table-hover table-bordered">
				<thead>
				<tr>
					<th>答辩时间</th>
					<th>答辩地址</th>
					<th>设置</th>
				</tr>
				</thead>
				<tbody>
				<td><input type="date" name="pleadTime" value="${Plead.pleadTime}"></td>
				<td><input type="text" placeholder="输入学校内地址" name ="pleadAddress" value="${Plead.pleadAddress}"></td>
				<td><input type="submit" value="设置"></td>
				</tbody>
			</table></form>
		</div>

		<style>
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
		</style>
	</div>

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

</script>

</body>                     
</html>