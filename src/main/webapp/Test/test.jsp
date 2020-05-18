<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>测试josn</title>
    <script src="${pageContext.request.contextPath}/webjars/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
    <button id="" onclick="search()">点击</button>

    <script>
    function search() {
        $.ajax({
            url:"${pageContext.request.contextPath}/Student/test",
            type:"GET",
            // dataType:"json",
            // data:"你好",
            success:function(data){
                alert(data.success);
                alert(data.message);
            }
        });
    }

    </script>
</body>
</html>
