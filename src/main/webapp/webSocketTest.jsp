<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>弹出层</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/css/bootstrap.min.css" />
	<script src="webjars/jquery/3.4.1/jquery.min.js"></script>
	<script src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<style>
		.black_overlay{
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
			top: 10%;
			left: 10%;
			width: 80%;
			height: 80%;
			border: 16px solid lightblue;
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
	<script type="text/javascript">
        //弹出隐藏层
        function ShowDiv(show_div,bg_div){
            document.getElementById(show_div).style.display='block';
            document.getElementById(bg_div).style.display='block' ;
            var bgdiv = document.getElementById(bg_div);
            bgdiv.style.width = document.body.scrollWidth;
            // bgdiv.style.height = $(document).height();
            $("#"+bg_div).height($(document).height());
        };
        //关闭弹出层
        function CloseDiv(show_div,bg_div)
        {
            document.getElementById(show_div).style.display='none';
            document.getElementById(bg_div).style.display='none';
        }
	</script>
</head>
<body>

<input id="Button1" type="button" value="点击弹出层" onclick="ShowDiv('MyDiv','fade')" />
<!--弹出层时背景层DIV-->
<div id="fade" class="black_overlay">
</div>
<div id="MyDiv" class="white_content">
	<div style="text-align: right; cursor: default; height: 40px;">
		<a href="#" style="font-size: 16px;" onclick="CloseDiv('MyDiv','fade')">关闭</a>
	</div>
	<p><strong>helloworld</strong></p>
</div>
</body>
</html>