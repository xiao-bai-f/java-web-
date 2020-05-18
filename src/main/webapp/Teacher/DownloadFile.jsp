<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>文件下载</title>
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
            <li class="layui-nav-item"><a href="/Teacher/DownloadFile" title="刷新"><i class="layui-icon layui-icon-refresh-3"></i></a></li>
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
        <!-- 查看试题信息-->
        <div class="box">
            <form action="afterChangeInfo" method="post">
                <div class="container" align="center">
                    <table style=" margin-left:50px; width: 200px;" class="table table-striped table-hover table-bordered table1">
                        <%--<h1>修改信息</h1>--%>
                        <thead>
                        <tr><td class="p1" style="font-size: 20px; padding-left: 50px"><strong>开题报告</strong></td></tr>
                        </thead>
                        <tbody id="open"></tbody>
                    </table>

                    <table style="margin-left:80px; width: 200px;" class="table table-striped table-hover table-bordered">
                            <thead>
                            <tr><td style="font-size: 20px; padding-left: 50px"><strong>中期检查</strong></td></tr>
                            </thead>
                        <tbody id="mid"></tbody>
                    </table>

                    <table style="margin-left:80px;  width: 200px;" class="table table-striped table-hover table-bordered">
                        <thead>
                        <tr><td style="font-size: 20px; padding-left: 50px"><strong>中期检查</strong></td></tr>
                        </thead>
                        <tbody id="first"></tbody>
                    </table>

                    <table style="margin-left:80px; width: 200px;" class="table table-striped table-hover table-bordered">
                        <thead>
                        <tr><td style="font-size: 20px; padding-left: 50px"><strong>中期检查</strong></td></tr>
                        </thead>
                        <tbody id="second"></tbody>
                    </table>

                    <table style=" margin-left:80px; width: 200px;" class="table table-striped table-hover table-bordered">
                        <thead>
                        <tr><td style="font-size: 20px; padding-left: 50px"><strong>中期检查</strong></td></tr>
                        </thead>
                        <tbody id="last"></tbody>
                    </table>
                </div>
            </form>
        </div>
    </div>

    <style>
        .layui-body{
            background-color: #e2e2e2;
        }
        .box{
            background-color: white;
            margin: 30px 60px;
            padding: 30px 60px;
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
<script>
    var type = new Array();
    var OpenReportfileName = new Array();
    var MidReportfileName = new Array();
    var ThesisFirstfileName = new Array();
    var ThesisSecondfileName = new Array();
    var ThesisLastfileName = new Array();

</script>

<c:forEach items="${OpenReportfileName}" var="fileName">
    <script>
        OpenReportfileName.push("${fileName}");
    </script>
</c:forEach>
<c:forEach items="${MidReportfileName}" var="fileName">
    <script>
        MidReportfileName.push("${fileName}");
    </script>
</c:forEach>
<c:forEach items="${ThesisFirstfileName}" var="fileName">
    <script>
        ThesisFirstfileName.push("${fileName}");
    </script>
</c:forEach>
<c:forEach items="${ThesisSecondfileName}" var="fileName">
    <script>
        ThesisSecondfileName.push("${fileName}");
    </script>
</c:forEach>
<c:forEach items="${ThesisLastfileName}" var="fileName">
    <script>
        ThesisLastfileName.push("${fileName}");
    </script>
</c:forEach>

<script>
    window.onload = function () {
        showPage();
    }
    function showPage() {
        var path="http://localhost:8080/UploadFile/";
        var text = "";
        for (var  i = 0; i<OpenReportfileName.length;i++){
            // text+="<tr><td><a href='/Teacher/download?path="+path+"OpenReport/"+OpenReportfileName[i]+"'>"+OpenReportfileName[i]+"</a></td></tr>";
            text+="<tr><td><a href='/UploadFile/OpenReport/"+OpenReportfileName[i]+"'>"+OpenReportfileName[i]+"</a></td></tr>";
        }
        document.getElementById("open").innerHTML = text;


        text = "";
        for (var  i = 0; i<MidReportfileName.length;i++){
            text+="<tr><td><a href='/UploadFile/MidReport/"+MidReportfileName[i]+"'>"+MidReportfileName[i]+"</a></td></tr>";
        }
        document.getElementById("mid").innerHTML = text;

        text = "";
        for (var  i = 0; i<ThesisFirstfileName.length;i++){
            text+="<tr><td><a href='/UploadFile/ThesisFirst/"+ThesisFirstfileName[i]+"'>"+ThesisFirstfileName[i]+"</a></td></tr>";
        }
        document.getElementById("first").innerHTML = text;

        text = "";
        for (var  i = 0; i<ThesisSecondfileName.length;i++){
            text+="<tr><td><a href='/UploadFile/ThesisSecond/"+ThesisSecondfileName[i]+"'>"+ThesisSecondfileName[i]+"</a></td></tr>";
        }
        document.getElementById("second").innerHTML = text;

        text = "";
        for (var  i = 0; i<ThesisLastfileName.length;i++){
            text+="<tr><td><a href='/UploadFile/ThesisLast/"+ThesisLastfileName[i]+"'>"+ThesisLastfileName[i]+"</a></td></tr>";
        }
        document.getElementById("last").innerHTML = text;
    }


</script>

</body>
</html>