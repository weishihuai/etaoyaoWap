<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:if test="${not empty loginUser}">
    <c:redirect url="/index.ac"></c:redirect>
</c:if>

<%--判断微信页面，如果是跳入微信绑定页面--%>
<c:if test="${empty loginUser}">
    <c:if test="${isWeixin eq 'Y'}">
        <c:redirect url="/wap/weixinBind.ac"></c:redirect>
    </c:if>
</c:if>


<%-- 登录后返回登录前页面 --%>
<%
    String source = request.getHeader("Referer");
    if(source!=null && !source.contains("register.ac")){
        request.getSession().setAttribute("redirectUrl",source);
    }
%>
<!DOCTYPE HTML>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>${webName}-登录</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/login.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.md5.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/loginValidate.js" type="text/javascript" ></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/loginValidateCode.js" type="text/javascript"></script><%--登录验证插件--%>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
</head>
<body>
<div class="m-top">
    <a class="back" href="javascript:void(0);" onclick="history.go(-1);"></a>
    <div class="toggle-box">${webName}登录</div>
</div>
<form method="post"  id="loginForm" name="loginForm" >
<div class="login-main">
    <div class="mt">
        <div class="item">
            <span>账号</span>
            <input type="text"  id="loginId" placeholder="请输入账号" maxlength="11">
        </div>
        <div class="item">
            <span>密码</span>
            <a href="javascript:void(0);" class="del-btn" id="cancel-psw"></a>
            <input type="password" id="userPsw" name="userPsw" placeholder="请输入密码" maxlength="20">
        </div>
        <div class="item ver-code" style="display:none;"  id="validateCodeField">
            <div class="pic"><a href="javascript:;"><img id="validateCodeImg" src='<%=request.getContextPath()%>/ValidateCode' onclick="changValidateCode()"></a></div>
            <a href="javascript:;" class="del-btn" id="cancel-validateCode"></a>
            <input type="text" name="validateCode" id="validateCode" maxlength="4" placeholder="验证码(点击图片可刷新)">
            <span class="jud-error"></span>
        </div>
    </div>
    <a href="javascript:void(0);" class="login-btn disbale" onclick="$('#loginForm').submit();">登录</a>
    <div class="quick-nav">
        <a href="${webRoot}/wap/findPsw.ac" class="find">找回密码</a>
        <a href="${webRoot}/wap/register.ac" class="register">快速注册</a>
    </div>
    <%--<div class="other">
        <div class="ot-top"><span>其它登录方式</span></div>
        <div class="ot-bot">
            <a href="javascript:void(0);"><img src="${webRoot}/template/bdw/wap/statics/images/qq.png" alt=""></a>
            <a href="javascript:void(0);"><img src="${webRoot}/template/bdw/wap/statics/images/taobao.png" alt=""></a>
            <a href="javascript:void(0);"><img src="${webRoot}/template/bdw/wap/statics/images/weibo.png" alt=""></a>
        </div>
    </div>--%>
</div>
</form>
<div id="tipsDiv" class="rem-get" style="display: none;" ><span id="tipsSpan"></span></div>
</body>
</html>

