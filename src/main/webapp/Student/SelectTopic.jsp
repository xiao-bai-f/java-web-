<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看并选择课题</title>
	<link rel="stylesheet" href="../layui/css/layui.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/css/bootstrap.min.css" />
	<script src="webjars/jquery/3.4.1/jquery.min.js"></script>
	<script src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
			<h2 align="center">${CollegeName}论文课题</h2>
			<div class="select" align="left">
				<form action="findTopic" method="post">
					<select name="selectId">
						<option value="1" >课题编号</option>
						<option value="2" >课题名称</option>
						<option value="3" >教师编号</option>
						<option value="4" >教师名称</option>
						<option value="5" >是否被选择</option>
					</select>
					<input type="text" name="selectName">
					<input type="submit" value="查找">
				</form>
			</div>
			<table style="width: 1400px;" align="center" class="table table-striped table-hover table-bordered">
				<thead>
				<tr>
					<th>序号</th>
					<th>课题编号</th>
					<th>课题名称</th>
					<th>课题描述</th>
					<th>课题要求</th>
					<th>发布时间</th>
					<th>教师</th>
					<th>是否被选择</th>
				</tr>
				</thead>
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
			.select{
				/*border: 1px solid red;*/
				margin-left: 40px;
				width: 350px;
			}
		</style>
		<!-- 正式代码 -->
		<script>
            var topicId = new Array();
            var topicName = new Array();
            var topicDesc = new Array();
            var topicRequier = new Array();
            var teacherName = new Array();
            var isSelected = new Array();
            var publishTime = new Array();
		</script>
		<c:forEach items="${TopicList}" var="topic">
			<script>
                topicId.push("${topic.topicId}");
                topicName.push("${topic.topicName}");
                topicDesc.push("${topic.topicDesc}");
                teacherName.push("${topic.teacherName}");
                topicRequier.push("${topic.topicRequier}");
                isSelected.push("${topic.isSelected}");
                publishTime.push("${topic.publishTime}");
			</script>
		</c:forEach>
		<%--<p id="text">所在学院没有教书提供试题</p>--%>
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
	<script type="text/javascript">
		window.onload = function (){
		    if(${TopicCount} > 0 ){
                ShowPage(1);
            }

        }
		//显示试题的详细信息
		function ShowTopic(){
			//var window2 = new window();
			//window.open('','_blank','width=400,height=100,menubar=no,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=yes')
			//window.showModalDialog("StudentMain",,"dialogWidth=200px;dialogHeight=100px");  
		}
		//确认选择
		function selectTopic(id){
			window.location.href="selectTopic?topicId="+id;
		}
	</script>
<script type="text/javascript">
    var pageSize =10;//每页显示行数
    var lineCount = ${TopicCount};//总行数
    var index = 1;	//默认当前页数

    function ShowPage(index){
        PageSize = this.pageSize;
        //计算总页数
        PageCount =  Math.ceil(lineCount/PageSize);
        //只有一页

        if(PageCount == 1){
            var topicText="";
            for (var i = 0; i < ${TopicCount}; i++) {
                topicText +="<tr><td>"+(i+1)+"</td>";
                topicText +="<td>"+topicId[i]+"</td>";
                topicText +="<td><a href=\"#\" onClick=\"ShowTopic()\">"+topicName[i]+"</a></td>";
                topicText +="<td>"+topicDesc[i]+"</td>";
                topicText +="<td>"+topicRequier[i]+"</td>";
                topicText +="<td>"+publishTime[i]+"</td>";
                topicText +="<td>"+teacherName[i]+"</td>";
                if(${IsTopic} == 0){
                    if(isSelected[i] == 'no'){
                        topicText += "<td><button type=\"button\" class = \" btn btn_success\" onClick=\"selectTopic(" + topicId[i] + ")\">选择课题</button></td><tr>";
                    }else{
                        topicText+="<td>被选择</td><tr>";
                    }
                }else{
                    topicText+="<td>不能重复选择</td><tr>";
                }
            }
            document.getElementById("data").innerHTML = topicText;

        }else{//有多页
            var topicText="";
            //判断当前页
            var currentLine = ((index-1)*PageSize);	//显示当前行
            if(lineCount%PageSize == 0){	//没有余数
                for(var i = currentLine;i<(index*PageSize);i++){
                    topicText +="<tr><td>"+(i+1)+"</td>";
                    topicText +="<td>"+topicId[i]+"</td>";
                    topicText +="<td><a href=\"#\" onClick=\"ShowTopic()\">"+topicName[i]+"</a></td>";
                    topicText +="<td>"+topicDesc[i]+"</td>";
                    topicText +="<td>"+topicRequier[i]+"</td>";
                    topicText +="<td>"+publishTime[i]+"</td>";
                    topicText +="<td>"+teacherName[i]+"</td>";
                    if(${IsTopic} == 0){
                        if(isSelected[i] == 'no'){
                            topicText += "<td><button type=\"button\" class = \" btn btn_success\" onClick=\"selectTopic(" + topicId[i] + ")\">选择课题</button></td><tr>";
                        }else{
                            topicText+="<td>被选择</td><tr>";
                        }
                    }else{
                        topicText+="<td>不能重复选择</td><tr>";
                    }
                }
            }else{	//有余数
                if((index == PageCount)){
                    lastCount = lineCount - PageSize*(index-1);

                    for(var i = currentLine;i<lineCount;i++){
                        topicText +="<tr><td>"+(i+1)+"</td>";
                        topicText +="<td>"+topicId[i]+"</td>";
                        topicText +="<td><a href=\"#\" onClick=\"ShowTopic()\">"+topicName[i]+"</a></td>";
                        topicText +="<td>"+topicDesc[i]+"</td>";
                        topicText +="<td>"+topicRequier[i]+"</td>";
                        topicText +="<td>"+publishTime[i]+"</td>";
                        topicText +="<td>"+teacherName[i]+"</td>";
                        if(${IsTopic} == 0){
                            if(isSelected[i] == 'no'){
                                topicText += "<td><button type=\"button\" class = \" btn btn_success\" onClick=\"selectTopic(" + topicId[i] + ")\">选择课题</button></td><tr>";
                            }else{
                                topicText+="<td>被选择</td><tr>";
                            }
                        }else{
                            topicText+="<td>不能重复选择</td><tr>";
                        }
                    }
                }else{
                    for(var i = currentLine; i<(index*PageSize) ;i++){
                        topicText +="<tr><td>"+(i+1)+"</td>";
                        topicText +="<td>"+topicId[i]+"</td>";
                        topicText +="<td><a href=\"#\" onClick=\"ShowTopic()\">"+topicName[i]+"</a></td>";
                        topicText +="<td>"+topicDesc[i]+"</td>";
                        topicText +="<td>"+topicRequier[i]+"</td>";
                        topicText +="<td>"+publishTime[i]+"</td>";
                        topicText +="<td>"+teacherName[i]+"</td>";
                        if(${IsTopic} == 0){
                            if(isSelected[i] == 'no'){x
                                topicText += "<td><button type=\"button\" class = \" btn btn_success\" onClick=\"selectTopic(" + topicId[i] + ")\">选择课题</button></td><tr>";
                            }else{
                                topicText+="<td>被选择</td><tr>";
                            }
                        }else{
                            topicText+="<td>不能重复选择</td><tr>";
                        }
                    }
                }
            }
            document.getElementById("data").innerHTML = topicText;
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