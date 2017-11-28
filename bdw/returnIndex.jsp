<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>返回首页-${webName}</title>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .m_center{
            height: 450px;
            width: 1190px;
            margin: 0px auto;
            text-align: center;
            padding-top: 70px;
        }
    </style>
    <script type="text/javascript">
        window.onload=function()
        {
            setInterval("redirect();",5000);
        };
        function redirect() {
            window.location.href="${webRoot}/index.ac";
        }
    </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=list"/>
<%--页头结束--%>
<div class="m_center">
    <img src="${webRoot}/template/bdw/statics/images/404-bg_446x222.png"/>
    <p style="font-size: 24px;">开发中, 敬请期待...</p>
    <span style="margin-top: 10px;font-size: 16px;"><em style="color: #e5151d;">5</em>秒后自动返回首页</span>
</div>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页头结束--%>
</body>
</html>
