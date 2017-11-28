<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>二维码扫描失败页</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="http://cdn.bootcss.com/twitter-bootstrap/3.0.3/css/bootstrap.min.css">
</head>
<body class="container">
<div class="row" style="margin-top:10px;">
    <div class="col-xs-5"><img src="${webRoot}/template/bdw/statics/images/weixin001.png" class="img-responsive" ></div>
    <div class="col-xs-7" style="line-height:50px;"><p>您好，请使用微信进行二维码扫描！</p></div>
</div>
</body>
</html>
