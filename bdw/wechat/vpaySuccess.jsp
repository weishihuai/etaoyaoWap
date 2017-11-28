<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getSysParamValue('authorityWeixin')}" var="authorityWeixin"/>
<!DOCTYPE HTML>
<html>
<head>
    <title>支付完成</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/wap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/jquery.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/bootstrap.min.js"></script>
</head>
<body style="background:#f7f7f7;">
    <div class="container zfwc">
        <div class="row zfwc_row" style=" font-size: 18px; margin-bottom: 20px;">
            <div class="col-xs-12">恭喜您支付已完成，</div>
            <div class="col-xs-12">感谢您对我们的支持！</div>
        </div>
        <div class="row zfwc_row2" style="font-size:16px; ">
            <div class="col-xs-12">请关注我们的官方微信：</div>
        </div>
        <div class="row zfwc_row" style="margin-top:0px;">
            <div class="col-xs-12">${authorityWeixin}</div>
        </div>
    </div>
    <div class="col-xs-10 col-xs-push-1"><a role="button" href="${webRoot}/wap/module/member/orderDetail.ac?id=${param.id}" class="btn btn-success btn-lg btn-block">查看订单详情</a></div>
    <div class="col-xs-10 col-xs-push-1" style="margin-top: 20px;"><a role="button" href="${webRoot}/wap/index.ac" class="btn btn-default btn-lg btn-block">返回商城首页</a></div>
</body>
</html>