<%--
  Created by IntelliJ IDEA.
  User: ljt
  Date: 14-3-25
  Time: 下午6:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/weixinSdk" prefix="weixinSdk"%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>我的账户</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/wdjp.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>

</head>

<body>
<div class="container wdzh">
    <div class="row">
        <div class="col-xs-4 wx_pic"><i><img src="${webRoot}/template/bdw/oldWap/statics/images/wx_pic.png" width="66" height="54"></i></div>
        <div class="col-xs-8">
            <div class="col-xs-12 yh">微信用户</div>
            <div class="col-xs-12 dj">会员昵称：${loginUser.vuserName}</div>
            <div class="col-xs-12 dj">会员等级：${loginUser.level}<%--VIP1--%></div>
        </div>
    </div>
</div>
<div class="container wdzh">
    <div class="row">
        <div class="col-xs-12 w_text">建议完善资料能达到更好的购物体验</div>
        <div class="col-xs-12"><a href="${webRoot}/wap/module/member/perfectionUserInfo.ac?userid=${loginUser.userId}" class="btn btn-block" role="button" style="background:#04b10f; color:#fff; font-size:16px; margin-bottom:15px;">完善资料</a></div>
    </div>
</div>

<div class="container wdzh">
    <div class="row">
        <c:choose>
            <c:when test="${!loginUser.isBinding}">
                <div class="col-xs-12 w_text">如果您有${webName}帐号请绑定</div>
                <div class="col-xs-12"><a href="${webRoot}/wap/module/member/boundAccount.ac?userid=${loginUser.userId}" class="btn btn-block" role="button" style="background:#e53621; color:#fff; font-size:16px; margin-bottom:15px;">帐号绑定</a></div>
            </c:when>
            <c:otherwise>
                <div class="col-xs-12 w_text">您已经绑定${webName}帐号</div>
                <div class="col-xs-12 w_text" style="color:#333;">${loginUser.bindLoginId}</div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
