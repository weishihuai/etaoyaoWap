<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--商品咨询--%>
<c:set var="buyConsultProxys" value="${sdk:findBuyConsultByProductId(param.productId,10)}"/>

<!DOCTYPE html>
<html>
    <head lang="en">
        <meta charset="utf-8">
        <title>售前咨询-${webName}</title>
        <meta content="yes" name="apple-mobile-web-app-capable">
        <meta content="yes" name="apple-touch-fullscreen">
        <meta content="telephone=no,email=no" name="format-detection">

        <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
        <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
        <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
        <link href="${webRoot}/template/bdw/wap/statics/css/pre-sales.css" type="text/css" rel="stylesheet" />
    </head>
    <body>
        <div class="m-top">
            <a href="javascript:history.go(-1);" class="back"></a>
            <span>售前咨询</span>
        </div>
        <div class="pre-main" style="margin-top: 100px">
            <c:forEach items="${buyConsultProxys.result}" var="buyConsultProxy" varStatus="result">
                <div class="item">
                    <div class="mt">
                        <div class="pic">
                            <c:choose>
                                <c:when test="${empty buyConsultProxy.userIconUrl}">
                                    <img src="${webRoot}/template/bdw/wap/statics/images/touxiang_40x40.png" alt="">
                                </c:when>
                                <c:otherwise>
                                    <img src="${buyConsultProxy.userIconUrl}" alt="">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <c:set value="${fn:substring(buyConsultProxy.userName, 0,1)}" var="preUserName"/><%-- 用户名前1位 --%>
                        <c:set value="${fn:substring(buyConsultProxy.userName, (fn:length(buyConsultProxy.userName) - 1),fn:length(buyConsultProxy.userName))}" var="sufUserName"/><%-- 用户名后1位 --%>
                        <span>${preUserName}***${sufUserName}</span>
                        <em><c:if test="${not empty buyConsultProxy.consultTimeString}">${buyConsultProxy.consultTimeString}</c:if></em>
                    </div>
                    <div class="question">
                        <span>询</span>
                        <p>${buyConsultProxy.consultCont}</p>
                    </div>
                    <c:if test="${not empty buyConsultProxy.consultReplyCont}">
                        <div class="answer">
                            <span>答</span>
                            <p>${buyConsultProxy.consultReplyCont}</p>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
        <div class="m-bot"><a href="${webRoot}/wap/presale/preSaleAdd.ac?productId=${param.productId}"><span>我要咨询</span></a></div>
    </body>

    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
</html>
