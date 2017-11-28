<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/1/6
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="4" var="limit"/>
<c:set var="commentProxyPage" value="${sdk:findProductComments(param.productId,limit)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>

<html>
<head>
    <meta charset="utf-8">
    <title>商品评论-易淘药健康网</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/base.css" type="text/css"/>
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/city.css" type="text/css"/>

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script>
        var webPath={
            webRoot:"${webRoot}", //当前路径
            productId:"${param.productId}",
            limit:"${param.limit}"
        }
    </script>
    <script src="${webRoot}/template/bdw/wap/citySend/statics/js/allComment.js" type="text/javascript"></script>

</head>
<body>
<div class="main m-good-detail">
    <div class="evaluation" style="margin-top: 0;">
        <dl>
            <dt id="commentTop" style="text-align: center;padding-left: 0;"><span style="font-size: 1.4rem">商品评价</span>(${commentProxyPage.totalCount})</dt>
            <div id="commentList">
                <c:choose>
                    <c:when test="${not empty commentProxyResult}">
                        <c:forEach items="${commentProxyResult}" var="commentProxy" varStatus="s">
                            <dd class="item">
                                <div class="from">
                                    <c:set value="${fn:substring(commentProxy.loginId, 0,3)}" var="mobileHeader"/><%-- 用户名前3位 --%>
                                    <c:set value="${fn:substring(commentProxy.loginId, 7,fn:length(commentProxy.loginId))}" var="mobileStern"/><%-- 用户名后4位 --%>
                                    <span class="fl">${mobileHeader}****${mobileStern}</span>
                                    <span class="fr">${commentProxy.createTimeString}</span>
                                </div>
                                <div class="stars">
                                    <c:forEach begin="1" end="${commentProxy.score}">
                                        <span class="active"></span>
                                    </c:forEach>
                                    <c:if test="${commentProxy.score < 5}">
                                        <c:forEach begin="${commentProxy.score}" end="4">
                                            <span></span>
                                        </c:forEach>
                                    </c:if>
                                </div>
                                <p class="cont" style="word-wrap: break-word;">${commentProxy.content}</p>
                                <c:if test="${not empty commentProxy.commentReplys}">
                                    <c:forEach items="${commentProxy.commentReplys}" var="reply">
                                        <div class="reply"
                                             style="line-height: 2rem; border: 1px solid #666; font-size: 1.2rem; color: #333;">
                                            <p>店家回复：${reply.commentCont}</p>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </dd>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="padding-top:1.8rem; text-align: center; font-size: 1.5rem; color:#666; ">
                            暂无评价
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </dl>
    </div>
</div>

<nav id="page-nav">
    <a href="${webRoot}/wap/citySend/loadAllComment.ac?productId=${param.productId}&page=2&limit=${limit}"></a>
</nav>
<script src="${webRoot}/template/bdw/wap/citySend/statics/js/base.js" type="text/javascript"></script>

</body>
</html>
