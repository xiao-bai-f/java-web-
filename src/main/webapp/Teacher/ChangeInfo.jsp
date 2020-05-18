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
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="/Teacher/ChangeInfo" title="刷新"><i class="layui-icon layui-icon-refresh-3"></i></a></li>
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
        <div class="box">
            <form action="afterChangeInfo" method="post">
                <div class="container" align="center">
                    <table style="width: 500px;" class="table table-striped table-hover table-bordered table1">
                        <tbody>
                        <tr><td class="p1">姓名</td><td class="p2"><input type="text" name="name" value="${Teacher.teacherName}"></td></tr>
                        <tr><td class="p1">年龄</td><td class="p2"><input type="text" name="age" value="${Teacher.teacherAge}"></td></tr>
                        <tr><td class="p1">性别</td><td class="p2"><input class="sex" type="radio" checked name="sex" value="男">男<input class="sex" type="radio" name="sex" value="女">女</td></tr>
                        </tbody>
                    </table>
                    <table style="width: 600px;" class="table table-striped table-hover table-bordered">
                        <tbody>
                            <tr><td class="p1">邮箱</td><td class="p2"><input type="text" name="mail" value="${Teacher.teacherEmail}"></td></tr>
                            <tr><td class="p1">电话</td><td class="p2"><input type="text" name="tel" value="${Teacher.teacherTel}"></td></tr>
                            <tr><td class="p1">修改信息</td><td class="p2"><input  class="submit" type="submit" value="修改信息"></td></tr>
                        </tbody>
                    </table>
                </div>
            </form>
        </div>
    </div>
    <style>
        .layui-body{
            background-color: #e2e2e2;
        }
        .container {
            display: flex;
            width: 1500px;
            margin: 10px 20px;
            padding-right: 15px;
            padding-left: 15px;
            margin-right: auto;
            margin-left: auto;
        }
        .box{
            background-color: white;
            margin: 30px 60px;
            padding: 30px 60px;
        }
        .p1{
            font-size: 20px;
            /*border: 1px solid red;*/
            letter-spacing: 2px;
            width: auto;

        }
        .p2{
            margin: auto;
            padding: auto;
            width: auto;
            height: auto;
        }
        .submit{
            width: 200px;
            font-size: 17.5px;
            letter-spacing: 2px;
        }

        .sex{
            border: 1px solid red;
            margin: 5px 5px 5px 10px;
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