<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>审批课题</title>
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
            <li class="layui-nav-item"><a href="/Teacher/TeacherMain?id=${id}" title="刷新"><i class="layui-icon layui-icon-refresh-3"></i></a></li>
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
        <!-- 菜单按钮 -->
        <div class="container" align="left">
            <h1 align="center">审批课题列表</h1>
            <form action="ApproveTopic" method="post">
                <table style="width: 1300px;" align="center" class="table table-striped table-hover table-bordered">
                    <thead>
                    <th>序号</th>
                    <th>学生学号</th>
                    <th>学生姓名</th>
                    <th>课题名称</th>
                    <th>课题要求</th>
                    <th>课题描述</th>
                    <th>提交时间</th>
                    <th>审批意见</th>
                    <th>操作</th>
                    </thead>
                    <tbody id="report"></tbody>
                </table></form>
            <br>
            <div id="PageBottom" class="bottom" align="center"></div>
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
            .text1{
                width: 120px;
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
<!--
    见面设置：
        1、开题报告列表、
        2、审批意见文办区
        3、确定审批结果按钮 (同意、退回)
-->
<script>
    window.onload = function () {
        if(${lineCount} != 0){
            ShowPage(1);
        }
    }
    var studentId = new Array();
    var studentName = new Array();
    var topicName = new Array();
    var topicDesc = new Array();
    var topicRequier = new Array();
    var classId = new Array();
    var approveData = new Array();

</script>
<c:forEach items="${studentList}" var="student">
    <script>
        studentId.push("${student.studentId}");
        studentName.push("${student.studentName}");
    </script>
</c:forEach>

<c:forEach items="${classesList}" var="classes">
    <script>
        classId.push("${classes.classId}");
    </script>
</c:forEach>

<c:forEach items="${ApproveTopicList}" var="topic">
    <script>
        topicName.push("${topic.topicName}");
        topicDesc.push(" ${topic.topicDesc}");
        topicRequier.push("${topic.topicRequier}");
        approveData.push("${topic.approveData}");
    </script>
</c:forEach>

<script>
    var pageSize = 10;//每页显示行数
    var lineCount = ${lineCount};//总行数
    var index = 1;	//默认当前页数

    function ShowPage(index){

        PageSize = this.pageSize;
        //计算总页数
        PageCount =  Math.ceil(lineCount/PageSize);
        //只有一页
        if(PageCount == 1){
            var list="";
            for (var i = 0 ; i<${lineCount} ; i++){
                list += "<tr><td>"+(i+1)+"</td>" +
                    "<td><input class='text1' type='text' name='studentId' value=\""+ studentId[i]+"\"></td>"+
                    "<td><input class='text1' type='text' name='studentName' value=\""+ studentName[i]+"\"></td>"+
                    "<td><input class='text1' type='text' name='topicName' value=\""+ topicName[i]+"\"></td>"+
                    "<td><input class='text1' type='text' name='topicRequier' value=\""+ topicRequier[i]+"\"></td>"+
                    "<td><input class='text1' type='text' name='topicDesc' value=\""+ topicDesc[i]+"\"></td>"+
                    "<td>"+ approveData[i]+"</td>"+
                    "<td><input class=\"choice\" type=\"radio\" checked name=\"choice\" value=\"1\">同意<input class=\"choice\" type=\"radio\" name=\"choice\" value=\"0\">不同意</td>"+
                    "<td><input type='submit' value='提交'></td></tr>";
            }
            document.getElementById("report").innerHTML = list;
        }else{//有多页
            list="";
            //判断当前页
            var currentLine = ((index-1)*PageSize);	//显示当前行
            if(lineCount%PageSize == 0){	//没有余数
                for (var i = 0 ; i<${lineCount} ; i++){
                    list += "<tr><td>"+(i+1)+"</td>" +
                        "<td>"+studentId[i]+"</td>" +
                        "<td>"+studentName[i]+"</td>" +
                        "<td>"+ topicName[i]+"</td>"+
                        "<td>"+ topicRequier[i]+"</td>"+
                        "<td>"+ topicDesc[i]+"</td>"+
                        "<td>"+ approveData[i]+"</td>"+
                        "<td><input class=\"choice\" type=\"radio\" checked name=\"choice\" value=\"1\">同意<input class=\"choice\" type=\"radio\" name=\"choice\" value=\"0\">不同意</td>"+
                        "<td><input type='submit' value='提交'></td></tr>";
                }
            }else{	//有余数
                if((index == PageCount)){
                    lastCount = lineCount - PageSize*(index-1);
                    for (var i = 0 ; i<${lineCount} ; i++) {
                        list += "<tr><td>" + (i + 1) + "</td>" +
                            "<td>" + studentId[i] + "</td>" +
                            "<td>" + studentName[i] + "</td>" +
                            "<td>" + topicName[i] + "</td>" +
                            "<td>" + topicRequier[i] + "</td>" +
                            "<td>" + topicDesc[i] + "</td>" +
                            "<td>" + approveData[i] + "</td>" +
                            "<td><input class=\"choice\" type=\"radio\" checked name=\"choice\" value=\"1\">同意<input class=\"choice\" type=\"radio\" name=\"choice\" value=\"0\">不同意</td>" +
                            "<td><input type='submit' value='提交'></td></tr>";
                    }
                }else{
                    for (var i = 0 ; i<${lineCount} ; i++){
                        list += "<tr><td>"+(i+1)+"</td>" +
                            "<td>"+ studentId[i]+"</td>" +
                            "<td>"+ studentName[i]+"</td>" +
                            "<td>"+ topicName[i]+"</td>"+
                            "<td>"+ topicRequier[i]+"</td>"+
                            "<td>"+ topicDesc[i]+"</td>"+
                            "<td>"+ approveData[i]+"</td>"+
                            "<td><input class=\"choice\" type=\"radio\" checked name=\"choice\" value=\"1\">同意<input class=\"choice\" type=\"radio\" name=\"choice\" value=\"0\">不同意</td>"+
                            "<td><input type='submit' value='提交'></td></tr>";
                    }
                }
            }
            document.getElementById("report").innerHTML = list;
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

    function showDetail(id,name,filename){
        //设置隐藏值
        document.getElementById("hiddenId").innerHTML = " <input type=\"hidden\" name=\"studentId\" value="+id+">";
        document.getElementById("hiddenName").innerHTML = " <input type=\"hidden\" name=\"studentName\" value="+name+">";
        document.getElementById("fileName").innerHTML = "<input type=\"hidden\" name=\"fileName\" value="+filename+">"
        document.getElementById("person").innerHTML = name;
        //显示上传的细节
    }
</script>
</body>
</html>
