<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${sdk:getSysParamValue('index_keywords')}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${sdk:getSysParamValue('index_description')}" /> <%--SEO description优化--%>
    <title>${webName}-商家违规-${sdk:getSysParamValue('index_title')}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/register.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script>
        window.onload=function()
        {
            setInterval("redirect();",5000);
        };
        function redirect()
        {
            window.location.href="${webRoot}/citySend/index.ac";

        }
    </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<div id="register">
    <div class="resulr">
        <div class="box"  style="padding-top:60px;">
            <h1>该门店可能由于触犯商城规定违规被冻结或者已经关闭！请联系客服！</h1>
            <p style="font-size: 14px;">5秒后默认返回淘药店首页，如果您的浏览器没有跳转，请<a href="${webRoot}/citySend/index.ac">点击这里</a></p>
        </div>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</html>
