<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE HTML>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>${webName}-重置密码</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/login.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.md5.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/statics/js/jquery.form.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/statics/js/jquery-validation-1.8.1/jquery.validate.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/findPsw.js"></script>
</head>
<body>
<div class="m-top">
    <a class="back" href="javascript:void(0);" onclick="history.go(-1);"></a>
    <div class="toggle-box">重置密码</div>
</div>

<form method="post" id="findPswForm" name="findPswForm" >
<div class="login-main reset-main">
    <div class="mt">
        <div class="item">
            <span>手机号</span>
            <input type="text" id="userMobile" name="userMobile" maxlength="11"   placeholder="请输入11位手机号码">
        </div>
        <div class="item">
            <span>验证码</span>
            <a href="javascript:void(0);" class="send" onclick="sendValidateNum(this)" id="second" >发送验证码</a>
            <input type="text"  name="messageCode" id="messageCode"  maxlength="6" placeholder="请输入手机验证码">
        </div>
        <div class="item">
            <span>设置密码</span>
            <a href="javascript:;" class="del-btn"></a>
            <input type="password" id="userPsw" name="userPsw" maxlength="20"  placeholder="请设置6-20位登录密码">
        </div>
    </div>
    <a href="javascript:;" class="login-btn disbale" id="fetchPassword">重置密码</a>
</div>
</form>
<%--提示窗口--%>
<div id="tipsDiv" class="rem-get" style="display: none;" ><span id="tipsSpan"></span></div>
</body>
</html>
