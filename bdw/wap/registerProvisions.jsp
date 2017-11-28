<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE HTML>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>${webName}用户服务协议</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/login.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
</head>
<body>
<div class="m-top">
    <a class="back" href="javascript:void(0);" onclick="history.go(-1);"></a>
    <div class="toggle-box">${webName}用户服务协议</div>
</div>

<div class="panel panel-default" style="overflow-y: scroll;">
    <c:set value="${sdk:getArticleCategoryById(7)}" var="articleCategory"/>
    <c:if test="${not empty articleCategory}">
        <c:set value="${articleCategory.userAgreement}" var="userAgreement"/>
    </c:if>
    <c:if test="${not empty userAgreement}">
        <c:set var="article" value="${userAgreement.top}"/>
    </c:if>
    <c:choose>
        <c:when test="${not empty article}">
            <p style=" word-wrap: break-word;">${article.articleCont}</p>
        </c:when>
        <c:otherwise>
            <p style=" word-wrap: break-word;">${sdk:getSysParamValue('register_provisions')}</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>

