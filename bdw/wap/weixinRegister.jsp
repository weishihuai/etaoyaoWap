<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${param.loginId}" var="loginId"/>
<c:if test="${not empty loginUser}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>
<%--判断微信页面，如果不是跳出微信绑定页面--%>

<c:if test="${isWeixin eq 'N'}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<c:if test="${empty loginId}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>
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
    <link href="${webRoot}/template/bdw/wap/statics/css/weixinLogin.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.form.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-validation-1.8.1/jquery.validate.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/weixinRegister.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.md5.js" type="text/javascript" ></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>

</head>
<body>



<div class="login-main reset-main">
    <span style="line-height: 0.96rem;">请设置商城账号登陆密码，完成注册绑定</span>
    <div class="mt">

        <input type="hidden"  id="loginId" name="loginId"  value="${loginId}">

        <div class="item"  >
            <span>验证码</span>
            <a href="javascript:;" class="send" id="second" onclick="sendCode()">发送验证码</a>
            <input type="text" name="code" id="code"  maxlength="6" placeholder="输入手机验证码" >
        </div>
        <div class="item">
            <span>密码</span>
            <a href="javascript:;" class="del-btn" style="display: none;"></a>
            <input type="password" id="userPsw" maxlength="20" name="userPsw"  placeholder="设置登录密码">
        </div>
    </div>

    <a href="javascript:;" class="login-btn disbale" onclick="checkRegisterForm()">下一步</a>
</div>

<%--提示窗口--%>
<div id="tipsDiv" class="rem-get" style="display: none;overflow: hidden;"><span id="tipsSpan"></span></div>
</body>
</html>

