<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getSysParamValue('webPhone')}" var="webPhone"/>                        <%--客服热线--%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>申请推广员</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-mine.css">
</head>

<body>

<div class="main m-apply-state">
    <%--<header class="header">
        <a href="javascript:history.go(-1);" class="back"></a>
        <div class="header-title">申请推广员</div>
    </header>--%>
    <div class="state">
            <span class="state-img">
                <img src="${webRoot}/template/bdw/wap/module/member/cps/statics/images/tick-light_62x46.png" alt="">
            </span>
        <p class="state-desc">申请成功，等待平台审核</p>
    </div>
    <div class="service">
        <p>客服热线：<em>${webPhone}</em></p>
        <p>我们会尽快帮你审核，请耐心等待！</p>
    </div>
    <a class="btn-block" href="${webRoot}/wap/module/member/index.ac?type=member">返回首页&ensp;(<span id="countDown">10</span>s)</a>
</div>

<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/myPromoteRegisterThirdStep.js"></script>
<script type="text/javascript">
    var webPath = {webRoot:"${webRoot}"};
</script>
</body>

</html>

