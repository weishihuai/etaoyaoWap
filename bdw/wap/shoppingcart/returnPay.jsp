<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<html>

<head lang="en">
    <meta charset="utf-8">
    <title>提交订单-成功</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/order.css" type="text/css" rel="stylesheet" />
</head>

<body>

<div class="m-top">
    <a href="javascript:history.go(-1);" class="back"></a>
    <span>订单支付成功</span>
</div>
<div class="order-main">
    <div class="submit-order">
        <div class="dt"><em></em><p>恭喜！您已成功支付订单</p></div>
        <div class="submit-btn-box"><a class="check-btn" href="${webRoot}/wap/module/member/myOrders.ac">查看订单</a><a class="return-index-btn" href="${webRoot}/wap/index.ac">返回首页</a></div>
    </div>
</div>
<script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
</body>
