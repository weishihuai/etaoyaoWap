<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-注册成功-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/register.css" rel="stylesheet" type="text/css" />
	<link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
	<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
	<script>
		window.onload=function()
		{
			setInterval("redirect();",5000);
		};
		function redirect()
		{
			window.location.href="${webRoot}/index.ac?firstLogin=1";
		}
	</script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="register">
	<div class="resulr">
		<div class="box">
			<h1>恭喜您注册成功，您接下来可以点击进入：</h1>
			<h2>1、进入<a href="${webRoot}/module/member/index.ac">会员管理中心</a>完善基本信息以及查看订单</h2>
			<h2>2、进入<a href="${webRoot}/index.ac?firstLogin=1">${webName}</a>立即开始您的购物之旅</h2>
			<p>默认返回首页，如果您的浏览器没有跳转，请<a href="${webRoot}/index.ac?firstLogin=1">点击这里</a></p>
		</div>
	</div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</html>
