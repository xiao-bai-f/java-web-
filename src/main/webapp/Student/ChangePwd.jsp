<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2020/4/5
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>
    <script>
        window.onload = function () {
            switch (${result}){
                case 0 :
                    alert("修改失败");
                    break;
                case 1 :
                    alert("修改成功")
                    window.location.href = "/Student/StudentMain?id=1";
                    break;
            }
        }

    </script>
</head>
<body>

    <form action="ChangePwd" method="post">
        <table>
            <%--<tr>--%>
                <%--<td>旧密码：<input type="password" name="oldpwd" value="${pwd}"></td>--%>
            <%--</tr>--%>
            <tr>
                <td>新密码：<input type="password" name="newpwd"></td>
            </tr>
            <tr>
                <td>确认密码：<input type="password" name= "dpwd"></td>
            </tr>
            <tr>
                <td><input type="submit" value="确定"></td>
            </tr>
        </table>

    </form>
</body>
</html>
