<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2020/4/1
  Time: 9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>审批${type}</title>
</head>
<body>
    <!--
        见面设置：
            1、开题报告列表、
            2、审批意见文办区
            3、确定审批结果按钮 (同意、退回)
    -->
    <script>
        window.onload = function () {

            showPage();
        }
        var studentId = new Array();
        var studentName = new Array();
        var fileName = new Array();
        var reportStudentId = new Array();
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
            reportStudentId.push("${report.studentId}");
        </script>
    </c:forEach>

    <script>
        function showPage() {
            var list = "<ul>";
            for (var i = 0 ; i<${lineCount} ; i++){
                <%--for (var j = 0 ; i<${ReportCount} ; j++){--%>
                    // if(studentId[i] == reportStudentId[j]){
                        list += "<li>学生编号"+studentId[i]+"学生姓名"+studentName[i]+"<a href=\"#\" onClick=\'showDetail(\""+studentId[i]+"\",\""+studentName[i]+"\",\""+fileName[i]+"\")\'>查看详情</a></li>";
                        // break;
                    // }
                // }
            }
            list += "</ul>";
            document.getElementById("list").innerHTML = list;
        }
        function showDetail(id,name,filename){
            //设置隐藏值

            document.getElementById("hiddenId").innerHTML = " <input type=\"hidden\" name=\"studentId\" value="+id+">";
            document.getElementById("hiddenName").innerHTML = " <input type=\"hidden\" name=\"studentName\" value="+name+">";
            document.getElementById("fileName").innerHTML = "<input type=\"hidden\" name=\"fileName\" value="+filename+">"
            alert("123");
            document.getElementById("person").innerHTML = name;
            //显示上传的细节
        }
    </script>
    <h1>审批${type}</h1>
    <p id="list"></p>
    <form action = "/DealApproval" method="post"><table>
        <tr>
            <td><p id="hiddenId"></p></td>
            <td><p id="hiddenName"></p></td>
            <td><input type="hidden" name="type" value=${type}></td>
            <td><p id="fileName"></p></td>
        </tr>
        <tr>
            <td>审批对象:<label id="person"></label></td>
        </tr>
        <tr>
            <td>审批意见</td>
        </tr>
        <tr><td><textarea rows="6" cols="60" name="opinionText"></textarea></td></tr>
        <tr>
            <td><input type="submit" value="同意" name="opinion"></td>
            <td><input type="submit" value="退回" name="opinion"></td>
        </tr>
    </table></form>
</body>
</html>
