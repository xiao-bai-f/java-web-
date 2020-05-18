<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>文件下载</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="webjars/jquery/3.4.1/jquery.min.js"></script>
    <script src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type='text/javascript' src='/dwr/engine.js'></script>
    <script type='text/javascript' src='/dwr/interface/StudentController.js'></script>
</head>
<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo" title="学生版">毕业论文选题系统</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="/Student/StudentMain?id=2" title="刷新"><i class="layui-icon layui-icon-refresh-3"></i></a></li>
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
        <!-- 内容主体区域  测试区域-->
        <div class="container" align="left">
            <h2 align="center">文件下载</h2>
            <table style="width: 1400px;" align="center" class="table table-striped table-hover table-bordered">
                <tbody id="data"></tbody>
            </table>
            <p id="PageBottom" align="center"></p>
        </div>

        <style>
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
    window.onload = function () {
        var open ="open";
        var mid = "mid";
        var first = "first";
        var second= "second";
        var last = "last";
        var data = " <tr >" +
            "                        <td><a href=\"#\" onclick='downloadfile(\""+open+"\",${Student.studentId})'>下载开题报告</a></td>" +
            "                        <td><a href=\"#\" onclick='downloadfile(\""+mid+"\",${Student.studentId})'>下载中期检查</a></td>" +
            "                        <td><a href=\"#\" onclick='downloadfile(\""+first+"\",${Student.studentId})'>下载论文初稿</a></td>" +
            "                        <td><a href=\"#\" onclick='downloadfile(\""+second+"\",${Student.studentId})'>下载论文定稿</a></td>" +
            "                        <td><a href=\"#\" onclick='downloadfile(\""+last+"\",${Student.studentId})'>下载论文终稿</a></td>" +
            "                    </tr>"
        document.getElementById("data").innerHTML=data;

    }
    function downloadfile(type,id) {
        StudentController.downloadFile(type,id);
    }
</script>
</body>
</html>