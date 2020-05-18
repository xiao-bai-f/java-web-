<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>审批${title}</title>
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
            <h1>审批${title}列表</h1>
            <div class="select" align="left">
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
            <form action="SetSubTime" method="post">
                <table style="width: 1300px;" align="center" class="table table-striped table-hover table-bordered">
                    <thead>
                        <th>序号</th>
                        <th>学生学号</th>
                        <th>学生姓名</th>
                        <th>课题编号</th>
                        <th>课题名称</th>
                        <th>文件名称</th>
                        <th>提交时间</th>
                        <th>审批</th>
                    </thead>
                    <tbody id="report"></tbody>
                </table>
            </form>
            <div id="PageBottom" class="bottom" align="center"></div>
        </div>

        <!--弹出层背景-->
        <div class="black_overplay" id="fade"></div>
        <!-- 弹出层 -->
        <div class="white_content" id="showdiv">
            <div class="head">
                <div style="text-align: right; cursor: default; height: 40px;">
                    <span style="font-size: 16px;" onclick="CloseDisplay('showdiv','fade')">关闭</span>
                </div>

                <form action = "DealApproval" method="post"><table>
                    <div>
                    <tr>
                        <td><input type="hidden" name="type" value="${type}"></td>
                        <td><input id="id" type="hidden" name="studentId" ></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="" id="studentId"></div>
                            <div class="" id="studentName"></div>
                        </td>
                    </tr>
                    </div>
                    <tr>
                        <td><p style=" margin-left:20px;" ><strong>审批意见</strong></p></td>
                    </tr>
                    <tr><td><textarea style="border: 1px solid black; margin-left:20px;" rows="6" cols="60" name="opinionText"></textarea></td></tr>

                    <tr>
                        <td><input   type="submit" class="btn-success btm" value="同意" name="opinion">
                            <input  type="submit" class="btn-danger btm" value="退回" name="opinion"></td>
                    </tr>
                </table></form>
            </div>
        </div>

        <style>
            .select{
                margin-left: 85px;
            }
            .btm{
                margin-left: 20px;
                margin-right:300px;
                margin-top: 5px;
                width: 50px;
            }

            .head{
                /*border: 1px solid red;*/
                margin-left: 10px;
                margin-top: 10px;
            }
            .head div{
                margin: 10px 20px;
            }
            .white_content{
                display: none;
                position: absolute;
                top: 10%;
                left: 20%;
                width: 50%;
                height: 50%;
                border: 10px solid whitesmoke;
                background-color: white;
                z-index:1002;
                overflow: auto;
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
                filter: alpha(opacity=60);
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
    //显示子弹窗
    function showDisplay(show_div,bg_div,Id,Name) {
        document.getElementById(show_div).style.display='block';
        document.getElementById(bg_div).style.display='block' ;
        document.getElementById("studentId").innerHTML="<strong>学生学号:</strong>"+Id;
        document.getElementById("studentName").innerHTML="<strong>学生姓名:</strong>"+Name;
        document.getElementById("id").value=Id;
    }

    //关闭子弹窗
    function CloseDisplay(show_div,bg_div) {
        document.getElementById(show_div).style.display='none';
        document.getElementById(bg_div).style.display='none';
    }
</script>
    <!--
        见面设置：
            1、开题报告列表、
            2、审批意见文办区
            3、确定审批结果按钮 (同意、退回)
    -->
    <script>
        window.onload = function () {
            if (${lineCount} > 0){
                ShowPage(1);
            }
        }

        var studentId = new Array();
        var studentName = new Array();
        var fileName = new Array();
        var SubTime = new Array();
        var topicId = new Array();
        var topicName = new Array();
    </script>
    <c:forEach items="${studentList}" var="student">
        <script>
            studentId.push("${student.studentId}");
            studentName.push("${student.studentName}");
        </script>
    </c:forEach>

    <c:forEach items="${ReportList}" var="report">
        <script>
            fileName.push("${report.fileName}");
            SubTime.push("${report.subTime}");
        </script>
    </c:forEach>

    <c:forEach items="${topicList}" var="topic">
        <script>
            topicId.push("${topic.topicId}");
            topicName.push("${topic.topicName}");
        </script>
    </c:forEach>

    <script>
         var pageSize = 10;//每页显示行数
        var lineCount = ${lineCount};//总行数

        function ShowPage(index){
            PageSize = this.pageSize;
            //计算总页数
            PageCount =  Math.ceil(lineCount/PageSize);
            //只有一页
            if(PageCount == 1){
                var list="";
                for (var i = 0 ; i<${lineCount} ; i++){
                    list += "<tr><td>"+(i+1)+"</td>" +
                    "<td>"+studentId[i]+"</td>" +
                    "<td>"+studentName[i]+"</td>" +
                    "<td>"+ topicId[i]+"</td>"+
                    "<td><a href='#'>"+ topicName[i]+"</a></td>"+
                    "<td title=\"下载文件\"><a href='#' onclick='Download(\""+fileName[i]+"\")'>"+ fileName[i]+"</a></td>"+
                    "<td>"+ SubTime[i]+"</td>"+
                    "<td><a href=\"#\" onClick='showDisplay(\"showdiv\",\"fade\",\""+studentId[i]+"\",\""+studentName[i]+"\")'>审批</a></td></tr>";
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
                            "<td>"+ topicId[i]+"</td>"+
                            "<td>"+ topicName[i]+"</td>"+
                            "<td title=\"下载文件\"><a href='#' onclick='Download("+fileName[i]+")'>"+ fileName[i]+"</a></td>"+
                            "<td>"+ SubTime[i]+"</td>"+
                            "<td><a href=\"#\" onClick=\'showDisplay(\""+studentId[i]+"\",\""+studentName[i]+"\",\""+fileName[i]+"\")\'>审批</a></td></tr>";
                    }
                }else{	//有余数
                    if((index == PageCount)){
                        lastCount = lineCount - PageSize*(index-1);
                        for (var i = 0 ; i<${lineCount} ; i++){
                            list += "<tr><td>"+(i+1)+"</td>" +
                                "<td>"+studentId[i]+"</td>" +
                                "<td>"+studentName[i]+"</td>" +
                                "<td>"+ topicId[i]+"</td>"+
                                "<td>"+ topicName[i]+"</td>"+
                                "<td title=\"下载文件\"><a href='#' onclick='download(\""+fileName[i]+"\")'>"+ fileName[i]+"</a></td>"+
                                "<td>"+ SubTime[i]+"</td>"+
                                "<td><a href=\"#\" onClick=\'showDetail(\""+studentId[i]+"\",\""+studentName[i]+"\",\""+fileName[i]+"\")\'>审批</a></td></tr>";
                        }
                    }else{
                        for (var i = 0 ; i<${lineCount} ; i++){
                            list += "<tr><td>"+(i+1)+"</td>" +
                                "<td>"+studentId[i]+"</td>" +
                                "<td>"+studentName[i]+"</td>" +
                                "<td>"+ topicId[i]+"</td>"+
                                "<td>"+ topicName[i]+"</td>"+
                                "<td title=\"下载文件\"><a href='#' onclick='download(\""+fileName[i]+"\")'>"+ fileName[i]+"</a></td>"+
                                "<td>"+ SubTime[i]+"</td>"+
                                "<td><a href=\"#\" onClick=\'showDetail(\""+studentId[i]+"\",\""+studentName[i]+"\",\""+fileName[i]+"\")\'>审批</a></td></tr>";
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

         function Download(name) {
             alert("${type}");
             var path = "http://localhost:8080/UploadFile/";
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
             window.location.href=path+name;
         }
    </script>
</body>
</html>
