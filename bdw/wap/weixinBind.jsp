<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:if test="${not empty loginUser}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>
<%--判断微信页面，如果不是跳出微信绑定页面--%>
    <c:if test="${isWeixin eq 'N'}">
        <c:redirect url="/wap/index.ac"></c:redirect>
    </c:if>
<%--<%--%>
    <%--session.setAttribute("openId", "5");--%>
<%--%>--%>

<!DOCTYPE HTML>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>${webName}-微信绑定</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/weixinLogin.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/weixinBind.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>

</head>
<body>


    <div class="login-main reset-main">
    <span>您的账号信息尚未完善,请输入手机号进行绑定</span>
        <div class="mt">
            <div class="item" style="padding-left:0px">
                <input type="text"  id="loginId" name="loginId"  maxlength="11"  placeholder="请输入11位手机号码">
                <input type="hidden"  id="openId" name="openId" value="${openId}" >
            </div>
        </div>
        <a href="javascript:;" class="login-btn disbale" onclick="checkIsRegisterAndBand()">下一步</a>
    </div>

<%--提示窗口--%>
<div id="tipsDiv" class="rem-get" style="display: none;overflow: hidden;"><span id="tipsSpan"></span></div>
</body>
</html>

