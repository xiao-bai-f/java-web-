<%@ page language="java" contentType="text/html; charset=UTF-8" 
     pageEncoding="UTF-8" isELIgnored="false"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--
	教师对学生管理界面 
	前端界面：
		搜索栏：搜索范围：教师所在院系
			默认按查找本系所有学生，按学号查找，按专业查找、按姓名查找、按是否已选试题查找、按班级查找
			
		列表显示：学生信息，
	
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看课题</title>
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
            <li class="layui-nav-item"><a href="/Teacher/TeacherMain?id=3" title="刷新"><i class="layui-icon layui-icon-refresh-3"></i></a></li>
            <li class="layui-nav-item"><a href="/Teacher/Download" title="文件下载"><i class="layui-icon layui-icon layui-icon-download-circle"></i></a></li>
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
                        <dd><a href="/Teacher/">审批课题</a></dd>
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
        <!-- 查看试题信息-->
        <div class="container" align="left">
            <h1 align="center">学生管理</h1>
            <!-- 搜索栏-->
            <div class="select">
                <form action="CheckStudent" method="post">
                    <%--<select name="selectId">--%>
                        <%--<option value="">高级查询</option>--%>
                        <%--<option value="2" >班级编号</option>--%>
                        <%--<option value="3" >已选择试题</option>--%>
                    <%--</select>--%>
                    <input type="text" placeholder="学号或名称" name="selectName">
                    <input type="submit" value="查询"></form>
            </div>

                <table style="width: 1300px;" align="center" class="table table-striped table-hover table-bordered">
                    <thead>
                    <th>序号</th>
                    <th>学生学号</th>
                    <th>学生姓名</th>
                    <th>是否选择课题</th>
                    <th>开题报告</th>
                    <th>中期检查报告</th>
                    <th>论文初稿</th>
                    <th>论文定稿</th>
                    <th>论文终稿</th>
                    </thead>
                    <tbody id="test"></tbody>
                </table>
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
            .select{
                margin-left: 85px;
                width: 350px;
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
    var topicId = new Array();
    var topicName= new Array();
    var topicDesc = new Array;
    var topicRequier = new Array;
    var studentId  = new Array();
    var studentName  = new Array();
    var publishTime = new Array;
    //JavaScript代码区域

    layui.use('element', function(){
        var element = layui.element;

    });

    function ChangeTopic(topicId){
        alert("修改课题");
    }


</script>

	<script type="text/javascript">
		window.onload = function(){
            if(${lineCount} != 0 ){
                ShowPage(1);
            }

		}
		var isTopic = new Array();
		var isOpen= new Array();
		var isMid= new Array();
		var isFirst= new Array();
		var isSecond= new Array();
		var isLast= new Array();
	</script>
	
	<!-- 遍历学生信息 -->
	<c:forEach items ="${studentList}"  var = "student"> 
		<script type="text/javascript">
			studentId.push("${student.studentId}");
			studentName.push("${student.studentName}");
            isTopic.push("${student.isTopic}");
            isOpen.push("${student.isOpenReport}");
            isMid.push("${student.isMidReport}");
            isFirst.push("${student.isThesisFirst}");
            isSecond.push("${student.isThesisSecond}");
            isLast.push("${student.isThesisLast}");
		</script>
 	</c:forEach>


	<script type="text/javascript">
		var pageSize = 10;//每页显示行数
		var lineCount = ${lineCount};//总行数
		var index = 1;	//默认当前页数

		function ShowPage(index){
			PageSize = this.pageSize;
			//计算总页数
			PageCount =  Math.ceil(lineCount/PageSize);
			//只有一页
			
			if(PageCount == 1){
				var text="";
				for(var i = 0; i<lineCount; i++){
				    text+="<tr><td>"+(i+1)+"</td>"+
                        "<td>"+studentId[i]+"</td>"+
                        "<td>"+studentName[i]+"</td>" +
                        "<td>"+isTopic[i]+"</td>" +
                        "<td>"+isOpen[i]+"</td>" +
                        "<td>"+isMid[i]+"</td>" +
                        "<td>"+isFirst[i]+"</td>" +
                        "<td>"+isSecond[i]+"</td>" +
                        "<td>"+isLast[i]+"</td>" +
                        "<tr>";

				}
				document.getElementById("test").innerHTML = text;
				
			}else{//有多页
				var text="";
				//判断当前页
				var currentLine = ((index-1)*PageSize);	//显示当前行
				if(lineCount%PageSize == 0){	//没有余数
					for(var i = currentLine;i<(index*PageSize);i++){
                        text+="<tr><td>"+(i+1)+"</td>"+
                            "<td>"+studentId[i]+"</td>"+
                            "<td>"+studentName[i]+"</td>" +
                            "<td>"+isTopic[i]+"</td>" +
                            "<td>"+isOpen[i]+"</td>" +
                            "<td>"+isMid[i]+"</td>" +
                            "<td>"+isFirst[i]+"</td>" +
                            "<td>"+isSecond[i]+"</td>" +
                            "<td>"+isLast[i]+"</td>" +
                            "<tr>";					}
				}else{	//有余数
					if((index == PageCount)){
						lastCount = lineCount - PageSize*(index-1);
						
						for(var i = currentLine;i<lineCount;i++){

                            text+="<tr><td>"+(i+1)+"</td>"+
                                "<td>"+studentId[i]+"</td>"+
                                "<td>"+studentName[i]+"</td>" +
                                "<td>"+isTopic[i]+"</td>" +
                                "<td>"+isOpen[i]+"</td>" +
                                "<td>"+isMid[i]+"</td>" +
                                "<td>"+isFirst[i]+"</td>" +
                                "<td>"+isSecond[i]+"</td>" +
                                "<td>"+isLast[i]+"</td>" +
                                "<tr>";						}
					}else{
						for(var i = currentLine; i<(index*PageSize) ;i++){
                            text+="<tr><td>"+(i+1)+"</td>"+
                                "<td>"+studentId[i]+"</td>"+
                                "<td>"+studentName[i]+"</td>" +
                                "<td>"+isTopic[i]+"</td>" +
                                "<td>"+isOpen[i]+"</td>" +
                                "<td>"+isMid[i]+"</td>" +
                                "<td>"+isFirst[i]+"</td>" +
                                "<td>"+isSecond[i]+"</td>" +
                                "<td>"+isLast[i]+"</td>" +
                                "<tr>";						}
					}
				}

				document.getElementById("test").innerHTML = text;			
			}
			var Pagebottom = "共"+lineCount+"条记录 分"+PageCount+"页 当前是第"+index+"页 ";
			if(index > 1){
				Pagebottom += "<a href= \"#\" onClick=\"ShowPage(1)\">首页</a>";
				Pagebottom +="<a href=\"#\" onClick=\"ShowPage("+(index-1)+")\">上一页</a>"
			}else{
				
				Pagebottom += "首页 ";
				Pagebottom += " 上一页";
			}
			if(index < PageCount){
				Pagebottom +="<a href=\"#\" onClick=\"ShowPage("+(index+1)+")\">下一页</a>";
				Pagebottom += "<a href= \"#\" onClick=\"ShowPage("+PageCount+")\">尾页</a>";
			}else{
				Pagebottom += "下一页";
				Pagebottom += "尾页";
			}	
			document.getElementById("PageBottom").innerHTML = Pagebottom;
		}
	</script>

</body>
</html>