<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>测试</title>
	<%--<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/css/bootstrap.min.css" />--%>
	<%--<script src="webjars/jquery/3.4.1/jquery.min.js"></script>--%>
	<%--<script src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
	<link rel="stylesheet" href="layui/css/layui.css">
</head>

<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin">
	<div class="layui-header">
		<div class="layui-logo">毕业论文选题系统</div>
		<!-- 头部区域（可配合layui已有的水平导航） -->
		<ul class="layui-nav layui-layout-left">
			<li class="layui-nav-item"><a href="" title="刷新"><i class="layui-icon layui-icon-refresh-3"></i></a></li>
			<li class="layui-nav-item"><a href="" title="文件下载"><i class="layui-icon layui-icon layui-icon-download-circle"></i></a></li>


		</ul>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item"><a href="">个人中心</a></li>
			<li class="layui-nav-item">
				<a href="javascript:;">
					<img src="layui/images/face/18.gif" class="layui-nav-img">
					用户名
				</a>
				<dl class="layui-nav-child">
				<dd><a href="">基本资料</a></dd>
				<dd><a href="">修改密码</a></dd>
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
					<a class="" href="javascript:;"><i class="layui-icon layui-icon layui-icon-home"></i>
						<cite>系统首页</cite></a></li>

				<li class="layui-nav-item layui-nav-itemed">
					<a class="" href="javascript:;">试题管理<span class="layui-nav-child"></span></a>
					<dl class="layui-nav-child">
						<dd><a href="javascript:;">选择试题</a></dd>
						<dd><a href="javascript:;">申请试题</a></dd>
						<dd><a href="javascript:;">申请修改试题昵称</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item">
					<a href="javascript:;">提交文件</a>
					<dl class="layui-nav-child">
						<dd><a href="javascript:;">提交开题报告</a></dd>
						<dd><a href="javascript:;">中期检查报告</a></dd>
						<dd><a href="">论文初稿</a></dd>
						<dd><a href="">论文定稿</a></dd>
						<dd><a href="">论文终稿</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item"><a href="">留言中心</a></li>
				<li class="layui-nav-item"><a href="">其他功能</a></li>
			</ul>
		</div>
	</div>

	<div class="layui-body">
		<!-- 内容主体区域 -->
		<div style="padding: 15px;">
			<ul id="nav">
				<li><button id="1">个人信息</button></li>
				<li><button id="2">试题管理</button></li>
				<li><button id="3">个人管理</button></li>
				<li><button id="4">教师留言</button></li>
				<li><button id="5">学院信息</button></li>
				<li><button id="6">修改密码</button></li>
				<li><button id="7">修改信息</button></li>
				<li><button id="8">退出登录</button></li>
				<li><button id="9">开题报告</button></li>
				<li><button id="10">中期检查报告</button></li>
				<li><button id="11">论文初稿</button></li>
				<li><button id="12">论文</button></li>
				<li><button id="13">论文终稿</button></li>
			</ul>

			<h1>学生主页</h1>
			<!-- 菜单按钮 -->
			<p>学生编号:${Student.studentId }</p>
			<p>学生姓名:${Student.studentName }</p>
			<p>学生性别:${Student.studentSex }</p>
			<p>学生年龄:${Student.studentAge }</p>
			<p>学生专业:${Major.majorName }</p>
			<p>学生学历:${Student.studentEducation }</p>
			<p>学生邮箱:${Student.studentEmail }</p>
			<p>学生电话:${Student.studentTel }</p>
			<p>学生地址:${Student.studentAddress }</p>
			<p>学生班级:${Classes.classId}</p>
			<p>学生学院:${College.collegeName }</p>
		</div>
	</div>

	<div class="layui-footer">
		<!-- 底部固定区域 -->
		© layui.com - 底部固定区域
	</div>
</div>
<script src="layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
</script>

<script>
    window.onload = function(){
        var  tagName = document.getElementsByTagName("button");
        for (var i = 0; i < tagName.length; i++) {
            tagName[i].onclick = function(){
                //当点击到对应按钮是跳转
                window.location.href= "Student/StudentMain?id="+this.id;
            }
        }
    }
</script>
</body>
</html>
