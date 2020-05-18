<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>论文评分</title>
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
            <div>
                <h2 style="margin-bottom: 30px; font-size: 20px;">查看评分</h2>
                <div style="margin-left: 25px;" align="left">
                    <form action=""method="post">
                        <select name="selectId">
                            <option value="1">待实现</option>
                            <option value="1">学生名称</option>
                            <option value="2">学号</option>
                            <option value="3">课题编号</option>
                            <option value="4">课题名称</option>
                            <option value="5">班级</option>
                            <option value="6">专业</option>
                        </select>
                        <input type="text" name="selectName">
                        <input type="submit" value="搜索">
                    </form>
                </div>
            <form action="" method="post">
                <table style="width: 1300px; margin-left:25px;" align="left" class="table table-striped table-hover table-bordered">
                    <thead>
                    <tr>
                        <th><strong>序号</strong></th>
                        <th><strong>学号</strong></th>
                        <th><strong>评分时间</strong></th>
                        <th><strong>内容(40)</strong></th>
                        <th><strong>思路(10)</strong></th>
                        <th><strong>表达(10)</strong></th>
                        <th><strong>回答(40)</strong></th>
                        <th><strong>总分(100)</strong></th>
                        <th><strong>操作</strong></th>
                    </tr>
                    </thead>
                    <tbody id="test"></tbody></table>
            </form></div>

        </div>
        <div id="PageBottom" align="center"></div>
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
        .ele{
            width: 65px;
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
            top: 15%;
            left: 30%;
            width: 40%;
            height: 50%;
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
    <div class="layui-footer">

    </div>
</div>
<script src="../layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
    /*
        学生信息
     */
    var studentId = new Array();
    var studentName = new Array();
    /*
        试题信息
     */
    var topicId = new Array();
    var topicName = new Array();
    var topicRequier = new Array();
    var topicDesc = new Array();

    /*
        开题报告信息
     */
    var openName = new Array();
    var opensubTime = new Array();
    var openstatus = new Array();

    var midName = new Array();
    var midsubTime = new Array();
    var midstatus = new Array();

    var firstName = new Array();
    var firstsubTime = new Array();
    var firststatus = new Array();

    var secondName = new Array();
    var secondsubTime = new Array();
    var secondstatus = new Array();

    var lastName = new Array();
    var lastsubTime = new Array();
    var laststatus = new Array();

    var subtime = new Array();
    var content = new Array();
    var think = new Array();
    var express = new Array();
    var answer = new Array();
    var grade = new Array();
    // function Scoring(index) {
    //     document.getElementById("showdiv").style.display='block';
    //     document.getElementById("fade").style.display='block' ;
    //     document.getElementById("studentId").innerHTML=studentId[index]+"<input type='hidden' name='studentId' value='"+studentId[index]+"'>" ;
    //
    // }
    //
    //
    // function CloseDisplay(show_div,bg_div) {
    //     document.getElementById(show_div).style.display='none';
    //     document.getElementById(bg_div).style.display='none';
    // }
</script>
<div>
    <%--<c:forEach items="${studentList}" var="student">--%>
        <%--<script>--%>
            <%--studentId.push("${student.studentId}");--%>
            <%--studentName.push("${student.studentName}");--%>
        <%--</script>--%>
    <%--</c:forEach>--%>
    <%--<c:forEach items="${topicList}" var ="topic">--%>
        <%--<script>--%>
            <%--topicId.push("${topic.topicId}");--%>
            <%--topicName.push("${topic.topicName}");--%>
            <%--topicRequier.push("${topic.topicRequier}");--%>
            <%--topicDesc.push("${topic.topicDesc}");--%>
        <%--</script>--%>
    <%--</c:forEach>--%>
    <%--<c:forEach items="${OpenReportList}" var="open">--%>
        <%--<script>--%>
            <%--openName.push("${open.fileName}");--%>
            <%--opensubTime.push("${open.subTime}");--%>
            <%--openstatus.push("${open.status}");--%>
        <%--</script>--%>
    <%--</c:forEach>--%>
    <%--<c:forEach items="${MidReportList}" var="mid">--%>
        <%--<script>--%>
            <%--midName.push("${mid.fileName}");--%>
            <%--midsubTime.push("${mid.subTime}");--%>
            <%--midstatus.push("${mid.status}");--%>
        <%--</script>--%>
    <%--</c:forEach>--%>
    <%--<c:forEach items="${ThesisFirstList}" var="mid">--%>
        <%--<script>--%>
            <%--firstName.push("${mid.fileName}");--%>
            <%--firstsubTime.push("${mid.subTime}");--%>
            <%--firststatus.push("${mid.status}");--%>
        <%--</script>--%>
    <%--</c:forEach>--%>
    <%--<c:forEach items="${ThesisSecondList}" var="mid">--%>
        <%--<script>--%>
            <%--secondName.push("${mid.fileName}");--%>
            <%--secondsubTime.push("${mid.subTime}");--%>
            <%--secondstatus.push("${mid.status}");--%>
        <%--</script>--%>
    <%--</c:forEach>--%>
    <%--<c:forEach items="${ThesisLastList}" var="mid">--%>
        <%--<script>--%>
            <%--lastName.push("${mid.fileName}");--%>
            <%--lastsubTime.push("${mid.subTime}");--%>
            <%--laststatus.push("${mid.status}");--%>
        <%--</script>--%>
    <%--</c:forEach>--%>
    <c:forEach items="${scoringList}" var="scoring">
        <script>
            studentId.push("${scoring.studentId}");
            subtime.push("${scoring.subtime}");
            content.push("${scoring.content}");
            think.push("${scoring.think}");
            express.push("${scoring.express}");
            answer.push("${scoring.answer}");
            grade.push("${scoring.grade}");
        </script>
    </c:forEach>
</div>

<script type="text/javascript">
    window.onload = function () {
            ShowPage(1);
    }

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
                    "<td>"+studentId[i]+"</td>" +
                    "<td>"+subtime[i]+"</td>"+
                    "<td>"+content[i]+"</td>" +
                    "<td>"+think[i]+"</td>" +
                    "<td>"+express[i]+"</td>"+
                    "<td>"+answer[i]+"</td>"+
                    "<td>"+grade[i]+"</td></tr>";
            }

            document.getElementById("test").innerHTML = text;
        }else{//有多页
            text="";
            //判断当前页
            var currentLine = ((index-1)*PageSize);	//显示当前行
            if(lineCount%PageSize == 0){	//没有余数
                for(var i = currentLine;i<(index*PageSize);i++){
                    text +="<tr><td>"+(i+1)+"</td>" +
                        "<td>"+studentId[i]+"</td>" +
                        "<td>"+studentName[i]+"</td>"+
                        "<td>"+topicId[i]+"</td>" +
                        "<td>"+topicName[i]+"</td>" +
                        "<td>"+openName[i]+"</td>"
                    "<td>"+midName[i]+"</td>"
                    "<td>"+firstName[i]+"</td>"
                    "<td>"+secondName[i]+"</td>"
                    "<td>"+lastName[i]+"</td></tr>";
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