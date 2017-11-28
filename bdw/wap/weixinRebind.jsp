<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:if test="${not empty loginUser}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>
<%--判断微信页面，如果不是跳出微信绑定页面--%>
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
    <title>${webName}-解绑</title>
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
    <script src="${webRoot}/template/bdw/wap/statics/js/weixinBind.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>

</head>
<body>

<form method="post" id="registerForm" name="registerForm" >
    <div class="login-main reset-main">
        <div style="text-align: center; ">
            <span style="font-size: 0.4rem;">账户${loginId}已绑定微信账号  </span>
            <br/>
            <span style="font-size: 0.4rem;">继续绑定将解绑原微信账号</span>
        </div>
        <div style="text-align: center; margin: 0 auto;">
        <a href="javascript:;" class="login-btn " style="display: inline-block; margin:0.3rem; " onclick="window.location.href='${webRoot}/wap/login.ac?'" >返回</a>
        <a href="javascript:;" class="login-btn " style="display: inline-block; margin:0.3rem;" onclick="window.location.href='${webRoot}/wap/passwordBind.ac?loginId=${loginId}'">继续绑定</a>

        </div>
    </div>
</form>
<%--提示窗口--%>
<div id="tipsDiv" class="rem-get" style="display: none;overflow: hidden;"><span id="tipsSpan"></span></div>
</body>
</html>

