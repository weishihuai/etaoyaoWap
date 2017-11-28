<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE HTML>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>${webName}-注册</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/login.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.form.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-validation-1.8.1/jquery.validate.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/register.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.md5.js" type="text/javascript" ></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>

</head>
<body>
<div class="m-top">
    <a class="back" href="javascript:void(0);" onclick="history.go(-1);"></a>
    <div class="toggle-box">${webName}注册</div>
</div>

<form method="post" id="registerForm" name="registerForm" >
<div class="login-main reset-main">
    <div class="mt">
        <div class="item">
            <span>手机号</span>
            <input type="text"  id="loginId" name="loginId"  maxlength="11"  placeholder="请输入11位手机号码">
        </div>
        <div class="item">
            <span>验证码</span>
            <a href="javascript:;" class="send" id="second" onclick="sendCode()">发送验证码</a>
            <input type="text" name="code" id="code"  maxlength="6" placeholder="请输入手机验证码" >
        </div>
        <div class="item">
            <span>设置密码</span>
            <a href="javascript:;" class="del-btn" style="display: none;"></a>
            <input type="password" id="userPsw" maxlength="20" name="userPsw"  placeholder="请设置6-20位登录密码">
        </div>
    </div>
    <div class="agreement">
        <span class="agree">同意</span>
        <a href="${webRoot}/wap/registerProvisions.ac">《${webName}用户服务协议》</a>
    </div>
    <a href="javascript:;" class="login-btn disbale" onclick="checkRegisterForm()">注册</a>
</div>
</form>
<%--提示窗口--%>
<div id="tipsDiv" class="rem-get" style="display: none;overflow: hidden;"><span id="tipsSpan"></span></div>
</body>
</html>

