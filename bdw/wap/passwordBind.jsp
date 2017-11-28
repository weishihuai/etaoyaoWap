<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:if test="${not empty loginUser}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>
<%--&lt;%&ndash;判断微信页面，如果不是跳出微信绑定页面&ndash;%&gt;--%>

<c:if test="${isWeixin eq 'N'}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<c:set value="${param.loginId}" var="loginId"/>
<c:if test="${empty loginId}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>
<!DOCTYPE HTML>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>${webName}-绑定</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/weixinLogin.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.md5.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.form.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-validation-1.8.1/jquery.validate.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/passwordBind.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>

</head>
<body>


    <div class="login-main reset-main">
        <span>请输入商城账户${loginId}的密码，完成绑定</span>
        <div class="mt">
            <div class="item" style="padding-left:0px">
                <input type="hidden"  id="loginId" name="loginId" value="${loginId}">
                <a href="javascript:;" class="del-btn" style="display: none;"></a>
                <input type="password" id="userPsw" maxlength="20" name="userPsw"  placeholder="请输入登录密码">
            </div>
        </div>
        <a href="javascript:;" class="login-btn disbale" onclick="confirmLogin()">登录绑定</a>
        <div class="quick-nav">
            <a href="${webRoot}/wap/findPsw.ac" class="find">找回密码</a>
        </div>
    </div>

<%--提示窗口--%>
<div id="tipsDiv" class="rem-get" style="display: none;overflow: hidden;"><span id="tipsSpan"></span></div>
</body>
</html>

